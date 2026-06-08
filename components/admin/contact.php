<?php
/**
 * Admin → Contacto
 * Edita textos editoriales de la página `/contacto` (settings `contact_*`).
 * Los datos "duros" (email, teléfono, WhatsApp, dirección, redes) viven en
 * settings `business_*` y se editan desde admin → Negocio.
 *
 * Requiere: $settings (array CONTACT_KEYS → string), $contactPage (?array de pages)
 */
$g = fn(string $k) => htmlspecialchars((string) ($settings[$k] ?? ''));
$is = fn(string $k, string $default = '1') => (($settings[$k] ?? $default) === '1');
$contactPage = $contactPage ?? null;
?>
<header class="admin-header">
    <div>
        <h1>Página de contacto</h1>
        <div class="admin-header__sub">
            Edita el copy de la página pública <code>/contacto</code>.
            Los datos de contacto (email, teléfono, dirección, redes) se editan en
            <a href="/admin/?view=business">Negocio</a>.
        </div>
    </div>
    <div style="display:flex;gap:.5rem;">
        <a href="/contacto" target="_blank" rel="noopener" class="btn btn--secondary">Ver página →</a>
    </div>
</header>

<?php if ($msg = flashGet('contact_success')): ?>
    <div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>
<?php if ($msg = flashGet('contact_error')): ?>
    <div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

