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
        ?>
<main class="container shop shop-checkout shop-checkout--empty">
    <div class="shop-checkout__empty">
        <div class="shop-checkout__empty-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                <path d="M1 1h4l2.7 13.4a2 2 0 0 0 2 1.6h9.7a2 2 0 0 0 2-1.6L23 6H6"/>
            </svg>
        </div>
        <h1>Tu carrito está vacío</h1>
        <p>Todavía no agregaste productos. Volvé a la tienda y empezamos de cero.</p>
        <a href="/catalogo" class="btn shop-checkout__empty-cta">Ir al catálogo</a>
    </div>
</main>
        <?php
        layoutEnd();
        return;
    }

    $methods = paymentsAvailable();
    $f = function (string $k, string $default = '') use ($formData): string {
        return htmlspecialchars((string) ($formData[$k] ?? $default));
    };
    $selectedMethod = (string) ($formData['payment_method'] ?? array_key_first($methods) ?? '');
    $itemCount = 0;
    foreach ($items as $it) { $itemCount += (int) $it['qty']; }

    layoutStart(['title' => 'Finalizar compra', 'canonical' => '/checkout']);
    ?>
<main class="container shop shop-checkout">
    <header class="shop-checkout__header">
        <a href="/carrito" class="shop-checkout__crumb">
            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="15 18 9 12 15 6"/></svg>
            Volver al carrito
        </a>
        <h1>Finalizar compra</h1>
        <ol class="shop-checkout__steps" aria-label="Pasos del checkout">
            <li class="shop-checkout__step is-active"><span>1</span> Contacto</li>
            <li class="shop-checkout__step is-active"><span>2</span> Envío</li>
            <li class="shop-checkout__step is-active"><span>3</span> Pago</li>
        </ol>
    </header>

    <?php if ($error): ?>
        <div class="shop-checkout__alert shop-checkout__alert--error" role="alert">
            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <span><?= htmlspecialchars($error) ?></span>
        </div>
    <?php endif; ?>

    <?php if (!$methods): ?>
        <div class="shop-checkout__alert shop-checkout__alert--warn" role="alert">
            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
            <span>No hay métodos de pago disponibles. Pedí al administrador del sitio que active al menos uno desde <strong>Pagos</strong>.</span>
        </div>
    <?php endif; ?>

    <form method="post" action="/checkout" class="shop-checkout__form">
        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
        <input type="hidden" name="action" value="place_order">

        <div class="shop-checkout__grid">
            <div class="shop-checkout__col">
                <section class="shop-checkout__card">
                    <header class="shop-checkout__card-head">
                        <span class="shop-checkout__num">1</span>
                        <div>
                            <h2 class="shop-checkout__card-title">Datos de contacto</h2>
                            <p class="shop-checkout__card-sub">Para enviarte la confirmación del pedido</p>
                        </div>
                    </header>
                    <div class="shop-checkout__fields">
                        <div class="shop-checkout__row2">
                            <div class="shop-checkout__field">
                                <label for="co-firstname">Nombre <span aria-hidden="true">*</span></label>
                                <input id="co-firstname" type="text" name="first_name" required autocomplete="given-name" value="<?= $f('first_name') ?>">
                            </div>
                            <div class="shop-checkout__field">
                                <label for="co-lastname">Apellido <span aria-hidden="true">*</span></label>
                                <input id="co-lastname" type="text" name="last_name" required autocomplete="family-name" value="<?= $f('last_name') ?>">
                            </div>
                        </div>
                        <div class="shop-checkout__field">
                            <label for="co-email">Email <span aria-hidden="true">*</span></label>
                            <input id="co-email" type="email" name="email" required autocomplete="email" inputmode="email" value="<?= $f('email') ?>" placeholder="tu@email.com">
                        </div>
                        <div class="shop-checkout__field">
                            <label for="co-phone">Teléfono <span aria-hidden="true">*</span></label>
                            <input id="co-phone" type="tel" name="phone" required autocomplete="tel" inputmode="tel" value="<?= $f('phone') ?>" placeholder="+56 9 1234 5678">
                            <small class="shop-checkout__field-hint">Lo usamos para coordinar la entrega.</small>
                        </div>
                    </div>
                </section>

                <section class="shop-checkout__card">
                    <header class="shop-checkout__card-head">
                        <span class="shop-checkout__num">2</span>
                        <div>
                            <h2 class="shop-checkout__card-title">Dirección de envío</h2>
                            <p class="shop-checkout__card-sub">Coordinamos el despacho por separado.</p>
                        </div>
                    </header>
                    <div class="shop-checkout__fields">
                        <div class="shop-checkout__field">
                            <label for="co-addr1">Dirección <span aria-hidden="true">*</span></label>
                            <input id="co-addr1" type="text" name="address_line1" required autocomplete="address-line1" value="<?= $f('address_line1') ?>" placeholder="Calle y número">
                        </div>
                        <div class="shop-checkout__field">
                            <label for="co-addr2">Departamento, piso, referencia</label>
                            <input id="co-addr2" type="text" name="address_line2" autocomplete="address-line2" value="<?= $f('address_line2') ?>" placeholder="Opcional">
                        </div>
                        <div class="shop-checkout__row2">
                            <div class="shop-checkout__field">
                                <label for="co-city">Ciudad / comuna <span aria-hidden="true">*</span></label>
                                <input id="co-city" type="text" name="city" required autocomplete="address-level2" value="<?= $f('city') ?>">
                            </div>
                            <div class="shop-checkout__field">
                                <label for="co-region">Región</label>
                                <input id="co-region" type="text" name="region" autocomplete="address-level1" value="<?= $f('region') ?>">
                            </div>
                        </div>
                        <div class="shop-checkout__row2">
                            <div class="shop-checkout__field">
                                <label for="co-zip">Código postal</label>
                                <input id="co-zip" type="text" name="postal_code" autocomplete="postal-code" inputmode="numeric" value="<?= $f('postal_code') ?>">
                            </div>
                            <div class="shop-checkout__field">
                                <label for="co-country">País</label>
                                <input id="co-country" type="text" name="country" autocomplete="country" value="<?= $f('country', (string) getSetting('store_country', 'CL')) ?>" maxlength="2">
                            </div>
                        </div>
                        <div class="shop-checkout__field">
                            <label for="co-note">Notas para el pedido <small>(opcional)</small></label>
                            <textarea id="co-note" name="customer_note" rows="2" placeholder="Indicaciones para la entrega, datos extra…"><?= $f('customer_note') ?></textarea>
                        </div>
                    </div>
                </section>

                <section class="shop-checkout__card">
                    <header class="shop-checkout__card-head">
                        <span class="shop-checkout__num">3</span>
                        <div>
                            <h2 class="shop-checkout__card-title">Método de pago</h2>
                            <p class="shop-checkout__card-sub">Elegí cómo querés pagar tu pedido.</p>
                        </div>
                    </header>
                    <?php if ($methods): ?>
                        <div class="shop-checkout__methods" role="radiogroup" aria-label="Método de pago">
                            <?php foreach ($methods as $key => $m):
                                $id = 'pm-' . $key;
                                $checked = $selectedMethod === $key;
                            ?>
                                <label class="shop-checkout__method<?= $checked ? ' is-selected' : '' ?>" for="<?= $id ?>">
                                    <input type="radio" id="<?= $id ?>" name="payment_method" value="<?= htmlspecialchars($key) ?>" <?= $checked ? 'checked' : '' ?> required>
                                    <span class="shop-checkout__method-dot" aria-hidden="true"></span>
                                    <span class="shop-checkout__method-body">
                                        <strong><?= htmlspecialchars($m['label']) ?></strong>
                                        <small><?= htmlspecialchars($m['description']) ?></small>
                                    </span>
                                </label>
                            <?php endforeach; ?>
                        </div>
                    <?php else: ?>
                        <p class="shop-checkout__methods-empty">Sin métodos de pago activos.</p>
                    <?php endif; ?>
                </section>
            </div>

            <aside class="shop-checkout__sidebar">
                <section class="shop-checkout__summary">
                    <header class="shop-checkout__summary-head">
                        <h2 class="shop-checkout__card-title">Tu pedido</h2>
                        <span class="shop-checkout__summary-count"><?= (int) $itemCount ?> <?= $itemCount === 1 ? 'producto' : 'productos' ?></span>
                    </header>
                    <ul class="shop-checkout__items">
                        <?php foreach ($items as $it): ?>
                            <li class="shop-checkout__item">
                                <span class="shop-checkout__item-qty"><?= (int) $it['qty'] ?></span>
                                <span class="shop-checkout__item-name">
                                    <?= htmlspecialchars($it['name']) ?>
                                    <?php if ($it['variation_label']): ?>
                                        <small><?= htmlspecialchars($it['variation_label']) ?></small>
                                    <?php endif; ?>
                                </span>
                                <span class="shop-checkout__item-total"><?= shopFormatPrice($it['line_total']) ?></span>
                            </li>
                        <?php endforeach; ?>
                    </ul>
                    <dl class="shop-checkout__totals">
                        <div class="shop-checkout__totline">
                            <dt>Subtotal</dt>
                            <dd><?= shopFormatPrice($totals['subtotal']) ?></dd>
                        </div>
                        <div class="shop-checkout__totline">
                            <dt>Envío</dt>
                            <dd class="shop-checkout__muted">A coordinar</dd>
                        </div>
                        <div class="shop-checkout__totline shop-checkout__totline--big">
                            <dt>Total a pagar</dt>
                            <dd><?= shopFormatPrice($totals['subtotal']) ?></dd>
                        </div>
                    </dl>
                    <p class="shop-checkout__hint">Impuestos incluidos. El costo de envío se coordina por separado.</p>
                    <button type="submit" class="btn shop-checkout__submit" <?= $methods ? '' : 'disabled' ?>>
                        <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                        Confirmar compra
                    </button>
                    <ul class="shop-checkout__trust">
                        <li>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                            Compra protegida
                        </li>
                        <li>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="1" y="3" width="15" height="13"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
                            Despachos en 24-48 hs
                        </li>
                        <li>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><path d="m9 12 2 2 4-4"/></svg>
                            Datos encriptados
                        </li>
                    </ul>
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
           . '<p><a href="/catalogo" class="btn">Volver al catálogo</a></p></main>';
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

    $statusClass = $isPaid ? 'is-paid' : ($isFailed ? 'is-failed' : 'is-pending');
    layoutStart(['title' => 'Orden ' . $orderNumber, 'canonical' => '/orden/' . $orderNumber]);
    ?>
