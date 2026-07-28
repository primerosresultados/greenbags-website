<?php
/**
 * Editor de bloques de una página (admin → Páginas → editar).
 * Se incluye DENTRO del <form> de page_edit.php.
 *
 * Requiere: $page (array de la fila de pages, puede ser nueva).
 *
 * Los `name` de los inputs NO se escriben acá: el JS los arma al enviar el
 * form recorriendo el DOM (data-key / data-rep-row). Así reordenar, duplicar o
 * borrar bloques no obliga a renumerar nada a mano.
 */

$blkPageId  = (int) ($page['id'] ?? 0);
$blkBlocks  = $blkPageId > 0 ? blocksForPage($blkPageId, false) : [];
$blkTypes   = blockTypes();

/* ------------------------- Render de un campo ------------------------- */

function blkAdminField(array $f, $value): void {
    $key   = $f['key'];
    $type  = $f['type'];
    $label = $f['label'] ?? $key;
    $hint  = $f['hint'] ?? '';
    $half  = !empty($f['half']);
    $ph    = $f['placeholder'] ?? '';
    $id    = 'blkf_' . bin2hex(random_bytes(4));
    ?>
    <div class="blkf<?= $half ? ' blkf--half' : '' ?><?= $type === 'repeater' ? ' blkf--rep' : '' ?>"
         data-field data-key="<?= htmlspecialchars($key) ?>"<?= $type === 'repeater' ? ' data-rep' : '' ?>>

        <?php if ($type !== 'checkbox'): ?>
            <label class="blkf__label" for="<?= $id ?>"><?= htmlspecialchars($label) ?></label>
        <?php endif; ?>

        <?php switch ($type):
            case 'textarea': ?>
                <textarea class="blkf__input<?= !empty($f['mono']) ? ' blkf__input--mono' : '' ?>"
                          id="<?= $id ?>" data-input rows="<?= (int) ($f['rows'] ?? 3) ?>"
                          placeholder="<?= htmlspecialchars($ph) ?>"><?= htmlspecialchars((string) $value) ?></textarea>
            <?php break;

            case 'richtext': ?>
                <div class="blkrt" data-rt>
                    <div class="blkrt__bar">
                        <button type="button" data-rt-cmd="bold" title="Negrita"><strong>B</strong></button>
                        <button type="button" data-rt-cmd="italic" title="Cursiva"><em>I</em></button>
                        <button type="button" data-rt-cmd="formatBlock" data-rt-arg="h3" title="Subtítulo">H</button>
                        <button type="button" data-rt-cmd="insertUnorderedList" title="Viñetas">•—</button>
                        <button type="button" data-rt-cmd="insertOrderedList" title="Lista numerada">1—</button>
                        <button type="button" data-rt-link title="Insertar enlace">🔗</button>
                        <button type="button" data-rt-cmd="removeFormat" title="Quitar formato">✕</button>
                    </div>
                    <div class="blkrt__area" contenteditable="true" role="textbox" aria-multiline="true"
                         aria-label="<?= htmlspecialchars($label) ?>" data-rt-area><?= (string) $value ?></div>
                    <textarea class="blkrt__raw" data-input hidden><?= htmlspecialchars((string) $value) ?></textarea>
                </div>
            <?php break;

            case 'image':
                $sifName        = '_blk';
                $sifValue       = (string) $value;
                $sifId          = $id;
                $sifLabel       = '';
                $sifPlaceholder = '/uploads/library/...webp';
                include __DIR__ . '/_single_image_field.php';
                break;

            case 'select': ?>
                <select class="blkf__input" id="<?= $id ?>" data-input>
                    <?php foreach (($f['options'] ?? []) as $ov => $ol): ?>
                        <option value="<?= htmlspecialchars($ov) ?>" <?= (string) $value === (string) $ov ? 'selected' : '' ?>>
                            <?= htmlspecialchars($ol) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            <?php break;

            case 'checkbox': ?>
                <input type="hidden" data-input value="<?= !empty($value) ? '1' : '0' ?>">
                <label class="blkf__check">
                    <input type="checkbox" data-check <?= !empty($value) ? 'checked' : '' ?>>
                    <span><?= htmlspecialchars($label) ?></span>
                </label>
            <?php break;

            case 'icon':
                $cur = (string) ($value !== '' ? $value : ($f['default'] ?? 'check')); ?>
                <input type="hidden" data-input value="<?= htmlspecialchars($cur) ?>">
                <div class="blkicons" data-icons>
                    <?php foreach (blockIcons() as $ik => $ic): ?>
                        <button type="button" class="blkicons__b<?= $ik === $cur ? ' is-on' : '' ?>"
                                data-icon="<?= htmlspecialchars($ik) ?>" title="<?= htmlspecialchars($ic['label']) ?>"
                                aria-label="<?= htmlspecialchars($ic['label']) ?>"><?= $ic['svg'] ?></button>
                    <?php endforeach; ?>
                </div>
            <?php break;

            case 'repeater':
                $rows = is_array($value) ? $value : []; ?>
                <div class="blkrep__rows" data-rep-rows>
                    <?php foreach ($rows as $ri => $row): ?>
                        <?php blkAdminRepRow($f, is_array($row) ? $row : [], $ri + 1); ?>
                    <?php endforeach; ?>
                </div>
                <button type="button" class="btn btn--ghost blkrep__add" data-rep-add>
                    + Agregar <?= htmlspecialchars(mb_strtolower($f['item_label'] ?? 'ítem')) ?>
                </button>
                <template data-rep-tpl><?php blkAdminRepRow($f, [], 0); ?></template>
            <?php break;

            case 'url':
            default: ?>
                <input type="text" class="blkf__input" id="<?= $id ?>" data-input
                       value="<?= htmlspecialchars((string) $value) ?>"
                       placeholder="<?= htmlspecialchars($ph) ?>">
            <?php endswitch; ?>

        <?php if ($hint !== ''): ?>
            <small class="blkf__hint"><?= htmlspecialchars($hint) ?></small>
        <?php endif; ?>
    </div>
    <?php
}

