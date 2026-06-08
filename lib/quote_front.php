<?php
/**
 * Frontend público del módulo cotizaciones.
 *
 * Maneja:
 *   /cotizacion         → GET muestra el "carrito" de cotización + form de envío
 *                          POST: add_to_quote, update_qty, update_notes, remove,
 *                                clear, submit_quote.
 *
 * Patrón POST-Redirect-GET (igual que /carrito). Anti-spam con honeypot + timing
 * en el form de envío.
 *
 * El drawer (mini-cotización) se renderiza en cada página vía `layout.php` y
 * comparte CSS con `cart_drawer.php`.
 */

function quoteFrontRoute(string $path): bool {
    if ($path === 'cotizacion' || $path === 'cotizar') {
        quoteRenderPage();
        return true;
    }
    return false;
}

function quoteRenderPage(): void {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        quoteHandlePost();
        return;   // siempre redirige
    }

    $items  = quoteItems();
    $totals = quoteTotals();
    $set    = quoteSettings();
    $msg    = flashGet('quote_msg');
    $err    = flashGet('quote_err');

    layoutStart([
        'title'       => $set['submit_label'] ?: 'Solicitar cotización',
        'description' => $set['intro_text'],
        'canonical'   => '/cotizacion',
    ]);
    ?>
<main class="container shop shop-cart shop-quote">
    <h1><?= htmlspecialchars($set['submit_label'] ?: 'Mi cotización') ?></h1>

    <?php if ($set['intro_text']): ?>
        <p class="shop-quote__intro"><?= htmlspecialchars($set['intro_text']) ?></p>
    <?php endif; ?>

    <?php if ($msg): ?><p class="alert alert--ok shop-cart__alert"><?= htmlspecialchars($msg) ?></p><?php endif; ?>
    <?php if ($err): ?><p class="alert alert--error shop-cart__alert"><?= htmlspecialchars($err) ?></p><?php endif; ?>

    <?php if (!$items && !$set['intro_text']): ?>
        <p class="shop-cart__empty">Todavía no agregaste productos. Podés navegar el catálogo y agregar productos a tu cotización, o describir lo que necesitás en el formulario de abajo.</p>
    <?php elseif ($items): ?>
        <div class="shop-cart__wrap">
            <table class="shop-cart__table">
                <thead>
                    <tr>
                        <th colspan="2">Producto</th>
                        <?php if ($set['show_prices'] && $totals['subtotal_est'] !== null): ?>
                            <th class="shop-cart__th-num">Precio ref.</th>
                        <?php endif; ?>
                        <th class="shop-cart__th-num">Cantidad</th>
                        <?php if ($set['show_prices'] && $totals['subtotal_est'] !== null): ?>
                            <th class="shop-cart__th-num">Subtotal</th>
                        <?php endif; ?>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                <?php foreach ($items as $it): ?>
                    <tr>
                        <td class="shop-cart__thumb">
                            <?php if (!empty($it['thumb']) && !empty($it['product_slug'])): ?>
                                <a href="/producto/<?= htmlspecialchars($it['product_slug']) ?>">
                                    <img src="<?= htmlspecialchars($it['thumb']) ?>" alt="<?= htmlspecialchars($it['name_snapshot']) ?>" loading="lazy">
                                </a>
                            <?php else: ?>
                                <div class="shop-cart__noimg"></div>
                            <?php endif; ?>
                        </td>
                        <td class="shop-cart__name">
                            <?php if (!empty($it['product_slug'])): ?>
                                <a href="/producto/<?= htmlspecialchars($it['product_slug']) ?>"><?= htmlspecialchars($it['name_snapshot']) ?></a>
                            <?php else: ?>
                                <?= htmlspecialchars($it['name_snapshot']) ?>
                            <?php endif; ?>
                            <?php if (!empty($it['sku_snapshot'])): ?>
                                <p class="shop-cart__var">SKU: <?= htmlspecialchars($it['sku_snapshot']) ?></p>
                            <?php endif; ?>
                            <details class="shop-quote__notes">
                                <summary>Agregar nota / especificaciones</summary>
                                <form method="post" action="/cotizacion" class="shop-quote__notesform">
                                    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                    <input type="hidden" name="action" value="update_notes">
                                    <input type="hidden" name="item_id" value="<?= (int) $it['id'] ?>">
                                    <textarea name="notes" rows="2" placeholder="Ej: necesito el color verde, 24 unidades por caja..."><?= htmlspecialchars((string) ($it['item_notes'] ?? '')) ?></textarea>
                                    <button type="submit" class="btn btn--ghost">Guardar nota</button>
                                </form>
                                <?php if (!empty($it['item_notes'])): ?>
                                    <p class="shop-quote__notes-current"><strong>Nota:</strong> <?= htmlspecialchars($it['item_notes']) ?></p>
                                <?php endif; ?>
                            </details>
                        </td>
                        <?php if ($set['show_prices'] && $totals['subtotal_est'] !== null): ?>
                            <td class="shop-cart__price"><?= $it['unit_price_est'] !== null ? shopFormatPrice($it['unit_price_est']) : '<span class="text-muted">a cotizar</span>' ?></td>
                        <?php endif; ?>
                        <td class="shop-cart__qty">
                            <form method="post" action="/cotizacion" class="shop-cart__qtyform">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <input type="hidden" name="action" value="update_qty">
                                <input type="hidden" name="item_id" value="<?= (int) $it['id'] ?>">
                                <input type="number" name="qty" value="<?= (int) $it['qty'] ?>" min="1" class="shop-qty">
                                <button type="submit" class="shop-cart__update" aria-label="Actualizar cantidad" title="Actualizar">⟳</button>
                            </form>
                        </td>
                        <?php if ($set['show_prices'] && $totals['subtotal_est'] !== null): ?>
                            <td class="shop-cart__line">
                                <?= $it['line_total_est'] !== null ? shopFormatPrice($it['line_total_est']) : '<span class="text-muted">—</span>' ?>
                            </td>
                        <?php endif; ?>
                        <td class="shop-cart__rm">
                            <form method="post" action="/cotizacion" class="shop-cart__rmform" onsubmit="return confirm('¿Quitar este producto de la cotización?');">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="item_id" value="<?= (int) $it['id'] ?>">
                                <button type="submit" class="shop-cart__rmbtn" aria-label="Quitar de la cotización" title="Quitar">×</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
                <?php if ($set['show_prices'] && $totals['subtotal_est'] !== null): ?>
                    <tfoot>
                        <tr>
                            <td colspan="4" class="shop-cart__totlbl">Estimado (<?= (int) $totals['qty'] ?> u.)</td>
                            <td colspan="2" class="shop-cart__tot"><?= shopFormatPrice($totals['subtotal_est']) ?></td>
                        </tr>
                    </tfoot>
                <?php endif; ?>
            </table>
        </div>

        <div class="shop-cart__actions" style="margin-bottom:2rem;">
            <a href="/tienda" class="btn btn--ghost">← Seguir agregando</a>
            <form method="post" action="/cotizacion" class="shop-cart__clearform" onsubmit="return confirm('¿Vaciar la cotización?');" style="display:inline;">
                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                <input type="hidden" name="action" value="clear">
                <button type="submit" class="btn btn--ghost">Vaciar</button>
            </form>
        </div>
    <?php endif; ?>

    <section class="shop-quote__form">
        <h2>Tus datos de contacto</h2>
        <p class="text-muted" style="margin:0 0 1.2rem;">Te respondemos en 24-48 hs hábiles con la propuesta personalizada.</p>

        <form method="post" action="/cotizacion" class="lead-form">
            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
            <input type="hidden" name="action" value="submit_quote">
            <input type="hidden" name="form_started" value="<?= time() ?>">
            <input type="text" name="website" value="" style="display:none" tabindex="-1" autocomplete="off">

            <div class="lead-form__grid">
                <p class="lead-form__field"><label>Nombre <span class="lead-form__required">*</span><input name="name" required value="<?= htmlspecialchars((string) ($_POST['name'] ?? '')) ?>"></label></p>
                <p class="lead-form__field"><label>Email <span class="lead-form__required">*</span><input name="email" type="email" required value="<?= htmlspecialchars((string) ($_POST['email'] ?? '')) ?>"></label></p>
                <p class="lead-form__field"><label>Teléfono <span class="lead-form__required">*</span><input name="phone" type="tel" required value="<?= htmlspecialchars((string) ($_POST['phone'] ?? '')) ?>"></label></p>
                <p class="lead-form__field"><label>Empresa <?= $set['require_company'] ? '<span class="lead-form__required">*</span>' : '' ?><input name="company" <?= $set['require_company'] ? 'required' : '' ?> value="<?= htmlspecialchars((string) ($_POST['company'] ?? '')) ?>"></label></p>
                <p class="lead-form__field"><label>RUT / Identificación tributaria <?= $set['require_taxid'] ? '<span class="lead-form__required">*</span>' : '' ?><input name="taxid" <?= $set['require_taxid'] ? 'required' : '' ?> value="<?= htmlspecialchars((string) ($_POST['taxid'] ?? '')) ?>"></label></p>
                <p class="lead-form__field"><label>Cargo / Posición<input name="position" value="<?= htmlspecialchars((string) ($_POST['position'] ?? '')) ?>"></label></p>
                <p class="lead-form__field"><label>Ciudad<input name="city" value="<?= htmlspecialchars((string) ($_POST['city'] ?? '')) ?>"></label></p>
                <p class="lead-form__field"><label>Región<input name="region" value="<?= htmlspecialchars((string) ($_POST['region'] ?? '')) ?>"></label></p>
            </div>
            <p class="lead-form__field">
                <label>Mensaje / Detalle de lo que necesitás
                    <textarea name="message" rows="5" placeholder="Si no agregaste productos del catálogo, contanos qué buscás: tipo de packaging, cantidades, frecuencia de compra, etc."><?= htmlspecialchars((string) ($_POST['message'] ?? '')) ?></textarea>
                </label>
            </p>
            <p class="lead-form__submit">
                <button type="submit" class="btn"><?= htmlspecialchars($set['submit_label'] ?: 'Solicitar cotización') ?></button>
            </p>
        </form>
    </section>
