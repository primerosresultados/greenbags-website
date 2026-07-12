-- ============================================================================
-- CLIENTE: GreenBags — Rediseñar la tarjeta "Retiro en bodega" (Sobre GreenBags).
-- ----------------------------------------------------------------------------
-- La tarjeta .gba-loc de la página "Sobre GreenBags" (migración 047) quedaba
-- muy plana. Este cambio le da más DISEÑO y jerarquía (no solo color):
--   - Eyebrow "Punto de retiro" + tile de ícono sólido, en una fila superior.
--   - Dirección en grande y con contraste; la comuna queda como subtítulo.
--   - Nota "Previa coordinación" como chip con ícono de reloj.
--   - Círculo decorativo de fondo + barra de acento izquierda flotante.
--   - Fondo mayormente blanco: el verde es acento, no relleno.
-- Estrategia: dos REPLACE quirúrgicos por slug (CSS + HTML), igual que la 051.
-- Idempotente: si el markup nuevo ya está aplicado, los REPLACE no hacen nada.
-- Se conserva el fallback @supports para navegadores sin color-mix().
-- ============================================================================

-- 1. CSS del card ------------------------------------------------------------
UPDATE pages
   SET body = REPLACE(
       body,
'.gba-loc {
    position: relative; overflow: hidden;
    background: #fff;
    border: 1px solid color-mix(in srgb, var(--gba-primary) 18%, #fff);
    border-radius: 18px;
    padding: 1.6rem;
    box-shadow: 0 18px 40px -24px rgba(13, 40, 24, .35);
    margin-top: 3.4rem;
}
.gba-loc::before {
    content: ""; position: absolute; left: 0; top: 0; bottom: 0; width: 4px;
    background: linear-gradient(180deg, var(--gba-primary), var(--gba-secondary));
    border-radius: 0 4px 4px 0;
}
.gba-loc__ico {
    display: grid; place-items: center;
    width: 46px; height: 46px; border-radius: 12px;
    background: color-mix(in srgb, var(--gba-primary) 12%, #fff);
    border: 1px solid color-mix(in srgb, var(--gba-primary) 20%, #fff);
    color: var(--gba-primary);
    margin-bottom: 1rem;
}
.gba-loc__ico svg { width: 22px; height: 22px; }
.gba-loc strong { display: block; font-size: 1.05rem; font-weight: 700; color: var(--gba-ink); margin-bottom: .35rem; }
.gba-loc p { font-size: .95rem; color: var(--gba-muted); line-height: 1.6; margin: 0; }
@supports not (background: color-mix(in srgb, red, blue)) {
    .gba-loc { border-color: #ddeed8; }
    .gba-loc__ico { background: #eef7ec; border-color: #d5ebcf; }
}',
'.gba-loc {
    position: relative; overflow: hidden;
    background: #fff;
    border: 1px solid color-mix(in srgb, var(--gba-primary) 22%, #e6ece6);
    border-radius: 20px;
    padding: 1.9rem;
    box-shadow: 0 22px 46px -26px rgba(13, 40, 24, .3);
    margin-top: 3.4rem;
}
.gba-loc::after {
    content: ""; position: absolute; right: -34px; top: -34px;
    width: 150px; height: 150px; border-radius: 50%;
    background: color-mix(in srgb, var(--gba-primary) 8%, #fff);
    z-index: 0;
}
.gba-loc::before {
    content: ""; position: absolute; left: 0; top: 1.7rem; bottom: 1.7rem; width: 4px;
    background: linear-gradient(180deg, var(--gba-primary), var(--gba-secondary));
    border-radius: 0 4px 4px 0;
    z-index: 1;
}
.gba-loc > * { position: relative; z-index: 1; }
.gba-loc__head { display: flex; align-items: center; gap: .75rem; margin-bottom: 1.15rem; }
.gba-loc__ico {
    display: grid; place-items: center;
    width: 46px; height: 46px; border-radius: 13px; flex: 0 0 auto;
    background: linear-gradient(140deg, var(--gba-primary), var(--gba-deep));
    color: #fff;
    box-shadow: 0 11px 22px -11px color-mix(in srgb, var(--gba-primary) 65%, transparent);
}
.gba-loc__ico svg { width: 22px; height: 22px; }
.gba-loc__eyebrow {
    font-size: .72rem; font-weight: 700; letter-spacing: .11em; text-transform: uppercase;
    color: var(--gba-primary);
}
.gba-loc strong { display: block; font-size: 1.15rem; font-weight: 800; color: var(--gba-ink); margin-bottom: .55rem; letter-spacing: -.01em; }
.gba-loc__addr { font-size: 1.18rem; font-weight: 700; color: var(--gba-ink); line-height: 1.3; margin: 0; }
.gba-loc__addr span { display: block; font-size: .95rem; font-weight: 500; color: var(--gba-muted); margin-top: .2rem; }
.gba-loc__note {
    display: inline-flex; align-items: center; gap: .4rem;
    margin: 1.15rem 0 0; padding: .42rem .8rem;
    font-size: .82rem; font-weight: 600; color: var(--gba-primary);
    background: color-mix(in srgb, var(--gba-primary) 10%, #fff);
    border: 1px solid color-mix(in srgb, var(--gba-primary) 20%, #fff);
    border-radius: 999px;
}
.gba-loc__note svg { width: 14px; height: 14px; flex: 0 0 auto; }
@supports not (background: color-mix(in srgb, red, blue)) {
    .gba-loc { border-color: #d5ebcf; }
    .gba-loc::after { background: #f2f8f0; }
    .gba-loc__ico { background: linear-gradient(140deg, #51af3f, #14532d); }
    .gba-loc__note { background: #eef7ec; border-color: #d5ebcf; color: #3f9330; }
}'
   )
 WHERE slug = 'sobre-greenbags';

-- 2. HTML del card -----------------------------------------------------------
UPDATE pages
   SET body = REPLACE(
       body,
'        <aside class="gba-loc" data-reveal style="--reveal-delay:.2s">
            <span class="gba-loc__ico" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M3 21V8l9-5 9 5v13"/><path d="M3 21h18"/><path d="M9 21v-6h6v6"/></svg>
            </span>
            <strong>Retiro en bodega</strong>
            <p>Lope de Vega 4516, Estación Central, previa coordinación.</p>
        </aside>',
'        <aside class="gba-loc" data-reveal style="--reveal-delay:.2s">
            <div class="gba-loc__head">
                <span class="gba-loc__ico" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M3 21V8l9-5 9 5v13"/><path d="M3 21h18"/><path d="M9 21v-6h6v6"/></svg>
                </span>
                <span class="gba-loc__eyebrow">Punto de retiro</span>
            </div>
            <strong>Retiro en bodega</strong>
            <p class="gba-loc__addr">Lope de Vega 4516<span>Estación Central</span></p>
            <p class="gba-loc__note">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/></svg>
                Previa coordinación
            </p>
        </aside>'
   )
 WHERE slug = 'sobre-greenbags';
