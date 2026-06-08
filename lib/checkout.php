<?php
/**
 * Checkout: render del formulario, validación, creación de la orden y
 * derivación al método de pago elegido.
 *
 * Una orden se crea SIEMPRE en la transacción (`status=pending`,
 * `payment_status=unpaid`) antes de redirigir al gateway. Si el pago no
 * concluye, la orden queda pending y puede recuperarse desde el admin o
 * abandonarse (cron futuro). Para métodos offline (transferencia / contra
 * entrega) se cierra el carrito y se muestra la pantalla de instrucciones.
 *
 * Flujo de páginas:
 *   GET  /checkout                 → checkoutRenderForm()
 *   POST /checkout                 → checkoutHandlePost() → redirige
 *   GET  /orden/{order_number}     → checkoutRenderConfirmation()
 *   GET  /checkout/flow/return     → procesa el retorno de Flow y redirige a /orden/{n}
 *   POST /checkout/flow/notify     → webhook server-to-server (idempotente)
 */

/** UUID v4 para event_id (Meta Pixel dedup) y otros usos. */
function checkoutUuidV4(): string {
    $b = random_bytes(16);
    $b[6] = chr((ord($b[6]) & 0x0f) | 0x40);
    $b[8] = chr((ord($b[8]) & 0x3f) | 0x80);
    return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($b), 4));
}

/** Número de orden legible y único: PREFIX + ddMMYY + counter del día. */
function checkoutGenerateOrderNumber(): string {
    $prefix = (string) getSetting('order_number_prefix', 'ORD-');
    $date   = date('ymd');
    $st     = getDB()->prepare("SELECT COUNT(*) FROM orders WHERE DATE(created_at) = CURDATE()");
    $st->execute();
    $n      = (int) $st->fetchColumn() + 1;
    return sprintf('%s%s-%04d', $prefix, $date, $n);
}

/* ===================== Router-level handlers ===================== */

/** True si manejó la URL (renderizó / redirigió). */
function checkoutRoute(string $path): bool {
    if ($path === 'checkout') {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            checkoutHandlePost();
            return true;
        }
        checkoutRenderForm();
        return true;
    }
    if ($path === 'checkout/flow/return') {
        checkoutFlowReturn();
        return true;
    }
    if ($path === 'checkout/flow/notify') {
        checkoutFlowNotify();
        return true;
    }
    // /orden/{order_number}
    if (preg_match('#^orden/([A-Za-z0-9\-]+)$#', $path, $m)) {
        checkoutRenderConfirmation($m[1]);
        return true;
    }
    return false;
}

/* ===================== Render ===================== */

