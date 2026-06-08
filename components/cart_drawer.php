<?php
/**
 * Mini-cart drawer (slide-in desde la izquierda).
 * Se renderiza en TODAS las páginas del front (lo incluye layout.php). El
 * ícono del header (`#header-cart-btn`) lo abre con JS; sin JS el link sigue
 * llevando a /carrito.
 *
 * Auto-abre cuando viene de un add_to_cart exitoso (flash `cart_just_added`),
 * leído desde `data-cart-open="1"` en <body>.
 */
$items  = cartItems();
$totals = cartTotals();
$ret    = $_SERVER['REQUEST_URI'] ?? '/';
?>
<div class="cart-drawer__backdrop" id="cart-drawer-backdrop" aria-hidden="true"></div>
<aside class="cart-drawer" id="cart-drawer" aria-hidden="true" aria-labelledby="cart-drawer-title">
    <header class="cart-drawer__head">
        <h2 id="cart-drawer-title">
            Mi carrito
            <span class="cart-drawer__count" id="cart-drawer-count"><?= (int) $totals['qty'] ?></span>
        </h2>
        <button type="button" class="cart-drawer__close" id="cart-drawer-close" aria-label="Cerrar carrito">
            <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
    </header>

    <?php if (!$items): ?>
        <div class="cart-drawer__empty">
            <svg viewBox="0 0 64 64" width="64" height="64" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <circle cx="24" cy="54" r="3"/><circle cx="50" cy="54" r="3"/>
                <path d="M4 6h6l5 32a4 4 0 0 0 4 3h26a4 4 0 0 0 4-3l3-19H14"/>
            </svg>
            <p>Tu carrito está vacío.</p>
            <a href="/tienda" class="btn">Ir a la tienda</a>
        </div>
    <?php else: ?>
        <div class="cart-drawer__body">
            <?php foreach ($items as $it): $moq = max(1, (int) ($it['min_order_qty'] ?? 1)); ?>
                <article class="cart-drawer__item">
                    <a href="/producto/<?= htmlspecialchars($it['slug']) ?>" class="cart-drawer__thumb">
                        <?php if (!empty($it['thumb'])): ?>
                            <img src="<?= htmlspecialchars($it['thumb']) ?>" alt="<?= htmlspecialchars($it['name']) ?>" loading="lazy">
                        <?php else: ?>
                            <span class="cart-drawer__noimg"></span>
                        <?php endif; ?>
                    </a>
                    <div class="cart-drawer__info">
                        <a class="cart-drawer__name" href="/producto/<?= htmlspecialchars($it['slug']) ?>"><?= htmlspecialchars($it['name']) ?></a>
                        <?php if ($it['variation_label']): ?>
                            <p class="cart-drawer__var"><?= htmlspecialchars($it['variation_label']) ?></p>
                        <?php endif; ?>
                        <p class="cart-drawer__price">
                            <span class="cart-drawer__unit"><?= shopFormatPrice($it['unit_price']) ?></span>
                            <span class="cart-drawer__line"><?= shopFormatPrice($it['line_total']) ?></span>
                        </p>
                        <div class="cart-drawer__row">
                            <form method="post" action="/carrito" class="cart-drawer__stepper">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <input type="hidden" name="action" value="update_qty">
                                <input type="hidden" name="item_id" value="<?= (int) $it['id'] ?>">
                                <input type="hidden" name="return_to" value="<?= htmlspecialchars($ret) ?>">
                                <button type="submit" name="qty" value="<?= max($moq, (int) $it['qty'] - 1) ?>" class="cart-drawer__step" <?= (int) $it['qty'] <= $moq ? 'disabled' : '' ?> aria-label="Disminuir">−</button>
                                <span class="cart-drawer__qty"><?= (int) $it['qty'] ?></span>
                                <button type="submit" name="qty" value="<?= (int) $it['qty'] + 1 ?>" class="cart-drawer__step" aria-label="Aumentar">+</button>
                            </form>
                            <form method="post" action="/carrito" class="cart-drawer__rmform" onsubmit="return confirm('¿Quitar este producto?');">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="item_id" value="<?= (int) $it['id'] ?>">
                                <input type="hidden" name="return_to" value="<?= htmlspecialchars($ret) ?>">
                                <button type="submit" class="cart-drawer__rm" aria-label="Quitar del carrito">
                                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6M14 11v6"/></svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </article>
            <?php endforeach; ?>
        </div>
        <footer class="cart-drawer__foot">
            <div class="cart-drawer__totrow">
                <span>Subtotal</span>
                <strong><?= shopFormatPrice($totals['subtotal']) ?></strong>
            </div>
            <div class="cart-drawer__hint">Envío e impuestos se calculan al pagar.</div>
            <div class="cart-drawer__cta">
                <a href="/carrito" class="btn btn--ghost">Ver carrito</a>
                <a href="/checkout" class="btn cart-drawer__checkout">Finalizar compra</a>
            </div>
        </footer>
    <?php endif; ?>
