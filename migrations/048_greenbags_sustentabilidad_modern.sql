-- ============================================================================
-- CLIENTE: GreenBags — "Compromiso sustentable" alineada al rediseño del sitio.
-- ----------------------------------------------------------------------------
-- Igual que la 047 hizo con "Sobre GreenBags", esta migración le da a
-- /sustentabilidad el lenguaje visual del home (bloque de marca de la 046) y
-- de la página "Sobre GreenBags", conservando EXACTAMENTE el copy aprobado por
-- el cliente (PDF jun 2026, punto 13):
--   - Hero en panel con gradiente de marca, textura de puntos, kicker pill,
--     foto (eco-sustentable.jpg) con marco interior + chip y badge flotantes.
--   - "Marco legal: Ley 21.368" con badge "Info en actualización" y las tres
--     tarjetas (plásticos de un solo uso / compostabilidad / Ley REP) como
--     pilares con tile de ícono y hover.
--   - "Certificaciones" como panel-nota con los enlaces de referencia.
--   - CTA final hacia el catálogo.
--   - Reveal-on-scroll progresivo (.js-reveal): sin JS todo queda visible.
-- El h1 del router queda sr-only (no display:none); el hero trae su título.
-- Prefijo .gbs (independiente de la 047 .gba): cada página trae su CSS inline.
--
-- UN SOLO statement. Pisa ediciones de admin sobre esta página (mismo
-- trade-off consciente que 044). Al forkear, borrar (ver docs/FORK_NEW_CLIENT).
-- ============================================================================

