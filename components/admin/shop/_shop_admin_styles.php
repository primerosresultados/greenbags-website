<?php
/** Estilos del admin de tienda. Se imprime una sola vez por request. */
if (!empty($GLOBALS['__shop_admin_styles'])) return;
$GLOBALS['__shop_admin_styles'] = true;
?>
<style>
.shop-table { width:100%; border-collapse:collapse; font-size:.9rem; }
.shop-table th, .shop-table td { padding:.7rem .8rem; text-align:left; border-bottom:1px solid #eef0f2; vertical-align:middle; }
.shop-table thead th { font-size:.74rem; text-transform:uppercase; letter-spacing:.04em; color:#6b7280; background:#fafafa; }
.shop-table tbody tr:hover { background:#fafafa; }
.shop-table__thumb { width:42px; height:42px; object-fit:cover; border-radius:6px; border:1px solid #e5e7eb; display:block; }
.shop-table__thumb--empty { background:#f3f4f6; }
.shop-badge { font-size:.72rem; padding:.2rem .5rem; border-radius:999px; font-weight:600; }
.shop-badge--published { background:#dcfce7; color:#166534; }
.shop-badge--draft { background:#fef9c3; color:#854d0e; }
.shop-badge--archived { background:#f3f4f6; color:#6b7280; }
.shop-price__old { text-decoration:line-through; color:#9ca3af; font-weight:400; }
.shop-filters { display:flex; gap:.5rem; margin:0 0 1rem; flex-wrap:wrap; }
.shop-filters input[type="search"] { flex:1; min-width:200px; padding:.55rem .7rem; border:1px solid #d1d5db; border-radius:6px; font:inherit; }
.shop-filters select { padding:.55rem .7rem; border:1px solid #d1d5db; border-radius:6px; font:inherit; }
.shop-pagination { display:flex; gap:.3rem; margin-top:1rem; flex-wrap:wrap; }
.shop-pagination a { padding:.4rem .7rem; border:1px solid #e5e7eb; border-radius:6px; text-decoration:none; color:#374151; font-size:.85rem; }
.shop-pagination a.is-active { background:var(--color-text,#111); color:#fff; border-color:var(--color-text,#111); }
.shop-form__row { display:grid; grid-template-columns:1fr 1fr; gap:1rem; }
@media (max-width:640px){ .shop-form__row { grid-template-columns:1fr; } }
.shop-checkgrid { display:grid; grid-template-columns:repeat(auto-fill,minmax(180px,1fr)); gap:.4rem; }
.shop-check { display:flex; align-items:center; gap:.45rem; font-size:.9rem; }
.shop-check input { width:auto; }
.shop-imgpick { display:grid; grid-template-columns:repeat(auto-fill,minmax(110px,1fr)); gap:.6rem; }
.shop-imgpick__item { position:relative; cursor:pointer; border:2px solid #e5e7eb; border-radius:8px; overflow:hidden; aspect-ratio:1; display:block; background:#f9fafb; transition:border-color .15s, box-shadow .15s; }
.shop-imgpick__item:hover { border-color:#94a3b8; }
.shop-imgpick__item img { width:100%; height:100%; object-fit:cover; display:block; }
.shop-imgpick__item.is-on { border-color:var(--color-text,#111); box-shadow:0 0 0 2px rgba(15,23,42,.08); }
.shop-imgpick__item input { position:absolute; top:6px; left:6px; width:20px; height:20px; z-index:2; cursor:pointer; }
.shop-imgpick__item.is-on::after { content:""; position:absolute; inset:0; background:linear-gradient(180deg, rgba(15,23,42,.04), rgba(15,23,42,.18)); pointer-events:none; }

/* Uploader directo dentro del editor de producto */
.pimg-uploader { display:flex; flex-direction:column; gap:.6rem; padding:1rem 1.1rem; border:1.5px dashed #cbd5e1; border-radius:10px; background:#fafafa; margin:0 0 .9rem; cursor:pointer; transition:border-color .2s, background .2s; }
.pimg-uploader:hover, .pimg-uploader.is-dragover { border-color:var(--color-text,#111); background:#fff; }
.pimg-uploader.is-dragover { border-style:solid; }
.pimg-uploader__cta { display:flex; gap:.85rem; align-items:center; color:#475569; }
.pimg-uploader__cta svg { flex-shrink:0; opacity:.8; }
.pimg-uploader__cta strong { display:block; font-size:.92rem; color:#0f172a; margin-bottom:.05rem; }
.pimg-uploader__cta span { font-size:.84rem; color:#64748b; }
.pimg-uploader__cta small { display:block; margin-top:.25rem; font-size:.74rem; color:#94a3b8; }
.pimg-uploader .ml-link { background:none; border:none; color:#0f172a; cursor:pointer; font:inherit; padding:0; text-decoration:underline; font-weight:500; }
.pimg-uploader__queue { display:flex; flex-direction:column; gap:.3rem; margin-top:.2rem; }
.pimg-uploader__row { display:flex; justify-content:space-between; align-items:center; gap:.7rem; padding:.4rem .65rem; background:#fff; border:1px solid #e5e7eb; border-radius:6px; font-size:.78rem; }
.pimg-uploader__row--ok { border-color:#bbf7d0; background:#f0fdf4; }
.pimg-uploader__row--err { border-color:#fecaca; background:#fef2f2; color:#991b1b; }
.pimg-uploader__name { flex:1; min-width:0; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; color:#334155; }
.pimg-uploader__status { flex-shrink:0; font-weight:500; color:#64748b; }
.pimg-uploader__row--ok .pimg-uploader__status { color:#166534; }
.pimg-uploader__row--err .pimg-uploader__status { color:#991b1b; }
/* Tipo de producto */
.shop-typepick { display:flex; gap:.7rem; flex-wrap:wrap; }
.shop-typepick__opt { flex:1; min-width:200px; display:flex; gap:.6rem; align-items:flex-start; border:1.5px solid #e5e7eb; border-radius:10px; padding:.8rem .9rem; cursor:pointer; }
.shop-typepick__opt input { width:auto; margin-top:.2rem; }
.shop-typepick__opt span { display:flex; flex-direction:column; }
.shop-typepick__opt small { color:#6b7280; font-size:.78rem; }
/* Toggle simple/variable */
.when-variable { display:none; }
.ptype-variable .when-variable { display:block; }
.ptype-variable .when-simple { display:none; }
.card__title .when-simple, .card__title .when-variable { display:inline; }
.ptype-wrap .card__title .when-variable { display:none; }
.ptype-variable .card__title .when-variable { display:inline; }
.ptype-variable .card__title .when-simple { display:none; }
/* Editor de opciones */
.opt-row { display:flex; gap:.5rem; margin-bottom:.5rem; align-items:center; }
.opt-row .opt-name { width:190px; flex-shrink:0; }
.opt-row .opt-vals { flex:1; min-width:0; }
.opt-row input { padding:.5rem .65rem; border:1px solid #d1d5db; border-radius:6px; font:inherit; font-size:.86rem; }
.opt-row .opt-del { flex-shrink:0; }
/* Tabla de variaciones */
.shop-vartable input, .shop-vartable select { padding:.4rem; border:1px solid #d1d5db; border-radius:6px; font:inherit; font-size:.84rem; }
.shop-vartable td { vertical-align:middle; }
/* Mayoreo y videos */
.tier-row, .video-row { display:flex; gap:.5rem; align-items:center; margin-bottom:.5rem; flex-wrap:wrap; }
.tier-row input { width:120px; padding:.45rem; border:1px solid #d1d5db; border-radius:6px; font:inherit; }
.tier-row span { color:#6b7280; font-size:.85rem; }
.video-row .video-url { flex:1; min-width:240px; padding:.5rem; border:1px solid #d1d5db; border-radius:6px; font:inherit; }
</style>
<script>
/* Reflejar selección de imágenes (borde activo) sin recargar. */
document.addEventListener('change', function(e){
    var cb = e.target.closest('.shop-imgpick__item input[type=checkbox]');
    if (cb) cb.closest('.shop-imgpick__item').classList.toggle('is-on', cb.checked);
});
</script>
