-- ============================================================
-- CLIENTE: GreenBags — Inicio = landing comercial + verde de logo
-- ============================================================
-- Cambios de contenido/branding pedidos por el cliente:
--   1. El Inicio (/) vuelve a ser el LANDING COMERCIAL (homeRender:
--      hero + beneficios + categorías + destacados + CTA). Ver index.php.
--      /tienda queda como alias y redirige a /catalogo (shop_front.php).
--   2. Paleta ajustada al verde del logo: primario #51af3f (más vivo) y
--      secundario derivado #a7dd98. Se propaga a botones/CTA/badges vía
--      lib/layout.php (--brand-primary / --color-accent).
--   3. "Sobre GreenBags" deja de ser el home → vuelve al menú.
--
-- Idempotente: UPDATEs por clave. Pisa ediciones de admin sobre estos campos.
-- ============================================================

-- 1. Paleta de marca (verde del logo)
UPDATE settings SET setting_value = '#51af3f' WHERE setting_key = 'theme_primary';
UPDATE settings SET setting_value = '#a7dd98' WHERE setting_key = 'theme_secondary';

-- 2. "Sobre GreenBags" vuelve al menú (ya no es el home)
UPDATE pages SET exclude_from_menu = 0 WHERE slug = 'sobre-greenbags';
