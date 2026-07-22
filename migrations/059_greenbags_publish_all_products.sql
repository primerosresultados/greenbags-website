-- ============================================================
-- CLIENTE: GreenBags - Publica TODOS los productos del catálogo.
-- El dashboard mostraba 962 productos pero la tienda solo 744, porque la
-- tienda filtra por status = 'published' y ~218 productos importados habían
-- quedado en estado 'draft'/'archived' (ver lib/catalog.php productsPublished).
-- Esta migración pasa a 'published' todo lo que no lo esté, para que el
-- catálogo público iguale al del panel.
-- Idempotente: solo toca las filas que aún no están publicadas.
-- Al forkear el starter, borrar este archivo (dato específico del cliente).
-- ============================================================

UPDATE products SET status = 'published' WHERE status <> 'published';
