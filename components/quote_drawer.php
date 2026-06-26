<?php
/*
 * Mini-cotización (drawer slide-in desde la izquierda).
 * ------------------------------------------------------------
 * Misma UX que cart_drawer pero apuntando a /cotizacion. Se renderiza en cada
 * página vía layout.php cuando `quotes_enabled = 1`. El ícono del header
 * (#header-quote-btn) lo abre con JS; sin JS, el link sigue llevando a
 * /cotizacion.
 *
 * Reusa las clases del cart-drawer para no duplicar CSS. Selectores
 * específicos: #quote-drawer, #quote-drawer-backdrop, #quote-drawer-count,
 * #quote-drawer-close, #header-quote-btn, #drawer-quote-btn.
 * ------------------------------------------------------------
 */
$items  = quoteItems();
$totals = quoteTotals();
$set    = quoteSettings();
$ret    = $_SERVER['REQUEST_URI'] ?? '/';
?>
<div class="cart-drawer__backdrop" id="quote-drawer-backdrop" aria-hidden="true"></div>
<aside class="cart-drawer" id="quote-drawer" aria-hidden="true" aria-labelledby="quote-drawer-title">
    <header class="cart-drawer__head">
        <h2 id="quote-drawer-title">
            <?= htmlspecialchars($set['drawer_title']) ?>
            <span class="cart-drawer__count" id="quote-drawer-count"><?= (int) $totals['qty'] ?></span>
        </h2>
        <button type="button" class="cart-drawer__close" id="quote-drawer-close" aria-label="Cerrar cotización">
            <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
    </header>

    <?php if (!$items): ?>
        <div class="cart-drawer__empty">
            <svg viewBox="0 0 64 64" width="64" height="64" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path d="M14 6h26l8 8v44H14z"/><polyline points="40 6 40 14 48 14"/><line x1="20" y1="28" x2="42" y2="28"/><line x1="20" y1="36" x2="42" y2="36"/><line x1="20" y1="44" x2="36" y2="44"/>
            </svg>
            <p>Todavía no agregaste productos a tu cotización.</p>
            <a href="/catalogo" class="btn">Ver catálogo</a>
        </div>
    <?php else: ?>
        <div class="cart-drawer__body">
            <?php foreach ($items as $it): ?>
                <article class="cart-drawer__item">
                    <a href="<?= !empty($it['product_slug']) ? '/producto/' . htmlspecialchars($it['product_slug']) : '#' ?>" class="cart-drawer__thumb">
                        <?php if (!empty($it['thumb'])): ?>
                            <img src="<?= htmlspecialchars($it['thumb']) ?>" alt="<?= htmlspecialchars($it['name_snapshot']) ?>" loading="lazy">
                        <?php else: ?>
                            <span class="cart-drawer__noimg"></span>
                        <?php endif; ?>
                    </a>
                    <div class="cart-drawer__info">
                        <a class="cart-drawer__name" href="<?= !empty($it['product_slug']) ? '/producto/' . htmlspecialchars($it['product_slug']) : '#' ?>"><?= htmlspecialchars($it['name_snapshot']) ?></a>
                        <?php if (!empty($it['sku_snapshot'])): ?>
                            <p class="cart-drawer__var">SKU: <?= htmlspecialchars($it['sku_snapshot']) ?></p>
                        <?php endif; ?>
                        <?php if ($set['show_prices'] && $it['unit_price_est'] !== null): ?>
                            <p class="cart-drawer__price">
                                <span class="cart-drawer__unit"><?= shopFormatPrice($it['unit_price_est']) ?></span>
                                <span class="cart-drawer__line"><?= shopFormatPrice($it['line_total_est']) ?></span>
                            </p>
                        <?php endif; ?>
                        <div class="cart-drawer__row">
                            <form method="post" action="/cotizacion" class="cart-drawer__stepper">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <input type="hidden" name="action" value="update_qty">
                                <input type="hidden" name="item_id" value="<?= (int) $it['id'] ?>">
                                <input type="hidden" name="return_to" value="<?= htmlspecialchars($ret) ?>">
                                <button type="submit" name="qty" value="<?= max(1, (int) $it['qty'] - 1) ?>" class="cart-drawer__step" <?= (int) $it['qty'] <= 1 ? 'disabled' : '' ?> aria-label="Disminuir">−</button>
                                <span class="cart-drawer__qty"><?= (int) $it['qty'] ?></span>
                                <button type="submit" name="qty" value="<?= (int) $it['qty'] + 1 ?>" class="cart-drawer__step" aria-label="Aumentar">+</button>
                            </form>
                            <form method="post" action="/cotizacion" class="cart-drawer__rmform" onsubmit="return confirm('¿Quitar este producto?');">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="item_id" value="<?= (int) $it['id'] ?>">
                                <input type="hidden" name="return_to" value="<?= htmlspecialchars($ret) ?>">
                                <button type="submit" class="cart-drawer__rm" aria-label="Quitar de la cotización">
                                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6M14 11v6"/></svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </article>
            <?php endforeach; ?>
        </div>
        <footer class="cart-drawer__foot">
            <?php if ($set['show_prices'] && $totals['subtotal_est'] !== null): ?>
                <div class="cart-drawer__totrow">
                    <span>Estimado</span>
                    <strong><?= shopFormatPrice($totals['subtotal_est']) ?></strong>
                </div>
            <?php endif; ?>
            <div class="cart-drawer__hint">Te enviamos la propuesta final por email tras revisar tu pedido.</div>
            <div class="cart-drawer__cta">
                <a href="/cotizacion" class="btn cart-drawer__checkout"><?= htmlspecialchars($set['submit_label']) ?></a>
            </div>
        </footer>
    <?php endif; ?>
