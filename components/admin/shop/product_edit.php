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
        <h1><?= $isNew ? 'Nuevo producto' : 'Editar producto' ?></h1>
        <?php if (!$isNew): ?><div class="admin-header__sub">/producto/<?= $v('slug') ?> · <a href="/producto/<?= $v('slug') ?>" target="_blank" rel="noopener">ver →</a></div><?php endif; ?>
    </div>
</header>

<?php if ($err): ?><div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($err) ?></span></div><?php endif; ?>

<div class="ptype-wrap ptype-<?= htmlspecialchars($type) ?>" id="ptype-wrap">
<form method="post">
    <input type="hidden" name="action" value="product_save">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
    <input type="hidden" name="id" value="<?= (int) ($product['id'] ?? 0) ?>">

    <div class="card">
        <h3 class="card__title">Tipo de producto</h3>
        <div class="shop-typepick">
            <label class="shop-typepick__opt"><input type="radio" name="type" value="simple" <?= $type !== 'variable' ? 'checked' : '' ?>> <span><strong>Simple</strong><small>Un único precio y stock</small></span></label>
            <label class="shop-typepick__opt"><input type="radio" name="type" value="variable" <?= $type === 'variable' ? 'checked' : '' ?>> <span><strong>Variable</strong><small>Talles/colores con precio y stock propios</small></span></label>
        </div>
    </div>

    <div class="card">
        <h3 class="card__title">Datos básicos</h3>
        <p class="form__field"><label>Nombre <input name="name" value="<?= $v('name') ?>" required></label></p>
        <div class="shop-form__row">
            <p class="form__field"><label>SKU <input name="sku" value="<?= $v('sku') ?>" placeholder="opcional"></label></p>
            <p class="form__field"><label>Slug <small class="text-muted">(auto si vacío)</small><input name="slug" value="<?= $v('slug') ?>" pattern="[a-z0-9-]*" placeholder="se-genera-solo"></label></p>
        </div>
        <p class="form__field"><label>Marca <input name="brand" value="<?= $v('brand') ?>" placeholder="opcional"></label></p>
        <p class="form__field"><label>Descripción corta <input name="short_description" maxlength="500" value="<?= $v('short_description') ?>"></label></p>
        <p class="form__field" style="margin:0;"><label>Descripción <small class="text-muted">(HTML permitido)</small>
            <textarea name="description" rows="8" style="font-family:var(--font-family-mono);font-size:.88rem;"><?= htmlspecialchars((string) ($product['description'] ?? '')) ?></textarea>
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title"><span class="when-simple">Precio</span><span class="when-variable">Precio base <small class="text-muted">(referencia; el real va por variación)</small></span></h3>
        <div class="shop-form__row">
            <p class="form__field"><label>Precio (CLP) <input type="number" step="1" min="0" name="price" value="<?= htmlspecialchars((string) ($product['price'] ?? '0')) ?>" required></label></p>
            <p class="form__field when-simple"><label>Precio oferta <small class="text-muted">(opcional)</small><input type="number" step="1" min="0" name="sale_price" value="<?= $product && $product['sale_price'] !== null ? htmlspecialchars((string) $product['sale_price']) : '' ?>"></label></p>
        </div>
        <div class="shop-form__row when-simple">
            <p class="form__field"><label>Oferta desde <input type="datetime-local" name="sale_starts_at" value="<?= $product && $product['sale_starts_at'] ? htmlspecialchars(str_replace(' ', 'T', substr((string) $product['sale_starts_at'], 0, 16))) : '' ?>"></label></p>
            <p class="form__field"><label>Oferta hasta <input type="datetime-local" name="sale_ends_at" value="<?= $product && $product['sale_ends_at'] ? htmlspecialchars(str_replace(' ', 'T', substr((string) $product['sale_ends_at'], 0, 16))) : '' ?>"></label></p>
        </div>
    </div>

    <div class="card when-simple">
        <h3 class="card__title">Inventario</h3>
        <p class="form__field"><label style="display:flex;align-items:center;gap:.5rem;">
            <input type="checkbox" name="manage_stock" value="1" style="width:auto;" <?= $isNew || (int) ($product['manage_stock'] ?? 1) === 1 ? 'checked' : '' ?>>
            <span>Gestionar stock</span>
        </label></p>
        <div class="shop-form__row">
            <p class="form__field"><label>Cantidad en stock <input type="number" step="1" name="stock_qty" value="<?= htmlspecialchars((string) ($product['stock_qty'] ?? '0')) ?>"></label></p>
            <p class="form__field"><label>Estado de stock
                <select name="stock_status">
                    <?php foreach (['in_stock' => 'En stock', 'out_of_stock' => 'Sin stock', 'backorder' => 'Bajo pedido'] as $k => $lbl): ?>
                        <option value="<?= $k ?>" <?= ($product['stock_status'] ?? 'in_stock') === $k ? 'selected' : '' ?>><?= $lbl ?></option>
                    <?php endforeach; ?>
                </select>
            </label></p>
        </div>
    </div>

    <div class="card when-variable">
        <h3 class="card__title">Opciones <small class="text-muted">(ej: Color, Talle — hasta 3)</small></h3>
        <div id="opt-rows">
            <?php foreach ($editorOptions as $i => $opt): ?>
                <div class="opt-row">
                    <input class="opt-name" name="options[<?= $i ?>][name]" value="<?= htmlspecialchars((string) ($opt['name'] ?? '')) ?>" placeholder="Nombre (ej: Color)">
                    <input class="opt-vals" name="options[<?= $i ?>][values]" value="<?= htmlspecialchars(implode(', ', (array) ($opt['values'] ?? []))) ?>" placeholder="Valores separados por coma: Rojo, Azul">
                    <button type="button" class="btn sif__remove opt-del" title="Quitar opción">×</button>
                </div>
            <?php endforeach; ?>
        </div>
        <button type="button" class="btn btn--ghost" id="opt-add" style="margin-top:.5rem;">+ Agregar opción</button>
        <p class="text-muted" style="font-size:.82rem;margin:.7rem 0 0;">Al guardar se generan/actualizan las variaciones (cada combinación). Sus precios y stock se editan abajo.</p>
    </div>

    <div class="card">
        <h3 class="card__title">Categorías</h3>
        <?php if (!$allCategoryOptions): ?>
            <p class="text-muted">No hay categorías aún. <a href="/admin/?view=category&id=new">Creá una →</a></p>
        <?php else: ?>
            <div class="shop-checkgrid">
            <?php foreach ($allCategoryOptions as $cid => $label): ?>
                <label class="shop-check"><input type="checkbox" name="categories[]" value="<?= (int) $cid ?>" <?= in_array((int) $cid, $productCatIds, true) ? 'checked' : '' ?>> <span><?= htmlspecialchars($label) ?></span></label>
            <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>

    <div class="card">
        <h3 class="card__title">
            Imágenes <small class="text-muted">(la primera tildada es la principal)</small>
            <a href="/admin/?view=media" target="_blank" class="text-muted" style="font-size:.78rem;font-weight:400;text-decoration:none;">Abrir Central de Medios →</a>
        </h3>

        <div class="pimg-uploader" id="pimg-uploader">
            <input type="file" id="pimg-uploader-input" accept="image/jpeg,image/png,image/webp" multiple hidden>
            <div class="pimg-uploader__cta">
                <svg viewBox="0 0 24 24" width="32" height="32" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4"/><polyline points="17 8 12 3 7 8"/><line x1="12" y1="3" x2="12" y2="15"/></svg>
                <div>
                    <strong>Arrastrá imágenes acá</strong>
                    <span>o <button type="button" class="ml-link" id="pimg-uploader-pick">elegí desde tu equipo</button></span>
                    <small>JPG · PNG · WebP · hasta 10MB c/u — se convierten a WebP optimizado y quedan tildadas para este producto.</small>
                </div>
            </div>
            <div class="pimg-uploader__queue" id="pimg-uploader-queue" hidden></div>
        </div>

        <div class="shop-imgpick" id="shop-imgpick">
        <?php foreach ($allMedia as $m): $mid = (int) $m['id']; ?>
            <label class="shop-imgpick__item <?= in_array($mid, $productImageIds, true) ? 'is-on' : '' ?>">
                <input type="checkbox" name="image_ids[]" value="<?= $mid ?>" <?= in_array($mid, $productImageIds, true) ? 'checked' : '' ?>>
                <img src="<?= htmlspecialchars($m['thumb_path'] ?: $m['file_path']) ?>" alt="<?= htmlspecialchars($m['alt'] ?? '') ?>" loading="lazy">
            </label>
        <?php endforeach; ?>
        </div>
        <?php if (!$allMedia): ?>
            <p class="text-muted pimg-empty" id="pimg-empty" style="margin:.8rem 0 0;">Aún no hay imágenes en la mediateca. Subí las primeras arrastrándolas arriba.</p>
        <?php endif; ?>
    </div>

    <div class="card">
        <h3 class="card__title">Comercio (Google Shopping / Meta)</h3>
        <div class="shop-form__row">
            <p class="form__field"><label>GTIN / código de barras <input name="gtin" value="<?= $v('gtin') ?>" placeholder="EAN / UPC"></label></p>
            <p class="form__field"><label>MPN <input name="mpn" value="<?= $v('mpn') ?>" placeholder="código fabricante"></label></p>
        </div>
        <div class="shop-form__row">
            <p class="form__field"><label>Condición
                <select name="item_condition">
                    <?php foreach (['new' => 'Nuevo', 'refurbished' => 'Reacondicionado', 'used' => 'Usado'] as $k => $lbl): ?>
                        <option value="<?= $k ?>" <?= ($product['item_condition'] ?? 'new') === $k ? 'selected' : '' ?>><?= $lbl ?></option>
                    <?php endforeach; ?>
                </select></label></p>
            <p class="form__field"><label>Compra mínima (unid.) <input type="number" min="1" name="min_order_qty" value="<?= htmlspecialchars((string) ($product['min_order_qty'] ?? '1')) ?>"></label></p>
        </div>
        <p class="form__field" style="margin:0;"><label>Categoría de Google <small class="text-muted">(ID numérico o ruta)</small><input name="google_category" value="<?= $v('google_category') ?>" placeholder="Apparel &amp; Accessories &gt; Clothing"></label></p>
    </div>

    <div class="card">
        <h3 class="card__title">Precios por mayor <small class="text-muted">(precio unitario según cantidad)</small></h3>
        <div id="tier-rows">
            <?php foreach ($productTiers as $i => $t): ?>
                <div class="tier-row">
                    <span>Desde</span>
                    <input type="number" min="1" name="tiers[<?= $i ?>][min_qty]" value="<?= (int) $t['min_qty'] ?>" placeholder="cant.">
                    <span>unid. →</span>
                    <input type="number" min="0" name="tiers[<?= $i ?>][unit_price]" value="<?= htmlspecialchars((string) $t['unit_price']) ?>" placeholder="precio c/u">
                    <button type="button" class="btn sif__remove tier-del" title="Quitar">×</button>
                </div>
            <?php endforeach; ?>
        </div>
        <button type="button" class="btn btn--ghost" id="tier-add" style="margin-top:.5rem;">+ Agregar tramo</button>
    </div>

    <div class="card">
        <h3 class="card__title">Videos <small class="text-muted">(YouTube, Vimeo o enlace .mp4 / Cloudinary)</small></h3>
        <div id="video-rows">
            <?php foreach ($productVideos as $vd): ?>
                <div class="video-row">
                    <input type="url" class="video-url" name="videos[]" value="<?= htmlspecialchars((string) $vd['url']) ?>" placeholder="https://youtu.be/...">
                    <button type="button" class="btn sif__remove video-del" title="Quitar">×</button>
                </div>
            <?php endforeach; ?>
        </div>
        <button type="button" class="btn btn--ghost" id="video-add" style="margin-top:.5rem;">+ Agregar video</button>
    </div>

    <div class="card">
        <h3 class="card__title">SEO & publicación</h3>
        <p class="form__field"><label>Meta título <input name="meta_title" maxlength="255" value="<?= $v('meta_title') ?>"></label></p>
        <p class="form__field"><label>Meta description <input name="meta_description" maxlength="300" value="<?= $v('meta_description') ?>"></label></p>
        <div class="shop-form__row">
            <p class="form__field"><label>Estado
                <select name="status">
                    <?php foreach (['draft' => 'Borrador', 'published' => 'Publicado', 'archived' => 'Archivado'] as $k => $lbl): ?>
                        <option value="<?= $k ?>" <?= ($product['status'] ?? 'draft') === $k ? 'selected' : '' ?>><?= $lbl ?></option>
                    <?php endforeach; ?>
                </select>
            </label></p>
            <p class="form__field"><label style="display:flex;align-items:center;gap:.5rem;margin-top:1.8rem;">
                <input type="checkbox" name="featured" value="1" style="width:auto;" <?= !empty($product['featured']) ? 'checked' : '' ?>>
                <span>Destacado</span>
            </label></p>
        </div>
    </div>

    <div style="margin-top:1.5rem;display:flex;gap:.5rem;justify-content:space-between;align-items:center;flex-wrap:wrap;">
        <button type="submit" class="btn">Guardar producto</button>
        <?php if (!$isNew): ?>
            <button type="submit" formaction="/admin/?action=product_delete" name="action" value="product_delete" class="btn btn--danger" onclick="return confirm('¿Eliminar este producto?')">Eliminar</button>
        <?php endif; ?>
    </div>
