-- ============================================================
-- CLIENTE: GreenBags — SEMILLA de medios subidos desde el admin.
--
-- El cliente cargó desde el admin el logo, la imagen del hero/story, las fotos
-- de las categorías y los logos de "Nuestros clientes". Esos archivos vivían en
-- `uploads/library/general/` SOLO en el hosting del demo (no estaban en git), por
-- eso al volver al dominio greenbags.cl las imágenes salían rotas: la base de
-- datos ya apuntaba a esas rutas, pero los archivos no se habían desplegado.
--
-- Esta migración (a) registra esos medios en la mediateca y (b) recablea el
-- home a esas imágenes SOLO si el campo está vacío, así que:
--   - En producción (BD que ya tenía el cableado) es un no-op: nada se pisa.
--   - En una instalación fresca deja el home igual que el demo.
-- Los .webp correspondientes están versionados en uploads/library/general/.
-- Idempotente: WHERE NOT EXISTS por file_path / sólo rellena columnas vacías.
-- Al forkear el starter, borrar este archivo (contenido específico del cliente).
-- ============================================================

-- 1) Registrar cada imagen en la mediateca (carpeta "General"). ---------------
INSERT INTO media_library (file_path, alt, title, mime, folder_id)
SELECT v.file_path, v.alt, v.title, 'image/webp',
       (SELECT id FROM media_folders WHERE slug = 'general' LIMIT 1)
FROM (
    SELECT '/uploads/library/general/m-eaec22ea55.webp' AS file_path, 'Greenbags.cl'              AS alt, 'Logo Greenbags'                 AS title UNION ALL
    SELECT '/uploads/library/general/m-a5f87aad39.webp', 'GreenBags packaging sustentable',       'Hero / marca GreenBags'          UNION ALL
    SELECT '/uploads/library/general/m-8846a1be11.webp', 'Packaging Ecológico',                   'Categoría Packaging Ecológico'   UNION ALL
    SELECT '/uploads/library/general/m-16eb4e6316.webp', 'Packaging Desechable',                  'Categoría Packaging Desechable'  UNION ALL
    SELECT '/uploads/library/general/m-3a8eb0df20.webp', 'Madera',                                'Categoría Madera'                UNION ALL
    SELECT '/uploads/library/general/m-d36346eee1.webp', 'Film y Aluminio',                       'Categoría Film y Aluminio'       UNION ALL
    SELECT '/uploads/library/general/m-ce11521d4e.webp', 'Cartón',                                'Categoría Cartón'                UNION ALL
    SELECT '/uploads/library/general/m-d7736a802b.webp', 'Aseo y Limpieza',                       'Categoría Aseo y Limpieza'       UNION ALL
    SELECT '/uploads/library/general/m-ce601665d6.webp', 'Personalización Productos',             'Categoría Personalización'       UNION ALL
    SELECT '/uploads/library/general/m-8d81290a7b.webp', 'Soluciones para tu local gastronómico', 'Banner HORECA'                   UNION ALL
    SELECT '/uploads/library/general/m-f3f3b3e191.webp', 'Vasos, tapas y cubiertos compostables', 'Banner línea completa'           UNION ALL
    SELECT '/uploads/library/general/m-01cea6baae.webp', 'Bolsas de papel con tu marca',          'Banner bolsas personalizadas'    UNION ALL
    SELECT '/uploads/library/general/m-0404158b7f.webp', 'Ají Seco',                              'Cliente Ají Seco'                UNION ALL
    SELECT '/uploads/library/general/m-063b4ea472.webp', 'Fuente Suiza',                          'Cliente Fuente Suiza'            UNION ALL
    SELECT '/uploads/library/general/m-d451913eb2.webp', 'Buenos Muchachos',                      'Cliente Buenos Muchachos'        UNION ALL
    SELECT '/uploads/library/general/m-eeee0d9bee.webp', 'Hotel Hilton',                          'Cliente Hotel Hilton'            UNION ALL
    SELECT '/uploads/library/general/m-b726cc46ee.webp', 'Banco Santander',                       'Cliente Banco Santander'
) AS v
WHERE NOT EXISTS (SELECT 1 FROM media_library m WHERE m.file_path = v.file_path);