/** Una fila de repeater (con sus subcampos). */
function blkAdminRepRow(array $f, array $row, int $num): void {
    ?>
    <div class="blkrep__row" data-rep-row>
        <div class="blkrep__rowbar">
            <span class="blkrep__num"><?= htmlspecialchars($f['item_label'] ?? 'Ítem') ?> <span data-rep-num><?= $num ?: 1 ?></span></span>
            <span class="blkrep__rowacts">
                <button type="button" class="blkbtn" data-rep-up title="Subir">↑</button>
                <button type="button" class="blkbtn" data-rep-down title="Bajar">↓</button>
                <button type="button" class="blkbtn blkbtn--danger" data-rep-del title="Quitar">✕</button>
            </span>
        </div>
        <div class="blkrep__fields" data-row-fields>
            <?php foreach ($f['fields'] as $sub): ?>
                <?php blkAdminField($sub, $row[$sub['key']] ?? ($sub['default'] ?? '')); ?>
            <?php endforeach; ?>
        </div>
    </div>
    <?php
}

/** Un bloque completo (barra + campos). */
function blkAdminItem(string $type, array $data, bool $isActive): void {
    $def = blockTypeDef($type);
    if (!$def) return;
    // Resumen que se ve con el bloque colapsado.
    $summary = '';
    foreach (['title', 'q', 'code'] as $k) {
        if (!empty($data[$k]) && is_string($data[$k])) { $summary = $data[$k]; break; }
    }
    ?>
    <div class="blkitem<?= $isActive ? '' : ' blkitem--off' ?>" data-blk-item data-type="<?= htmlspecialchars($type) ?>">
        <input type="hidden" data-blk-type value="<?= htmlspecialchars($type) ?>">
        <input type="hidden" data-blk-active value="<?= $isActive ? '1' : '0' ?>">

        <div class="blkitem__bar">
            <button type="button" class="blkitem__toggle" data-blk-toggle aria-expanded="false">
                <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 6 15 12 9 18"/></svg>
            </button>
            <span class="blkitem__type"><?= htmlspecialchars($def['label']) ?></span>
            <span class="blkitem__summary" data-blk-summary><?= htmlspecialchars(mb_strimwidth($summary, 0, 70, '…')) ?></span>
            <span class="blkitem__off-tag">oculto</span>
            <span class="blkitem__acts">
                <button type="button" class="blkbtn" data-blk-up title="Subir">↑</button>
                <button type="button" class="blkbtn" data-blk-down title="Bajar">↓</button>
                <button type="button" class="blkbtn" data-blk-eye title="Mostrar/ocultar en el sitio">👁</button>
                <button type="button" class="blkbtn" data-blk-dup title="Duplicar">⧉</button>
                <button type="button" class="blkbtn blkbtn--danger" data-blk-del title="Eliminar">✕</button>
            </span>
        </div>

        <div class="blkitem__body" data-blk-fields hidden>
            <?php if (!empty($def['desc'])): ?>
                <p class="blkitem__desc"><?= htmlspecialchars($def['desc']) ?></p>
            <?php endif; ?>
            <div class="blkf__grid">
                <?php foreach ($def['fields'] as $f): ?>
                    <?php blkAdminField($f, $data[$f['key']] ?? ($f['default'] ?? ($f['type'] === 'repeater' ? [] : ''))); ?>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
    <?php
}
?>

