<?php
/** Requiere: $product (record|null), $productCatIds, $productImageIds,
 *  $allCategoryOptions, $allMedia, $productOptions, $productVariationsList */
$isNew = empty($product['id']);
$err   = flashGet('shop_err');
$v     = fn(string $k, $d = '') => htmlspecialchars((string) ($product[$k] ?? $d));
$type  = $product['type'] ?? 'simple';
$productOptions = $productOptions ?? [];
$productVariationsList = $productVariationsList ?? [];
$productTiers = $productTiers ?? [];
$productVideos = $productVideos ?? [];
// Para el editor: al menos una fila de opción si es variable y no hay ninguna.
$editorOptions = $productOptions;
if ($type === 'variable' && !$editorOptions) $editorOptions = [['name' => '', 'values' => []]];
?>
<header class="admin-header">
    <div>
        <div style="margin-bottom:.3rem;"><a href="/admin/?view=products" class="text-muted" style="font-size:.88rem;">← Volver a productos</a></div>
        <h1><?= $isNew ? '📦 Nuevo producto' : '📦 Editar producto' ?></h1>
        <?php if (!$isNew): ?>
            <div class="admin-header__sub">/producto/<?= $v('slug') ?> · <a href="/producto/<?= $v('slug') ?>" target="_blank" rel="noopener">ver en el sitio →</a></div>
        <?php else: ?>
            <div class="admin-header__sub">Completá los datos del producto. Los campos con * son obligatorios.</div>
        <?php endif; ?>
    </div>
</header>

<?php if ($err): ?><div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($err) ?></span></div><?php endif; ?>

<style>
/* Modernización del editor de productos */
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
  line-height: 1.5;
}

textarea.form-control--mono {
  font-family: 'Monaco', 'Menlo', monospace;
  font-size: 0.88rem;
}

select.form-control {
  cursor: pointer;
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
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
}

.form-row--full { grid-template-columns: 1fr; }

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

