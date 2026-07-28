<?php
/** Vista "Carga masiva": bajar el CSV de ejemplo, llenarlo y subirlo. */
$msg    = flashGet('shop_msg');
$err    = flashGet('shop_err');
$detail = flashGet('shop_upload_detail');
$detail = $detail ? (json_decode($detail, true) ?: []) : [];
$spec   = productsUploadSpec();
?>
<header class="admin-header">
    <div>
        <h1>Carga masiva de productos</h1>
        <div class="admin-header__sub">Sube un CSV y crea o actualiza muchos productos de una vez</div>
    </div>
    <div style="display:flex;gap:.5rem;flex-wrap:wrap;">
        <a class="btn btn--ghost" href="/admin/?view=products">← Volver al listado</a>
    </div>
</header>

<?php if ($msg): ?><div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div><?php endif; ?>
<?php if ($err): ?><div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($err) ?></span></div><?php endif; ?>

<?php if ($detail): ?>
<div class="card pup-detail">
    <strong>Detalle de filas con problemas</strong>
    <ul>
        <?php foreach ($detail as $d): ?><li><?= htmlspecialchars((string) $d) ?></li><?php endforeach; ?>
    </ul>
</div>
<?php endif; ?>

<div class="pup-steps">
    <section class="card pup-step">
        <div class="pup-step__n">1</div>
        <div>
            <h2>Descarga el ejemplo</h2>
            <p class="text-muted">Un CSV con los encabezados correctos y 3 productos de ejemplo. Ábrelo con Excel o Google Sheets.</p>
            <a class="btn" href="/admin/?action=products_template">Descargar ejemplo CSV</a>
        </div>
    </section>

    <section class="card pup-step">
        <div class="pup-step__n">2</div>
        <div>
            <h2>Completa tus productos</h2>
            <p class="text-muted">
                Borra las filas de ejemplo y carga las tuyas: <strong>una fila por producto</strong>.
                Guarda el archivo como CSV (sirve separado por <code>;</code> o por <code>,</code>).
            </p>
        </div>
    </section>

    <section class="card pup-step">
        <div class="pup-step__n">3</div>
        <div>
            <h2>Sube el archivo</h2>
            <p class="text-muted">Se procesa al instante. Si una fila tiene un error, se salta y te lo mostramos acá.</p>
            <form method="post" enctype="multipart/form-data" class="pup-form" onsubmit="return this.file.value !== '';">
                <input type="hidden" name="action" value="products_upload">
                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                <label class="btn btn--ghost pup-file">
                    Elegir archivo CSV
                    <input type="file" name="file" accept=".csv,text/csv" hidden
                           onchange="this.form.querySelector('.pup-go').hidden = !this.value; this.form.querySelector('.pup-name').textContent = this.files[0] ? this.files[0].name : '';">
                </label>
                <span class="pup-name text-muted"></span>
                <button type="submit" class="btn pup-go" hidden>Cargar productos</button>
            </form>
        </div>
    </section>
</div>

<div class="card pup-cols">
    <h2>Columnas del archivo</h2>
    <p class="text-muted" style="margin-top:-.4rem;">
        Todas son opcionales salvo <code>nombre</code>. <strong>Celda vacía = no se toca</strong> (en productos nuevos queda el valor por defecto).
    </p>
    <div style="overflow-x:auto;">
        <table class="shop-table">
            <thead><tr><th>Columna</th><th>Qué poner</th></tr></thead>
            <tbody>
            <?php foreach ($spec as $c): ?>
                <tr>
                    <td><code><?= htmlspecialchars($c['col']) ?></code></td>
                    <td class="text-muted"><?= htmlspecialchars($c['help']) ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <ul class="pup-notes text-muted">
        <li>Si el <code>sku</code> ya existe en el catálogo, la fila <strong>actualiza</strong> ese producto en vez de duplicarlo.</li>
        <li>Las categorías que no existan se crean automáticamente.</li>
        <li>Si completas <code>imagen_url</code> en un producto que ya tiene fotos, se reemplaza la galería.</li>
        <li>Máximo <?= PRODUCTS_UPLOAD_MAX_ROWS ?> filas y <?= PRODUCTS_UPLOAD_MAX_IMAGES ?> imágenes por archivo (sube el resto en otro archivo).</li>
        <li>Para editar precios y stock de lo que ya está cargado, es más rápido <a href="/admin/?view=products_bulk">Editar en tabla</a>.</li>
    </ul>
</div>

<?php require __DIR__ . '/_shop_admin_styles.php'; ?>
<style>
/* El admin no carga auth.css: le damos cuerpo al resultado de la carga acá. */
.auth-alert { display:block; padding:.85rem 1rem; border:1px solid #e5e7eb; border-radius:10px; background:#fff; font-size:.9rem; margin-bottom:1rem; }
.auth-alert--success { border-color:#bbf7d0; background:#f0fdf4; color:#166534; }
.auth-alert--error { border-color:#fecaca; background:#fef2f2; color:#991b1b; }
.pup-steps { display:grid; gap:.75rem; margin-bottom:1rem; }
.pup-step { display:flex; gap:1rem; align-items:flex-start; padding:1.1rem 1.25rem; }
.pup-step h2 { font-size:1rem; margin:0 0 .25rem; }
.pup-step p { font-size:.88rem; margin:0 0 .7rem; }
.pup-step__n { flex:0 0 28px; width:28px; height:28px; border-radius:50%; background:var(--color-text,#0f172a); color:#fff; display:flex; align-items:center; justify-content:center; font-size:.8rem; font-weight:600; }
.pup-form { display:flex; gap:.5rem; align-items:center; flex-wrap:wrap; }
.pup-file { cursor:pointer; margin:0; }
.pup-form [hidden] { display:none; }
.pup-name { font-size:.82rem; }
.pup-cols { padding:1.25rem; }
.pup-cols h2 { font-size:1rem; margin:0 0 .6rem; }
.pup-cols code { background:#f3f4f6; border-radius:4px; padding:.1rem .3rem; font-size:.82rem; }
.pup-cols .shop-table td { padding:.45rem .6rem; font-size:.85rem; }
.pup-notes { font-size:.85rem; margin:1rem 0 0; padding-left:1.1rem; display:grid; gap:.3rem; }
.pup-detail { padding:1rem 1.25rem; margin-bottom:1rem; border-left:3px solid #f59e0b; }
.pup-detail ul { margin:.5rem 0 0; padding-left:1.1rem; font-size:.85rem; color:#6b7280; display:grid; gap:.25rem; }
</style>