</aside>

<script>
// Mini-cotización: open/close + AJAX para qty/remove dentro del drawer.
(function(){
    if (window.__quoteDrawerBound) return;
    window.__quoteDrawerBound = true;

    function $(id){ return document.getElementById(id); }
    function getDrawer(){ return $('quote-drawer'); }
    function getBackdrop(){ return $('quote-drawer-backdrop'); }

    function open(){
        var d = getDrawer(), b = getBackdrop();
        if (!d || !b) return;
        d.classList.add('is-open'); b.classList.add('is-open');
        d.setAttribute('aria-hidden','false');
        document.body.style.overflow = 'hidden';
    }
    function shut(){
        var d = getDrawer(), b = getBackdrop();
        if (!d || !b) return;
        d.classList.remove('is-open'); b.classList.remove('is-open');
        d.setAttribute('aria-hidden','true');
        document.body.style.overflow = '';
    }

    document.addEventListener('click', function(e){
        var trigger = e.target.closest('#header-quote-btn, #drawer-quote-btn');
        if (trigger){
            e.preventDefault();
            var siteDrawer = $('site-drawer');
            if (siteDrawer && siteDrawer.classList.contains('is-open')) {
                siteDrawer.classList.remove('is-open');
                var sb = $('site-drawer-backdrop'); if (sb) sb.classList.remove('is-open');
                var bg = $('site-burger'); if (bg) bg.classList.remove('is-open');
                siteDrawer.setAttribute('aria-hidden','true');
                setTimeout(open, 120);
            } else {
                open();
            }
            return;
        }
        if (e.target.closest('#quote-drawer-close')) { shut(); return; }
        if (e.target.closest('#quote-drawer-backdrop')) { shut(); return; }
    });
    document.addEventListener('keydown', function(e){ if (e.key === 'Escape') shut(); });

    function refreshBadges(count){
        document.querySelectorAll('#header-quote-btn').forEach(function(el){
            var b = el.querySelector('.site-navbar__cart-badge');
            if (count > 0){
                if (!b){ b = document.createElement('span'); b.className = 'site-navbar__cart-badge'; el.appendChild(b); }
                b.textContent = count;
            } else if (b){ b.remove(); }
        });
        document.querySelectorAll('#drawer-quote-btn').forEach(function(el){
            var b = el.querySelector('.site-drawer__cart-badge');
            if (count > 0){
                if (!b){ b = document.createElement('span'); b.className = 'site-drawer__cart-badge'; el.appendChild(b); }
                b.textContent = count;
            } else if (b){ b.remove(); }
        });
    }

    document.addEventListener('submit', function(e){
        var form = e.target.closest('#quote-drawer form');
        if (!form) return;
        e.preventDefault();
        if (form.__busy) return; form.__busy = true;

        var fd = new FormData(form);
        if (e.submitter && e.submitter.name) fd.append(e.submitter.name, e.submitter.value);
        fd.set('from_drawer', '1');

        fetch('/cotizacion', { method: 'POST', body: fd, headers: { 'Accept': 'application/json' }, credentials: 'same-origin' })
            .then(function(r){ return r.json(); })
            .then(function(j){
                if (j && typeof j.innerHtml === 'string'){
                    var d = getDrawer();
                    if (d) d.innerHTML = j.innerHtml;
                }
                if (j && typeof j.count === 'number') refreshBadges(j.count);
            })
            .catch(function(){})
            .finally(function(){ form.__busy = false; });
    });

    if (document.body.getAttribute('data-quote-open') === '1') {
        setTimeout(open, 80);
    }
})();
</script>
