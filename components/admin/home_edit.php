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

    <!-- SECCIONES VISIBLES -->
    <div class="card">
        <h3 class="card__title">👁️ Secciones visibles</h3>
        <div class="settings-section-hint">Activá o desactivá bloques del inicio.</div>
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
