-- ============================================================
-- CLEANUP: páginas genéricas del starter que ensucian el menú de GreenBags
-- ============================================================
-- El instalador (install/index.php) siembra `home`, `sobre-nosotros` y
-- `contacto` como ejemplos. Para GreenBags:
--   - `home` es siempre redundante: el home real es `/`, renderizado por
--     index.php desde lib/home.php. Una página publicada con slug `home`
--     aparece en el menú duplicando "Inicio".
--   - `sobre-nosotros` queda desplazado por `sobre-greenbags` (sembrado en
--     028_greenbags_seed.sql), por lo que el menú muestra dos entradas
--     equivalentes.
--
-- Estrategia (defensiva, no destructiva con ediciones del cliente):
--   1. Si el body sigue siendo el placeholder por defecto del instalador,
--      se BORRA la página (limpieza completa).
--   2. Si el body fue editado, se EXCLUYE del menú (exclude_from_menu = 1)
--      para preservar el contenido pero sacarlo del nav. El cliente puede
--      volver a publicarlo desde admin → Páginas si lo necesita.
-- ============================================================

-- `home`: placeholder original del instalador → borrar.
DELETE FROM pages
WHERE slug = 'home'
  AND body LIKE '%Esta es la página de inicio de ejemplo%';

-- `home` con contenido editado (si existe) → fuera del menú.
UPDATE pages
SET exclude_from_menu = 1
WHERE slug = 'home';

-- `sobre-nosotros`: placeholder original del instalador → borrar.
DELETE FROM pages
WHERE slug = 'sobre-nosotros'
  AND body LIKE '%Cuéntanos quién eres y qué haces%';

-- `sobre-nosotros` con contenido editado (si existe) → fuera del menú,
-- ya que `sobre-greenbags` es la página canónica para GreenBags.
UPDATE pages
SET exclude_from_menu = 1
WHERE slug = 'sobre-nosotros';

-- ============================================================
-- Limpieza de settings huérfanos
-- ============================================================
-- El bloque "Escríbenos" del home se eliminó del código. El setting
-- `home_show_contact` queda huérfano: si estaba en '1', seguía mostrando
-- el form aunque no se usaba; ahora directamente lo borramos.
DELETE FROM settings WHERE setting_key = 'home_show_contact';
