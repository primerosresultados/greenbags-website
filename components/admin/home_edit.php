<?php
/**
 * Editor de la página de inicio (admin → Páginas → Inicio).
 * Consolida en un solo lugar el contenido del home que antes vivía disperso en
 * Configuración: bloque de marca, banda de cotización, secciones visibles, y
 * accesos directos a los administradores de Banners y Clientes.
 * Requiere: $settings (claves HOME_KEYS), $homeBannerCount, $homeClientCount.
 */
$g = fn(string $k) => htmlspecialchars((string) ($settings[$k] ?? ''));
$on = fn(string $k) => ($settings[$k] ?? '') === '1';
$homeBannerCount = $homeBannerCount ?? 0;
$homeClientCount = $homeClientCount ?? 0;
$layout = $settings['home_categories_layout'] ?? 'bento';
?>
<header class="admin-header">
    <div>
        <h1>🏠 Editar Inicio</h1>
        <div class="admin-header__sub">Todo el contenido de la página principal en un solo lugar.</div>
    </div>
    <div class="admin-header__actions">
        <a class="btn btn--ghost" href="/" target="_blank" rel="noopener">Ver inicio →</a>
    </div>
</header>

<?php if ($msg = flashGet('home_success')): ?>
    <div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

<style>
.form-control { display:block; width:100%; padding:.75rem 1rem; font-size:.95rem; border:2px solid #e5e7eb; border-radius:8px; transition:all .2s ease; font-family:inherit; background:#fff; box-sizing:border-box; }
.form-control:focus { outline:0; border-color:#0f172a; box-shadow:0 0 0 3px rgba(15,23,42,.1); }
textarea.form-control { resize:vertical; min-height:90px; line-height:1.5; }
.form-label { display:block; font-weight:600; margin-bottom:.6rem; color:#1f2937; font-size:.95rem; }
.form-hint { display:block; font-size:.85rem; color:#6b7280; margin-top:.4rem; line-height:1.5; }
.form-group { margin-bottom:1.5rem; }
.form-group:last-child { margin-bottom:0; }
.form-row { display:grid; gap:1.5rem; grid-template-columns:repeat(auto-fit,minmax(260px,1fr)); }
.settings-section-hint { padding:.75rem 1rem; background:#f0f9ff; border-left:3px solid #0f172a; border-radius:4px; font-size:.9rem; color:#1f2937; line-height:1.6; margin-bottom:1.5rem; }
.home-toggles { display:grid; gap:.7rem; grid-template-columns:repeat(auto-fit,minmax(240px,1fr)); }
.checkbox-wrapper { display:flex; align-items:center; gap:.75rem; padding:.85rem 1rem; background:#f9fafb; border:2px solid #e5e7eb; border-radius:8px; }
.checkbox-wrapper input[type="checkbox"] { width:20px; height:20px; accent-color:#0f172a; cursor:pointer; flex-shrink:0; }
.checkbox-wrapper label { cursor:pointer; user-select:none; font-weight:500; margin:0; flex:1; }
.home-manage { display:flex; align-items:center; justify-content:space-between; gap:1rem; flex-wrap:wrap; padding:1rem 1.2rem; background:#f8fafc; border:1px solid #e5e7eb; border-radius:10px; }
.home-manage__txt strong { display:block; color:#0f172a; }
.home-manage__txt span { font-size:.85rem; color:#64748b; }
.home-actions { margin-top:2rem; padding-top:1.75rem; border-top:1px solid #e5e7eb; display:flex; gap:.75rem; }
</style>

<form method="post" id="home-form">
    <input type="hidden" name="action" value="save_home">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">

    <!-- HERO / BANNERS -->
    <div class="card">
        <h3 class="card__title">🎬 Hero (carrusel de banners)</h3>
        <div class="settings-section-hint">
            La parte de arriba del inicio es un carrusel de banners. Cada banner tiene su texto, imagen y botón.
        </div>
        <div class="home-manage">
            <div class="home-manage__txt">
                <strong>Banners del hero</strong>
                <span><?= (int) $homeBannerCount ?> banner(s) cargado(s)</span>
            </div>
            <a class="btn" href="/admin/?view=banners">Administrar banners →</a>
        </div>

        <div class="form-group" style="margin-top:1.5rem;">
            <label class="form-label">Puntos debajo del título</label>
            <span class="form-hint" style="margin:0 0 .6rem;">Las tres frases cortas con ícono que acompañan al banner. Deja vacío el campo para ocultar ese punto.</span>
            <div class="form-row">
                <?php for ($i = 1; $i <= 3; $i++): ?>
                    <input class="form-control" type="text" name="s[home_hero_point_<?= $i ?>]"
                           value="<?= $g("home_hero_point_{$i}") ?>" placeholder="Punto <?= $i ?>">
                <?php endfor; ?>
            </div>
        </div>
        <div class="form-group">
            <label class="form-label">Texto del botón de WhatsApp</label>
            <input class="form-control" type="text" name="s[home_hero_wa_label]" value="<?= $g('home_hero_wa_label') ?>" placeholder="Escribir por WhatsApp">
            <span class="form-hint">Sólo aparece si cargaste un número de WhatsApp en Negocio.</span>
        </div>
    </div>

    <!-- BENEFICIOS -->
    <div class="card">
        <h3 class="card__title">✅ Franja de beneficios</h3>
        <div class="settings-section-hint">
            Las cuatro tarjetas que se superponen al hero (envíos, pago, devoluciones, atención).
            Los íconos son fijos; vaciar título y texto oculta esa tarjeta.
        </div>
        <?php foreach ([1 => 'Envíos rápidos', 2 => 'Pago seguro', 3 => 'Cambios y devoluciones', 4 => 'Atención al cliente'] as $i => $ph): ?>
            <div class="form-row" style="margin-bottom:1rem;">
                <div class="form-group" style="margin:0;">
                    <label class="form-label">Beneficio <?= $i ?> — título</label>
                    <input class="form-control" type="text" name="s[home_benefit_<?= $i ?>_title]" value="<?= $g("home_benefit_{$i}_title") ?>" placeholder="<?= htmlspecialchars($ph) ?>">
                </div>
                <div class="form-group" style="margin:0;">
                    <label class="form-label">Beneficio <?= $i ?> — texto</label>
                    <input class="form-control" type="text" name="s[home_benefit_<?= $i ?>_desc]" value="<?= $g("home_benefit_{$i}_desc") ?>" placeholder="Descripción corta">
                </div>
            </div>
        <?php endforeach; ?>
    </div>

    <!-- BLOQUE DE MARCA -->
    <div class="card">
        <h3 class="card__title">✨ Bloque de marca ("Más de 15 años…")</h3>
        <div class="form-group">
            <label class="form-label">Título</label>
            <input class="form-control" type="text" name="s[home_story_title]" value="<?= $g('home_story_title') ?>" placeholder="Más de 15 años junto a empresas chilenas">
        </div>
        <div class="form-group">
            <label class="form-label">Texto</label>
            <textarea class="form-control" name="s[home_story_body]"><?= $g('home_story_body') ?></textarea>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Texto del botón</label>
                <input class="form-control" type="text" name="s[home_story_cta_label]" value="<?= $g('home_story_cta_label') ?>" placeholder="Conocer GreenBags">
            </div>
            <div class="form-group">
                <label class="form-label">URL del botón</label>
                <input class="form-control" type="text" name="s[home_story_cta_url]" value="<?= $g('home_story_cta_url') ?>" placeholder="/sobre-greenbags">
            </div>
        </div>
        <div class="form-group">
            <label class="form-label">Imagen</label>
            <?php
                $sifName  = 's[home_story_image]';
                $sifValue = (string) ($settings['home_story_image'] ?? '');
                $sifLabel = '';
                $sifPlaceholder = '/uploads/library/greenbags/...jpg';
                require __DIR__ . '/_single_image_field.php';
            ?>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Antetítulo</label>
                <input class="form-control" type="text" name="s[home_story_kicker]" value="<?= $g('home_story_kicker') ?>" placeholder="Empresa chilena">
            </div>
            <div class="form-group">
                <label class="form-label">Etiqueta sobre la foto</label>
                <input class="form-control" type="text" name="s[home_story_chip]" value="<?= $g('home_story_chip') ?>" placeholder="Entregas confiables">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Insignia — número</label>
                <input class="form-control" type="text" name="s[home_story_badge_num]" value="<?= $g('home_story_badge_num') ?>" placeholder="+15">
            </div>
            <div class="form-group">
                <label class="form-label">Insignia — texto</label>
                <textarea class="form-control" name="s[home_story_badge_text]" rows="2" style="min-height:0;"><?= $g('home_story_badge_text') ?></textarea>
                <span class="form-hint">Un salto de línea acá se respeta en el sitio.</span>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">Puntos del bloque</label>
            <span class="form-hint" style="margin:0 0 .6rem;">Los tres ítems con ícono debajo del texto.</span>
            <?php foreach ([1 => 'Atención personalizada', 2 => 'Responsabilidad ambiental', 3 => 'Para cada canal'] as $i => $ph): ?>
                <div class="form-row" style="margin-bottom:1rem;">
                    <input class="form-control" type="text" name="s[home_story_feat_<?= $i ?>_title]" value="<?= $g("home_story_feat_{$i}_title") ?>" placeholder="<?= htmlspecialchars($ph) ?>">
                    <input class="form-control" type="text" name="s[home_story_feat_<?= $i ?>_desc]" value="<?= $g("home_story_feat_{$i}_desc") ?>" placeholder="Descripción corta">
                </div>
            <?php endforeach; ?>
        </div>
    </div>

    <!-- TÍTULOS DE SECCIÓN -->
    <div class="card">
        <h3 class="card__title">🏷️ Títulos de las secciones</h3>
        <div class="settings-section-hint">
            Encabezados de las franjas de categorías, ejecutivos y productos destacados.
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Categorías — título</label>
                <input class="form-control" type="text" name="s[home_cats_title]" value="<?= $g('home_cats_title') ?>" placeholder="Nuestras Categorías">
            </div>
            <div class="form-group">
                <label class="form-label">Categorías — link a la derecha</label>
                <input class="form-control" type="text" name="s[home_cats_link]" value="<?= $g('home_cats_link') ?>" placeholder="Ver catálogo →">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Ejecutivos — título</label>
                <input class="form-control" type="text" name="s[home_sellers_title]" value="<?= $g('home_sellers_title') ?>" placeholder="Habla con un ejecutivo">
            </div>
            <div class="form-group">
                <label class="form-label">Ejecutivos — bajada</label>
                <input class="form-control" type="text" name="s[home_sellers_subtitle]" value="<?= $g('home_sellers_subtitle') ?>" placeholder="Atención directa y sin intermediarios">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Destacados — título</label>
                <input class="form-control" type="text" name="s[home_featured_title]" value="<?= $g('home_featured_title') ?>" placeholder="Lo más buscado">
            </div>
            <div class="form-group">
                <label class="form-label">Destacados — link a la derecha</label>
                <input class="form-control" type="text" name="s[home_featured_link]" value="<?= $g('home_featured_link') ?>" placeholder="Ver todo →">
            </div>
        </div>
    </div>

    <!-- NUESTROS CLIENTES -->
    <div class="card">
        <h3 class="card__title">🤝 Nuestros clientes</h3>
        <div class="form-group">
            <label class="form-label">Título de la sección</label>
            <input class="form-control" type="text" name="s[home_clients_title]" value="<?= $g('home_clients_title') ?>" placeholder="Nuestros clientes">
        </div>
        <div class="home-manage">
            <div class="home-manage__txt">
                <strong>Logos de clientes</strong>
                <span><?= (int) $homeClientCount ?> cliente(s) cargado(s)</span>
            </div>
            <a class="btn" href="/admin/?view=clients">Administrar clientes →</a>
        </div>
    </div>

    <!-- BANDA FINAL -->
    <div class="card">
        <h3 class="card__title">📣 Banda final (cotización)</h3>
        <div class="settings-section-hint">
            Franja al final del inicio. El botón abre el formulario de cotización ("Cotiza tu packaging").
        </div>
        <div class="form-group">
            <label class="form-label">Título</label>
            <input class="form-control" type="text" name="s[home_cta_title]" value="<?= $g('home_cta_title') ?>" placeholder="¿Listo para conocer nuestras soluciones?">
        </div>
        <div class="form-group">
            <label class="form-label">Subtítulo</label>
            <input class="form-control" type="text" name="s[home_cta_subtitle]" value="<?= $g('home_cta_subtitle') ?>" placeholder="Pide una cotización personalizada o descarga nuestro catálogo.">
        </div>
        <div class="form-group">
            <label class="form-label">Texto del botón</label>
            <input class="form-control" type="text" name="s[home_cta_label]" value="<?= $g('home_cta_label') ?>" placeholder="Solicitar cotización">
        </div>
    </div>

    <!-- MODAL DE COTIZACIÓN -->
    <div class="card">
        <h3 class="card__title">💬 Formulario de cotización</h3>
        <div class="settings-section-hint">
            La ventana que se abre al tocar “Solicitar cotización” en cualquier parte del inicio.
        </div>
        <div class="form-group">
            <label class="form-label">Título</label>
            <input class="form-control" type="text" name="s[home_quote_title]" value="<?= $g('home_quote_title') ?>" placeholder="Cotiza tu packaging">
        </div>
        <div class="form-group">
            <label class="form-label">Bajada</label>
            <textarea class="form-control" name="s[home_quote_subtitle]" rows="2" style="min-height:0;"><?= $g('home_quote_subtitle') ?></textarea>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Texto del botón de envío</label>
                <input class="form-control" type="text" name="s[home_quote_button]" value="<?= $g('home_quote_button') ?>" placeholder="Solicitar cotización">
            </div>
            <div class="form-group">
                <label class="form-label">Línea de confianza (al pie)</label>
                <input class="form-control" type="text" name="s[home_quote_trust]" value="<?= $g('home_quote_trust') ?>" placeholder="Sin compromiso · Respuesta por WhatsApp o email">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Mensaje de éxito — título</label>
                <input class="form-control" type="text" name="s[home_quote_ok_title]" value="<?= $g('home_quote_ok_title') ?>" placeholder="¡Gracias por escribirnos!">
            </div>
            <div class="form-group">
                <label class="form-label">Mensaje de éxito — texto</label>
                <input class="form-control" type="text" name="s[home_quote_ok_text]" value="<?= $g('home_quote_ok_text') ?>" placeholder="Te responderemos a la brevedad.">
            </div>
        </div>
    </div>

    <!-- SECCIONES VISIBLES -->
    <div class="card">
        <h3 class="card__title">👁️ Secciones visibles</h3>
        <div class="settings-section-hint">Activa o desactiva bloques del inicio.</div>
        <div class="home-toggles">
            <?php foreach ([
                'home_show_story'      => 'Bloque de marca',
                'home_show_clients'    => 'Nuestros clientes',
                'home_show_categories' => 'Categorías',
                'home_show_benefits'   => 'Beneficios (envío/pago/…)',
                'home_show_featured'   => 'Productos destacados',
            ] as $key => $lbl): ?>
                <div class="checkbox-wrapper">
                    <input type="checkbox" id="<?= $key ?>" name="s[<?= $key ?>]" value="1" <?= $on($key) ? 'checked' : '' ?>>
                    <label for="<?= $key ?>"><?= htmlspecialchars($lbl) ?></label>
                </div>
            <?php endforeach; ?>
        </div>
        <div class="form-group" style="margin-top:1.4rem;">
            <label class="form-label">Diseño de las categorías</label>
            <select class="form-control" name="s[home_categories_layout]">
                <?php foreach (['bento' => 'Bento (mosaico)', 'grid' => 'Grilla', 'carousel' => 'Carrusel', 'masonry' => 'Masonry'] as $k => $lbl): ?>
                    <option value="<?= $k ?>" <?= $layout === $k ? 'selected' : '' ?>><?= htmlspecialchars($lbl) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
    </div>

    <div class="home-actions">
        <button type="submit" form="home-form" class="btn" style="padding:.85rem 2rem;font-size:.95rem;font-weight:600;">Guardar cambios</button>
    </div>
</form>