<form method="post">
    <input type="hidden" name="action" value="save_contact">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">

    <!-- ====== Entrada de página (pages) ====== -->
    <div class="card">
        <h3 class="card__title">Página en el menú</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.88rem;">
            La página aparece en el header con este título mientras esté publicada.
        </p>
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:.8rem;">
            <p class="form__field"><label>Título de la página <small class="text-muted">(menú/head)</small>
                <input type="text" name="c[page_title]" value="<?= htmlspecialchars((string) ($contactPage['title'] ?? 'Contacto')) ?>" placeholder="Contacto">
            </label></p>
            <p class="form__field" style="display:flex;align-items:end;">
                <label style="display:flex;align-items:center;gap:.5rem;margin:0;">
                    <input type="checkbox" name="c[is_published]" value="1" <?= (!$contactPage || (int) ($contactPage['is_published'] ?? 1)) ? 'checked' : '' ?>>
                    <span>Publicada (visible en <code>/contacto</code>)</span>
                </label>
            </p>
        </div>
    </div>

    <!-- ====== Hero ====== -->
    <div class="card">
        <h3 class="card__title">Cabecera</h3>
        <p class="form__field"><label>Eyebrow / etiqueta corta <small class="text-muted">(arriba del título)</small>
            <input type="text" name="c[contact_eyebrow]" value="<?= $g('contact_eyebrow') ?>" placeholder="Estamos para ayudarte">
        </label></p>
        <p class="form__field"><label>Título principal
            <input type="text" name="c[contact_title]" value="<?= $g('contact_title') ?>" placeholder="Hablemos">
        </label></p>
        <p class="form__field" style="margin:0;"><label>Intro / bajada
            <textarea name="c[contact_intro]" rows="3" placeholder="Una o dos líneas sobre cómo te pueden contactar."><?= $g('contact_intro') ?></textarea>
        </label></p>
    </div>

    <!-- ====== Métodos ====== -->
    <div class="card">
        <h3 class="card__title">Tarjetas de métodos directos</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.88rem;">
            Bloque con WhatsApp, email, teléfono y dirección. Solo se muestran los que tengan datos cargados en
            <a href="/admin/?view=business">Negocio</a>.
        </p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;margin:0 0 .8rem;">
                <input type="checkbox" name="c[contact_show_methods]" value="1" <?= $is('contact_show_methods') ? 'checked' : '' ?>>
                <span>Mostrar tarjetas de contacto rápido</span>
            </label>
        </p>
        <p class="form__field" style="margin:0;"><label>Título de la sección
            <input type="text" name="c[contact_methods_title]" value="<?= $g('contact_methods_title') ?>" placeholder="Canales directos">
        </label></p>
    </div>

    <!-- ====== Formulario ====== -->
    <div class="card">
        <h3 class="card__title">Formulario de contacto</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.88rem;">
            Los mensajes se guardan como leads (source = <code>contact_page</code>) y disparan las notificaciones configuradas en
            <a href="/admin/?view=mailing">Mailing</a>.
        </p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;margin:0 0 .8rem;">
                <input type="checkbox" name="c[contact_show_form]" value="1" <?= $is('contact_show_form') ? 'checked' : '' ?>>
                <span>Mostrar formulario</span>
            </label>
        </p>
        <p class="form__field"><label>Título del formulario
            <input type="text" name="c[contact_form_title]" value="<?= $g('contact_form_title') ?>" placeholder="Escribinos un mensaje">
        </label></p>
        <p class="form__field"><label>Intro del formulario
            <textarea name="c[contact_form_intro]" rows="2" placeholder="Contanos en qué podemos ayudarte..."><?= $g('contact_form_intro') ?></textarea>
        </label></p>
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:.8rem;">
            <p class="form__field" style="margin:0;"><label>Título del mensaje de éxito
                <input type="text" name="c[contact_form_success_title]" value="<?= $g('contact_form_success_title') ?>" placeholder="¡Gracias por escribirnos!">
            </label></p>
            <p class="form__field" style="margin:0;"><label>Cuerpo del mensaje de éxito
                <input type="text" name="c[contact_form_success_body]" value="<?= $g('contact_form_success_body') ?>" placeholder="Recibimos tu mensaje y te respondemos en breve.">
            </label></p>
        </div>
    </div>

    <!-- ====== Mapa ====== -->
    <div class="card">
        <h3 class="card__title">Mapa embebido</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.88rem;">
            Pegá el <strong>src</strong> del <code>&lt;iframe&gt;</code> que te da Google Maps
            (Compartir → Insertar un mapa → copiá el valor de <code>src=...</code>).
        </p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;margin:0 0 .8rem;">
                <input type="checkbox" name="c[contact_show_map]" value="1" <?= $is('contact_show_map') ? 'checked' : '' ?>>
                <span>Mostrar mapa</span>
            </label>
        </p>
        <p class="form__field"><label>Título de la sección
            <input type="text" name="c[contact_map_title]" value="<?= $g('contact_map_title') ?>" placeholder="Dónde estamos">
        </label></p>
        <p class="form__field" style="margin:0;"><label>URL del iframe (src) de Google Maps
            <input type="url" name="c[contact_map_embed]" value="<?= $g('contact_map_embed') ?>" placeholder="https://www.google.com/maps/embed?pb=...">
        </label></p>
    </div>

    <!-- ====== Sucursales ====== -->
    <div class="card">
        <h3 class="card__title">Sucursales</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.88rem;">
            Si tenés sucursales activas cargadas en <a href="/admin/?view=business">Negocio → Sucursales</a>, se listan acá como tarjetas.
        </p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;margin:0 0 .8rem;">
                <input type="checkbox" name="c[contact_show_branches]" value="1" <?= $is('contact_show_branches') ? 'checked' : '' ?>>
                <span>Mostrar sucursales</span>
            </label>
        </p>
        <p class="form__field" style="margin:0;"><label>Título de la sección
            <input type="text" name="c[contact_branches_title]" value="<?= $g('contact_branches_title') ?>" placeholder="Nuestras sucursales">
        </label></p>
    </div>

    <!-- ====== SEO ====== -->
    <div class="card">
        <h3 class="card__title">SEO</h3>
        <p class="form__field" style="margin:0;"><label>Meta description <small class="text-muted">(opcional — si está vacía, usa la intro del hero)</small>
            <input type="text" name="c[contact_meta_description]" value="<?= $g('contact_meta_description') ?>" maxlength="300" placeholder="Contactanos por WhatsApp, email o teléfono...">
        </label></p>
    </div>

    <p style="margin-top:1.5rem;">
        <button type="submit" class="btn">Guardar cambios</button>
    </p>
</form>
