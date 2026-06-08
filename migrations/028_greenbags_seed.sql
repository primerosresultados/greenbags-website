-- ============================================================
-- SEED ESPECÍFICO DE CLIENTE: GreenBags (packaging sustentable, Chile)
-- ============================================================
-- Esta migración carga la configuración inicial del sitio:
--   - Settings de identidad y contacto.
--   - Branding (paleta + announce bar + copy del home).
--   - Activación del módulo cotizaciones (B2B sin precios públicos).
--   - Categorías base del catálogo (las 7 del brief).
--   - Página "Sobre GreenBags" y "Gracias por cotizar".
--
-- AL FORKEAR EL STARTER PARA OTRO CLIENTE:
--   1) Borrar este archivo (o renombrarlo con prefix `_` para que no corra).
--   2) Crear `028_<cliente>_seed.sql` con los datos del nuevo proyecto.
--
-- Todos los INSERTs son idempotentes:
--   - Settings: `ON DUPLICATE KEY UPDATE setting_key = setting_key` → no
--     pisan ediciones del cliente desde el admin (si ya hay valor, no toca).
--   - Categorías / Páginas: `INSERT IGNORE` (slug es UNIQUE).
-- Se puede correr varias veces sin problema.
-- ============================================================

-- ── Identidad y contacto ──
INSERT INTO settings (setting_key, setting_value) VALUES
    ('site_name',               'GreenBags'),
    ('timezone',                'America/Santiago'),
    ('business_legal_name',     'GreenBags SpA'),
    ('business_tagline',        'Packaging sustentable para empresas'),
    ('business_description',    'Comercializamos soluciones de packaging, productos de higiene, aseo y manipulación de alimentos para empresas. Más de 15 años entregando soluciones sustentables, atención personalizada y despachos rápidos en todo Chile.'),
    ('business_country',        'Chile'),
    ('business_region',         'Región Metropolitana'),
    ('business_city',           'Santiago'),
    ('business_hours',          'Lun-Vie 9:00-18:00'),
    ('business_whatsapp',       ''),
    ('business_whatsapp_text',  'Hola GreenBags, me interesa cotizar packaging para mi negocio.'),
    ('whatsapp_float',          '1'),
    ('store_country',           'CL'),
    ('store_currency',          'CLP'),
    ('currency_symbol',         '$'),
    ('currency_decimals',       '0')
ON DUPLICATE KEY UPDATE setting_key = setting_key;

-- ── Branding (paleta + header style + favicon vacío) ──
INSERT INTO settings (setting_key, setting_value) VALUES
    ('theme_primary',           '#2f7a3a'),
    ('theme_secondary',         '#a8c896'),
    ('header_style',            'classic'),
    ('announce_enabled',        '1'),
    ('announce_text',           'Despachos en 24-48 hs en Región Metropolitana · Cobertura nacional'),
    ('announce_bg',             '#1f3a2b'),
    ('announce_fg',             '#ffffff'),
    ('announce_link_label',     ''),
    ('announce_link_url',       '')
ON DUPLICATE KEY UPDATE setting_key = setting_key;

-- ── Home page copy ──
INSERT INTO settings (setting_key, setting_value) VALUES
    ('home_hero_eyebrow',       '15 años cuidando tu negocio'),
    ('home_hero_title',         'Packaging sustentable para empresas que buscan calidad y rapidez'),
    ('home_hero_subtitle',      'Despachos en 24-48 horas · Atención directa de los dueños · Soluciones ecológicas certificadas.'),
    ('home_hero_cta_label',     'Solicitar cotización'),
    ('home_hero_cta_url',       '/cotizacion'),
    ('home_show_benefits',      '1'),
    ('home_show_categories',    '1'),
    ('home_show_featured',      '0'),
    ('home_show_story',         '1'),
    ('home_story_title',        'Más de 15 años junto a empresas chilenas'),
    ('home_story_body',         'Somos una empresa chilena dedicada a entregar soluciones de packaging, higiene y aseo a empresas que valoran la rapidez, la atención personalizada y la responsabilidad ambiental. Atendidos directamente por sus dueños, garantizamos respuestas concretas y entregas confiables. Acompañamos a Horeca, retail, industria y emprendedores con productos certificados y opciones sustentables que se adaptan a su escala.'),
    ('home_story_cta_label',    'Conocer GreenBags'),
    ('home_story_cta_url',      '/sobre-greenbags'),
    ('home_cta_title',          '¿Listo para conocer nuestras soluciones?'),
    ('home_cta_subtitle',       'Pedí una cotización personalizada o descargá nuestro catálogo.'),
    ('home_cta_label',          'Solicitar cotización'),
    ('home_cta_url',            '/cotizacion')
ON DUPLICATE KEY UPDATE setting_key = setting_key;

-- ── Activar módulo cotizaciones (B2B, sin precios públicos) ──
INSERT INTO settings (setting_key, setting_value) VALUES
    ('quotes_enabled',          '1'),
    ('quote_show_prices',       '0'),
    ('quote_require_company',   '1'),
    ('quote_require_taxid',     '0'),
    ('quote_intro_text',        'Contanos qué productos necesitás y tu equipo de GreenBags te enviará una propuesta en 24-48 horas hábiles.'),
    ('quote_button_label',      'Agregar a cotización'),
    ('quote_submit_label',      'Solicitar cotización'),
    ('quote_drawer_title',      'Mi cotización'),
    ('quote_thanks_slug',       'gracias-cotizacion'),
    ('quote_number_prefix',     'GB-'),
    ('quote_expiration_days',   '14')
