<?php
/** Requiere: $settings (array key => value) */
?>
<header class="admin-header">
    <div>
        <h1>Configuración</h1>
        <div class="admin-header__sub">Ajustes generales del sitio, marca, notificaciones y tracking.</div>
    </div>
</header>

<?php if ($msg = flashGet('settings_success')): ?>
    <div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>
<?php if ($msg = flashGet('settings_error')): ?>
    <div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

<form method="post">
    <input type="hidden" name="action" value="save_settings">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">

    <div class="card">
        <h3 class="card__title">General</h3>
        <p class="form__field"><label>Nombre del sitio
            <input name="s[site_name]" value="<?= htmlspecialchars($settings['site_name'] ?? '') ?>" required>
        </label></p>
        <p class="form__field" style="margin:0;"><label>Timezone
            <input name="s[timezone]" value="<?= htmlspecialchars($settings['timezone'] ?? 'America/Santiago') ?>">
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title">Colores de marca</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.9rem;">El primario se usa en botones, links activos y badges. El secundario en el CTA destacado (ej. WhatsApp). Deja en blanco para usar los colores por defecto.</p>
        <?php $tP = $settings['theme_primary'] ?? ''; $tS = $settings['theme_secondary'] ?? ''; ?>
        <div style="display:grid;gap:1rem;grid-template-columns:1fr 1fr;align-items:end;">
            <div>
                <label style="display:block;font-size:.85rem;font-weight:600;margin-bottom:.4rem;">Color primario</label>
                <div style="display:flex;gap:.5rem;align-items:center;">
                    <input type="color" name="s[theme_primary]" value="<?= htmlspecialchars($tP ?: '#0f172a') ?>" style="height:46px;width:64px;padding:.2rem;border-radius:8px;border:1px solid #d1d5db;cursor:pointer;" id="tp">
                    <input type="text" value="<?= htmlspecialchars($tP) ?>" placeholder="#0f172a" style="flex:1;" id="tp-hex" oninput="document.getElementById('tp').value = this.value;">
                </div>
                <div class="theme-preview" style="margin-top:.7rem;display:flex;gap:.5rem;align-items:center;">
                    <span style="display:inline-block;width:80px;height:32px;border-radius:6px;background:<?= htmlspecialchars($tP ?: '#0f172a') ?>;" id="tp-swatch"></span>
                    <button type="button" style="background:<?= htmlspecialchars($tP ?: '#0f172a') ?>;color:#fff;border:0;padding:.5rem 1rem;border-radius:8px;font-weight:600;" id="tp-btn">Botón primario</button>
                </div>
            </div>
            <div>
                <label style="display:block;font-size:.85rem;font-weight:600;margin-bottom:.4rem;">Color secundario</label>
                <div style="display:flex;gap:.5rem;align-items:center;">
                    <input type="color" name="s[theme_secondary]" value="<?= htmlspecialchars($tS ?: '#25d366') ?>" style="height:46px;width:64px;padding:.2rem;border-radius:8px;border:1px solid #d1d5db;cursor:pointer;" id="ts">
                    <input type="text" value="<?= htmlspecialchars($tS) ?>" placeholder="#25d366" style="flex:1;" id="ts-hex" oninput="document.getElementById('ts').value = this.value;">
                </div>
                <div class="theme-preview" style="margin-top:.7rem;display:flex;gap:.5rem;align-items:center;">
                    <span style="display:inline-block;width:80px;height:32px;border-radius:6px;background:<?= htmlspecialchars($tS ?: '#25d366') ?>;" id="ts-swatch"></span>
                    <button type="button" style="background:<?= htmlspecialchars($tS ?: '#25d366') ?>;color:#fff;border:0;padding:.5rem 1rem;border-radius:8px;font-weight:600;" id="ts-btn">CTA secundario</button>
                </div>
            </div>
        </div>
        <script>
        // Live preview de los color pickers (sin esperar a guardar).
        (function(){
            function sync(colorId, swatchId, btnId, hexId){
                var c = document.getElementById(colorId);
                if (!c) return;
                c.addEventListener('input', function(){
                    document.getElementById(swatchId).style.background = c.value;
                    document.getElementById(btnId).style.background = c.value;
                    document.getElementById(hexId).value = c.value;
                });
            }
            sync('tp','tp-swatch','tp-btn','tp-hex');
            sync('ts','ts-swatch','ts-btn','ts-hex');
        })();
        </script>
    </div>

    <div class="card">
        <h3 class="card__title">Announce bar (barra superior)</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.9rem;">Banda fina arriba del header para promos, envíos gratis, anuncios importantes. Si desactivás esta opción no se renderiza.</p>
        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;">
                <input type="checkbox" name="s[announce_enabled]" value="1" <?= (($settings['announce_enabled'] ?? '0') === '1') ? 'checked' : '' ?> style="width:auto;">
                <span>Mostrar announce bar</span>
            </label>
        </p>
        <p class="form__field"><label>Texto principal
            <input name="s[announce_text]" value="<?= htmlspecialchars($settings['announce_text'] ?? '') ?>" placeholder="🚚 Envío gratis en compras +$50.000">
        </label></p>
        <div style="display:grid;gap:.8rem;grid-template-columns:1fr 1fr;">
            <p class="form__field"><label>Texto del link (opcional)
                <input name="s[announce_link_label]" value="<?= htmlspecialchars($settings['announce_link_label'] ?? '') ?>" placeholder="Ver condiciones">
            </label></p>
            <p class="form__field"><label>URL del link (opcional)
                <input name="s[announce_link_url]" value="<?= htmlspecialchars($settings['announce_link_url'] ?? '') ?>" placeholder="/envios">
            </label></p>
        </div>
        <div style="display:grid;gap:.8rem;grid-template-columns:1fr 1fr;">
            <p class="form__field"><label>Color de fondo
                <input type="color" name="s[announce_bg]" value="<?= htmlspecialchars($settings['announce_bg'] ?: '#0f172a') ?>" style="height:42px;padding:.2rem;width:120px;">
            </label></p>
            <p class="form__field" style="margin:0;"><label>Color del texto
                <input type="color" name="s[announce_fg]" value="<?= htmlspecialchars($settings['announce_fg'] ?: '#ffffff') ?>" style="height:42px;padding:.2rem;width:120px;">
            </label></p>
        </div>
    </div>

    <div class="card">
        <h3 class="card__title">Estilo de cabecera</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.9rem;">Tres variantes modernas. La de hamburguesa muestra el menú lateral incluso en desktop (estilo agencia / marca premium).</p>
        <?php $hs = $settings['header_style'] ?? 'classic'; ?>
        <div class="header-style-picker">
            <?php foreach ([
                ['key' => 'classic',   'name' => 'Clásico moderno', 'desc' => 'Logo izquierda, menú horizontal, acciones a la derecha.',
                 'svg' => '<svg viewBox="0 0 220 56" preserveAspectRatio="none"><rect width="220" height="56" fill="#fff" stroke="#e5e7eb"/><rect x="14" y="22" width="42" height="12" rx="2" fill="#0f172a"/><rect x="86" y="26" width="20" height="4" rx="1" fill="#94a3b8"/><rect x="114" y="26" width="20" height="4" rx="1" fill="#94a3b8"/><rect x="142" y="26" width="20" height="4" rx="1" fill="#0f172a"/><circle cx="184" cy="28" r="8" fill="#f1f5f9"/><rect x="196" y="20" width="14" height="16" rx="8" fill="#25d366"/></svg>'],
                ['key' => 'centered',  'name' => 'Centrado',        'desc' => 'Logo grande arriba, menú horizontal centrado debajo.',
                 'svg' => '<svg viewBox="0 0 220 70" preserveAspectRatio="none"><rect width="220" height="70" fill="#fff" stroke="#e5e7eb"/><rect x="90" y="10" width="40" height="14" rx="2" fill="#0f172a"/><rect x="64" y="44" width="18" height="4" rx="1" fill="#94a3b8"/><rect x="90" y="44" width="18" height="4" rx="1" fill="#0f172a"/><rect x="116" y="44" width="18" height="4" rx="1" fill="#94a3b8"/><rect x="142" y="44" width="18" height="4" rx="1" fill="#94a3b8"/><circle cx="14" cy="36" r="7" fill="#f1f5f9"/><rect x="190" y="30" width="14" height="14" rx="7" fill="#25d366"/></svg>'],
                ['key' => 'hamburger', 'name' => 'Hamburguesa',     'desc' => 'Sólo logo, carrito y menú lateral. Mínimo y elegante en cualquier viewport.',
                 'svg' => '<svg viewBox="0 0 220 56" preserveAspectRatio="none"><rect width="220" height="56" fill="#fff" stroke="#e5e7eb"/><rect x="14" y="22" width="42" height="12" rx="2" fill="#0f172a"/><circle cx="174" cy="28" r="8" fill="#f1f5f9"/><rect x="190" y="20" width="18" height="2.5" rx="1" fill="#0f172a"/><rect x="190" y="27" width="18" height="2.5" rx="1" fill="#0f172a"/><rect x="190" y="34" width="18" height="2.5" rx="1" fill="#0f172a"/></svg>'],
            ] as $opt): ?>
                <label class="header-style-card<?= $hs === $opt['key'] ? ' is-active' : '' ?>">
                    <input type="radio" name="s[header_style]" value="<?= $opt['key'] ?>" <?= $hs === $opt['key'] ? 'checked' : '' ?>>
                    <span class="header-style-card__preview"><?= $opt['svg'] ?></span>
                    <span class="header-style-card__name"><?= htmlspecialchars($opt['name']) ?></span>
                    <span class="header-style-card__desc"><?= htmlspecialchars($opt['desc']) ?></span>
                </label>
            <?php endforeach; ?>
        </div>
        <style>
        .header-style-picker { display: grid; gap: .9rem; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); }
        .header-style-card { display: flex; flex-direction: column; gap: .5rem; padding: 1rem; border: 2px solid #e5e7eb; border-radius: 12px; cursor: pointer; background: #fff; transition: border-color .15s, box-shadow .15s, transform .15s; }
        .header-style-card:hover { border-color: #94a3b8; transform: translateY(-1px); box-shadow: 0 6px 18px rgba(15,23,42,.06); }
        .header-style-card.is-active { border-color: #0f172a; box-shadow: 0 6px 18px rgba(15,23,42,.10); }
        .header-style-card input { position: absolute; opacity: 0; pointer-events: none; }
        .header-style-card__preview { display: block; border-radius: 8px; overflow: hidden; background: #f8fafc; }
        .header-style-card__preview svg { width: 100%; height: auto; display: block; }
        .header-style-card__name { font-weight: 600; font-size: .95rem; }
        .header-style-card__desc { font-size: .82rem; color: #64748b; line-height: 1.4; }
        </style>
    </div>

    <div class="card">
        <h3 class="card__title">Página de inicio</h3>
        <p class="text-muted" style="margin:0 0 1rem;font-size:.9rem;">Personalizá los bloques de tu home. Si dejás un campo vacío se usan los textos por defecto.</p>

        <h4 style="margin:.4rem 0 .6rem;font-size:.9rem;text-transform:uppercase;letter-spacing:.05em;color:#64748b;">Hero (banner principal)</h4>
        <p class="form__field"><label>Eyebrow (texto pequeño arriba del título)
            <input name="s[home_hero_eyebrow]" value="<?= htmlspecialchars($settings['home_hero_eyebrow'] ?? '') ?>" placeholder="Nueva colección">
        </label></p>
        <p class="form__field"><label>Título
            <input name="s[home_hero_title]" value="<?= htmlspecialchars($settings['home_hero_title'] ?? '') ?>" placeholder="Bienvenidos a la tienda">
        </label></p>
        <p class="form__field"><label>Subtítulo
            <textarea name="s[home_hero_subtitle]" rows="2"><?= htmlspecialchars($settings['home_hero_subtitle'] ?? '') ?></textarea>
        </label></p>
        <div style="display:grid;gap:.8rem;grid-template-columns:1fr 1fr;">
            <p class="form__field"><label>Texto del botón principal
                <input name="s[home_hero_cta_label]" value="<?= htmlspecialchars($settings['home_hero_cta_label'] ?? '') ?>" placeholder="Ver tienda">
            </label></p>
            <p class="form__field"><label>URL del botón principal
                <input name="s[home_hero_cta_url]" value="<?= htmlspecialchars($settings['home_hero_cta_url'] ?? '') ?>" placeholder="/tienda">
            </label></p>
        </div>
        <?php
            $sifName  = 's[home_hero_image]';
            $sifValue = (string) ($settings['home_hero_image'] ?? '');
            $sifLabel = 'Imagen de fondo (opcional, recomendado 1600×900)';
            $sifPlaceholder = '/uploads/...';
            require __DIR__ . '/_single_image_field.php';
        ?>

        <h4 style="margin:1.4rem 0 .6rem;font-size:.9rem;text-transform:uppercase;letter-spacing:.05em;color:#64748b;">Bloques visibles</h4>
        <div style="display:grid;gap:.5rem;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));">
            <?php foreach ([
                'home_show_benefits'   => 'Beneficios (envío/pago/etc.)',
                'home_show_categories' => 'Categorías destacadas',
                'home_show_featured'   => 'Productos destacados',
                'home_show_story'      => 'Bloque de marca',
                'home_show_contact'    => 'Formulario de contacto',
            ] as $key => $lbl): $on = ($settings[$key] ?? '1') === '1'; ?>
                <label style="display:flex;align-items:center;gap:.5rem;font-size:.9rem;">
                    <input type="checkbox" name="s[<?= $key ?>]" value="1" <?= $on ? 'checked' : '' ?> style="width:auto;">
                    <span><?= htmlspecialchars($lbl) ?></span>
                </label>
            <?php endforeach; ?>
        </div>

        <h4 style="margin:1.4rem 0 .6rem;font-size:.9rem;text-transform:uppercase;letter-spacing:.05em;color:#64748b;">Bloque de marca / storytelling</h4>
        <p class="form__field"><label>Título
            <input name="s[home_story_title]" value="<?= htmlspecialchars($settings['home_story_title'] ?? '') ?>" placeholder="Hechos con dedicación">
        </label></p>
        <p class="form__field"><label>Texto
            <textarea name="s[home_story_body]" rows="4"><?= htmlspecialchars($settings['home_story_body'] ?? '') ?></textarea>
        </label></p>
        <div style="display:grid;gap:.8rem;grid-template-columns:1fr 1fr;">
            <p class="form__field"><label>Texto del botón
                <input name="s[home_story_cta_label]" value="<?= htmlspecialchars($settings['home_story_cta_label'] ?? '') ?>" placeholder="Conócenos">
            </label></p>
            <p class="form__field"><label>URL del botón
                <input name="s[home_story_cta_url]" value="<?= htmlspecialchars($settings['home_story_cta_url'] ?? '') ?>" placeholder="/nosotros">
            </label></p>
        </div>
        <?php
            $sifName  = 's[home_story_image]';
            $sifValue = (string) ($settings['home_story_image'] ?? '');
            $sifLabel = 'Imagen del bloque (recomendado 800×600)';
            $sifPlaceholder = '/uploads/...';
            require __DIR__ . '/_single_image_field.php';
        ?>

        <h4 style="margin:1.4rem 0 .6rem;font-size:.9rem;text-transform:uppercase;letter-spacing:.05em;color:#64748b;">Banda final (newsletter)</h4>
        <p class="text-muted" style="margin:0 0 .6rem;font-size:.85rem;">Banda al final de la home con form de suscripción. Los emails quedan en Leads con origen <code>newsletter</code>.</p>
        <p class="form__field"><label>Título
            <input name="s[home_cta_title]" value="<?= htmlspecialchars($settings['home_cta_title'] ?? '') ?>" placeholder="Suscríbete y recibe nuestras novedades">
        </label></p>
        <p class="form__field"><label>Subtítulo (descripción breve)
            <input name="s[home_cta_subtitle]" value="<?= htmlspecialchars($settings['home_cta_subtitle'] ?? '') ?>" placeholder="Ofertas exclusivas, descuentos y lanzamientos en tu correo.">
        </label></p>
        <p class="form__field" style="margin:0;"><label>Texto del botón
            <input name="s[home_cta_label]" value="<?= htmlspecialchars($settings['home_cta_label'] ?? '') ?>" placeholder="Suscríbete">
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title">Logo del header</h3>
        <p class="text-muted" style="margin:0 0 .8rem;font-size:.88rem;">Imagen que aparece en el sidebar del admin y se puede usar en el front. Idealmente PNG o SVG con fondo transparente.</p>
        <?php
            $sifName  = 's[logo_image]';
            $sifValue = (string) ($settings['logo_image'] ?? '');
            $sifLabel = '';
            $sifPlaceholder = '/uploads/brand/logo.png';
            require __DIR__ . '/_single_image_field.php';
        ?>
    </div>

    <div class="card">
        <h3 class="card__title">Notificaciones de leads</h3>
        <p class="form__field"><label>Email destino (recibe los leads)
            <input type="email" name="s[notification_email]" value="<?= htmlspecialchars($settings['notification_email'] ?? '') ?>">
        </label></p>
        <p class="form__field"><label>From: (remitente — debe ser de tu dominio)
            <input type="email" name="s[notification_from]" value="<?= htmlspecialchars($settings['notification_from'] ?? '') ?>" placeholder="no-reply@tudominio.com">
        </label></p>

        <p class="form__field">
            <label style="display:flex;align-items:center;gap:.5rem;">
                <input type="checkbox" name="s[autoreply_enabled]" value="1" style="width:auto;" <?= ($settings['autoreply_enabled'] ?? '0') === '1' ? 'checked' : '' ?>>
                <span>Enviar auto-respuesta al lead</span>
            </label>
        </p>
        <p class="form__field"><label>Asunto auto-respuesta
            <input name="s[autoreply_subject]" value="<?= htmlspecialchars($settings['autoreply_subject'] ?? '') ?>">
        </label></p>
        <p class="form__field" style="margin:0;"><label>Cuerpo auto-respuesta (variables: <code>{{name}}</code>, <code>{{email}}</code>)
            <textarea name="s[autoreply_body]" rows="5"><?= htmlspecialchars($settings['autoreply_body'] ?? '') ?></textarea>
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title">Tracking</h3>
        <p class="form__field"><label>Google Analytics ID (G-XXXXXXX)
            <input name="s[ga_id]" value="<?= htmlspecialchars($settings['ga_id'] ?? '') ?>">
        </label></p>
        <p class="form__field" style="margin:0;"><label>Facebook Pixel ID
            <input name="s[pixel_id]" value="<?= htmlspecialchars($settings['pixel_id'] ?? '') ?>">
        </label></p>
    </div>

    <p style="margin-top:1.5rem;"><button type="submit" class="btn">Guardar cambios</button></p>
</form>

<?php
$faviconPath   = trim((string) ($settings['favicon_image'] ?? ''));
$faviconAbs    = $faviconPath ? (__DIR__ . '/../..' . $faviconPath) : '';
$faviconExists = $faviconPath !== '' && @file_exists($faviconAbs);
$faviconHref   = $faviconExists ? ($faviconPath . '?v=' . @filemtime($faviconAbs)) : '';
?>
<div class="card">
    <h3 class="card__title">Favicon</h3>
    <p class="text-muted" style="margin:0 0 1rem;font-size:.9rem;">El ícono que aparece en la pestaña del navegador. PNG, SVG o ICO (recomendado: PNG cuadrado 512×512 o SVG).</p>
    <div style="display:flex;gap:1.2rem;align-items:center;flex-wrap:wrap;">
        <div style="width:64px;height:64px;border:1px solid #e5e7eb;background:#f9fafb;display:flex;align-items:center;justify-content:center;flex-shrink:0;border-radius:6px;">
            <?php if ($faviconExists): ?>
                <img src="<?= htmlspecialchars($faviconHref) ?>" alt="" style="max-width:100%;max-height:100%;object-fit:contain;">
            <?php else: ?>
                <span class="text-muted" style="font-size:.7rem;">sin favicon</span>
            <?php endif; ?>
        </div>
        <form method="post" enctype="multipart/form-data" style="display:flex;gap:.6rem;align-items:center;flex-wrap:wrap;margin:0;">
            <input type="hidden" name="action" value="favicon_upload">
            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
            <input type="file" name="favicon" accept="image/png,image/svg+xml,image/x-icon,.png,.svg,.ico" required>
            <button type="submit" class="btn">Subir favicon</button>
        </form>
        <?php if ($faviconExists): ?>
            <form method="post" style="margin:0;" onsubmit="return confirm('¿Eliminar el favicon actual?');">
                <input type="hidden" name="action" value="favicon_remove">
                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                <button type="submit" class="btn btn--ghost">Eliminar</button>
            </form>
        <?php endif; ?>
    </div>
    <?php if ($faviconExists): ?>
        <p class="text-muted" style="margin:.9rem 0 0;font-size:.82rem;">Archivo actual: <code><?= htmlspecialchars($faviconPath) ?></code></p>
    <?php endif; ?>
</div>

<script>
// Selector de estilo de header: marca visualmente la tarjeta activa al cambiar el radio.
(function(){
    document.querySelectorAll('.header-style-card input[type="radio"]').forEach(function(r){
        r.addEventListener('change', function(){
            document.querySelectorAll('.header-style-card').forEach(function(c){ c.classList.remove('is-active'); });
            r.closest('.header-style-card').classList.add('is-active');
        });
    });
})();
</script>