UPDATE pages SET body =
'<style>
/* El h1 del router queda solo para lectores de pantalla; el hero trae el suyo. */
.page > h1:first-child {
    position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px;
    overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; border: 0;
}
.gbs {
    --gbs-primary: var(--brand-primary, #51af3f);
    --gbs-secondary: var(--brand-secondary, #a7dd98);
    --gbs-ink: #0f172a;
    --gbs-body: #475569;
    --gbs-muted: #64748b;
    --gbs-deep: #14532d;
    margin: 1.2rem 0 4.5rem;
    display: grid;
    gap: clamp(3rem, 6vw, 5rem);
}

/* ====== Piezas compartidas ====== */
.gbs-kicker {
    display: inline-flex; align-items: center; gap: .45rem;
    margin: 0 0 1rem;
    font-size: .76rem; font-weight: 700; letter-spacing: .09em; text-transform: uppercase;
    color: var(--gbs-primary);
    background: color-mix(in srgb, var(--gbs-primary) 10%, #fff);
    border: 1px solid color-mix(in srgb, var(--gbs-primary) 22%, #fff);
    padding: .4rem .85rem; border-radius: 999px;
}
.gbs-kicker svg { width: 13px; height: 13px; flex: 0 0 auto; }
.gbs-h2 {
    font-size: clamp(1.9rem, 3.2vw, 2.4rem);
    font-weight: 800; letter-spacing: -.01em;
    color: var(--gbs-ink);
    margin: 0 0 1rem; line-height: 1.15;
    display: inline-flex; align-items: center; flex-wrap: wrap; gap: .7rem;
}
.gbs-pending {
    display: inline-flex; align-items: center; gap: .35rem;
    font-size: .72rem; font-weight: 700; letter-spacing: .02em;
    text-transform: none;
    background: #fef9c3; color: #854d0e;
    border: 1px solid #fde68a; border-radius: 999px;
    padding: .2rem .7rem; vertical-align: middle;
}
.gbs-pending svg { width: 12px; height: 12px; }
@supports not (background: color-mix(in srgb, red, blue)) {
    .gbs-kicker { background: #eef7ec; border-color: #cfe8c8; }
}

/* ====== Hero ====== */
.gbs-hero {
    position: relative; overflow: hidden;
    display: grid; align-items: center;
    grid-template-columns: 1.05fr 1fr;
    gap: clamp(2rem, 4.5vw, 4rem);
    padding: clamp(1.6rem, 3.5vw, 3.25rem);
    border-radius: 24px;
    background:
        radial-gradient(720px 340px at 88% -10%, color-mix(in srgb, var(--gbs-secondary) 38%, transparent), transparent 70%),
        linear-gradient(160deg, color-mix(in srgb, var(--gbs-primary) 7%, #fff) 0%, #f7fbf6 55%, #fff 100%);
    border: 1px solid color-mix(in srgb, var(--gbs-primary) 14%, #fff);
}
@supports not (background: color-mix(in srgb, red, blue)) {
    .gbs-hero { background: linear-gradient(160deg, #eef7ec 0%, #f7fbf6 55%, #fff 100%); border-color: #ddeed8; }
}
.gbs-hero::before {
    content: ""; position: absolute; right: -40px; top: -40px;
    width: 320px; height: 260px;
    background-image: radial-gradient(rgba(81, 175, 63, .38) 1.5px, transparent 1.5px);
    background-size: 18px 18px;
    -webkit-mask-image: radial-gradient(closest-side at 65% 35%, #000, transparent);
            mask-image: radial-gradient(closest-side at 65% 35%, #000, transparent);
    pointer-events: none;
}
.gbs-hero__title {
    font-size: clamp(2.1rem, 3.8vw, 2.9rem);
    font-weight: 800; letter-spacing: -.015em;
    color: var(--gbs-ink);
    margin: 0 0 1rem; line-height: 1.08;
}
.gbs-hero__lead {
    font-size: clamp(1.04rem, 1.2vw, 1.16rem);
    color: var(--gbs-body); line-height: 1.7;
    margin: 0 0 1.7rem; max-width: 52ch;
}
.gbs-hero__actions { display: flex; flex-wrap: wrap; gap: .8rem; }
.gbs-cta {
    padding: .85rem 1.5rem; font-size: .95rem; font-weight: 600;
    border-radius: 12px; gap: .55rem;
    box-shadow: 0 8px 18px color-mix(in srgb, var(--color-primary, #0f0f10) 22%, transparent);
}
.gbs-cta svg { transition: transform .2s ease; }
.gbs-cta:hover svg { transform: translateX(3px); }
.gbs-cta-ghost {
    display: inline-flex; align-items: center; gap: .55rem;
    padding: .85rem 1.4rem; font-size: .95rem; font-weight: 600;
    border-radius: 12px; text-decoration: none;
    color: var(--gbs-deep);
    background: #fff;
    border: 1px solid color-mix(in srgb, var(--gbs-primary) 28%, #fff);
    transition: background .2s ease, border-color .2s ease;
}
.gbs-cta-ghost:hover {
    background: color-mix(in srgb, var(--gbs-primary) 8%, #fff);
    border-color: color-mix(in srgb, var(--gbs-primary) 45%, #fff);
    color: var(--gbs-deep); text-decoration: none;
}
@supports not (background: color-mix(in srgb, red, blue)) {
    .gbs-cta { box-shadow: 0 8px 18px rgba(15, 15, 16, .22); }
    .gbs-cta-ghost { border-color: #cfe8c8; }
    .gbs-cta-ghost:hover { background: #eef7ec; border-color: #a7dd98; }
}
.gbs-hero__media { position: relative; }
.gbs-hero__media img {
    width: 100%; aspect-ratio: 4/3; border-radius: 18px; object-fit: cover; display: block;
    box-shadow: 0 26px 50px -22px rgba(13, 40, 24, .45);
}
.gbs-hero__frame {
    position: absolute; inset: .8rem; border-radius: 12px;
    border: 1px solid rgba(255, 255, 255, .55);
    pointer-events: none;
}
.gbs-hero__chip {
    position: absolute; top: 1rem; right: 1rem; z-index: 1;
    display: inline-flex; align-items: center; gap: .45rem;
    background: rgba(255, 255, 255, .92);
    -webkit-backdrop-filter: blur(6px); backdrop-filter: blur(6px);
    border-radius: 999px; padding: .45rem .85rem;
    font-size: .78rem; font-weight: 700; color: var(--gbs-deep);
    box-shadow: 0 10px 22px rgba(13, 40, 24, .18);
}
.gbs-hero__chip svg { width: 16px; height: 16px; color: var(--gbs-primary); flex: 0 0 auto; }
.gbs-hero__badge {
    position: absolute; left: 1rem; bottom: 1rem; z-index: 1;
    display: flex; align-items: center; gap: .6rem;
    background: #fff; border: 1px solid #eef2ee; border-radius: 14px;
    padding: .65rem .95rem;
    box-shadow: 0 14px 30px rgba(13, 40, 24, .22);
}
.gbs-hero__badge-ico {
    display: grid; place-items: center;
    width: 34px; height: 34px; border-radius: 10px;
    background: color-mix(in srgb, var(--gbs-primary) 14%, #fff);
    color: var(--gbs-primary); flex: 0 0 auto;
}
.gbs-hero__badge-ico svg { width: 20px; height: 20px; }
.gbs-hero__badge-txt { font-size: .8rem; font-weight: 700; color: var(--gbs-ink); line-height: 1.2; }
.gbs-hero__badge-txt span { display: block; font-size: .72rem; font-weight: 500; color: var(--gbs-muted); }
@supports not (background: color-mix(in srgb, red, blue)) {
    .gbs-hero__badge-ico { background: #eef7ec; }
}
@media (prefers-reduced-motion: no-preference) {
    .gbs-hero__badge { animation: gbsFloat 5.5s ease-in-out infinite; }
}
@keyframes gbsFloat { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-7px); } }

/* ====== Marco legal ====== */
.gbs-law__intro { max-width: 62ch; }
.gbs-law__intro p { font-size: 1.02rem; color: var(--gbs-body); line-height: 1.75; margin: 0 0 1.8rem; }
.gbs-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 1.1rem; }
.gbs-card {
    position: relative; overflow: hidden;
    background: #fff;
    border: 1px solid color-mix(in srgb, var(--gbs-primary) 14%, #fff);
    border-radius: 18px;
    padding: 1.7rem 1.5rem;
    transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease;
}
.gbs-card::after {
    content: ""; position: absolute; left: 0; right: 0; top: 0; height: 3px;
    background: linear-gradient(90deg, var(--gbs-primary), var(--gbs-secondary));
    transform: scaleX(0); transform-origin: left;
    transition: transform .3s ease;
}
.gbs-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 22px 44px -22px rgba(13, 40, 24, .3);
    border-color: color-mix(in srgb, var(--gbs-primary) 35%, #fff);
}
.gbs-card:hover::after { transform: scaleX(1); }
.gbs-card__ico {
    display: grid; place-items: center;
    width: 46px; height: 46px; border-radius: 12px;
    background: color-mix(in srgb, var(--gbs-primary) 12%, #fff);
    border: 1px solid color-mix(in srgb, var(--gbs-primary) 20%, #fff);
    color: var(--gbs-primary);
    margin-bottom: 1.1rem;
}
.gbs-card__ico svg { width: 22px; height: 22px; }
.gbs-card h3 { font-size: 1.08rem; font-weight: 700; color: var(--gbs-ink); margin: 0 0 .5rem; letter-spacing: -.01em; }
.gbs-card p { font-size: .95rem; color: var(--gbs-muted); line-height: 1.6; margin: 0; }
@supports not (background: color-mix(in srgb, red, blue)) {
    .gbs-card { border-color: #ddeed8; }
    .gbs-card:hover { border-color: #a7dd98; }
    .gbs-card__ico { background: #eef7ec; border-color: #d5ebcf; }
}

/* ====== Certificaciones (panel-nota) ====== */
.gbs-certs {
    position: relative; overflow: hidden;
    display: grid; grid-template-columns: auto 1fr; gap: 1.3rem; align-items: start;
    background: #f6faf4;
    border: 1px solid color-mix(in srgb, var(--gbs-primary) 16%, #fff);
    border-radius: 20px;
    padding: clamp(1.5rem, 3vw, 2.2rem);
}
@supports not (background: color-mix(in srgb, red, blue)) {
    .gbs-certs { border-color: #ddeed8; }
}
.gbs-certs__ico {
    display: grid; place-items: center;
    width: 52px; height: 52px; border-radius: 14px;
    background: #fff; border: 1px solid color-mix(in srgb, var(--gbs-primary) 20%, #fff);
    color: var(--gbs-primary); flex: 0 0 auto;
}
.gbs-certs__ico svg { width: 26px; height: 26px; }
.gbs-certs__body h3 { font-size: 1.15rem; font-weight: 700; color: var(--gbs-ink); margin: 0 0 .5rem; }
.gbs-certs__body p { font-size: .98rem; color: var(--gbs-body); line-height: 1.7; margin: 0; }
.gbs-certs__links { margin-top: 1rem; display: flex; flex-wrap: wrap; gap: .6rem; }
.gbs-certs__link {
    display: inline-flex; align-items: center; gap: .4rem;
    padding: .45rem .9rem; border-radius: 999px;
    background: #fff; border: 1px solid color-mix(in srgb, var(--gbs-primary) 22%, #fff);
    color: var(--gbs-deep); font-size: .86rem; font-weight: 600; text-decoration: none;
    transition: background .2s ease, border-color .2s ease, transform .2s ease;
}
.gbs-certs__link:hover {
    background: color-mix(in srgb, var(--gbs-primary) 8%, #fff);
    border-color: color-mix(in srgb, var(--gbs-primary) 42%, #fff);
    color: var(--gbs-deep); text-decoration: none; transform: translateY(-1px);
}
.gbs-certs__link svg { width: 13px; height: 13px; }
@supports not (background: color-mix(in srgb, red, blue)) {
    .gbs-certs__ico { border-color: #cfe8c8; }
    .gbs-certs__link { border-color: #cfe8c8; }
    .gbs-certs__link:hover { background: #eef7ec; border-color: #a7dd98; }
}

/* ====== CTA final ====== */
.gbs-final {
    position: relative; overflow: hidden;
    display: grid; align-items: center;
    grid-template-columns: 1.6fr auto;
    gap: clamp(1.5rem, 3vw, 2.5rem);
    padding: clamp(1.8rem, 3.5vw, 2.8rem);
    border-radius: 24px;
    color: #fff;
    background:
        radial-gradient(600px 300px at 90% -20%, color-mix(in srgb, var(--gbs-secondary) 45%, transparent), transparent 70%),
        linear-gradient(135deg, #123f23 0%, var(--gbs-deep) 55%, #1a6b36 100%);
}
@supports not (background: color-mix(in srgb, red, blue)) {
    .gbs-final { background: linear-gradient(135deg, #123f23 0%, #14532d 55%, #1a6b36 100%); }
}
.gbs-final::before {
    content: ""; position: absolute; left: -30px; bottom: -50px;
    width: 260px; height: 220px;
    background-image: radial-gradient(rgba(255, 255, 255, .35) 1.5px, transparent 1.5px);
    background-size: 18px 18px;
    -webkit-mask-image: radial-gradient(closest-side at 35% 65%, #000, transparent);
            mask-image: radial-gradient(closest-side at 35% 65%, #000, transparent);
    pointer-events: none;
}
.gbs-final h2 { font-size: clamp(1.5rem, 2.6vw, 2rem); font-weight: 800; letter-spacing: -.01em; margin: 0 0 .5rem; color: #fff; line-height: 1.2; }
.gbs-final p { font-size: 1rem; color: rgba(255, 255, 255, .85); line-height: 1.6; margin: 0; max-width: 52ch; }
.gbs-final__btn {
    position: relative; z-index: 1;
    display: inline-flex; align-items: center; gap: .55rem;
    padding: .95rem 1.7rem;
    background: #fff; color: var(--gbs-deep);
    border-radius: 12px; text-decoration: none;
    font-weight: 700; font-size: .98rem;
    box-shadow: 0 14px 30px -12px rgba(0, 0, 0, .45);
    transition: transform .2s ease, box-shadow .2s ease;
    justify-self: end;
}
.gbs-final__btn:hover {
    transform: translateY(-2px);
    color: var(--gbs-deep); text-decoration: none;
    box-shadow: 0 20px 38px -12px rgba(0, 0, 0, .5);
}
.gbs-final__btn svg { width: 16px; height: 16px; transition: transform .2s ease; }
.gbs-final__btn:hover svg { transform: translateX(3px); }

/* ====== Reveal-on-scroll (solo con JS y sin reduced-motion) ====== */
@media (prefers-reduced-motion: no-preference) {
    .gbs.js-reveal [data-reveal] {
        opacity: 0; transform: translateY(22px);
        transition:
            opacity .65s ease var(--reveal-delay, 0s),
            transform .65s cubic-bezier(.22, .61, .36, 1) var(--reveal-delay, 0s);
    }
    .gbs.js-reveal [data-reveal].is-in { opacity: 1; transform: none; }
}

/* ====== Mobile ====== */
@media (max-width: 800px) {
    .gbs-hero, .gbs-final { grid-template-columns: 1fr; }
    .gbs-final__btn { justify-self: stretch; justify-content: center; }
}
@media (max-width: 640px) {
    .gbs { margin-top: .6rem; gap: 2.6rem; }
    .gbs-hero { padding: 1.2rem 1.2rem 1.4rem; border-radius: 18px; }
    .gbs-hero::before { width: 220px; height: 180px; background-size: 15px 15px; }
    .gbs-hero__media img { aspect-ratio: 16/10; border-radius: 12px; }
    .gbs-hero__frame { inset: .55rem; border-radius: 8px; }
    .gbs-hero__chip { top: .7rem; right: .7rem; font-size: .72rem; padding: .35rem .7rem; }
    .gbs-hero__badge { left: .7rem; bottom: .7rem; padding: .5rem .75rem; border-radius: 12px; }
    .gbs-hero__actions a { flex: 1 1 100%; justify-content: center; }
    .gbs-certs { grid-template-columns: 1fr; }
}
</style>

<div class="gbs" id="gbs-root">

    <!-- ====== Hero ====== -->
    <header class="gbs-hero">
        <div class="gbs-hero__copy">
            <p class="gbs-kicker" data-reveal>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/></svg>
                Sustentabilidad
            </p>
            <p class="gbs-hero__title" aria-hidden="true" data-reveal style="--reveal-delay:.08s">Compromiso sustentable</p>
            <p class="gbs-hero__lead" data-reveal style="--reveal-delay:.16s">En GreenBags trabajamos por una economía circular real: reducir, reutilizar y reemplazar los plásticos de un solo uso por alternativas certificadas.</p>
            <div class="gbs-hero__actions" data-reveal style="--reveal-delay:.24s">
                <a href="/catalogo" class="btn gbs-cta">
                    <span>Ver catálogo</span>
                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>
                <a href="/contacto" class="gbs-cta-ghost">Contáctanos</a>
            </div>
        </div>
        <div class="gbs-hero__media" data-reveal style="--reveal-delay:.12s">
            <img src="/uploads/library/greenbags/eco-sustentable.jpg" alt="Compromiso ecológico y sustentable" loading="lazy">
            <span class="gbs-hero__frame" aria-hidden="true"></span>
            <div class="gbs-hero__chip" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/><path d="M9 12l2 2 4-4"/></svg>
                <span>Materiales certificados</span>
            </div>
            <div class="gbs-hero__badge" aria-hidden="true">
                <span class="gbs-hero__badge-ico">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M7 19H4.815a1.83 1.83 0 0 1-1.57-.881 1.785 1.785 0 0 1-.004-1.784L7.196 9.5"/><path d="M11 19h8.203a1.83 1.83 0 0 0 1.556-.89 1.784 1.784 0 0 0 0-1.775l-1.226-2.12"/><path d="m14 16-3 3 3 3"/><path d="M8.293 13.596 4.875 9.5 1.5 12.5"/><path d="m9.344 5.811 1.093-1.892A1.83 1.83 0 0 1 11.985 3a1.784 1.784 0 0 1 1.546.888l3.943 6.843"/><path d="m13.378 9.633 4.096-1.098 1.097 4.096"/></svg>
                </span>
                <span class="gbs-hero__badge-txt">Economía circular<span>reducir · reutilizar</span></span>
            </div>
        </div>
    </header>

    <!-- ====== Marco legal: Ley 21.368 ====== -->
    <section class="gbs-law">
        <div class="gbs-law__intro">
            <p class="gbs-kicker" data-reveal>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 3 4 6v6c0 5 3.5 7.5 8 9 4.5-1.5 8-4 8-9V6l-8-3z"/></svg>
                Marco legal
            </p>
            <h2 class="gbs-h2" data-reveal style="--reveal-delay:.08s">
                Ley 21.368
                <span class="gbs-pending"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/></svg>Info en actualización</span>
            </h2>
            <p data-reveal style="--reveal-delay:.16s">La Ley 21.368 regula la entrega de productos de plástico de un solo uso y promueve el uso de envases certificados como compostables o reutilizables. Acompañamos a nuestros clientes en el cumplimiento con soluciones alineadas a esta normativa.</p>
        </div>
        <div class="gbs-cards">
            <div class="gbs-card" data-reveal style="--reveal-delay:.14s">
                <span class="gbs-card__ico" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/></svg>
                </span>
                <h3>Plásticos de un solo uso</h3>
                <p>Reemplazo por materiales de origen vegetal (fibra de caña, cartón y papel kraft) certificados.</p>
            </div>
            <div class="gbs-card" data-reveal style="--reveal-delay:.22s">
                <span class="gbs-card__ico" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="9" r="6"/><path d="M9 14.5 8 22l4-2 4 2-1-7.5"/><path d="m10 9 1.5 1.5L14.5 7.5"/></svg>
                </span>
                <h3>Certificación de compostabilidad</h3>
                <p>Productos con certificación de compostabilidad y biodegradabilidad según normas vigentes.</p>
            </div>
            <div class="gbs-card" data-reveal style="--reveal-delay:.3s">
                <span class="gbs-card__ico" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12a9 9 0 1 1-3-6.7"/><path d="M21 4v5h-5"/></svg>
                </span>
                <h3>Ley REP</h3>
                <p>Responsabilidad Extendida del Productor: apoyamos la gestión responsable de residuos de envases y embalajes.</p>
            </div>
        </div>
    </section>

    <!-- ====== Certificaciones ====== -->
    <section class="gbs-certsec">
        <p class="gbs-kicker" data-reveal>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="9" r="6"/><path d="M9 14.5 8 22l4-2 4 2-1-7.5"/></svg>
            Certificaciones
        </p>
        <div class="gbs-certs" data-reveal style="--reveal-delay:.1s">
            <span class="gbs-certs__ico" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="9" r="6"/><path d="M9 14.5 8 22l4-2 4 2-1-7.5"/><path d="m10 9 1.5 1.5L14.5 7.5"/></svg>
            </span>
            <div class="gbs-certs__body">
                <h3>Respaldo y normativa</h3>
                <p>El detalle de nuestras certificaciones está en actualización. Mientras tanto, puedes revisar las siguientes referencias del sector:</p>
                <div class="gbs-certs__links">
                    <a class="gbs-certs__link" href="https://tugou.cl/eco-tugou/" target="_blank" rel="noopener">
                        tugou.cl/eco-tugou
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17 17 7M8 7h9v9"/></svg>
                    </a>
                    <a class="gbs-certs__link" href="https://ecoitalia.cl/certificaciones" target="_blank" rel="noopener">
                        ecoitalia.cl/certificaciones
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17 17 7M8 7h9v9"/></svg>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- ====== CTA final ====== -->
    <section class="gbs-final" data-reveal>
        <div>
            <h2>¿Buscas alternativas sustentables para tu empresa?</h2>
            <p>Explora nuestro catálogo de packaging biodegradable y compostable, o escríbenos y te ayudamos a elegir.</p>
        </div>
        <a href="/catalogo" class="gbs-final__btn">
            <span>Ver catálogo</span>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
        </a>
    </section>

</div>

<script>
(function(){
    var root = document.getElementById("gbs-root");
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
WHERE slug = 'sustentabilidad';
