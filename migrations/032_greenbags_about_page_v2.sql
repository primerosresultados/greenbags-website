-- ============================================================
-- CLIENTE: GreenBags — rediseño v2 de "Sobre GreenBags"
-- ============================================================
-- Reemplaza el body del PR #7 / PR #10 atendiendo el feedback del cliente:
--   - Ancho ahora hereda 100% del .container global → matchea la cabecera.
--   - Mucho más aire entre el header y el hero (margin-top dedicado).
--   - Mapa estilizado de Chile eliminado (parecía culebra). Reemplazado
--     por un panel de cobertura con stats y tags.
--   - Nueva sección de Equipo (4 placeholders para fotos del equipo).
--   - Nueva sección de Testimonios (3 quotes — placeholders editables).
--   - Tipografía, sombras y spacing más refinados.
--
-- Idempotente: UPDATE incondicional al slug. Si el cliente había editado
-- desde admin, se pisa (trade-off consciente — ya fue así en 030/031).
--
-- Al forkear el starter, borrar este archivo junto con 028/029/030/031
-- (ver docs/FORK_NEW_CLIENT.md).
-- ============================================================

UPDATE pages
SET body = '<style>
/* Oculta el h1 por defecto que el router agrega antes del body */
.page > h1:first-child { display: none; }