<div class="card">
    <div class="blkedit__head">
        <div>
            <h3 class="card__title" style="margin:0;">Contenido de la página</h3>
            <p class="blkedit__lead">Armá la página con bloques. Cada bloque es una sección: llená los campos y listo, del diseño se encarga el sitio.</p>
        </div>
    </div>

    <?php // Los assets del selector de Medios tienen que existir en el DOM vivo
          // (no dentro de un <template>, donde el <script> no se ejecuta).
          $sifName = '_blk_bootstrap'; $sifValue = ''; ?>
    <div hidden aria-hidden="true"><?php include __DIR__ . '/_single_image_field.php'; ?></div>

    <?php
    // Seguro anti-borrado: el JS pone esto en 1 al serializar los bloques. Si
    // el script no corrió (JS deshabilitado, error), el POST llega con 0 y el
    // admin deja los bloques intactos en vez de vaciarlos.
    ?>
    <input type="hidden" name="blocks_serialized" value="0" data-blk-flag>

    <div class="blkedit" data-blkedit>
        <div class="blkedit__list" data-blk-list>
            <?php foreach ($blkBlocks as $b): ?>
                <?php blkAdminItem($b['type'], $b['data'], (bool) $b['is_active']); ?>
            <?php endforeach; ?>
        </div>

        <p class="blkedit__empty" data-blk-empty <?= $blkBlocks ? 'hidden' : '' ?>>
            Esta página todavía no tiene bloques.
            <?php if (trim((string) ($page['body'] ?? '')) !== ''): ?>
                Mientras no agregues ninguno se sigue mostrando el HTML de “Contenido avanzado”.
            <?php endif; ?>
        </p>

        <div class="blkadd">
            <button type="button" class="btn blkadd__open" data-blk-add-open>+ Agregar bloque</button>
            <div class="blkadd__palette" data-blk-palette hidden>
                <?php foreach ($blkTypes as $tk => $td): ?>
                    <button type="button" class="blkadd__opt<?= !empty($td['advanced']) ? ' blkadd__opt--adv' : '' ?>" data-blk-add="<?= htmlspecialchars($tk) ?>">
                        <strong><?= htmlspecialchars($td['label']) ?></strong>
                        <span><?= htmlspecialchars($td['desc']) ?></span>
                    </button>
                <?php endforeach; ?>
            </div>
        </div>
    </div>

    <?php // Un template por tipo: el JS clona esto al agregar un bloque nuevo. ?>
    <?php foreach ($blkTypes as $tk => $td): ?>
        <template data-blk-tpl="<?= htmlspecialchars($tk) ?>"><?php blkAdminItem($tk, [], true); ?></template>
    <?php endforeach; ?>
</div>

