-- ============================================================================
-- CLIENTE: GreenBags — "Sobre GreenBags" alineada al rediseño del sitio.
-- ----------------------------------------------------------------------------
-- La página quedó plana tras la reescritura de contenido (044). Este rediseño
-- conserva EXACTAMENTE el copy aprobado por el cliente (PDF jun 2026) y le
-- aplica el lenguaje visual del home actual (bloque de marca de la 046):
--   - Hero en panel con gradiente suave de marca, textura de puntos, kicker
--     pill, foto con marco interior + chip y badge "+15 años" flotantes.
--   - "Una empresa chilena con foco en el detalle": copy + tarjeta de retiro
--     en bodega (misma nota de la 044, ahora como card con ícono).
--   - "Tres pilares": tarjetas con tile de ícono, hover lift y hairline verde.
--   - Cierre: banda CTA compacta hacia /contacto (reusa el dato "menos de
--     4 horas" del contact_intro aprobado en 044).
--   - Reveal-on-scroll progresivo (.js-reveal), igual que el home: sin JS o
--     con reduced-motion todo queda visible.
-- El h1 que el router imprime antes del body queda sr-only (no display:none)
-- para no perder semántica; el hero muestra su propio título aria-hidden.
--
-- UN SOLO statement a propósito. Pisa ediciones de admin sobre esta página
-- (mismo trade-off consciente que 030/031/032/044).
-- Al forkear el starter, borrar este archivo (ver docs/FORK_NEW_CLIENT.md).
-- ============================================================================

UPDATE pages SET body =
'<style>
/* El h1 del router queda solo para lectores de pantalla; el hero trae el suyo. */
.page > h1:first-child {
    position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px;
    overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; border: 0;
}
.gba {
    --gba-primary: var(--brand-primary, #51af3f);
    --gba-secondary: var(--brand-secondary, #a7dd98);
    --gba-ink: #0f172a;
    --gba-body: #475569;
    --gba-muted: #64748b;
    --gba-deep: #14532d;
    margin: 1.2rem 0 4.5rem;
    display: grid;
    gap: clamp(3rem, 6vw, 5rem);
}

/* ====== Piezas compartidas ====== */
.gba-kicker {
    display: inline-flex; align-items: center; gap: .45rem;
    margin: 0 0 1rem;
    font-size: .76rem; font-weight: 700; letter-spacing: .09em; text-transform: uppercase;
    color: var(--gba-primary);
    background: color-mix(in srgb, var(--gba-primary) 10%, #fff);
    border: 1px solid color-mix(in srgb, var(--gba-primary) 22%, #fff);
    padding: .4rem .85rem; border-radius: 999px;
}
.gba-kicker svg { width: 13px; height: 13px; flex: 0 0 auto; }
.gba-h2 {
    font-size: clamp(1.9rem, 3.2vw, 2.4rem);
    font-weight: 800; letter-spacing: -.01em;
    color: var(--gba-ink);
    margin: 0 0 1rem; line-height: 1.15;
}
@supports not (background: color-mix(in srgb, red, blue)) {
    .gba-kicker { background: #eef7ec; border-color: #cfe8c8; }
}

/* ====== Hero ====== */
.gba-hero {
    position: relative; overflow: hidden;
    display: grid; align-items: center;
    grid-template-columns: 1.05fr 1fr;
    gap: clamp(2rem, 4.5vw, 4rem);
    padding: clamp(1.6rem, 3.5vw, 3.25rem);
    border-radius: 24px;
    background:
        radial-gradient(720px 340px at 88% -10%, color-mix(in srgb, var(--gba-secondary) 38%, transparent), transparent 70%),
        linear-gradient(160deg, color-mix(in srgb, var(--gba-primary) 7%, #fff) 0%, #f7fbf6 55%, #fff 100%);
    border: 1px solid color-mix(in srgb, var(--gba-primary) 14%, #fff);
}
@supports not (background: color-mix(in srgb, red, blue)) {
    .gba-hero { background: linear-gradient(160deg, #eef7ec 0%, #f7fbf6 55%, #fff 100%); border-color: #ddeed8; }
}
.gba-hero::before {
    content: ""; position: absolute; right: -40px; top: -40px;
    width: 320px; height: 260px;
    background-image: radial-gradient(rgba(81, 175, 63, .38) 1.5px, transparent 1.5px);
    background-size: 18px 18px;
    -webkit-mask-image: radial-gradient(closest-side at 65% 35%, #000, transparent);
            mask-image: radial-gradient(closest-side at 65% 35%, #000, transparent);
    pointer-events: none;
}
.gba-hero__title {
    font-size: clamp(2.1rem, 3.8vw, 2.9rem);
    font-weight: 800; letter-spacing: -.015em;
    color: var(--gba-ink);
    margin: 0 0 1rem; line-height: 1.08;
}
.gba-hero__lead {
    font-size: clamp(1.04rem, 1.2vw, 1.16rem);
    color: var(--gba-body); line-height: 1.7;
    margin: 0 0 1.7rem; max-width: 52ch;
}
.gba-hero__actions { display: flex; flex-wrap: wrap; gap: .8rem; }
.gba-cta {
    padding: .85rem 1.5rem; font-size: .95rem; font-weight: 600;
    border-radius: 12px; gap: .55rem;
    box-shadow: 0 8px 18px color-mix(in srgb, var(--color-primary, #0f0f10) 22%, transparent);
}
.gba-cta svg { transition: transform .2s ease; }
.gba-cta:hover svg { transform: translateX(3px); }
.gba-cta-ghost {
    display: inline-flex; align-items: center; gap: .55rem;
    padding: .85rem 1.4rem; font-size: .95rem; font-weight: 600;
    border-radius: 12px; text-decoration: none;
    color: var(--gba-deep);
    background: #fff;
    border: 1px solid color-mix(in srgb, var(--gba-primary) 28%, #fff);
    transition: background .2s ease, border-color .2s ease;
}
.gba-cta-ghost:hover {
    background: color-mix(in srgb, var(--gba-primary) 8%, #fff);
    border-color: color-mix(in srgb, var(--gba-primary) 45%, #fff);
    color: var(--gba-deep); text-decoration: none;
}
@supports not (background: color-mix(in srgb, red, blue)) {
    .gba-cta { box-shadow: 0 8px 18px rgba(15, 15, 16, .22); }
    .gba-cta-ghost { border-color: #cfe8c8; }
    .gba-cta-ghost:hover { background: #eef7ec; border-color: #a7dd98; }
}
.gba-hero__media { position: relative; }
.gba-hero__media img {
    width: 100%; aspect-ratio: 4/3; border-radius: 18px; object-fit: cover; display: block;
    box-shadow: 0 26px 50px -22px rgba(13, 40, 24, .45);
}
.gba-hero__frame {
    position: absolute; inset: .8rem; border-radius: 12px;
    border: 1px solid rgba(255, 255, 255, .55);
    pointer-events: none;
}
.gba-hero__chip {
    position: absolute; top: 1rem; right: 1rem; z-index: 1;
    display: inline-flex; align-items: center; gap: .45rem;
    background: rgba(255, 255, 255, .92);
    -webkit-backdrop-filter: blur(6px); backdrop-filter: blur(6px);
    border-radius: 999px; padding: .45rem .85rem;
    font-size: .78rem; font-weight: 700; color: var(--gba-deep);
    box-shadow: 0 10px 22px rgba(13, 40, 24, .18);
}
.gba-hero__chip svg { width: 16px; height: 16px; color: var(--gba-primary); flex: 0 0 auto; }
.gba-hero__badge {
    position: absolute; left: 1rem; bottom: 1rem; z-index: 1;
    display: flex; align-items: center; gap: .6rem;
    background: #fff; border: 1px solid #eef2ee; border-radius: 14px;
    padding: .65rem .95rem;
    box-shadow: 0 14px 30px rgba(13, 40, 24, .22);
}
.gba-hero__badge-num {
    font-size: 1.7rem; font-weight: 800; line-height: 1; letter-spacing: -.02em;
    color: var(--gba-primary);
}
.gba-hero__badge-txt { font-size: .74rem; font-weight: 600; color: var(--gba-body); line-height: 1.25; }
@media (prefers-reduced-motion: no-preference) {
    .gba-hero__badge { animation: gbaFloat 5.5s ease-in-out infinite; }
}
@keyframes gbaFloat { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-7px); } }

/* ====== Quiénes somos + retiro en bodega ====== */
.gba-who {
    display: grid; align-items: start;
    grid-template-columns: 1.3fr .9fr;
    gap: clamp(2rem, 4.5vw, 4rem);
}
.gba-who p { font-size: 1.02rem; color: var(--gba-body); line-height: 1.75; margin: 0 0 1rem; max-width: 62ch; }
.gba-who p:last-child { margin-bottom: 0; }
.gba-loc {
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
}

/* ====== Pilares ====== */
.gba-pillars { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 1.1rem; }
.gba-pillar {
    position: relative; overflow: hidden;
    background: #fff;
    border: 1px solid color-mix(in srgb, var(--gba-primary) 14%, #fff);
    border-radius: 18px;
    padding: 1.7rem 1.5rem;
    transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease;
}
.gba-pillar::after {
    content: ""; position: absolute; left: 0; right: 0; top: 0; height: 3px;
    background: linear-gradient(90deg, var(--gba-primary), var(--gba-secondary));
    transform: scaleX(0); transform-origin: left;
    transition: transform .3s ease;
}
.gba-pillar:hover {
    transform: translateY(-4px);
    box-shadow: 0 22px 44px -22px rgba(13, 40, 24, .3);
    border-color: color-mix(in srgb, var(--gba-primary) 35%, #fff);
}
.gba-pillar:hover::after { transform: scaleX(1); }
.gba-pillar__ico {
    display: grid; place-items: center;
    width: 46px; height: 46px; border-radius: 12px;
    background: color-mix(in srgb, var(--gba-primary) 12%, #fff);
    border: 1px solid color-mix(in srgb, var(--gba-primary) 20%, #fff);
    color: var(--gba-primary);
    margin-bottom: 1.1rem;
}
.gba-pillar__ico svg { width: 22px; height: 22px; }
.gba-pillar h3 { font-size: 1.08rem; font-weight: 700; color: var(--gba-ink); margin: 0 0 .5rem; letter-spacing: -.01em; }
.gba-pillar p { font-size: .95rem; color: var(--gba-muted); line-height: 1.6; margin: 0; }
@supports not (background: color-mix(in srgb, red, blue)) {
    .gba-pillar { border-color: #ddeed8; }
    .gba-pillar:hover { border-color: #a7dd98; }
    .gba-pillar__ico { background: #eef7ec; border-color: #d5ebcf; }
}

/* ====== CTA final ====== */
.gba-final {
    position: relative; overflow: hidden;
    display: grid; align-items: center;
    grid-template-columns: 1.6fr auto;
    gap: clamp(1.5rem, 3vw, 2.5rem);
    padding: clamp(1.8rem, 3.5vw, 2.8rem);
    border-radius: 24px;
    color: #fff;
    background:
        radial-gradient(600px 300px at 90% -20%, color-mix(in srgb, var(--gba-secondary) 45%, transparent), transparent 70%),
        linear-gradient(135deg, #123f23 0%, var(--gba-deep) 55%, #1a6b36 100%);
}
@supports not (background: color-mix(in srgb, red, blue)) {
    .gba-final { background: linear-gradient(135deg, #123f23 0%, #14532d 55%, #1a6b36 100%); }
}
.gba-final::before {
    content: ""; position: absolute; left: -30px; bottom: -50px;
    width: 260px; height: 220px;
    background-image: radial-gradient(rgba(255, 255, 255, .35) 1.5px, transparent 1.5px);
    background-size: 18px 18px;
    -webkit-mask-image: radial-gradient(closest-side at 35% 65%, #000, transparent);
            mask-image: radial-gradient(closest-side at 35% 65%, #000, transparent);
    pointer-events: none;
}
.gba-final h2 { font-size: clamp(1.5rem, 2.6vw, 2rem); font-weight: 800; letter-spacing: -.01em; margin: 0 0 .5rem; color: #fff; line-height: 1.2; }
.gba-final p { font-size: 1rem; color: rgba(255, 255, 255, .85); line-height: 1.6; margin: 0; max-width: 52ch; }
.gba-final__btn {
    position: relative; z-index: 1;
    display: inline-flex; align-items: center; gap: .55rem;
    padding: .95rem 1.7rem;
    background: #fff; color: var(--gba-deep);
    border-radius: 12px; text-decoration: none;
    font-weight: 700; font-size: .98rem;
    box-shadow: 0 14px 30px -12px rgba(0, 0, 0, .45);
    transition: transform .2s ease, box-shadow .2s ease;
    justify-self: end;
}
.gba-final__btn:hover {
    transform: translateY(-2px);
    color: var(--gba-deep); text-decoration: none;
    box-shadow: 0 20px 38px -12px rgba(0, 0, 0, .5);
}
.gba-final__btn svg { width: 16px; height: 16px; transition: transform .2s ease; }
.gba-final__btn:hover svg { transform: translateX(3px); }

/* ====== Reveal-on-scroll (solo con JS y sin reduced-motion) ====== */
@media (prefers-reduced-motion: no-preference) {
    .gba.js-reveal [data-reveal] {
        opacity: 0; transform: translateY(22px);
        transition:
            opacity .65s ease var(--reveal-delay, 0s),
            transform .65s cubic-bezier(.22, .61, .36, 1) var(--reveal-delay, 0s);
    }
    .gba.js-reveal [data-reveal].is-in { opacity: 1; transform: none; }
}

/* ====== Mobile ====== */
@media (max-width: 800px) {
    .gba-hero, .gba-who, .gba-final { grid-template-columns: 1fr; }
    .gba-loc { margin-top: 0; }
    .gba-final__btn { justify-self: stretch; justify-content: center; }
}
@media (max-width: 640px) {
    .gba { margin-top: .6rem; gap: 2.6rem; }
    .gba-hero { padding: 1.2rem 1.2rem 1.4rem; border-radius: 18px; }
    .gba-hero::before { width: 220px; height: 180px; background-size: 15px 15px; }
    .gba-hero__media img { aspect-ratio: 16/10; border-radius: 12px; }
    .gba-hero__frame { inset: .55rem; border-radius: 8px; }
    .gba-hero__chip { top: .7rem; right: .7rem; font-size: .72rem; padding: .35rem .7rem; }
    .gba-hero__badge { left: .7rem; bottom: .7rem; padding: .5rem .75rem; border-radius: 12px; }
    .gba-hero__badge-num { font-size: 1.35rem; }
    .gba-hero__badge-txt { font-size: .68rem; }
    .gba-hero__actions a { flex: 1 1 100%; justify-content: center; }
}
</style>

<div class="gba" id="gba-root">

    <!-- ====== Hero ====== -->
    <header class="gba-hero">
        <div class="gba-hero__copy">
            <p class="gba-kicker" data-reveal>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0Z"/><circle cx="12" cy="10" r="3"/></svg>
                Empresa chilena
            </p>
            <p class="gba-hero__title" aria-hidden="true" data-reveal style="--reveal-delay:.08s">Sobre GreenBags</p>
            <p class="gba-hero__lead" data-reveal style="--reveal-delay:.16s">GreenBags nació con la misión de entregar a las empresas soluciones de packaging, higiene y aseo industrial que combinen calidad, rapidez y responsabilidad ambiental.</p>
            <div class="gba-hero__actions" data-reveal style="--reveal-delay:.24s">
                <a href="/catalogo" class="btn gba-cta">
                    <span>Ver catálogo</span>
                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>
                <a href="/contacto" class="gba-cta-ghost">Contáctanos</a>
            </div>
        </div>
        <div class="gba-hero__media" data-reveal style="--reveal-delay:.12s">
            <img src="/uploads/library/greenbags/eco-sustentable.jpg" alt="Compromiso ecológico de GreenBags" loading="lazy">
            <span class="gba-hero__frame" aria-hidden="true"></span>
            <div class="gba-hero__chip" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/></svg>
                <span>Responsabilidad ambiental</span>
            </div>
            <div class="gba-hero__badge" aria-hidden="true">
                <span class="gba-hero__badge-num">+15</span>
                <span class="gba-hero__badge-txt">años de<br>experiencia</span>
            </div>
        </div>
    </header>

    <!-- ====== Quiénes somos + retiro en bodega ====== -->
    <section class="gba-who">
        <div class="gba-who__copy">
            <p class="gba-kicker" data-reveal>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                Quiénes somos
            </p>
            <h2 class="gba-h2" data-reveal style="--reveal-delay:.08s">Una empresa chilena con foco en el detalle</h2>
            <p data-reveal style="--reveal-delay:.16s">Después de más de 15 años en el rubro, somos una alternativa real para quienes valoran la atención cercana y necesitan un proveedor que cumpla. Sin intermediarios: trabajas directamente con quienes toman las decisiones.</p>
            <p data-reveal style="--reveal-delay:.24s">Acompañamos a clientes de canal Horeca, retail, industria y emprendedores, con productos biodegradables y compostables certificados y despachos confiables en 24-48 horas dentro de la Región Metropolitana.</p>
        </div>
        <aside class="gba-loc" data-reveal style="--reveal-delay:.2s">
            <span class="gba-loc__ico" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M3 21V8l9-5 9 5v13"/><path d="M3 21h18"/><path d="M9 21v-6h6v6"/></svg>
            </span>
            <strong>Retiro en bodega</strong>
            <p>Lope de Vega 4516, Estación Central, previa coordinación.</p>
        </aside>
    </section>

    <!-- ====== Pilares ====== -->
    <section>
        <p class="gba-kicker" data-reveal>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 3v2M12 19v2M5.6 5.6l1.4 1.4M17 17l1.4 1.4M3 12h2M19 12h2M5.6 18.4 7 17M17 7l1.4-1.4"/><circle cx="12" cy="12" r="4"/></svg>
            Lo que nos define
        </p>
        <h2 class="gba-h2" data-reveal style="--reveal-delay:.08s">Tres pilares que marcan la diferencia</h2>
        <div class="gba-pillars">
            <div class="gba-pillar" data-reveal style="--reveal-delay:.14s">
                <span class="gba-pillar__ico" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
                </span>
                <h3>Atención cercana</h3>
                <p>Hablas con quienes resuelven, sin call centers ni capas intermedias.</p>
            </div>
            <div class="gba-pillar" data-reveal style="--reveal-delay:.22s">
                <span class="gba-pillar__ico" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/></svg>
                </span>
                <h3>Sustentables y certificados</h3>
                <p>Productos biodegradables y compostables certificados, alineados a la Ley REP y políticas ESG.</p>
            </div>
            <div class="gba-pillar" data-reveal style="--reveal-delay:.3s">
                <span class="gba-pillar__ico" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2 3 14h7l-1 8 10-12h-7l1-8z"/></svg>
                </span>
                <h3>Despachos en 24-48 horas</h3>
                <p>Logística confiable en la Región Metropolitana y cobertura nacional coordinada.</p>
            </div>
        </div>
    </section>

    <!-- ====== CTA final ====== -->
    <section class="gba-final" data-reveal>
        <div>
            <h2>¿Conversamos sobre tu próximo pedido?</h2>
            <p>Escríbenos por el canal que más te acomode; respondemos en horario hábil, normalmente en menos de 4 horas.</p>
        </div>
        <a href="/contacto" class="gba-final__btn">
            <span>Contáctanos</span>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
        </a>
    </section>

</div>

<script>
(function(){
    var root = document.getElementById("gba-root");
    if (!root || !("IntersectionObserver" in window)) return;
    root.classList.add("js-reveal");
    var io = new IntersectionObserver(function(entries){
        entries.forEach(function(e){
            if (e.isIntersecting) { e.target.classList.add("is-in"); io.unobserve(e.target); }
        });
    }, { threshold: .15, rootMargin: "0px 0px -8% 0px" });
    root.querySelectorAll("[data-reveal]").forEach(function(el){ io.observe(el); });
})();
</script>'
WHERE slug = 'sobre-greenbags';