function checkoutRenderForm(?array $formData = null, ?string $error = null): void {
    $items   = cartItems();
    $totals  = cartTotals();
    if (!$items) {
        layoutStart(['title' => 'Finalizar compra', 'canonical' => '/checkout']);
        echo '<main class="container shop shop-checkout"><h1>Finalizar compra</h1>'
           . '<p class="shop-cart__empty">Tu carrito está vacío. Volvé a la tienda para elegir productos.</p>'
           . '<p><a href="/tienda" class="btn">Ir a la tienda</a></p></main>';
        layoutEnd();
        return;
    }

    $methods = paymentsAvailable();
    $f = function (string $k, string $default = '') use ($formData): string {
        return htmlspecialchars((string) ($formData[$k] ?? $default));
    };
    $selectedMethod = (string) ($formData['payment_method'] ?? array_key_first($methods) ?? '');

    layoutStart(['title' => 'Finalizar compra', 'canonical' => '/checkout']);
    ?>
<main class="container shop shop-checkout">
    <h1>Finalizar compra</h1>

    <?php if ($error): ?>
        <p class="alert alert--error shop-cart__alert"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <?php if (!$methods): ?>
        <div class="alert alert--error shop-cart__alert">
            No hay métodos de pago disponibles. Pedí al administrador del sitio que active al menos uno desde <strong>Pagos</strong>.
        </div>
    <?php endif; ?>

    <form method="post" action="/checkout" class="shop-checkout__form">
        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
        <input type="hidden" name="action" value="place_order">

        <div class="shop-checkout__grid">
            <div class="shop-checkout__col">
                <section class="card">
                    <h3 class="card__title">Datos de contacto</h3>
                    <div class="shop-checkout__row2">
                        <p class="form__field"><label>Nombre *
                            <input type="text" name="first_name" required value="<?= $f('first_name') ?>">
                        </label></p>
                        <p class="form__field"><label>Apellido *
                            <input type="text" name="last_name" required value="<?= $f('last_name') ?>">
                        </label></p>
                    </div>
                    <p class="form__field"><label>Email *
                        <input type="email" name="email" required value="<?= $f('email') ?>">
                    </label></p>
                    <p class="form__field" style="margin:0;"><label>Teléfono *
                        <input type="tel" name="phone" required value="<?= $f('phone') ?>" placeholder="+56 9 1234 5678">
                    </label></p>
                </section>

                <section class="card">
                    <h3 class="card__title">Dirección de envío</h3>
                    <p class="form__field"><label>Dirección *
                        <input type="text" name="address_line1" required value="<?= $f('address_line1') ?>" placeholder="Calle y número">
                    </label></p>
                    <p class="form__field"><label>Departamento, piso, referencia
                        <input type="text" name="address_line2" value="<?= $f('address_line2') ?>">
                    </label></p>
                    <div class="shop-checkout__row2">
                        <p class="form__field"><label>Ciudad / comuna *
                            <input type="text" name="city" required value="<?= $f('city') ?>">
                        </label></p>
                        <p class="form__field"><label>Región
                            <input type="text" name="region" value="<?= $f('region') ?>">
                        </label></p>
                    </div>
                    <div class="shop-checkout__row2">
                        <p class="form__field"><label>Código postal
                            <input type="text" name="postal_code" value="<?= $f('postal_code') ?>">
                        </label></p>
                        <p class="form__field"><label>País
                            <input type="text" name="country" value="<?= $f('country', (string) getSetting('store_country', 'CL')) ?>" maxlength="2">
                        </label></p>
                    </div>
                    <p class="form__field" style="margin:0;"><label>Notas para el pedido (opcional)
                        <textarea name="customer_note" rows="2" placeholder="Indicaciones para la entrega, datos extra…"><?= $f('customer_note') ?></textarea>
                    </label></p>
                </section>

                <section class="card">
                    <h3 class="card__title">Método de pago</h3>
                    <?php if ($methods): ?>
                        <div class="shop-checkout__methods">
                            <?php foreach ($methods as $key => $m):
                                $id = 'pm-' . $key;
                                $checked = $selectedMethod === $key;
                            ?>
                                <label class="shop-checkout__method<?= $checked ? ' is-selected' : '' ?>" for="<?= $id ?>">
                                    <input type="radio" id="<?= $id ?>" name="payment_method" value="<?= htmlspecialchars($key) ?>" <?= $checked ? 'checked' : '' ?> required>
                                    <span class="shop-checkout__method-body">
                                        <strong><?= htmlspecialchars($m['label']) ?></strong>
                                        <small><?= htmlspecialchars($m['description']) ?></small>
                                    </span>
                                </label>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>
                </section>
            </div>

            <aside class="shop-checkout__sidebar">
                <section class="card">
                    <h3 class="card__title">Tu pedido</h3>
                    <ul class="shop-checkout__items">
                        <?php foreach ($items as $it): ?>
                            <li class="shop-checkout__item">
                                <span class="shop-checkout__item-name">
                                    <?= htmlspecialchars($it['name']) ?>
                                    <?php if ($it['variation_label']): ?>
                                        <small> · <?= htmlspecialchars($it['variation_label']) ?></small>
                                    <?php endif; ?>
                                    <small> × <?= (int) $it['qty'] ?></small>
                                </span>
                                <span class="shop-checkout__item-total"><?= shopFormatPrice($it['line_total']) ?></span>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                    <div class="shop-checkout__totline">
                        <span>Subtotal</span>
                        <strong><?= shopFormatPrice($totals['subtotal']) ?></strong>
                    </div>
                    <div class="shop-checkout__totline shop-checkout__totline--big">
                        <span>Total a pagar</span>
                        <strong><?= shopFormatPrice($totals['subtotal']) ?></strong>
                    </div>
                    <p class="shop-checkout__hint">Los impuestos están incluidos. El costo de envío se coordina por separado.</p>
                    <button type="submit" class="btn shop-checkout__submit" <?= $methods ? '' : 'disabled' ?>>Confirmar compra</button>
                    <a href="/carrito" class="shop-checkout__back">← Volver al carrito</a>
                </section>
            </aside>
        </div>
    </form>
</main>
<script>
(function(){
    document.querySelectorAll('.shop-checkout__method input[type="radio"]').forEach(function(r){
        r.addEventListener('change', function(){
            document.querySelectorAll('.shop-checkout__method').forEach(function(l){ l.classList.remove('is-selected'); });
            r.closest('.shop-checkout__method').classList.add('is-selected');
        });
    });
})();
</script>
    <?php
    layoutEnd();
}

