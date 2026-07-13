-- ============================================================================
-- CLIENTE: GreenBags — logos reales de certificaciones en "Compromiso
-- sustentable", con protagonismo visual (carpeta assets/logos-certificaciones/
-- provista por el cliente).
-- ----------------------------------------------------------------------------
-- La sección "Certificaciones" era un panel-nota placeholder ("El detalle de
-- nuestras certificaciones está en actualización") con solo links externos.
-- La 052 había dejado 4 slots editables desde el panel (cert_logo_1..4) para
-- cuando el cliente subiera logos, pero seguían vacíos y ocultos.
--
-- Ahora el cliente entregó 8 sellos reales (forestal, compostabilidad,
-- reciclabilidad). Se versionan directo en el repo (no dependen de que un
-- admin los suba) para que carguen de inmediato en cualquier instalación:
--   uploads/library/greenbags/certificaciones/*.jpg
--
-- Esta migración reemplaza la fila placeholder de la 052 + el panel-nota por
-- una sección con protagonismo: encabezado, intro, y los 8 logos agrupados en
-- 3 categorías dentro de tarjetas con hover. Se conservan los links externos
-- de referencia (tugou/ecoitalia) como "más información" al final.
--
-- Deja huérfanos (inofensivos, no se renderizan): el CSS .gbs-cert-logos de la
-- 052 y los 4 campos "Logo N" del panel de imágenes en settings.php, que se
-- eliminan en el mismo cambio de código (no en SQL).
-- ============================================================================

UPDATE pages
   SET body = REPLACE(
       body,
'<!-- ====== Certificaciones ====== -->
    <section class="gbs-certsec">
        <p class="gbs-kicker" data-reveal>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="9" r="6"/><path d="M9 14.5 8 22l4-2 4 2-1-7.5"/></svg>
            Certificaciones
        </p>
        <div class="gbs-cert-logos" data-reveal style="--reveal-delay:.08s">
            <img class="gbs-cert-logo" src="{{img:cert_logo_1}}" alt="Certificacion" loading="lazy">
            <img class="gbs-cert-logo" src="{{img:cert_logo_2}}" alt="Certificacion" loading="lazy">
            <img class="gbs-cert-logo" src="{{img:cert_logo_3}}" alt="Certificacion" loading="lazy">
            <img class="gbs-cert-logo" src="{{img:cert_logo_4}}" alt="Certificacion" loading="lazy">
        </div>
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
    </section>',
'<!-- ====== Certificaciones ====== -->
    <section class="gbs-certsec">
        <p class="gbs-kicker" data-reveal>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="9" r="6"/><path d="M9 14.5 8 22l4-2 4 2-1-7.5"/></svg>
            Certificaciones
        </p>
        <h2 class="gbs-h2" data-reveal style="--reveal-delay:.06s">Sellos que respaldan cada producto</h2>
        <p class="gbs-certs-intro" data-reveal style="--reveal-delay:.1s">Nuestro packaging biodegradable y compostable cuenta con el respaldo de organismos internacionales que certifican su origen, compostabilidad y reciclabilidad.</p>

        <div class="gbs-certgroup" data-reveal style="--reveal-delay:.14s">
            <h3 class="gbs-certgroup__title">Origen forestal</h3>
            <div class="gbs-certgrid">
                <figure class="gbs-certlogo">
                    <img src="/uploads/library/greenbags/certificaciones/pefc.jpg" alt="PEFC — papel de bosques gestionados de forma sostenible" loading="lazy">
                </figure>
                <figure class="gbs-certlogo">
                    <img src="/uploads/library/greenbags/certificaciones/fsc.jpg" alt="FSC — papel de fuentes responsables" loading="lazy">
                </figure>
            </div>
        </div>

        <div class="gbs-certgroup" data-reveal style="--reveal-delay:.18s">
            <h3 class="gbs-certgroup__title">Compostabilidad</h3>
            <div class="gbs-certgrid">
                <figure class="gbs-certlogo">
                    <img src="/uploads/library/greenbags/certificaciones/as5810-home-compostable.jpg" alt="AS 5810 — compostaje doméstico (Australia)" loading="lazy">
                </figure>
                <figure class="gbs-certlogo">
                    <img src="/uploads/library/greenbags/certificaciones/din-en13432-astm-d6400-compostable.jpg" alt="DIN EN 13432 / ASTM D6400 — compostaje industrial" loading="lazy">
                </figure>
                <figure class="gbs-certlogo">
                    <img src="/uploads/library/greenbags/certificaciones/bpi-compostable-astm-d6400.jpg" alt="BPI — compostable ASTM D6400 (Norteamérica)" loading="lazy">
                </figure>
                <figure class="gbs-certlogo">
                    <img src="/uploads/library/greenbags/certificaciones/din-nf-t51800-home-compostable.jpg" alt="DIN NF T 51-800 — compostaje doméstico (Francia)" loading="lazy">
                </figure>
            </div>
        </div>

        <div class="gbs-certgroup" data-reveal style="--reveal-delay:.22s">
            <h3 class="gbs-certgroup__title">Reciclabilidad</h3>
            <div class="gbs-certgrid">
                <figure class="gbs-certlogo">
                    <img src="/uploads/library/greenbags/certificaciones/reciclable.jpg" alt="Reciclable" loading="lazy">
                </figure>
                <figure class="gbs-certlogo">
                    <img src="/uploads/library/greenbags/certificaciones/flustix-dinplus-reciclable.jpg" alt="Flustix DINplus — reciclable" loading="lazy">
                </figure>
            </div>
        </div>

        <p class="gbs-certs-more" data-reveal style="--reveal-delay:.26s">
            Más información:
            <a class="gbs-certs__link" href="https://tugou.cl/eco-tugou/" target="_blank" rel="noopener">
                tugou.cl/eco-tugou
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17 17 7M8 7h9v9"/></svg>
            </a>
            <a class="gbs-certs__link" href="https://ecoitalia.cl/certificaciones" target="_blank" rel="noopener">
                ecoitalia.cl/certificaciones
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17 17 7M8 7h9v9"/></svg>
            </a>
        </p>
    </section>')
 WHERE slug = 'sustentabilidad';

-- CSS de la nueva grilla (antes del único </style> de la página).
UPDATE pages
   SET body = REPLACE(
       body,
       '</style>',
'/* === Logos reales de certificaciones (jul 2026) === */
.gbs-certs-intro { max-width: 62ch; font-size: 1.02rem; color: var(--gbs-body); line-height: 1.75; margin: 0 0 2rem; }
.gbs-certgroup { margin: 0 0 1.8rem; }
.gbs-certgroup:last-of-type { margin-bottom: 0; }
.gbs-certgroup__title {
    font-size: .8rem; font-weight: 700; letter-spacing: .07em; text-transform: uppercase;
    color: var(--gbs-primary); margin: 0 0 .9rem;
}
.gbs-certgrid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 1.1rem; }
.gbs-certlogo {
    margin: 0; padding: .9rem;
    background: #fff;
    border: 1px solid color-mix(in srgb, var(--gbs-primary) 14%, #fff);
    border-radius: 16px;
    display: grid; place-items: center;
    transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease;
}
.gbs-certlogo:hover {
    transform: translateY(-4px) scale(1.02);
    box-shadow: 0 20px 40px -20px rgba(13, 40, 24, .3);
    border-color: color-mix(in srgb, var(--gbs-primary) 35%, #fff);
}
.gbs-certlogo img { width: 100%; height: auto; display: block; border-radius: 10px; }
@supports not (background: color-mix(in srgb, red, blue)) {
    .gbs-certlogo { border-color: #ddeed8; }
    .gbs-certlogo:hover { border-color: #a7dd98; }
}
.gbs-certs-more {
    margin: 1.8rem 0 0; font-size: .92rem; color: var(--gbs-muted);
    display: flex; flex-wrap: wrap; align-items: center; gap: .5rem .9rem;
}
@media (max-width: 640px) {
    .gbs-certgrid { grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); gap: .8rem; }
}
</style>')
 WHERE slug = 'sustentabilidad';