.gb-about {
    --gb-primary: var(--brand-primary, #2f7a3a);
    --gb-primary-dark: #1f5a2a;
    --gb-secondary: var(--brand-secondary, #a8c896);
    --gb-dark: #0d1f15;
    --gb-soft: #f3f9f4;
    --gb-soft-2: #ebf3ea;
    --gb-border: #e1ebdd;
    --gb-text: #1a2a22;
    --gb-muted: #5a665e;
    --gb-muted-light: #8a948e;

    width: 100%;
    margin: 2.5rem 0 0;
    font-feature-settings: "ss01", "cv11";
}

.gb-about__section {
    margin: 0 0 5rem;
}
.gb-about__section:last-child { margin-bottom: 0; }

.gb-about__head {
    text-align: center;
    max-width: 720px;
    margin: 0 auto 2.5rem;
}
.gb-about__kicker {
    display: inline-flex; align-items: center; gap: .5rem;
    font-size: .76rem; font-weight: 700; letter-spacing: .14em;
    text-transform: uppercase;
    color: var(--gb-primary);
    margin-bottom: 1rem;
}
.gb-about__kicker::before,
.gb-about__kicker::after {
    content: "";
    width: 24px; height: 1px;
    background: var(--gb-secondary);
    opacity: .7;
}
.gb-about__h {
    font-size: clamp(1.7rem, 3vw, 2.3rem);
    line-height: 1.18;
    letter-spacing: -.025em;
    font-weight: 700;
    color: var(--gb-dark);
    margin: 0 0 1rem;
}
.gb-about__sub {
    font-size: 1.05rem;
    line-height: 1.65;
    color: var(--gb-muted);
    margin: 0;
}

/* ============ HERO ============ */
.gb-about__hero {
    position: relative;
    overflow: hidden;
    color: #fff;
    background:
        radial-gradient(900px 500px at 85% 15%, rgba(168, 200, 150, .28), transparent 60%),
        radial-gradient(600px 400px at 10% 95%, rgba(255, 255, 255, .08), transparent 60%),
        linear-gradient(135deg, #0d1f15 0%, #173a26 50%, #2f7a3a 100%);
    border-radius: 28px;
    padding: clamp(2.8rem, 5vw, 4.8rem) clamp(1.5rem, 4vw, 3.5rem) clamp(5.5rem, 8vw, 7.5rem);
    box-shadow: 0 30px 70px -30px rgba(13, 31, 21, .4);
}
.gb-about__hero-grid {
    position: relative; z-index: 1;
    display: grid;
    grid-template-columns: 1.4fr 1fr;
    gap: 3rem;
    align-items: center;
    max-width: 1280px;
    margin: 0 auto;
}
.gb-about__hero-copy {
    display: flex; flex-direction: column; gap: 1.4rem;
}
.gb-about__hero-eyebrow {
    display: inline-flex; align-items: center; gap: .55rem;
    align-self: flex-start;
    padding: .42rem 1rem;
    background: rgba(255, 255, 255, .12);
    border: 1px solid rgba(255, 255, 255, .22);
    border-radius: 999px;
    -webkit-backdrop-filter: blur(8px);
    backdrop-filter: blur(8px);
    font-size: .82rem; font-weight: 600; letter-spacing: .015em;
    color: #f0fdf4;
}
.gb-about__hero-eyebrow svg { width: 14px; height: 14px; }
.gb-about__hero-title {
    font-size: clamp(2rem, 4.4vw, 3.4rem);
    line-height: 1.08;
    letter-spacing: -.028em;
    font-weight: 700;
    margin: 0;
    color: #fff;
}
.gb-about__hero-title em {
    font-style: normal;
    background: linear-gradient(90deg, var(--gb-secondary) 0%, #d4f0c2 100%);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
}
.gb-about__hero-lead {
    font-size: clamp(1rem, 1.4vw, 1.16rem);
    line-height: 1.65;
    margin: 0;
    color: rgba(255, 255, 255, .9);
    max-width: 540px;
}
.gb-about__hero-actions {
    display: flex; flex-wrap: wrap; gap: .8rem;
    margin-top: .4rem;
}
.gb-about__hero-cta {
    display: inline-flex; align-items: center; gap: .55rem;
    padding: .92rem 1.65rem;
    background: #fff;
    color: var(--gb-dark);
    border-radius: 12px;
    font-weight: 600; font-size: .98rem;
    text-decoration: none;
    box-shadow: 0 14px 30px -10px rgba(0, 0, 0, .4);
    transition: transform .2s ease, box-shadow .2s ease;
}
.gb-about__hero-cta:hover {
    transform: translateY(-2px);
    color: var(--gb-dark); text-decoration: none;
    box-shadow: 0 20px 38px -10px rgba(0, 0, 0, .45);
}
.gb-about__hero-cta svg { width: 16px; height: 16px; }
.gb-about__hero-secondary {
    display: inline-flex; align-items: center; gap: .55rem;
    padding: .92rem 1.4rem;
    background: rgba(255, 255, 255, .08);
    border: 1px solid rgba(255, 255, 255, .25);
    color: #fff;
    border-radius: 12px;
    font-weight: 600; font-size: .98rem;
    text-decoration: none;
    -webkit-backdrop-filter: blur(8px);
    backdrop-filter: blur(8px);
    transition: background .2s, border-color .2s;
}
.gb-about__hero-secondary:hover {
    background: rgba(255, 255, 255, .14);
    border-color: rgba(255, 255, 255, .4);
    color: #fff; text-decoration: none;
}

/* Hero visual: badge grande de sustentabilidad */
.gb-about__hero-visual {
    position: relative;
    display: grid; place-items: center;
}
.gb-about__hero-badge {
    position: relative;
    width: clamp(220px, 26vw, 320px);
    aspect-ratio: 1;
    border-radius: 50%;
    background: radial-gradient(circle at 30% 30%, rgba(168, 200, 150, .35), rgba(168, 200, 150, .05) 70%);
    display: grid; place-items: center;
}
.gb-about__hero-badge::before {
    content: "";
    position: absolute; inset: 12%;
    border-radius: 50%;
    border: 1px dashed rgba(168, 200, 150, .35);
    animation: gb-spin 60s linear infinite;
}
.gb-about__hero-badge-inner {
    position: relative;
    width: 60%; height: 60%;
    background: rgba(255, 255, 255, .08);
    border: 1px solid rgba(255, 255, 255, .18);
    border-radius: 50%;
    display: grid; place-items: center;
    -webkit-backdrop-filter: blur(12px);
    backdrop-filter: blur(12px);
    color: #fff;
    text-align: center;
}
.gb-about__hero-badge-inner strong {
    display: block;
    font-size: clamp(1.6rem, 3vw, 2.4rem);
    font-weight: 700;
    line-height: 1;
    letter-spacing: -.02em;
}
.gb-about__hero-badge-inner span {
    display: block;
    font-size: .78rem;
    font-weight: 500;
    letter-spacing: .08em;
    text-transform: uppercase;
    color: rgba(255, 255, 255, .75);
    margin-top: .4rem;
}
@keyframes gb-spin {
    to { transform: rotate(360deg); }
}

@media (max-width: 880px) {
    .gb-about__hero-grid { grid-template-columns: 1fr; gap: 2.4rem; }
    .gb-about__hero-visual { display: none; }
}

/* ============ STATS (flotantes bajo el hero) ============ */
.gb-about__stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1rem;
    margin: -5rem auto 5rem;
    max-width: 1240px;
    position: relative; z-index: 2;
}
.gb-about__stat {
    background: #fff;
    border: 1px solid var(--gb-border);
    border-radius: 18px;
    padding: 1.5rem 1.5rem;
    box-shadow: 0 14px 36px -18px rgba(13, 31, 21, .18), 0 2px 6px rgba(13, 31, 21, .04);
    transition: transform .2s ease, box-shadow .2s ease;
}
.gb-about__stat:hover {
    transform: translateY(-3px);
    box-shadow: 0 22px 44px -18px rgba(13, 31, 21, .22), 0 4px 10px rgba(13, 31, 21, .05);
}
.gb-about__stat-icon {
    display: inline-flex; align-items: center; justify-content: center;
    width: 40px; height: 40px;
    border-radius: 12px;
    background: var(--gb-soft);
    color: var(--gb-primary);
    margin-bottom: 1rem;
}
.gb-about__stat-icon svg { width: 20px; height: 20px; }
.gb-about__stat-num {
    font-size: 2.2rem; line-height: 1;
    font-weight: 700;
    color: var(--gb-dark);
    letter-spacing: -.03em;
    margin-bottom: .35rem;
    font-variant-numeric: tabular-nums;
}
.gb-about__stat-num em {
    font-style: normal;
    color: var(--gb-primary);
}
.gb-about__stat-label {
    font-size: .92rem; font-weight: 500;
    color: var(--gb-muted);
    line-height: 1.4;
}

/* ============ ABOUT (split text + visual) ============ */
.gb-about__about {
    display: grid;
    grid-template-columns: 1.1fr 1fr;
    gap: 3.5rem;
    align-items: center;
}
.gb-about__about-copy .gb-about__kicker { margin-bottom: .8rem; }
.gb-about__about-copy .gb-about__kicker::before { display: none; }
.gb-about__about-copy .gb-about__kicker::after { display: none; }
.gb-about__about-copy h2 {
    font-size: clamp(1.7rem, 3vw, 2.3rem);
    line-height: 1.18;
    letter-spacing: -.025em;
    font-weight: 700;
    color: var(--gb-dark);
    margin: 0 0 1.2rem;
}
.gb-about__about-copy p {
    font-size: 1.04rem;
    line-height: 1.7;
    color: var(--gb-text);
    margin: 0 0 1rem;
}
.gb-about__about-feats {
    list-style: none;
    margin: 1.5rem 0 0;
    padding: 0;
    display: flex; flex-direction: column; gap: .8rem;
}
.gb-about__about-feats li {
    display: flex; align-items: flex-start; gap: .8rem;
    font-size: .98rem;
    color: var(--gb-text);
    line-height: 1.5;
}
.gb-about__about-feats svg {
    flex: 0 0 auto;
    width: 22px; height: 22px;
    margin-top: 1px;
    color: var(--gb-primary);
}
.gb-about__about-visual {
    position: relative;
    aspect-ratio: 5/4;
    border-radius: 26px;
    overflow: hidden;
    background:
        radial-gradient(400px 300px at 30% 30%, rgba(47, 122, 58, .15), transparent 65%),
        radial-gradient(300px 220px at 75% 80%, rgba(168, 200, 150, .4), transparent 65%),
        linear-gradient(160deg, var(--gb-soft) 0%, #dde9da 100%);
    display: grid; place-items: center;
}
.gb-about__about-visual svg {
    position: relative; z-index: 1;
    width: 55%; height: auto; opacity: .94;
}
@media (max-width: 800px) {
    .gb-about__about { grid-template-columns: 1fr; gap: 2rem; }
    .gb-about__about-visual { max-width: 380px; margin: 0 auto; }
}

/* ============ PILLARS ============ */
.gb-about__pillars {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 1.2rem;
}
.gb-about__pillar {
    background: #fff;
    border: 1px solid var(--gb-border);
    border-radius: 22px;
    padding: 2rem 1.7rem;
    position: relative;
    overflow: hidden;
    transition: transform .25s ease, box-shadow .25s ease, border-color .25s;
}
.gb-about__pillar::before {
    content: "";
    position: absolute; top: 0; left: 0; right: 0; height: 3px;
    background: linear-gradient(90deg, var(--gb-primary), var(--gb-secondary));
    opacity: 0;
    transition: opacity .25s;
}
.gb-about__pillar:hover {
    transform: translateY(-4px);
    box-shadow: 0 22px 50px -20px rgba(13, 31, 21, .22);
    border-color: var(--gb-secondary);
}
.gb-about__pillar:hover::before { opacity: 1; }
.gb-about__pillar-icon {
    display: inline-flex; align-items: center; justify-content: center;
    width: 56px; height: 56px;
    border-radius: 16px;
    background: linear-gradient(135deg, var(--gb-soft) 0%, #dceadc 100%);
    color: var(--gb-primary);
    margin-bottom: 1.3rem;
}
.gb-about__pillar-icon svg { width: 28px; height: 28px; }
.gb-about__pillar h3 {
    font-size: 1.15rem; font-weight: 700;
    color: var(--gb-dark);
    margin: 0 0 .6rem;
    letter-spacing: -.015em;
}
.gb-about__pillar p {
    font-size: .96rem;
    color: var(--gb-muted);
    line-height: 1.6;
    margin: 0;
}

/* ============ TEAM ============ */
.gb-about__team {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1.2rem;
}
.gb-about__team-card {
    background: #fff;
    border: 1px solid var(--gb-border);
    border-radius: 22px;
    padding: 1.8rem 1.4rem 1.6rem;
    text-align: center;
    transition: transform .2s, box-shadow .2s, border-color .2s;
}
.gb-about__team-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 22px 50px -22px rgba(13, 31, 21, .2);
    border-color: var(--gb-secondary);
}
.gb-about__team-avatar {
    width: 88px; height: 88px;
    border-radius: 50%;
    margin: 0 auto 1rem;
    display: grid; place-items: center;
    background: linear-gradient(135deg, var(--gb-soft) 0%, var(--gb-secondary) 100%);
    color: var(--gb-primary-dark);
    font-size: 1.7rem;
    font-weight: 700;
    letter-spacing: -.02em;
    position: relative;
    overflow: hidden;
    border: 3px solid #fff;
    box-shadow: 0 6px 20px -6px rgba(13, 31, 21, .25);
}
.gb-about__team-name {
    font-size: 1.05rem;
    font-weight: 700;
    color: var(--gb-dark);
    margin: 0 0 .25rem;
    letter-spacing: -.01em;
}
.gb-about__team-role {
    font-size: .85rem;
    font-weight: 500;
    color: var(--gb-primary);
    margin: 0 0 .6rem;
    text-transform: uppercase;
    letter-spacing: .06em;
}
.gb-about__team-bio {
    font-size: .9rem;
    color: var(--gb-muted);
    line-height: 1.5;
    margin: 0;
}

.gb-about__team-note {
    text-align: center;
    font-size: .85rem;
    color: var(--gb-muted-light);
    margin-top: 1.5rem;
    font-style: italic;
}

/* ============ TESTIMONIALS ============ */
.gb-about__testimonials {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.4rem;
}
.gb-about__quote {
    position: relative;
    background: #fff;
    border: 1px solid var(--gb-border);
    border-radius: 22px;
    padding: 2rem 1.8rem 1.6rem;
    overflow: hidden;
    transition: transform .25s, box-shadow .25s, border-color .25s;
}
.gb-about__quote::before {
    content: "”";
    position: absolute;
    top: -.6rem; right: 1rem;
    font-family: Georgia, serif;
    font-size: 6rem;
    line-height: 1;
    color: var(--gb-secondary);
    opacity: .35;
}
.gb-about__quote:hover {
    transform: translateY(-3px);
    box-shadow: 0 22px 50px -22px rgba(13, 31, 21, .2);
    border-color: var(--gb-secondary);
}
.gb-about__quote-stars {
    display: inline-flex; gap: .15rem;
    margin-bottom: 1rem;
    color: #f59e0b;
}
.gb-about__quote-stars svg { width: 16px; height: 16px; fill: currentColor; }
.gb-about__quote-text {
    font-size: 1rem;
    line-height: 1.65;
    color: var(--gb-text);
    margin: 0 0 1.5rem;
    position: relative; z-index: 1;
}
.gb-about__quote-author {
    display: flex; align-items: center; gap: .85rem;
    padding-top: 1.2rem;
    border-top: 1px solid var(--gb-border);
}
.gb-about__quote-avatar {
    width: 44px; height: 44px;
    border-radius: 50%;
    display: grid; place-items: center;
    background: linear-gradient(135deg, var(--gb-soft) 0%, var(--gb-secondary) 100%);
    color: var(--gb-primary-dark);
    font-size: .98rem;
    font-weight: 700;
    flex: 0 0 auto;
}
.gb-about__quote-meta strong {
    display: block;
    font-size: .94rem;
    font-weight: 700;
    color: var(--gb-dark);
    line-height: 1.2;
}
.gb-about__quote-meta span {
    display: block;
    font-size: .82rem;
    color: var(--gb-muted);
    line-height: 1.3;
    margin-top: .1rem;
}

/* ============ SECTORS ============ */
.gb-about__sectors {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(210px, 1fr));
    gap: .85rem;
}
.gb-about__sector {
    display: flex; align-items: center; gap: .9rem;
    padding: 1rem 1.15rem;
    background: var(--gb-soft);
    border: 1px solid #d6e7d1;
    border-radius: 14px;
    transition: background .2s, transform .2s, border-color .2s;
}
.gb-about__sector:hover {
    background: var(--gb-soft-2);
    border-color: var(--gb-secondary);
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

/* ============ COVERAGE (sin mapa) ============ */
.gb-about__coverage {
    position: relative; overflow: hidden;
    padding: 3rem 2.5rem;
    background:
        radial-gradient(700px 400px at 100% 0%, rgba(168, 200, 150, .22), transparent 60%),
        linear-gradient(135deg, var(--gb-dark) 0%, #1a3a26 100%);
    color: #fff;
    border-radius: 28px;
    box-shadow: 0 30px 70px -30px rgba(13, 31, 21, .4);
}
.gb-about__coverage-head {
    display: grid;
    grid-template-columns: 1.2fr 1fr;
    gap: 2.5rem;
    align-items: center;
    margin-bottom: 2.5rem;
}
.gb-about__coverage h3 {
    font-size: clamp(1.5rem, 2.6vw, 2rem);
    line-height: 1.2;
    color: #fff;
    margin: 0 0 1rem;
    font-weight: 700;
    letter-spacing: -.022em;
}
.gb-about__coverage p {
    color: rgba(255, 255, 255, .85);
    font-size: 1.02rem; line-height: 1.65;
    margin: 0;
    max-width: 480px;
}
.gb-about__cov-tags {
    display: flex; flex-wrap: wrap; gap: .55rem;
    justify-content: flex-start;
}
.gb-about__cov-tag {
    display: inline-flex; align-items: center; gap: .4rem;
    padding: .45rem .95rem;
    background: rgba(255, 255, 255, .1);
    border: 1px solid rgba(255, 255, 255, .22);
    border-radius: 999px;
    font-size: .84rem; font-weight: 600;
    color: #fff;
}
.gb-about__cov-tag svg { width: 12px; height: 12px; }

.gb-about__cov-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1rem;
    padding-top: 2rem;
    border-top: 1px solid rgba(255, 255, 255, .15);
}
.gb-about__cov-stat {
    text-align: left;
}
.gb-about__cov-stat-num {
    font-size: 2.2rem; line-height: 1;
    font-weight: 700;
    color: var(--gb-secondary);
    letter-spacing: -.03em;
    margin-bottom: .4rem;
    font-variant-numeric: tabular-nums;
}
.gb-about__cov-stat-label {
    font-size: .88rem;
    color: rgba(255, 255, 255, .8);
    line-height: 1.4;
}

@media (max-width: 800px) {
    .gb-about__coverage { padding: 2.2rem 1.6rem; }
    .gb-about__coverage-head { grid-template-columns: 1fr; gap: 1.5rem; }
}

/* ============ FINAL CTA ============ */
.gb-about__final {
    display: grid; grid-template-columns: 1.7fr 1fr;
    gap: 2rem; align-items: center;
    padding: 2.6rem 2.6rem;
    background: linear-gradient(135deg, #fff 0%, var(--gb-soft) 100%);
    border: 1px solid var(--gb-border);
    border-radius: 24px;
}
.gb-about__final-eyebrow {
    display: inline-flex; align-items: center; gap: .4rem;
    font-size: .76rem; font-weight: 700; letter-spacing: .12em;
    text-transform: uppercase;
    color: var(--gb-primary);
    margin-bottom: .8rem;
}
.gb-about__final h3 {
    font-size: clamp(1.5rem, 2.4vw, 2rem);
    color: var(--gb-dark);
    margin: 0 0 .6rem;
    line-height: 1.22;
    font-weight: 700;
    letter-spacing: -.022em;
}
.gb-about__final p {
    color: var(--gb-muted);
    font-size: 1rem; line-height: 1.6;
    margin: 0;
    max-width: 520px;
}
.gb-about__final-cta {
    display: inline-flex; align-items: center; justify-content: center; gap: .55rem;
    padding: 1rem 1.7rem;
    background: var(--gb-primary);
    color: #fff;
    text-decoration: none;
    border-radius: 12px;
    font-weight: 600; font-size: 1rem;
    box-shadow: 0 16px 32px -12px rgba(47, 122, 58, .55);
    transition: transform .2s, box-shadow .2s, filter .2s;
    justify-self: end;
}
.gb-about__final-cta:hover {
    transform: translateY(-2px);
    color: #fff; text-decoration: none;
    filter: brightness(1.05);
    box-shadow: 0 20px 38px -12px rgba(47, 122, 58, .65);
}
.gb-about__final-cta svg { width: 16px; height: 16px; }

@media (max-width: 760px) {
    .gb-about__final { grid-template-columns: 1fr; text-align: center; padding: 2.2rem 1.5rem; }
    .gb-about__final-cta { justify-self: stretch; }
    .gb-about__stats { margin-top: -4rem; }
    .gb-about__hero { padding-bottom: 5rem; }
}
</style>

<section class="gb-about">

    <!-- =========== HERO =========== -->
    <header class="gb-about__hero">
        <div class="gb-about__hero-grid">
            <div class="gb-about__hero-copy">
                <span class="gb-about__hero-eyebrow">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2 L13.5 8.5 L20 8.5 L14.7 12.7 L17 19.5 L12 15.4 L7 19.5 L9.3 12.7 L4 8.5 L10.5 8.5 Z"/></svg>
                    15+ años junto a empresas chilenas
                </span>
                <h1 class="gb-about__hero-title">Soluciones <em>sustentables</em> para empresas que valoran calidad y rapidez</h1>
                <p class="gb-about__hero-lead">Somos una empresa chilena dedicada al packaging, productos de higiene y aseo industrial. Atendidos directamente por sus dueños, garantizamos respuestas concretas y entregas confiables en todo el país.</p>
                <div class="gb-about__hero-actions">
                    <a href="/cotizacion" class="gb-about__hero-cta">
                        Solicitar cotización
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12 H19 M13 6 L19 12 L13 18"/></svg>
                    </a>
                    <a href="/tienda" class="gb-about__hero-secondary">
                        Ver catálogo
                    </a>
                </div>
            </div>
            <div class="gb-about__hero-visual" aria-hidden="true">
                <div class="gb-about__hero-badge">
                    <div class="gb-about__hero-badge-inner">
                        <strong>15+</strong>
                        <span>Años de experiencia</span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- =========== STATS =========== -->
    <div class="gb-about__stats">
        <div class="gb-about__stat">
            <span class="gb-about__stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7 V12 L15 14"/></svg></span>
            <div class="gb-about__stat-num"><em>15+</em></div>
            <div class="gb-about__stat-label">Años de experiencia en el rubro</div>
        </div>
        <div class="gb-about__stat">
            <span class="gb-about__stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 7 H17 L21 11 V17 H3 Z"/><circle cx="7" cy="18" r="2"/><circle cx="17" cy="18" r="2"/></svg></span>
            <div class="gb-about__stat-num">24-48<em>h</em></div>
            <div class="gb-about__stat-label">Despachos en Región Metropolitana</div>
        </div>
        <div class="gb-about__stat">
            <span class="gb-about__stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M3 12 H21 M12 3 a14 14 0 0 1 0 18 M12 3 a14 14 0 0 0 0 18"/></svg></span>
            <div class="gb-about__stat-num">100<em>%</em></div>
            <div class="gb-about__stat-label">Cobertura nacional en Chile</div>
        </div>
        <div class="gb-about__stat">
            <span class="gb-about__stat-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 21 V8 Q3 4 8 4 H16 Q21 4 21 8 V21 Z"/><path d="M8 11 H16 M8 15 H13"/></svg></span>
            <div class="gb-about__stat-num">B2B</div>
            <div class="gb-about__stat-label">Atención directa de los dueños</div>
        </div>
    </div>

    <!-- =========== ABOUT =========== -->
    <div class="gb-about__section">
        <div class="gb-about__about">
            <div class="gb-about__about-copy">
                <span class="gb-about__kicker">Quiénes somos</span>
                <h2>Una empresa chilena con foco en el detalle</h2>
                <p>GreenBags nació con la misión de entregar a las empresas soluciones de packaging, higiene y aseo industrial que combinen calidad, rapidez y responsabilidad ambiental.</p>
                <p>Después de más de 15 años en el rubro, somos una alternativa real para quienes valoran la atención cercana y necesitan un proveedor que cumpla. Sin intermediarios: trabajás directamente con quienes toman las decisiones.</p>
                <ul class="gb-about__about-feats">
                    <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M8 12 L11 15 L16 9"/></svg><span>Atención directa de los dueños, sin call centers ni capas intermedias.</span></li>
                    <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M8 12 L11 15 L16 9"/></svg><span>Productos biodegradables y compostables certificados.</span></li>
                    <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M8 12 L11 15 L16 9"/></svg><span>Despachos confiables en 24-48 horas dentro de la Región Metropolitana.</span></li>
                </ul>
            </div>
            <div class="gb-about__about-visual" aria-hidden="true">
                <svg viewBox="0 0 200 160" xmlns="http://www.w3.org/2000/svg" fill="none">
                    <path d="M55 55 L145 55 L155 140 Q155 150 145 150 L55 150 Q45 150 45 140 Z" fill="rgba(47,122,58,0.18)" stroke="rgba(47,122,58,0.55)" stroke-width="1.6"/>
                    <path d="M75 55 Q75 30 100 30 Q125 30 125 55" stroke="rgba(47,122,58,0.7)" stroke-width="2.2" stroke-linecap="round"/>
                    <path d="M100 80 Q80 90 80 110 Q80 125 100 125 Q120 125 120 110 Q120 90 100 80 Z" fill="rgba(47,122,58,0.55)"/>
                    <path d="M100 88 L100 122 M88 100 L100 105 M112 100 L100 105" stroke="#fff" stroke-width="1.4" stroke-linecap="round"/>
                </svg>
            </div>
        </div>
    </div>

    <!-- =========== PILLARS =========== -->
    <div class="gb-about__section">
        <div class="gb-about__head">
            <span class="gb-about__kicker">Nuestra propuesta de valor</span>
            <h2 class="gb-about__h">Tres pilares que marcan la diferencia</h2>
            <p class="gb-about__sub">No prometemos lo imposible: cumplimos en lo que realmente importa para que tu operación no se detenga.</p>
        </div>
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

    <!-- =========== TEAM =========== -->
    <div class="gb-about__section">
        <div class="gb-about__head">
            <span class="gb-about__kicker">Nuestro equipo</span>
            <h2 class="gb-about__h">Las personas detrás de GreenBags</h2>
            <p class="gb-about__sub">Un equipo pequeño y comprometido que conoce a sus clientes por nombre y se mete en cada pedido como si fuera el primero.</p>
        </div>
        <div class="gb-about__team">
            <div class="gb-about__team-card">
                <div class="gb-about__team-avatar">FA</div>
                <h3 class="gb-about__team-name">Felipe Álvarez</h3>
                <p class="gb-about__team-role">Socio fundador</p>
                <p class="gb-about__team-bio">Lidera la relación comercial y el contacto directo con los clientes.</p>
            </div>
            <div class="gb-about__team-card">
                <div class="gb-about__team-avatar">AS</div>
                <h3 class="gb-about__team-name">Álvaro Sánchez</h3>
                <p class="gb-about__team-role">Socio fundador</p>
                <p class="gb-about__team-bio">Coordina compras, sustentabilidad y nuevas líneas de producto.</p>
            </div>
            <div class="gb-about__team-card">
                <div class="gb-about__team-avatar">LM</div>
                <h3 class="gb-about__team-name">Logística RM</h3>
                <p class="gb-about__team-role">Operaciones</p>
                <p class="gb-about__team-bio">El equipo que arma, despacha y entrega tus pedidos en 24-48 horas.</p>
            </div>
            <div class="gb-about__team-card">
                <div class="gb-about__team-avatar">AV</div>
                <h3 class="gb-about__team-name">Atención al cliente</h3>
                <p class="gb-about__team-role">Postventa</p>
                <p class="gb-about__team-bio">Te acompañamos antes, durante y después de cada compra.</p>
            </div>
        </div>
        <p class="gb-about__team-note">Las fotos del equipo se cargan desde el admin → Páginas → Sobre GreenBags.</p>
    </div>

    <!-- =========== TESTIMONIALS =========== -->
    <div class="gb-about__section">
        <div class="gb-about__head">
            <span class="gb-about__kicker">Lo que dicen nuestros clientes</span>
            <h2 class="gb-about__h">Empresas que confían en GreenBags</h2>
            <p class="gb-about__sub">Quienes nos eligen valoran la cercanía, la rapidez y los productos que no fallan en su día a día.</p>
        </div>
        <div class="gb-about__testimonials">
            <article class="gb-about__quote">
                <div class="gb-about__quote-stars" aria-label="5 estrellas">
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                </div>
                <p class="gb-about__quote-text">Pedí cotización un martes y al jueves ya tenía mi pedido completo en la cafetería. El packaging compostable nos dejó cumplir con las políticas del mall sin sufrir.</p>
                <div class="gb-about__quote-author">
                    <div class="gb-about__quote-avatar">CT</div>
                    <div class="gb-about__quote-meta">
                        <strong>Carolina T.</strong>
                        <span>Cafetería boutique · Las Condes</span>
                    </div>
                </div>
            </article>
            <article class="gb-about__quote">
                <div class="gb-about__quote-stars" aria-label="5 estrellas">
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                </div>
                <p class="gb-about__quote-text">Probamos con tres proveedores antes de quedarnos con GreenBags. Atienden los dueños, responden el mismo día y nunca nos quedamos sin stock para el food truck.</p>
                <div class="gb-about__quote-author">
                    <div class="gb-about__quote-avatar">RM</div>
                    <div class="gb-about__quote-meta">
                        <strong>Rodrigo M.</strong>
                        <span>Food truck · Providencia</span>
                    </div>
                </div>
            </article>
            <article class="gb-about__quote">
                <div class="gb-about__quote-stars" aria-label="5 estrellas">
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                    <svg viewBox="0 0 24 24"><path d="M12 2 L14.85 8.6 L22 9.3 L16.5 14 L18.2 21 L12 17.3 L5.8 21 L7.5 14 L2 9.3 L9.15 8.6 Z"/></svg>
                </div>
                <p class="gb-about__quote-text">Para nuestras pastelerías el packaging es parte de la experiencia. Encontramos cajas con diseño cuidado y materiales certificados que se sienten premium.</p>
                <div class="gb-about__quote-author">
                    <div class="gb-about__quote-avatar">MJ</div>
                    <div class="gb-about__quote-meta">
                        <strong>María José L.</strong>
                        <span>Pastelería · Ñuñoa</span>
                    </div>
                </div>
            </article>
        </div>
        <p class="gb-about__team-note">Testimonios de ejemplo: editables desde admin → Páginas → Sobre GreenBags.</p>
    </div>

    <!-- =========== SECTORS =========== -->
    <div class="gb-about__section">
        <div class="gb-about__head">
            <span class="gb-about__kicker">A quiénes acompañamos</span>
            <h2 class="gb-about__h">Empresas del rubro alimentario, retail y servicios</h2>
            <p class="gb-about__sub">Trabajamos con quienes mueven el día a día del país: desde el food truck del barrio hasta cadenas con presencia nacional.</p>
        </div>
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

    <!-- =========== COVERAGE (sin mapa) =========== -->
    <div class="gb-about__section">
        <div class="gb-about__coverage">
            <div class="gb-about__coverage-head">
                <div>
                    <h3>Foco en RM, capacidad para todo Chile</h3>
                    <p>Operamos desde la Región Metropolitana con despachos en 24-48 horas, y coordinamos envíos al resto del país con proveedores logísticos confiables.</p>
                </div>
                <div class="gb-about__cov-tags">
                    <span class="gb-about__cov-tag"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="4"/></svg>Región Metropolitana</span>
                    <span class="gb-about__cov-tag"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="4"/></svg>Norte Grande</span>
                    <span class="gb-about__cov-tag"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="4"/></svg>Zona Centro</span>
                    <span class="gb-about__cov-tag"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="4"/></svg>Sur</span>
                    <span class="gb-about__cov-tag"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="4"/></svg>Patagonia</span>
                </div>
            </div>
            <div class="gb-about__cov-grid">
                <div class="gb-about__cov-stat">
                    <div class="gb-about__cov-stat-num">16</div>
                    <div class="gb-about__cov-stat-label">Regiones con envío disponible</div>
                </div>
                <div class="gb-about__cov-stat">
                    <div class="gb-about__cov-stat-num">24-48h</div>
                    <div class="gb-about__cov-stat-label">Despacho promedio en RM</div>
                </div>
                <div class="gb-about__cov-stat">
                    <div class="gb-about__cov-stat-num">3-5 días</div>
                    <div class="gb-about__cov-stat-label">Despacho a regiones</div>
                </div>
                <div class="gb-about__cov-stat">
                    <div class="gb-about__cov-stat-num">99%</div>
                    <div class="gb-about__cov-stat-label">Entregas a tiempo</div>
                </div>
            </div>
        </div>
    </div>

    <!-- =========== FINAL CTA =========== -->
    <div class="gb-about__section">
        <div class="gb-about__final">
            <div>
                <span class="gb-about__final-eyebrow">Empezá hoy</span>
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
WHERE slug = 'sobre-greenbags';