ON DUPLICATE KEY UPDATE setting_key = setting_key;

-- ── Mailing (provider por defecto = mail nativo; cliente luego configura Resend) ──
INSERT INTO settings (setting_key, setting_value) VALUES
    ('mail_provider',           'mail'),
    ('notification_email',      '')
ON DUPLICATE KEY UPDATE setting_key = setting_key;

-- ============================================================
-- Categorías base (las 7 del brief). Sin parent → todas top-level.
-- ============================================================
INSERT IGNORE INTO categories (slug, name, description, sort_order, is_active) VALUES
    ('packaging-desechable',
     'Packaging Desechable',
     'Envases para comida, delivery, colaciones, repostería y panadería. Bandejas, vasos, tapas y contenedores.',
     10, 1),
    ('packaging-sustentable',
     'Packaging Sustentable',
     'Envases biodegradables, compostables y certificados. Alternativas ecológicas para empresas con políticas de economía circular.',
     20, 1),
    ('bolsas',
     'Bolsas',
     'Bolsas ecológicas, compostables, biodegradables. Para comercio, lavandería y empaque corporativo.',
     30, 1),
    ('productos-higiene',
     'Productos de Higiene',
     'Papel higiénico, toallas, dispensadores, jabones y sanitizantes para empresas.',
     40, 1),
    ('productos-aseo',
     'Productos de Aseo',
     'Limpiadores, desinfectantes, implementos e insumos de aseo industrial.',
     50, 1),
    ('manipulacion-alimentos',
     'Manipulación de Alimentos',
     'Guantes, delantales, elementos de protección e insumos para cocina industrial.',
     60, 1),
    ('personalizacion-corporativa',
     'Personalización Corporativa',
     'Bolsas con logo, packaging con marca, productos personalizados y material promocional corporativo.',
     70, 1);

-- ============================================================
-- Páginas base
-- ============================================================
INSERT IGNORE INTO pages (slug, title, body, meta_description, is_published, exclude_from_menu) VALUES
    ('sobre-greenbags',
     'Sobre GreenBags',
     '<h2>Quiénes somos</h2>
<p>GreenBags es una empresa chilena con más de 15 años de experiencia, dedicada a la comercialización de soluciones de packaging, productos de higiene, aseo y manipulación de alimentos para empresas.</p>
<h2>Nuestra propuesta de valor</h2>
<ul>
<li><strong>Atención personalizada y directa</strong> de sus propios dueños.</li>
<li><strong>Soluciones sustentables y biodegradables</strong> certificadas.</li>
<li><strong>Despachos rápidos</strong> entre 24 y 48 horas.</li>
</ul>
<h2>A quiénes acompañamos</h2>
<p>Trabajamos con restaurantes, cafeterías, casinos, food trucks, panaderías y pastelerías. También con distribuidores, supermercados, almacenes y minimarkets. Empresas de alimentación, aseo y lavanderías. Y emprendedores del rubro gastronómico que están iniciando su negocio.</p>
<h2>Cobertura</h2>
<p>Nuestro foco inicial es la Región Metropolitana, con capacidad de despacho a todo Chile.</p>',
     'GreenBags: más de 15 años abasteciendo a empresas chilenas con soluciones de packaging sustentable, higiene y aseo.',
     1, 0),

    ('sustentabilidad',
     'Compromiso sustentable',
     '<h2>Nuestro compromiso con la economía circular</h2>
<p>Trabajamos con proveedores certificados para ofrecer alternativas que reducen el impacto ambiental sin sacrificar calidad ni costos competitivos.</p>
<h2>Materiales y certificaciones</h2>
<ul>
<li>Envases <strong>biodegradables</strong> y <strong>compostables</strong> certificados.</li>
<li>Bolsas ecológicas y soluciones para reciclaje.</li>
<li>Productos alineados con la <strong>Ley REP</strong> (Responsabilidad Extendida del Productor).</li>
</ul>
<p>Si tu empresa tiene políticas de sustentabilidad, podemos ayudarte a cumplir tus objetivos ESG con el packaging que usás a diario.</p>',
     'Packaging sustentable certificado: biodegradable, compostable y alineado con Ley REP.',
     1, 0),

    ('gracias-cotizacion',
     '¡Gracias por tu solicitud!',
     '<p>Recibimos tu solicitud de cotización y un ejecutivo de <strong>GreenBags</strong> te va a contactar en las próximas 24-48 horas hábiles.</p>
<p>Si tu pedido es urgente, podés escribirnos por <strong>WhatsApp</strong> usando el botón flotante del sitio o el link en el pie de página.</p>
<p><a href="/" class="btn">← Volver al inicio</a></p>',
     'Tu solicitud de cotización fue recibida. Te respondemos en 24-48 horas.',
     1, 1);

-- ============================================================
-- Banner hero principal (idempotente: solo inserta si no existe ya uno con el
-- mismo título). El cliente puede subir una imagen desde admin → Banners.
-- ============================================================
INSERT INTO banners (position, eyebrow, title, subtitle, cta_label, cta_url, text_align, sort_order, is_active)
SELECT 'home_hero',
       '15 años cuidando tu negocio',
       'Packaging sustentable para empresas',
       'Despachos en 24-48 horas en Región Metropolitana · Atención directa de los dueños · Productos ecológicos certificados.',
       'Solicitar cotización',
       '/cotizacion',
       'left',
       1,
       1
WHERE NOT EXISTS (SELECT 1 FROM banners WHERE title = 'Packaging sustentable para empresas');

