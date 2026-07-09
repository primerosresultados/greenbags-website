-- ============================================================================
-- Hacer editables desde el panel las imágenes embebidas en el HTML de las
-- páginas internas "Sobre GreenBags" y "Compromiso sustentable".
-- ----------------------------------------------------------------------------
-- Estrategia: se reemplaza el <img src> fijo por un token {{img:KEY}} que
-- pageBodyRender() (lib/helpers.php) resuelve al valor del setting en cada
-- render. Así el admin cambia la imagen desde un campo, sin tocar el HTML.
-- Idempotente: el default solo se inserta si no existe; el REPLACE por slug no
-- hace nada si el token ya está aplicado.
-- ============================================================================

-- 1. Settings con la ruta actual como valor por defecto (no pisar si ya existe).
INSERT INTO settings (setting_key, setting_value) VALUES
    ('about_media_image',          '/uploads/library/greenbags/eco-sustentable.jpg'),
    ('sustentabilidad_media_image','/uploads/library/greenbags/eco-sustentable.jpg')
ON DUPLICATE KEY UPDATE setting_value = setting_value;

-- 2. Tokenizar el <img> de cada página (surgical REPLACE, por slug).
UPDATE pages
   SET body = REPLACE(body, '/uploads/library/greenbags/eco-sustentable.jpg', '{{img:about_media_image}}')
 WHERE slug = 'sobre-greenbags';

UPDATE pages
   SET body = REPLACE(body, '/uploads/library/greenbags/eco-sustentable.jpg', '{{img:sustentabilidad_media_image}}')
 WHERE slug = 'sustentabilidad';
