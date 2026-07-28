-- ============================================================================
-- Migra el contenido existente al editor de bloques (061).
-- ----------------------------------------------------------------------------
-- "Sobre GreenBags" y "Compromiso sustentable" eran ~20 KB de HTML + CSS
-- embebido cada una: no se podían tocar desde el panel sin romper el diseño.
-- Acá se descomponen en bloques tipados con el MISMO copy aprobado por el
-- cliente (PDF jun 2026 + feedback jul 2026 + tuteo de la 060). El diseño ya no
-- viaja en el contenido: vive en assets/css/blocks.css.
--
-- pages.body NO se borra. Queda como respaldo y sólo se renderiza cuando la
-- página no tiene bloques, así el cambio es reversible borrando sus filas de
-- page_blocks.
--
-- Idempotente: cada página se llena una sola vez (NOT EXISTS sobre page_blocks
-- de esa página), en un único INSERT por página.
--
-- Se usa JSON_OBJECT/JSON_ARRAY en vez de escribir el JSON a mano: MySQL se
-- encarga de escapar comillas y acentos.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Sobre GreenBags
-- ---------------------------------------------------------------------------
INSERT INTO page_blocks (page_id, type, sort_order, is_active, data)
SELECT p.id, s.type, s.sort_order, 1, s.data
FROM pages p
JOIN (
    SELECT 'hero' AS type, 0 AS sort_order, CAST(JSON_OBJECT(
        'kicker',     'Empresa chilena',
        'title',      'Sobre GreenBags',
        'body',       '<p>GreenBags nació con la misión de entregar a las empresas soluciones de packaging, higiene y aseo industrial que combinen calidad, rapidez y responsabilidad ambiental.</p>',
        'image',      COALESCE((SELECT setting_value FROM settings WHERE setting_key = 'about_media_image'), '/uploads/library/greenbags/eco-sustentable.jpg'),
        'cta_label',  'Ver catálogo',
        'cta_url',    '/catalogo',
        'cta2_label', 'Contáctanos',
        'cta2_url',   '/contacto',
        'badge_num',  '+15',
        'badge_text', 'años de experiencia'
    ) AS CHAR) AS data

    UNION ALL SELECT 'text', 1, CAST(JSON_OBJECT(
        'kicker', 'Quiénes somos',
        'title',  'Una empresa chilena con foco en el detalle',
        'body',   CONCAT(
            '<p>Después de más de 15 años en el rubro, somos una alternativa real para quienes valoran la atención cercana y necesitan un proveedor que cumpla. Sin intermediarios: trabajas directamente con quienes toman las decisiones.</p>',
            '<p>Acompañamos a clientes de canal Horeca, retail, industria y emprendedores, con productos biodegradables y compostables certificados y despachos confiables en 24-48 horas dentro de la Región Metropolitana.</p>'
        ),
        'align',  'left',
        'width',  'narrow'
    ) AS CHAR)

    UNION ALL SELECT 'callout', 2, CAST(JSON_OBJECT(
        'icon',  'store',
        'title', 'Retiro en bodega',
        'body',  '<p>Lope de Vega 4516, Estación Central, previa coordinación.</p>'
    ) AS CHAR)

    UNION ALL SELECT 'cards', 3, CAST(JSON_OBJECT(
        'kicker', 'Lo que nos define',
        'title',  'Tres pilares que marcan la diferencia',
        'intro',  '',
        'cols',   '3',
        'items',  JSON_ARRAY(
            JSON_OBJECT('icon', 'chat',  'title', 'Atención cercana',
                        'body', 'Hablas con quienes resuelven, sin call centers ni capas intermedias.'),
            JSON_OBJECT('icon', 'leaf',  'title', 'Sustentables y certificados',
                        'body', 'Productos biodegradables y compostables certificados, alineados a la Ley REP y políticas ESG.'),
            JSON_OBJECT('icon', 'truck', 'title', 'Despachos en 24-48 horas',
                        'body', 'Logística confiable en la Región Metropolitana y cobertura nacional coordinada.')
        )
    ) AS CHAR)

    UNION ALL SELECT 'cta', 4, CAST(JSON_OBJECT(
        'title',     '¿Conversamos sobre tu próximo pedido?',
        'body',      'Escríbenos por el canal que más te acomode; respondemos en horario hábil, normalmente en menos de 4 horas.',
        'cta_label', 'Contáctanos',
        'cta_url',   '/contacto',
        'style',     'brand'
    ) AS CHAR)
) AS s
WHERE p.slug = 'sobre-greenbags'
  AND NOT EXISTS (SELECT 1 FROM page_blocks b WHERE b.page_id = p.id);


