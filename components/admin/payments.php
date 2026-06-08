<?php
/**
 * Admin → Pagos.
 * Requiere: $settings (subset $PAYMENT_KEYS).
 *
 * Permite habilitar y configurar pasarelas digitales (Transbank Webpay Plus,
 * Flow y MercadoPago) y métodos offline (transferencia bancaria, contra
 * entrega). Cada pasarela se activa con un checkbox; los campos sensibles
 * (api keys, tokens) se guardan en `settings` y se enmascararán al lector
 * casual al renderizar el value (no hay "view source", el HTML los muestra
 * en claro porque el admin ya está autenticado).
 */
$g = fn(string $k) => htmlspecialchars((string) ($settings[$k] ?? ''));
$on = fn(string $k) => ($settings[$k] ?? '0') === '1';
?>
<header class="admin-header">
    <div>
        <h1>Pagos</h1>
        <div class="admin-header__sub">Configurá las pasarelas y métodos de pago que verá el cliente al finalizar la compra.</div>
    </div>
</header>

<?php if ($msg = flashGet('payments_success')): ?>
    <div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>
<?php if ($msg = flashGet('payments_error')): ?>
    <div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

<form method="post" autocomplete="off">
    <input type="hidden" name="action" value="save_payments">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">

    <div class="card">
        <h3 class="card__title">Flow</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.88rem;">
            Pasarela chilena con tarjetas, Webpay, transferencia y otros medios. Generá tu API Key y Secret Key en
            <a href="https://www.flow.cl/app/web/misDatos.php" target="_blank" rel="noopener">flow.cl → Mis datos</a>.
        </p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;">
                <input type="checkbox" name="p[pay_flow_enabled]" value="1" <?= $on('pay_flow_enabled') ? 'checked' : '' ?> style="width:auto;">
                <span>Habilitar Flow en el checkout</span>
            </label>
        </p>
        <p class="form__field"><label>Ambiente
            <select name="p[flow_environment]">
                <?php $env = $settings['flow_environment'] ?? 'sandbox'; ?>
                <option value="sandbox" <?= $env === 'sandbox' ? 'selected' : '' ?>>Sandbox (pruebas)</option>
                <option value="production" <?= $env === 'production' ? 'selected' : '' ?>>Producción</option>
            </select>
        </label></p>
        <p class="form__field"><label>API Key
            <input type="text" name="p[flow_api_key]" value="<?= $g('flow_api_key') ?>" placeholder="0123ABCD-…" autocomplete="off">
        </label></p>
        <p class="form__field" style="margin:0;"><label>Secret Key
            <input type="text" name="p[flow_secret_key]" value="<?= $g('flow_secret_key') ?>" placeholder="xxxxxxxxxxxxxxxxxxxx" autocomplete="off">
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title">MercadoPago (Checkout Pro)</h3>
        <p class="text-muted" style="margin:0 0 .6rem;font-size:.88rem;">
            Generá las credenciales en
            <a href="https://www.mercadopago.cl/developers/panel/app" target="_blank" rel="noopener">mercadopago → Tus integraciones</a>.
            Usá las claves de prueba mientras pruebas el flujo.
        </p>
        <p class="auth-alert auth-alert--info" style="margin:0 0 1rem;font-size:.85rem;">
            <strong>Pendiente de integración:</strong> las credenciales se guardan, pero el botón aún no aparece en el checkout hasta conectar la API real de MercadoPago.
        </p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;">
                <input type="checkbox" name="p[pay_mercadopago_enabled]" value="1" <?= $on('pay_mercadopago_enabled') ? 'checked' : '' ?> style="width:auto;">
                <span>Habilitar MercadoPago en el checkout</span>
            </label>
        </p>
        <p class="form__field"><label>Public Key
            <input type="text" name="p[mp_public_key]" value="<?= $g('mp_public_key') ?>" placeholder="APP_USR-…" autocomplete="off">
        </label></p>
        <p class="form__field" style="margin:0;"><label>Access Token
            <input type="text" name="p[mp_access_token]" value="<?= $g('mp_access_token') ?>" placeholder="APP_USR-…" autocomplete="off">
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title">Transbank Webpay Plus</h3>
        <p class="text-muted" style="margin:0 0 .6rem;font-size:.88rem;">
            Generá tu código de comercio en el portal de Transbank. Si dejás los campos vacíos podés usar las credenciales públicas de integración.
        </p>
        <p class="auth-alert auth-alert--info" style="margin:0 0 1rem;font-size:.85rem;">
            <strong>Pendiente de integración:</strong> las credenciales se guardan, pero el botón aún no aparece en el checkout hasta conectar la API real de Transbank.
        </p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;">
                <input type="checkbox" name="p[pay_transbank_enabled]" value="1" <?= $on('pay_transbank_enabled') ? 'checked' : '' ?> style="width:auto;">
                <span>Habilitar Webpay Plus en el checkout</span>
            </label>
        </p>
        <p class="form__field"><label>Ambiente
            <select name="p[tbk_environment]">
                <?php $tenv = $settings['tbk_environment'] ?? 'integration'; ?>
                <option value="integration" <?= $tenv === 'integration' ? 'selected' : '' ?>>Integración (pruebas)</option>
                <option value="production"  <?= $tenv === 'production'  ? 'selected' : '' ?>>Producción</option>
            </select>
        </label></p>
        <p class="form__field"><label>Commerce Code
            <input type="text" name="p[tbk_commerce_code]" value="<?= $g('tbk_commerce_code') ?>" placeholder="597055555532" autocomplete="off">
        </label></p>
        <p class="form__field" style="margin:0;"><label>API Key
            <input type="text" name="p[tbk_api_key]" value="<?= $g('tbk_api_key') ?>" placeholder="579B532A7440BB0C9079DED94D31EA1615BACEB56610332264630D42D0A36B1C" autocomplete="off">
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title">Transferencia bancaria</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.88rem;">
            El cliente recibe los datos al final del checkout y coordina la transferencia por fuera del sitio. La orden queda en <code>pending</code> hasta que la marques como pagada.
        </p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;">
                <input type="checkbox" name="p[pay_bank_transfer_enabled]" value="1" <?= $on('pay_bank_transfer_enabled') ? 'checked' : '' ?> style="width:auto;">
                <span>Habilitar transferencia bancaria</span>
            </label>
        </p>
        <p class="form__field" style="margin:0;"><label>Instrucciones (datos bancarios, plazo, contacto)
            <textarea name="p[pay_bank_transfer_instructions]" rows="5" placeholder="Banco: …
Cuenta corriente: …
RUT: …
Nombre: …
Email para enviar comprobante: …"><?= $g('pay_bank_transfer_instructions') ?></textarea>
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title">Pago contra entrega</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.88rem;">
            El cliente paga al recibir el pedido. La orden queda en <code>pending</code> y la confirmás cuando coordinás el cobro.
        </p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;">
                <input type="checkbox" name="p[pay_cod_enabled]" value="1" <?= $on('pay_cod_enabled') ? 'checked' : '' ?> style="width:auto;">
                <span>Habilitar pago contra entrega</span>
            </label>
        </p>
        <p class="form__field" style="margin:0;"><label>Instrucciones (zonas, condiciones, recargo)
            <textarea name="p[pay_cod_instructions]" rows="4" placeholder="Disponible en la Región Metropolitana. Aceptamos efectivo y débito en el lugar."><?= $g('pay_cod_instructions') ?></textarea>
        </label></p>
    </div>

    <p style="margin-top:1.5rem;"><button type="submit" class="btn">Guardar cambios</button></p>
</form>