<style>
/* ===================== Editor de bloques ===================== */
.blkedit__head { display:flex; align-items:flex-start; justify-content:space-between; gap:1rem; margin-bottom:1.2rem; }
.blkedit__lead { margin:.35rem 0 0; font-size:.9rem; color:#64748b; line-height:1.55; max-width:70ch; }
.blkedit__empty { margin:0 0 1rem; padding:1.1rem 1.2rem; background:#f8fafc; border:1px dashed #cbd5e1; border-radius:10px; color:#64748b; font-size:.9rem; line-height:1.55; }
.blkedit__list { display:flex; flex-direction:column; gap:.6rem; margin-bottom:1rem; }

.blkitem { border:1px solid #e5e7eb; border-radius:10px; background:#fff; overflow:hidden; }
.blkitem--off { opacity:.62; background:#fafafa; }
.blkitem__bar { display:flex; align-items:center; gap:.6rem; padding:.7rem .8rem; background:#f9fafb; border-bottom:1px solid transparent; }
.blkitem:has(.blkitem__body:not([hidden])) .blkitem__bar { border-bottom-color:#e5e7eb; }
.blkitem__toggle { background:none; border:0; cursor:pointer; color:#6b7280; padding:.2rem; display:flex; line-height:0; }
.blkitem__toggle svg { transition:transform .18s ease; }
.blkitem__toggle[aria-expanded="true"] svg { transform:rotate(90deg); }
.blkitem__type { font-weight:600; font-size:.9rem; color:#0f172a; white-space:nowrap; }
.blkitem__summary { flex:1; min-width:0; font-size:.85rem; color:#94a3b8; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
.blkitem__off-tag { display:none; font-size:.7rem; font-weight:700; text-transform:uppercase; letter-spacing:.06em; color:#b45309; background:#fffbeb; border:1px solid #fde68a; padding:.15rem .45rem; border-radius:999px; }
.blkitem--off .blkitem__off-tag { display:inline-block; }
.blkitem__acts { display:flex; gap:.2rem; flex-shrink:0; }
.blkitem__desc { margin:0 0 1.1rem; font-size:.85rem; color:#64748b; line-height:1.5; }
.blkitem__body { padding:1.1rem 1rem 1.2rem; }

.blkbtn { background:#fff; border:1px solid #e5e7eb; border-radius:6px; cursor:pointer; color:#475569; font-size:.82rem; line-height:1; padding:.35rem .5rem; transition:all .15s; }
.blkbtn:hover { background:#f1f5f9; border-color:#cbd5e1; color:#0f172a; }
.blkbtn--danger:hover { background:#fee2e2; border-color:#fecaca; color:#b91c1c; }

/* -------- Campos -------- */
.blkf__grid { display:grid; gap:1rem; grid-template-columns:repeat(2,minmax(0,1fr)); }
.blkf { grid-column:1/-1; min-width:0; }
.blkf--half { grid-column:span 1; }
.blkf__label { display:block; font-size:.82rem; font-weight:600; color:#374151; margin:0 0 .35rem; }
.blkf__input { display:block; width:100%; padding:.55rem .7rem; border:1px solid #d1d5db; border-radius:6px; font:inherit; font-size:.88rem; background:#fff; box-sizing:border-box; }
.blkf__input:focus { outline:0; border-color:#0f172a; box-shadow:0 0 0 3px rgba(15,23,42,.08); }
.blkf__input--mono { font-family:var(--font-family-mono); font-size:.82rem; }
textarea.blkf__input { resize:vertical; line-height:1.55; }
.blkf__hint { display:block; font-size:.78rem; color:#94a3b8; margin-top:.3rem; line-height:1.45; }
.blkf__check { display:flex; align-items:center; gap:.5rem; font-size:.88rem; }
.blkf__check input { width:auto; }

/* -------- Texto rico -------- */
.blkrt { border:1px solid #d1d5db; border-radius:6px; overflow:hidden; background:#fff; }
.blkrt:focus-within { border-color:#0f172a; box-shadow:0 0 0 3px rgba(15,23,42,.08); }
.blkrt__bar { display:flex; gap:.15rem; padding:.35rem; background:#f9fafb; border-bottom:1px solid #e5e7eb; flex-wrap:wrap; }
.blkrt__bar button { background:none; border:1px solid transparent; border-radius:4px; cursor:pointer; min-width:28px; height:28px; font-size:.82rem; color:#475569; display:inline-flex; align-items:center; justify-content:center; }
.blkrt__bar button:hover { background:#e2e8f0; color:#0f172a; }
.blkrt__area { padding:.65rem .75rem; min-height:110px; font-size:.9rem; line-height:1.65; color:#1f2937; outline:0; }
.blkrt__area:empty::before { content:attr(aria-label); color:#cbd5e1; }
.blkrt__area p { margin:0 0 .7rem; }
.blkrt__area h3 { font-size:1.02rem; font-weight:700; margin:.9rem 0 .4rem; color:#0f172a; }
.blkrt__area ul, .blkrt__area ol { margin:0 0 .7rem; padding-left:1.3rem; }
.blkrt__area a { color:#0f766e; text-decoration:underline; }

/* -------- Íconos -------- */
.blkicons { display:flex; flex-wrap:wrap; gap:.3rem; }
.blkicons__b { width:36px; height:36px; display:grid; place-items:center; background:#fff; border:1px solid #e5e7eb; border-radius:8px; cursor:pointer; color:#64748b; padding:0; transition:all .15s; }
.blkicons__b svg { width:19px; height:19px; }
.blkicons__b:hover { border-color:#cbd5e1; color:#0f172a; background:#f8fafc; }
.blkicons__b.is-on { border-color:#0f172a; color:#0f172a; background:#f1f5f9; box-shadow:0 0 0 2px rgba(15,23,42,.08); }

/* -------- Repetidores -------- */
.blkf--rep { border:1px solid #eef2f7; border-radius:8px; padding:.9rem; background:#fcfdfe; }
.blkrep__rows { display:flex; flex-direction:column; gap:.55rem; margin-bottom:.6rem; }
.blkrep__row { border:1px solid #e5e7eb; border-radius:8px; background:#fff; }
.blkrep__rowbar { display:flex; align-items:center; justify-content:space-between; gap:.5rem; padding:.45rem .6rem; background:#f9fafb; border-bottom:1px solid #eef2f7; border-radius:8px 8px 0 0; }
.blkrep__num { font-size:.78rem; font-weight:700; color:#64748b; text-transform:uppercase; letter-spacing:.05em; }
.blkrep__rowacts { display:flex; gap:.2rem; }
.blkrep__fields { padding:.8rem; display:grid; gap:.8rem; grid-template-columns:repeat(2,minmax(0,1fr)); }
.blkrep__fields > .blkf { grid-column:1/-1; }
.blkrep__fields > .blkf--half { grid-column:span 1; }
.blkrep__add { padding:.45rem .8rem; font-size:.82rem; }

/* -------- Agregar bloque -------- */
.blkadd { position:relative; }
.blkadd__palette[hidden] { display:none; }  /* display:grid le gana a [hidden] */
.blkadd__palette { display:grid; gap:.5rem; grid-template-columns:repeat(auto-fill,minmax(230px,1fr)); margin-top:.8rem; padding:.9rem; background:#f8fafc; border:1px solid #e5e7eb; border-radius:10px; }
.blkadd__opt { text-align:left; background:#fff; border:1px solid #e5e7eb; border-radius:8px; padding:.75rem .85rem; cursor:pointer; transition:all .15s; display:block; }
.blkadd__opt:hover { border-color:#0f172a; box-shadow:0 4px 12px rgba(15,23,42,.08); transform:translateY(-1px); }
.blkadd__opt strong { display:block; font-size:.88rem; color:#0f172a; margin-bottom:.2rem; }
.blkadd__opt span { display:block; font-size:.78rem; color:#64748b; line-height:1.45; }
.blkadd__opt--adv { background:#fafafa; border-style:dashed; }

@media (max-width:720px) {
    .blkf__grid, .blkrep__fields { grid-template-columns:1fr; }
    .blkf--half { grid-column:1/-1; }
    .blkitem__summary { display:none; }
}
</style>

<script>
(function(){
    var root = document.querySelector('[data-blkedit]');
    if (!root) return;
    var list  = root.querySelector('[data-blk-list]');
    var empty = root.querySelector('[data-blk-empty]');
    var form  = root.closest('form');

    /* -------- utilidades -------- */
    function items(){ return Array.prototype.slice.call(list.querySelectorAll(':scope > [data-blk-item]')); }
    function refreshEmpty(){ if (empty) empty.hidden = items().length > 0; }
    function rows(rep){ return Array.prototype.slice.call(rep.querySelectorAll(':scope > [data-rep-rows] > [data-rep-row]')); }
    function renumberRows(rep){
        rows(rep).forEach(function(r, i){
            var n = r.querySelector('[data-rep-num]');
            if (n) n.textContent = i + 1;
        });
    }
    function summaryOf(item){
        // Primer campo de texto con contenido: title → q → code.
        var order = ['title','q','code'];
        for (var i = 0; i < order.length; i++) {
            var f = item.querySelector(':scope > [data-blk-fields] .blkf__grid > [data-field][data-key="' + order[i] + '"]');
            if (!f) continue;
            var inp = f.querySelector('[data-input]');
            if (inp && inp.value.trim()) return inp.value.trim().slice(0, 70);
        }
        return '';
    }
    function refreshSummary(item){
        var el = item.querySelector('[data-blk-summary]');
        if (el) el.textContent = summaryOf(item);
    }
    function expand(item, open){
        var body = item.querySelector(':scope > [data-blk-fields]');
        var tgl  = item.querySelector('[data-blk-toggle]');
        if (!body) return;
        body.hidden = !open;
        if (tgl) tgl.setAttribute('aria-expanded', open ? 'true' : 'false');
    }

    /* -------- nombres al enviar --------
       Recorre el DOM y arma blocks[i][f][clave] / blocks[i][f][rep][j][clave].
       Se hace acá y no en el HTML para que mover/duplicar/borrar no obligue a
       renumerar nada mientras se edita. */
    function nameFields(scope, prefix){
        scope.querySelectorAll(':scope > [data-field]').forEach(function(f){
            var key = f.dataset.key;
            if (f.hasAttribute('data-rep')) {
                rows(f).forEach(function(row, j){
                    var rf = row.querySelector('[data-row-fields]');
                    if (rf) nameFields(rf, prefix + '[' + key + '][' + j + ']');
                });
                return;
            }
            var input = f.querySelector('[data-input], [data-sif-input]');
            if (input) input.name = prefix + '[' + key + ']';
        });
    }
    function serialize(){
        var flag = document.querySelector('[data-blk-flag]');
        if (flag) flag.value = '1';   // avisa al servidor que la lista es válida
        items().forEach(function(item, i){
            var p = 'blocks[' + i + ']';
            var t = item.querySelector('[data-blk-type]');
            var a = item.querySelector('[data-blk-active]');
            if (t) t.name = p + '[type]';
            if (a) a.name = p + '[is_active]';
            // Sincroniza los editores de texto rico con su textarea oculto.
            item.querySelectorAll('[data-rt]').forEach(function(rt){
                var area = rt.querySelector('[data-rt-area]');
                var raw  = rt.querySelector('[data-input]');
                if (area && raw) raw.value = area.innerHTML.trim() === '<br>' ? '' : area.innerHTML;
            });
            var grid = item.querySelector(':scope > [data-blk-fields] > .blkf__grid');
            if (grid) nameFields(grid, p + '[f]');
        });
    }
    if (form) form.addEventListener('submit', serialize);

    /* -------- acciones sobre bloques -------- */
    root.addEventListener('click', function(e){
        var t = e.target;

        var tgl = t.closest('[data-blk-toggle]');
        if (tgl) {
            var it = tgl.closest('[data-blk-item]');
            expand(it, it.querySelector(':scope > [data-blk-fields]').hidden);
            return;
        }

        var up = t.closest('[data-blk-up]');
        if (up) {
            var it2 = up.closest('[data-blk-item]');
            if (it2.previousElementSibling) it2.parentNode.insertBefore(it2, it2.previousElementSibling);
            return;
        }
        var dn = t.closest('[data-blk-down]');
        if (dn) {
            var it3 = dn.closest('[data-blk-item]');
            if (it3.nextElementSibling) it3.parentNode.insertBefore(it3.nextElementSibling, it3);
            return;
        }
        var eye = t.closest('[data-blk-eye]');
        if (eye) {
            var it4 = eye.closest('[data-blk-item]');
            var flag = it4.querySelector('[data-blk-active]');
            var on = flag.value === '1';
            flag.value = on ? '0' : '1';
            it4.classList.toggle('blkitem--off', on);
            return;
        }
        var dup = t.closest('[data-blk-dup]');
        if (dup) {
            var it5 = dup.closest('[data-blk-item]');
            var copy = it5.cloneNode(true);
            it5.parentNode.insertBefore(copy, it5.nextSibling);
            refreshEmpty();
            return;
        }
        var del = t.closest('[data-blk-del]');
        if (del) {
            if (!confirm('¿Eliminar este bloque? El cambio se aplica al guardar la página.')) return;
            del.closest('[data-blk-item]').remove();
            refreshEmpty();
            return;
        }

        /* -------- repetidores -------- */
        var radd = t.closest('[data-rep-add]');
        if (radd) {
            var rep = radd.closest('[data-rep]');
            var tpl = rep.querySelector(':scope > [data-rep-tpl]');
            var holder = rep.querySelector(':scope > [data-rep-rows]');
            holder.appendChild(tpl.content.cloneNode(true));
            renumberRows(rep);
            return;
        }
        var rdel = t.closest('[data-rep-del]');
        if (rdel) {
            var row = rdel.closest('[data-rep-row]');
            var rep2 = rdel.closest('[data-rep]');
            row.remove();
            renumberRows(rep2);
            return;
        }
        var rup = t.closest('[data-rep-up]');
        if (rup) {
            var row2 = rup.closest('[data-rep-row]');
            if (row2.previousElementSibling) row2.parentNode.insertBefore(row2, row2.previousElementSibling);
            renumberRows(rup.closest('[data-rep]'));
            return;
        }
        var rdn = t.closest('[data-rep-down]');
        if (rdn) {
            var row3 = rdn.closest('[data-rep-row]');
            if (row3.nextElementSibling) row3.parentNode.insertBefore(row3.nextElementSibling, row3);
            renumberRows(rdn.closest('[data-rep]'));
            return;
        }

        /* -------- selector de íconos -------- */
        var ico = t.closest('[data-icon]');
        if (ico) {
            var wrap = ico.closest('[data-icons]');
            wrap.querySelectorAll('.blkicons__b').forEach(function(b){ b.classList.remove('is-on'); });
            ico.classList.add('is-on');
            var hidden = wrap.parentNode.querySelector('input[data-input]');
            if (hidden) hidden.value = ico.dataset.icon;
            return;
        }

        /* -------- texto rico -------- */
        var cmd = t.closest('[data-rt-cmd]');
        if (cmd) {
            var area = cmd.closest('[data-rt]').querySelector('[data-rt-area]');
            area.focus();
            document.execCommand(cmd.dataset.rtCmd, false, cmd.dataset.rtArg || null);
            return;
        }
        var lnk = t.closest('[data-rt-link]');
        if (lnk) {
            var area2 = lnk.closest('[data-rt]').querySelector('[data-rt-area]');
            area2.focus();
            var url = prompt('Dirección del enlace (ej: /contacto o https://…)');
            if (url) document.execCommand('createLink', false, url);
            return;
        }

        /* -------- paleta de bloques -------- */
        var openBtn = t.closest('[data-blk-add-open]');
        if (openBtn) {
            var pal = root.querySelector('[data-blk-palette]');
            pal.hidden = !pal.hidden;
            return;
        }
        var add = t.closest('[data-blk-add]');
        if (add) {
            var tpl2 = root.parentNode.querySelector('template[data-blk-tpl="' + add.dataset.blkAdd + '"]');
            if (!tpl2) return;
            var frag = tpl2.content.cloneNode(true);
            var node = frag.querySelector('[data-blk-item]');
            list.appendChild(frag);
            expand(node, true);
            root.querySelector('[data-blk-palette]').hidden = true;
            refreshEmpty();
            node.scrollIntoView({ behavior: 'smooth', block: 'center' });
            return;
        }
    });

    // El resumen de la barra sigue lo que se escribe en el título.
    root.addEventListener('input', function(e){
        var item = e.target.closest('[data-blk-item]');
        if (item) refreshSummary(item);
    });

    // Checkbox visible → input oculto (es el que viaja con el form).
    root.addEventListener('change', function(e){
        var cb = e.target.closest('[data-check]');
        if (!cb) return;
        var hidden = cb.closest('[data-field]').querySelector('input[data-input]');
        if (hidden) hidden.value = cb.checked ? '1' : '0';
    });

    refreshEmpty();
})();
</script>
