<?php
/** Requiere: $banner (?array), $allMedia (array) */
$isNew = !$banner;
$b = $banner ?? [
    'id' => 0, 'eyebrow' => '', 'title' => '', 'subtitle' => '',
    'image_id' => null, 'image_path' => '',
    'cta_label' => '', 'cta_url' => '', 'text_align' => 'left',
    'overlay_left' => 86, 'overlay_right' => 55,
    'sort_order' => 0, 'is_active' => 1,
];
$ovL = isset($b['overlay_left'])  ? (int) $b['overlay_left']  : 86;
$ovR = isset($b['overlay_right']) ? (int) $b['overlay_right'] : 55;
?>
<header class="admin-header">
    <div>
        <div style="margin-bottom:.3rem;"><a href="/admin/?view=banners" class="text-muted" style="font-size:.88rem;">← Volver a banners</a></div>
        <h1><?= $isNew ? '🎬 Nuevo banner' : '🎬 Editar banner' ?></h1>
        <div class="admin-header__sub">Edita el contenido, imagen y CTA del banner principal del home.</div>
    </div>
</header>

<?php if ($msg = flashGet('banner_err')): ?>
    <div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

<style>
/* Modernización de formularios — banner_edit */
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
  min-height: 80px;
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

.form-required {
  color: #dc2626;
  font-weight: 700;
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

/* Checkboxes */
.checkbox-wrapper {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.85rem 1rem;
  background: #f9fafb;
  border: 2px solid #e5e7eb;
  border-radius: 8px;
  transition: all 0.2s;
}

.checkbox-wrapper:hover {
  border-color: #d1d5db;
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
  margin: 0;
  flex: 1;
}

/* Selector de alineación tipo cards */
.align-picker { display: grid; gap: .8rem; grid-template-columns: repeat(3, 1fr); margin-top: .25rem; }
.align-card { display: flex; flex-direction: column; align-items: center; gap: .5rem; padding: 1rem; border: 2px solid #e5e7eb; border-radius: 10px; cursor: pointer; background: #fff; transition: all .15s; text-align: center; }
.align-card:hover { border-color: #94a3b8; transform: translateY(-1px); box-shadow: 0 6px 18px rgba(15,23,42,.06); }
.align-card.is-active { border-color: #0f172a; box-shadow: 0 6px 18px rgba(15,23,42,.10); background: #f8fafc; }
.align-card input { position: absolute; opacity: 0; pointer-events: none; }
.align-card svg { width: 32px; height: 32px; color: #475569; }
.align-card.is-active svg { color: #0f172a; }
.align-card__name { font-weight: 600; font-size: .88rem; color: #1f2937; }

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

/* Footer con acciones */
.banner-actions {
  margin-top: 2rem;
  padding-top: 1.75rem;
  border-top: 1px solid #e5e7eb;
  display: flex;
  gap: 0.75rem;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.banner-actions__primary {
  padding: 0.85rem 2rem;
  font-size: 0.95rem;
  font-weight: 600;
}

/* Overlay opacity controls */
.overlay-preview {
  width: 100%;
  aspect-ratio: 21 / 9;
  border-radius: 10px;
  overflow: hidden;
  background: #1e293b;
  border: 2px solid #e5e7eb;
  position: relative;
}
.overlay-preview__image {
  width: 100%; height: 100%;
  background-color: #1e293b;
  background-position: center;
  background-size: cover;
  background-repeat: no-repeat;
  background-image:
    linear-gradient(135deg,
      rgba(15, 23, 42, var(--ov-l, .86)),
      rgba(15, 23, 42, var(--ov-r, .55))),
    var(--ov-img, none);
}
.overlay-value {
  display: inline-block;
  margin-left: .35rem;
  padding: 0 .5rem;
  font-size: .8rem;
  font-weight: 700;
  color: #1f2937;
  background: #e5e7eb;
  border-radius: 999px;
  min-width: 36px;
  text-align: center;
}
.overlay-slider {
  width: 100%;
  margin: .6rem 0 .25rem;
  -webkit-appearance: none;
  appearance: none;
  height: 6px;
  background: #e5e7eb;
  border-radius: 999px;
  outline: none;
}
.overlay-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 22px; height: 22px;
  border-radius: 50%;
  background: #0f172a;
  cursor: pointer;
  box-shadow: 0 2px 6px rgba(15,23,42,.3);
  transition: transform .15s;
}
.overlay-slider::-webkit-slider-thumb:hover { transform: scale(1.1); }
.overlay-slider::-moz-range-thumb {
  width: 22px; height: 22px;
  border-radius: 50%;
  background: #0f172a;
  border: none;
  cursor: pointer;
  box-shadow: 0 2px 6px rgba(15,23,42,.3);
}
</style>

<form method="post">
    <input type="hidden" name="action" value="banner_save">
    <input type="hidden" name="id" value="<?= (int) $b['id'] ?>">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">

    <!-- CONTENIDO -->
    <div class="card">
        <h3 class="card__title">📝 Contenido</h3>

        <div class="form-group">
            <label class="form-label">Eyebrow <small class="text-muted" style="font-weight:400;">(texto pequeño arriba del título)</small></label>
            <input class="form-control" name="eyebrow" maxlength="120" value="<?= htmlspecialchars((string) ($b['eyebrow'] ?? '')) ?>" placeholder="Nueva colección">
            <span class="form-hint">Texto corto destacado encima del título principal. Opcional.</span>
        </div>

        <div class="form-group">
            <label class="form-label">Título <span class="form-required">*</span></label>
            <input class="form-control" name="title" maxlength="200" required value="<?= htmlspecialchars((string) $b['title']) ?>" placeholder="Verano 2026">
            <span class="form-hint">El título principal grande del banner. Obligatorio.</span>
        </div>

        <div class="form-group">
            <label class="form-label">Subtítulo</label>
            <textarea class="form-control" name="subtitle" rows="3" maxlength="400" placeholder="Descripción breve o frases separadas por puntos…"><?= htmlspecialchars((string) ($b['subtitle'] ?? '')) ?></textarea>
            <span class="form-hint">Descripción debajo del título. Opcional.</span>
        </div>
    </div>

    <!-- IMAGEN -->
    <div class="card">
        <h3 class="card__title">🖼️ Imagen de fondo</h3>
        <div class="settings-section-hint">
            <strong>Opcional</strong>
            Si no se asigna, el banner usa el gradient oscuro por defecto. Recomendado: imagen horizontal 1600×900px.
        </div>
        <?php
            $sifName  = 'image_id';
            $sifValue = (string) ($b['image_id'] ?? '');
            $sifLabel = '';
            $sifPlaceholder = '';
            require __DIR__ . '/_single_image_field.php';
        ?>
    </div>

    <!-- CTA -->
    <div class="card">
        <h3 class="card__title">🔘 Botón (CTA)</h3>
        <div class="settings-section-hint">
            Botón principal del banner. Si dejas ambos vacíos, no se mostrará el botón.
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Texto del botón</label>
                <input class="form-control" name="cta_label" maxlength="80" value="<?= htmlspecialchars((string) ($b['cta_label'] ?? '')) ?>" placeholder="Ver colección">
            </div>
            <div class="form-group">
                <label class="form-label">URL del botón</label>
                <input class="form-control" name="cta_url" maxlength="255" value="<?= htmlspecialchars((string) ($b['cta_url'] ?? '')) ?>" placeholder="/tienda">
                <span class="form-hint">Ruta interna (ej: /tienda) o URL completa.</span>
            </div>
        </div>
    </div>

    <!-- DISEÑO -->
    <div class="card">
        <h3 class="card__title">🎨 Diseño</h3>

        <div class="form-group">
            <label class="form-label">Alineación del texto</label>
            <?php $ta = $b['text_align'] ?? 'left'; ?>
            <div class="align-picker">
                <?php foreach ([
                    ['key' => 'left',   'name' => 'Izquierda', 'svg' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="15" y2="12"/><line x1="3" y1="18" x2="18" y2="18"/></svg>'],
                    ['key' => 'center', 'name' => 'Centrada',  'svg' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><line x1="3" y1="6" x2="21" y2="6"/><line x1="6" y1="12" x2="18" y2="12"/><line x1="4" y1="18" x2="20" y2="18"/></svg>'],
                    ['key' => 'right',  'name' => 'Derecha',   'svg' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><line x1="3" y1="6" x2="21" y2="6"/><line x1="9" y1="12" x2="21" y2="12"/><line x1="6" y1="18" x2="21" y2="18"/></svg>'],
                ] as $opt): ?>
                    <label class="align-card<?= $ta === $opt['key'] ? ' is-active' : '' ?>">
                        <input type="radio" name="text_align" value="<?= $opt['key'] ?>" <?= $ta === $opt['key'] ? 'checked' : '' ?>>
                        <?= $opt['svg'] ?>
                        <span class="align-card__name"><?= htmlspecialchars($opt['name']) ?></span>
                    </label>
                <?php endforeach; ?>
            </div>
        </div>

        <!-- OVERLAY OPACIDAD -->
        <div class="form-group" style="margin-top: 2rem;">
            <label class="form-label">Opacidad del overlay sobre la imagen</label>
            <span class="form-hint" style="margin-bottom: 1rem;">
                Sombra oscura que va sobre la imagen para que el texto se lea. Bajalo del lado donde
                querés que se vea más la imagen.
            </span>

            <?php $previewImg = trim((string) ($b['image_path'] ?? '')); ?>
            <div class="overlay-preview" aria-hidden="true">
                <div class="overlay-preview__image" id="overlay-preview-image"
                     style="--ov-l: <?= $ovL / 100 ?>; --ov-r: <?= $ovR / 100 ?>; <?php if ($previewImg): ?>--ov-img: url('<?= htmlspecialchars($previewImg) ?>');<?php endif; ?>"></div>
                <?php if (!$previewImg): ?>
                    <div style="position:absolute;inset:0;display:flex;align-items:center;justify-content:center;color:#94a3b8;font-size:.85rem;pointer-events:none;">
                        Asigná una imagen para ver la preview real
                    </div>
                <?php endif; ?>
            </div>

            <div class="form-row" style="margin-top: 1rem;">
                <div class="form-group" style="margin: 0;">
                    <label class="form-label" for="overlay_left">Izquierda (%)
                        <span class="overlay-value" id="overlay_left_val"><?= $ovL ?></span>
                    </label>
                    <input type="range" id="overlay_left" name="overlay_left"
                           min="0" max="100" step="1" value="<?= $ovL ?>"
                           class="overlay-slider" data-side="left">
                    <span class="form-hint">Típicamente alto (80-90) para que el texto se lea.</span>
                </div>
                <div class="form-group" style="margin: 0;">
                    <label class="form-label" for="overlay_right">Derecha (%)
                        <span class="overlay-value" id="overlay_right_val"><?= $ovR ?></span>
                    </label>
                    <input type="range" id="overlay_right" name="overlay_right"
                           min="0" max="100" step="1" value="<?= $ovR ?>"
                           class="overlay-slider" data-side="right">
                    <span class="form-hint">Bajalo (0-30) si querés mostrar más la imagen del lado derecho.</span>
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Orden de aparición</label>
                <input class="form-control" type="number" name="sort_order" value="<?= (int) $b['sort_order'] ?>" min="0">
                <span class="form-hint">Menor número aparece antes. Si hay un solo banner, déjalo en 0.</span>
            </div>
            <div class="form-group">
                <label class="form-label">Visibilidad</label>
                <div class="checkbox-wrapper">
                    <input type="checkbox" id="is_active" name="is_active" value="1" <?= (int) $b['is_active'] === 1 ? 'checked' : '' ?>>
                    <label for="is_active">Banner activo (visible en la home)</label>
                </div>
            </div>
        </div>
    </div>

    <!-- ACCIONES -->
    <div class="banner-actions">
        <button type="submit" class="btn banner-actions__primary">Guardar banner</button>
        <?php if (!$isNew): ?>
            <form method="post" style="margin:0;" onsubmit="return confirm('¿Eliminar este banner? La acción no se puede deshacer.');">
                <input type="hidden" name="action" value="banner_delete">
                <input type="hidden" name="id" value="<?= (int) $b['id'] ?>">
                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                <button type="submit" class="btn btn--danger">Eliminar banner</button>
            </form>
        <?php endif; ?>
    </div>
</form>

<script>
// Selector de alineación
(function(){
    document.querySelectorAll('.align-card input[type="radio"]').forEach(function(r){
        r.addEventListener('change', function(){
            document.querySelectorAll('.align-card').forEach(function(c){ c.classList.remove('is-active'); });
            r.closest('.align-card').classList.add('is-active');
        });
    });
})();

// Overlay opacity: actualiza preview + valor numérico en vivo.
(function(){
    var preview = document.getElementById('overlay-preview-image');
    var sliders = document.querySelectorAll('.overlay-slider');
    if (!preview || !sliders.length) return;

    function applyFrom(slider){
        var side = slider.dataset.side; // 'left' | 'right'
        var val  = parseInt(slider.value, 10) || 0;
        var lbl  = document.getElementById('overlay_' + side + '_val');
        if (lbl) lbl.textContent = val;
        preview.style.setProperty(side === 'left' ? '--ov-l' : '--ov-r', (val / 100).toString());
    }

    sliders.forEach(function(s){
        s.addEventListener('input', function(){ applyFrom(s); });
    });
})();
</script>
