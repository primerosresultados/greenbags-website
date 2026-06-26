-- ============================================================
-- CLIENTE: GreenBags — feedback del landing (PDF junio 2026)
-- ============================================================
-- Aplica los ajustes de contenido/settings pedidos por el cliente:
--   1.  site_name → "GreenBags" (estaba en el default "Mi Sitio", el seed 028
--       no lo pisó porque usa ON DUPLICATE KEY UPDATE no-op).
--   3.  Oculta la franja superior (announce bar + topbar de contacto/horario).
--   4.  Saca "Atención directa de los dueños" del subtítulo del hero.
--   5.  Oculta la tira de beneficios (Envíos / Pago / Devoluciones / Atención).
--   6.  Reemplaza la taxonomía de categorías por la lista nueva del PDF.
--   8.  Saca la repetición "Atendidos directamente por sus dueños" del story.
--   9.  Activa la sección "Nuestros clientes" (logos placeholder por ahora).
--   10. Contactos directos (Felipe Tapia / Alvaro Merello) + dirección nueva.
--   11. Nota de retiro en bodega previa coordinación.
--
-- Estrategia: updates condicionados al valor sembrado para no pisar ediciones
-- hechas desde el admin. Idempotente.
-- Al forkear el starter, borrar este archivo (ver docs/FORK_NEW_CLIENT.md).
-- ============================================================

-- ── 1) Identidad: nombre del sitio ──
UPDATE settings
   SET setting_value = 'GreenBags'
 WHERE setting_key = 'site_name'
   AND (setting_value IS NULL OR setting_value = '' OR setting_value = 'Mi Sitio');

-- ── 3) Franja superior: announce + topbar ──
UPDATE settings SET setting_value = '0' WHERE setting_key = 'announce_enabled';

INSERT INTO settings (setting_key, setting_value) VALUES
    ('header_show_topbar', '0')
ON DUPLICATE KEY UPDATE setting_value = '0';

-- ── 4) Hero: sacar "Atención directa de los dueños" ──
UPDATE settings
   SET setting_value = 'Despachos en 24-48 horas · Soluciones ecológicas certificadas.'
 WHERE setting_key = 'home_hero_subtitle'
   AND setting_value = 'Despachos en 24-48 horas · Atención directa de los dueños · Soluciones ecológicas certificadas.';

-- ── 5) Ocultar tira de beneficios ──
UPDATE settings SET setting_value = '0'
 WHERE setting_key = 'home_show_benefits' AND setting_value = '1';

-- ── 8) Story: quitar repetición "Atendidos directamente por sus dueños" ──
UPDATE settings
   SET setting_value = REPLACE(setting_value, ' Atendidos directamente por sus dueños, garantizamos', ' Garantizamos')
 WHERE setting_key = 'home_story_body';

-- ── 6) Categorías: reemplazar taxonomía por la lista del PDF ──
-- Primero desactivamos TODAS las actuales; luego upsert de las 8 nuevas.
UPDATE categories SET is_active = 0;

INSERT INTO categories (name, slug, sort_order, is_active) VALUES
    ('Packaging Ecológico',        'packaging-ecologico',        10, 1),
    ('Packaging Desechable',       'packaging-desechable',       20, 1),
    ('Bolsas',                     'bolsas',                     30, 1),
    ('Madera',                     'madera',                     40, 1),
    ('Film y Aluminio',            'film-y-aluminio',            50, 1),
    ('Cartón',                     'carton',                     60, 1),
    ('Aseo y Limpieza',            'aseo-y-limpieza',            70, 1),
    ('Personalización Productos',  'personalizacion-productos',  80, 1)
ON DUPLICATE KEY UPDATE
    name       = VALUES(name),
    sort_order = VALUES(sort_order),
    is_active  = 1;

-- ── 10) Dirección nueva ──
UPDATE settings SET setting_value = 'Lope de Vega 4516'
 WHERE setting_key = 'business_address';
UPDATE settings SET setting_value = 'Estación Central'
 WHERE setting_key = 'business_city';
UPDATE settings SET setting_value = 'Santiago'
 WHERE setting_key = 'business_region';

-- ── 10) Contactos directos ──
INSERT INTO settings (setting_key, setting_value) VALUES
    ('contact_person_1_name',  'Felipe Tapia'),
    ('contact_person_1_role',  'Contacto comercial'),
    ('contact_person_1_phone', '+56 9 9822 0252'),
    ('contact_person_1_email', 'ftapia@greenbags.cl'),
    ('contact_person_2_name',  'Alvaro Merello'),
    ('contact_person_2_role',  'Contacto comercial'),
    ('contact_person_2_phone', '+56 9 8358 2322'),
    ('contact_person_2_email', 'amerello@greenbags.cl')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- ── 11) Nota de retiro en bodega ──
INSERT INTO settings (setting_key, setting_value) VALUES
    ('business_pickup_note', 'Retiro en bodega disponible, previa coordinación.')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- ── 9) Sección "Nuestros clientes" (logos placeholder hasta tener los reales) ──
INSERT INTO settings (setting_key, setting_value) VALUES
    ('home_show_clients',  '1'),
    ('home_clients_title', 'Nuestros clientes'),
    ('home_clients_names', 'Ají Seco|Fuente Suiza|Buenos Muchachos|Hotel Hilton|Banco Santander')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);
