-- ============================================================
-- Página de Contacto: settings de copy + demo data de contacto
-- ============================================================
-- Esta migración deja la página /contacto lista para visualizar:
--   1) Settings `contact_*` con el copy editorial (eyebrow, título, intros).
--   2) Settings `business_*` rellenos con DEMO data plausible (Chile/GreenBags)
--      SOLO si están vacíos — preserva ediciones del cliente desde admin.
--   3) Entrada en `pages` con slug=`contacto`, asegura título y published=1.
--   4) Dos sucursales demo si la tabla branches está vacía.
--
-- Idempotente: se puede correr varias veces. Las queries que rellenan
-- business_* usan `IF(setting_value = '' OR IS NULL, demo, current)` para
-- nunca pisar valores ya cargados.
--
-- AL FORKEAR PARA OTRO CLIENTE:
--   Borrar este archivo o renombrarlo con prefix `_` para que no corra.
--   El admin podrá igualmente armar la página desde admin → Contacto.
-- ============================================================

-- ── Copy editorial de /contacto (contact_*) ──
-- Se siembran sólo si no existen. ON DUPLICATE → no-op para preservar edits.
INSERT INTO settings (setting_key, setting_value) VALUES
    ('contact_eyebrow',             'Estamos para ayudarte'),
    ('contact_title',               'Hablemos sobre tu próximo pedido'),
    ('contact_intro',               'Cotizamos packaging, productos de higiene y aseo para empresas. Elegí el canal que más te acomode: respondemos en menos de 4 horas hábiles.'),
    ('contact_methods_title',       'Canales directos'),
    ('contact_form_title',          'Escribinos un mensaje'),
    ('contact_form_intro',          'Contanos qué productos te interesan o qué problema querés resolver y un ejecutivo de GreenBags te responde a la brevedad.'),
    ('contact_form_success_title',  '¡Gracias por escribirnos!'),
    ('contact_form_success_body',   'Recibimos tu mensaje y nos contactamos en las próximas horas hábiles. Si es urgente, escribinos por WhatsApp.'),
    ('contact_map_title',           'Dónde estamos'),
    ('contact_map_embed',           'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d106432.69734395538!2d-70.71067699999999!3d-33.4488897!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9662c5410425af2f%3A0x8475d53c400f0931!2sSantiago%2C%20Chile!5e0!3m2!1ses!2sar!4v1700000000000!5m2!1ses!2sar'),
    ('contact_branches_title',      'Nuestros puntos de atención'),
    ('contact_show_methods',        '1'),
    ('contact_show_form',           '1'),
    ('contact_show_map',            '1'),
    ('contact_show_branches',       '1'),
    ('contact_meta_description',    'Contactá a GreenBags por WhatsApp, email o teléfono. Cotizamos packaging sustentable, higiene y aseo para empresas en Chile.')
ON DUPLICATE KEY UPDATE setting_key = setting_key;

-- ── Datos de contacto demo (business_*) ──
-- Sólo rellena si están vacíos: preserva ediciones del cliente.
INSERT INTO settings (setting_key, setting_value) VALUES ('business_email', 'contacto@greenbags.cl')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

INSERT INTO settings (setting_key, setting_value) VALUES ('business_phone', '+56 2 2234 5678')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

INSERT INTO settings (setting_key, setting_value) VALUES ('business_whatsapp', '56912345678')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

INSERT INTO settings (setting_key, setting_value) VALUES ('business_whatsapp_text', 'Hola GreenBags, vengo desde la página de contacto y quiero cotizar.')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

INSERT INTO settings (setting_key, setting_value) VALUES ('business_address', 'Av. Providencia 1234, Of. 503')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

INSERT INTO settings (setting_key, setting_value) VALUES ('business_postal_code', '7500000')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

INSERT INTO settings (setting_key, setting_value) VALUES ('business_maps_url', 'https://maps.app.goo.gl/8Jc8eqJfMxPN5tQE9')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

INSERT INTO settings (setting_key, setting_value) VALUES ('business_hours', 'Lun a Vie 9:00 - 18:00 · Sáb 10:00 - 13:00')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

-- Redes demo (sólo si vacías).
INSERT INTO settings (setting_key, setting_value) VALUES ('social_instagram', 'https://instagram.com/greenbagschile')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

INSERT INTO settings (setting_key, setting_value) VALUES ('social_facebook', 'https://facebook.com/greenbagschile')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

INSERT INTO settings (setting_key, setting_value) VALUES ('social_linkedin', 'https://linkedin.com/company/greenbags')
ON DUPLICATE KEY UPDATE setting_value = IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

-- ── Página /contacto ──
-- Asegura que exista publicada, con título 'Contacto'. Body se ignora (el
-- route renderiza el template a medida) pero lo limpiamos para que no
-- quede el placeholder viejo del instalador en caso de que el cliente vuelva
-- a un render genérico en el futuro.
INSERT INTO pages (slug, title, body, meta_description, is_published, exclude_from_menu)
VALUES (
    'contacto',
    'Contacto',
    '',
    'Contactá a GreenBags por WhatsApp, email o teléfono. Cotizamos packaging sustentable, higiene y aseo para empresas en Chile.',
    1,
    0
)
ON DUPLICATE KEY UPDATE
    title             = VALUES(title),
    is_published      = 1,
    exclude_from_menu = 0;

-- Si el body original era el placeholder del instalador ("Escríbenos a..."),
-- lo limpiamos para no dejar HTML huérfano. El route ya no lo usa, pero queda
-- prolijo en la tabla.
UPDATE pages
SET body = ''
WHERE slug = 'contacto'
  AND body LIKE '%Escríbenos a%formulario de la%';

-- ── Sucursales demo (sólo si la tabla está vacía) ──
INSERT INTO branches (name, address, city, region, country, postal_code, phone, whatsapp, email, hours, maps_url, sort_order, is_active)
SELECT * FROM (
    SELECT
        'Casa Matriz Providencia' AS name,
        'Av. Providencia 1234, Of. 503' AS address,
        'Santiago' AS city,
        'Región Metropolitana' AS region,
        'Chile' AS country,
        '7500000' AS postal_code,
        '+56 2 2234 5678' AS phone,
        '56912345678' AS whatsapp,
        'providencia@greenbags.cl' AS email,
        'Lun-Vie 9:00-18:00 · Sáb 10:00-13:00' AS hours,
        'https://maps.app.goo.gl/8Jc8eqJfMxPN5tQE9' AS maps_url,
        10 AS sort_order,
        1 AS is_active
) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM branches);

INSERT INTO branches (name, address, city, region, country, postal_code, phone, whatsapp, email, hours, maps_url, sort_order, is_active)
SELECT * FROM (
    SELECT
        'Centro de Distribución Quilicura' AS name,
        'Av. Industrial 4567, Bodega 12' AS address,
        'Quilicura' AS city,
        'Región Metropolitana' AS region,
        'Chile' AS country,
        '8710000' AS postal_code,
        '+56 2 2987 6543' AS phone,
        '56987654321' AS whatsapp,
        'despachos@greenbags.cl' AS email,
        'Lun-Vie 8:00-17:00 (retiro con cita)' AS hours,
        '' AS maps_url,
        20 AS sort_order,
        1 AS is_active
) AS tmp
WHERE (SELECT COUNT(*) FROM branches) <= 1;