-- ---------------------------------------------------------------------------
-- Compromiso sustentable
-- ---------------------------------------------------------------------------
INSERT INTO page_blocks (page_id, type, sort_order, is_active, data)
SELECT p.id, s.type, s.sort_order, 1, s.data
FROM pages p
JOIN (
    SELECT 'hero' AS type, 0 AS sort_order, CAST(JSON_OBJECT(
        'kicker',     'Sustentabilidad',
        'title',      'Compromiso sustentable',
        'body',       '<p>En GreenBags trabajamos por una economía circular real: reducir, reutilizar y reemplazar los plásticos de un solo uso por alternativas certificadas.</p>',
        'image',      COALESCE((SELECT setting_value FROM settings WHERE setting_key = 'sustentabilidad_media_image'), '/uploads/library/greenbags/eco-sustentable.jpg'),
        'cta_label',  'Ver catálogo',
        'cta_url',    '/catalogo',
        'cta2_label', 'Contáctanos',
        'cta2_url',   '/contacto'
    ) AS CHAR) AS data

    UNION ALL SELECT 'text', 1, CAST(JSON_OBJECT(
        'kicker', 'Marco legal',
        'title',  'Ley 21.368',
        'body',   '<p>La Ley 21.368 regula la entrega de productos de plástico de un solo uso y promueve el uso de envases certificados como compostables o reutilizables. Acompañamos a nuestros clientes en el cumplimiento con soluciones alineadas a esta normativa.</p>',
        'align',  'left',
        'width',  'narrow'
    ) AS CHAR)

    UNION ALL SELECT 'cards', 2, CAST(JSON_OBJECT(
        'cols',  '3',
        'items', JSON_ARRAY(
            JSON_OBJECT('icon', 'recycle', 'title', 'Plásticos de un solo uso',
                        'body', 'Reemplazo por materiales de origen vegetal (fibra de caña, cartón y papel kraft) certificados.'),
            JSON_OBJECT('icon', 'award',   'title', 'Certificación de compostabilidad',
                        'body', 'Productos con certificación de compostabilidad y biodegradabilidad según normas vigentes.'),
            JSON_OBJECT('icon', 'shield',  'title', 'Ley REP',
                        'body', 'Responsabilidad Extendida del Productor: apoyamos la gestión responsable de residuos de envases y embalajes.')
        )
    ) AS CHAR)

    UNION ALL SELECT 'text', 3, CAST(JSON_OBJECT(
        'kicker', 'Certificaciones',
        'title',  'Sellos que respaldan cada producto',
        'body',   '<p>Nuestro packaging biodegradable y compostable cuenta con el respaldo de organismos internacionales que certifican su origen, compostabilidad y reciclabilidad.</p>',
        'align',  'left',
        'width',  'narrow'
    ) AS CHAR)

    UNION ALL SELECT 'logos', 4, CAST(JSON_OBJECT(
        'title', 'Origen forestal',
        'items', JSON_ARRAY(
            JSON_OBJECT('image', '/uploads/library/greenbags/certificaciones/pefc.jpg',
                        'alt',   'PEFC — papel de bosques gestionados de forma sostenible', 'url', ''),
            JSON_OBJECT('image', '/uploads/library/greenbags/certificaciones/fsc.jpg',
                        'alt',   'FSC — papel de fuentes responsables', 'url', '')
        )
    ) AS CHAR)

    UNION ALL SELECT 'logos', 5, CAST(JSON_OBJECT(
        'title', 'Compostabilidad',
        'items', JSON_ARRAY(
            JSON_OBJECT('image', '/uploads/library/greenbags/certificaciones/as5810-home-compostable.jpg',
                        'alt',   'AS 5810 — compostaje doméstico (Australia)', 'url', ''),
            JSON_OBJECT('image', '/uploads/library/greenbags/certificaciones/din-en13432-astm-d6400-compostable.jpg',
                        'alt',   'DIN EN 13432 / ASTM D6400 — compostaje industrial', 'url', ''),
            JSON_OBJECT('image', '/uploads/library/greenbags/certificaciones/bpi-compostable-astm-d6400.jpg',
                        'alt',   'BPI — compostable ASTM D6400 (Norteamérica)', 'url', ''),
            JSON_OBJECT('image', '/uploads/library/greenbags/certificaciones/din-nf-t51800-home-compostable.jpg',
                        'alt',   'DIN NF T 51-800 — compostaje doméstico (Francia)', 'url', '')
        )
    ) AS CHAR)

    UNION ALL SELECT 'logos', 6, CAST(JSON_OBJECT(
        'title', 'Reciclabilidad',
        'items', JSON_ARRAY(
            JSON_OBJECT('image', '/uploads/library/greenbags/certificaciones/reciclable.jpg',
                        'alt',   'Reciclable', 'url', ''),
            JSON_OBJECT('image', '/uploads/library/greenbags/certificaciones/flustix-dinplus-reciclable.jpg',
                        'alt',   'Flustix DINplus — reciclable', 'url', '')
        )
    ) AS CHAR)

    UNION ALL SELECT 'text', 7, CAST(JSON_OBJECT(
        'body',  CONCAT(
            '<p>Más información: ',
            '<a href="https://tugou.cl/eco-tugou/" target="_blank" rel="noopener">tugou.cl/eco-tugou</a> · ',
            '<a href="https://ecoitalia.cl/certificaciones" target="_blank" rel="noopener">ecoitalia.cl/certificaciones</a>',
            '</p>'
        ),
        'align', 'left',
        'width', 'narrow'
    ) AS CHAR)

    UNION ALL SELECT 'cta', 8, CAST(JSON_OBJECT(
        'title',     '¿Buscas alternativas sustentables para tu empresa?',
        'body',      'Explora nuestro catálogo de packaging biodegradable y compostable, o escríbenos y te ayudamos a elegir.',
        'cta_label', 'Ver catálogo',
        'cta_url',   '/catalogo',
        'style',     'brand'
    ) AS CHAR)
) AS s
WHERE p.slug = 'sustentabilidad'
  AND NOT EXISTS (SELECT 1 FROM page_blocks b WHERE b.page_id = p.id);


