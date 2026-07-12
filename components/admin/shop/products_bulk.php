<?php
/** Requiere: $bulkProducts (array de filas), $bulkSearch, $bulkStatus */
$rows = $bulkProducts ?? [];
$msg  = flashGet('shop_msg');
$err  = flashGet('shop_err');
$statusLabels = ['draft' => 'Borrador', 'published' => 'Publicado', 'archived' => 'Archivado'];
$stockLabels  = ['in_stock' => 'En stock', 'out_of_stock' => 'Sin stock', 'backorder' => 'Bajo pedido'];
// Query para preservar filtros en el link de exportación.
$exportQs = http_build_query(array_filter([
    'action' => 'products_export', 'view' => 'products_bulk',
    'search' => $bulkSearch, 'status' => $bulkStatus,
]));
?>
<header class="admin-header">
    <div>
        <h1>Editar en tabla</h1>
        <div class="admin-header__sub"><?= count($rows) ?> producto(s) — editá precios, stock, estado y fotos de un tirón</div>
    </div>
    <div style="display:flex;gap:.5rem;flex-wrap:wrap;">
        <a class="btn btn--ghost" href="/admin/?view=products">← Volver al listado</a>
        <a class="btn btn--ghost" href="/admin/?<?= htmlspecialchars($exportQs) ?>">Exportar Excel</a>
    </div>
</header>

<?php if ($msg): ?><div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div><?php endif; ?>
<?php if ($err): ?><div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($err) ?></span></div><?php endif; ?>

<div class="pbulk-toolbar">
    <form method="get" class="shop-filters" style="margin:0;flex:1;">
        <input type="hidden" name="view" value="products_bulk">
        <input type="search" name="search" value="<?= htmlspecialchars($bulkSearch) ?>" placeholder="Buscar por nombre o SKU…">
        <select name="status">
            <option value="">Todos los estados</option>
            <?php foreach ($statusLabels as $k => $v): ?>
                <option value="<?= $k ?>" <?= $bulkStatus === $k ? 'selected' : '' ?>><?= $v ?></option>
            <?php endforeach; ?>
        </select>
        <button class="btn btn--ghost" type="submit">Filtrar</button>
    </form>

    <form method="post" enctype="multipart/form-data" class="pbulk-import" onsubmit="return this.file.value !== '';">
        <input type="hidden" name="action" value="products_import">
        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
        <label class="btn btn--ghost pbulk-import__label">
            Importar Excel
            <input type="file" name="file" accept=".csv,text/csv" hidden onchange="this.form.querySelector('.pbulk-import__go').hidden=false; this.form.querySelector('.pbulk-import__name').textContent=this.files[0]?this.files[0].name:'';">
        </label>
        <span class="pbulk-import__name text-muted" style="font-size:.82rem;"></span>
        <button type="submit" class="btn pbulk-import__go" hidden>Subir</button>
    </form>
</div>
<p class="text-muted" style="font-size:.8rem;margin:.2rem 0 1rem;">
    El archivo de importación usa el mismo formato del export (columnas por <code>id</code>). Las fotos se editan solo desde esta tabla.
</p>

<?php if (!$rows): ?>
    <div class="card" style="padding:2rem;text-align:center;color:#6b7280;">
        No hay productos. <a href="/admin/?view=product&id=new">Creá el primero →</a>
    </div>
