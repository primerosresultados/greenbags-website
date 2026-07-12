-- ============================================================================
-- CLIENTE: GreenBags — feedback jul 2026 (capturas WhatsApp).
-- ----------------------------------------------------------------------------
-- Tres pedidos concretos del cliente:
--   1. "Sobre GreenBags": el ícono/tarjeta de "Retiro en bodega" se veía muy
--      chico; que se visualice más.  -> ícono grande con fondo de marca lleno,
--      título más grande, card con más aire.
--   2. "Sobre GreenBags": los "Tres pilares" se veían planos; que se noten más
--      los cuadros.  -> borde y sombra visibles por defecto (no solo en hover)
--      + íconos grandes con fondo de marca lleno.
--   3. "Compromiso sustentable" (Certificaciones): sumar los logos de las
--      certificaciones.  -> fila de logos editables desde el panel (slots
--      cert_logo_1..4). Vacíos se ocultan solos; la fila entera se oculta si no
--      hay ningún logo cargado, así hoy la página se ve igual que antes hasta
--      que el cliente suba los archivos.
--
-- Estrategia surgical (como 051): NO reescribe el body completo. Inyecta
-- overrides de CSS antes del único </style> de cada página y, en sustentable,
-- inserta la grilla de logos justo antes de la card de certificaciones. Así se
-- respeta la tokenización de imágenes de la 051 y cualquier edición previa.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1 + 2) "Sobre GreenBags": retiro en bodega y pilares más presentes.
-- ---------------------------------------------------------------------------
UPDATE pages
   SET body = REPLACE(
       body,
       '</style>',
'/* === Feedback cliente jul 2026: retiro en bodega + pilares más presentes === */
.gba-loc { padding: 1.9rem; }
.gba-loc__ico {
    width: 62px; height: 62px; border-radius: 16px;
    background: linear-gradient(135deg, var(--gba-primary), var(--gba-secondary));
    border: none; color: #fff;
    box-shadow: 0 12px 24px -12px color-mix(in srgb, var(--gba-primary) 55%, transparent);
}
.gba-loc__ico svg { width: 32px; height: 32px; }
.gba-loc strong { font-size: 1.3rem; }
.gba-loc p { font-size: 1rem; }
.gba-pillar {
    border-color: color-mix(in srgb, var(--gba-primary) 28%, #fff);
    box-shadow: 0 16px 34px -26px rgba(13, 40, 24, .38);
}
.gba-pillar__ico {
    width: 60px; height: 60px; border-radius: 16px;
    background: linear-gradient(135deg, var(--gba-primary), var(--gba-secondary));
    border: none; color: #fff;
    box-shadow: 0 12px 24px -12px color-mix(in srgb, var(--gba-primary) 50%, transparent);
}
.gba-pillar__ico svg { width: 30px; height: 30px; }
.gba-pillar h3 { font-size: 1.18rem; }
.gba-pillar p { font-size: 1rem; }
@supports not (background: color-mix(in srgb, red, blue)) {
    .gba-loc__ico, .gba-pillar__ico { background: #51af3f; border: none; color: #fff; }
    .gba-pillar { border-color: #cfe8c8; }
}
</style>')
 WHERE slug = 'sobre-greenbags';

-- ---------------------------------------------------------------------------
-- 3) "Compromiso sustentable": logos de certificaciones (editables por panel).
-- ---------------------------------------------------------------------------

-- 3a. Slots de logo (default vacío; no pisar si ya existen).
INSERT INTO settings (setting_key, setting_value) VALUES
    ('cert_logo_1', ''),
    ('cert_logo_2', ''),
    ('cert_logo_3', ''),
    ('cert_logo_4', '')
ON DUPLICATE KEY UPDATE setting_value = setting_value;

-- 3b. CSS de la grilla de logos (antes del único </style>).
UPDATE pages
   SET body = REPLACE(
       body,
       '</style>',
'/* === Feedback cliente jul 2026: logos de certificaciones === */
.gbs-cert-logos {
    display: flex; flex-wrap: wrap; align-items: center;
    gap: clamp(1.5rem, 4vw, 3rem);
    margin: 0 0 1.6rem;
}
.gbs-cert-logo { height: 68px; width: auto; max-width: 190px; object-fit: contain; }
.gbs-cert-logo[src=""], .gbs-cert-logo:not([src]) { display: none; }
/* Sin ningún logo cargado, la fila entera no aparece (la pagina queda como antes). */
.gbs-cert-logos:not(:has(.gbs-cert-logo[src]:not([src=""]))) { display: none; }
@media (max-width: 640px) { .gbs-cert-logo { height: 52px; } }
</style>')
 WHERE slug = 'sustentabilidad';

-- 3c. Insertar la grilla de logos justo antes de la card de certificaciones.
UPDATE pages
   SET body = REPLACE(
       body,
       '<div class="gbs-certs" data-reveal style="--reveal-delay:.1s">',
'<div class="gbs-cert-logos" data-reveal style="--reveal-delay:.08s">
            <img class="gbs-cert-logo" src="{{img:cert_logo_1}}" alt="Certificacion" loading="lazy">
            <img class="gbs-cert-logo" src="{{img:cert_logo_2}}" alt="Certificacion" loading="lazy">
            <img class="gbs-cert-logo" src="{{img:cert_logo_3}}" alt="Certificacion" loading="lazy">
            <img class="gbs-cert-logo" src="{{img:cert_logo_4}}" alt="Certificacion" loading="lazy">
        </div>
        <div class="gbs-certs" data-reveal style="--reveal-delay:.1s">')
 WHERE slug = 'sustentabilidad';