-- ---------------------------------------------------------------------------
-- Gracias (post-lead)
-- ---------------------------------------------------------------------------
INSERT INTO page_blocks (page_id, type, sort_order, is_active, data)
SELECT p.id, s.type, s.sort_order, 1, s.data
FROM pages p
JOIN (
    SELECT 'text' AS type, 0 AS sort_order, CAST(JSON_OBJECT(
        'body',  '<p>Recibimos tu consulta y te vamos a responder a la brevedad.</p>',
        'align', 'center',
        'width', 'narrow'
    ) AS CHAR) AS data

    UNION ALL SELECT 'cta', 1, CAST(JSON_OBJECT(
        'title',     '¿Seguimos viendo productos?',
        'body',      'Mientras te respondemos, puedes recorrer el catálogo completo.',
        'cta_label', 'Ver catálogo',
        'cta_url',   '/catalogo',
        'cta2_label','Volver al inicio',
        'cta2_url',  '/',
        'style',     'soft'
    ) AS CHAR)
) AS s
WHERE p.slug = 'gracias'
  AND NOT EXISTS (SELECT 1 FROM page_blocks b WHERE b.page_id = p.id);


-- ---------------------------------------------------------------------------
-- Gracias (post-cotización)
-- ---------------------------------------------------------------------------
INSERT INTO page_blocks (page_id, type, sort_order, is_active, data)
SELECT p.id, s.type, s.sort_order, 1, s.data
FROM pages p
JOIN (
    SELECT 'text' AS type, 0 AS sort_order, CAST(JSON_OBJECT(
        'body', CONCAT(
            '<p>Recibimos tu solicitud de cotización y un ejecutivo de <strong>GreenBags</strong> te va a contactar en las próximas 24-48 horas hábiles.</p>',
            '<p>Si tu pedido es urgente, puedes escribirnos por <strong>WhatsApp</strong> usando el botón flotante del sitio o el link en el pie de página.</p>'
        ),
        'align', 'center',
        'width', 'narrow'
    ) AS CHAR) AS data

    UNION ALL SELECT 'cta', 1, CAST(JSON_OBJECT(
        'title',      'Mientras tanto…',
        'body',       'Puedes seguir viendo el catálogo o volver al inicio.',
        'cta_label',  'Ver catálogo',
        'cta_url',    '/catalogo',
        'cta2_label', 'Volver al inicio',
        'cta2_url',   '/',
        'style',      'soft'
    ) AS CHAR)
) AS s
WHERE p.slug = 'gracias-cotizacion'
  AND NOT EXISTS (SELECT 1 FROM page_blocks b WHERE b.page_id = p.id);
