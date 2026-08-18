/* ===========================================================================
 * GreenBags — Buscador de productos del header (modal AJAX)
 * ---------------------------------------------------------------------------
 * El botón de la lupa (#site-search-btn) abre un modal con un input que
 * consulta /buscar?ajax=1&q=... mientras se escribe y pinta los resultados sin
 * recargar la página.
 *
 * Decisiones que no se ven en el código:
 *   - El formulario apunta a /buscar de verdad, así Enter (y los navegadores
 *     sin JS, que llegan por el enlace del drawer) caen en la página completa
 *     de resultados con su grilla y su paginador.
 *   - Cada tecla cancela la petición anterior (AbortController): si el usuario
 *     escribe rápido, la respuesta vieja no puede pisar a la nueva.
 *   - Los resultados se arman con nodos del DOM y textContent, nunca con
 *     innerHTML sobre datos del servidor.
 *
 * Expuesto como window.GBSearch para poder abrirlo desde otras vistas.
 * ========================================================================= */
(function () {
    'use strict';

    var MIN_CHARS = 2;
    var DEBOUNCE  = 220;

    var modal   = document.getElementById('site-search');
    var input   = document.getElementById('site-search-input');
    var results = document.getElementById('site-search-results');
    var status  = document.getElementById('site-search-status');
    var clearBt = document.getElementById('site-search-clear');
    var openBt  = document.getElementById('site-search-btn');
    if (!modal || !input || !results || !status) return;

    var timer     = null;
    var ctrl      = null;   // AbortController de la petición en vuelo
    var lastQuery = '';
    var cache     = {};     // q → payload, evita repetir la misma consulta
    var items     = [];     // nodos <a> de resultados
    var active    = -1;     // índice resaltado con las flechas
    var prevFocus = null;

    /* ---------------- abrir / cerrar ---------------- */

    function open() {
        if (!modal.hidden) return;
        prevFocus = document.activeElement;
        modal.hidden = false;
        document.body.classList.add('has-search-open');
        if (openBt) openBt.setAttribute('aria-expanded', 'true');
        // Foco inmediato y otra pasada en el siguiente tick: en algunos
        // navegadores el elemento recién mostrado todavía no es enfocable.
        input.focus();
        setTimeout(function () { input.focus(); input.select(); }, 30);
    }

    function close() {
        if (modal.hidden) return;
        abort();
        modal.hidden = true;
        document.body.classList.remove('has-search-open');
        if (openBt) openBt.setAttribute('aria-expanded', 'false');
        if (prevFocus && prevFocus.focus) prevFocus.focus();
    }

    function abort() {
        if (timer) { clearTimeout(timer); timer = null; }
        if (ctrl)  { ctrl.abort(); ctrl = null; }
    }

    /* ---------------- render ---------------- */

    function reset() {
        results.textContent = '';
        items  = [];
        active = -1;
        input.setAttribute('aria-expanded', 'false');
    }

    function say(text) {
        status.textContent = text;
        status.hidden = text === '';
    }

    function itemNode(p) {
        var a = document.createElement('a');
        a.className = 'site-search__item';
        a.href = p.url;
        a.setAttribute('role', 'option');

        var fig = document.createElement('span');
        fig.className = 'site-search__thumb';
        if (p.img) {
            var img = document.createElement('img');
            img.src = p.img;
            img.alt = '';
            img.loading = 'lazy';
            img.addEventListener('error', function () {
                fig.classList.add('is-empty');
                img.remove();
            });
            fig.appendChild(img);
        } else {
            fig.classList.add('is-empty');
        }
        a.appendChild(fig);

        var body = document.createElement('span');
        body.className = 'site-search__item-body';

        var name = document.createElement('span');
        name.className = 'site-search__item-name';
        name.textContent = p.name;
        body.appendChild(name);

        if (p.sku) {
            var sku = document.createElement('span');
            sku.className = 'site-search__item-sku';
            sku.textContent = 'SKU ' + p.sku;
            body.appendChild(sku);
        }
        a.appendChild(body);

        var price = document.createElement('span');
        price.className = 'site-search__item-price';
        if (p.old) {
            var old = document.createElement('s');
            old.textContent = p.old;
            price.appendChild(old);
        }
        var now = document.createElement('strong');
        now.textContent = p.price;
        price.appendChild(now);
        a.appendChild(price);

        return a;
    }

    function render(data) {
        reset();

        if (!data.items.length) {
            say('No encontramos productos para “' + data.q + '”.');
            return;
        }

        data.items.forEach(function (p) {
            var node = itemNode(p);
            results.appendChild(node);
            items.push(node);
        });

        // Pie: link a la página completa cuando hay más de los que entran.
        var all = document.createElement('a');
        all.className = 'site-search__all';
        all.href = data.url;
        all.textContent = data.total > data.items.length
            ? 'Ver los ' + data.total + ' resultados'
            : 'Ver resultados en el catálogo';
        results.appendChild(all);
        items.push(all);

        input.setAttribute('aria-expanded', 'true');
        say(data.total === 1 ? '1 producto encontrado' : data.total + ' productos encontrados');
    }

    /* ---------------- consulta ---------------- */

    function search(q) {
        if (cache[q]) { render(cache[q]); return; }

        modal.classList.add('is-loading');
        ctrl = new AbortController();

        fetch('/buscar?ajax=1&q=' + encodeURIComponent(q), {
            signal: ctrl.signal,
            headers: { 'Accept': 'application/json' }
        })
            .then(function (r) {
                if (!r.ok) throw new Error('http ' + r.status);
                return r.json();
            })
            .then(function (data) {
                cache[q] = data;
                // Llegó tarde: el usuario ya está escribiendo otra cosa.
                if (input.value.trim() !== q) return;
                render(data);
            })
            .catch(function (e) {
                if (e.name === 'AbortError') return;
                reset();
                say('No pudimos buscar en este momento. Intenta de nuevo.');
            })
            .then(function () {
                modal.classList.remove('is-loading');
                ctrl = null;
            });
    }

    function onType() {
        var q = input.value.trim();
        if (clearBt) clearBt.hidden = q === '';
        if (q === lastQuery) return;
        lastQuery = q;

        abort();
        if (q.length < MIN_CHARS) {
            reset();
            modal.classList.remove('is-loading');
            say('Escribe al menos ' + MIN_CHARS + ' letras para ver resultados.');
            return;
        }
        timer = setTimeout(function () { search(q); }, DEBOUNCE);
    }

    /* ---------------- teclado ---------------- */

    function highlight(i) {
        if (active >= 0 && items[active]) items[active].classList.remove('is-active');
        active = i;
        if (active >= 0 && items[active]) {
            items[active].classList.add('is-active');
            items[active].scrollIntoView({ block: 'nearest' });
        }
    }

    function move(delta) {
        if (!items.length) return;
        var next = active + delta;
        if (next < 0) next = items.length - 1;
        if (next >= items.length) next = 0;
        highlight(next);
    }

    input.addEventListener('input', onType);
    input.addEventListener('keydown', function (e) {
        if (e.key === 'ArrowDown') { e.preventDefault(); move(1); }
        else if (e.key === 'ArrowUp') { e.preventDefault(); move(-1); }
        else if (e.key === 'Enter' && active >= 0 && items[active]) {
            // Con un resultado resaltado, Enter va a ese producto en vez de
            // mandar el formulario a la página de resultados.
            e.preventDefault();
            window.location.href = items[active].href;
        }
    });

    if (clearBt) {
        clearBt.addEventListener('click', function () {
            input.value = '';
            clearBt.hidden = true;
            lastQuery = '';
            abort();
            reset();
            say('Escribe al menos ' + MIN_CHARS + ' letras para ver resultados.');
            input.focus();
        });
    }

    if (openBt) {
        openBt.addEventListener('click', function (e) {
            e.preventDefault();
            open();
        });
    }

    // Enlaces "Buscar productos" del drawer mobile: abren el modal y cierran el
    // drawer; si el JS no cargó siguen siendo un <a href="/buscar"> normal.
    document.querySelectorAll('[data-search-open]').forEach(function (el) {
        el.addEventListener('click', function (e) {
            e.preventDefault();
            var dClose = document.getElementById('site-drawer-close');
            if (dClose) dClose.click();
            open();
        });
    });

    modal.querySelectorAll('[data-search-close]').forEach(function (el) {
        el.addEventListener('click', close);
    });

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape' && !modal.hidden) { close(); return; }
        // Atajo global: Ctrl/Cmd + K, salvo que se esté escribiendo en un campo.
        if ((e.ctrlKey || e.metaKey) && (e.key === 'k' || e.key === 'K')) {
            var t = e.target;
            var typing = t && (t.tagName === 'INPUT' || t.tagName === 'TEXTAREA' || t.isContentEditable);
            if (typing && t !== input) return;
            e.preventDefault();
            modal.hidden ? open() : close();
        }
    });

    window.GBSearch = { open: open, close: close };
})();