</aside>

<script>
// Mini-cart: open/close + AJAX para qty/remove dentro del drawer (sin recargar).
// El bind está en delegación porque el contenido del drawer se reemplaza tras
// cada acción (no podemos depender de listeners atados a nodos viejos).
(function(){
    if (window.__cartDrawerBound) return; // idempotente: el drawer se re-incluye
    window.__cartDrawerBound = true;

    function $(id){ return document.getElementById(id); }
    function getDrawer(){ return $('cart-drawer'); }
    function getBackdrop(){ return $('cart-drawer-backdrop'); }

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

    // Click en el ícono del header.
    document.addEventListener('click', function(e){
        var trigger = e.target.closest('#header-cart-btn, #drawer-cart-btn');
        if (trigger){
            e.preventDefault();
            // Si el menú mobile estaba abierto, cerrarlo primero.
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
        if (e.target.closest('#cart-drawer-close')) { shut(); return; }
        if (e.target.closest('#cart-drawer-backdrop')) { shut(); return; }
    });
    document.addEventListener('keydown', function(e){ if (e.key === 'Escape') shut(); });

    // Actualiza los badges del cart en el header/drawer mobile.
    function refreshBadges(count){
        // navbar (todas las variantes).
        document.querySelectorAll('#header-cart-btn').forEach(function(el){
            var b = el.querySelector('.site-navbar__cart-badge');
            if (count > 0){
                if (!b){
                    b = document.createElement('span');
                    b.className = 'site-navbar__cart-badge';
                    el.appendChild(b);
                }
                b.textContent = count;
            } else if (b){
                b.remove();
            }
        });
        // drawer mobile.
        document.querySelectorAll('#drawer-cart-btn').forEach(function(el){
            var b = el.querySelector('.site-drawer__cart-badge');
            if (count > 0){
                if (!b){
                    b = document.createElement('span');
                    b.className = 'site-drawer__cart-badge';
                    el.appendChild(b);
                }
                b.textContent = count;
            } else if (b){
                b.remove();
            }
        });
    }

    // Intercepta submits de forms dentro del drawer → AJAX + reemplaza contenido.
    document.addEventListener('submit', function(e){
        var form = e.target.closest('#cart-drawer form');
        if (!form) return;
        e.preventDefault();
        if (form.__busy) return; form.__busy = true;

        var fd = new FormData(form);
        // Incluir el botón presionado si tiene name/value (para steppers +/-).
        if (e.submitter && e.submitter.name) fd.append(e.submitter.name, e.submitter.value);
        fd.set('from_drawer', '1');

        fetch('/carrito', { method: 'POST', body: fd, headers: { 'Accept': 'application/json' }, credentials: 'same-origin' })
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

    // Auto-abrir si venimos de un add_to_cart desde la ficha de producto
    // (el server marcó data-cart-open="1" via flash).
    if (document.body.getAttribute('data-cart-open') === '1') {
        setTimeout(open, 80);
    }
})();
</script>
