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

<style>
/* Modernización de formularios */
.form-control {
  display: block;
  width: 100%;
  padding: 0.75rem 1rem;
  font-size: 0.95rem;
  border: 2px solid #e5e7eb;
  border-radius: 8px;
  transition: all 0.2s ease;
  font-family: inherit;
  background: #fff;
  box-sizing: border-box;
}

.form-control:focus {
  outline: 0;
  border-color: #0f172a;
  box-shadow: 0 0 0 3px rgba(15, 23, 42, 0.1);
}

.form-control:disabled {
  background: #f3f4f6;
  color: #9ca3af;
  cursor: not-allowed;
}

textarea.form-control {
  resize: vertical;
  min-height: 100px;
  font-family: 'Monaco', 'Menlo', monospace;
  font-size: 0.9rem;
  line-height: 1.5;
}

.form-label {
  display: block;
  font-weight: 600;
  margin-bottom: 0.6rem;
  color: #1f2937;
  font-size: 0.95rem;
}

.form-hint {
  display: block;
  font-size: 0.85rem;
  color: #6b7280;
  margin-top: 0.4rem;
  line-height: 1.5;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group:last-child {
  margin-bottom: 0;
}

.form-row {
  display: grid;
  gap: 1.5rem;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
}

.form-row--full { grid-template-columns: 1fr; }

/* Color pickers */
.color-picker-group {
  display: flex;
  gap: 1rem;
  align-items: flex-start;
  flex-wrap: wrap;
}

.color-picker-col {
  flex: 1;
  min-width: 280px;
}

.color-input-wrapper {
  display: flex;
  gap: 0.75rem;
  align-items: center;
}

.color-picker-input {
  width: 56px;
  height: 48px;
  border: 2px solid #e5e7eb;
  border-radius: 8px;
  padding: 4px;
  cursor: pointer;
  flex-shrink: 0;
  transition: border-color 0.2s;
}

.color-picker-input:hover {
  border-color: #d1d5db;
}

.color-hex-input {
  flex: 1;
  font-family: 'Monaco', 'Menlo', monospace;
}

.color-preview {
  margin-top: 0.8rem;
  padding: 1rem;
  border-radius: 8px;
  background: #f9fafb;
  border: 1px solid #e5e7eb;
  display: flex;
  gap: 0.75rem;
  align-items: center;
}

.color-preview-swatch {
  display: inline-block;
  width: 48px;
  height: 48px;
  border-radius: 6px;
  border: 1px solid #d1d5db;
  flex-shrink: 0;
}

.color-preview-btn {
  padding: 0.6rem 1.25rem;
  border-radius: 6px;
  border: 0;
  color: #fff;
  font-weight: 600;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.2s;
  flex: 1;
}

.color-preview-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

/* Checkboxes */
.checkbox-wrapper {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.checkbox-wrapper input[type="checkbox"] {
  width: 20px;
  height: 20px;
  accent-color: #0f172a;
  cursor: pointer;
  flex-shrink: 0;
}

.checkbox-wrapper label {
  cursor: pointer;
  user-select: none;
  font-weight: 500;
}

/* Grid de checks */
.checkbox-grid {
  display: grid;
  gap: 0.75rem;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
}

/* Section helper */
.settings-section-hint {
  padding: 0.75rem 1rem;
  background: #f0f9ff;
  border-left: 3px solid #0f172a;
  border-radius: 4px;
  font-size: 0.9rem;
  color: #1f2937;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.settings-section-hint strong {
  display: block;
  font-weight: 600;
  margin-bottom: 0.4rem;
}

.header-style-picker { display: grid; gap: .9rem; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); margin-top: 1rem; }
.header-style-card { display: flex; flex-direction: column; gap: .5rem; padding: 1rem; border: 2px solid #e5e7eb; border-radius: 12px; cursor: pointer; background: #fff; transition: border-color .15s, box-shadow .15s, transform .15s; }
.header-style-card:hover { border-color: #94a3b8; transform: translateY(-1px); box-shadow: 0 6px 18px rgba(15,23,42,.06); }
.header-style-card.is-active { border-color: #0f172a; box-shadow: 0 6px 18px rgba(15,23,42,.10); }
.header-style-card input { position: absolute; opacity: 0; pointer-events: none; }
.header-style-card__preview { display: block; border-radius: 8px; overflow: hidden; background: #f8fafc; }
.header-style-card__preview svg { width: 100%; height: auto; display: block; }
.header-style-card__name { font-weight: 600; font-size: .95rem; }
.header-style-card__desc { font-size: .82rem; color: #64748b; line-height: 1.4; }

/* Submit button area */
.settings-submit { margin-top: 2.5rem; padding-top: 2rem; border-top: 1px solid #e5e7eb; }

/* Tamaño del texto (escala tipográfica) */
.type-scale__val { font-weight: 700; color: #0f172a; font-variant-numeric: tabular-nums; margin-left: .25rem; }
.type-scale__range { width: 100%; accent-color: #16a34a; height: 28px; cursor: pointer; }
.type-scale__preview {
    margin-top: 1rem; padding: 1.1rem 1.25rem; border: 1px dashed #d1d5db;
    border-radius: 12px; background: #fafafa;
}
.type-scale__preview-label {
    font-size: .72rem; font-weight: 700; letter-spacing: .08em; text-transform: uppercase;
    color: #94a3b8; margin-bottom: .5rem;
}
.type-scale__prev-h { margin: 0 0 .35rem; font-weight: 800; color: #0f172a; line-height: 1.2; }
.type-scale__prev-p { margin: 0; color: #475569; line-height: 1.6; }
</style>

<form method="post">
    <input type="hidden" name="action" value="save_settings">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">

    <!-- GENERAL -->
    <div class="card">
        <h3 class="card__title">⚙️ Configuración General</h3>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Nombre del sitio</label>
                <input class="form-control" type="text" name="s[site_name]" value="<?= htmlspecialchars($settings['site_name'] ?? '') ?>" required>
                <span class="form-hint">Aparece en el navegador, meta tags y JSON-LD</span>
            </div>
            <div class="form-group">
                <label class="form-label">Zona horaria</label>
                <input class="form-control" type="text" name="s[timezone]" value="<?= htmlspecialchars($settings['timezone'] ?? 'America/Santiago') ?>">
                <span class="form-hint">Ej: America/Santiago, America/New_York</span>
            </div>
        </div>
    </div>

    <!-- COLORES DE MARCA -->
    <div class="card">
        <h3 class="card__title">🎨 Colores de Marca</h3>

        <div class="settings-section-hint">
            <strong>Qué es cada color:</strong>
            El primario se usa en botones, links y badges. El secundario en CTAs destacados (ej. WhatsApp).
        </div>

        <?php $tP = $settings['theme_primary'] ?? ''; $tS = $settings['theme_secondary'] ?? ''; ?>

        <div class="color-picker-group">
            <div class="color-picker-col">
                <label class="form-label">Color Primario</label>
                <div class="color-input-wrapper">
                    <input type="color" class="color-picker-input" name="s[theme_primary]" value="<?= htmlspecialchars($tP ?: '#0f172a') ?>" id="tp">
                    <input type="text" class="form-control color-hex-input" value="<?= htmlspecialchars($tP) ?>" placeholder="#0f172a" id="tp-hex" oninput="document.getElementById('tp').value = this.value;">
                </div>
                <div class="color-preview">
                    <span class="color-preview-swatch" id="tp-swatch" style="background:<?= htmlspecialchars($tP ?: '#0f172a') ?>;"></span>
                    <button type="button" class="color-preview-btn" id="tp-btn" style="background:<?= htmlspecialchars($tP ?: '#0f172a') ?>;">Botón primario</button>
                </div>
            </div>

            <div class="color-picker-col">
                <label class="form-label">Color Secundario</label>
                <div class="color-input-wrapper">
                    <input type="color" class="color-picker-input" name="s[theme_secondary]" value="<?= htmlspecialchars($tS ?: '#25d366') ?>" id="ts">
                    <input type="text" class="form-control color-hex-input" value="<?= htmlspecialchars($tS) ?>" placeholder="#25d366" id="ts-hex" oninput="document.getElementById('ts').value = this.value;">
                </div>
                <div class="color-preview">
                    <span class="color-preview-swatch" id="ts-swatch" style="background:<?= htmlspecialchars($tS ?: '#25d366') ?>;"></span>
                    <button type="button" class="color-preview-btn" id="ts-btn" style="background:<?= htmlspecialchars($tS ?: '#25d366') ?>;">CTA secundario</button>
                </div>
            </div>
        </div>

        <script>
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

    <!-- TAMAÑO DEL TEXTO (escala tipográfica global) -->
    <?php
        $tsHead = (int) ($settings['type_scale_headings'] ?? 100); if ($tsHead <= 0) $tsHead = 100;
        $tsBody = (int) ($settings['type_scale_body'] ?? 100);     if ($tsBody <= 0) $tsBody = 100;
        $tsHead = max(85, min(140, $tsHead));
        $tsBody = max(85, min(140, $tsBody));
    ?>
    <div class="card">
        <h3 class="card__title">🔠 Tamaño del texto</h3>

        <div class="settings-section-hint">
            Agranda (o achica) los <strong>títulos</strong> y los <strong>párrafos</strong> en todo el sitio.
            100&nbsp;% es el tamaño normal. Se aplica a todas las páginas públicas.
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Títulos <span class="type-scale__val" id="ts-head-val"><?= $tsHead ?>%</span></label>
                <input type="range" class="type-scale__range" name="s[type_scale_headings]" id="ts-head"
                       min="85" max="140" step="5" value="<?= $tsHead ?>"
                       oninput="document.getElementById('ts-head-val').textContent=this.value+'%';document.getElementById('ts-prev-h').style.fontSize=(1.6*this.value/100)+'rem';">
            </div>
            <div class="form-group">
                <label class="form-label">Párrafos <span class="type-scale__val" id="ts-body-val"><?= $tsBody ?>%</span></label>
                <input type="range" class="type-scale__range" name="s[type_scale_body]" id="ts-body"
                       min="85" max="140" step="5" value="<?= $tsBody ?>"
                       oninput="document.getElementById('ts-body-val').textContent=this.value+'%';document.getElementById('ts-prev-p').style.fontSize=(1*this.value/100)+'rem';">
            </div>
        </div>

        <div class="type-scale__preview">
            <div class="type-scale__preview-label">Vista previa</div>
            <p class="type-scale__prev-h" id="ts-prev-h" style="font-size:<?= 1.6 * $tsHead / 100 ?>rem;">Título de ejemplo</p>
            <p class="type-scale__prev-p" id="ts-prev-p" style="font-size:<?= 1 * $tsBody / 100 ?>rem;">Este es un párrafo de ejemplo para ver cómo se leería el texto de tu sitio con el tamaño elegido.</p>
        </div>
    </div>

    <!-- ANNOUNCE BAR -->
    <div class="card">
        <h3 class="card__title">📢 Barra de Anuncios (Announce Bar)</h3>

        <div class="settings-section-hint">
            Banda fina en el top del header para promos, envío gratis o avisos importantes.
        </div>

        <div class="form-group">
            <div class="checkbox-wrapper">
                <input type="checkbox" id="announce_enabled" name="s[announce_enabled]" value="1" <?= (($settings['announce_enabled'] ?? '0') === '1') ? 'checked' : '' ?>>
                <label for="announce_enabled">Mostrar announce bar</label>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">Texto principal</label>
            <input class="form-control" type="text" name="s[announce_text]" value="<?= htmlspecialchars($settings['announce_text'] ?? '') ?>" placeholder="🚚 Envío gratis en compras +$50.000">
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Texto del link (opcional)</label>
                <input class="form-control" type="text" name="s[announce_link_label]" value="<?= htmlspecialchars($settings['announce_link_label'] ?? '') ?>" placeholder="Ver condiciones">
            </div>
            <div class="form-group">
                <label class="form-label">URL del link (opcional)</label>
                <input class="form-control" type="text" name="s[announce_link_url]" value="<?= htmlspecialchars($settings['announce_link_url'] ?? '') ?>" placeholder="/envios">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Color de fondo</label>
                <input type="color" class="form-control" style="height:48px;" name="s[announce_bg]" value="<?= htmlspecialchars($settings['announce_bg'] ?: '#0f172a') ?>">
            </div>
            <div class="form-group">
                <label class="form-label">Color del texto</label>
                <input type="color" class="form-control" style="height:48px;" name="s[announce_fg]" value="<?= htmlspecialchars($settings['announce_fg'] ?: '#ffffff') ?>">
            </div>
        </div>
    </div>

    <!-- ESTILO DE CABECERA -->
    <div class="card">
        <h3 class="card__title">🎯 Estilo de Cabecera</h3>

        <div class="settings-section-hint">
            Elige el layout del header. La hamburguesa muestra el menú lateral (agencia / premium).
        </div>

        <?php $hs = $settings['header_style'] ?? 'classic'; ?>
        <div class="header-style-picker">
            <?php foreach ([
                ['key' => 'classic',   'name' => 'Clásico Moderno', 'desc' => 'Logo izquierda, menú horizontal, acciones a la derecha.',
                 'svg' => '<svg viewBox="0 0 220 56" preserveAspectRatio="none"><rect width="220" height="56" fill="#fff" stroke="#e5e7eb"/><rect x="14" y="22" width="42" height="12" rx="2" fill="#0f172a"/><rect x="86" y="26" width="20" height="4" rx="1" fill="#94a3b8"/><rect x="114" y="26" width="20" height="4" rx="1" fill="#94a3b8"/><rect x="142" y="26" width="20" height="4" rx="1" fill="#0f172a"/><circle cx="184" cy="28" r="8" fill="#f1f5f9"/><rect x="196" y="20" width="14" height="16" rx="8" fill="#25d366"/></svg>'],
                ['key' => 'centered',  'name' => 'Centrado',        'desc' => 'Logo grande arriba, menú centrado debajo.',
                 'svg' => '<svg viewBox="0 0 220 70" preserveAspectRatio="none"><rect width="220" height="70" fill="#fff" stroke="#e5e7eb"/><rect x="90" y="10" width="40" height="14" rx="2" fill="#0f172a"/><rect x="64" y="44" width="18" height="4" rx="1" fill="#94a3b8"/><rect x="90" y="44" width="18" height="4" rx="1" fill="#0f172a"/><rect x="116" y="44" width="18" height="4" rx="1" fill="#94a3b8"/><rect x="142" y="44" width="18" height="4" rx="1" fill="#94a3b8"/><circle cx="14" cy="36" r="7" fill="#f1f5f9"/><rect x="190" y="30" width="14" height="14" rx="7" fill="#25d366"/></svg>'],
                ['key' => 'hamburger', 'name' => 'Hamburguesa',     'desc' => 'Solo logo, carrito y menú. Minimalista y elegante.',
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
    </div>

    <!-- PÁGINA DE INICIO -->
    <div class="card">
        <h3 class="card__title">🏠 Página de Inicio</h3>

        <div class="settings-section-hint">
            Personaliza los textos y bloques del home. Si dejas vacío se usan los default.
        </div>

        <h4 style="margin:1.5rem 0 0.8rem; font-size:.95rem; font-weight:600; color:#1f2937;">🎬 Hero (Banner Principal)</h4>

        <div class="form-group">
            <label class="form-label">Eyebrow (pequeño arriba del título)</label>
            <input class="form-control" type="text" name="s[home_hero_eyebrow]" value="<?= htmlspecialchars($settings['home_hero_eyebrow'] ?? '') ?>" placeholder="Nueva colección">
            <span class="form-hint">Texto pequeño y destacado encima del título principal</span>
        </div>

        <div class="form-group">
            <label class="form-label">Título principal</label>
            <input class="form-control" type="text" name="s[home_hero_title]" value="<?= htmlspecialchars($settings['home_hero_title'] ?? '') ?>" placeholder="Bienvenidos a la tienda">
        </div>

        <div class="form-group">
            <label class="form-label">Subtítulo o descripción</label>
            <textarea class="form-control" name="s[home_hero_subtitle]"><?= htmlspecialchars($settings['home_hero_subtitle'] ?? '') ?></textarea>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Texto del botón principal</label>
                <input class="form-control" type="text" name="s[home_hero_cta_label]" value="<?= htmlspecialchars($settings['home_hero_cta_label'] ?? '') ?>" placeholder="Ver tienda">
            </div>
            <div class="form-group">
                <label class="form-label">URL del botón principal</label>
                <input class="form-control" type="text" name="s[home_hero_cta_url]" value="<?= htmlspecialchars($settings['home_hero_cta_url'] ?? '') ?>" placeholder="/tienda">
            </div>
        </div>

        <?php
            $sifName  = 's[home_hero_image]';
            $sifValue = (string) ($settings['home_hero_image'] ?? '');
            $sifLabel = 'Imagen de fondo (opcional, recomendado 1600×900)';
            $sifPlaceholder = '/uploads/...';
            require __DIR__ . '/_single_image_field.php';
        ?>

        <h4 style="margin:2rem 0 0.8rem; font-size:.95rem; font-weight:600; color:#1f2937;">📋 Bloques Visibles en Home</h4>
        <div class="checkbox-grid">
            <?php foreach ([
                'home_show_benefits'   => 'Beneficios (envío/pago/etc.)',
                'home_show_categories' => 'Categorías destacadas',
                'home_show_featured'   => 'Productos destacados',
                'home_show_story'      => 'Bloque de marca',
            ] as $key => $lbl): $on = ($settings[$key] ?? '1') === '1'; ?>
                <div class="checkbox-wrapper">
                    <input type="checkbox" id="<?= $key ?>" name="s[<?= $key ?>]" value="1" <?= $on ? 'checked' : '' ?>>
                    <label for="<?= $key ?>"><?= htmlspecialchars($lbl) ?></label>
                </div>
            <?php endforeach; ?>
        </div>

        <h4 style="margin:2rem 0 0.8rem; font-size:.95rem; font-weight:600; color:#1f2937;">🧱 Layout de Categorías</h4>
        <div class="settings-section-hint">
            Cómo se muestran las "Categorías destacadas" en el home.
        </div>
        <?php $cl = $settings['home_categories_layout'] ?? 'bento'; ?>
        <div class="header-style-picker">
            <?php foreach ([
                ['key' => 'bento',    'name' => 'Muro (bento)', 'desc' => 'Mosaico con un tile grande + tiles medianos. El default.',
                 'svg' => '<svg viewBox="0 0 220 90" preserveAspectRatio="none"><rect width="220" height="90" fill="#fff" stroke="#e5e7eb"/><rect x="8"  y="8"  width="100" height="74" rx="6" fill="#0f172a"/><rect x="116" y="8"  width="46"  height="34" rx="6" fill="#475569"/><rect x="170" y="8"  width="42"  height="34" rx="6" fill="#475569"/><rect x="116" y="50" width="60"  height="32" rx="6" fill="#94a3b8"/><rect x="184" y="50" width="28"  height="32" rx="6" fill="#94a3b8"/></svg>'],
                ['key' => 'grid',     'name' => 'Cuadros',      'desc' => 'Grilla uniforme: todos los tiles del mismo tamaño.',
                 'svg' => '<svg viewBox="0 0 220 90" preserveAspectRatio="none"><rect width="220" height="90" fill="#fff" stroke="#e5e7eb"/><rect x="8"   y="8"  width="48" height="34" rx="6" fill="#0f172a"/><rect x="62"  y="8"  width="48" height="34" rx="6" fill="#475569"/><rect x="116" y="8"  width="48" height="34" rx="6" fill="#0f172a"/><rect x="170" y="8"  width="42" height="34" rx="6" fill="#475569"/><rect x="8"   y="48" width="48" height="34" rx="6" fill="#94a3b8"/><rect x="62"  y="48" width="48" height="34" rx="6" fill="#0f172a"/><rect x="116" y="48" width="48" height="34" rx="6" fill="#475569"/><rect x="170" y="48" width="42" height="34" rx="6" fill="#94a3b8"/></svg>'],
                ['key' => 'carousel', 'name' => 'Carrusel infinito', 'desc' => 'Desliza horizontal con snap. Ideal para muchas categorías.',
                 'svg' => '<svg viewBox="0 0 220 90" preserveAspectRatio="none"><rect width="220" height="90" fill="#fff" stroke="#e5e7eb"/><rect x="8"   y="14" width="58" height="62" rx="6" fill="#0f172a"/><rect x="74"  y="14" width="58" height="62" rx="6" fill="#475569"/><rect x="140" y="14" width="58" height="62" rx="6" fill="#94a3b8"/><rect x="206" y="14" width="12" height="62" rx="6" fill="#cbd5e1"/><circle cx="14" cy="45" r="6" fill="#fff" stroke="#0f172a" stroke-width="1.4"/><circle cx="206" cy="45" r="6" fill="#fff" stroke="#0f172a" stroke-width="1.4"/></svg>'],
                ['key' => 'masonry',  'name' => 'Mosaico',      'desc' => 'Alturas variables tipo Pinterest. Pierde de vista la simetría.',
                 'svg' => '<svg viewBox="0 0 220 90" preserveAspectRatio="none"><rect width="220" height="90" fill="#fff" stroke="#e5e7eb"/><rect x="8"   y="8"  width="48" height="50" rx="6" fill="#0f172a"/><rect x="8"   y="62" width="48" height="20" rx="6" fill="#94a3b8"/><rect x="62"  y="8"  width="48" height="30" rx="6" fill="#475569"/><rect x="62"  y="42" width="48" height="40" rx="6" fill="#0f172a"/><rect x="116" y="8"  width="48" height="42" rx="6" fill="#94a3b8"/><rect x="116" y="54" width="48" height="28" rx="6" fill="#475569"/><rect x="170" y="8"  width="42" height="24" rx="6" fill="#0f172a"/><rect x="170" y="36" width="42" height="46" rx="6" fill="#94a3b8"/></svg>'],
            ] as $opt): ?>
                <label class="header-style-card<?= $cl === $opt['key'] ? ' is-active' : '' ?>">
                    <input type="radio" name="s[home_categories_layout]" value="<?= $opt['key'] ?>" <?= $cl === $opt['key'] ? 'checked' : '' ?>>
                    <span class="header-style-card__preview"><?= $opt['svg'] ?></span>
                    <span class="header-style-card__name"><?= htmlspecialchars($opt['name']) ?></span>
                    <span class="header-style-card__desc"><?= htmlspecialchars($opt['desc']) ?></span>
                </label>
            <?php endforeach; ?>
        </div>

        <h4 style="margin:2rem 0 0.8rem; font-size:.95rem; font-weight:600; color:#1f2937;">👥 Bloque de Marca / Storytelling</h4>

        <div class="form-group">
            <label class="form-label">Título</label>
            <input class="form-control" type="text" name="s[home_story_title]" value="<?= htmlspecialchars($settings['home_story_title'] ?? '') ?>" placeholder="Hechos con dedicación">
        </div>

        <div class="form-group">
            <label class="form-label">Texto de la historia</label>
            <textarea class="form-control" name="s[home_story_body]"><?= htmlspecialchars($settings['home_story_body'] ?? '') ?></textarea>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Texto del botón</label>
                <input class="form-control" type="text" name="s[home_story_cta_label]" value="<?= htmlspecialchars($settings['home_story_cta_label'] ?? '') ?>" placeholder="Conócenos">
            </div>
            <div class="form-group">
                <label class="form-label">URL del botón</label>
                <input class="form-control" type="text" name="s[home_story_cta_url]" value="<?= htmlspecialchars($settings['home_story_cta_url'] ?? '') ?>" placeholder="/nosotros">
            </div>
        </div>

        <?php
            $sifName  = 's[home_story_image]';
            $sifValue = (string) ($settings['home_story_image'] ?? '');
            $sifLabel = 'Imagen del bloque (recomendado 800×600)';
            $sifPlaceholder = '/uploads/...';
            require __DIR__ . '/_single_image_field.php';
        ?>

        <h4 style="margin:2rem 0 0.8rem; font-size:.95rem; font-weight:600; color:#1f2937;">📧 Banda Final (Newsletter)</h4>

        <div class="settings-section-hint">
            Banda al final del home con formulario de suscripción. Los emails quedan en Leads.
        </div>

        <div class="form-group">
            <label class="form-label">Título</label>
            <input class="form-control" type="text" name="s[home_cta_title]" value="<?= htmlspecialchars($settings['home_cta_title'] ?? '') ?>" placeholder="Suscríbete y recibe nuestras novedades">
        </div>

        <div class="form-group">
            <label class="form-label">Subtítulo o descripción</label>
            <input class="form-control" type="text" name="s[home_cta_subtitle]" value="<?= htmlspecialchars($settings['home_cta_subtitle'] ?? '') ?>" placeholder="Ofertas exclusivas, descuentos y lanzamientos en tu correo.">
        </div>

        <div class="form-group">
            <label class="form-label">Texto del botón</label>
            <input class="form-control" type="text" name="s[home_cta_label]" value="<?= htmlspecialchars($settings['home_cta_label'] ?? '') ?>" placeholder="Suscríbete">
        </div>
    </div>

    <!-- CATÁLOGO: DISPLAY DE VARIACIONES -->
    <div class="card">
        <h3 class="card__title">🧩 Variaciones de productos</h3>

        <div class="settings-section-hint">
            <strong>Cómo se muestran los atributos en la ficha del producto.</strong>
            Si tus productos tienen muchos valores por atributo (ej. 15+ tamaños),
            el desplegable evita que se desborde el layout.
        </div>

        <?php $vdm = $settings['variations_display_mode'] ?? 'swatches'; ?>
        <div class="header-style-picker">
            <?php foreach ([
                ['key' => 'swatches', 'name' => 'Botones (chips)', 'desc' => 'Cada valor como un botón. Ideal con pocos valores por atributo.',
                 'svg' => '<svg viewBox="0 0 220 90" preserveAspectRatio="none"><rect width="220" height="90" fill="#fff" stroke="#e5e7eb"/><rect x="14" y="14" width="40" height="4" rx="2" fill="#0f172a"/><rect x="14" y="26" width="38" height="22" rx="6" fill="#fff" stroke="#0f172a" stroke-width="1.6"/><rect x="58" y="26" width="38" height="22" rx="6" fill="#0f172a"/><rect x="102" y="26" width="38" height="22" rx="6" fill="#fff" stroke="#cbd5e1" stroke-width="1.6"/><rect x="146" y="26" width="38" height="22" rx="6" fill="#fff" stroke="#cbd5e1" stroke-width="1.6"/><rect x="14" y="58" width="38" height="22" rx="6" fill="#fff" stroke="#cbd5e1" stroke-width="1.6"/><rect x="58" y="58" width="38" height="22" rx="6" fill="#fff" stroke="#cbd5e1" stroke-width="1.6"/><rect x="102" y="58" width="38" height="22" rx="6" fill="#fff" stroke="#cbd5e1" stroke-width="1.6"/><rect x="146" y="58" width="38" height="22" rx="6" fill="#fff" stroke="#cbd5e1" stroke-width="1.6"/></svg>'],
                ['key' => 'select',   'name' => 'Desplegable',     'desc' => 'Un select por atributo. Compacto y ordenado con muchos valores.',
                 'svg' => '<svg viewBox="0 0 220 90" preserveAspectRatio="none"><rect width="220" height="90" fill="#fff" stroke="#e5e7eb"/><rect x="14" y="14" width="50" height="4" rx="2" fill="#0f172a"/><rect x="14" y="26" width="192" height="22" rx="6" fill="#fff" stroke="#0f172a" stroke-width="1.6"/><rect x="22" y="33" width="60" height="6" rx="2" fill="#0f172a"/><path d="M194 35 l5 6 l5 -6" stroke="#0f172a" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round"/><rect x="14" y="58" width="36" height="4" rx="2" fill="#0f172a"/><rect x="14" y="68" width="192" height="14" rx="6" fill="#fff" stroke="#cbd5e1" stroke-width="1.6"/></svg>'],
            ] as $opt): ?>
                <label class="header-style-card<?= $vdm === $opt['key'] ? ' is-active' : '' ?>">
                    <input type="radio" name="s[variations_display_mode]" value="<?= $opt['key'] ?>" <?= $vdm === $opt['key'] ? 'checked' : '' ?>>
                    <span class="header-style-card__preview"><?= $opt['svg'] ?></span>
                    <span class="header-style-card__name"><?= htmlspecialchars($opt['name']) ?></span>
                    <span class="header-style-card__desc"><?= htmlspecialchars($opt['desc']) ?></span>
                </label>
            <?php endforeach; ?>
        </div>
    </div>

    <!-- LOGO -->
    <?php
        $logoSrc  = (string) ($settings['logo_image'] ?? '');
        // Valores actuales (o default si nunca se guardaron). Deben coincidir
        // con los fallbacks de site_header.css / layout.php.
        $lhD  = (int) ($settings['logo_height_desktop']        ?? 0) ?: 82;
        $lhM  = (int) ($settings['logo_height_mobile']         ?? 0) ?: 56;
        $flhD = (int) ($settings['footer_logo_height_desktop'] ?? 0) ?: 92;
        $flhM = (int) ($settings['footer_logo_height_mobile']  ?? 0) ?: 74;
    ?>
    <style>
        .logo-size__row { display: grid; grid-template-columns: 1fr; gap: 1.1rem; margin-top: .4rem; }
        .logo-size__ctrl label { display: flex; justify-content: space-between; align-items: baseline; font-weight: 600; margin-bottom: .35rem; }
        .logo-size__val { font-variant-numeric: tabular-nums; color: #3c8a2e; font-weight: 700; }
        .logo-size input[type=range] { width: 100%; accent-color: #51af3f; }
        .logo-size__preview { margin-top: 1.1rem; }
        .logo-size__preview-label { font-size: .85rem; color: #64748b; margin-bottom: .4rem; }
        .logo-size__stage { display: flex; align-items: center; min-height: 96px; padding: 1rem 1.2rem; border: 1px dashed #cbd5e1; border-radius: 12px; background: #fff; overflow: hidden; }
        .logo-size__stage--dark { background: #0f172a; border-color: #334155; }
        .logo-size__img { width: auto; max-width: 100%; display: block; }
        .logo-size__stage--dark .logo-size__img { filter: brightness(0) invert(1); }
        .logo-size__ph { width: 150px; border-radius: 8px; background: linear-gradient(135deg,#e2e8f0,#cbd5e1); display: flex; align-items: center; justify-content: center; color: #94a3b8; font-size: .8rem; }
        .logo-size__stage--dark .logo-size__ph { background: linear-gradient(135deg,#334155,#475569); color:#cbd5e1; }
    </style>

    <div class="card">
        <h3 class="card__title">📝 Logo del Header</h3>
        <div class="settings-section-hint">
            <strong>Recomendación:</strong> PNG o SVG con fondo transparente. Se mostrará en el sidebar del admin.
        </div>
        <?php
            $sifName  = 's[logo_image]';
            $sifValue = $logoSrc;
            $sifLabel = '';
            $sifPlaceholder = '/uploads/brand/logo.png';
            require __DIR__ . '/_single_image_field.php';
        ?>

        <div class="logo-size" data-logo-size>
            <div class="settings-section-hint" style="margin-top:1rem;">
                <strong>Tamaño del logo.</strong> Ajustá el alto (en píxeles) para escritorio y celular. La vista previa se actualiza en vivo.
            </div>
            <div class="logo-size__row">
                <div class="logo-size__ctrl">
                    <label>Alto en escritorio <span><span class="logo-size__val" data-for="logo_height_desktop"><?= $lhD ?></span> px</span></label>
                    <input type="range" min="40" max="140" step="1" name="s[logo_height_desktop]" value="<?= $lhD ?>" data-logo-range data-target="desktop">
                </div>
                <div class="logo-size__ctrl">
                    <label>Alto en celular <span><span class="logo-size__val" data-for="logo_height_mobile"><?= $lhM ?></span> px</span></label>
                    <input type="range" min="28" max="90" step="1" name="s[logo_height_mobile]" value="<?= $lhM ?>" data-logo-range data-target="mobile">
                </div>
            </div>
            <div class="logo-size__preview">
                <div class="logo-size__preview-label">Vista previa (<span class="logo-size__preview-target">escritorio</span>):</div>
                <div class="logo-size__stage">
                    <?php if ($logoSrc !== ''): ?>
                        <img class="logo-size__img" src="<?= htmlspecialchars($logoSrc) ?>" alt="Vista previa del logo" style="height:<?= $lhD ?>px">
                    <?php else: ?>
                        <div class="logo-size__ph" style="height:<?= $lhD ?>px">Subí un logo para verlo</div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <h3 class="card__title">📝 Logo del Footer</h3>
        <div class="settings-section-hint">
            Usa el mismo archivo de logo (se muestra en blanco sobre el fondo oscuro del pie de página). Acá solo ajustás su tamaño.
        </div>
        <div class="logo-size" data-logo-size>
            <div class="logo-size__row">
                <div class="logo-size__ctrl">
                    <label>Alto en escritorio <span><span class="logo-size__val" data-for="footer_logo_height_desktop"><?= $flhD ?></span> px</span></label>
                    <input type="range" min="40" max="140" step="1" name="s[footer_logo_height_desktop]" value="<?= $flhD ?>" data-logo-range data-target="desktop">
                </div>
                <div class="logo-size__ctrl">
                    <label>Alto en celular <span><span class="logo-size__val" data-for="footer_logo_height_mobile"><?= $flhM ?></span> px</span></label>
                    <input type="range" min="28" max="100" step="1" name="s[footer_logo_height_mobile]" value="<?= $flhM ?>" data-logo-range data-target="mobile">
                </div>
            </div>
            <div class="logo-size__preview">
                <div class="logo-size__preview-label">Vista previa (<span class="logo-size__preview-target">escritorio</span>):</div>
                <div class="logo-size__stage logo-size__stage--dark">
                    <?php if ($logoSrc !== ''): ?>
                        <img class="logo-size__img" src="<?= htmlspecialchars($logoSrc) ?>" alt="Vista previa del logo (footer)" style="height:<?= $flhD ?>px">
                    <?php else: ?>
                        <div class="logo-size__ph" style="height:<?= $flhD ?>px">Subí un logo para verlo</div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <script>
    (function(){
        document.querySelectorAll('[data-logo-size]').forEach(function(box){
            var previewEl = box.querySelector('.logo-size__img') || box.querySelector('.logo-size__ph');
            var targetLbl = box.querySelector('.logo-size__preview-target');
            box.querySelectorAll('[data-logo-range]').forEach(function(range){
                var key = range.name.replace(/^s\[|\]$/g, '');
                var out = box.querySelector('.logo-size__val[data-for="' + key + '"]');
                function apply(updatePreview){
                    if (out) out.textContent = range.value;
                    if (updatePreview && previewEl){
                        previewEl.style.height = range.value + 'px';
                        if (targetLbl) targetLbl.textContent = range.dataset.target === 'mobile' ? 'celular' : 'escritorio';
                    }
                }
                range.addEventListener('input', function(){ apply(true); });
                apply(range.dataset.target === 'desktop'); // el de escritorio fija la vista previa inicial
            });
        });
    })();
    </script>

    <!-- IMÁGENES DE PÁGINAS INTERNAS -->
    <div class="card">
        <h3 class="card__title">🖼️ Imágenes de páginas</h3>
        <div class="settings-section-hint">
            Fotos de las páginas <strong>"Sobre GreenBags"</strong> y <strong>"Compromiso sustentable"</strong>. Cambialas acá sin tocar el HTML.
        </div>

        <div class="form-group" style="margin-bottom:1.4rem;">
            <label class="form-label" style="display:block;font-weight:600;margin-bottom:.5rem;">Imagen de "Sobre GreenBags"</label>
            <?php
                $sifName  = 's[about_media_image]';
                $sifValue = (string) ($settings['about_media_image'] ?? '');
                $sifLabel = '';
                $sifPlaceholder = '/uploads/library/greenbags/...jpg';
                require __DIR__ . '/_single_image_field.php';
            ?>
        </div>

        <div class="form-group">
            <label class="form-label" style="display:block;font-weight:600;margin-bottom:.5rem;">Imagen de "Compromiso sustentable"</label>
            <?php
                $sifName  = 's[sustentabilidad_media_image]';
                $sifValue = (string) ($settings['sustentabilidad_media_image'] ?? '');
                $sifLabel = '';
                $sifPlaceholder = '/uploads/library/greenbags/...jpg';
                require __DIR__ . '/_single_image_field.php';
            ?>
        </div>
    </div>

    <!-- NOTIFICACIONES -->
    <div class="card">
        <h3 class="card__title">💌 Notificaciones de Leads</h3>

        <div class="form-group">
            <label class="form-label">Email destino (recibe los leads)</label>
            <input class="form-control" type="email" name="s[notification_email]" value="<?= htmlspecialchars($settings['notification_email'] ?? '') ?>" placeholder="admin@tudominio.com">
            <span class="form-hint">Aquí llegarán todos los leads del formulario de contacto</span>
        </div>

        <div class="form-group">
            <label class="form-label">From: (remitente del email)</label>
            <input class="form-control" type="email" name="s[notification_from]" value="<?= htmlspecialchars($settings['notification_from'] ?? '') ?>" placeholder="no-reply@tudominio.com">
            <span class="form-hint">Debe ser un email de tu dominio para evitar spam</span>
        </div>

        <div style="border-top: 1px solid #e5e7eb; padding-top: 1.5rem; margin-top: 1.5rem;">
            <h4 style="margin:0 0 1rem; font-size:.95rem; font-weight:600; color:#1f2937;">🤖 Auto-respuesta a Leads</h4>

            <div class="checkbox-wrapper">
                <input type="checkbox" id="autoreply_enabled" name="s[autoreply_enabled]" value="1" style="width:auto;" <?= ($settings['autoreply_enabled'] ?? '0') === '1' ? 'checked' : '' ?>>
                <label for="autoreply_enabled">Enviar auto-respuesta automática</label>
            </div>

            <div class="form-group">
                <label class="form-label">Asunto de la auto-respuesta</label>
                <input class="form-control" type="text" name="s[autoreply_subject]" value="<?= htmlspecialchars($settings['autoreply_subject'] ?? '') ?>" placeholder="Hemos recibido tu mensaje">
            </div>

            <div class="form-group">
                <label class="form-label">Cuerpo de la auto-respuesta</label>
                <textarea class="form-control" name="s[autoreply_body]"><?= htmlspecialchars($settings['autoreply_body'] ?? '') ?></textarea>
                <span class="form-hint">Puedes usar: <code>{{name}}</code>, <code>{{email}}</code></span>
            </div>
        </div>
    </div>

    <!-- TRACKING -->
    <div class="card">
        <h3 class="card__title">📊 Tracking y Análisis</h3>

        <div class="form-group">
            <label class="form-label">Google Analytics ID</label>
            <input class="form-control" type="text" name="s[ga_id]" value="<?= htmlspecialchars($settings['ga_id'] ?? '') ?>" placeholder="G-XXXXXXX">
            <span class="form-hint">Ej: G-ABC123DEF456 (sin las comillas)</span>
        </div>

        <div class="form-group">
            <label class="form-label">Facebook Pixel ID</label>
            <input class="form-control" type="text" name="s[pixel_id]" value="<?= htmlspecialchars($settings['pixel_id'] ?? '') ?>" placeholder="123456789012345">
            <span class="form-hint">El ID numérico de tu Meta Pixel</span>
        </div>
    </div>

    <!-- FAVICON -->
    <?php
    $faviconPath   = trim((string) ($settings['favicon_image'] ?? ''));
    $faviconAbs    = $faviconPath ? (__DIR__ . '/../..' . $faviconPath) : '';
    $faviconExists = $faviconPath !== '' && @file_exists($faviconAbs);
    $faviconHref   = $faviconExists ? ($faviconPath . '?v=' . @filemtime($faviconAbs)) : '';
    ?>
    <div class="card">
        <h3 class="card__title">🔗 Favicon</h3>
        <div class="settings-section-hint">
            El ícono que aparece en la pestaña del navegador. PNG, SVG o ICO (recomendado: PNG 512×512).
        </div>

        <div style="display:flex;gap:1.5rem;align-items:center;flex-wrap:wrap;margin-bottom:1.5rem;">
            <div style="width:72px;height:72px;border:2px solid #e5e7eb;background:#f9fafb;display:flex;align-items:center;justify-content:center;border-radius:8px;flex-shrink:0;">
                <?php if ($faviconExists): ?>
                    <img src="<?= htmlspecialchars($faviconHref) ?>" alt="" style="max-width:100%;max-height:100%;object-fit:contain;">
                <?php else: ?>
                    <span style="font-size:.75rem;color:#9ca3af;">Sin favicon</span>
                <?php endif; ?>
            </div>

            <?php /* OJO: los <form> de favicon NO pueden anidarse dentro del form
                     principal de settings (HTML5 cierra el form padre al ver un
                     form anidado y rompe el botón "Guardar todos los cambios").
                     Por eso los inputs/botones usan el atributo HTML5 form="..."
                     para asociarse a forms declarados fuera, al final del archivo. */ ?>
            <div style="display:flex;gap:.75rem;align-items:center;flex-wrap:wrap;">
                <input type="file" name="favicon" form="favicon-upload-form" accept="image/png,image/svg+xml,image/x-icon,.png,.svg,.ico" required>
                <button type="submit" class="btn" form="favicon-upload-form">Subir favicon</button>
            </div>

            <?php if ($faviconExists): ?>
                <button type="submit" class="btn btn--ghost" form="favicon-remove-form" onclick="return confirm('¿Eliminar el favicon actual?');">Eliminar</button>
            <?php endif; ?>
        </div>

        <?php if ($faviconExists): ?>
            <div style="padding:.75rem 1rem; background:#f0f9ff; border-radius:6px; border-left:3px solid #0f172a;">
                <span style="font-size:.85rem;color:#1f2937;">Archivo actual: <code style="background:#fff;padding:.2rem .4rem;border-radius:3px;font-family:monospace;"><?= htmlspecialchars($faviconPath) ?></code></span>
            </div>
        <?php endif; ?>
    </div>

    <!-- SUBMIT -->
    <div class="settings-submit">
        <button type="submit" class="btn" style="padding: 0.85rem 2rem; font-size: 0.95rem; font-weight: 600;">Guardar todos los cambios</button>
    </div>
</form>

<?php /* Forms del favicon, declarados fuera del form principal de settings.
         Los inputs/botones del bloque favicon se asocian con form="<id>". */ ?>
<form id="favicon-upload-form" method="post" enctype="multipart/form-data" style="display:none;">
    <input type="hidden" name="action" value="favicon_upload">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
</form>
<?php if ($faviconExists): ?>
<form id="favicon-remove-form" method="post" style="display:none;">
    <input type="hidden" name="action" value="favicon_remove">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
</form>
<?php endif; ?>

<script>
// Activación visual de los radio-cards (header, layout de categorías, etc.)
// Limita el toggle a los cards del MISMO picker para que no se desactiven
// los de otro grupo en la misma página.
(function(){
    document.querySelectorAll('.header-style-card input[type="radio"]').forEach(function(r){
        r.addEventListener('change', function(){
            var picker = r.closest('.header-style-picker');
            if (!picker) return;
            picker.querySelectorAll('.header-style-card').forEach(function(c){ c.classList.remove('is-active'); });
            r.closest('.header-style-card').classList.add('is-active');
        });
    });
})();
</script>