function checkoutRenderConfirmation(string $orderNumber): void {
    $st = getDB()->prepare('SELECT * FROM orders WHERE order_number = ?');
    $st->execute([$orderNumber]);
    $order = $st->fetch() ?: null;
    if (!$order) {
        http_response_code(404);
        layoutStart(['title' => 'Orden no encontrada']);
        echo '<main class="container shop"><h1>Orden no encontrada</h1>'
           . '<p>No pudimos encontrar esa orden. Si llegaste acá desde un email, revisá el enlace.</p>'
           . '<p><a href="/tienda" class="btn">Volver a la tienda</a></p></main>';
        layoutEnd();
        return;
    }

    $it = getDB()->prepare('SELECT * FROM order_items WHERE order_id = ? ORDER BY id');
    $it->execute([(int) $order['id']]);
    $items = $it->fetchAll();
    $method = (string) $order['payment_method'];
    $instructions = '';
    if ($method === 'bank_transfer') {
        $instructions = (string) getSetting('pay_bank_transfer_instructions', '');
    } elseif ($method === 'cod') {
        $instructions = (string) getSetting('pay_cod_instructions', '');
    }
    $methodLabel = paymentsAllMethods()[$method]['label'] ?? $method;
    $isPaid = ($order['payment_status'] ?? '') === 'paid';
    $isFailed = in_array($order['payment_status'] ?? '', ['failed'], true);

    layoutStart(['title' => 'Orden ' . $orderNumber, 'canonical' => '/orden/' . $orderNumber]);
    ?>
<main class="container shop shop-order">
    <h1>
        <?php if ($isPaid): ?>¡Gracias por tu compra!
        <?php elseif ($isFailed): ?>Hubo un problema con el pago
        <?php else: ?>Orden creada
        <?php endif; ?>
    </h1>
    <p class="shop-order__num">Número: <strong><?= htmlspecialchars($order['order_number']) ?></strong></p>

    <?php if ($isPaid): ?>
        <p class="alert alert--ok">Tu pago fue confirmado. Te enviamos un email con el detalle.</p>
    <?php elseif ($isFailed): ?>
        <p class="alert alert--error">El pago no se pudo completar. Podés volver a intentarlo desde el carrito.</p>
    <?php elseif ($method === 'flow'): ?>
        <p class="alert">Estamos esperando la confirmación de Flow. Si ya completaste el pago, podés actualizar esta página en unos segundos.</p>
    <?php elseif ($instructions !== ''): ?>
        <div class="card shop-order__instructions">
            <h3 class="card__title">Instrucciones para completar el pago — <?= htmlspecialchars($methodLabel) ?></h3>
            <pre><?= htmlspecialchars($instructions) ?></pre>
            <p class="text-muted" style="margin:.5rem 0 0;font-size:.9rem;">Indicá el número de orden <strong><?= htmlspecialchars($order['order_number']) ?></strong> al momento de pagar.</p>
        </div>
    <?php else: ?>
        <p class="alert">Tu orden quedó registrada como pendiente. Nos pondremos en contacto para coordinar el pago.</p>
    <?php endif; ?>

    <section class="card">
        <h3 class="card__title">Detalle</h3>
        <table class="shop-cart__table">
            <thead>
                <tr><th>Producto</th><th class="shop-cart__th-num">Cant.</th><th class="shop-cart__th-num">Subtotal</th></tr>
            </thead>
            <tbody>
                <?php foreach ($items as $i): ?>
                    <tr>
                        <td><?= htmlspecialchars($i['name']) ?><?php if ($i['sku']): ?> <small class="text-muted">(<?= htmlspecialchars($i['sku']) ?>)</small><?php endif; ?></td>
                        <td class="shop-cart__price"><?= (int) $i['qty'] ?></td>
                        <td class="shop-cart__line"><?= shopFormatPrice($i['line_total']) ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
            <tfoot>
                <tr><td colspan="2" class="shop-cart__totlbl">Total</td><td class="shop-cart__tot"><?= shopFormatPrice($order['grand_total']) ?></td></tr>
            </tfoot>
        </table>
    </section>

    <p style="margin-top:1.4rem;"><a href="/tienda" class="btn btn--ghost">← Seguir comprando</a></p>
</main>
    <?php
    layoutEnd();
}