</form>

<?php if ($type === 'variable' && !$isNew): ?>
    <div class="card when-variable" style="margin-top:1.5rem;">
        <h3 class="card__title">Variaciones <small class="text-muted">(<?= count($productVariationsList) ?>)</small></h3>
        <?php if (!$productVariationsList): ?>
            <p class="text-muted">Definí opciones arriba y guardá el producto para generar las variaciones.</p>
        <?php else: ?>
        <form method="post" action="/admin/?view=product&id=<?= (int) $product['id'] ?>">
            <input type="hidden" name="action" value="variations_save">
            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
            <input type="hidden" name="id" value="<?= (int) $product['id'] ?>">
            <div style="overflow-x:auto;">
            <table class="shop-table shop-vartable">
                <thead><tr><th>Variación</th><th>Imagen</th><th>Precio</th><th>Oferta</th><th>Stock</th><th>Estado</th><th>SKU</th><th>GTIN</th><th>Activa</th></tr></thead>
                <tbody>
                <?php foreach ($productVariationsList as $vr): $vid = (int) $vr['id']; ?>
                    <tr>
                        <td><strong><?= htmlspecialchars($vr['label'] ?: '—') ?></strong></td>
                        <td><select name="variations[<?= $vid ?>][image_id]" style="width:130px;">
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
                        <td style="text-align:center;"><input type="checkbox" name="variations[<?= $vid ?>][is_active]" value="1" <?= (int) $vr['is_active'] ? 'checked' : '' ?>></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
            </div>
            <div style="margin-top:1rem;"><button type="submit" class="btn">Guardar variaciones</button></div>
        </form>
        <?php endif; ?>
    </div>
