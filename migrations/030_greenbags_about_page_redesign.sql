-- ============================================================
-- CLIENTE: GreenBags — rediseño de la página "Sobre GreenBags"
-- ============================================================
-- Reemplaza el body sencillo (h2 + p + ul) del seed 028 por un diseño
-- moderno, con hero, stats, pilares, sectores y mapa estilizado.
--
-- Todo el styling vive en un bloque <style> dentro del body (CSS scoped
-- bajo `.gb-about` + `gb-` para evitar colisiones). No toca CSS global ni
-- archivos del starter: el rediseño es propiedad de este cliente y vive
-- en su seed. Al forkear para otro cliente, borrar este archivo junto con
-- 028 y 029 (ver FORK_NEW_CLIENT.md).
--
-- Usa las CSS vars `--brand-primary` / `--brand-secondary` que el layout
-- inyecta desde settings (theme_primary / theme_secondary). Cambiarlas
-- desde admin → Configuración recolorea el rediseño automáticamente.
--
-- Defensivo: sólo actualiza si el body sigue siendo el del seed original
-- (heurística: contiene el `<h2>Quiénes somos</h2>` literal y NO contiene
-- la marca `gb-about` del rediseño). Si el cliente ya editó la página
-- desde admin, no se pisa.
-- ============================================================

UPDATE pages
SET body = '<style>
/* Oculta el h1 por defecto que el router agrega antes del body
 * (index.php → <article class="page"><h1>title</h1>body</article>).
 * Mi hero usa su propio h1 visual. El <title> y <meta og:title> siguen
 * llevando el título oficial de la página para SEO. */
.page > h1:first-child { display: none; }