/* ===================== POST handler ===================== */

function checkoutHandlePost(): void {
    csrfCheck();
    $action = (string) ($_POST['action'] ?? '');
    if ($action !== 'place_order') {
        redirect('/checkout');
    }

    $items = cartItems();
    if (!$items) {
        redirect('/carrito');
    }
    $totals = cartTotals();

    // Validación mínima.
    $data = [
        'first_name'    => trim((string) ($_POST['first_name']    ?? '')),
        'last_name'     => trim((string) ($_POST['last_name']     ?? '')),
        'email'         => trim((string) ($_POST['email']         ?? '')),
        'phone'         => trim((string) ($_POST['phone']         ?? '')),
        'address_line1' => trim((string) ($_POST['address_line1'] ?? '')),
        'address_line2' => trim((string) ($_POST['address_line2'] ?? '')),
        'city'          => trim((string) ($_POST['city']          ?? '')),
        'region'        => trim((string) ($_POST['region']        ?? '')),
        'postal_code'   => trim((string) ($_POST['postal_code']   ?? '')),
        'country'       => strtoupper(trim((string) ($_POST['country'] ?? 'CL'))) ?: 'CL',
        'customer_note' => trim((string) ($_POST['customer_note'] ?? '')),
        'payment_method'=> trim((string) ($_POST['payment_method'] ?? '')),
    ];

    $methods = paymentsAvailable();
    if (!isset($methods[$data['payment_method']])) {
        checkoutRenderForm($data, 'Elegí un método de pago válido.');
        return;
    }
    if ($data['first_name'] === '' || $data['last_name'] === '' || $data['phone'] === ''
        || $data['address_line1'] === '' || $data['city'] === ''
        || !filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
        checkoutRenderForm($data, 'Revisá los campos obligatorios (nombre, email, teléfono, dirección, ciudad).');
        return;
    }

    // Crear orden en transacción.
    $db = getDB();
    try {
        $db->beginTransaction();
        $order = checkoutCreateOrder($items, $totals, $data);
        $db->commit();
    } catch (Throwable $e) {
        if ($db->inTransaction()) $db->rollBack();
        error_log('checkout create error: ' . $e->getMessage());
        checkoutRenderForm($data, 'No se pudo crear la orden. Probá nuevamente.');
        return;
    }

    // Marca el carrito como convertido para no remarketear sobre algo ya comprado.
    $cart = cartCurrent(false);
    if ($cart) {
        $db->prepare("UPDATE carts SET status = 'converted' WHERE id = ?")->execute([(int) $cart['id']]);
        $db->prepare('DELETE FROM cart_items WHERE cart_id = ?')->execute([(int) $cart['id']]);
    }

    // Inicia el flujo del método elegido (online → gateway / offline → /orden/{n}).
    $start = paymentsStart($order, $data['payment_method']);
    if (!$start['ok']) {
        // La orden quedó en pending — el comprador puede reintentar contactándonos.
        redirect('/orden/' . rawurlencode($order['order_number']) . '?err=' . urlencode($start['error'] ?? ''));
    }
    redirect($start['redirect']);
}