<?php endif; ?>
</div>

<script>
(function(){
    var wrap = document.getElementById('ptype-wrap');
    document.querySelectorAll('input[name=type]').forEach(function(r){
        r.addEventListener('change', function(){ wrap.className = 'ptype-wrap ptype-' + this.value; });
    });
    // Editor de opciones: agregar/quitar filas (máx 3).
    var rows = document.getElementById('opt-rows');
    var addBtn = document.getElementById('opt-add');
    if (addBtn) addBtn.addEventListener('click', function(){
        var n = rows.querySelectorAll('.opt-row').length;
        if (n >= 3) { alert('Máximo 3 opciones.'); return; }
        var div = document.createElement('div');
        div.className = 'opt-row';
        div.innerHTML = '<input class="opt-name" name="options['+n+'][name]" placeholder="Nombre (ej: Talle)">'
            + '<input class="opt-vals" name="options['+n+'][values]" placeholder="Valores separados por coma: S, M, L">'
            + '<button type="button" class="btn sif__remove opt-del" title="Quitar opción">×</button>';
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
        var d = document.createElement('div'); d.className = 'tier-row';
        d.innerHTML = '<span>Desde</span><input type="number" min="1" name="tiers['+tierN+'][min_qty]" placeholder="cant.">'
            + '<span>unid. →</span><input type="number" min="0" name="tiers['+tierN+'][unit_price]" placeholder="precio c/u">'
            + '<button type="button" class="btn sif__remove tier-del" title="Quitar">×</button>';
        tierRows.appendChild(d); tierN++;
    });
    if (tierRows) tierRows.addEventListener('click', function(e){ var x = e.target.closest('.tier-del'); if (x) x.closest('.tier-row').remove(); });
    // Videos: agregar/quitar.
    var vidRows = document.getElementById('video-rows'), vidAdd = document.getElementById('video-add');
    if (vidAdd) vidAdd.addEventListener('click', function(){
        var d = document.createElement('div'); d.className = 'video-row';
        d.innerHTML = '<input type="url" class="video-url" name="videos[]" placeholder="https://youtu.be/...">'
            + '<button type="button" class="btn sif__remove video-del" title="Quitar">×</button>';
        vidRows.appendChild(d);
    });
    if (vidRows) vidRows.addEventListener('click', function(e){ var x = e.target.closest('.video-del'); if (x) x.closest('.video-row').remove(); });

    // Uploader directo de imágenes (sube a Mediateca via JSON y agrega tildada al grid).
    var pup = document.getElementById('pimg-uploader');
    var pin = document.getElementById('pimg-uploader-input');
    var pgrid = document.getElementById('shop-imgpick');
    var pempty = document.getElementById('pimg-empty');
    var pqueue = document.getElementById('pimg-uploader-queue');
    var pick = document.getElementById('pimg-uploader-pick');
    if (pup && pin && pgrid) {
        var csrf = <?= json_encode(csrfToken()) ?>;
        function esc(s){ return String(s||'').replace(/[&<>"']/g, function(c){ return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]; }); }
        function addItem(media){
            if (pempty) { pempty.remove(); pempty = null; }
            var lbl = document.createElement('label');
            lbl.className = 'shop-imgpick__item is-on';
            lbl.innerHTML = '<input type="checkbox" name="image_ids[]" value="' + (media.id|0) + '" checked>'
                + '<img src="' + esc(media.path) + '" alt="" loading="lazy">';
            pgrid.insertBefore(lbl, pgrid.firstChild);
        }
        function setQueueLine(name, status){
            if (!pqueue) return;
            pqueue.hidden = false;
            var row = document.createElement('div');
            row.className = 'pimg-uploader__row pimg-uploader__row--' + status;
            row.innerHTML = '<span class="pimg-uploader__name">' + esc(name) + '</span><span class="pimg-uploader__status">' + esc(status === 'ok' ? '✓ subida' : status === 'err' ? '✕ error' : 'subiendo…') + '</span>';
            pqueue.appendChild(row);
            return row;
        }
        function uploadOne(file){
            var line = setQueueLine(file.name, 'up');
            var fd = new FormData();
            fd.append('action', 'media_upload_inline');
            fd.append('csrf', csrf);
            fd.append('file', file);
            return fetch(window.location.pathname || '/admin/', { method: 'POST', body: fd, credentials: 'same-origin' })
                .then(function(r){ return r.json(); })
                .then(function(j){
                    if (j && j.ok && j.path) {
                        addItem({ id: j.id || 0, path: j.path });
                        if (line) { line.className = 'pimg-uploader__row pimg-uploader__row--ok'; line.querySelector('.pimg-uploader__status').textContent = '✓ subida'; }
                    } else {
                        if (line) { line.className = 'pimg-uploader__row pimg-uploader__row--err'; line.querySelector('.pimg-uploader__status').textContent = '✕ ' + (j && j.error ? j.error : 'error'); }
                    }
                })
                .catch(function(err){
                    if (line) { line.className = 'pimg-uploader__row pimg-uploader__row--err'; line.querySelector('.pimg-uploader__status').textContent = '✕ ' + (err.message || 'error'); }
                });
        }
        function handleFiles(files){
            if (!files || !files.length) return;
            if (pqueue) pqueue.innerHTML = '';
            var arr = Array.from(files);
            (function next(i){
                if (i >= arr.length) { pin.value = ''; return; }
                uploadOne(arr[i]).then(function(){ next(i + 1); });
            })(0);
        }
        if (pick) pick.addEventListener('click', function(){ pin.click(); });
        pin.addEventListener('change', function(){ handleFiles(pin.files); });
        ['dragenter','dragover'].forEach(function(ev){ pup.addEventListener(ev, function(e){ e.preventDefault(); pup.classList.add('is-dragover'); }); });
        ['dragleave','drop'].forEach(function(ev){ pup.addEventListener(ev, function(e){ e.preventDefault(); pup.classList.remove('is-dragover'); }); });
        pup.addEventListener('drop', function(e){ if (e.dataTransfer && e.dataTransfer.files) handleFiles(e.dataTransfer.files); });
        pup.addEventListener('click', function(e){
            if (e.target === pup || e.target.closest('.pimg-uploader__cta') && !e.target.closest('button,a,input')) pin.click();
        });
    }
})();
</script>

<?php require __DIR__ . '/_shop_admin_styles.php'; ?>