-- 2) Logo del sitio y foto del bloque "storytelling" (settings). --------------
--    Rellena sólo si el valor está vacío/nulo; si el admin ya guardó algo, se
--    preserva (mismo criterio "sólo si está vacío" que el resto del seed).
INSERT INTO settings (setting_key, setting_value) VALUES
    ('logo_image',       '/uploads/library/general/m-eaec22ea55.webp'),
    ('home_story_image', '/uploads/library/general/m-a5f87aad39.webp')
ON DUPLICATE KEY UPDATE setting_value =
    IF(setting_value IS NULL OR setting_value = '', VALUES(setting_value), setting_value);

-- 3) Fotos de las categorías (sólo si la categoría aún no tiene imagen). -------
UPDATE categories c
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-8846a1be11.webp'
   SET c.image_id = m.id WHERE c.slug = 'packaging-ecologico'       AND c.image_id IS NULL;
UPDATE categories c
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-16eb4e6316.webp'
   SET c.image_id = m.id WHERE c.slug = 'packaging-desechable'      AND c.image_id IS NULL;
UPDATE categories c
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-8846a1be11.webp'
   SET c.image_id = m.id WHERE c.slug = 'bolsas'                    AND c.image_id IS NULL;
UPDATE categories c
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-3a8eb0df20.webp'
   SET c.image_id = m.id WHERE c.slug = 'madera'                    AND c.image_id IS NULL;
UPDATE categories c
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-d36346eee1.webp'
   SET c.image_id = m.id WHERE c.slug = 'film-y-aluminio'           AND c.image_id IS NULL;
UPDATE categories c
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-ce11521d4e.webp'
   SET c.image_id = m.id WHERE c.slug = 'carton'                    AND c.image_id IS NULL;
UPDATE categories c
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-d7736a802b.webp'
   SET c.image_id = m.id WHERE c.slug = 'aseo-y-limpieza'           AND c.image_id IS NULL;
UPDATE categories c
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-ce601665d6.webp'
   SET c.image_id = m.id WHERE c.slug = 'personalizacion-productos' AND c.image_id IS NULL;

-- 4) Logos de "Nuestros clientes" (sólo si el cliente aún no tiene logo). ------
UPDATE home_clients SET logo_path = '/uploads/library/general/m-0404158b7f.webp'
    WHERE name = 'Ají Seco'          AND (logo_path IS NULL OR logo_path = '');
UPDATE home_clients SET logo_path = '/uploads/library/general/m-063b4ea472.webp'
    WHERE name = 'Fuente Suiza'      AND (logo_path IS NULL OR logo_path = '');
UPDATE home_clients SET logo_path = '/uploads/library/general/m-d451913eb2.webp'
    WHERE name = 'Buenos Muchachos'  AND (logo_path IS NULL OR logo_path = '');
UPDATE home_clients SET logo_path = '/uploads/library/general/m-eeee0d9bee.webp'
    WHERE name = 'Hotel Hilton'      AND (logo_path IS NULL OR logo_path = '');
UPDATE home_clients SET logo_path = '/uploads/library/general/m-b726cc46ee.webp'
    WHERE name = 'Banco Santander'   AND (logo_path IS NULL OR logo_path = '');

-- 5) Imágenes de los banners del hero (sólo si el banner aún no tiene imagen). -
UPDATE banners b
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-8d81290a7b.webp'
   SET b.image_id = m.id
   WHERE b.position = 'home_hero' AND b.title = 'Soluciones para tu local gastronómico' AND b.image_id IS NULL;
UPDATE banners b
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-f3f3b3e191.webp'
   SET b.image_id = m.id
   WHERE b.position = 'home_hero' AND b.title = 'Vasos, tapas y cubiertos compostables' AND b.image_id IS NULL;
UPDATE banners b
   JOIN media_library m ON m.file_path = '/uploads/library/general/m-01cea6baae.webp'
   SET b.image_id = m.id
   WHERE b.position = 'home_hero' AND b.title = 'Bolsas de papel con tu marca' AND b.image_id IS NULL;