function checkoutCreateOrder(array $items, array $totals, array $data): array {
    $db = getDB();
    $orderNumber = checkoutGenerateOrderNumber();
    $currency    = (string) shopCurrency()['code'];
    $eventId     = checkoutUuidV4();
    $billing = [
        'first_name' => $data['first_name'], 'last_name' => $data['last_name'],
        'email'      => $data['email'],     'phone'     => $data['phone'],
        'line1'      => $data['address_line1'], 'line2' => $data['address_line2'],
        'city'       => $data['city'],      'region'    => $data['region'],
        'postal_code'=> $data['postal_code'],'country'  => $data['country'],
    ];

    $db->prepare(
        'INSERT INTO orders
         (order_number, email, status, currency, subtotal, discount_total, shipping_total,
          tax_total, grand_total, billing_json, shipping_json, payment_method, payment_status,
          customer_note, event_id, ip_address, user_agent)
         VALUES
         (?, ?, "pending", ?, ?, 0, 0, 0, ?, ?, ?, ?, "unpaid", ?, ?, ?, ?)'
    )->execute([
        $orderNumber,
        $data['email'],
        $currency,
        (float) $totals['subtotal'],
        (float) $totals['subtotal'],
        json_encode($billing,  JSON_UNESCAPED_UNICODE),
        json_encode($billing,  JSON_UNESCAPED_UNICODE),
        $data['payment_method'],
        $data['customer_note'],
        $eventId,
        clientIp(),
        substr((string) ($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 500),
    ]);
    $orderId = (int) $db->lastInsertId();

    $itemSt = $db->prepare(
        'INSERT INTO order_items (order_id, product_id, variation_id, sku, name, qty, unit_price, line_total)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?)'
    );
    foreach ($items as $it) {
        // Buscamos el SKU si la variación lo tiene; si no, dejamos el SKU del producto si existe.
        $sku = null;
        if (!empty($it['variation_id'])) {
            $vSt = $db->prepare('SELECT sku FROM product_variations WHERE id = ?');
            $vSt->execute([(int) $it['variation_id']]);
            $sku = $vSt->fetchColumn() ?: null;
        } else {
            $pSt = $db->prepare('SELECT sku FROM products WHERE id = ?');
            $pSt->execute([(int) $it['product_id']]);
            $sku = $pSt->fetchColumn() ?: null;
        }
        $name = $it['name'] . ($it['variation_label'] ? ' (' . $it['variation_label'] . ')' : '');
        $itemSt->execute([
            $orderId, (int) $it['product_id'],
            !empty($it['variation_id']) ? (int) $it['variation_id'] : null,
            $sku ?: null,
            $name,
            (int) $it['qty'],
            (float) $it['unit_price'],
            (float) $it['line_total'],
        ]);
    }

    $db->prepare(
        'INSERT INTO order_status_history (order_id, status, note) VALUES (?, "pending", "Orden creada desde el checkout.")'
    )->execute([$orderId]);

    // Devuelve la fila completa.
    $st = $db->prepare('SELECT * FROM orders WHERE id = ?');
    $st->execute([$orderId]);
    return $st->fetch();
}

/* ===================== Flow webhook + return ===================== */

function checkoutFlowReturn(): void {
    $token = (string) ($_GET['token'] ?? $_POST['token'] ?? '');
    $res   = paymentsFlowConsumeToken($token);
    if (!$res['ok']) {
        layoutStart(['title' => 'Pago Flow']);
        echo '<main class="container shop"><h1>No pudimos confirmar el pago</h1>'
           . '<p>' . htmlspecialchars($res['error'] ?? 'Error desconocido.') . '</p>'
           . '<p><a href="/carrito" class="btn">Volver al carrito</a></p></main>';
        layoutEnd();
        return;
    }
    redirect('/orden/' . rawurlencode($res['order_number']));
}

function checkoutFlowNotify(): void {
    // Webhook server-to-server. Flow espera "OK" como respuesta.
    $token = (string) ($_POST['token'] ?? $_GET['token'] ?? '');
    paymentsFlowConsumeToken($token);
    header('Content-Type: text/plain');
    echo 'OK';
    exit;
}
