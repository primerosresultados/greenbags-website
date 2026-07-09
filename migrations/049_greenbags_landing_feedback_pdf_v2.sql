-- ============================================================================
-- CLIENTE: GreenBags — 2ª ronda de feedback (PDF, jul 2026) sobre el landing.
-- ----------------------------------------------------------------------------
-- Sólo cambios de contenido de los banners del hero (texto). El resto del
-- feedback se resuelve por código (logo/footer/cotizador → CSS/PHP) o por
-- panel (imágenes de banners, story, categorías y logos de clientes).
--
-- Idempotente: UPDATE por título del banner (los títulos no cambian).
-- ============================================================================

-- 1. Banner "Reduce tu huella con cada pedido": el cliente pidió reemplazar
--    "sin resignar" por lenguaje más común → "sin sacrificar".
UPDATE banners
   SET subtitle = 'Materiales certificados y proveedores responsables, sin sacrificar calidad ni tiempos de entrega.'
 WHERE position = 'home_hero' AND title = 'Reduce tu huella con cada pedido';

-- 2. Banner "Soluciones para tu local gastronómico": texto revisado por el
--    cliente (según la necesidad de cada restaurante, cafetería y delivery).
UPDATE banners
   SET subtitle = 'Cajas, vasos, bolsas y cubiertos compostables pensados según la necesidad de cada restaurante, cafetería y delivery.'
 WHERE position = 'home_hero' AND title = 'Soluciones para tu local gastronómico';

-- 3. Banner "Bolsas de papel con tu marca": texto nuevo del cliente.
UPDATE banners
   SET subtitle = 'Impresión personalizada para tu local. Destaca tu marca de forma sustentable.'
 WHERE position = 'home_hero' AND title = 'Bolsas de papel con tu marca';