.gb-about {
    --gb-primary: var(--brand-primary, #2f7a3a);
    --gb-secondary: var(--brand-secondary, #a8c896);
    --gb-dark: #102018;
    --gb-soft: #f3f9f4;
    --gb-border: #e1ebdd;
    --gb-muted: #5a665e;

    max-width: 1180px;
    margin: 0 auto;
    font-feature-settings: "ss01", "cv11";
}

/* ============ HERO ============ */
.gb-about__hero {
    position: relative;
    overflow: hidden;
    color: #fff;
    background: linear-gradient(135deg, #0e2218 0%, #1b3a28 55%, var(--gb-primary) 100%);
    border-radius: 24px;
    padding: clamp(2.5rem, 5vw, 4.5rem) clamp(1.4rem, 4vw, 3rem) clamp(5rem, 8vw, 7rem);
    margin-bottom: 0;
}
.gb-about__hero::before {
    content: "";
    position: absolute; inset: 0;
    background:
        radial-gradient(900px 500px at 85% 15%, rgba(168, 200, 150, .28), transparent 60%),
        radial-gradient(600px 400px at 10% 95%, rgba(255, 255, 255, .08), transparent 60%);
    pointer-events: none;
}
.gb-about__hero-inner {
    position: relative; z-index: 1;
    max-width: 760px;
    display: flex; flex-direction: column; gap: 1.3rem;
}
.gb-about__eyebrow {
    display: inline-flex; align-items: center; gap: .5rem;
    align-self: flex-start;
    padding: .38rem .95rem;
    background: rgba(255, 255, 255, .14);
    border: 1px solid rgba(255, 255, 255, .25);
    border-radius: 999px;
    -webkit-backdrop-filter: blur(8px);
    backdrop-filter: blur(8px);
    font-size: .82rem; font-weight: 600; letter-spacing: .02em;
    color: #f0fdf4;
}
.gb-about__eyebrow svg { width: 14px; height: 14px; }

.gb-about__title {
    font-size: clamp(2rem, 4.6vw, 3.2rem);
    line-height: 1.1;
    letter-spacing: -.025em;
    font-weight: 700;
    margin: 0;
    color: #fff;
}
.gb-about__title em {
    font-style: normal;
    background: linear-gradient(90deg, var(--gb-secondary), #d4f0c2);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
}
.gb-about__lead {
    font-size: clamp(1rem, 1.4vw, 1.16rem);
    line-height: 1.6;
    margin: 0;
    color: rgba(255, 255, 255, .9);
}
.gb-about__hero-cta {
    display: inline-flex; align-items: center; gap: .55rem;
    align-self: flex-start;
    padding: .9rem 1.6rem;
    background: #fff;
    color: var(--gb-dark);
    border-radius: 12px;
    font-weight: 600; font-size: .98rem;
    text-decoration: none;
    box-shadow: 0 12px 28px -10px rgba(0, 0, 0, .35);
    transition: transform .2s ease, box-shadow .2s ease;
    margin-top: .3rem;
}
.gb-about__hero-cta:hover {
    transform: translateY(-2px);
    box-shadow: 0 18px 36px -10px rgba(0, 0, 0, .4);
    color: var(--gb-dark);
    text-decoration: none;
}
.gb-about__hero-cta svg { width: 16px; height: 16px; }

/* ============ STATS ============ */
.gb-about__stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1rem;
    margin: -5rem 0 4.5rem;
    padding: 0 .5rem;
    position: relative; z-index: 2;
}
.gb-about__stat {
    background: #fff;
    border: 1px solid var(--gb-border);
    border-radius: 18px;
    padding: 1.4rem 1.4rem;
    box-shadow: 0 14px 36px -16px rgba(15, 40, 25, .15), 0 2px 6px rgba(15, 40, 25, .04);
}
.gb-about__stat-num {
    font-size: 2.3rem; line-height: 1;
    font-weight: 700;
    color: var(--gb-primary);
    letter-spacing: -.03em;
    margin-bottom: .4rem;
    font-variant-numeric: tabular-nums;
}
.gb-about__stat-label {
    font-size: .92rem; font-weight: 500;
    color: var(--gb-muted);
    line-height: 1.4;
}

/* ============ SECTION shared ============ */
.gb-about__section {
    margin: 0 0 5rem;
    padding: 0 .5rem;
}
.gb-about__kicker {
    display: inline-block;
    font-size: .76rem; font-weight: 700; letter-spacing: .12em;
    text-transform: uppercase;
    color: var(--gb-primary);
    margin-bottom: .9rem;
}
.gb-about__h {
    font-size: clamp(1.55rem, 2.8vw, 2.05rem);
    line-height: 1.18;
    letter-spacing: -.02em;
    font-weight: 700;
    color: var(--gb-dark);
    margin: 0 0 1rem;
}
.gb-about__p {
    font-size: 1.04rem;
    line-height: 1.7;
    color: #3d4a44;
    max-width: 680px;
    margin: 0 0 1rem;
}

/* ============ ABOUT split ============ */
.gb-about__about {
    display: grid;
    grid-template-columns: 1.05fr 1fr;
    gap: 3rem;
    align-items: center;
    margin-top: 1.5rem;
}
.gb-about__about-visual {
    position: relative;
    aspect-ratio: 5/4;
    border-radius: 26px;
    background: linear-gradient(160deg, var(--gb-soft) 0%, #e1ede0 100%);
    overflow: hidden;
    display: grid; place-items: center;
}
.gb-about__about-visual::before {
    content: "";
    position: absolute; inset: -10%;
    background:
        radial-gradient(400px 300px at 30% 30%, rgba(47, 122, 58, .15), transparent 65%),
        radial-gradient(300px 220px at 75% 80%, rgba(168, 200, 150, .35), transparent 65%);
}
.gb-about__about-visual svg {
    position: relative; z-index: 1;
    width: 62%; height: auto; opacity: .92;
}
@media (max-width: 760px) {
    .gb-about__about { grid-template-columns: 1fr; gap: 2rem; }
    .gb-about__about-visual { max-width: 360px; margin: 0 auto; }
}

/* ============ PILLARS ============ */
.gb-about__pillars {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.1rem;
    margin-top: 2rem;
}
.gb-about__pillar {
    background: #fff;
    border: 1px solid var(--gb-border);
    border-radius: 20px;
    padding: 1.7rem 1.5rem;
    transition: transform .2s ease, box-shadow .2s ease, border-color .2s;
}
.gb-about__pillar:hover {
    transform: translateY(-4px);
    box-shadow: 0 18px 44px -18px rgba(15, 40, 25, .2);
    border-color: var(--gb-secondary);
}
.gb-about__pillar-icon {
    display: inline-flex; align-items: center; justify-content: center;
    width: 52px; height: 52px;
    border-radius: 14px;
    background: var(--gb-soft);
    color: var(--gb-primary);
    margin-bottom: 1.1rem;
}
.gb-about__pillar-icon svg { width: 26px; height: 26px; }
.gb-about__pillar h3 {
    font-size: 1.1rem; font-weight: 700;
    color: var(--gb-dark);
    margin: 0 0 .55rem;
    letter-spacing: -.01em;
}
.gb-about__pillar p {
    font-size: .96rem;
    color: var(--gb-muted);
    line-height: 1.55;
    margin: 0;
}

/* ============ SECTORS ============ */
.gb-about__sectors {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: .75rem;
    margin-top: 2rem;
}
.gb-about__sector {
    display: flex; align-items: center; gap: .85rem;
    padding: 1rem 1.1rem;
    background: var(--gb-soft);
    border: 1px solid #d6e7d1;
    border-radius: 14px;
    transition: background .2s, transform .2s;
}
.gb-about__sector:hover {
    background: #e3efde;
    transform: translateY(-2px);
}
.gb-about__sector-icon {
    flex: 0 0 auto;
    width: 36px; height: 36px;
    display: inline-flex; align-items: center; justify-content: center;
    background: #fff;
    border-radius: 10px;
    color: var(--gb-primary);
}
.gb-about__sector-icon svg { width: 18px; height: 18px; }
.gb-about__sector-label {
    font-size: .94rem; font-weight: 600;
    color: var(--gb-dark);
    line-height: 1.25;
}

/* ============ COVERAGE ============ */
.gb-about__coverage {
    display: grid;
    grid-template-columns: 1.15fr 1fr;
    gap: 2.5rem;
    align-items: center;
    padding: 2.6rem 2.4rem;
    background: linear-gradient(135deg, var(--gb-dark) 0%, #1c3a28 100%);
    color: #fff;
    border-radius: 26px;
    position: relative; overflow: hidden;
    margin-top: 2rem;
}
.gb-about__coverage::before {
    content: ""; position: absolute; inset: 0;
    background: radial-gradient(700px 400px at 100% 0%, rgba(168, 200, 150, .22), transparent 60%);
    pointer-events: none;
}
.gb-about__coverage > * { position: relative; z-index: 1; }
.gb-about__coverage h3 {
    font-size: clamp(1.4rem, 2.4vw, 1.95rem);
    line-height: 1.2;
    color: #fff;
    margin: 0 0 1rem;
    font-weight: 700;
    letter-spacing: -.02em;
}
.gb-about__coverage p {
    color: rgba(255, 255, 255, .85);
    font-size: 1.02rem; line-height: 1.6;
    margin: 0 0 1.4rem;
    max-width: 460px;
}
.gb-about__cov-tags {
    display: flex; flex-wrap: wrap; gap: .5rem;
}
.gb-about__cov-tag {
    padding: .4rem .9rem;
    background: rgba(255, 255, 255, .1);
    border: 1px solid rgba(255, 255, 255, .22);
    border-radius: 999px;
    font-size: .82rem; font-weight: 600;
}
.gb-about__map {
    position: relative;
    width: 100%;
    max-width: 260px;
    margin: 0 auto;
}
.gb-about__map svg { width: 100%; height: auto; display: block; }

@media (max-width: 800px) {
    .gb-about__coverage { grid-template-columns: 1fr; padding: 2.2rem 1.6rem; }
    .gb-about__map { max-width: 200px; }
}

/* ============ FINAL CTA ============ */
.gb-about__final {
    display: grid; grid-template-columns: 1.7fr 1fr;
    gap: 2rem; align-items: center;
    padding: 2.3rem 2.4rem;
    background: linear-gradient(135deg, #fff 0%, var(--gb-soft) 100%);
    border: 1px solid var(--gb-border);
    border-radius: 22px;
    margin-top: 2rem;
}
.gb-about__final h3 {
    font-size: clamp(1.35rem, 2.2vw, 1.8rem);
    color: var(--gb-dark);
    margin: 0 0 .55rem;
    line-height: 1.22;
    font-weight: 700;
    letter-spacing: -.02em;
}
.gb-about__final p {
    color: var(--gb-muted);
    font-size: 1rem; line-height: 1.55;
    margin: 0;
}
.gb-about__final-cta {
    display: inline-flex; align-items: center; justify-content: center; gap: .55rem;
    padding: .95rem 1.6rem;
    background: var(--gb-primary);
    color: #fff;
    text-decoration: none;
    border-radius: 12px;
    font-weight: 600; font-size: 1rem;
    box-shadow: 0 14px 30px -12px rgba(47, 122, 58, .6);
    transition: transform .2s, box-shadow .2s, filter .2s;
    justify-self: end;
}
.gb-about__final-cta:hover {
    transform: translateY(-2px);
    color: #fff; text-decoration: none;
    filter: brightness(1.05);
    box-shadow: 0 18px 38px -12px rgba(47, 122, 58, .7);
}
.gb-about__final-cta svg { width: 16px; height: 16px; }

@media (max-width: 760px) {
    .gb-about__final { grid-template-columns: 1fr; text-align: center; padding: 2rem 1.4rem; }
    .gb-about__final-cta { justify-self: stretch; }
    .gb-about__stats { margin-top: -4rem; }
}
</style>

<section class="gb-about">

    <!-- HERO -->
    <header class="gb-about__hero">
        <div class="gb-about__hero-inner">
            <span class="gb-about__eyebrow">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2 L13.5 8.5 L20 8.5 L14.7 12.7 L17 19.5 L12 15.4 L7 19.5 L9.3 12.7 L4 8.5 L10.5 8.5 Z"/></svg>
                15+ años junto a empresas chilenas
            </span>
            <h1 class="gb-about__title">Soluciones <em>sustentables</em> para empresas que valoran calidad y rapidez</h1>
            <p class="gb-about__lead">Somos una empresa chilena dedicada al packaging, productos de higiene y aseo industrial. Atendidos directamente por sus dueños, garantizamos respuestas concretas y entregas confiables en todo el país.</p>
            <a href="/cotizacion" class="gb-about__hero-cta">
                Solicitar cotización
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12 H19 M13 6 L19 12 L13 18"/></svg>
            </a>
        </div>
    </header>

    <!-- STATS -->
    <div class="gb-about__stats">
        <div class="gb-about__stat">
            <div class="gb-about__stat-num">15+</div>
            <div class="gb-about__stat-label">Años de experiencia en el rubro</div>
        </div>
        <div class="gb-about__stat">
            <div class="gb-about__stat-num">24-48h</div>
            <div class="gb-about__stat-label">Despachos en Región Metropolitana</div>
        </div>
        <div class="gb-about__stat">
            <div class="gb-about__stat-num">100%</div>
            <div class="gb-about__stat-label">Cobertura nacional en Chile</div>
        </div>
        <div class="gb-about__stat">
            <div class="gb-about__stat-num">B2B</div>
            <div class="gb-about__stat-label">Atención directa de los dueños</div>
        </div>
    </div>

    <!-- ABOUT -->
    <div class="gb-about__section">
        <span class="gb-about__kicker">Quiénes somos</span>
        <div class="gb-about__about">
            <div>
                <h2 class="gb-about__h">Una empresa chilena con foco en el detalle</h2>
                <p class="gb-about__p">GreenBags nació con la misión de entregar a las empresas soluciones de packaging, higiene y aseo industrial que combinen calidad, rapidez y responsabilidad ambiental.</p>
                <p class="gb-about__p">Después de más de 15 años en el rubro, somos una alternativa real para quienes valoran la atención cercana y necesitan un proveedor que cumpla. Sin intermediarios: trabajás directamente con quienes toman las decisiones.</p>
            </div>
            <div class="gb-about__about-visual" aria-hidden="true">
                <svg viewBox="0 0 200 160" xmlns="http://www.w3.org/2000/svg" fill="none">
                    <!-- Bolsa estilizada -->
                    <path d="M55 55 L145 55 L155 140 Q155 150 145 150 L55 150 Q45 150 45 140 Z" fill="rgba(47,122,58,0.18)" stroke="rgba(47,122,58,0.55)" stroke-width="1.6"/>
                    <!-- Asas -->
                    <path d="M75 55 Q75 30 100 30 Q125 30 125 55" stroke="rgba(47,122,58,0.7)" stroke-width="2.2" stroke-linecap="round"/>
                    <!-- Hoja -->
                    <path d="M100 80 Q80 90 80 110 Q80 125 100 125 Q120 125 120 110 Q120 90 100 80 Z" fill="rgba(47,122,58,0.55)"/>
                    <path d="M100 88 L100 122 M88 100 L100 105 M112 100 L100 105" stroke="#fff" stroke-width="1.4" stroke-linecap="round"/>
                </svg>
            </div>
        </div>
    </div>

    <!-- PILLARS -->
    <div class="gb-about__section">
        <span class="gb-about__kicker">Nuestra propuesta de valor</span>
        <h2 class="gb-about__h">Tres pilares que marcan la diferencia</h2>
        <p class="gb-about__p">No prometemos lo imposible: cumplimos en lo que realmente importa para que tu operación no se detenga.</p>
        <div class="gb-about__pillars">
            <div class="gb-about__pillar">
                <span class="gb-about__pillar-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8z"/></svg>
                </span>
                <h3>Atención directa de los dueños</h3>
                <p>Sin call centers ni capas intermedias. Hablás con quienes deciden y resuelven, todos los días.</p>
            </div>
            <div class="gb-about__pillar">
                <span class="gb-about__pillar-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 22 Q7 14 12 8 Q17 14 17 22 Z"/><path d="M12 8 V2 M12 4 Q8 5 6 8 M12 4 Q16 5 18 8"/></svg>
                </span>
                <h3>Sustentables y certificados</h3>
                <p>Productos biodegradables, compostables y certificados, alineados a Ley REP y políticas ESG.</p>
            </div>
            <div class="gb-about__pillar">
                <span class="gb-about__pillar-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2 L4 14 L12 14 L11 22 L20 10 L12 10 Z"/></svg>
                </span>
                <h3>Despachos en 24-48 horas</h3>
                <p>Logística confiable en RM y cobertura nacional. Tu pedido sale rápido y sin sorpresas.</p>
            </div>
        </div>
    </div>

    <!-- SECTORS -->
    <div class="gb-about__section">
        <span class="gb-about__kicker">A quiénes acompañamos</span>
        <h2 class="gb-about__h">Empresas y emprendedores del rubro alimentario, retail y servicios</h2>
        <p class="gb-about__p">Trabajamos con quienes mueven el día a día del país: desde el food truck del barrio hasta cadenas con presencia nacional.</p>
        <div class="gb-about__sectors">
            <div class="gb-about__sector">
                <span class="gb-about__sector-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 11 H20 L18 21 H6 Z"/><path d="M8 11 V7 a4 4 0 0 1 8 0 V11"/></svg></span>
                <span class="gb-about__sector-label">Restaurantes y cafeterías</span>
            </div>
            <div class="gb-about__sector">
                <span class="gb-about__sector-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="10" width="14" height="8" rx="1.5"/><path d="M17 12 H21 L21 18 H17 Z"/><circle cx="7" cy="20" r="2"/><circle cx="18" cy="20" r="2"/></svg></span>
                <span class="gb-about__sector-label">Casinos y food trucks</span>
            </div>
            <div class="gb-about__sector">
                <span class="gb-about__sector-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 14 Q4 8 12 8 Q20 8 20 14 V20 H4 Z"/><path d="M9 8 V5 M12 8 V4 M15 8 V5"/></svg></span>
                <span class="gb-about__sector-label">Panaderías y pastelerías</span>
            </div>
            <div class="gb-about__sector">
                <span class="gb-about__sector-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="8" width="13" height="10" rx="1"/><path d="M16 11 H20 L21 14 V18 H16 Z"/><circle cx="7" cy="20" r="1.5"/><circle cx="18" cy="20" r="1.5"/></svg></span>
                <span class="gb-about__sector-label">Distribuidores y mayoristas</span>
            </div>
            <div class="gb-about__sector">
                <span class="gb-about__sector-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9 L12 3 L21 9 V21 H3 Z"/><path d="M9 21 V13 H15 V21"/></svg></span>
                <span class="gb-about__sector-label">Supermercados y minimarkets</span>
            </div>
            <div class="gb-about__sector">
                <span class="gb-about__sector-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="13" r="7"/><path d="M9 13 H15 M12 10 V16"/><path d="M8 4 H16"/></svg></span>
                <span class="gb-about__sector-label">Lavanderías industriales</span>
            </div>
            <div class="gb-about__sector">
                <span class="gb-about__sector-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3 L14.5 9 L21 9.5 L16 14 L17.5 20.5 L12 17 L6.5 20.5 L8 14 L3 9.5 L9.5 9 Z"/></svg></span>
                <span class="gb-about__sector-label">Emprendedores gastronómicos</span>
            </div>
            <div class="gb-about__sector">
                <span class="gb-about__sector-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M8 12 L11 15 L16 9"/></svg></span>
                <span class="gb-about__sector-label">Industria alimentaria</span>
            </div>
        </div>
    </div>

    <!-- COVERAGE -->
    <div class="gb-about__section">
        <span class="gb-about__kicker">Cobertura</span>
        <div class="gb-about__coverage">
            <div>
                <h3>Foco en RM, capacidad para todo Chile</h3>
                <p>Operamos desde la Región Metropolitana con despachos en 24-48 horas, y coordinamos envíos al resto del país con proveedores logísticos confiables.</p>
                <div class="gb-about__cov-tags">
                    <span class="gb-about__cov-tag">Región Metropolitana</span>
                    <span class="gb-about__cov-tag">Norte Grande</span>
                    <span class="gb-about__cov-tag">Zona Centro</span>
                    <span class="gb-about__cov-tag">Sur</span>
                    <span class="gb-about__cov-tag">Patagonia</span>
                </div>
            </div>
            <div class="gb-about__map" aria-hidden="true">
                <svg viewBox="0 0 110 240" xmlns="http://www.w3.org/2000/svg">
                    <!-- Silueta estilizada de Chile (decorativa) -->
                    <path d="M55 8 Q63 22 58 42 Q52 62 60 82 Q66 102 56 122 Q47 142 54 162 Q60 182 53 202 Q49 222 47 230 Q43 232 41 228 Q38 208 41 188 Q45 168 39 148 Q34 128 41 108 Q48 88 41 68 Q35 48 42 28 Q47 12 51 8 Q53 6 55 8 Z" fill="rgba(168,200,150,0.32)" stroke="rgba(168,200,150,0.7)" stroke-width="0.9"/>
                    <!-- Punto RM con halo -->
                    <circle cx="51" cy="62" r="11" fill="rgba(168,200,150,0.25)"/>
                    <circle cx="51" cy="62" r="5" fill="#a8c896"/>
                    <circle cx="51" cy="62" r="2" fill="#fff"/>
                    <text x="68" y="65" fill="#fff" font-size="7" font-family="Inter, sans-serif" font-weight="700">RM</text>
                </svg>
            </div>
        </div>
    </div>

    <!-- FINAL CTA -->
    <div class="gb-about__section">
        <div class="gb-about__final">
            <div>
                <h3>¿Listo para conocer nuestras soluciones?</h3>
                <p>Contanos qué productos necesitás y tu equipo de GreenBags te enviará una propuesta a medida en 24-48 horas hábiles.</p>
            </div>
            <a href="/cotizacion" class="gb-about__final-cta">
                Solicitar cotización
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12 H19 M13 6 L19 12 L13 18"/></svg>
            </a>
        </div>
    </div>

</section>'
WHERE slug = 'sobre-greenbags'
  AND body LIKE '%<h2>Quiénes somos</h2>%'
  AND body NOT LIKE '%gb-about%';