<?php else: ?>
<form method="post" id="pbulk-form">
    <input type="hidden" name="action" value="products_bulk_save" id="pbulk-action">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
    <input type="hidden" name="search" value="<?= htmlspecialchars($bulkSearch) ?>">
    <input type="hidden" name="status" value="<?= htmlspecialchars($bulkStatus) ?>">

    <div class="card" style="padding:0;overflow-x:auto;">
    <table class="shop-table pbulk-table">
        <thead><tr>
            <th style="text-align:center;"><input type="checkbox" id="pbulk-all" class="pbulk-check" title="Seleccionar todo"></th>
            <th>Foto</th><th>Nombre</th><th>SKU</th><th>Precio</th><th>Oferta</th>
            <th>Stock</th><th>Gest.</th><th>Estado stock</th><th>Estado</th><th>Dest.</th>
        </tr></thead>
        <tbody>
        <?php foreach ($rows as $p): $id = (int) $p['id']; ?>
            <tr>
                <td style="text-align:center;">
                    <input type="checkbox" name="del[]" value="<?= $id ?>" class="pbulk-check pbulk-del" title="Seleccionar para eliminar">
                </td>
                <td class="pbulk-photocell">
                    <label class="pbulk-photo" title="Cambiar foto principal">
                        <?php if (!empty($p['thumb'])): ?>
                            <img class="pbulk-thumb" src="<?= htmlspecialchars($p['thumb']) ?>" alt="" loading="lazy">
                        <?php else: ?>
                            <img class="pbulk-thumb pbulk-thumb--empty" src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg'/%3E" alt="">
                        <?php endif; ?>
                        <input type="file" accept="image/*" class="pbulk-file" data-id="<?= $id ?>" hidden>
                        <span class="pbulk-photo__badge">✎</span>
                    </label>
                    <input type="hidden" name="rows[<?= $id ?>][primary_media_id]" value="" class="pbulk-media-<?= $id ?>">
                </td>
                <td>
                    <input class="pbulk-in pbulk-in--name" name="rows[<?= $id ?>][name]" value="<?= htmlspecialchars((string) $p['name']) ?>" required>
                    <?php if (($p['type'] ?? 'simple') === 'variable'): ?><small class="text-muted">variable</small><?php endif; ?>
                    <a class="pbulk-edit" href="/admin/?view=product&id=<?= $id ?>" title="Ficha completa">↗</a>
                </td>
                <td><input class="pbulk-in pbulk-in--sku" name="rows[<?= $id ?>][sku]" value="<?= htmlspecialchars((string) ($p['sku'] ?? '')) ?>" placeholder="—"></td>
                <td><input class="pbulk-in pbulk-in--num" type="number" step="1" min="0" name="rows[<?= $id ?>][price]" value="<?= htmlspecialchars((string) $p['price']) ?>"></td>
                <td><input class="pbulk-in pbulk-in--num" type="number" step="1" min="0" name="rows[<?= $id ?>][sale_price]" value="<?= $p['sale_price'] !== null ? htmlspecialchars((string) $p['sale_price']) : '' ?>" placeholder="—"></td>
                <td><input class="pbulk-in pbulk-in--num pbulk-in--stock" type="number" step="1" name="rows[<?= $id ?>][stock_qty]" value="<?= (int) $p['stock_qty'] ?>"></td>
                <td style="text-align:center;">
                    <input type="checkbox" name="rows[<?= $id ?>][manage_stock]" value="1" <?= (int) $p['manage_stock'] === 1 ? 'checked' : '' ?> title="Gestionar stock" class="pbulk-check">
                </td>
                <td>
                    <select class="pbulk-in pbulk-in--sel" name="rows[<?= $id ?>][stock_status]">
                        <?php foreach ($stockLabels as $k => $v): ?>
                            <option value="<?= $k ?>" <?= ($p['stock_status'] ?? '') === $k ? 'selected' : '' ?>><?= $v ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td>
                    <select class="pbulk-in pbulk-in--sel" name="rows[<?= $id ?>][status]">
                        <?php foreach ($statusLabels as $k => $v): ?>
                            <option value="<?= $k ?>" <?= ($p['status'] ?? '') === $k ? 'selected' : '' ?>><?= $v ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td style="text-align:center;">
                    <input type="checkbox" name="rows[<?= $id ?>][featured]" value="1" <?= (int) $p['featured'] === 1 ? 'checked' : '' ?> title="Destacado" class="pbulk-check">
                </td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>

    <div class="pbulk-savebar">
        <span class="text-muted" style="font-size:.85rem;" id="pbulk-selinfo">Los cambios se aplican al guardar.</span>
        <div style="display:flex;gap:.5rem;flex-wrap:wrap;">
            <button type="button" class="btn btn--danger" id="pbulk-delete" hidden>Eliminar seleccionados</button>
            <button type="submit" class="btn">Guardar cambios</button>
        </div>
    </div>
</form>
<?php endif; ?>

