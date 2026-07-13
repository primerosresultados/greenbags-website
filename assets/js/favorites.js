/* ===========================================================================
 * GreenBags — Favoritos (wishlist client-side)
 * ---------------------------------------------------------------------------
 * No hay login obligatorio para guardar favoritos: se persisten en el
 * navegador (localStorage). Cada ítem es un snapshot mínimo del producto
 * {id, slug, name, img, price} tomado de los data-fav-* del botón, así la
 * página /favoritos se arma sin pegarle a la BD.
 *
 * Botones que participan (todos con data-fav-id):
 *   - .shop-wishlist   → ficha de producto
 *   - .shop-favbtn     → corazón overlay en las cards del catálogo
 *
 * Expuesto como window.GBFav por si otra vista lo necesita.
 * ========================================================================= */
(function () {
    'use strict';

    var KEY = 'gb_favorites';

    function read() {
        try {
            var raw = localStorage.getItem(KEY);
            var arr = raw ? JSON.parse(raw) : [];
            return Array.isArray(arr) ? arr : [];
        } catch (e) {
            return [];
        }
    }

    function write(list) {
        try {
            localStorage.setItem(KEY, JSON.stringify(list));
        } catch (e) { /* storage lleno o bloqueado: se ignora */ }
    }

    function has(id) {
        id = String(id);
        return read().some(function (it) { return String(it.id) === id; });
    }

    function toggle(item) {
        var list = read();
        var id = String(item.id);
        var idx = list.findIndex(function (it) { return String(it.id) === id; });
        if (idx >= 0) {
            list.splice(idx, 1);
        } else {
            list.unshift({
                id: item.id,
                slug: item.slug || '',
                name: item.name || '',
                img: item.img || '',
                price: item.price || ''
            });
        }
        write(list);
        return idx < 0; // true si quedó agregado
    }

    function remove(id) {
        id = String(id);
        write(read().filter(function (it) { return String(it.id) !== id; }));
    }

    function clear() { write([]); }

    /* ---------- UI sync ---------- */

    function syncBadge() {
        var badge = document.querySelector('.site-navbar__fav-badge');
        if (!badge) return;
        var n = read().length;
        badge.textContent = n;
        badge.hidden = n === 0;
    }

    function syncButtons() {
        var buttons = document.querySelectorAll('[data-fav-id]');
        buttons.forEach(function (btn) {
            var on = has(btn.getAttribute('data-fav-id'));
            btn.classList.toggle('is-fav', on);
            btn.setAttribute('aria-pressed', on ? 'true' : 'false');
        });
    }

    function itemFromButton(btn) {
        return {
            id: btn.getAttribute('data-fav-id'),
            slug: btn.getAttribute('data-fav-slug'),
            name: btn.getAttribute('data-fav-name'),
            img: btn.getAttribute('data-fav-img'),
            price: btn.getAttribute('data-fav-price')
        };
    }

    /* ---------- Página /favoritos ---------- */

    function esc(s) {
        return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
            return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
        });
    }

    function renderFavPage() {
        var root = document.getElementById('fav-page');
        if (!root) return;
        var list = read();
        var grid = root.querySelector('#fav-grid');
        var empty = root.querySelector('#fav-empty');
        var toolbar = root.querySelector('#fav-toolbar');

        if (!list.length) {
            if (grid) grid.innerHTML = '';
            if (empty) empty.hidden = false;
            if (toolbar) toolbar.hidden = true;
            return;
        }
        if (empty) empty.hidden = true;
        if (toolbar) toolbar.hidden = false;

        grid.innerHTML = list.map(function (it) {
            var url = '/producto/' + encodeURIComponent(it.slug);
            var img = it.img
                ? '<img src="' + esc(it.img) + '" alt="' + esc(it.name) + '" loading="lazy" onerror="this.closest(\'.fav-card__img\').classList.add(\'fav-card__img--empty\');this.remove();">'
                : '';
            return '' +
                '<div class="fav-card">' +
                    '<button type="button" class="fav-card__rm" data-fav-remove="' + esc(it.id) + '" aria-label="Quitar de favoritos">' +
                        '<svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>' +
                    '</button>' +
                    '<a class="fav-card__img' + (it.img ? '' : ' fav-card__img--empty') + '" href="' + url + '">' + img + '</a>' +
                    '<div class="fav-card__body">' +
                        '<a class="fav-card__name" href="' + url + '">' + esc(it.name) + '</a>' +
                        '<p class="fav-card__price">' + esc(it.price) + '</p>' +
                        '<a class="btn btn--small fav-card__cta" href="' + url + '">Ver producto</a>' +
                    '</div>' +
                '</div>';
        }).join('');
    }

    /* ---------- Eventos ---------- */

    document.addEventListener('click', function (e) {
        var favBtn = e.target.closest('[data-fav-id]');
        if (favBtn) {
            // En las cards el botón está fuera del <a>, pero por las dudas.
            e.preventDefault();
            e.stopPropagation();
            toggle(itemFromButton(favBtn));
            syncButtons();
            syncBadge();
            renderFavPage();
            return;
        }
        var rm = e.target.closest('[data-fav-remove]');
        if (rm) {
            e.preventDefault();
            remove(rm.getAttribute('data-fav-remove'));
            syncButtons();
            syncBadge();
            renderFavPage();
            return;
        }
        var clearBtn = e.target.closest('[data-fav-clear]');
        if (clearBtn) {
            e.preventDefault();
            if (read().length && !window.confirm('¿Vaciar todos tus favoritos?')) return;
            clear();
            syncButtons();
            syncBadge();
            renderFavPage();
        }
    });

    // Si el usuario tiene la lista abierta en dos pestañas, se mantienen en sync.
    window.addEventListener('storage', function (e) {
        if (e.key === KEY) { syncButtons(); syncBadge(); renderFavPage(); }
    });

    function init() {
        syncButtons();
        syncBadge();
        renderFavPage();
    }
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

    window.GBFav = { read: read, has: has, toggle: toggle, remove: remove, clear: clear, count: function () { return read().length; } };
})();
