-- ============================================================
-- CLIENTE: GreenBags - SEMILLA categoría Bolsas (tugou.cl).
-- Fuente: https://tugou.cl/product-category/envolver-y-llevar/bolsas/
-- Generado por tools/dump_catalog_seed.php tras importar la categoría 22.
-- 11 productos (Sacos Kraft + Bolsas asa troquel), PUBLICADOS, con imágenes.
-- Complementa la 041: la 041 los sembró como borrador y sin fotos (el API de
-- tugou las ocultaba entonces); esta corre después, los publica y les agrega
-- las imágenes reales (hoy sí expuestas). Categoría → 'bolsas' (existente).
-- Idempotente (claves naturales: sku/file_path/slug).
-- Requiere que los WebP en uploads/library/importados/ estén commiteados.
-- Al forkear el starter, borrar este archivo (catálogo específico del cliente).
-- ============================================================

INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-DC222815', NULL, NULL, 'Bolsa Kraft 22x28x15cm. Asa troquel Plast. (1×300)', 'bolsa-kraft-22x28x15cm-asa-troquel-plast-1x300', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-DC223615', NULL, NULL, 'Bolsa Kraft 22x36x15cm. Asa troquel Plast. (1×300)', 'bolsa-kraft-22x36x15cm-asa-troquel-plast-1x300', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-DC224115', NULL, NULL, 'Bolsa Kraft 22x41x15cm. Asa troquel Plast. (1×300)', 'bolsa-kraft-22x41x15cm-asa-troquel-plast-1x300', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-T100', NULL, NULL, 'Saco Kraft Café 1kg (1×1000)', 'saco-kraft-caf-e-1kg-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-T200', NULL, NULL, 'Saco Kraft Café 2kg (1×1000)', 'saco-kraft-caf-e-2kg-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-T300', NULL, NULL, 'Saco Kraft Café 3kg (1×1000)', 'saco-kraft-caf-e-3kg-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-T400', NULL, NULL, 'Saco Kraft Café 4kg (1×500)', 'saco-kraft-caf-e-4kg-1x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-T500', NULL, NULL, 'Saco Kraft Café 5kg (1×500)', 'saco-kraft-caf-e-5kg-1x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-T600', NULL, NULL, 'Saco Kraft Café 6kg (1×500)', 'saco-kraft-caf-e-6kg-1x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-T700', NULL, NULL, 'Saco Kraft Café 7kg (1×500)', 'saco-kraft-caf-e-7kg-1x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-T800', NULL, NULL, 'Saco Kraft Café 8kg (1×500)', 'saco-kraft-caf-e-8kg-1x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);

INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t100-1-afd38c.webp', '/uploads/library/importados/tg-cm-t100-1-afd38c-480.webp', '/uploads/library/importados/tg-cm-t100-1-afd38c-1024.webp', '/uploads/library/importados/tg-cm-t100-1-afd38c-480.webp', 'tg-cm-t100-1', 'image/webp', 584, 416, 15450, NULL, 9
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t100-1-afd38c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t700-1-6acab7.webp', '/uploads/library/importados/tg-cm-t700-1-6acab7-480.webp', '/uploads/library/importados/tg-cm-t700-1-6acab7-1024.webp', '/uploads/library/importados/tg-cm-t700-1-6acab7-480.webp', 'tg-cm-t700-1', 'image/webp', 584, 416, 14672, NULL, 10
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t700-1-6acab7.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t800-1-c44507.webp', '/uploads/library/importados/tg-cm-t800-1-c44507-480.webp', '/uploads/library/importados/tg-cm-t800-1-c44507-1024.webp', '/uploads/library/importados/tg-cm-t800-1-c44507-480.webp', 'tg-cm-t800-1', 'image/webp', 584, 416, 14672, NULL, 11
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t800-1-c44507.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t300-1-eb6a53.webp', '/uploads/library/importados/tg-cm-t300-1-eb6a53-480.webp', '/uploads/library/importados/tg-cm-t300-1-eb6a53-1024.webp', '/uploads/library/importados/tg-cm-t300-1-eb6a53-480.webp', 'tg-cm-t300-1', 'image/webp', 584, 416, 14672, NULL, 12
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t300-1-eb6a53.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t400-1-045c83.webp', '/uploads/library/importados/tg-cm-t400-1-045c83-480.webp', '/uploads/library/importados/tg-cm-t400-1-045c83-1024.webp', '/uploads/library/importados/tg-cm-t400-1-045c83-480.webp', 'tg-cm-t400-1', 'image/webp', 584, 416, 14672, NULL, 13
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t400-1-045c83.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t600-1-a68f6c.webp', '/uploads/library/importados/tg-cm-t600-1-a68f6c-480.webp', '/uploads/library/importados/tg-cm-t600-1-a68f6c-1024.webp', '/uploads/library/importados/tg-cm-t600-1-a68f6c-480.webp', 'tg-cm-t600-1', 'image/webp', 584, 416, 14672, NULL, 14
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t600-1-a68f6c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t200-1-92e0f6.webp', '/uploads/library/importados/tg-cm-t200-1-92e0f6-480.webp', '/uploads/library/importados/tg-cm-t200-1-92e0f6-1024.webp', '/uploads/library/importados/tg-cm-t200-1-92e0f6-480.webp', 'tg-cm-t200-1', 'image/webp', 584, 416, 14672, NULL, 15
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t200-1-92e0f6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t500-1-8d78db.webp', '/uploads/library/importados/tg-cm-t500-1-8d78db-480.webp', '/uploads/library/importados/tg-cm-t500-1-8d78db-1024.webp', '/uploads/library/importados/tg-cm-t500-1-8d78db-480.webp', 'tg-cm-t500-1', 'image/webp', 584, 416, 14672, NULL, 16
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t500-1-8d78db.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc224115-1-733d95.webp', '/uploads/library/importados/tg-cm-dc224115-1-733d95-480.webp', '/uploads/library/importados/tg-cm-dc224115-1-733d95-1024.webp', '/uploads/library/importados/tg-cm-dc224115-1-733d95-480.webp', 'tg-cm-dc224115-1', 'image/webp', 640, 640, 18772, NULL, 17
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc224115-1-733d95.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc224115-2-22c9e6.webp', '/uploads/library/importados/tg-cm-dc224115-2-22c9e6-480.webp', '/uploads/library/importados/tg-cm-dc224115-2-22c9e6-1024.webp', '/uploads/library/importados/tg-cm-dc224115-2-22c9e6-480.webp', 'tg-cm-dc224115-2', 'image/webp', 579, 522, 9230, NULL, 18
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc224115-2-22c9e6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc223615-1-f6ee3f.webp', '/uploads/library/importados/tg-cm-dc223615-1-f6ee3f-480.webp', '/uploads/library/importados/tg-cm-dc223615-1-f6ee3f-1024.webp', '/uploads/library/importados/tg-cm-dc223615-1-f6ee3f-480.webp', 'tg-cm-dc223615-1', 'image/webp', 640, 640, 18772, NULL, 19
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc223615-1-f6ee3f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc223615-2-74a838.webp', '/uploads/library/importados/tg-cm-dc223615-2-74a838-480.webp', '/uploads/library/importados/tg-cm-dc223615-2-74a838-1024.webp', '/uploads/library/importados/tg-cm-dc223615-2-74a838-480.webp', 'tg-cm-dc223615-2', 'image/webp', 579, 522, 9230, NULL, 20
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc223615-2-74a838.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc222815-1-292006.webp', '/uploads/library/importados/tg-cm-dc222815-1-292006-480.webp', '/uploads/library/importados/tg-cm-dc222815-1-292006-1024.webp', '/uploads/library/importados/tg-cm-dc222815-1-292006-480.webp', 'tg-cm-dc222815-1', 'image/webp', 640, 640, 18772, NULL, 21
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc222815-1-292006.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc222815-2-09bef6.webp', '/uploads/library/importados/tg-cm-dc222815-2-09bef6-480.webp', '/uploads/library/importados/tg-cm-dc222815-2-09bef6-1024.webp', '/uploads/library/importados/tg-cm-dc222815-2-09bef6-480.webp', 'tg-cm-dc222815-2', 'image/webp', 579, 522, 9230, NULL, 22
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc222815-2-09bef6.webp');

INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-DC222815' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-DC223615' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-DC224115' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-T100' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-T200' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-T300' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-T400' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-T500' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-T600' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-T700' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-T800' AND c.slug = 'bolsas';

INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC222815' AND m.file_path = '/uploads/library/importados/tg-cm-dc222815-1-292006.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC222815' AND m2.file_path = '/uploads/library/importados/tg-cm-dc222815-1-292006.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC222815' AND m.file_path = '/uploads/library/importados/tg-cm-dc222815-2-09bef6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC222815' AND m2.file_path = '/uploads/library/importados/tg-cm-dc222815-2-09bef6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC223615' AND m.file_path = '/uploads/library/importados/tg-cm-dc223615-1-f6ee3f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC223615' AND m2.file_path = '/uploads/library/importados/tg-cm-dc223615-1-f6ee3f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC223615' AND m.file_path = '/uploads/library/importados/tg-cm-dc223615-2-74a838.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC223615' AND m2.file_path = '/uploads/library/importados/tg-cm-dc223615-2-74a838.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC224115' AND m.file_path = '/uploads/library/importados/tg-cm-dc224115-1-733d95.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC224115' AND m2.file_path = '/uploads/library/importados/tg-cm-dc224115-1-733d95.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC224115' AND m.file_path = '/uploads/library/importados/tg-cm-dc224115-2-22c9e6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC224115' AND m2.file_path = '/uploads/library/importados/tg-cm-dc224115-2-22c9e6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T100' AND m.file_path = '/uploads/library/importados/tg-cm-t100-1-afd38c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T100' AND m2.file_path = '/uploads/library/importados/tg-cm-t100-1-afd38c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T200' AND m.file_path = '/uploads/library/importados/tg-cm-t200-1-92e0f6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T200' AND m2.file_path = '/uploads/library/importados/tg-cm-t200-1-92e0f6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T300' AND m.file_path = '/uploads/library/importados/tg-cm-t300-1-eb6a53.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T300' AND m2.file_path = '/uploads/library/importados/tg-cm-t300-1-eb6a53.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T400' AND m.file_path = '/uploads/library/importados/tg-cm-t400-1-045c83.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T400' AND m2.file_path = '/uploads/library/importados/tg-cm-t400-1-045c83.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T500' AND m.file_path = '/uploads/library/importados/tg-cm-t500-1-8d78db.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T500' AND m2.file_path = '/uploads/library/importados/tg-cm-t500-1-8d78db.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T600' AND m.file_path = '/uploads/library/importados/tg-cm-t600-1-a68f6c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T600' AND m2.file_path = '/uploads/library/importados/tg-cm-t600-1-a68f6c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T700' AND m.file_path = '/uploads/library/importados/tg-cm-t700-1-6acab7.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T700' AND m2.file_path = '/uploads/library/importados/tg-cm-t700-1-6acab7.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T800' AND m.file_path = '/uploads/library/importados/tg-cm-t800-1-c44507.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T800' AND m2.file_path = '/uploads/library/importados/tg-cm-t800-1-c44507.webp');