<?php require __DIR__ . '/_shop_admin_styles.php'; ?>
<style>
.pbulk-toolbar { display:flex; gap:.75rem; align-items:flex-start; flex-wrap:wrap; margin-bottom:.4rem; }
.pbulk-import { display:flex; gap:.5rem; align-items:center; flex-wrap:wrap; }
.pbulk-import__label { cursor:pointer; margin:0; }
.pbulk-table th, .pbulk-table td { padding:.5rem .55rem; }
.pbulk-in { width:100%; padding:.4rem .5rem; border:1px solid #d1d5db; border-radius:6px; font:inherit; font-size:.85rem; background:#fff; }
.pbulk-in:focus { outline:none; border-color:var(--color-text,#111); box-shadow:0 0 0 2px rgba(15,23,42,.08); }
.pbulk-in--name { min-width:170px; }
.pbulk-in--sku { min-width:90px; }
.pbulk-in--num { width:88px; text-align:right; }
.pbulk-in--stock { width:70px; }
.pbulk-in--sel { min-width:110px; }
.pbulk-check { width:20px; height:20px; accent-color:var(--color-text,#0f172a); cursor:pointer; }
.pbulk-photo { position:relative; display:block; width:46px; height:46px; cursor:pointer; }
.pbulk-thumb { width:46px; height:46px; object-fit:cover; border-radius:6px; border:1px solid #e5e7eb; display:block; background:#f3f4f6; }
.pbulk-thumb--empty { background:#f3f4f6; }
.pbulk-photo__badge { position:absolute; right:-5px; bottom:-5px; width:18px; height:18px; border-radius:50%; background:var(--color-text,#0f172a); color:#fff; font-size:.62rem; display:flex; align-items:center; justify-content:center; box-shadow:0 1px 3px rgba(0,0,0,.25); }
.pbulk-photo.is-loading { opacity:.5; }
.pbulk-photo.is-done .pbulk-thumb { border-color:#16a34a; box-shadow:0 0 0 2px rgba(22,163,74,.25); }
.pbulk-edit { margin-left:.35rem; color:#9ca3af; text-decoration:none; font-size:.9rem; }
.pbulk-edit:hover { color:var(--color-text,#111); }
.pbulk-savebar { position:sticky; bottom:0; display:flex; justify-content:space-between; align-items:center; gap:1rem; margin-top:1rem; padding:.85rem 1rem; background:rgba(255,255,255,.96); border:1px solid #eef0f2; border-radius:10px; box-shadow:0 -4px 16px rgba(0,0,0,.05); flex-wrap:wrap; }
</style>
<script>
(function(){
    var form = document.getElementById('pbulk-form');
    if (!form) return;
    var csrf = <?= json_encode(csrfToken()) ?>;

    // --- Selección para borrado masivo ---
    var all = document.getElementById('pbulk-all');
    var delBtn = document.getElementById('pbulk-delete');
    var selInfo = document.getElementById('pbulk-selinfo');
    var actionInput = document.getElementById('pbulk-action');
    function selected(){ return Array.prototype.filter.call(form.querySelectorAll('.pbulk-del'), function(c){ return c.checked; }); }
    function refreshSel(){
        var n = selected().length;
        if (delBtn) delBtn.hidden = n === 0;
        if (delBtn) delBtn.textContent = 'Eliminar seleccionados (' + n + ')';
        if (selInfo) selInfo.textContent = n > 0 ? (n + ' seleccionado(s)') : 'Los cambios se aplican al guardar.';
        var boxes = form.querySelectorAll('.pbulk-del');
        if (all) all.checked = n > 0 && n === boxes.length;
    }
    if (all) all.addEventListener('change', function(){
        form.querySelectorAll('.pbulk-del').forEach(function(c){ c.checked = all.checked; });
        refreshSel();
    });
    form.addEventListener('change', function(e){ if (e.target.closest('.pbulk-del')) refreshSel(); });
    if (delBtn) delBtn.addEventListener('click', function(){
        var n = selected().length;
        if (!n) return;
        if (!confirm('¿Eliminar ' + n + ' producto(s)? Esta acción no se puede deshacer.')) return;
        if (actionInput) actionInput.value = 'products_bulk_delete';
        form.submit();
    });

    form.addEventListener('change', function(e){
        var input = e.target.closest('.pbulk-file');
        if (!input || !input.files || !input.files.length) return;
        var id = input.getAttribute('data-id');
        var label = input.closest('.pbulk-photo');
        var img = label.querySelector('.pbulk-thumb');
        var hidden = form.querySelector('.pbulk-media-' + id);

        label.classList.add('is-loading');
        label.classList.remove('is-done');

        var fd = new FormData();
        fd.append('action', 'media_upload_inline');
        fd.append('csrf', csrf);
        fd.append('file', input.files[0]);

        fetch(window.location.pathname || '/admin/', { method:'POST', body:fd, credentials:'same-origin' })
            .then(function(r){ return r.json(); })
            .then(function(j){
                label.classList.remove('is-loading');
                if (j && j.ok && j.path) {
                    img.src = j.path;
                    img.classList.remove('pbulk-thumb--empty');
                    if (hidden) hidden.value = j.id || '';
                    label.classList.add('is-done');
                } else {
                    alert('No se pudo subir la imagen: ' + (j && j.error ? j.error : 'error'));
                }
                input.value = '';
            })
            .catch(function(err){
                label.classList.remove('is-loading');
                alert('Error al subir: ' + (err.message || err));
                input.value = '';
            });
    });
})();
</script>