<main class="container shop shop-order <?= $statusClass ?>">
    <div class="shop-order__hero">
        <div class="shop-order__hero-icon" aria-hidden="true">
            <?php if ($isPaid): ?>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
            <?php elseif ($isFailed): ?>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
            <?php else: ?>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
            <?php endif; ?>
        </div>
        <h1>
            <?php if ($isPaid): ?>¡Gracias por tu compra!
            <?php elseif ($isFailed): ?>Hubo un problema con el pago
            <?php else: ?>Orden creada
            <?php endif; ?>
        </h1>
        <p class="shop-order__num">Número de orden: <strong><?= htmlspecialchars($order['order_number']) ?></strong></p>
    </div>

    <?php if ($isPaid): ?>
        <div class="shop-checkout__alert shop-checkout__alert--ok">
            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="20 6 9 17 4 12"/></svg>
            <span>Tu pago fue confirmado. Te enviamos un email con el detalle.</span>
        </div>
    <?php elseif ($isFailed): ?>
        <div class="shop-checkout__alert shop-checkout__alert--error">
            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <span>El pago no se pudo completar. Podés volver a intentarlo desde el carrito.</span>
        </div>
    <?php elseif ($method === 'flow'): ?>
        <div class="shop-checkout__alert shop-checkout__alert--info">
            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
            <span>Estamos esperando la confirmación de Flow. Si ya completaste el pago, actualizá esta página en unos segundos.</span>
        </div>
    <?php elseif ($instructions !== ''): ?>
        <section class="shop-checkout__card shop-order__instructions">
            <header class="shop-checkout__card-head">
                <span class="shop-checkout__num">i</span>
                <div>
                    <h2 class="shop-checkout__card-title">Instrucciones de pago — <?= htmlspecialchars($methodLabel) ?></h2>
                    <p class="shop-checkout__card-sub">Indicá el número <strong><?= htmlspecialchars($order['order_number']) ?></strong> al momento de pagar.</p>
                </div>
            </header>
            <pre><?= htmlspecialchars($instructions) ?></pre>
        </section>
    <?php else: ?>
        <div class="shop-checkout__alert shop-checkout__alert--info">
            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
            <span>Tu orden quedó registrada como pendiente. Nos pondremos en contacto para coordinar el pago.</span>
        </div>
    <?php endif; ?>

    <section class="shop-checkout__card">
        <header class="shop-checkout__card-head">
            <span class="shop-checkout__num"><svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg></span>
            <div>
                <h2 class="shop-checkout__card-title">Detalle del pedido</h2>
                <p class="shop-checkout__card-sub"><?= count($items) ?> <?= count($items) === 1 ? 'producto' : 'productos' ?> · Total <strong><?= shopFormatPrice($order['grand_total']) ?></strong></p>
            </div>
        </header>
        <ul class="shop-order__items">
            <?php foreach ($items as $i): ?>
                <li class="shop-order__item">
                    <span class="shop-order__item-qty"><?= (int) $i['qty'] ?></span>
                    <span class="shop-order__item-name">
                        <?= htmlspecialchars($i['name']) ?>
                        <?php if ($i['sku']): ?><small>SKU: <?= htmlspecialchars($i['sku']) ?></small><?php endif; ?>
                    </span>
                    <span class="shop-order__item-total"><?= shopFormatPrice($i['line_total']) ?></span>
                </li>
            <?php endforeach; ?>
        </ul>
        <div class="shop-order__total">
            <span>Total</span>
            <strong><?= shopFormatPrice($order['grand_total']) ?></strong>
        </div>
    </section>

    <div class="shop-order__actions">
        <a href="/catalogo" class="btn">Seguir comprando</a>
    </div>
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