.checkbox-wrapper:hover { border-color: #d1d5db; }

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

/* Hint informativo */
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

/* Selector simple/variable tipo cards */
.type-picker { display: grid; gap: .9rem; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); }
.type-card { display: flex; gap: .8rem; align-items: flex-start; padding: 1.1rem 1.2rem; border: 2px solid #e5e7eb; border-radius: 12px; cursor: pointer; background: #fff; transition: all .15s; }
.type-card:hover { border-color: #94a3b8; transform: translateY(-1px); box-shadow: 0 6px 18px rgba(15,23,42,.06); }
.type-card.is-active { border-color: #0f172a; box-shadow: 0 6px 18px rgba(15,23,42,.10); background: #f8fafc; }
.type-card input { position: absolute; opacity: 0; pointer-events: none; }
.type-card__icon { font-size: 1.6rem; line-height: 1; flex-shrink: 0; }
.type-card__body { display: flex; flex-direction: column; gap: .2rem; }
.type-card__name { font-weight: 600; font-size: .98rem; color: #1f2937; }
.type-card__desc { font-size: .82rem; color: #64748b; line-height: 1.4; }

/* Grid de checkboxes para categorías */
.shop-checkgrid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 0.6rem;
}

.shop-check {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  padding: 0.6rem 0.85rem;
  background: #fff;
  border: 2px solid #e5e7eb;
  border-radius: 8px;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.15s;
}

.shop-check:hover { border-color: #94a3b8; }
.shop-check input { width: auto; accent-color: #0f172a; }
.shop-check:has(input:checked) { border-color: #0f172a; background: #f8fafc; }

/* Picker de imágenes */
.shop-imgpick {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  gap: 0.6rem;
}

.shop-imgpick__item {
  position: relative;
  cursor: pointer;
  border: 2px solid #e5e7eb;
  border-radius: 10px;
  overflow: hidden;
  aspect-ratio: 1;
  display: block;
  transition: all 0.15s;
}

.shop-imgpick__item:hover { border-color: #94a3b8; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,.08); }
.shop-imgpick__item img { width: 100%; height: 100%; object-fit: cover; display: block; }
.shop-imgpick__item.is-on { border-color: #0f172a; box-shadow: 0 4px 12px rgba(15,23,42,.18); }
.shop-imgpick__item input { position: absolute; top: 6px; left: 6px; width: 20px; height: 20px; z-index: 2; accent-color: #0f172a; }

/* Filas dinámicas (opciones, tiers, videos) */
.dyn-row {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 0.6rem;
  align-items: center;
  flex-wrap: wrap;
}

.dyn-row .form-control { padding: 0.55rem 0.75rem; font-size: 0.9rem; }
.dyn-row__span { color: #6b7280; font-size: 0.88rem; }
.dyn-row__del {
  flex-shrink: 0;
  background: transparent;
  border: 2px solid #fecaca;
  color: #a02a2a;
  padding: 0.4rem 0.7rem;
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  font-size: 1rem;
  line-height: 1;
}
.dyn-row__del:hover { background: #fee2e2; }

.opt-row .opt-name { width: 200px; flex-shrink: 0; }
.opt-row .opt-vals { flex: 1; min-width: 200px; }

.tier-row .tier-input { width: 130px; }
.video-row .video-url { flex: 1; min-width: 240px; }

.dyn-add-btn {
  margin-top: 0.5rem;
  padding: 0.55rem 1rem;
  font-size: 0.88rem;
  font-weight: 600;
}

/* Tabla de variaciones */
.shop-vartable {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.88rem;
}
.shop-vartable th, .shop-vartable td {
  padding: 0.65rem 0.7rem;
  text-align: left;
  border-bottom: 1px solid #eef0f2;
  vertical-align: middle;
}
.shop-vartable thead th {
  font-size: 0.74rem;
  text-transform: uppercase;
  letter-spacing: 0.04em;
  color: #6b7280;
  background: #f9fafb;
  font-weight: 600;
}
.shop-vartable input, .shop-vartable select {
  padding: 0.45rem 0.55rem;
  border: 1.5px solid #d1d5db;
  border-radius: 6px;
  font: inherit;
  font-size: 0.84rem;
  background: #fff;
}
.shop-vartable input:focus, .shop-vartable select:focus {
  outline: 0;
  border-color: #0f172a;
}

/* Toggle simple/variable */
.when-variable { display: none; }
.ptype-variable .when-variable { display: block; }
.ptype-variable .when-simple { display: none; }
.card__title .when-simple, .card__title .when-variable { display: inline; }
.ptype-wrap .card__title .when-variable { display: none; }
.ptype-variable .card__title .when-variable { display: inline; }
.ptype-variable .card__title .when-simple { display: none; }

/* Footer */
.product-actions {
  margin-top: 2rem;
  padding-top: 1.75rem;
  border-top: 1px solid #e5e7eb;
  display: flex;
  gap: 0.75rem;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.product-actions__primary {
  padding: 0.85rem 2rem;
  font-size: 0.95rem;
  font-weight: 600;
}
</style>

<div class="ptype-wrap ptype-<?= htmlspecialchars($type) ?>" id="ptype-wrap">
<form method="post">
    <input type="hidden" name="action" value="product_save">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
    <input type="hidden" name="id" value="<?= (int) ($product['id'] ?? 0) ?>">

    <!-- TIPO -->
    <div class="card">
        <h3 class="card__title">🧩 Tipo de producto</h3>
        <div class="settings-section-hint">
            Elegí <strong style="display:inline;">Simple</strong> para un único precio y stock, o <strong style="display:inline;">Variable</strong> si tiene talles/colores con stock por combinación.
        </div>
        <div class="type-picker">
            <label class="type-card<?= $type !== 'variable' ? ' is-active' : '' ?>">
                <input type="radio" name="type" value="simple" <?= $type !== 'variable' ? 'checked' : '' ?>>
                <span class="type-card__icon">📦</span>
                <span class="type-card__body">
                    <span class="type-card__name">Simple</span>
                    <span class="type-card__desc">Un único precio y stock. Ideal para productos sin variantes.</span>
                </span>
            </label>
            <label class="type-card<?= $type === 'variable' ? ' is-active' : '' ?>">
                <input type="radio" name="type" value="variable" <?= $type === 'variable' ? 'checked' : '' ?>>
                <span class="type-card__icon">🎨</span>
                <span class="type-card__body">
                    <span class="type-card__name">Variable</span>
                    <span class="type-card__desc">Combinaciones (color/talle) con precio y stock propios.</span>
                </span>
            </label>
        </div>
    </div>

    <!-- DATOS BÁSICOS -->
    <div class="card">
        <h3 class="card__title">📝 Datos básicos</h3>

        <div class="form-group">
            <label class="form-label">Nombre del producto <span class="form-required">*</span></label>
            <input class="form-control" name="name" value="<?= $v('name') ?>" required placeholder="Ej: Bolsa kraft sustentable">
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">SKU</label>
                <input class="form-control" name="sku" value="<?= $v('sku') ?>" placeholder="opcional">
                <span class="form-hint">Código interno único. Útil para inventario.</span>
            </div>
            <div class="form-group">
                <label class="form-label">Slug (URL)</label>
                <input class="form-control" name="slug" value="<?= $v('slug') ?>" pattern="[a-z0-9-]*" placeholder="se-genera-solo">
                <span class="form-hint">Si lo dejas vacío, se genera desde el nombre.</span>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">Marca</label>
            <input class="form-control" name="brand" value="<?= $v('brand') ?>" placeholder="opcional">
        </div>

        <div class="form-group">
            <label class="form-label">Descripción corta</label>
            <input class="form-control" name="short_description" maxlength="500" value="<?= $v('short_description') ?>" placeholder="Una línea que resume el producto">
            <span class="form-hint">Aparece en listados y resultados de búsqueda.</span>
        </div>

        <div class="form-group">
            <label class="form-label">Descripción completa</label>
            <textarea class="form-control form-control--mono" name="description" rows="8" placeholder="Descripción larga, HTML permitido…"><?= htmlspecialchars((string) ($product['description'] ?? '')) ?></textarea>
            <span class="form-hint">HTML permitido. Aparece en la página del producto.</span>
        </div>
    </div>

    <!-- PRECIO -->
    <div class="card">
        <h3 class="card__title">
            💰 <span class="when-simple">Precio</span><span class="when-variable">Precio base <small class="text-muted" style="font-weight:400;">(referencia; el real va por variación)</small></span>
        </h3>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Precio (CLP) <span class="form-required">*</span></label>
                <input class="form-control" type="number" step="1" min="0" name="price" value="<?= htmlspecialchars((string) ($product['price'] ?? '0')) ?>" required>
            </div>
            <div class="form-group when-simple">
                <label class="form-label">Precio de oferta <small class="text-muted" style="font-weight:400;">(opcional)</small></label>
                <input class="form-control" type="number" step="1" min="0" name="sale_price" value="<?= $product && $product['sale_price'] !== null ? htmlspecialchars((string) $product['sale_price']) : '' ?>" placeholder="Sin oferta">
                <span class="form-hint">Si lo dejas vacío, no hay oferta activa.</span>
            </div>
        </div>

        <div class="form-row when-simple">
            <div class="form-group">
                <label class="form-label">Oferta desde</label>
                <input class="form-control" type="datetime-local" name="sale_starts_at" value="<?= $product && $product['sale_starts_at'] ? htmlspecialchars(str_replace(' ', 'T', substr((string) $product['sale_starts_at'], 0, 16))) : '' ?>">
            </div>
            <div class="form-group">
                <label class="form-label">Oferta hasta</label>
                <input class="form-control" type="datetime-local" name="sale_ends_at" value="<?= $product && $product['sale_ends_at'] ? htmlspecialchars(str_replace(' ', 'T', substr((string) $product['sale_ends_at'], 0, 16))) : '' ?>">
            </div>
        </div>
    </div>

    <!-- INVENTARIO (solo simple) -->
    <div class="card when-simple">
        <h3 class="card__title">📊 Inventario</h3>

        <div class="form-group">
            <div class="checkbox-wrapper">
                <input type="checkbox" id="manage_stock" name="manage_stock" value="1" <?= $isNew || (int) ($product['manage_stock'] ?? 1) === 1 ? 'checked' : '' ?>>
                <label for="manage_stock">Gestionar stock automáticamente</label>
            </div>
            <span class="form-hint">Si está desactivado, el producto siempre se considera disponible.</span>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Cantidad en stock</label>
                <input class="form-control" type="number" step="1" name="stock_qty" value="<?= htmlspecialchars((string) ($product['stock_qty'] ?? '0')) ?>">
            </div>
            <div class="form-group">
                <label class="form-label">Estado de stock</label>
                <select class="form-control" name="stock_status">
                    <?php foreach (['in_stock' => '✅ En stock', 'out_of_stock' => '❌ Sin stock', 'backorder' => '⏳ Bajo pedido'] as $k => $lbl): ?>
                        <option value="<?= $k ?>" <?= ($product['stock_status'] ?? 'in_stock') === $k ? 'selected' : '' ?>><?= $lbl ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
        </div>
    </div>

    <!-- OPCIONES (solo variable) -->
    <div class="card when-variable">
        <h3 class="card__title">🎨 Opciones <small class="text-muted" style="font-weight:400;">(ej: Color, Talle — hasta 3)</small></h3>
        <div class="settings-section-hint">
            Definí los atributos del producto y sus valores separados por coma. Al guardar se generan/actualizan las variaciones (cada combinación).
        </div>

        <div id="opt-rows">
            <?php foreach ($editorOptions as $i => $opt): ?>
                <div class="dyn-row opt-row">
                    <input class="form-control opt-name" name="options[<?= $i ?>][name]" value="<?= htmlspecialchars((string) ($opt['name'] ?? '')) ?>" placeholder="Nombre (ej: Color)">
                    <input class="form-control opt-vals" name="options[<?= $i ?>][values]" value="<?= htmlspecialchars(implode(', ', (array) ($opt['values'] ?? []))) ?>" placeholder="Valores separados por coma: Rojo, Azul, Verde">
                    <button type="button" class="dyn-row__del opt-del" title="Quitar opción">×</button>
                </div>
            <?php endforeach; ?>
        </div>
        <button type="button" class="btn btn--ghost dyn-add-btn" id="opt-add">+ Agregar opción</button>
    </div>

    <!-- CATEGORÍAS -->
    <div class="card">
        <h3 class="card__title">🗂️ Categorías</h3>
        <?php if (!$allCategoryOptions): ?>
            <div class="settings-section-hint" style="background:#fef3c7;border-left-color:#d97706;">
                No hay categorías aún. <a href="/admin/?view=category&id=new" style="color:#0f172a;font-weight:600;">Creá la primera →</a>
            </div>
        <?php else: ?>
            <div class="shop-checkgrid">
                <?php foreach ($allCategoryOptions as $cid => $label): ?>
                    <label class="shop-check">
                        <input type="checkbox" name="categories[]" value="<?= (int) $cid ?>" <?= in_array((int) $cid, $productCatIds, true) ? 'checked' : '' ?>>
                        <span><?= htmlspecialchars($label) ?></span>
                    </label>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>

    <!-- IMÁGENES -->
    <div class="card">
        <h3 class="card__title">🖼️ Imágenes <small class="text-muted" style="font-weight:400;">(la primera tildada es la principal)</small></h3>
        <?php if (!$allMedia): ?>
            <div class="settings-section-hint" style="background:#fef3c7;border-left-color:#d97706;">
                La Mediateca está vacía. <a href="/admin/?view=media" target="_blank" style="color:#0f172a;font-weight:600;">Subí imágenes →</a>
            </div>
        <?php else: ?>
            <div class="shop-imgpick">
                <?php foreach ($allMedia as $m): $mid = (int) $m['id']; ?>
                    <label class="shop-imgpick__item <?= in_array($mid, $productImageIds, true) ? 'is-on' : '' ?>">
                        <input type="checkbox" name="image_ids[]" value="<?= $mid ?>" <?= in_array($mid, $productImageIds, true) ? 'checked' : '' ?>>
                        <img src="<?= htmlspecialchars($m['thumb_path'] ?: $m['file_path']) ?>" alt="<?= htmlspecialchars($m['alt'] ?? '') ?>" loading="lazy">
                    </label>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>

    <!-- COMERCIO -->
    <div class="card">
        <h3 class="card__title">🛒 Comercio (Google Shopping / Meta)</h3>
        <div class="settings-section-hint">
            Datos para feeds de productos y catálogos publicitarios. Opcional pero recomendado si vas a hacer Ads.
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">GTIN / código de barras</label>
                <input class="form-control" name="gtin" value="<?= $v('gtin') ?>" placeholder="EAN / UPC">
            </div>
            <div class="form-group">
                <label class="form-label">MPN</label>
                <input class="form-control" name="mpn" value="<?= $v('mpn') ?>" placeholder="Código del fabricante">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Condición</label>
                <select class="form-control" name="item_condition">
                    <?php foreach (['new' => '✨ Nuevo', 'refurbished' => '🔄 Reacondicionado', 'used' => '📦 Usado'] as $k => $lbl): ?>
                        <option value="<?= $k ?>" <?= ($product['item_condition'] ?? 'new') === $k ? 'selected' : '' ?>><?= $lbl ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label">Compra mínima (unidades)</label>
                <input class="form-control" type="number" min="1" name="min_order_qty" value="<?= htmlspecialchars((string) ($product['min_order_qty'] ?? '1')) ?>">
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">Categoría de Google</label>
            <input class="form-control" name="google_category" value="<?= $v('google_category') ?>" placeholder="Apparel & Accessories > Clothing">
            <span class="form-hint">ID numérico o ruta. <a href="https://support.google.com/merchants/answer/6324436" target="_blank" rel="noopener" style="color:#0f172a;">Ver lista oficial →</a></span>
        </div>
    </div>

    <!-- PRECIOS POR MAYOR -->
    <div class="card">
        <h3 class="card__title">📈 Precios por mayor <small class="text-muted" style="font-weight:400;">(precio unitario según cantidad)</small></h3>
        <div class="settings-section-hint">
            Si compran más de X unidades, el precio unitario baja. Útil para ventas B2B y al por mayor.
        </div>

        <div id="tier-rows">
            <?php foreach ($productTiers as $i => $t): ?>
                <div class="dyn-row tier-row">
                    <span class="dyn-row__span">Desde</span>
                    <input class="form-control tier-input" type="number" min="1" name="tiers[<?= $i ?>][min_qty]" value="<?= (int) $t['min_qty'] ?>" placeholder="cant.">
                    <span class="dyn-row__span">unid. →</span>
                    <input class="form-control tier-input" type="number" min="0" name="tiers[<?= $i ?>][unit_price]" value="<?= htmlspecialchars((string) $t['unit_price']) ?>" placeholder="precio c/u">
                    <button type="button" class="dyn-row__del tier-del" title="Quitar">×</button>
                </div>
            <?php endforeach; ?>
        </div>
        <button type="button" class="btn btn--ghost dyn-add-btn" id="tier-add">+ Agregar tramo</button>
    </div>

    <!-- VIDEOS -->
    <div class="card">
        <h3 class="card__title">🎥 Videos <small class="text-muted" style="font-weight:400;">(YouTube, Vimeo o enlace .mp4 / Cloudinary)</small></h3>

        <div id="video-rows">
            <?php foreach ($productVideos as $vd): ?>
                <div class="dyn-row video-row">
                    <input type="url" class="form-control video-url" name="videos[]" value="<?= htmlspecialchars((string) $vd['url']) ?>" placeholder="https://youtu.be/...">
                    <button type="button" class="dyn-row__del video-del" title="Quitar">×</button>
                </div>
            <?php endforeach; ?>
        </div>
        <button type="button" class="btn btn--ghost dyn-add-btn" id="video-add">+ Agregar video</button>
    </div>

    <!-- SEO -->
    <div class="card">
        <h3 class="card__title">🔍 SEO y publicación</h3>
        <div class="settings-section-hint">
            Los meta tags afectan cómo aparece el producto en Google. Si los dejas vacíos se usan el nombre y la descripción corta.
        </div>

        <div class="form-group">
            <label class="form-label">Meta título</label>
            <input class="form-control" name="meta_title" maxlength="255" value="<?= $v('meta_title') ?>" placeholder="Título para Google (60-70 caracteres)">
        </div>

        <div class="form-group">
            <label class="form-label">Meta description</label>
            <input class="form-control" name="meta_description" maxlength="300" value="<?= $v('meta_description') ?>" placeholder="Descripción para Google (150-160 caracteres)">
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Estado de publicación</label>
                <select class="form-control" name="status">
                    <?php foreach (['draft' => '📝 Borrador', 'published' => '✅ Publicado', 'archived' => '📦 Archivado'] as $k => $lbl): ?>
                        <option value="<?= $k ?>" <?= ($product['status'] ?? 'draft') === $k ? 'selected' : '' ?>><?= $lbl ?></option>
                    <?php endforeach; ?>
                </select>
                <span class="form-hint">Solo los productos en "Publicado" se muestran en la tienda.</span>
            </div>
            <div class="form-group">
                <label class="form-label">Destacado</label>
                <div class="checkbox-wrapper">
                    <input type="checkbox" id="featured" name="featured" value="1" <?= !empty($product['featured']) ? 'checked' : '' ?>>
                    <label for="featured">⭐ Marcar como destacado</label>
                </div>
            </div>
        </div>
    </div>

    <!-- ACCIONES -->
    <div class="product-actions">
        <button type="submit" class="btn product-actions__primary">Guardar producto</button>
        <?php if (!$isNew): ?>
            <button type="submit" formaction="/admin/?action=product_delete" name="action" value="product_delete" class="btn btn--danger" onclick="return confirm('¿Eliminar este producto?')">Eliminar producto</button>
        <?php endif; ?>
    </div>
</form>

<?php if ($type === 'variable' && !$isNew): ?>
    <div class="card when-variable" style="margin-top:1.5rem;">
        <h3 class="card__title">🔀 Variaciones <small class="text-muted" style="font-weight:400;">(<?= count($productVariationsList) ?>)</small></h3>
        <?php if (!$productVariationsList): ?>
            <div class="settings-section-hint" style="background:#fef3c7;border-left-color:#d97706;">
                Definí las opciones arriba y guardá el producto para generar las variaciones.
            </div>
        <?php else: ?>
        <div class="settings-section-hint">
            Cada fila es una combinación de opciones. Editá precios, stock e imágenes individualmente.
        </div>
        <form method="post" action="/admin/?view=product&id=<?= (int) $product['id'] ?>">
            <input type="hidden" name="action" value="variations_save">
            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
            <input type="hidden" name="id" value="<?= (int) $product['id'] ?>">
            <div style="overflow-x:auto;">
                <table class="shop-vartable">
                    <thead><tr><th>Variación</th><th>Imagen</th><th>Precio</th><th>Oferta</th><th>Stock</th><th>Estado</th><th>SKU</th><th>GTIN</th><th>Activa</th></tr></thead>
                    <tbody>
                    <?php foreach ($productVariationsList as $vr): $vid = (int) $vr['id']; ?>
                        <tr>
                            <td><strong><?= htmlspecialchars($vr['label'] ?: '—') ?></strong></td>
                            <td><select name="variations[<?= $vid ?>][image_id]" style="width:140px;">
                                <option value="">— ninguna —</option>
                                <?php foreach ($allMedia as $m): ?>
                                    <option value="<?= (int) $m['id'] ?>" <?= (int) ($vr['image_id'] ?? 0) === (int) $m['id'] ? 'selected' : '' ?>><?= htmlspecialchars($m['alt'] ?: basename((string) $m['file_path'])) ?></option>
                                <?php endforeach; ?>
                            </select></td>
                            <td><input type="number" step="1" min="0" name="variations[<?= $vid ?>][price]" value="<?= htmlspecialchars((string) $vr['price']) ?>" style="width:100px;"></td>
                            <td><input type="number" step="1" min="0" name="variations[<?= $vid ?>][sale_price]" value="<?= $vr['sale_price'] !== null ? htmlspecialchars((string) $vr['sale_price']) : '' ?>" style="width:100px;" placeholder="—"></td>
                            <td><input type="number" step="1" name="variations[<?= $vid ?>][stock_qty]" value="<?= (int) $vr['stock_qty'] ?>" style="width:80px;"></td>
                            <td><select name="variations[<?= $vid ?>][stock_status]">
                                <?php foreach (['in_stock' => 'En stock', 'out_of_stock' => 'Sin stock', 'backorder' => 'Bajo pedido'] as $k => $lbl): ?>
                                    <option value="<?= $k ?>" <?= $vr['stock_status'] === $k ? 'selected' : '' ?>><?= $lbl ?></option>
                                <?php endforeach; ?>
                            </select></td>
                            <td><input name="variations[<?= $vid ?>][sku]" value="<?= htmlspecialchars((string) ($vr['sku'] ?? '')) ?>" style="width:110px;" placeholder="SKU"></td>
                            <td><input name="variations[<?= $vid ?>][gtin]" value="<?= htmlspecialchars((string) ($vr['gtin'] ?? '')) ?>" style="width:110px;" placeholder="GTIN"></td>
                            <td style="text-align:center;"><input type="checkbox" name="variations[<?= $vid ?>][is_active]" value="1" <?= (int) $vr['is_active'] ? 'checked' : '' ?> style="width:20px;height:20px;accent-color:#0f172a;"></td>
                        </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
            <div style="margin-top:1.25rem;"><button type="submit" class="btn">Guardar variaciones</button></div>
        </form>
        <?php endif; ?>
    </div>
<?php endif; ?>
</div>

<script>
(function(){
    var wrap = document.getElementById('ptype-wrap');
    // Toggle simple/variable + activar card del tipo
    document.querySelectorAll('input[name=type]').forEach(function(r){
        r.addEventListener('change', function(){
            wrap.className = 'ptype-wrap ptype-' + this.value;
            document.querySelectorAll('.type-card').forEach(function(c){ c.classList.remove('is-active'); });
            r.closest('.type-card').classList.add('is-active');
        });
    });

    // Editor de opciones: agregar/quitar filas (máx 3).
    var rows = document.getElementById('opt-rows');
    var addBtn = document.getElementById('opt-add');
    if (addBtn) addBtn.addEventListener('click', function(){
        var n = rows.querySelectorAll('.opt-row').length;
        if (n >= 3) { alert('Máximo 3 opciones.'); return; }
        var div = document.createElement('div');
        div.className = 'dyn-row opt-row';
        div.innerHTML = '<input class="form-control opt-name" name="options['+n+'][name]" placeholder="Nombre (ej: Talle)">'
            + '<input class="form-control opt-vals" name="options['+n+'][values]" placeholder="Valores separados por coma: S, M, L">'
            + '<button type="button" class="dyn-row__del opt-del" title="Quitar opción">×</button>';
        rows.appendChild(div);
    });
    if (rows) rows.addEventListener('click', function(e){
        var del = e.target.closest('.opt-del');
        if (del) del.closest('.opt-row').remove();
    });

    // Precios por mayor: agregar/quitar tramos.
    var tierRows = document.getElementById('tier-rows'), tierAdd = document.getElementById('tier-add');
    var tierN = tierRows ? tierRows.querySelectorAll('.tier-row').length : 0;
    if (tierAdd) tierAdd.addEventListener('click', function(){
        var d = document.createElement('div'); d.className = 'dyn-row tier-row';
        d.innerHTML = '<span class="dyn-row__span">Desde</span><input class="form-control tier-input" type="number" min="1" name="tiers['+tierN+'][min_qty]" placeholder="cant.">'
            + '<span class="dyn-row__span">unid. →</span><input class="form-control tier-input" type="number" min="0" name="tiers['+tierN+'][unit_price]" placeholder="precio c/u">'
            + '<button type="button" class="dyn-row__del tier-del" title="Quitar">×</button>';
        tierRows.appendChild(d); tierN++;
    });
    if (tierRows) tierRows.addEventListener('click', function(e){ var x = e.target.closest('.tier-del'); if (x) x.closest('.tier-row').remove(); });

    // Videos: agregar/quitar.
    var vidRows = document.getElementById('video-rows'), vidAdd = document.getElementById('video-add');
    if (vidAdd) vidAdd.addEventListener('click', function(){
        var d = document.createElement('div'); d.className = 'dyn-row video-row';
        d.innerHTML = '<input type="url" class="form-control video-url" name="videos[]" placeholder="https://youtu.be/...">'
            + '<button type="button" class="dyn-row__del video-del" title="Quitar">×</button>';
        vidRows.appendChild(d);
    });
    if (vidRows) vidRows.addEventListener('click', function(e){ var x = e.target.closest('.video-del'); if (x) x.closest('.video-row').remove(); });

    // Reflejar selección de imágenes (borde activo)
    document.addEventListener('change', function(e){
        var cb = e.target.closest('.shop-imgpick__item input[type=checkbox]');
        if (cb) cb.closest('.shop-imgpick__item').classList.toggle('is-on', cb.checked);
    });
})();
</script>
