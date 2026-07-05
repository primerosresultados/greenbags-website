-- ============================================================
-- Hero: más banners para que el slider tenga sentido (antes solo
-- había 1 banner activo, así que dots/flechas no se veían).
-- Idempotente: WHERE NOT EXISTS por título / file_path.
-- ============================================================

-- 1. Registrar las imágenes ya subidas en uploads/library/greenbags/.
INSERT INTO media_library (file_path, alt, title, mime, folder_id)
SELECT '/uploads/library/greenbags/eco-sustentable.jpg',
       'Compromiso ecológico y sustentable de GreenBags',
       'Eco sustentable GreenBags',
       'image/jpeg',
       (SELECT id FROM media_folders WHERE slug = 'marca' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM media_library WHERE file_path = '/uploads/library/greenbags/eco-sustentable.jpg'
);

INSERT INTO media_library (file_path, alt, title, mime, folder_id)
SELECT '/uploads/library/greenbags/horeca-alimentos.jpg',
       'Packaging para HORECA y locales gastronómicos',
       'Horeca alimentos GreenBags',
       'image/jpeg',
       (SELECT id FROM media_folders WHERE slug = 'marca' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM media_library WHERE file_path = '/uploads/library/greenbags/horeca-alimentos.jpg'
);

-- 2. Banner #2: sustentabilidad.
INSERT INTO banners (position, eyebrow, title, subtitle, image_id, cta_label, cta_url, text_align, sort_order, is_active)
SELECT 'home_hero',
       '100% compostable',
       'Reduce tu huella con cada pedido',
       'Materiales certificados y proveedores responsables, sin resignar calidad ni tiempos de entrega.',
       (SELECT id FROM media_library WHERE file_path = '/uploads/library/greenbags/eco-sustentable.jpg' LIMIT 1),
       'Ver catálogo',
       '/catalogo',
       'left',
       2,
       1
WHERE NOT EXISTS (SELECT 1 FROM banners WHERE title = 'Reduce tu huella con cada pedido');

-- 3. Banner #3: HORECA / retail.
INSERT INTO banners (position, eyebrow, title, subtitle, image_id, cta_label, cta_url, text_align, sort_order, is_active)
SELECT 'home_hero',
       'Para HORECA y retail',
       'Soluciones para tu local gastronómico',
       'Cajas, vasos, bolsas y cubiertos compostables pensados para el ritmo de restaurantes, cafés y delivery.',
       (SELECT id FROM media_library WHERE file_path = '/uploads/library/greenbags/horeca-alimentos.jpg' LIMIT 1),
       'Cotizar ahora',
       '/cotizacion',
       'left',
       3,
       1
WHERE NOT EXISTS (SELECT 1 FROM banners WHERE title = 'Soluciones para tu local gastronómico');
