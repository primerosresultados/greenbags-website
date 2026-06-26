-- ============================================================================
-- Swap Inicio / Tienda
-- ----------------------------------------------------------------------------
-- Reorganización de contenido pedida por el cliente:
--   - Inicio (/)        → ahora muestra el contenido de "Sobre GreenBags"
--                         (ver index.php: home renderiza la página CMS
--                         `sobre-greenbags`).
--   - Tienda (/tienda)  → ahora muestra el landing de venta que antes era el
--                         home (ver lib/shop_front.php: homeRender()).
--   - Catálogo (/catalogo) → nueva URL de la grilla de productos.
--
-- Como Inicio ya ES "Sobre GreenBags", el ítem "Sobre GreenBags" del menú
-- quedaría duplicado → lo sacamos del menú (la página sigue accesible por su
-- slug, pero no se lista).
-- ============================================================================

UPDATE pages
SET exclude_from_menu = 1
WHERE slug = 'sobre-greenbags';