</main>
    <?php
    layoutEnd();
}

function quoteHandlePost(): void {
    $action     = (string) ($_POST['action'] ?? '');
    $fromDrawer = !empty($_POST['from_drawer']);
    $rawReturn  = (string) ($_POST['return_to'] ?? '');
    $returnTo   = (preg_match('#^/[a-zA-Z0-9_\-/?=&%.,~]*$#', $rawReturn) && !str_contains($rawReturn, '//'))
        ? $rawReturn : '';

    if ($action === 'submit_quote') {
        // Anti-spam: honeypot + timing. Fake success (los bots no se enteran).
        $honeypotTripped = !empty($_POST['website']);
        $tooFast = !isset($_POST['form_started']) || (time() - (int) $_POST['form_started']) < 2;
        if ($honeypotTripped || $tooFast) {
            $thanks = (string) getSetting('quote_thanks_slug', 'gracias-cotizacion');
            redirect('/' . ltrim($thanks, '/'));
        }
        csrfCheck();
        $res = quoteSubmit($_POST);
        if (!$res['ok']) {
            flashSet('quote_err', $res['error']);
            redirect('/cotizacion');
        }
        $thanks = (string) getSetting('quote_thanks_slug', 'gracias-cotizacion');
        redirect('/' . ltrim($thanks, '/') . '?n=' . urlencode($res['number'] ?? ''));
    }

    csrfCheck();
    $resOk = true; $resErr = null;

    switch ($action) {
        case 'add_to_quote':
            $res = quoteAddItem(
                (int) ($_POST['product_id'] ?? 0),
                ($_POST['variation_id'] ?? '') !== '' ? (int) $_POST['variation_id'] : null,
                (int) ($_POST['qty'] ?? 1),
                isset($_POST['item_notes']) ? trim((string) $_POST['item_notes']) : null
            );
            $resOk = !empty($res['ok']);
            $resErr = $res['error'] ?? null;
            if (!$fromDrawer) {
                flashSet($resOk ? 'quote_msg' : 'quote_err',
                    $resOk ? 'Producto agregado a la cotización.' : ($resErr ?: 'No se pudo agregar.'));
                if ($resOk) {
                    flashSet('quote_just_added', '1');
                    if ($returnTo !== '') redirect($returnTo);
                }
            }
            break;
        case 'update_qty':
            quoteUpdateQty((int) ($_POST['item_id'] ?? 0), (int) ($_POST['qty'] ?? 0));
            if (!$fromDrawer && $returnTo !== '') {
                flashSet('quote_just_added', '1');
                redirect($returnTo);
            }
            break;
        case 'update_notes':
            quoteUpdateNotes((int) ($_POST['item_id'] ?? 0), (string) ($_POST['notes'] ?? ''));
            if (!$fromDrawer) flashSet('quote_msg', 'Nota guardada.');
            break;
        case 'remove':
            quoteRemoveItem((int) ($_POST['item_id'] ?? 0));
            if (!$fromDrawer && $returnTo !== '') {
                flashSet('quote_just_added', '1');
                redirect($returnTo);
            }
            break;
        case 'clear':
            quoteClear();
            if (!$fromDrawer) flashSet('quote_msg', 'Cotización vaciada.');
            break;
    }

    if ($fromDrawer) {
        ob_start();
        require __DIR__ . '/../components/quote_drawer.php';
        $full = (string) ob_get_clean();
        $inner = '';
        if (preg_match('#<aside[^>]*id="quote-drawer"[^>]*>(.*?)</aside>#s', $full, $m)) {
            $inner = $m[1];
        }
        header('Content-Type: application/json; charset=utf-8');
        header('Cache-Control: no-store');
        echo json_encode([
            'ok'        => $resOk,
            'error'     => $resErr,
            'innerHtml' => $inner,
            'count'     => quoteCount(),
        ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        exit;
    }

    redirect('/cotizacion');
}
