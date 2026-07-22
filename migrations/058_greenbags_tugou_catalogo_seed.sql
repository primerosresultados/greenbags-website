-- ============================================================
-- CLIENTE: GreenBags — SEMILLA catálogo tugou (selección Excel del cliente).
-- Fuente: /Users/.../Downloads/productos_tugou.xlsx (163 productos curados).
-- Importados vía tools/scrape_tugou.php + import_catalog.php (publish-all).
--   · 163 productos PUBLICADOS, con imágenes WebP reales y 1 categoría c/u.
--   · price=0 (tugou oculta precios); la tienda corre en modo cotización.
--   · Categorización por clasificador (lib/import_remote.php):
--       Packaging Desechable 86 · Cartón 31 · Film y Aluminio 13
--       Bolsas 10 · Packaging Ecológico 10 · Aseo y Limpieza 9 · Madera 4
-- Idempotente (claves naturales: sku/file_path/slug). Complementa la 041:
-- estos SKUs estaban como borrador sin fotos; acá quedan publicados y con foto.
-- Requiere los WebP en uploads/library/importados/ commiteados.
-- Al forkear el starter, borrar este archivo (catálogo específico del cliente).
-- ============================================================

INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CIP-CF28300', NULL, NULL, 'Cling Film PVC 28cm x 300m – Caja cortadora (1×6)', 'cling-film-pvc-28cm-x-300m-caja-cortadora-1x6', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-DC222815', NULL, NULL, 'Bolsa Kraft 22x28x15cm. Asa troquel Plast. (1×300)', 'bolsa-kraft-22x28x15cm-asa-troquel-plast-1x300', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-DC223615', NULL, NULL, 'Bolsa Kraft 22x36x15cm. Asa troquel Plast. (1×300)', 'bolsa-kraft-22x36x15cm-asa-troquel-plast-1x300', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-DC224115', NULL, NULL, 'Bolsa Kraft 22x41x15cm. Asa troquel Plast. (1×300)', 'bolsa-kraft-22x41x15cm-asa-troquel-plast-1x300', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-CM-RBP35X50', NULL, NULL, 'Bolsa pull pack 35×50 (4×700)', 'bolsa-pull-pack-35x50-4x700', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
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
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-FB-SE23X23-TG', NULL, NULL, 'Servilleta 23×23 Imp Tugou (30×200)', 'servilleta-23x23-imp-tugou-30x200', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-FB-SE30X30-TG', NULL, NULL, 'Servilleta 30×30 Imp Tugou (24×200)', 'servilleta-30x30-imp-tugou-24x200', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GH-GWT009TU', NULL, NULL, 'Mug 12oz de viaje, Imp. Re-Utiliza (1×25)', 'mug-12oz-de-viaje-imp-re-utiliza-1x25', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GO-P105W', NULL, NULL, 'Plato 18cm Ø Blanco (20×50)', 'plato-18cm-o-blanco-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GO-P106W', NULL, NULL, 'Plato 22cm Ø Blanco (10×50)', 'plato-22cm-o-blanco-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GO-P108W', NULL, NULL, 'Plato 3Div. 22cm Ø Blanco (10×50)', 'plato-3div-22cm-o-blanco-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GO-P109W', NULL, NULL, 'Plato 26cm Ø Blanco (10×50)', 'plato-26cm-o-blanco-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GO-P110W', NULL, NULL, 'Plato 3Div. 26cm Ø Blanco (10×50)', 'plato-3div-26cm-o-blanco-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GT-P005', NULL, NULL, 'Plato 26 cms. Bagasse (10×50)', 'plato-26-cms-bagasse-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GT-P007', NULL, NULL, 'Plato 26 cms. 3div. Bagasse (10×50)', 'plato-26-cms-3div-bagasse-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GT-P011', NULL, NULL, 'Plato 18 cms. Bagasse (20×50)', 'plato-18-cms-bagasse-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GT-P012', NULL, NULL, 'Plato 23 cms. 3div. Bagasse (10×50)', 'plato-23-cms-3div-bagasse-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-GT-P013', NULL, NULL, 'Plato 23 cms. Bagasse (10×50)', 'plato-23-cms-bagasse-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-HL-LBG08', NULL, NULL, 'Tapa 8oz Bagasse (20×50)', 'tapa-8oz-bagasse-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-HL-LBG1220', NULL, NULL, 'Tapa 12oz-20oz Bagasse (20×50)', 'tapa-12oz-20oz-bagasse-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-HL-SBPLAFK1000-G', NULL, NULL, 'Bowl 1000cc Papel PLA Kraft Imp. Generico (6×50)', 'bowl-1000cc-papel-pla-kraft-imp-generico-6x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-HL-WBLSTFW08', NULL, NULL, 'Tapa blanca 8oz Papel WBased apilable (20×50)', 'tapa-blanca-8oz-papel-wbased-apilable-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-HL-WBLSTFW1220', NULL, NULL, 'Tapa blanca 10-20oz Papel WBased apilable (20×50)', 'tapa-blanca-10-20oz-papel-wbased-apilable-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IC-INT10000035E', NULL, NULL, 'Papel Duofresh Especial 30×37 cm. Imp. Black (7×400)', 'papel-duofresh-especial-30x37-cm-imp-black-7x400', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IC-INT10000036E', NULL, NULL, 'Papel Duofresh Especial 30×37 cm. Imp. Street (7×400)', 'papel-duofresh-especial-30x37-cm-imp-street-7x400', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IC-INT10000037E', NULL, NULL, 'Papel Duofresh Especial 30×37 cm. Imp. Splash (7×400)', 'papel-duofresh-especial-30x37-cm-imp-splash-7x400', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IC-INT50000', NULL, NULL, 'Papel Duofresh Premiun Blanco 20x20cm. Imp. Tugou (1×1000)', 'papel-duofresh-premiun-blanco-20x20cm-imp-tugou-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IC-INT50006', NULL, NULL, 'Papel Duofresh Especial Blanco 33x44cm. (1×1000)', 'papel-duofresh-especial-blanco-33x44cm-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IC-PMB10001', NULL, NULL, 'Papel Duofresh Metalizado 33x37cm Imp. Cuadrille Negro (1×1000)', 'papel-duofresh-metalizado-33x37cm-imp-cuadrille-negro-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IC-PMB7000251E', NULL, NULL, 'Papel Duofresh Metalizado 33x37cm Imp. Street (1×1000)', 'papel-duofresh-metalizado-33x37cm-imp-street-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IC-PMB7000252E', NULL, NULL, 'Papel Duofresh Metalizado 33x37cm Imp. Splash (1×1000)', 'papel-duofresh-metalizado-33x37cm-imp-splash-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IC-PMB7000253E', NULL, NULL, 'Papel Duofresh Metalizado 33x37cm Imp. Black (1×1000)', 'papel-duofresh-metalizado-33x37cm-imp-black-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-INR-VREC12', NULL, NULL, 'Vaso Recto 12oz PP Natural (1×100)', 'vaso-recto-12oz-pp-natural-1x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BBTK001', NULL, NULL, 'Bandeja #1 tipo Canoa Kraft PE 4oz (4×250)', 'bandeja-1-tipo-canoa-kraft-pe-4oz-4x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BBTK002', NULL, NULL, 'Bandeja #2 tipo Canoa Kraft PE 6oz (4×250)', 'bandeja-2-tipo-canoa-kraft-pe-6oz-4x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BBTK003', NULL, NULL, 'Bandeja #3 tipo Canoa Kraft PE 10oz (4×250)', 'bandeja-3-tipo-canoa-kraft-pe-10oz-4x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BBTK004', NULL, NULL, 'Bandeja #4 tipo Canoa Kraft PE 13oz (4×250)', 'bandeja-4-tipo-canoa-kraft-pe-13oz-4x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BBTK005', NULL, NULL, 'Bandeja #5 tipo Canoa Kraft PE 23oz (4×250)', 'bandeja-5-tipo-canoa-kraft-pe-23oz-4x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BBTK006', NULL, NULL, 'Bandeja #6 tipo Canoa Kraft PE 32oz (4×250)', 'bandeja-6-tipo-canoa-kraft-pe-32oz-4x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BU170-PC', NULL, NULL, 'Balde polipapel 170oz Imp. Pop Corn (4×30)', 'balde-polipapel-170oz-imp-pop-corn-4x30', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BU24-PC', NULL, NULL, 'Balde polipapel 24oz Imp. Pop Corn (10×50)', 'balde-polipapel-24oz-imp-pop-corn-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BU32-PC', NULL, NULL, 'Balde polipapel 32oz Imp. Pop Corn (10×50)', 'balde-polipapel-32oz-imp-pop-corn-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BU46-PC', NULL, NULL, 'Balde polipapel 46oz Imp. Pop Corn (10×50)', 'balde-polipapel-46oz-imp-pop-corn-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BU70W', NULL, NULL, 'Balde polipapel 70oz Blanco (6×50)', 'balde-polipapel-70oz-blanco-6x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-BU85-PC', NULL, NULL, 'Balde polipapel 85oz Imp. Pop Corn (6×50)', 'balde-polipapel-85oz-imp-pop-corn-6x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-CR1200K', NULL, NULL, 'Caja bisagra 1200ml Kraft (4×50)', 'caja-bisagra-1200ml-kraft-4x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-CR1600K', NULL, NULL, 'Caja bisagra 1600ml Kraft (4×50)', 'caja-bisagra-1600ml-kraft-4x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-CR2100K', NULL, NULL, 'Caja bisagra 2100ml Kraft (4×50)', 'caja-bisagra-2100ml-kraft-4x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-CR500K', NULL, NULL, 'Caja bisagra 500ml Kraft (4×50)', 'caja-bisagra-500ml-kraft-4x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-CR700K', NULL, NULL, 'Caja bisagra 700ml Kraft (4×50)', 'caja-bisagra-700ml-kraft-4x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-CR900K', NULL, NULL, 'Caja bisagra 900ml Kraft (4×50)', 'caja-bisagra-900ml-kraft-4x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-CRV1200K', NULL, NULL, 'Caja c/ventana 1200ml Kraft (4×50)', 'caja-c-ventana-1200ml-kraft-4x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-CRV1600K', NULL, NULL, 'Caja c/ventana 1600ml Kraft (4×50)', 'caja-c-ventana-1600ml-kraft-4x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-CRV2100K', NULL, NULL, 'Caja c/ventana 2100ml Kraft (4×50)', 'caja-c-ventana-2100ml-kraft-4x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-LSDPET1024', NULL, NULL, 'Tapa 10-24oz PET c/ranura (20×50)', 'tapa-10-24oz-pet-c-ranura-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PCS05', NULL, NULL, 'Pocillo Traslúcido 0.5oz (1×2500)', 'pocillo-trasl-ucido-0-5oz-1x2500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PCS075', NULL, NULL, 'Pocillo Traslúcido 0.75oz (1×2500)', 'pocillo-trasl-ucido-0-75oz-1x2500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PCS10', NULL, NULL, 'Pocillo Traslúcido 1oz (1×2.500)', 'pocillo-trasl-ucido-1oz-1x2-500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PCS15', NULL, NULL, 'Pocillo Traslúcido 1,5oz (1×2500)', 'pocillo-trasl-ucido-1-5oz-1x2500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PCS20', NULL, NULL, 'Pocillo Traslúcido 2oz (1×2500)', 'pocillo-trasl-ucido-2oz-1x2500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PCS20B', NULL, NULL, 'Pocillo Negro 2oz (1×2500)', 'pocillo-negro-2oz-1x2500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PCS25', NULL, NULL, 'Pocillo Traslucido 2.5oz (1×2500)', 'pocillo-traslucido-2-5oz-1x2500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PCS325', NULL, NULL, 'Pocillo Traslúcido 3,25oz (1×2500)', 'pocillo-trasl-ucido-3-25oz-1x2500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PCS325B', NULL, NULL, 'Pocillo Negro 3,25oz (1×2500)', 'pocillo-negro-3-25oz-1x2500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PPC10T', NULL, NULL, 'Salsero 1oz de Papel Antigrasa (20×250)', 'salsero-1oz-de-papel-antigrasa-20x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PZBOXCH', NULL, NULL, 'Caja chica p/ Pizza 25x25x4cm (1×100)', 'caja-chica-p-pizza-25x25x4cm-1x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PZBOXGD', NULL, NULL, 'Caja grande p/ Pizza 38x38x4cm (1×100)', 'caja-grande-p-pizza-38x38x4cm-1x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-PZBOXMD', NULL, NULL, 'Caja mediana p/ Pizza 32x32x4cm (1×100)', 'caja-mediana-p-pizza-32x32x4cm-1x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-RBP16SSK', NULL, NULL, 'Envase Kraft 16oz p/llevar (10×50)', 'envase-kraft-16oz-p-llevar-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-RBP26SSK', NULL, NULL, 'Envase Kraft 26oz p/llevar (10×50)', 'envase-kraft-26oz-p-llevar-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-RBP32SSK', NULL, NULL, 'Envase Kraft 32oz p/llevar (10×50)', 'envase-kraft-32oz-p-llevar-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-SL08', NULL, NULL, 'Cubrevaso 8oz Kraft (20×50)', 'cubrevaso-8oz-kraft-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-SL12/16', NULL, NULL, 'Cubrevaso 12/16oz Kraft (20×50)', 'cubrevaso-12-16oz-kraft-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-ST6197B', NULL, NULL, 'Bombilla negra 6mm x 19,7 – 3capas (10×500)', 'bombilla-negra-6mm-x-19-7-3capas-10x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-ST6197W', NULL, NULL, 'Bombilla blanca 6mm x 19,7 – 3capas (10×500)', 'bombilla-blanca-6mm-x-19-7-3capas-10x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-ST8254B', NULL, NULL, 'Bombilla negra 8mm x 25,4 – 3capas (8×500)', 'bombilla-negra-8mm-x-25-4-3capas-8x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-ST8254W', NULL, NULL, 'Bombilla blanca 8mm x 25,4 – 3capas (8×500)', 'bombilla-blanca-8mm-x-25-4-3capas-8x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-WST6197B', NULL, NULL, 'Bombilla negra 6mm x 19,7 – 3capas Envuelta (10×500)', 'bombilla-negra-6mm-x-19-7-3capas-envuelta-10x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-WST6197W', NULL, NULL, 'Bombilla blanca 6mm x 19,7 – 3capas Envuelta (10×500)', 'bombilla-blanca-6mm-x-19-7-3capas-envuelta-10x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-WST8254B', NULL, NULL, 'Bombilla negra 8mm x 25,4 – 3capas Envuelta (8×500)', 'bombilla-negra-8mm-x-25-4-3capas-envuelta-8x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-IY-WST8254W', NULL, NULL, 'Bombilla blanca 8mm x 25,4 – 3capas Envuelta (8×500)', 'bombilla-blanca-8mm-x-25-4-3capas-envuelta-8x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-AL300100', NULL, NULL, 'Rollo de Aluminio 30cm x 100m (1×6)', 'rollo-de-aluminio-30cm-x-100m-1x6', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-C10NCL', NULL, NULL, 'Bandeja Alum. 500ml c/Tapa PP (50×20)', 'bandeja-alum-500ml-c-tapa-pp-50x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-C10NT', NULL, NULL, 'Bandeja Alum. 500ml c/Tapa Cart-Alum. (50×20)', 'bandeja-alum-500ml-c-tapa-cart-alum-50x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-C18NCL', NULL, NULL, 'Bandeja Alum. 600ml c/Tapa PP (30×20)', 'bandeja-alum-600ml-c-tapa-pp-30x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-C18NT', NULL, NULL, 'Bandeja Alum. 600ml c/Tapa Cart-Alum. (30×20)', 'bandeja-alum-600ml-c-tapa-cart-alum-30x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-C30NCL', NULL, NULL, 'Bandeja Alum. 1100ml c/Tapa PP (30×20)', 'bandeja-alum-1100ml-c-tapa-pp-30x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-C30NT', NULL, NULL, 'Bandeja Alum. 1100ml c/Tapa Cart-Alum.  (30×20)', 'bandeja-alum-1100ml-c-tapa-cart-alum-30x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-C40NCL', NULL, NULL, 'Bandeja Alum. 2000ml c/Tapa PP (20×20)', 'bandeja-alum-2000ml-c-tapa-pp-20x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-C40NT', NULL, NULL, 'Bandeja Alum. 2000ml c/Tapa Cart-Alum. (20×20)', 'bandeja-alum-2000ml-c-tapa-cart-alum-20x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-C5NT', NULL, NULL, 'Bandeja Alum. 250ml c/Tapa Cart-Alum. (50×20)', 'bandeja-alum-250ml-c-tapa-cart-alum-50x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-LY-Y465', NULL, NULL, 'Pavera de Aluminio 7,0L, top465x350x70mm alt. (1×50)', 'pavera-de-aluminio-7-0l-top465x350x70mm-alt-1x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-ND-CS1R-TG', NULL, NULL, 'Caja Sushi 1 Roll Imp. Eco-Tugou (1×250)', 'caja-sushi-1-roll-imp-eco-tugou-1x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-ND-CS2R-TG', NULL, NULL, 'Caja Sushi 2 Rolls Imp. Eco-Tugou(1×250)', 'caja-sushi-2-rolls-imp-eco-tugou-1x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-ND-CS3R-TG', NULL, NULL, 'Caja Sushi 3 Rolls Imp. Eco-Tugou (1×250)', 'caja-sushi-3-rolls-imp-eco-tugou-1x250', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-SN-PETCI98', NULL, NULL, 'Inserto 98mm Ø 5oz PET p/vaso 16-24oz (10×100)', 'inserto-98mm-o-5oz-pet-p-vaso-16-24oz-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-SN-PETPCI4', NULL, NULL, 'Inserto 92mm Ø 4oz PET p/vaso 12/20oz (10×100)', 'inserto-92mm-o-4oz-pet-p-vaso-12-20oz-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-SN-PLACI4', NULL, NULL, 'Inserto 92mm Ø 4oz PLA p/vaso 12/20oz (10×100)', 'inserto-92mm-o-4oz-pla-p-vaso-12-20oz-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-SN-PLACI98', NULL, NULL, 'Inserto 98mm Ø PLA p/vaso 16-24oz (10×100)', 'inserto-98mm-o-pla-p-vaso-16-24oz-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-SW-LSRC26', NULL, NULL, 'Tapa PET p/contenedor 26oz (8×45)', 'tapa-pet-p-contenedor-26oz-8x45', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-SW-LSRC40', NULL, NULL, 'Tapa PET p/contenedor 40oz (8×45)', 'tapa-pet-p-contenedor-40oz-8x45', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-SW-SB26S', NULL, NULL, 'Contenedor Kraft 26oz (8×45)', 'contenedor-kraft-26oz-8x45', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-SW-SB40S', NULL, NULL, 'Contenedor Kraft 40oz (8×45)', 'contenedor-kraft-40oz-8x45', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-10857', NULL, NULL, '20 oz. Sho bowl c/tapa domo (1X150)', '20-oz-sho-bowl-c-tapa-domo-1x150', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-10865', NULL, NULL, '32 oz. Sho bowl c/tapa domo (1X150)', '32-oz-sho-bowl-c-tapa-domo-1x150', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-8000', NULL, NULL, 'Tapa p/plato oval Tugou (2×150)', 'tapa-p-plato-oval-tugou-2x150', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-8010', NULL, NULL, 'Plato oval transparente s/div. (2×150)', 'plato-oval-transparente-s-div-2x150', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-8010N', NULL, NULL, 'Plato oval negro s/div. (2×150)', 'plato-oval-negro-s-div-2x150', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-8012', NULL, NULL, 'Plato oval transparente con div. (2×150)', 'plato-oval-transparente-con-div-2x150', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-8012N', NULL, NULL, 'Plato oval negro con div. (2×150)', 'plato-oval-negro-con-div-2x150', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-CE47100', NULL, NULL, 'Cinta de Embalaje 47mm x 100mts (1×36)', 'cinta-de-embalaje-47mm-x-100mts-1x36', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-CE75100', NULL, NULL, 'Cinta de Embalaje 75mm x 100mts (1×36)', 'cinta-de-embalaje-75mm-x-100mts-1x36', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-CG6510', NULL, NULL, 'Copa Gelatera 200cc (16X100)', 'copa-gelatera-200cc-16x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-CT08', NULL, NULL, 'Copa 8oz PS Base/Tapa (20juegos x 25)', 'copa-8oz-ps-base-tapa-20juegos-x-25', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-CT12', NULL, NULL, 'Copa 12oz PS Base/Tapa (20juegos x 25)', 'copa-12oz-ps-base-tapa-20juegos-x-25', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-DCR160B', NULL, NULL, 'Base p/ Postre PS Redonda 160ml (45×16)', 'base-p-postre-ps-redonda-160ml-45x16', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-DCR60B', NULL, NULL, 'Base p/ Postre PS Redonda 60ml (69×20)', 'base-p-postre-ps-redonda-60ml-69x20', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-DCS110BC', NULL, NULL, 'Base/Tapa p/ Postre PS cuadrado 110ml (50×10)', 'base-tapa-p-postre-ps-cuadrado-110ml-50x10', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-DCS220BC', NULL, NULL, 'Base/Tapa p/ Postre PS cuadrado 220ml (32×10)', 'base-tapa-p-postre-ps-cuadrado-220ml-32x10', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-DCT180BC', NULL, NULL, 'Base/Tapa p/ Postre PS Triang. 180ml (28×10)', 'base-tapa-p-postre-ps-triang-180ml-28x10', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-DCT80BC', NULL, NULL, 'Base/Tapa p/ Postre PS Triang. 80ml (45×12)', 'base-tapa-p-postre-ps-triang-80ml-45x12', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-FC04', NULL, NULL, 'Pote Polipapel 4oz Blanco (20×50)', 'pote-polipapel-4oz-blanco-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-FC045', NULL, NULL, 'Pote Polipapel 4.5oz Blanco (20×50)', 'pote-polipapel-4-5oz-blanco-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-FPA15', NULL, NULL, 'Film Paletizador Automatico 15kg. (1u)', 'film-paletizador-automatico-15kg-1u', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-FPM2', NULL, NULL, 'Film Paletizador manual 2kg (1×6)', 'film-paletizador-manual-2kg-1x6', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-FPM217', NULL, NULL, 'Film Paletizador manual (1×6)', 'film-paletizador-manual-1x6', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-FPM2N', NULL, NULL, 'Film Paletizador manual Negro 2kg (1×6)', 'film-paletizador-manual-negro-2kg-1x6', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-FPM2R', NULL, NULL, 'Film Paletizador manual Rojo 2kg (1×6)', 'film-paletizador-manual-rojo-2kg-1x6', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-FPMPER2', NULL, NULL, 'Film Paletizador Manual Perforado 500mm x 25micras x 180mt (1×6)', 'film-paletizador-manual-perforado-500mm-x-25micras-x-180mt-1x6', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-GC001', NULL, NULL, 'Gorro Clip de 20″ Blanco (10×100)', 'gorro-clip-de-20-blanco-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-GPE10000', NULL, NULL, 'Guante Polietileno (10x10x100)', 'guante-polietileno-10x10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-GVF001', NULL, NULL, 'Guante Vinilo s/polvo “S” (10×100)', 'guante-vinilo-s-polvo-s-10-100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-GVF002', NULL, NULL, 'Guante Vinilo s/polvo “M” (10×100)', 'guante-vinilo-s-polvo-m-10-100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-GVF003', NULL, NULL, 'Guante Vinilo s/polvo “L” (10×100)', 'guante-vinilo-s-polvo-l-10-100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-M003', NULL, NULL, 'Mascarilla 3 Pliegues C/Filtro (40×50)', 'mascarilla-3-pliegues-c-filtro-40x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-PB26PP3D', NULL, NULL, 'Plato blanco PP 26cm 3div. (10×50)', 'plato-blanco-pp-26cm-3div-10x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-PE001', NULL, NULL, 'Pechera De 28″x46″ (10×100)', 'pechera-de-28-x46-10-100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-PVFE301400', NULL, NULL, 'Film PVC p/Alimentos 30cm x 1.400mts. (1 rollo)', 'film-pvc-p-alimentos-30cm-x-1-400mts-1-rollo', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-PVFE381400', NULL, NULL, 'Film PVC p/Alimentos 38cm x 1.400mts. (1 rollo)', 'film-pvc-p-alimentos-38cm-x-1-400mts-1-rollo', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-PVFE451400', NULL, NULL, 'Film PVC p/Alimentos 45cm x 1.400mts. (1 rollo)', 'film-pvc-p-alimentos-45cm-x-1-400mts-1-rollo', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-R001', NULL, NULL, 'Redecilla Negra (10×100)', 'redecilla-negra-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-SC001', NULL, NULL, 'Cubrezapato azul antideslizante (10×100)', 'cubrezapato-azul-antideslizante-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-SEL1414', NULL, NULL, 'Servilleta lunch (20x500u)', 'servilleta-lunch-20x500u', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-SL08/10', NULL, NULL, 'Cubrevaso 8/10oz Kraft (10×100)', 'cubrevaso-8-10oz-kraft-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-SL12/20', NULL, NULL, 'Cubrevaso 12/20oz Kraft (1×1000)', 'cubrevaso-12-20oz-kraft-1x1000', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-SO16R', NULL, NULL, 'Vaso PS 16oz Rojo int. Blanco (20×50)', 'vaso-ps-16oz-rojo-int-blanco-20x50', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-TG-TCG10', NULL, NULL, 'Tapa p/ Copa Gelatera 200cc (100×16)', 'tapa-p-copa-gelatera-200cc-100x16', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-BS20025', NULL, NULL, 'Brocheta de Bamboo 250×2,5mm (100×200)', 'brocheta-de-bamboo-250x2-5mm-100x200', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-F160B', NULL, NULL, 'Tenedor de madera 16cm (10×100)', 'tenedor-de-madera-16cm-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-IS1110', NULL, NULL, 'Cuchara de Té/postre 11×2.4 (20×100)', 'cuchara-de-t-e-postre-11x2-4-20-100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-IS70A', NULL, NULL, 'Cuchara de helado 7cm (200x50u)', 'cuchara-de-helado-7cm-200x50u', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-K160B', NULL, NULL, 'Cuchillo de madera 16cm (10×100)', 'cuchillo-de-madera-16cm-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-S160B', NULL, NULL, 'Cuchara de madera 16cm (10×100)', 'cuchara-de-madera-16cm-10x100', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-WSET5', NULL, NULL, 'Kit Ten+Cuchi embolsado Kraft (1×500)', 'kit-ten-cuchi-embolsado-kraft-1x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-WSET5N', NULL, NULL, 'Kit Ten+Cuchi+Serv embolsado Kraft (1×500)', 'kit-ten-cuchi-serv-embolsado-kraft-1x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-WSET6', NULL, NULL, 'Kit Ten+Cuchi+Cucha embolsado Kraft (1×500)', 'kit-ten-cuchi-cucha-embolsado-kraft-1x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);
INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand, item_condition, google_category, status, price, sale_price, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status, weight, featured, meta_title, meta_description) VALUES ('simple', 'TG-YS-WSET6N', NULL, NULL, 'Kit Ten+Cuchi+Cucha+Serv embolsado Kraft (1×500)', 'kit-ten-cuchi-cucha-serv-embolsado-kraft-1x500', NULL, '', NULL, 'new', NULL, 'published', 0, NULL, 0, 0, 0, 1, 0, 'in_stock', NULL, 0, NULL, NULL)
  ON DUPLICATE KEY UPDATE type=VALUES(type), gtin=VALUES(gtin), mpn=VALUES(mpn), name=VALUES(name), slug=VALUES(slug), short_description=VALUES(short_description), description=VALUES(description), brand=VALUES(brand), item_condition=VALUES(item_condition), google_category=VALUES(google_category), status=VALUES(status), price=VALUES(price), sale_price=VALUES(sale_price), min_price=VALUES(min_price), max_price=VALUES(max_price), manage_stock=VALUES(manage_stock), min_order_qty=VALUES(min_order_qty), stock_qty=VALUES(stock_qty), stock_status=VALUES(stock_status), weight=VALUES(weight), featured=VALUES(featured), meta_title=VALUES(meta_title), meta_description=VALUES(meta_description);

INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-gc001-1-0e9edf.webp', '/uploads/library/importados/tg-tg-gc001-1-0e9edf-480.webp', '/uploads/library/importados/tg-tg-gc001-1-0e9edf-1024.webp', '/uploads/library/importados/tg-tg-gc001-1-0e9edf-480.webp', 'tg-tg-gc001-1', 'image/webp', 869, 720, 15406, NULL, 1
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-gc001-1-0e9edf.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-gc001-2-6d234c.webp', '/uploads/library/importados/tg-tg-gc001-2-6d234c-480.webp', '/uploads/library/importados/tg-tg-gc001-2-6d234c-1024.webp', '/uploads/library/importados/tg-tg-gc001-2-6d234c-480.webp', 'tg-tg-gc001-2', 'image/webp', 555, 610, 8142, NULL, 2
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-gc001-2-6d234c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-r001-1-02b601.webp', '/uploads/library/importados/tg-tg-r001-1-02b601-480.webp', '/uploads/library/importados/tg-tg-r001-1-02b601-1024.webp', '/uploads/library/importados/tg-tg-r001-1-02b601-480.webp', 'tg-tg-r001-1', 'image/webp', 536, 536, 21686, NULL, 3
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-r001-1-02b601.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-gpe10000-1-2a829a.webp', '/uploads/library/importados/tg-tg-gpe10000-1-2a829a-480.webp', '/uploads/library/importados/tg-tg-gpe10000-1-2a829a-1024.webp', '/uploads/library/importados/tg-tg-gpe10000-1-2a829a-480.webp', 'tg-tg-gpe10000-1', 'image/webp', 334, 370, 7468, NULL, 4
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-gpe10000-1-2a829a.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-gvf003-1-1460df.webp', '/uploads/library/importados/tg-tg-gvf003-1-1460df-480.webp', '/uploads/library/importados/tg-tg-gvf003-1-1460df-1024.webp', '/uploads/library/importados/tg-tg-gvf003-1-1460df-480.webp', 'tg-tg-gvf003-1', 'image/webp', 577, 433, 16628, NULL, 5
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-gvf003-1-1460df.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-gvf002-1-f4e799.webp', '/uploads/library/importados/tg-tg-gvf002-1-f4e799-480.webp', '/uploads/library/importados/tg-tg-gvf002-1-f4e799-1024.webp', '/uploads/library/importados/tg-tg-gvf002-1-f4e799-480.webp', 'tg-tg-gvf002-1', 'image/webp', 577, 433, 16628, NULL, 6
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-gvf002-1-f4e799.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-gvf001-1-e6f2df.webp', '/uploads/library/importados/tg-tg-gvf001-1-e6f2df-480.webp', '/uploads/library/importados/tg-tg-gvf001-1-e6f2df-1024.webp', '/uploads/library/importados/tg-tg-gvf001-1-e6f2df-480.webp', 'tg-tg-gvf001-1', 'image/webp', 577, 433, 16628, NULL, 7
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-gvf001-1-e6f2df.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pe001-1-3c025b.webp', '/uploads/library/importados/tg-tg-pe001-1-3c025b-480.webp', '/uploads/library/importados/tg-tg-pe001-1-3c025b-1024.webp', '/uploads/library/importados/tg-tg-pe001-1-3c025b-480.webp', 'tg-tg-pe001-1', 'image/webp', 345, 388, 4588, NULL, 8
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pe001-1-3c025b.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pe001-2-71761e.webp', '/uploads/library/importados/tg-tg-pe001-2-71761e-480.webp', '/uploads/library/importados/tg-tg-pe001-2-71761e-1024.webp', '/uploads/library/importados/tg-tg-pe001-2-71761e-480.webp', 'tg-tg-pe001-2', 'image/webp', 304, 379, 6286, NULL, 9
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pe001-2-71761e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-m003-1-9142cd.webp', '/uploads/library/importados/tg-tg-m003-1-9142cd-480.webp', '/uploads/library/importados/tg-tg-m003-1-9142cd-1024.webp', '/uploads/library/importados/tg-tg-m003-1-9142cd-480.webp', 'tg-tg-m003-1', 'image/webp', 864, 864, 8524, NULL, 10
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-m003-1-9142cd.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-m003-2-89fc08.webp', '/uploads/library/importados/tg-tg-m003-2-89fc08-480.webp', '/uploads/library/importados/tg-tg-m003-2-89fc08-1024.webp', '/uploads/library/importados/tg-tg-m003-2-89fc08-480.webp', 'tg-tg-m003-2', 'image/webp', 864, 864, 15528, NULL, 11
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-m003-2-89fc08.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-sc001-1-ec7fb3.webp', '/uploads/library/importados/tg-tg-sc001-1-ec7fb3-480.webp', '/uploads/library/importados/tg-tg-sc001-1-ec7fb3-1024.webp', '/uploads/library/importados/tg-tg-sc001-1-ec7fb3-480.webp', 'tg-tg-sc001-1', 'image/webp', 1000, 1000, 51046, NULL, 12
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-sc001-1-ec7fb3.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu170-pc-1-418496.webp', '/uploads/library/importados/tg-iy-bu170-pc-1-418496-480.webp', '/uploads/library/importados/tg-iy-bu170-pc-1-418496-1024.webp', '/uploads/library/importados/tg-iy-bu170-pc-1-418496-480.webp', 'tg-iy-bu170-pc-1', 'image/webp', 719, 721, 30048, NULL, 13
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu170-pc-1-418496.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu170-pc-2-b7b5f6.webp', '/uploads/library/importados/tg-iy-bu170-pc-2-b7b5f6-480.webp', '/uploads/library/importados/tg-iy-bu170-pc-2-b7b5f6-1024.webp', '/uploads/library/importados/tg-iy-bu170-pc-2-b7b5f6-480.webp', 'tg-iy-bu170-pc-2', 'image/webp', 1313, 568, 41448, NULL, 14
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu170-pc-2-b7b5f6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu24-pc-1-c21cd7.webp', '/uploads/library/importados/tg-iy-bu24-pc-1-c21cd7-480.webp', '/uploads/library/importados/tg-iy-bu24-pc-1-c21cd7-1024.webp', '/uploads/library/importados/tg-iy-bu24-pc-1-c21cd7-480.webp', 'tg-iy-bu24-pc-1', 'image/webp', 554, 474, 7676, NULL, 15
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu24-pc-1-c21cd7.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu24-pc-2-2a8487.webp', '/uploads/library/importados/tg-iy-bu24-pc-2-2a8487-480.webp', '/uploads/library/importados/tg-iy-bu24-pc-2-2a8487-1024.webp', '/uploads/library/importados/tg-iy-bu24-pc-2-2a8487-480.webp', 'tg-iy-bu24-pc-2', 'image/webp', 1313, 568, 41448, NULL, 16
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu24-pc-2-2a8487.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu32-pc-1-5cb490.webp', '/uploads/library/importados/tg-iy-bu32-pc-1-5cb490-480.webp', '/uploads/library/importados/tg-iy-bu32-pc-1-5cb490-1024.webp', '/uploads/library/importados/tg-iy-bu32-pc-1-5cb490-480.webp', 'tg-iy-bu32-pc-1', 'image/webp', 544, 606, 7952, NULL, 17
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu32-pc-1-5cb490.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu32-pc-2-f8c089.webp', '/uploads/library/importados/tg-iy-bu32-pc-2-f8c089-480.webp', '/uploads/library/importados/tg-iy-bu32-pc-2-f8c089-1024.webp', '/uploads/library/importados/tg-iy-bu32-pc-2-f8c089-480.webp', 'tg-iy-bu32-pc-2', 'image/webp', 1313, 568, 41448, NULL, 18
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu32-pc-2-f8c089.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu46-pc-1-d63e01.webp', '/uploads/library/importados/tg-iy-bu46-pc-1-d63e01-480.webp', '/uploads/library/importados/tg-iy-bu46-pc-1-d63e01-1024.webp', '/uploads/library/importados/tg-iy-bu46-pc-1-d63e01-480.webp', 'tg-iy-bu46-pc-1', 'image/webp', 486, 497, 8476, NULL, 19
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu46-pc-1-d63e01.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu46-pc-2-4b823b.webp', '/uploads/library/importados/tg-iy-bu46-pc-2-4b823b-480.webp', '/uploads/library/importados/tg-iy-bu46-pc-2-4b823b-1024.webp', '/uploads/library/importados/tg-iy-bu46-pc-2-4b823b-480.webp', 'tg-iy-bu46-pc-2', 'image/webp', 1313, 568, 41448, NULL, 20
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu46-pc-2-4b823b.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu70w-1-8c0622.webp', '/uploads/library/importados/tg-iy-bu70w-1-8c0622-480.webp', '/uploads/library/importados/tg-iy-bu70w-1-8c0622-1024.webp', '/uploads/library/importados/tg-iy-bu70w-1-8c0622-480.webp', 'tg-iy-bu70w-1', 'image/webp', 542, 537, 2746, NULL, 21
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu70w-1-8c0622.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu70w-2-d70327.webp', '/uploads/library/importados/tg-iy-bu70w-2-d70327-480.webp', '/uploads/library/importados/tg-iy-bu70w-2-d70327-1024.webp', '/uploads/library/importados/tg-iy-bu70w-2-d70327-480.webp', 'tg-iy-bu70w-2', 'image/webp', 518, 487, 2760, NULL, 22
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu70w-2-d70327.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu85-pc-1-22e4cd.webp', '/uploads/library/importados/tg-iy-bu85-pc-1-22e4cd-480.webp', '/uploads/library/importados/tg-iy-bu85-pc-1-22e4cd-1024.webp', '/uploads/library/importados/tg-iy-bu85-pc-1-22e4cd-480.webp', 'tg-iy-bu85-pc-1', 'image/webp', 652, 576, 22590, NULL, 23
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu85-pc-1-22e4cd.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bu85-pc-2-de917c.webp', '/uploads/library/importados/tg-iy-bu85-pc-2-de917c-480.webp', '/uploads/library/importados/tg-iy-bu85-pc-2-de917c-1024.webp', '/uploads/library/importados/tg-iy-bu85-pc-2-de917c-480.webp', 'tg-iy-bu85-pc-2', 'image/webp', 1313, 568, 41448, NULL, 24
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bu85-pc-2-de917c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c30nt-1-01fdf4.webp', '/uploads/library/importados/tg-ly-c30nt-1-01fdf4-480.webp', '/uploads/library/importados/tg-ly-c30nt-1-01fdf4-1024.webp', '/uploads/library/importados/tg-ly-c30nt-1-01fdf4-480.webp', 'tg-ly-c30nt-1', 'image/webp', 503, 555, 15194, NULL, 25
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c30nt-1-01fdf4.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c30nt-2-67ecc0.webp', '/uploads/library/importados/tg-ly-c30nt-2-67ecc0-480.webp', '/uploads/library/importados/tg-ly-c30nt-2-67ecc0-1024.webp', '/uploads/library/importados/tg-ly-c30nt-2-67ecc0-480.webp', 'tg-ly-c30nt-2', 'image/webp', 843, 544, 16174, NULL, 26
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c30nt-2-67ecc0.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c30ncl-1-aec301.webp', '/uploads/library/importados/tg-ly-c30ncl-1-aec301-480.webp', '/uploads/library/importados/tg-ly-c30ncl-1-aec301-1024.webp', '/uploads/library/importados/tg-ly-c30ncl-1-aec301-480.webp', 'tg-ly-c30ncl-1', 'image/webp', 503, 555, 15194, NULL, 27
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c30ncl-1-aec301.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c30ncl-2-d130d1.webp', '/uploads/library/importados/tg-ly-c30ncl-2-d130d1-480.webp', '/uploads/library/importados/tg-ly-c30ncl-2-d130d1-1024.webp', '/uploads/library/importados/tg-ly-c30ncl-2-d130d1-480.webp', 'tg-ly-c30ncl-2', 'image/webp', 635, 587, 16972, NULL, 28
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c30ncl-2-d130d1.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c40nt-1-389a02.webp', '/uploads/library/importados/tg-ly-c40nt-1-389a02-480.webp', '/uploads/library/importados/tg-ly-c40nt-1-389a02-1024.webp', '/uploads/library/importados/tg-ly-c40nt-1-389a02-480.webp', 'tg-ly-c40nt-1', 'image/webp', 650, 614, 33386, NULL, 29
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c40nt-1-389a02.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c40nt-2-47f4c8.webp', '/uploads/library/importados/tg-ly-c40nt-2-47f4c8-480.webp', '/uploads/library/importados/tg-ly-c40nt-2-47f4c8-1024.webp', '/uploads/library/importados/tg-ly-c40nt-2-47f4c8-480.webp', 'tg-ly-c40nt-2', 'image/webp', 843, 544, 15966, NULL, 30
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c40nt-2-47f4c8.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c40ncl-1-28b1dc.webp', '/uploads/library/importados/tg-ly-c40ncl-1-28b1dc-480.webp', '/uploads/library/importados/tg-ly-c40ncl-1-28b1dc-1024.webp', '/uploads/library/importados/tg-ly-c40ncl-1-28b1dc-480.webp', 'tg-ly-c40ncl-1', 'image/webp', 650, 614, 33386, NULL, 31
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c40ncl-1-28b1dc.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c40ncl-2-2118b8.webp', '/uploads/library/importados/tg-ly-c40ncl-2-2118b8-480.webp', '/uploads/library/importados/tg-ly-c40ncl-2-2118b8-1024.webp', '/uploads/library/importados/tg-ly-c40ncl-2-2118b8-480.webp', 'tg-ly-c40ncl-2', 'image/webp', 693, 516, 61258, NULL, 32
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c40ncl-2-2118b8.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c5nt-1-4f593b.webp', '/uploads/library/importados/tg-ly-c5nt-1-4f593b-480.webp', '/uploads/library/importados/tg-ly-c5nt-1-4f593b-1024.webp', '/uploads/library/importados/tg-ly-c5nt-1-4f593b-480.webp', 'tg-ly-c5nt-1', 'image/webp', 608, 571, 18914, NULL, 33
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c5nt-1-4f593b.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c5nt-2-d8a5d5.webp', '/uploads/library/importados/tg-ly-c5nt-2-d8a5d5-480.webp', '/uploads/library/importados/tg-ly-c5nt-2-d8a5d5-1024.webp', '/uploads/library/importados/tg-ly-c5nt-2-d8a5d5-480.webp', 'tg-ly-c5nt-2', 'image/webp', 757, 557, 3108, NULL, 34
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c5nt-2-d8a5d5.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c10nt-1-60564c.webp', '/uploads/library/importados/tg-ly-c10nt-1-60564c-480.webp', '/uploads/library/importados/tg-ly-c10nt-1-60564c-1024.webp', '/uploads/library/importados/tg-ly-c10nt-1-60564c-480.webp', 'tg-ly-c10nt-1', 'image/webp', 653, 592, 32098, NULL, 35
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c10nt-1-60564c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c10nt-2-e00475.webp', '/uploads/library/importados/tg-ly-c10nt-2-e00475-480.webp', '/uploads/library/importados/tg-ly-c10nt-2-e00475-1024.webp', '/uploads/library/importados/tg-ly-c10nt-2-e00475-480.webp', 'tg-ly-c10nt-2', 'image/webp', 757, 557, 3118, NULL, 36
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c10nt-2-e00475.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c10ncl-1-c5313f.webp', '/uploads/library/importados/tg-ly-c10ncl-1-c5313f-480.webp', '/uploads/library/importados/tg-ly-c10ncl-1-c5313f-1024.webp', '/uploads/library/importados/tg-ly-c10ncl-1-c5313f-480.webp', 'tg-ly-c10ncl-1', 'image/webp', 653, 592, 32098, NULL, 37
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c10ncl-1-c5313f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c10ncl-2-837809.webp', '/uploads/library/importados/tg-ly-c10ncl-2-837809-480.webp', '/uploads/library/importados/tg-ly-c10ncl-2-837809-1024.webp', '/uploads/library/importados/tg-ly-c10ncl-2-837809-480.webp', 'tg-ly-c10ncl-2', 'image/webp', 635, 587, 16516, NULL, 38
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c10ncl-2-837809.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c18nt-1-b77082.webp', '/uploads/library/importados/tg-ly-c18nt-1-b77082-480.webp', '/uploads/library/importados/tg-ly-c18nt-1-b77082-1024.webp', '/uploads/library/importados/tg-ly-c18nt-1-b77082-480.webp', 'tg-ly-c18nt-1', 'image/webp', 663, 594, 20288, NULL, 39
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c18nt-1-b77082.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c18nt-2-0dfa24.webp', '/uploads/library/importados/tg-ly-c18nt-2-0dfa24-480.webp', '/uploads/library/importados/tg-ly-c18nt-2-0dfa24-1024.webp', '/uploads/library/importados/tg-ly-c18nt-2-0dfa24-480.webp', 'tg-ly-c18nt-2', 'image/webp', 757, 557, 3118, NULL, 40
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c18nt-2-0dfa24.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c18ncl-1-1c77db.webp', '/uploads/library/importados/tg-ly-c18ncl-1-1c77db-480.webp', '/uploads/library/importados/tg-ly-c18ncl-1-1c77db-1024.webp', '/uploads/library/importados/tg-ly-c18ncl-1-1c77db-480.webp', 'tg-ly-c18ncl-1', 'image/webp', 663, 594, 20288, NULL, 41
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c18ncl-1-1c77db.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-c18ncl-2-d0f0e9.webp', '/uploads/library/importados/tg-ly-c18ncl-2-d0f0e9-480.webp', '/uploads/library/importados/tg-ly-c18ncl-2-d0f0e9-1024.webp', '/uploads/library/importados/tg-ly-c18ncl-2-d0f0e9-480.webp', 'tg-ly-c18ncl-2', 'image/webp', 693, 516, 61258, NULL, 42
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-c18ncl-2-d0f0e9.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-rbp35x50-1-19549e.webp', '/uploads/library/importados/tg-cm-rbp35x50-1-19549e-480.webp', '/uploads/library/importados/tg-cm-rbp35x50-1-19549e-1024.webp', '/uploads/library/importados/tg-cm-rbp35x50-1-19549e-480.webp', 'tg-cm-rbp35x50-1', 'image/webp', 574, 539, 5682, NULL, 43
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-rbp35x50-1-19549e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pzboxch-1-4a6ec0.webp', '/uploads/library/importados/tg-iy-pzboxch-1-4a6ec0-480.webp', '/uploads/library/importados/tg-iy-pzboxch-1-4a6ec0-1024.webp', '/uploads/library/importados/tg-iy-pzboxch-1-4a6ec0-480.webp', 'tg-iy-pzboxch-1', 'image/webp', 864, 864, 12810, NULL, 44
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pzboxch-1-4a6ec0.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pzboxch-2-4d5d1a.webp', '/uploads/library/importados/tg-iy-pzboxch-2-4d5d1a-480.webp', '/uploads/library/importados/tg-iy-pzboxch-2-4d5d1a-1024.webp', '/uploads/library/importados/tg-iy-pzboxch-2-4d5d1a-480.webp', 'tg-iy-pzboxch-2', 'image/webp', 864, 864, 10960, NULL, 45
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pzboxch-2-4d5d1a.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pzboxgd-1-21d8db.webp', '/uploads/library/importados/tg-iy-pzboxgd-1-21d8db-480.webp', '/uploads/library/importados/tg-iy-pzboxgd-1-21d8db-1024.webp', '/uploads/library/importados/tg-iy-pzboxgd-1-21d8db-480.webp', 'tg-iy-pzboxgd-1', 'image/webp', 864, 864, 10476, NULL, 46
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pzboxgd-1-21d8db.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pzboxgd-2-0d8536.webp', '/uploads/library/importados/tg-iy-pzboxgd-2-0d8536-480.webp', '/uploads/library/importados/tg-iy-pzboxgd-2-0d8536-1024.webp', '/uploads/library/importados/tg-iy-pzboxgd-2-0d8536-480.webp', 'tg-iy-pzboxgd-2', 'image/webp', 864, 864, 11260, NULL, 47
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pzboxgd-2-0d8536.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pzboxmd-1-4d8d1d.webp', '/uploads/library/importados/tg-iy-pzboxmd-1-4d8d1d-480.webp', '/uploads/library/importados/tg-iy-pzboxmd-1-4d8d1d-1024.webp', '/uploads/library/importados/tg-iy-pzboxmd-1-4d8d1d-480.webp', 'tg-iy-pzboxmd-1', 'image/webp', 864, 864, 10414, NULL, 48
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pzboxmd-1-4d8d1d.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pzboxmd-2-b1bad6.webp', '/uploads/library/importados/tg-iy-pzboxmd-2-b1bad6-480.webp', '/uploads/library/importados/tg-iy-pzboxmd-2-b1bad6-1024.webp', '/uploads/library/importados/tg-iy-pzboxmd-2-b1bad6-480.webp', 'tg-iy-pzboxmd-2', 'image/webp', 864, 864, 11260, NULL, 49
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pzboxmd-2-b1bad6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-nd-cs1r-tg-1-e3c530.webp', '/uploads/library/importados/tg-nd-cs1r-tg-1-e3c530-480.webp', '/uploads/library/importados/tg-nd-cs1r-tg-1-e3c530-1024.webp', '/uploads/library/importados/tg-nd-cs1r-tg-1-e3c530-480.webp', 'tg-nd-cs1r-tg-1', 'image/webp', 918, 918, 24774, NULL, 50
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-nd-cs1r-tg-1-e3c530.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-nd-cs1r-tg-2-2e8482.webp', '/uploads/library/importados/tg-nd-cs1r-tg-2-2e8482-480.webp', '/uploads/library/importados/tg-nd-cs1r-tg-2-2e8482-1024.webp', '/uploads/library/importados/tg-nd-cs1r-tg-2-2e8482-480.webp', 'tg-nd-cs1r-tg-2', 'image/webp', 918, 918, 13232, NULL, 51
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-nd-cs1r-tg-2-2e8482.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-nd-cs2r-tg-1-385c8e.webp', '/uploads/library/importados/tg-nd-cs2r-tg-1-385c8e-480.webp', '/uploads/library/importados/tg-nd-cs2r-tg-1-385c8e-1024.webp', '/uploads/library/importados/tg-nd-cs2r-tg-1-385c8e-480.webp', 'tg-nd-cs2r-tg-1', 'image/webp', 918, 918, 25848, NULL, 52
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-nd-cs2r-tg-1-385c8e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-nd-cs2r-tg-2-76d7a8.webp', '/uploads/library/importados/tg-nd-cs2r-tg-2-76d7a8-480.webp', '/uploads/library/importados/tg-nd-cs2r-tg-2-76d7a8-1024.webp', '/uploads/library/importados/tg-nd-cs2r-tg-2-76d7a8-480.webp', 'tg-nd-cs2r-tg-2', 'image/webp', 918, 918, 21210, NULL, 53
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-nd-cs2r-tg-2-76d7a8.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-nd-cs3r-tg-1-3f5460.webp', '/uploads/library/importados/tg-nd-cs3r-tg-1-3f5460-480.webp', '/uploads/library/importados/tg-nd-cs3r-tg-1-3f5460-1024.webp', '/uploads/library/importados/tg-nd-cs3r-tg-1-3f5460-480.webp', 'tg-nd-cs3r-tg-1', 'image/webp', 918, 918, 21870, NULL, 54
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-nd-cs3r-tg-1-3f5460.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-nd-cs3r-tg-2-231761.webp', '/uploads/library/importados/tg-nd-cs3r-tg-2-231761-480.webp', '/uploads/library/importados/tg-nd-cs3r-tg-2-231761-1024.webp', '/uploads/library/importados/tg-nd-cs3r-tg-2-231761-480.webp', 'tg-nd-cs3r-tg-2', 'image/webp', 918, 918, 25870, NULL, 55
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-nd-cs3r-tg-2-231761.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr1200k-1-b6a212.webp', '/uploads/library/importados/tg-iy-cr1200k-1-b6a212-480.webp', '/uploads/library/importados/tg-iy-cr1200k-1-b6a212-1024.webp', '/uploads/library/importados/tg-iy-cr1200k-1-b6a212-480.webp', 'tg-iy-cr1200k-1', 'image/webp', 1280, 1280, 15874, NULL, 56
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr1200k-1-b6a212.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr1200k-2-c8ea58.webp', '/uploads/library/importados/tg-iy-cr1200k-2-c8ea58-480.webp', '/uploads/library/importados/tg-iy-cr1200k-2-c8ea58-1024.webp', '/uploads/library/importados/tg-iy-cr1200k-2-c8ea58-480.webp', 'tg-iy-cr1200k-2', 'image/webp', 1080, 1080, 20052, NULL, 57
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr1200k-2-c8ea58.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr1200k-3-7aa03d.webp', '/uploads/library/importados/tg-iy-cr1200k-3-7aa03d-480.webp', '/uploads/library/importados/tg-iy-cr1200k-3-7aa03d-1024.webp', '/uploads/library/importados/tg-iy-cr1200k-3-7aa03d-480.webp', 'tg-iy-cr1200k-3', 'image/webp', 1080, 1080, 23654, NULL, 58
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr1200k-3-7aa03d.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr1600k-1-d20696.webp', '/uploads/library/importados/tg-iy-cr1600k-1-d20696-480.webp', '/uploads/library/importados/tg-iy-cr1600k-1-d20696-1024.webp', '/uploads/library/importados/tg-iy-cr1600k-1-d20696-480.webp', 'tg-iy-cr1600k-1', 'image/webp', 1280, 1280, 15874, NULL, 59
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr1600k-1-d20696.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr1600k-2-c52a91.webp', '/uploads/library/importados/tg-iy-cr1600k-2-c52a91-480.webp', '/uploads/library/importados/tg-iy-cr1600k-2-c52a91-1024.webp', '/uploads/library/importados/tg-iy-cr1600k-2-c52a91-480.webp', 'tg-iy-cr1600k-2', 'image/webp', 1080, 1080, 20052, NULL, 60
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr1600k-2-c52a91.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr1600k-3-c0ae89.webp', '/uploads/library/importados/tg-iy-cr1600k-3-c0ae89-480.webp', '/uploads/library/importados/tg-iy-cr1600k-3-c0ae89-1024.webp', '/uploads/library/importados/tg-iy-cr1600k-3-c0ae89-480.webp', 'tg-iy-cr1600k-3', 'image/webp', 1080, 1080, 23654, NULL, 61
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr1600k-3-c0ae89.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr2100k-1-d20ec0.webp', '/uploads/library/importados/tg-iy-cr2100k-1-d20ec0-480.webp', '/uploads/library/importados/tg-iy-cr2100k-1-d20ec0-1024.webp', '/uploads/library/importados/tg-iy-cr2100k-1-d20ec0-480.webp', 'tg-iy-cr2100k-1', 'image/webp', 1280, 1280, 15874, NULL, 62
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr2100k-1-d20ec0.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr2100k-2-f4ffbc.webp', '/uploads/library/importados/tg-iy-cr2100k-2-f4ffbc-480.webp', '/uploads/library/importados/tg-iy-cr2100k-2-f4ffbc-1024.webp', '/uploads/library/importados/tg-iy-cr2100k-2-f4ffbc-480.webp', 'tg-iy-cr2100k-2', 'image/webp', 1080, 1080, 20052, NULL, 63
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr2100k-2-f4ffbc.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr2100k-3-389242.webp', '/uploads/library/importados/tg-iy-cr2100k-3-389242-480.webp', '/uploads/library/importados/tg-iy-cr2100k-3-389242-1024.webp', '/uploads/library/importados/tg-iy-cr2100k-3-389242-480.webp', 'tg-iy-cr2100k-3', 'image/webp', 1080, 1080, 23654, NULL, 64
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr2100k-3-389242.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr500k-1-8f80e4.webp', '/uploads/library/importados/tg-iy-cr500k-1-8f80e4-480.webp', '/uploads/library/importados/tg-iy-cr500k-1-8f80e4-1024.webp', '/uploads/library/importados/tg-iy-cr500k-1-8f80e4-480.webp', 'tg-iy-cr500k-1', 'image/webp', 1280, 1280, 15874, NULL, 65
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr500k-1-8f80e4.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr500k-2-b2da4d.webp', '/uploads/library/importados/tg-iy-cr500k-2-b2da4d-480.webp', '/uploads/library/importados/tg-iy-cr500k-2-b2da4d-1024.webp', '/uploads/library/importados/tg-iy-cr500k-2-b2da4d-480.webp', 'tg-iy-cr500k-2', 'image/webp', 1080, 1080, 20052, NULL, 66
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr500k-2-b2da4d.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr500k-3-ba474f.webp', '/uploads/library/importados/tg-iy-cr500k-3-ba474f-480.webp', '/uploads/library/importados/tg-iy-cr500k-3-ba474f-1024.webp', '/uploads/library/importados/tg-iy-cr500k-3-ba474f-480.webp', 'tg-iy-cr500k-3', 'image/webp', 1080, 1080, 23654, NULL, 67
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr500k-3-ba474f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr700k-1-7a7512.webp', '/uploads/library/importados/tg-iy-cr700k-1-7a7512-480.webp', '/uploads/library/importados/tg-iy-cr700k-1-7a7512-1024.webp', '/uploads/library/importados/tg-iy-cr700k-1-7a7512-480.webp', 'tg-iy-cr700k-1', 'image/webp', 1280, 1280, 15874, NULL, 68
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr700k-1-7a7512.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr700k-2-6936fd.webp', '/uploads/library/importados/tg-iy-cr700k-2-6936fd-480.webp', '/uploads/library/importados/tg-iy-cr700k-2-6936fd-1024.webp', '/uploads/library/importados/tg-iy-cr700k-2-6936fd-480.webp', 'tg-iy-cr700k-2', 'image/webp', 1080, 1080, 20052, NULL, 69
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr700k-2-6936fd.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr700k-3-b449a3.webp', '/uploads/library/importados/tg-iy-cr700k-3-b449a3-480.webp', '/uploads/library/importados/tg-iy-cr700k-3-b449a3-1024.webp', '/uploads/library/importados/tg-iy-cr700k-3-b449a3-480.webp', 'tg-iy-cr700k-3', 'image/webp', 1080, 1080, 23654, NULL, 70
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr700k-3-b449a3.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr900k-1-13ebcf.webp', '/uploads/library/importados/tg-iy-cr900k-1-13ebcf-480.webp', '/uploads/library/importados/tg-iy-cr900k-1-13ebcf-1024.webp', '/uploads/library/importados/tg-iy-cr900k-1-13ebcf-480.webp', 'tg-iy-cr900k-1', 'image/webp', 1280, 1280, 15874, NULL, 71
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr900k-1-13ebcf.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr900k-2-347201.webp', '/uploads/library/importados/tg-iy-cr900k-2-347201-480.webp', '/uploads/library/importados/tg-iy-cr900k-2-347201-1024.webp', '/uploads/library/importados/tg-iy-cr900k-2-347201-480.webp', 'tg-iy-cr900k-2', 'image/webp', 1080, 1080, 20052, NULL, 72
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr900k-2-347201.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-cr900k-3-f20863.webp', '/uploads/library/importados/tg-iy-cr900k-3-f20863-480.webp', '/uploads/library/importados/tg-iy-cr900k-3-f20863-1024.webp', '/uploads/library/importados/tg-iy-cr900k-3-f20863-480.webp', 'tg-iy-cr900k-3', 'image/webp', 1080, 1080, 23654, NULL, 73
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-cr900k-3-f20863.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-crv1200k-1-aea943.webp', '/uploads/library/importados/tg-iy-crv1200k-1-aea943-480.webp', '/uploads/library/importados/tg-iy-crv1200k-1-aea943-1024.webp', '/uploads/library/importados/tg-iy-crv1200k-1-aea943-480.webp', 'tg-iy-crv1200k-1', 'image/webp', 576, 460, 7596, NULL, 74
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-crv1200k-1-aea943.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-crv1200k-2-8f6c90.webp', '/uploads/library/importados/tg-iy-crv1200k-2-8f6c90-480.webp', '/uploads/library/importados/tg-iy-crv1200k-2-8f6c90-1024.webp', '/uploads/library/importados/tg-iy-crv1200k-2-8f6c90-480.webp', 'tg-iy-crv1200k-2', 'image/webp', 830, 613, 11832, NULL, 75
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-crv1200k-2-8f6c90.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-crv1600k-1-52b352.webp', '/uploads/library/importados/tg-iy-crv1600k-1-52b352-480.webp', '/uploads/library/importados/tg-iy-crv1600k-1-52b352-1024.webp', '/uploads/library/importados/tg-iy-crv1600k-1-52b352-480.webp', 'tg-iy-crv1600k-1', 'image/webp', 576, 460, 7596, NULL, 76
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-crv1600k-1-52b352.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-crv1600k-2-8c2f48.webp', '/uploads/library/importados/tg-iy-crv1600k-2-8c2f48-480.webp', '/uploads/library/importados/tg-iy-crv1600k-2-8c2f48-1024.webp', '/uploads/library/importados/tg-iy-crv1600k-2-8c2f48-480.webp', 'tg-iy-crv1600k-2', 'image/webp', 830, 613, 11832, NULL, 77
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-crv1600k-2-8c2f48.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-crv2100k-1-b98429.webp', '/uploads/library/importados/tg-iy-crv2100k-1-b98429-480.webp', '/uploads/library/importados/tg-iy-crv2100k-1-b98429-1024.webp', '/uploads/library/importados/tg-iy-crv2100k-1-b98429-480.webp', 'tg-iy-crv2100k-1', 'image/webp', 576, 460, 7596, NULL, 78
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-crv2100k-1-b98429.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-crv2100k-2-be9856.webp', '/uploads/library/importados/tg-iy-crv2100k-2-be9856-480.webp', '/uploads/library/importados/tg-iy-crv2100k-2-be9856-1024.webp', '/uploads/library/importados/tg-iy-crv2100k-2-be9856-480.webp', 'tg-iy-crv2100k-2', 'image/webp', 830, 613, 11832, NULL, 79
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-crv2100k-2-be9856.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-go-p105w-1-ecf97f.webp', '/uploads/library/importados/tg-go-p105w-1-ecf97f-480.webp', '/uploads/library/importados/tg-go-p105w-1-ecf97f-1024.webp', '/uploads/library/importados/tg-go-p105w-1-ecf97f-480.webp', 'tg-go-p105w-1', 'image/webp', 678, 642, 4018, NULL, 80
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-go-p105w-1-ecf97f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-go-p106w-1-54c1f1.webp', '/uploads/library/importados/tg-go-p106w-1-54c1f1-480.webp', '/uploads/library/importados/tg-go-p106w-1-54c1f1-1024.webp', '/uploads/library/importados/tg-go-p106w-1-54c1f1-480.webp', 'tg-go-p106w-1', 'image/webp', 678, 642, 4122, NULL, 81
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-go-p106w-1-54c1f1.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-go-p109w-1-81715f.webp', '/uploads/library/importados/tg-go-p109w-1-81715f-480.webp', '/uploads/library/importados/tg-go-p109w-1-81715f-1024.webp', '/uploads/library/importados/tg-go-p109w-1-81715f-480.webp', 'tg-go-p109w-1', 'image/webp', 678, 642, 4122, NULL, 82
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-go-p109w-1-81715f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-go-p108w-1-3994fc.webp', '/uploads/library/importados/tg-go-p108w-1-3994fc-480.webp', '/uploads/library/importados/tg-go-p108w-1-3994fc-1024.webp', '/uploads/library/importados/tg-go-p108w-1-3994fc-480.webp', 'tg-go-p108w-1', 'image/webp', 642, 605, 4518, NULL, 83
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-go-p108w-1-3994fc.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-go-p110w-1-bfe22b.webp', '/uploads/library/importados/tg-go-p110w-1-bfe22b-480.webp', '/uploads/library/importados/tg-go-p110w-1-bfe22b-1024.webp', '/uploads/library/importados/tg-go-p110w-1-bfe22b-480.webp', 'tg-go-p110w-1', 'image/webp', 566, 545, 3914, NULL, 84
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-go-p110w-1-bfe22b.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-10857-1-131d68.webp', '/uploads/library/importados/tg-tg-10857-1-131d68-480.webp', '/uploads/library/importados/tg-tg-10857-1-131d68-1024.webp', '/uploads/library/importados/tg-tg-10857-1-131d68-480.webp', 'tg-tg-10857-1', 'image/webp', 870, 633, 26218, NULL, 85
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-10857-1-131d68.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-10865-1-78b602.webp', '/uploads/library/importados/tg-tg-10865-1-78b602-480.webp', '/uploads/library/importados/tg-tg-10865-1-78b602-1024.webp', '/uploads/library/importados/tg-tg-10865-1-78b602-480.webp', 'tg-tg-10865-1', 'image/webp', 681, 486, 5598, NULL, 86
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-10865-1-78b602.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-10865-2-2d8f2f.webp', '/uploads/library/importados/tg-tg-10865-2-2d8f2f-480.webp', '/uploads/library/importados/tg-tg-10865-2-2d8f2f-1024.webp', '/uploads/library/importados/tg-tg-10865-2-2d8f2f-480.webp', 'tg-tg-10865-2', 'image/webp', 602, 507, 6784, NULL, 87
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-10865-2-2d8f2f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dcr160b-1-319b9c.webp', '/uploads/library/importados/tg-tg-dcr160b-1-319b9c-480.webp', '/uploads/library/importados/tg-tg-dcr160b-1-319b9c-1024.webp', '/uploads/library/importados/tg-tg-dcr160b-1-319b9c-480.webp', 'tg-tg-dcr160b-1', 'image/webp', 691, 548, 4804, NULL, 88
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dcr160b-1-319b9c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dcr60b-1-f75aa1.webp', '/uploads/library/importados/tg-tg-dcr60b-1-f75aa1-480.webp', '/uploads/library/importados/tg-tg-dcr60b-1-f75aa1-1024.webp', '/uploads/library/importados/tg-tg-dcr60b-1-f75aa1-480.webp', 'tg-tg-dcr60b-1', 'image/webp', 691, 548, 4804, NULL, 89
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dcr60b-1-f75aa1.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dcs110bc-1-856c0d.webp', '/uploads/library/importados/tg-tg-dcs110bc-1-856c0d-480.webp', '/uploads/library/importados/tg-tg-dcs110bc-1-856c0d-1024.webp', '/uploads/library/importados/tg-tg-dcs110bc-1-856c0d-480.webp', 'tg-tg-dcs110bc-1', 'image/webp', 597, 524, 11858, NULL, 90
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dcs110bc-1-856c0d.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dcs110bc-2-279e04.webp', '/uploads/library/importados/tg-tg-dcs110bc-2-279e04-480.webp', '/uploads/library/importados/tg-tg-dcs110bc-2-279e04-1024.webp', '/uploads/library/importados/tg-tg-dcs110bc-2-279e04-480.webp', 'tg-tg-dcs110bc-2', 'image/webp', 772, 617, 15074, NULL, 91
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dcs110bc-2-279e04.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dcs220bc-1-e893b8.webp', '/uploads/library/importados/tg-tg-dcs220bc-1-e893b8-480.webp', '/uploads/library/importados/tg-tg-dcs220bc-1-e893b8-1024.webp', '/uploads/library/importados/tg-tg-dcs220bc-1-e893b8-480.webp', 'tg-tg-dcs220bc-1', 'image/webp', 597, 524, 11858, NULL, 92
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dcs220bc-1-e893b8.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dcs220bc-2-6eb446.webp', '/uploads/library/importados/tg-tg-dcs220bc-2-6eb446-480.webp', '/uploads/library/importados/tg-tg-dcs220bc-2-6eb446-1024.webp', '/uploads/library/importados/tg-tg-dcs220bc-2-6eb446-480.webp', 'tg-tg-dcs220bc-2', 'image/webp', 772, 617, 15074, NULL, 93
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dcs220bc-2-6eb446.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dct180bc-1-0cf239.webp', '/uploads/library/importados/tg-tg-dct180bc-1-0cf239-480.webp', '/uploads/library/importados/tg-tg-dct180bc-1-0cf239-1024.webp', '/uploads/library/importados/tg-tg-dct180bc-1-0cf239-480.webp', 'tg-tg-dct180bc-1', 'image/webp', 702, 522, 12196, NULL, 94
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dct180bc-1-0cf239.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dct180bc-2-cca6fa.webp', '/uploads/library/importados/tg-tg-dct180bc-2-cca6fa-480.webp', '/uploads/library/importados/tg-tg-dct180bc-2-cca6fa-1024.webp', '/uploads/library/importados/tg-tg-dct180bc-2-cca6fa-480.webp', 'tg-tg-dct180bc-2', 'image/webp', 823, 604, 12180, NULL, 95
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dct180bc-2-cca6fa.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dct80bc-1-78cdbc.webp', '/uploads/library/importados/tg-tg-dct80bc-1-78cdbc-480.webp', '/uploads/library/importados/tg-tg-dct80bc-1-78cdbc-1024.webp', '/uploads/library/importados/tg-tg-dct80bc-1-78cdbc-480.webp', 'tg-tg-dct80bc-1', 'image/webp', 702, 522, 12196, NULL, 96
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dct80bc-1-78cdbc.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-dct80bc-2-da3c75.webp', '/uploads/library/importados/tg-tg-dct80bc-2-da3c75-480.webp', '/uploads/library/importados/tg-tg-dct80bc-2-da3c75-1024.webp', '/uploads/library/importados/tg-tg-dct80bc-2-da3c75-480.webp', 'tg-tg-dct80bc-2', 'image/webp', 823, 604, 12180, NULL, 97
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-dct80bc-2-da3c75.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-sbplafk1000-g-1-0d9fac.webp', '/uploads/library/importados/tg-hl-sbplafk1000-g-1-0d9fac-480.webp', '/uploads/library/importados/tg-hl-sbplafk1000-g-1-0d9fac-1024.webp', '/uploads/library/importados/tg-hl-sbplafk1000-g-1-0d9fac-480.webp', 'tg-hl-sbplafk1000-g-1', 'image/webp', 1200, 1600, 31668, NULL, 98
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-sbplafk1000-g-1-0d9fac.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-sbplafk1000-g-2-a3095c.webp', '/uploads/library/importados/tg-hl-sbplafk1000-g-2-a3095c-480.webp', '/uploads/library/importados/tg-hl-sbplafk1000-g-2-a3095c-1024.webp', '/uploads/library/importados/tg-hl-sbplafk1000-g-2-a3095c-480.webp', 'tg-hl-sbplafk1000-g-2', 'image/webp', 1200, 1600, 31004, NULL, 99
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-sbplafk1000-g-2-a3095c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs20b-1-a9b977.webp', '/uploads/library/importados/tg-iy-pcs20b-1-a9b977-480.webp', '/uploads/library/importados/tg-iy-pcs20b-1-a9b977-1024.webp', '/uploads/library/importados/tg-iy-pcs20b-1-a9b977-480.webp', 'tg-iy-pcs20b-1', 'image/webp', 600, 469, 3380, NULL, 100
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs20b-1-a9b977.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs325b-1-389a9e.webp', '/uploads/library/importados/tg-iy-pcs325b-1-389a9e-480.webp', '/uploads/library/importados/tg-iy-pcs325b-1-389a9e-1024.webp', '/uploads/library/importados/tg-iy-pcs325b-1-389a9e-480.webp', 'tg-iy-pcs325b-1', 'image/webp', 703, 562, 6254, NULL, 101
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs325b-1-389a9e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs325b-2-036f8f.webp', '/uploads/library/importados/tg-iy-pcs325b-2-036f8f-480.webp', '/uploads/library/importados/tg-iy-pcs325b-2-036f8f-1024.webp', '/uploads/library/importados/tg-iy-pcs325b-2-036f8f-480.webp', 'tg-iy-pcs325b-2', 'image/webp', 641, 561, 4572, NULL, 102
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs325b-2-036f8f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs05-1-a29701.webp', '/uploads/library/importados/tg-iy-pcs05-1-a29701-480.webp', '/uploads/library/importados/tg-iy-pcs05-1-a29701-1024.webp', '/uploads/library/importados/tg-iy-pcs05-1-a29701-480.webp', 'tg-iy-pcs05-1', 'image/webp', 252, 196, 5198, NULL, 103
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs05-1-a29701.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs075-1-66b526.webp', '/uploads/library/importados/tg-iy-pcs075-1-66b526-480.webp', '/uploads/library/importados/tg-iy-pcs075-1-66b526-1024.webp', '/uploads/library/importados/tg-iy-pcs075-1-66b526-480.webp', 'tg-iy-pcs075-1', 'image/webp', 252, 196, 5070, NULL, 104
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs075-1-66b526.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs15-1-9d39b2.webp', '/uploads/library/importados/tg-iy-pcs15-1-9d39b2-480.webp', '/uploads/library/importados/tg-iy-pcs15-1-9d39b2-1024.webp', '/uploads/library/importados/tg-iy-pcs15-1-9d39b2-480.webp', 'tg-iy-pcs15-1', 'image/webp', 248, 149, 3532, NULL, 105
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs15-1-9d39b2.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs10-1-48af0a.webp', '/uploads/library/importados/tg-iy-pcs10-1-48af0a-480.webp', '/uploads/library/importados/tg-iy-pcs10-1-48af0a-1024.webp', '/uploads/library/importados/tg-iy-pcs10-1-48af0a-480.webp', 'tg-iy-pcs10-1', 'image/webp', 287, 219, 6136, NULL, 106
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs10-1-48af0a.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs10-2-74653e.webp', '/uploads/library/importados/tg-iy-pcs10-2-74653e-480.webp', '/uploads/library/importados/tg-iy-pcs10-2-74653e-1024.webp', '/uploads/library/importados/tg-iy-pcs10-2-74653e-480.webp', 'tg-iy-pcs10-2', 'image/webp', 238, 191, 5242, NULL, 107
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs10-2-74653e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs25-1-48bf73.webp', '/uploads/library/importados/tg-iy-pcs25-1-48bf73-480.webp', '/uploads/library/importados/tg-iy-pcs25-1-48bf73-1024.webp', '/uploads/library/importados/tg-iy-pcs25-1-48bf73-480.webp', 'tg-iy-pcs25-1', 'image/webp', 237, 174, 4336, NULL, 108
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs25-1-48bf73.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs20-1-1ac899.webp', '/uploads/library/importados/tg-iy-pcs20-1-1ac899-480.webp', '/uploads/library/importados/tg-iy-pcs20-1-1ac899-1024.webp', '/uploads/library/importados/tg-iy-pcs20-1-1ac899-480.webp', 'tg-iy-pcs20-1', 'image/webp', 248, 178, 4458, NULL, 109
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs20-1-1ac899.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-pcs325-1-92e3b1.webp', '/uploads/library/importados/tg-iy-pcs325-1-92e3b1-480.webp', '/uploads/library/importados/tg-iy-pcs325-1-92e3b1-1024.webp', '/uploads/library/importados/tg-iy-pcs325-1-92e3b1-480.webp', 'tg-iy-pcs325-1', 'image/webp', 226, 180, 3564, NULL, 110
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-pcs325-1-92e3b1.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-ppc10t-1-e825cc.webp', '/uploads/library/importados/tg-iy-ppc10t-1-e825cc-480.webp', '/uploads/library/importados/tg-iy-ppc10t-1-e825cc-1024.webp', '/uploads/library/importados/tg-iy-ppc10t-1-e825cc-480.webp', 'tg-iy-ppc10t-1', 'image/webp', 864, 864, 5142, NULL, 111
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-ppc10t-1-e825cc.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-ct12-1-2d9a57.webp', '/uploads/library/importados/tg-tg-ct12-1-2d9a57-480.webp', '/uploads/library/importados/tg-tg-ct12-1-2d9a57-1024.webp', '/uploads/library/importados/tg-tg-ct12-1-2d9a57-480.webp', 'tg-tg-ct12-1', 'image/webp', 470, 338, 6172, NULL, 112
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-ct12-1-2d9a57.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-ct08-1-459592.webp', '/uploads/library/importados/tg-tg-ct08-1-459592-480.webp', '/uploads/library/importados/tg-tg-ct08-1-459592-1024.webp', '/uploads/library/importados/tg-tg-ct08-1-459592-480.webp', 'tg-tg-ct08-1', 'image/webp', 434, 321, 5842, NULL, 113
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-ct08-1-459592.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-ct08-2-0ad757.webp', '/uploads/library/importados/tg-tg-ct08-2-0ad757-480.webp', '/uploads/library/importados/tg-tg-ct08-2-0ad757-1024.webp', '/uploads/library/importados/tg-tg-ct08-2-0ad757-480.webp', 'tg-tg-ct08-2', 'image/webp', 648, 580, 46036, NULL, 114
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-ct08-2-0ad757.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-y465-1-6fe09e.webp', '/uploads/library/importados/tg-ly-y465-1-6fe09e-480.webp', '/uploads/library/importados/tg-ly-y465-1-6fe09e-1024.webp', '/uploads/library/importados/tg-ly-y465-1-6fe09e-480.webp', 'tg-ly-y465-1', 'image/webp', 1080, 1080, 65304, NULL, 115
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-y465-1-6fe09e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-sw-sb26s-1-cfc86a.webp', '/uploads/library/importados/tg-sw-sb26s-1-cfc86a-480.webp', '/uploads/library/importados/tg-sw-sb26s-1-cfc86a-1024.webp', '/uploads/library/importados/tg-sw-sb26s-1-cfc86a-480.webp', 'tg-sw-sb26s-1', 'image/webp', 657, 469, 7662, NULL, 116
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-sw-sb26s-1-cfc86a.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-sw-sb26s-2-198870.webp', '/uploads/library/importados/tg-sw-sb26s-2-198870-480.webp', '/uploads/library/importados/tg-sw-sb26s-2-198870-1024.webp', '/uploads/library/importados/tg-sw-sb26s-2-198870-480.webp', 'tg-sw-sb26s-2', 'image/webp', 461, 452, 8124, NULL, 117
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-sw-sb26s-2-198870.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-sw-sb40s-1-5fb841.webp', '/uploads/library/importados/tg-sw-sb40s-1-5fb841-480.webp', '/uploads/library/importados/tg-sw-sb40s-1-5fb841-1024.webp', '/uploads/library/importados/tg-sw-sb40s-1-5fb841-480.webp', 'tg-sw-sb40s-1', 'image/webp', 657, 469, 7662, NULL, 118
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-sw-sb40s-1-5fb841.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-8012n-1-738a53.webp', '/uploads/library/importados/tg-tg-8012n-1-738a53-480.webp', '/uploads/library/importados/tg-tg-8012n-1-738a53-1024.webp', '/uploads/library/importados/tg-tg-8012n-1-738a53-480.webp', 'tg-tg-8012n-1', 'image/webp', 534, 403, 8614, NULL, 119
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-8012n-1-738a53.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-8012n-2-43a636.webp', '/uploads/library/importados/tg-tg-8012n-2-43a636-480.webp', '/uploads/library/importados/tg-tg-8012n-2-43a636-1024.webp', '/uploads/library/importados/tg-tg-8012n-2-43a636-480.webp', 'tg-tg-8012n-2', 'image/webp', 622, 522, 15064, NULL, 120
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-8012n-2-43a636.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-8010n-1-439100.webp', '/uploads/library/importados/tg-tg-8010n-1-439100-480.webp', '/uploads/library/importados/tg-tg-8010n-1-439100-1024.webp', '/uploads/library/importados/tg-tg-8010n-1-439100-480.webp', 'tg-tg-8010n-1', 'image/webp', 564, 189, 16182, NULL, 121
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-8010n-1-439100.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-8012-1-d03912.webp', '/uploads/library/importados/tg-tg-8012-1-d03912-480.webp', '/uploads/library/importados/tg-tg-8012-1-d03912-1024.webp', '/uploads/library/importados/tg-tg-8012-1-d03912-480.webp', 'tg-tg-8012-1', 'image/webp', 623, 478, 8308, NULL, 122
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-8012-1-d03912.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-8010-1-20ed90.webp', '/uploads/library/importados/tg-tg-8010-1-20ed90-480.webp', '/uploads/library/importados/tg-tg-8010-1-20ed90-1024.webp', '/uploads/library/importados/tg-tg-8010-1-20ed90-480.webp', 'tg-tg-8010-1', 'image/webp', 564, 189, 16182, NULL, 123
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-8010-1-20ed90.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-8000-1-577ed6.webp', '/uploads/library/importados/tg-tg-8000-1-577ed6-480.webp', '/uploads/library/importados/tg-tg-8000-1-577ed6-1024.webp', '/uploads/library/importados/tg-tg-8000-1-577ed6-480.webp', 'tg-tg-8000-1', 'image/webp', 672, 471, 9644, NULL, 124
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-8000-1-577ed6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-sw-lsrc26-1-8b8b2e.webp', '/uploads/library/importados/tg-sw-lsrc26-1-8b8b2e-480.webp', '/uploads/library/importados/tg-sw-lsrc26-1-8b8b2e-1024.webp', '/uploads/library/importados/tg-sw-lsrc26-1-8b8b2e-480.webp', 'tg-sw-lsrc26-1', 'image/webp', 618, 540, 6726, NULL, 125
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-sw-lsrc26-1-8b8b2e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-sw-lsrc40-1-e5a196.webp', '/uploads/library/importados/tg-sw-lsrc40-1-e5a196-480.webp', '/uploads/library/importados/tg-sw-lsrc40-1-e5a196-1024.webp', '/uploads/library/importados/tg-sw-lsrc40-1-e5a196-480.webp', 'tg-sw-lsrc40-1', 'image/webp', 618, 540, 6726, NULL, 126
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-sw-lsrc40-1-e5a196.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fc045-1-583be3.webp', '/uploads/library/importados/tg-tg-fc045-1-583be3-480.webp', '/uploads/library/importados/tg-tg-fc045-1-583be3-1024.webp', '/uploads/library/importados/tg-tg-fc045-1-583be3-480.webp', 'tg-tg-fc045-1', 'image/webp', 649, 519, 2936, NULL, 127
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fc045-1-583be3.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fc04-1-146272.webp', '/uploads/library/importados/tg-tg-fc04-1-146272-480.webp', '/uploads/library/importados/tg-tg-fc04-1-146272-1024.webp', '/uploads/library/importados/tg-tg-fc04-1-146272-480.webp', 'tg-tg-fc04-1', 'image/webp', 686, 476, 2696, NULL, 128
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fc04-1-146272.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-rbp16ssk-1-df2637.webp', '/uploads/library/importados/tg-iy-rbp16ssk-1-df2637-480.webp', '/uploads/library/importados/tg-iy-rbp16ssk-1-df2637-1024.webp', '/uploads/library/importados/tg-iy-rbp16ssk-1-df2637-480.webp', 'tg-iy-rbp16ssk-1', 'image/webp', 493, 474, 4624, NULL, 129
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-rbp16ssk-1-df2637.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-rbp26ssk-1-2d5533.webp', '/uploads/library/importados/tg-iy-rbp26ssk-1-2d5533-480.webp', '/uploads/library/importados/tg-iy-rbp26ssk-1-2d5533-1024.webp', '/uploads/library/importados/tg-iy-rbp26ssk-1-2d5533-480.webp', 'tg-iy-rbp26ssk-1', 'image/webp', 583, 490, 4284, NULL, 130
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-rbp26ssk-1-2d5533.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-rbp32ssk-1-06d269.webp', '/uploads/library/importados/tg-iy-rbp32ssk-1-06d269-480.webp', '/uploads/library/importados/tg-iy-rbp32ssk-1-06d269-1024.webp', '/uploads/library/importados/tg-iy-rbp32ssk-1-06d269-480.webp', 'tg-iy-rbp32ssk-1', 'image/webp', 708, 570, 4318, NULL, 131
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-rbp32ssk-1-06d269.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bbtk001-1-79a091.webp', '/uploads/library/importados/tg-iy-bbtk001-1-79a091-480.webp', '/uploads/library/importados/tg-iy-bbtk001-1-79a091-1024.webp', '/uploads/library/importados/tg-iy-bbtk001-1-79a091-480.webp', 'tg-iy-bbtk001-1', 'image/webp', 625, 484, 11634, NULL, 132
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bbtk001-1-79a091.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bbtk002-1-47620b.webp', '/uploads/library/importados/tg-iy-bbtk002-1-47620b-480.webp', '/uploads/library/importados/tg-iy-bbtk002-1-47620b-1024.webp', '/uploads/library/importados/tg-iy-bbtk002-1-47620b-480.webp', 'tg-iy-bbtk002-1', 'image/webp', 600, 600, 18934, NULL, 133
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bbtk002-1-47620b.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bbtk003-1-b98e90.webp', '/uploads/library/importados/tg-iy-bbtk003-1-b98e90-480.webp', '/uploads/library/importados/tg-iy-bbtk003-1-b98e90-1024.webp', '/uploads/library/importados/tg-iy-bbtk003-1-b98e90-480.webp', 'tg-iy-bbtk003-1', 'image/webp', 600, 600, 18934, NULL, 134
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bbtk003-1-b98e90.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bbtk004-1-ff532c.webp', '/uploads/library/importados/tg-iy-bbtk004-1-ff532c-480.webp', '/uploads/library/importados/tg-iy-bbtk004-1-ff532c-1024.webp', '/uploads/library/importados/tg-iy-bbtk004-1-ff532c-480.webp', 'tg-iy-bbtk004-1', 'image/webp', 667, 609, 2898, NULL, 135
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bbtk004-1-ff532c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bbtk005-1-731c56.webp', '/uploads/library/importados/tg-iy-bbtk005-1-731c56-480.webp', '/uploads/library/importados/tg-iy-bbtk005-1-731c56-1024.webp', '/uploads/library/importados/tg-iy-bbtk005-1-731c56-480.webp', 'tg-iy-bbtk005-1', 'image/webp', 671, 496, 8914, NULL, 136
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bbtk005-1-731c56.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-bbtk006-1-d21541.webp', '/uploads/library/importados/tg-iy-bbtk006-1-d21541-480.webp', '/uploads/library/importados/tg-iy-bbtk006-1-d21541-1024.webp', '/uploads/library/importados/tg-iy-bbtk006-1-d21541-480.webp', 'tg-iy-bbtk006-1', 'image/webp', 718, 540, 6146, NULL, 137
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-bbtk006-1-d21541.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-st6197w-1-0ec810.webp', '/uploads/library/importados/tg-iy-st6197w-1-0ec810-480.webp', '/uploads/library/importados/tg-iy-st6197w-1-0ec810-1024.webp', '/uploads/library/importados/tg-iy-st6197w-1-0ec810-480.webp', 'tg-iy-st6197w-1', 'image/webp', 568, 520, 14606, NULL, 138
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-st6197w-1-0ec810.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-wst6197w-1-bd0365.webp', '/uploads/library/importados/tg-iy-wst6197w-1-bd0365-480.webp', '/uploads/library/importados/tg-iy-wst6197w-1-bd0365-1024.webp', '/uploads/library/importados/tg-iy-wst6197w-1-bd0365-480.webp', 'tg-iy-wst6197w-1', 'image/webp', 509, 715, 17108, NULL, 139
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-wst6197w-1-bd0365.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-st8254w-1-9f682c.webp', '/uploads/library/importados/tg-iy-st8254w-1-9f682c-480.webp', '/uploads/library/importados/tg-iy-st8254w-1-9f682c-1024.webp', '/uploads/library/importados/tg-iy-st8254w-1-9f682c-480.webp', 'tg-iy-st8254w-1', 'image/webp', 560, 760, 31614, NULL, 140
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-st8254w-1-9f682c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-wst8254w-1-e21ca0.webp', '/uploads/library/importados/tg-iy-wst8254w-1-e21ca0-480.webp', '/uploads/library/importados/tg-iy-wst8254w-1-e21ca0-1024.webp', '/uploads/library/importados/tg-iy-wst8254w-1-e21ca0-480.webp', 'tg-iy-wst8254w-1', 'image/webp', 573, 665, 21116, NULL, 141
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-wst8254w-1-e21ca0.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-st6197b-1-5f9c3e.webp', '/uploads/library/importados/tg-iy-st6197b-1-5f9c3e-480.webp', '/uploads/library/importados/tg-iy-st6197b-1-5f9c3e-1024.webp', '/uploads/library/importados/tg-iy-st6197b-1-5f9c3e-480.webp', 'tg-iy-st6197b-1', 'image/webp', 524, 746, 19720, NULL, 142
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-st6197b-1-5f9c3e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-wst6197b-1-01565b.webp', '/uploads/library/importados/tg-iy-wst6197b-1-01565b-480.webp', '/uploads/library/importados/tg-iy-wst6197b-1-01565b-1024.webp', '/uploads/library/importados/tg-iy-wst6197b-1-01565b-480.webp', 'tg-iy-wst6197b-1', 'image/webp', 557, 748, 24334, NULL, 143
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-wst6197b-1-01565b.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-st8254b-1-0c0e96.webp', '/uploads/library/importados/tg-iy-st8254b-1-0c0e96-480.webp', '/uploads/library/importados/tg-iy-st8254b-1-0c0e96-1024.webp', '/uploads/library/importados/tg-iy-st8254b-1-0c0e96-480.webp', 'tg-iy-st8254b-1', 'image/webp', 550, 746, 21412, NULL, 144
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-st8254b-1-0c0e96.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-wst8254b-1-f0d745.webp', '/uploads/library/importados/tg-iy-wst8254b-1-f0d745-480.webp', '/uploads/library/importados/tg-iy-wst8254b-1-f0d745-1024.webp', '/uploads/library/importados/tg-iy-wst8254b-1-f0d745-480.webp', 'tg-iy-wst8254b-1', 'image/webp', 618, 582, 13472, NULL, 145
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-wst8254b-1-f0d745.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-bs20025-1-6ef804.webp', '/uploads/library/importados/tg-ys-bs20025-1-6ef804-480.webp', '/uploads/library/importados/tg-ys-bs20025-1-6ef804-1024.webp', '/uploads/library/importados/tg-ys-bs20025-1-6ef804-480.webp', 'tg-ys-bs20025-1', 'image/webp', 1920, 1440, 111732, NULL, 146
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-bs20025-1-6ef804.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-bs20025-2-92feb0.webp', '/uploads/library/importados/tg-ys-bs20025-2-92feb0-480.webp', '/uploads/library/importados/tg-ys-bs20025-2-92feb0-1024.webp', '/uploads/library/importados/tg-ys-bs20025-2-92feb0-480.webp', 'tg-ys-bs20025-2', 'image/webp', 1920, 1440, 48442, NULL, 147
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-bs20025-2-92feb0.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-cg6510-1-4f80cc.webp', '/uploads/library/importados/tg-tg-cg6510-1-4f80cc-480.webp', '/uploads/library/importados/tg-tg-cg6510-1-4f80cc-1024.webp', '/uploads/library/importados/tg-tg-cg6510-1-4f80cc-480.webp', 'tg-tg-cg6510-1', 'image/webp', 1195, 896, 22146, NULL, 148
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-cg6510-1-4f80cc.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-tcg10-1-fb355a.webp', '/uploads/library/importados/tg-tg-tcg10-1-fb355a-480.webp', '/uploads/library/importados/tg-tg-tcg10-1-fb355a-1024.webp', '/uploads/library/importados/tg-tg-tcg10-1-fb355a-480.webp', 'tg-tg-tcg10-1', 'image/webp', 472, 354, 5584, NULL, 149
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-tcg10-1-fb355a.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-is70a-1-bcfe20.webp', '/uploads/library/importados/tg-ys-is70a-1-bcfe20-480.webp', '/uploads/library/importados/tg-ys-is70a-1-bcfe20-1024.webp', '/uploads/library/importados/tg-ys-is70a-1-bcfe20-480.webp', 'tg-ys-is70a-1', 'image/webp', 1000, 750, 30786, NULL, 150
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-is70a-1-bcfe20.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-is70a-2-ca31fe.webp', '/uploads/library/importados/tg-ys-is70a-2-ca31fe-480.webp', '/uploads/library/importados/tg-ys-is70a-2-ca31fe-1024.webp', '/uploads/library/importados/tg-ys-is70a-2-ca31fe-480.webp', 'tg-ys-is70a-2', 'image/webp', 1000, 750, 50056, NULL, 151
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-is70a-2-ca31fe.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-is70a-3-27d84a.webp', '/uploads/library/importados/tg-ys-is70a-3-27d84a-480.webp', '/uploads/library/importados/tg-ys-is70a-3-27d84a-1024.webp', '/uploads/library/importados/tg-ys-is70a-3-27d84a-480.webp', 'tg-ys-is70a-3', 'image/webp', 1000, 750, 41628, NULL, 152
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-is70a-3-27d84a.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-s160b-1-26bb4c.webp', '/uploads/library/importados/tg-ys-s160b-1-26bb4c-480.webp', '/uploads/library/importados/tg-ys-s160b-1-26bb4c-1024.webp', '/uploads/library/importados/tg-ys-s160b-1-26bb4c-480.webp', 'tg-ys-s160b-1', 'image/webp', 1000, 750, 21016, NULL, 153
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-s160b-1-26bb4c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-s160b-2-de6274.webp', '/uploads/library/importados/tg-ys-s160b-2-de6274-480.webp', '/uploads/library/importados/tg-ys-s160b-2-de6274-1024.webp', '/uploads/library/importados/tg-ys-s160b-2-de6274-480.webp', 'tg-ys-s160b-2', 'image/webp', 1000, 750, 25374, NULL, 154
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-s160b-2-de6274.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-is1110-1-9e6e34.webp', '/uploads/library/importados/tg-ys-is1110-1-9e6e34-480.webp', '/uploads/library/importados/tg-ys-is1110-1-9e6e34-1024.webp', '/uploads/library/importados/tg-ys-is1110-1-9e6e34-480.webp', 'tg-ys-is1110-1', 'image/webp', 439, 249, 11542, NULL, 155
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-is1110-1-9e6e34.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-k160b-1-2f6a26.webp', '/uploads/library/importados/tg-ys-k160b-1-2f6a26-480.webp', '/uploads/library/importados/tg-ys-k160b-1-2f6a26-1024.webp', '/uploads/library/importados/tg-ys-k160b-1-2f6a26-480.webp', 'tg-ys-k160b-1', 'image/webp', 1000, 750, 28554, NULL, 156
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-k160b-1-2f6a26.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-k160b-2-3cb34a.webp', '/uploads/library/importados/tg-ys-k160b-2-3cb34a-480.webp', '/uploads/library/importados/tg-ys-k160b-2-3cb34a-1024.webp', '/uploads/library/importados/tg-ys-k160b-2-3cb34a-480.webp', 'tg-ys-k160b-2', 'image/webp', 1000, 750, 33900, NULL, 157
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-k160b-2-3cb34a.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-wset5-1-ee5d89.webp', '/uploads/library/importados/tg-ys-wset5-1-ee5d89-480.webp', '/uploads/library/importados/tg-ys-wset5-1-ee5d89-1024.webp', '/uploads/library/importados/tg-ys-wset5-1-ee5d89-480.webp', 'tg-ys-wset5-1', 'image/webp', 1000, 750, 54092, NULL, 158
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-wset5-1-ee5d89.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-wset6-1-e419ea.webp', '/uploads/library/importados/tg-ys-wset6-1-e419ea-480.webp', '/uploads/library/importados/tg-ys-wset6-1-e419ea-1024.webp', '/uploads/library/importados/tg-ys-wset6-1-e419ea-480.webp', 'tg-ys-wset6-1', 'image/webp', 1000, 750, 53868, NULL, 159
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-wset6-1-e419ea.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-wset6n-1-518c69.webp', '/uploads/library/importados/tg-ys-wset6n-1-518c69-480.webp', '/uploads/library/importados/tg-ys-wset6n-1-518c69-1024.webp', '/uploads/library/importados/tg-ys-wset6n-1-518c69-480.webp', 'tg-ys-wset6n-1', 'image/webp', 1000, 750, 63090, NULL, 160
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-wset6n-1-518c69.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-wset5n-1-f228ae.webp', '/uploads/library/importados/tg-ys-wset5n-1-f228ae-480.webp', '/uploads/library/importados/tg-ys-wset5n-1-f228ae-1024.webp', '/uploads/library/importados/tg-ys-wset5n-1-f228ae-480.webp', 'tg-ys-wset5n-1', 'image/webp', 1000, 750, 68824, NULL, 161
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-wset5n-1-f228ae.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-f160b-1-ee5ef8.webp', '/uploads/library/importados/tg-ys-f160b-1-ee5ef8-480.webp', '/uploads/library/importados/tg-ys-f160b-1-ee5ef8-1024.webp', '/uploads/library/importados/tg-ys-f160b-1-ee5ef8-480.webp', 'tg-ys-f160b-1', 'image/webp', 1000, 750, 20174, NULL, 162
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-f160b-1-ee5ef8.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-f160b-2-3600e6.webp', '/uploads/library/importados/tg-ys-f160b-2-3600e6-480.webp', '/uploads/library/importados/tg-ys-f160b-2-3600e6-1024.webp', '/uploads/library/importados/tg-ys-f160b-2-3600e6-480.webp', 'tg-ys-f160b-2', 'image/webp', 1000, 750, 25120, NULL, 163
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-f160b-2-3600e6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ys-f160b-3-43830a.webp', '/uploads/library/importados/tg-ys-f160b-3-43830a-480.webp', '/uploads/library/importados/tg-ys-f160b-3-43830a-1024.webp', '/uploads/library/importados/tg-ys-f160b-3-43830a-480.webp', 'tg-ys-f160b-3', 'image/webp', 1000, 750, 26732, NULL, 164
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ys-f160b-3-43830a.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-gh-gwt009tu-1-789d4b.webp', '/uploads/library/importados/tg-gh-gwt009tu-1-789d4b-480.webp', '/uploads/library/importados/tg-gh-gwt009tu-1-789d4b-1024.webp', '/uploads/library/importados/tg-gh-gwt009tu-1-789d4b-480.webp', 'tg-gh-gwt009tu-1', 'image/webp', 960, 720, 17250, NULL, 165
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-gh-gwt009tu-1-789d4b.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-gt-p011-1-9fba75.webp', '/uploads/library/importados/tg-gt-p011-1-9fba75-480.webp', '/uploads/library/importados/tg-gt-p011-1-9fba75-1024.webp', '/uploads/library/importados/tg-gt-p011-1-9fba75-480.webp', 'tg-gt-p011-1', 'image/webp', 869, 720, 15980, NULL, 166
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-gt-p011-1-9fba75.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-gt-p012-1-84d95e.webp', '/uploads/library/importados/tg-gt-p012-1-84d95e-480.webp', '/uploads/library/importados/tg-gt-p012-1-84d95e-1024.webp', '/uploads/library/importados/tg-gt-p012-1-84d95e-480.webp', 'tg-gt-p012-1', 'image/webp', 869, 720, 13004, NULL, 167
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-gt-p012-1-84d95e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-gt-p013-1-59638d.webp', '/uploads/library/importados/tg-gt-p013-1-59638d-480.webp', '/uploads/library/importados/tg-gt-p013-1-59638d-1024.webp', '/uploads/library/importados/tg-gt-p013-1-59638d-480.webp', 'tg-gt-p013-1', 'image/webp', 869, 720, 15980, NULL, 168
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-gt-p013-1-59638d.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-gt-p007-1-41b0c5.webp', '/uploads/library/importados/tg-gt-p007-1-41b0c5-480.webp', '/uploads/library/importados/tg-gt-p007-1-41b0c5-1024.webp', '/uploads/library/importados/tg-gt-p007-1-41b0c5-480.webp', 'tg-gt-p007-1', 'image/webp', 869, 720, 13004, NULL, 169
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-gt-p007-1-41b0c5.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-gt-p005-1-3533dd.webp', '/uploads/library/importados/tg-gt-p005-1-3533dd-480.webp', '/uploads/library/importados/tg-gt-p005-1-3533dd-1024.webp', '/uploads/library/importados/tg-gt-p005-1-3533dd-480.webp', 'tg-gt-p005-1', 'image/webp', 869, 720, 15980, NULL, 170
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-gt-p005-1-3533dd.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pb26pp3d-1-01d004.webp', '/uploads/library/importados/tg-tg-pb26pp3d-1-01d004-480.webp', '/uploads/library/importados/tg-tg-pb26pp3d-1-01d004-1024.webp', '/uploads/library/importados/tg-tg-pb26pp3d-1-01d004-480.webp', 'tg-tg-pb26pp3d-1', 'image/webp', 762, 589, 5680, NULL, 171
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pb26pp3d-1-01d004.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pb26pp3d-2-bc04da.webp', '/uploads/library/importados/tg-tg-pb26pp3d-2-bc04da-480.webp', '/uploads/library/importados/tg-tg-pb26pp3d-2-bc04da-1024.webp', '/uploads/library/importados/tg-tg-pb26pp3d-2-bc04da-480.webp', 'tg-tg-pb26pp3d-2', 'image/webp', 874, 609, 9746, NULL, 172
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pb26pp3d-2-bc04da.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-fb-se23x23-tg-1-d66490.webp', '/uploads/library/importados/tg-fb-se23x23-tg-1-d66490-480.webp', '/uploads/library/importados/tg-fb-se23x23-tg-1-d66490-1024.webp', '/uploads/library/importados/tg-fb-se23x23-tg-1-d66490-480.webp', 'tg-fb-se23x23-tg-1', 'image/webp', 661, 498, 21082, NULL, 173
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-fb-se23x23-tg-1-d66490.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-fb-se30x30-tg-1-55ab60.webp', '/uploads/library/importados/tg-fb-se30x30-tg-1-55ab60-480.webp', '/uploads/library/importados/tg-fb-se30x30-tg-1-55ab60-1024.webp', '/uploads/library/importados/tg-fb-se30x30-tg-1-55ab60-480.webp', 'tg-fb-se30x30-tg-1', 'image/webp', 661, 498, 21082, NULL, 174
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-fb-se30x30-tg-1-55ab60.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-sel1414-1-d44479.webp', '/uploads/library/importados/tg-tg-sel1414-1-d44479-480.webp', '/uploads/library/importados/tg-tg-sel1414-1-d44479-1024.webp', '/uploads/library/importados/tg-tg-sel1414-1-d44479-480.webp', 'tg-tg-sel1414-1', 'image/webp', 495, 515, 21592, NULL, 175
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-sel1414-1-d44479.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-so16r-1-f2e922.webp', '/uploads/library/importados/tg-tg-so16r-1-f2e922-480.webp', '/uploads/library/importados/tg-tg-so16r-1-f2e922-1024.webp', '/uploads/library/importados/tg-tg-so16r-1-f2e922-480.webp', 'tg-tg-so16r-1', 'image/webp', 1044, 1044, 12646, NULL, 176
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-so16r-1-f2e922.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-so16r-2-b67d24.webp', '/uploads/library/importados/tg-tg-so16r-2-b67d24-480.webp', '/uploads/library/importados/tg-tg-so16r-2-b67d24-1024.webp', '/uploads/library/importados/tg-tg-so16r-2-b67d24-480.webp', 'tg-tg-so16r-2', 'image/webp', 1054, 1054, 12508, NULL, 177
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-so16r-2-b67d24.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-so16r-3-416f1b.webp', '/uploads/library/importados/tg-tg-so16r-3-416f1b-480.webp', '/uploads/library/importados/tg-tg-so16r-3-416f1b-1024.webp', '/uploads/library/importados/tg-tg-so16r-3-416f1b-480.webp', 'tg-tg-so16r-3', 'image/webp', 822, 822, 16948, NULL, 178
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-so16r-3-416f1b.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-inr-vrec12-1-56b527.webp', '/uploads/library/importados/tg-inr-vrec12-1-56b527-480.webp', '/uploads/library/importados/tg-inr-vrec12-1-56b527-1024.webp', '/uploads/library/importados/tg-inr-vrec12-1-56b527-480.webp', 'tg-inr-vrec12-1', 'image/webp', 1080, 1080, 4676, NULL, 179
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-inr-vrec12-1-56b527.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-sn-petpci4-1-cd6dc6.webp', '/uploads/library/importados/tg-sn-petpci4-1-cd6dc6-480.webp', '/uploads/library/importados/tg-sn-petpci4-1-cd6dc6-1024.webp', '/uploads/library/importados/tg-sn-petpci4-1-cd6dc6-480.webp', 'tg-sn-petpci4-1', 'image/webp', 704, 704, 80688, NULL, 180
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-sn-petpci4-1-cd6dc6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-sn-placi4-1-3a38e7.webp', '/uploads/library/importados/tg-sn-placi4-1-3a38e7-480.webp', '/uploads/library/importados/tg-sn-placi4-1-3a38e7-1024.webp', '/uploads/library/importados/tg-sn-placi4-1-3a38e7-480.webp', 'tg-sn-placi4-1', 'image/webp', 666, 666, 52890, NULL, 181
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-sn-placi4-1-3a38e7.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-sn-petci98-1-c7e004.webp', '/uploads/library/importados/tg-sn-petci98-1-c7e004-480.webp', '/uploads/library/importados/tg-sn-petci98-1-c7e004-1024.webp', '/uploads/library/importados/tg-sn-petci98-1-c7e004-480.webp', 'tg-sn-petci98-1', 'image/webp', 908, 908, 98522, NULL, 182
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-sn-petci98-1-c7e004.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-sn-placi98-1-3abdad.webp', '/uploads/library/importados/tg-sn-placi98-1-3abdad-480.webp', '/uploads/library/importados/tg-sn-placi98-1-3abdad-1024.webp', '/uploads/library/importados/tg-sn-placi98-1-3abdad-480.webp', 'tg-sn-placi98-1', 'image/webp', 908, 908, 98522, NULL, 183
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-sn-placi98-1-3abdad.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-lsdpet1024-1-5c17ec.webp', '/uploads/library/importados/tg-iy-lsdpet1024-1-5c17ec-480.webp', '/uploads/library/importados/tg-iy-lsdpet1024-1-5c17ec-1024.webp', '/uploads/library/importados/tg-iy-lsdpet1024-1-5c17ec-480.webp', 'tg-iy-lsdpet1024-1', 'image/webp', 433, 577, 9348, NULL, 184
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-lsdpet1024-1-5c17ec.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-lsdpet1024-2-3cc542.webp', '/uploads/library/importados/tg-iy-lsdpet1024-2-3cc542-480.webp', '/uploads/library/importados/tg-iy-lsdpet1024-2-3cc542-1024.webp', '/uploads/library/importados/tg-iy-lsdpet1024-2-3cc542-480.webp', 'tg-iy-lsdpet1024-2', 'image/webp', 375, 666, 15950, NULL, 185
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-lsdpet1024-2-3cc542.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-lsdpet1024-3-13a697.webp', '/uploads/library/importados/tg-iy-lsdpet1024-3-13a697-480.webp', '/uploads/library/importados/tg-iy-lsdpet1024-3-13a697-1024.webp', '/uploads/library/importados/tg-iy-lsdpet1024-3-13a697-480.webp', 'tg-iy-lsdpet1024-3', 'image/webp', 577, 433, 15886, NULL, 186
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-lsdpet1024-3-13a697.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-lbg1220-1-41ee88.webp', '/uploads/library/importados/tg-hl-lbg1220-1-41ee88-480.webp', '/uploads/library/importados/tg-hl-lbg1220-1-41ee88-1024.webp', '/uploads/library/importados/tg-hl-lbg1220-1-41ee88-480.webp', 'tg-hl-lbg1220-1', 'image/webp', 1440, 1920, 68366, NULL, 187
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-lbg1220-1-41ee88.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-lbg1220-2-f6e320.webp', '/uploads/library/importados/tg-hl-lbg1220-2-f6e320-480.webp', '/uploads/library/importados/tg-hl-lbg1220-2-f6e320-1024.webp', '/uploads/library/importados/tg-hl-lbg1220-2-f6e320-480.webp', 'tg-hl-lbg1220-2', 'image/webp', 1920, 1440, 55102, NULL, 188
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-lbg1220-2-f6e320.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-lbg1220-3-9efd5b.webp', '/uploads/library/importados/tg-hl-lbg1220-3-9efd5b-480.webp', '/uploads/library/importados/tg-hl-lbg1220-3-9efd5b-1024.webp', '/uploads/library/importados/tg-hl-lbg1220-3-9efd5b-480.webp', 'tg-hl-lbg1220-3', 'image/webp', 1440, 1920, 87532, NULL, 189
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-lbg1220-3-9efd5b.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-lbg08-1-7306b6.webp', '/uploads/library/importados/tg-hl-lbg08-1-7306b6-480.webp', '/uploads/library/importados/tg-hl-lbg08-1-7306b6-1024.webp', '/uploads/library/importados/tg-hl-lbg08-1-7306b6-480.webp', 'tg-hl-lbg08-1', 'image/webp', 1440, 1920, 68366, NULL, 190
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-lbg08-1-7306b6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-lbg08-2-fab5a3.webp', '/uploads/library/importados/tg-hl-lbg08-2-fab5a3-480.webp', '/uploads/library/importados/tg-hl-lbg08-2-fab5a3-1024.webp', '/uploads/library/importados/tg-hl-lbg08-2-fab5a3-480.webp', 'tg-hl-lbg08-2', 'image/webp', 1920, 1440, 55102, NULL, 191
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-lbg08-2-fab5a3.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-lbg08-3-ddf019.webp', '/uploads/library/importados/tg-hl-lbg08-3-ddf019-480.webp', '/uploads/library/importados/tg-hl-lbg08-3-ddf019-1024.webp', '/uploads/library/importados/tg-hl-lbg08-3-ddf019-480.webp', 'tg-hl-lbg08-3', 'image/webp', 1440, 1920, 87532, NULL, 192
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-lbg08-3-ddf019.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-wblstfw1220-1-486c29.webp', '/uploads/library/importados/tg-hl-wblstfw1220-1-486c29-480.webp', '/uploads/library/importados/tg-hl-wblstfw1220-1-486c29-1024.webp', '/uploads/library/importados/tg-hl-wblstfw1220-1-486c29-480.webp', 'tg-hl-wblstfw1220-1', 'image/webp', 1440, 1920, 55068, NULL, 193
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-wblstfw1220-1-486c29.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-wblstfw1220-2-8c5646.webp', '/uploads/library/importados/tg-hl-wblstfw1220-2-8c5646-480.webp', '/uploads/library/importados/tg-hl-wblstfw1220-2-8c5646-1024.webp', '/uploads/library/importados/tg-hl-wblstfw1220-2-8c5646-480.webp', 'tg-hl-wblstfw1220-2', 'image/webp', 1440, 1920, 54788, NULL, 194
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-wblstfw1220-2-8c5646.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-wblstfw08-1-b62097.webp', '/uploads/library/importados/tg-hl-wblstfw08-1-b62097-480.webp', '/uploads/library/importados/tg-hl-wblstfw08-1-b62097-1024.webp', '/uploads/library/importados/tg-hl-wblstfw08-1-b62097-480.webp', 'tg-hl-wblstfw08-1', 'image/webp', 1440, 1920, 55068, NULL, 195
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-wblstfw08-1-b62097.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-hl-wblstfw08-2-e5bc78.webp', '/uploads/library/importados/tg-hl-wblstfw08-2-e5bc78-480.webp', '/uploads/library/importados/tg-hl-wblstfw08-2-e5bc78-1024.webp', '/uploads/library/importados/tg-hl-wblstfw08-2-e5bc78-480.webp', 'tg-hl-wblstfw08-2', 'image/webp', 1440, 1920, 54788, NULL, 196
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-hl-wblstfw08-2-e5bc78.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc222815-1-98ca9f.webp', '/uploads/library/importados/tg-cm-dc222815-1-98ca9f-480.webp', '/uploads/library/importados/tg-cm-dc222815-1-98ca9f-1024.webp', '/uploads/library/importados/tg-cm-dc222815-1-98ca9f-480.webp', 'tg-cm-dc222815-1', 'image/webp', 640, 640, 18772, NULL, 197
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc222815-1-98ca9f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc222815-2-3058ba.webp', '/uploads/library/importados/tg-cm-dc222815-2-3058ba-480.webp', '/uploads/library/importados/tg-cm-dc222815-2-3058ba-1024.webp', '/uploads/library/importados/tg-cm-dc222815-2-3058ba-480.webp', 'tg-cm-dc222815-2', 'image/webp', 579, 522, 9230, NULL, 198
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc222815-2-3058ba.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc223615-1-ff3d56.webp', '/uploads/library/importados/tg-cm-dc223615-1-ff3d56-480.webp', '/uploads/library/importados/tg-cm-dc223615-1-ff3d56-1024.webp', '/uploads/library/importados/tg-cm-dc223615-1-ff3d56-480.webp', 'tg-cm-dc223615-1', 'image/webp', 640, 640, 18772, NULL, 199
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc223615-1-ff3d56.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc223615-2-1cb266.webp', '/uploads/library/importados/tg-cm-dc223615-2-1cb266-480.webp', '/uploads/library/importados/tg-cm-dc223615-2-1cb266-1024.webp', '/uploads/library/importados/tg-cm-dc223615-2-1cb266-480.webp', 'tg-cm-dc223615-2', 'image/webp', 579, 522, 9230, NULL, 200
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc223615-2-1cb266.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc224115-1-445609.webp', '/uploads/library/importados/tg-cm-dc224115-1-445609-480.webp', '/uploads/library/importados/tg-cm-dc224115-1-445609-1024.webp', '/uploads/library/importados/tg-cm-dc224115-1-445609-480.webp', 'tg-cm-dc224115-1', 'image/webp', 640, 640, 18772, NULL, 201
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc224115-1-445609.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-dc224115-2-ec2d82.webp', '/uploads/library/importados/tg-cm-dc224115-2-ec2d82-480.webp', '/uploads/library/importados/tg-cm-dc224115-2-ec2d82-1024.webp', '/uploads/library/importados/tg-cm-dc224115-2-ec2d82-480.webp', 'tg-cm-dc224115-2', 'image/webp', 579, 522, 9230, NULL, 202
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-dc224115-2-ec2d82.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t100-1-f2e117.webp', '/uploads/library/importados/tg-cm-t100-1-f2e117-480.webp', '/uploads/library/importados/tg-cm-t100-1-f2e117-1024.webp', '/uploads/library/importados/tg-cm-t100-1-f2e117-480.webp', 'tg-cm-t100-1', 'image/webp', 584, 416, 15450, NULL, 203
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t100-1-f2e117.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t200-1-38d67d.webp', '/uploads/library/importados/tg-cm-t200-1-38d67d-480.webp', '/uploads/library/importados/tg-cm-t200-1-38d67d-1024.webp', '/uploads/library/importados/tg-cm-t200-1-38d67d-480.webp', 'tg-cm-t200-1', 'image/webp', 584, 416, 14672, NULL, 204
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t200-1-38d67d.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t300-1-f7c5c6.webp', '/uploads/library/importados/tg-cm-t300-1-f7c5c6-480.webp', '/uploads/library/importados/tg-cm-t300-1-f7c5c6-1024.webp', '/uploads/library/importados/tg-cm-t300-1-f7c5c6-480.webp', 'tg-cm-t300-1', 'image/webp', 584, 416, 14672, NULL, 205
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t300-1-f7c5c6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t400-1-1ea243.webp', '/uploads/library/importados/tg-cm-t400-1-1ea243-480.webp', '/uploads/library/importados/tg-cm-t400-1-1ea243-1024.webp', '/uploads/library/importados/tg-cm-t400-1-1ea243-480.webp', 'tg-cm-t400-1', 'image/webp', 584, 416, 14672, NULL, 206
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t400-1-1ea243.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t500-1-15ce36.webp', '/uploads/library/importados/tg-cm-t500-1-15ce36-480.webp', '/uploads/library/importados/tg-cm-t500-1-15ce36-1024.webp', '/uploads/library/importados/tg-cm-t500-1-15ce36-480.webp', 'tg-cm-t500-1', 'image/webp', 584, 416, 14672, NULL, 207
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t500-1-15ce36.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cm-t600-1-04f51f.webp', '/uploads/library/importados/tg-cm-t600-1-04f51f-480.webp', '/uploads/library/importados/tg-cm-t600-1-04f51f-1024.webp', '/uploads/library/importados/tg-cm-t600-1-04f51f-480.webp', 'tg-cm-t600-1', 'image/webp', 584, 416, 14672, NULL, 208
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cm-t600-1-04f51f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-sl12-16-1-62a03e.webp', '/uploads/library/importados/tg-iy-sl12-16-1-62a03e-480.webp', '/uploads/library/importados/tg-iy-sl12-16-1-62a03e-1024.webp', '/uploads/library/importados/tg-iy-sl12-16-1-62a03e-480.webp', 'tg-iy-sl12-16-1', 'image/webp', 603, 447, 20842, NULL, 209
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-sl12-16-1-62a03e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-sl12-20-1-ffb2eb.webp', '/uploads/library/importados/tg-tg-sl12-20-1-ffb2eb-480.webp', '/uploads/library/importados/tg-tg-sl12-20-1-ffb2eb-1024.webp', '/uploads/library/importados/tg-tg-sl12-20-1-ffb2eb-480.webp', 'tg-tg-sl12-20-1', 'image/webp', 603, 447, 22002, NULL, 210
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-sl12-20-1-ffb2eb.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-sl08-10-1-522db7.webp', '/uploads/library/importados/tg-tg-sl08-10-1-522db7-480.webp', '/uploads/library/importados/tg-tg-sl08-10-1-522db7-1024.webp', '/uploads/library/importados/tg-tg-sl08-10-1-522db7-480.webp', 'tg-tg-sl08-10-1', 'image/webp', 603, 447, 22002, NULL, 211
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-sl08-10-1-522db7.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-iy-sl08-1-4aef97.webp', '/uploads/library/importados/tg-iy-sl08-1-4aef97-480.webp', '/uploads/library/importados/tg-iy-sl08-1-4aef97-1024.webp', '/uploads/library/importados/tg-iy-sl08-1-4aef97-480.webp', 'tg-iy-sl08-1', 'image/webp', 603, 447, 20842, NULL, 212
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-iy-sl08-1-4aef97.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-cip-cf28300-1-4edb3c.webp', '/uploads/library/importados/tg-cip-cf28300-1-4edb3c-480.webp', '/uploads/library/importados/tg-cip-cf28300-1-4edb3c-1024.webp', '/uploads/library/importados/tg-cip-cf28300-1-4edb3c-480.webp', 'tg-cip-cf28300-1', 'image/webp', 1031, 593, 32076, NULL, 213
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-cip-cf28300-1-4edb3c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pvfe301400-1-bb69f8.webp', '/uploads/library/importados/tg-tg-pvfe301400-1-bb69f8-480.webp', '/uploads/library/importados/tg-tg-pvfe301400-1-bb69f8-1024.webp', '/uploads/library/importados/tg-tg-pvfe301400-1-bb69f8-480.webp', 'tg-tg-pvfe301400-1', 'image/webp', 1528, 1528, 38274, NULL, 214
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pvfe301400-1-bb69f8.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pvfe301400-2-571812.webp', '/uploads/library/importados/tg-tg-pvfe301400-2-571812-480.webp', '/uploads/library/importados/tg-tg-pvfe301400-2-571812-1024.webp', '/uploads/library/importados/tg-tg-pvfe301400-2-571812-480.webp', 'tg-tg-pvfe301400-2', 'image/webp', 1528, 1528, 53032, NULL, 215
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pvfe301400-2-571812.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pvfe381400-1-793132.webp', '/uploads/library/importados/tg-tg-pvfe381400-1-793132-480.webp', '/uploads/library/importados/tg-tg-pvfe381400-1-793132-1024.webp', '/uploads/library/importados/tg-tg-pvfe381400-1-793132-480.webp', 'tg-tg-pvfe381400-1', 'image/webp', 1528, 1528, 37224, NULL, 216
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pvfe381400-1-793132.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pvfe381400-2-5de8d4.webp', '/uploads/library/importados/tg-tg-pvfe381400-2-5de8d4-480.webp', '/uploads/library/importados/tg-tg-pvfe381400-2-5de8d4-1024.webp', '/uploads/library/importados/tg-tg-pvfe381400-2-5de8d4-480.webp', 'tg-tg-pvfe381400-2', 'image/webp', 1528, 1528, 57740, NULL, 217
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pvfe381400-2-5de8d4.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pvfe451400-1-86bcce.webp', '/uploads/library/importados/tg-tg-pvfe451400-1-86bcce-480.webp', '/uploads/library/importados/tg-tg-pvfe451400-1-86bcce-1024.webp', '/uploads/library/importados/tg-tg-pvfe451400-1-86bcce-480.webp', 'tg-tg-pvfe451400-1', 'image/webp', 1800, 1800, 103244, NULL, 218
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pvfe451400-1-86bcce.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-pvfe451400-2-ed2ca0.webp', '/uploads/library/importados/tg-tg-pvfe451400-2-ed2ca0-480.webp', '/uploads/library/importados/tg-tg-pvfe451400-2-ed2ca0-1024.webp', '/uploads/library/importados/tg-tg-pvfe451400-2-ed2ca0-480.webp', 'tg-tg-pvfe451400-2', 'image/webp', 1528, 1528, 43490, NULL, 219
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-pvfe451400-2-ed2ca0.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ly-al300100-1-0379f5.webp', '/uploads/library/importados/tg-ly-al300100-1-0379f5-480.webp', '/uploads/library/importados/tg-ly-al300100-1-0379f5-1024.webp', '/uploads/library/importados/tg-ly-al300100-1-0379f5-480.webp', 'tg-ly-al300100-1', 'image/webp', 627, 443, 8160, NULL, 220
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ly-al300100-1-0379f5.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-int10000035e-1-2cc720.webp', '/uploads/library/importados/tg-ic-int10000035e-1-2cc720-480.webp', '/uploads/library/importados/tg-ic-int10000035e-1-2cc720-1024.webp', '/uploads/library/importados/tg-ic-int10000035e-1-2cc720-480.webp', 'tg-ic-int10000035e-1', 'image/webp', 1080, 1080, 86804, NULL, 221
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-int10000035e-1-2cc720.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-int10000037e-1-b4ee14.webp', '/uploads/library/importados/tg-ic-int10000037e-1-b4ee14-480.webp', '/uploads/library/importados/tg-ic-int10000037e-1-b4ee14-1024.webp', '/uploads/library/importados/tg-ic-int10000037e-1-b4ee14-480.webp', 'tg-ic-int10000037e-1', 'image/webp', 1080, 1080, 107412, NULL, 222
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-int10000037e-1-b4ee14.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-int10000036e-1-5243a6.webp', '/uploads/library/importados/tg-ic-int10000036e-1-5243a6-480.webp', '/uploads/library/importados/tg-ic-int10000036e-1-5243a6-1024.webp', '/uploads/library/importados/tg-ic-int10000036e-1-5243a6-480.webp', 'tg-ic-int10000036e-1', 'image/webp', 1080, 1080, 101496, NULL, 223
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-int10000036e-1-5243a6.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-int50006-1-34bf3e.webp', '/uploads/library/importados/tg-ic-int50006-1-34bf3e-480.webp', '/uploads/library/importados/tg-ic-int50006-1-34bf3e-1024.webp', '/uploads/library/importados/tg-ic-int50006-1-34bf3e-480.webp', 'tg-ic-int50006-1', 'image/webp', 1000, 1000, 24016, NULL, 224
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-int50006-1-34bf3e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-int50006-2-be96b5.webp', '/uploads/library/importados/tg-ic-int50006-2-be96b5-480.webp', '/uploads/library/importados/tg-ic-int50006-2-be96b5-1024.webp', '/uploads/library/importados/tg-ic-int50006-2-be96b5-480.webp', 'tg-ic-int50006-2', 'image/webp', 1000, 1000, 14862, NULL, 225
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-int50006-2-be96b5.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-int50006-3-294106.webp', '/uploads/library/importados/tg-ic-int50006-3-294106-480.webp', '/uploads/library/importados/tg-ic-int50006-3-294106-1024.webp', '/uploads/library/importados/tg-ic-int50006-3-294106-480.webp', 'tg-ic-int50006-3', 'image/webp', 800, 812, 138908, NULL, 226
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-int50006-3-294106.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-pmb7000253e-1-4bffac.webp', '/uploads/library/importados/tg-ic-pmb7000253e-1-4bffac-480.webp', '/uploads/library/importados/tg-ic-pmb7000253e-1-4bffac-1024.webp', '/uploads/library/importados/tg-ic-pmb7000253e-1-4bffac-480.webp', 'tg-ic-pmb7000253e-1', 'image/webp', 1080, 1080, 98786, NULL, 227
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-pmb7000253e-1-4bffac.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-pmb10001-1-b33b36.webp', '/uploads/library/importados/tg-ic-pmb10001-1-b33b36-480.webp', '/uploads/library/importados/tg-ic-pmb10001-1-b33b36-1024.webp', '/uploads/library/importados/tg-ic-pmb10001-1-b33b36-480.webp', 'tg-ic-pmb10001-1', 'image/webp', 717, 717, 80482, NULL, 228
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-pmb10001-1-b33b36.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-pmb7000252e-1-c1ba7f.webp', '/uploads/library/importados/tg-ic-pmb7000252e-1-c1ba7f-480.webp', '/uploads/library/importados/tg-ic-pmb7000252e-1-c1ba7f-1024.webp', '/uploads/library/importados/tg-ic-pmb7000252e-1-c1ba7f-480.webp', 'tg-ic-pmb7000252e-1', 'image/webp', 1080, 1080, 116412, NULL, 229
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-pmb7000252e-1-c1ba7f.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-pmb7000251e-1-bd8664.webp', '/uploads/library/importados/tg-ic-pmb7000251e-1-bd8664-480.webp', '/uploads/library/importados/tg-ic-pmb7000251e-1-bd8664-1024.webp', '/uploads/library/importados/tg-ic-pmb7000251e-1-bd8664-480.webp', 'tg-ic-pmb7000251e-1', 'image/webp', 1080, 1080, 102032, NULL, 230
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-pmb7000251e-1-bd8664.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-ic-int50000-1-b1cf24.webp', '/uploads/library/importados/tg-ic-int50000-1-b1cf24-480.webp', '/uploads/library/importados/tg-ic-int50000-1-b1cf24-1024.webp', '/uploads/library/importados/tg-ic-int50000-1-b1cf24-480.webp', 'tg-ic-int50000-1', 'image/webp', 500, 500, 14372, NULL, 231
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-ic-int50000-1-b1cf24.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-ce47100-1-0939f3.webp', '/uploads/library/importados/tg-tg-ce47100-1-0939f3-480.webp', '/uploads/library/importados/tg-tg-ce47100-1-0939f3-1024.webp', '/uploads/library/importados/tg-tg-ce47100-1-0939f3-480.webp', 'tg-tg-ce47100-1', 'image/webp', 410, 375, 8478, NULL, 232
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-ce47100-1-0939f3.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-ce75100-1-a3814c.webp', '/uploads/library/importados/tg-tg-ce75100-1-a3814c-480.webp', '/uploads/library/importados/tg-tg-ce75100-1-a3814c-1024.webp', '/uploads/library/importados/tg-tg-ce75100-1-a3814c-480.webp', 'tg-tg-ce75100-1', 'image/webp', 488, 469, 8728, NULL, 233
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-ce75100-1-a3814c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpa15-1-11b945.webp', '/uploads/library/importados/tg-tg-fpa15-1-11b945-480.webp', '/uploads/library/importados/tg-tg-fpa15-1-11b945-1024.webp', '/uploads/library/importados/tg-tg-fpa15-1-11b945-480.webp', 'tg-tg-fpa15-1', 'image/webp', 650, 618, 16414, NULL, 234
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpa15-1-11b945.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm217-1-cfa455.webp', '/uploads/library/importados/tg-tg-fpm217-1-cfa455-480.webp', '/uploads/library/importados/tg-tg-fpm217-1-cfa455-1024.webp', '/uploads/library/importados/tg-tg-fpm217-1-cfa455-480.webp', 'tg-tg-fpm217-1', 'image/webp', 869, 720, 31390, NULL, 235
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm217-1-cfa455.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm217-2-2e68f8.webp', '/uploads/library/importados/tg-tg-fpm217-2-2e68f8-480.webp', '/uploads/library/importados/tg-tg-fpm217-2-2e68f8-1024.webp', '/uploads/library/importados/tg-tg-fpm217-2-2e68f8-480.webp', 'tg-tg-fpm217-2', 'image/webp', 542, 504, 1872, NULL, 236
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm217-2-2e68f8.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm2-1-57d50d.webp', '/uploads/library/importados/tg-tg-fpm2-1-57d50d-480.webp', '/uploads/library/importados/tg-tg-fpm2-1-57d50d-1024.webp', '/uploads/library/importados/tg-tg-fpm2-1-57d50d-480.webp', 'tg-tg-fpm2-1', 'image/webp', 869, 720, 31390, NULL, 237
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm2-1-57d50d.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm2-2-d070e8.webp', '/uploads/library/importados/tg-tg-fpm2-2-d070e8-480.webp', '/uploads/library/importados/tg-tg-fpm2-2-d070e8-1024.webp', '/uploads/library/importados/tg-tg-fpm2-2-d070e8-480.webp', 'tg-tg-fpm2-2', 'image/webp', 629, 632, 3090, NULL, 238
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm2-2-d070e8.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm2n-1-84e06e.webp', '/uploads/library/importados/tg-tg-fpm2n-1-84e06e-480.webp', '/uploads/library/importados/tg-tg-fpm2n-1-84e06e-1024.webp', '/uploads/library/importados/tg-tg-fpm2n-1-84e06e-480.webp', 'tg-tg-fpm2n-1', 'image/webp', 1528, 1528, 35164, NULL, 239
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm2n-1-84e06e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm2n-2-55d93e.webp', '/uploads/library/importados/tg-tg-fpm2n-2-55d93e-480.webp', '/uploads/library/importados/tg-tg-fpm2n-2-55d93e-1024.webp', '/uploads/library/importados/tg-tg-fpm2n-2-55d93e-480.webp', 'tg-tg-fpm2n-2', 'image/webp', 1528, 1528, 15082, NULL, 240
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm2n-2-55d93e.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm2n-3-1b5216.webp', '/uploads/library/importados/tg-tg-fpm2n-3-1b5216-480.webp', '/uploads/library/importados/tg-tg-fpm2n-3-1b5216-1024.webp', '/uploads/library/importados/tg-tg-fpm2n-3-1b5216-480.webp', 'tg-tg-fpm2n-3', 'image/webp', 1528, 1528, 21214, NULL, 241
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm2n-3-1b5216.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpmper2-1-2b22de.webp', '/uploads/library/importados/tg-tg-fpmper2-1-2b22de-480.webp', '/uploads/library/importados/tg-tg-fpmper2-1-2b22de-1024.webp', '/uploads/library/importados/tg-tg-fpmper2-1-2b22de-480.webp', 'tg-tg-fpmper2-1', 'image/webp', 1528, 1528, 32242, NULL, 242
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpmper2-1-2b22de.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpmper2-2-6f31b3.webp', '/uploads/library/importados/tg-tg-fpmper2-2-6f31b3-480.webp', '/uploads/library/importados/tg-tg-fpmper2-2-6f31b3-1024.webp', '/uploads/library/importados/tg-tg-fpmper2-2-6f31b3-480.webp', 'tg-tg-fpmper2-2', 'image/webp', 1528, 1528, 22800, NULL, 243
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpmper2-2-6f31b3.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpmper2-3-04018a.webp', '/uploads/library/importados/tg-tg-fpmper2-3-04018a-480.webp', '/uploads/library/importados/tg-tg-fpmper2-3-04018a-1024.webp', '/uploads/library/importados/tg-tg-fpmper2-3-04018a-480.webp', 'tg-tg-fpmper2-3', 'image/webp', 1528, 1528, 16368, NULL, 244
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpmper2-3-04018a.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm2r-1-9d875c.webp', '/uploads/library/importados/tg-tg-fpm2r-1-9d875c-480.webp', '/uploads/library/importados/tg-tg-fpm2r-1-9d875c-1024.webp', '/uploads/library/importados/tg-tg-fpm2r-1-9d875c-480.webp', 'tg-tg-fpm2r-1', 'image/webp', 1528, 1528, 43290, NULL, 245
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm2r-1-9d875c.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm2r-2-39f326.webp', '/uploads/library/importados/tg-tg-fpm2r-2-39f326-480.webp', '/uploads/library/importados/tg-tg-fpm2r-2-39f326-1024.webp', '/uploads/library/importados/tg-tg-fpm2r-2-39f326-480.webp', 'tg-tg-fpm2r-2', 'image/webp', 1528, 1528, 24278, NULL, 246
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm2r-2-39f326.webp');
INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)
  SELECT '/uploads/library/importados/tg-tg-fpm2r-3-16aff8.webp', '/uploads/library/importados/tg-tg-fpm2r-3-16aff8-480.webp', '/uploads/library/importados/tg-tg-fpm2r-3-16aff8-1024.webp', '/uploads/library/importados/tg-tg-fpm2r-3-16aff8-480.webp', 'tg-tg-fpm2r-3', 'image/webp', 1528, 1528, 22408, NULL, 247
  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = '/uploads/library/importados/tg-tg-fpm2r-3-16aff8.webp');

-- Reset de categorías de estos SKUs para que la asignación sea autoritativa
-- (la 041 los dejó en su categoría de borrador; acá se re-clasifican limpio).
DELETE pc FROM product_categories pc
  JOIN products p ON p.id = pc.product_id
 WHERE p.sku IN (
    'TG-CIP-CF28300',
    'TG-CM-DC222815',
    'TG-CM-DC223615',
    'TG-CM-DC224115',
    'TG-CM-RBP35X50',
    'TG-CM-T100',
    'TG-CM-T200',
    'TG-CM-T300',
    'TG-CM-T400',
    'TG-CM-T500',
    'TG-CM-T600',
    'TG-FB-SE23X23-TG',
    'TG-FB-SE30X30-TG',
    'TG-GH-GWT009TU',
    'TG-GO-P105W',
    'TG-GO-P106W',
    'TG-GO-P108W',
    'TG-GO-P109W',
    'TG-GO-P110W',
    'TG-GT-P005',
    'TG-GT-P007',
    'TG-GT-P011',
    'TG-GT-P012',
    'TG-GT-P013',
    'TG-HL-LBG08',
    'TG-HL-LBG1220',
    'TG-HL-SBPLAFK1000-G',
    'TG-HL-WBLSTFW08',
    'TG-HL-WBLSTFW1220',
    'TG-IC-INT10000035E',
    'TG-IC-INT10000036E',
    'TG-IC-INT10000037E',
    'TG-IC-INT50000',
    'TG-IC-INT50006',
    'TG-IC-PMB10001',
    'TG-IC-PMB7000251E',
    'TG-IC-PMB7000252E',
    'TG-IC-PMB7000253E',
    'TG-INR-VREC12',
    'TG-IY-BBTK001',
    'TG-IY-BBTK002',
    'TG-IY-BBTK003',
    'TG-IY-BBTK004',
    'TG-IY-BBTK005',
    'TG-IY-BBTK006',
    'TG-IY-BU170-PC',
    'TG-IY-BU24-PC',
    'TG-IY-BU32-PC',
    'TG-IY-BU46-PC',
    'TG-IY-BU70W',
    'TG-IY-BU85-PC',
    'TG-IY-CR1200K',
    'TG-IY-CR1600K',
    'TG-IY-CR2100K',
    'TG-IY-CR500K',
    'TG-IY-CR700K',
    'TG-IY-CR900K',
    'TG-IY-CRV1200K',
    'TG-IY-CRV1600K',
    'TG-IY-CRV2100K',
    'TG-IY-LSDPET1024',
    'TG-IY-PCS05',
    'TG-IY-PCS075',
    'TG-IY-PCS10',
    'TG-IY-PCS15',
    'TG-IY-PCS20',
    'TG-IY-PCS20B',
    'TG-IY-PCS25',
    'TG-IY-PCS325',
    'TG-IY-PCS325B',
    'TG-IY-PPC10T',
    'TG-IY-PZBOXCH',
    'TG-IY-PZBOXGD',
    'TG-IY-PZBOXMD',
    'TG-IY-RBP16SSK',
    'TG-IY-RBP26SSK',
    'TG-IY-RBP32SSK',
    'TG-IY-SL08',
    'TG-IY-SL12/16',
    'TG-IY-ST6197B',
    'TG-IY-ST6197W',
    'TG-IY-ST8254B',
    'TG-IY-ST8254W',
    'TG-IY-WST6197B',
    'TG-IY-WST6197W',
    'TG-IY-WST8254B',
    'TG-IY-WST8254W',
    'TG-LY-AL300100',
    'TG-LY-C10NCL',
    'TG-LY-C10NT',
    'TG-LY-C18NCL',
    'TG-LY-C18NT',
    'TG-LY-C30NCL',
    'TG-LY-C30NT',
    'TG-LY-C40NCL',
    'TG-LY-C40NT',
    'TG-LY-C5NT',
    'TG-LY-Y465',
    'TG-ND-CS1R-TG',
    'TG-ND-CS2R-TG',
    'TG-ND-CS3R-TG',
    'TG-SN-PETCI98',
    'TG-SN-PETPCI4',
    'TG-SN-PLACI4',
    'TG-SN-PLACI98',
    'TG-SW-LSRC26',
    'TG-SW-LSRC40',
    'TG-SW-SB26S',
    'TG-SW-SB40S',
    'TG-TG-10857',
    'TG-TG-10865',
    'TG-TG-8000',
    'TG-TG-8010',
    'TG-TG-8010N',
    'TG-TG-8012',
    'TG-TG-8012N',
    'TG-TG-CE47100',
    'TG-TG-CE75100',
    'TG-TG-CG6510',
    'TG-TG-CT08',
    'TG-TG-CT12',
    'TG-TG-DCR160B',
    'TG-TG-DCR60B',
    'TG-TG-DCS110BC',
    'TG-TG-DCS220BC',
    'TG-TG-DCT180BC',
    'TG-TG-DCT80BC',
    'TG-TG-FC04',
    'TG-TG-FC045',
    'TG-TG-FPA15',
    'TG-TG-FPM2',
    'TG-TG-FPM217',
    'TG-TG-FPM2N',
    'TG-TG-FPM2R',
    'TG-TG-FPMPER2',
    'TG-TG-GC001',
    'TG-TG-GPE10000',
    'TG-TG-GVF001',
    'TG-TG-GVF002',
    'TG-TG-GVF003',
    'TG-TG-M003',
    'TG-TG-PB26PP3D',
    'TG-TG-PE001',
    'TG-TG-PVFE301400',
    'TG-TG-PVFE381400',
    'TG-TG-PVFE451400',
    'TG-TG-R001',
    'TG-TG-SC001',
    'TG-TG-SEL1414',
    'TG-TG-SL08/10',
    'TG-TG-SL12/20',
    'TG-TG-SO16R',
    'TG-TG-TCG10',
    'TG-YS-BS20025',
    'TG-YS-F160B',
    'TG-YS-IS1110',
    'TG-YS-IS70A',
    'TG-YS-K160B',
    'TG-YS-S160B',
    'TG-YS-WSET5',
    'TG-YS-WSET5N',
    'TG-YS-WSET6',
    'TG-YS-WSET6N'
 );

INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CIP-CF28300' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-DC222815' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-DC223615' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-DC224115' AND c.slug = 'bolsas';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-CM-RBP35X50' AND c.slug = 'bolsas';
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
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-FB-SE23X23-TG' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-FB-SE30X30-TG' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GH-GWT009TU' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GO-P105W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GO-P106W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GO-P108W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GO-P109W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GO-P110W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GT-P005' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GT-P007' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GT-P011' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GT-P012' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-GT-P013' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-HL-LBG08' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-HL-LBG1220' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-HL-SBPLAFK1000-G' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-HL-WBLSTFW08' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-HL-WBLSTFW1220' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IC-INT10000035E' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IC-INT10000036E' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IC-INT10000037E' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IC-INT50000' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IC-INT50006' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IC-PMB10001' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IC-PMB7000251E' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IC-PMB7000252E' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IC-PMB7000253E' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-INR-VREC12' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BBTK001' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BBTK002' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BBTK003' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BBTK004' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BBTK005' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BBTK006' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BU170-PC' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BU24-PC' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BU32-PC' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BU46-PC' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BU70W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-BU85-PC' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-CR1200K' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-CR1600K' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-CR2100K' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-CR500K' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-CR700K' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-CR900K' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-CRV1200K' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-CRV1600K' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-CRV2100K' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-LSDPET1024' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PCS05' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PCS075' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PCS10' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PCS15' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PCS20' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PCS20B' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PCS25' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PCS325' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PCS325B' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PPC10T' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PZBOXCH' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PZBOXGD' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-PZBOXMD' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-RBP16SSK' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-RBP26SSK' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-RBP32SSK' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-SL08' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-SL12/16' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-ST6197B' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-ST6197W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-ST8254B' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-ST8254W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-WST6197B' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-WST6197W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-WST8254B' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-IY-WST8254W' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-AL300100' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-C10NCL' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-C10NT' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-C18NCL' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-C18NT' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-C30NCL' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-C30NT' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-C40NCL' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-C40NT' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-C5NT' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-LY-Y465' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-ND-CS1R-TG' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-ND-CS2R-TG' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-ND-CS3R-TG' AND c.slug = 'carton';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-SN-PETCI98' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-SN-PETPCI4' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-SN-PLACI4' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-SN-PLACI98' AND c.slug = 'packaging-ecologico';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-SW-LSRC26' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-SW-LSRC40' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-SW-SB26S' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-SW-SB40S' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-10857' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-10865' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-8000' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-8010' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-8010N' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-8012' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-8012N' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-CE47100' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-CE75100' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-CG6510' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-CT08' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-CT12' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-DCR160B' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-DCR60B' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-DCS110BC' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-DCS220BC' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-DCT180BC' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-DCT80BC' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-FC04' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-FC045' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-FPA15' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-FPM2' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-FPM217' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-FPM2N' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-FPM2R' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-FPMPER2' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-GC001' AND c.slug = 'aseo-y-limpieza';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-GPE10000' AND c.slug = 'aseo-y-limpieza';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-GVF001' AND c.slug = 'aseo-y-limpieza';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-GVF002' AND c.slug = 'aseo-y-limpieza';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-GVF003' AND c.slug = 'aseo-y-limpieza';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-M003' AND c.slug = 'aseo-y-limpieza';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-PB26PP3D' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-PE001' AND c.slug = 'aseo-y-limpieza';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-PVFE301400' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-PVFE381400' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-PVFE451400' AND c.slug = 'film-y-aluminio';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-R001' AND c.slug = 'aseo-y-limpieza';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-SC001' AND c.slug = 'aseo-y-limpieza';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-SEL1414' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-SL08/10' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-SL12/20' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-SO16R' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-TG-TCG10' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-BS20025' AND c.slug = 'madera';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-F160B' AND c.slug = 'madera';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-IS1110' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-IS70A' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-K160B' AND c.slug = 'madera';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-S160B' AND c.slug = 'madera';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-WSET5' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-WSET5N' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-WSET6' AND c.slug = 'packaging-desechable';
INSERT IGNORE INTO product_categories (product_id, category_id)
  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = 'TG-YS-WSET6N' AND c.slug = 'packaging-desechable';

INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CIP-CF28300' AND m.file_path = '/uploads/library/importados/tg-cip-cf28300-1-4edb3c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CIP-CF28300' AND m2.file_path = '/uploads/library/importados/tg-cip-cf28300-1-4edb3c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC222815' AND m.file_path = '/uploads/library/importados/tg-cm-dc222815-1-98ca9f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC222815' AND m2.file_path = '/uploads/library/importados/tg-cm-dc222815-1-98ca9f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC222815' AND m.file_path = '/uploads/library/importados/tg-cm-dc222815-2-3058ba.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC222815' AND m2.file_path = '/uploads/library/importados/tg-cm-dc222815-2-3058ba.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC223615' AND m.file_path = '/uploads/library/importados/tg-cm-dc223615-1-ff3d56.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC223615' AND m2.file_path = '/uploads/library/importados/tg-cm-dc223615-1-ff3d56.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC223615' AND m.file_path = '/uploads/library/importados/tg-cm-dc223615-2-1cb266.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC223615' AND m2.file_path = '/uploads/library/importados/tg-cm-dc223615-2-1cb266.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC224115' AND m.file_path = '/uploads/library/importados/tg-cm-dc224115-1-445609.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC224115' AND m2.file_path = '/uploads/library/importados/tg-cm-dc224115-1-445609.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-DC224115' AND m.file_path = '/uploads/library/importados/tg-cm-dc224115-2-ec2d82.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-DC224115' AND m2.file_path = '/uploads/library/importados/tg-cm-dc224115-2-ec2d82.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-RBP35X50' AND m.file_path = '/uploads/library/importados/tg-cm-rbp35x50-1-19549e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-RBP35X50' AND m2.file_path = '/uploads/library/importados/tg-cm-rbp35x50-1-19549e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T100' AND m.file_path = '/uploads/library/importados/tg-cm-t100-1-f2e117.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T100' AND m2.file_path = '/uploads/library/importados/tg-cm-t100-1-f2e117.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T200' AND m.file_path = '/uploads/library/importados/tg-cm-t200-1-38d67d.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T200' AND m2.file_path = '/uploads/library/importados/tg-cm-t200-1-38d67d.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T300' AND m.file_path = '/uploads/library/importados/tg-cm-t300-1-f7c5c6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T300' AND m2.file_path = '/uploads/library/importados/tg-cm-t300-1-f7c5c6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T400' AND m.file_path = '/uploads/library/importados/tg-cm-t400-1-1ea243.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T400' AND m2.file_path = '/uploads/library/importados/tg-cm-t400-1-1ea243.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T500' AND m.file_path = '/uploads/library/importados/tg-cm-t500-1-15ce36.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T500' AND m2.file_path = '/uploads/library/importados/tg-cm-t500-1-15ce36.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-CM-T600' AND m.file_path = '/uploads/library/importados/tg-cm-t600-1-04f51f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-CM-T600' AND m2.file_path = '/uploads/library/importados/tg-cm-t600-1-04f51f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-FB-SE23X23-TG' AND m.file_path = '/uploads/library/importados/tg-fb-se23x23-tg-1-d66490.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-FB-SE23X23-TG' AND m2.file_path = '/uploads/library/importados/tg-fb-se23x23-tg-1-d66490.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-FB-SE30X30-TG' AND m.file_path = '/uploads/library/importados/tg-fb-se30x30-tg-1-55ab60.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-FB-SE30X30-TG' AND m2.file_path = '/uploads/library/importados/tg-fb-se30x30-tg-1-55ab60.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GH-GWT009TU' AND m.file_path = '/uploads/library/importados/tg-gh-gwt009tu-1-789d4b.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GH-GWT009TU' AND m2.file_path = '/uploads/library/importados/tg-gh-gwt009tu-1-789d4b.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GO-P105W' AND m.file_path = '/uploads/library/importados/tg-go-p105w-1-ecf97f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GO-P105W' AND m2.file_path = '/uploads/library/importados/tg-go-p105w-1-ecf97f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GO-P106W' AND m.file_path = '/uploads/library/importados/tg-go-p106w-1-54c1f1.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GO-P106W' AND m2.file_path = '/uploads/library/importados/tg-go-p106w-1-54c1f1.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GO-P108W' AND m.file_path = '/uploads/library/importados/tg-go-p108w-1-3994fc.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GO-P108W' AND m2.file_path = '/uploads/library/importados/tg-go-p108w-1-3994fc.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GO-P109W' AND m.file_path = '/uploads/library/importados/tg-go-p109w-1-81715f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GO-P109W' AND m2.file_path = '/uploads/library/importados/tg-go-p109w-1-81715f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GO-P110W' AND m.file_path = '/uploads/library/importados/tg-go-p110w-1-bfe22b.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GO-P110W' AND m2.file_path = '/uploads/library/importados/tg-go-p110w-1-bfe22b.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GT-P005' AND m.file_path = '/uploads/library/importados/tg-gt-p005-1-3533dd.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GT-P005' AND m2.file_path = '/uploads/library/importados/tg-gt-p005-1-3533dd.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GT-P007' AND m.file_path = '/uploads/library/importados/tg-gt-p007-1-41b0c5.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GT-P007' AND m2.file_path = '/uploads/library/importados/tg-gt-p007-1-41b0c5.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GT-P011' AND m.file_path = '/uploads/library/importados/tg-gt-p011-1-9fba75.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GT-P011' AND m2.file_path = '/uploads/library/importados/tg-gt-p011-1-9fba75.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GT-P012' AND m.file_path = '/uploads/library/importados/tg-gt-p012-1-84d95e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GT-P012' AND m2.file_path = '/uploads/library/importados/tg-gt-p012-1-84d95e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-GT-P013' AND m.file_path = '/uploads/library/importados/tg-gt-p013-1-59638d.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-GT-P013' AND m2.file_path = '/uploads/library/importados/tg-gt-p013-1-59638d.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-LBG08' AND m.file_path = '/uploads/library/importados/tg-hl-lbg08-1-7306b6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-LBG08' AND m2.file_path = '/uploads/library/importados/tg-hl-lbg08-1-7306b6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-LBG08' AND m.file_path = '/uploads/library/importados/tg-hl-lbg08-2-fab5a3.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-LBG08' AND m2.file_path = '/uploads/library/importados/tg-hl-lbg08-2-fab5a3.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-LBG08' AND m.file_path = '/uploads/library/importados/tg-hl-lbg08-3-ddf019.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-LBG08' AND m2.file_path = '/uploads/library/importados/tg-hl-lbg08-3-ddf019.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-LBG1220' AND m.file_path = '/uploads/library/importados/tg-hl-lbg1220-1-41ee88.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-LBG1220' AND m2.file_path = '/uploads/library/importados/tg-hl-lbg1220-1-41ee88.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-LBG1220' AND m.file_path = '/uploads/library/importados/tg-hl-lbg1220-2-f6e320.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-LBG1220' AND m2.file_path = '/uploads/library/importados/tg-hl-lbg1220-2-f6e320.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-LBG1220' AND m.file_path = '/uploads/library/importados/tg-hl-lbg1220-3-9efd5b.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-LBG1220' AND m2.file_path = '/uploads/library/importados/tg-hl-lbg1220-3-9efd5b.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-SBPLAFK1000-G' AND m.file_path = '/uploads/library/importados/tg-hl-sbplafk1000-g-1-0d9fac.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-SBPLAFK1000-G' AND m2.file_path = '/uploads/library/importados/tg-hl-sbplafk1000-g-1-0d9fac.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-SBPLAFK1000-G' AND m.file_path = '/uploads/library/importados/tg-hl-sbplafk1000-g-2-a3095c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-SBPLAFK1000-G' AND m2.file_path = '/uploads/library/importados/tg-hl-sbplafk1000-g-2-a3095c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-WBLSTFW08' AND m.file_path = '/uploads/library/importados/tg-hl-wblstfw08-1-b62097.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-WBLSTFW08' AND m2.file_path = '/uploads/library/importados/tg-hl-wblstfw08-1-b62097.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-WBLSTFW08' AND m.file_path = '/uploads/library/importados/tg-hl-wblstfw08-2-e5bc78.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-WBLSTFW08' AND m2.file_path = '/uploads/library/importados/tg-hl-wblstfw08-2-e5bc78.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-WBLSTFW1220' AND m.file_path = '/uploads/library/importados/tg-hl-wblstfw1220-1-486c29.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-WBLSTFW1220' AND m2.file_path = '/uploads/library/importados/tg-hl-wblstfw1220-1-486c29.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-HL-WBLSTFW1220' AND m.file_path = '/uploads/library/importados/tg-hl-wblstfw1220-2-8c5646.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-HL-WBLSTFW1220' AND m2.file_path = '/uploads/library/importados/tg-hl-wblstfw1220-2-8c5646.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-INT10000035E' AND m.file_path = '/uploads/library/importados/tg-ic-int10000035e-1-2cc720.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-INT10000035E' AND m2.file_path = '/uploads/library/importados/tg-ic-int10000035e-1-2cc720.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-INT10000036E' AND m.file_path = '/uploads/library/importados/tg-ic-int10000036e-1-5243a6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-INT10000036E' AND m2.file_path = '/uploads/library/importados/tg-ic-int10000036e-1-5243a6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-INT10000037E' AND m.file_path = '/uploads/library/importados/tg-ic-int10000037e-1-b4ee14.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-INT10000037E' AND m2.file_path = '/uploads/library/importados/tg-ic-int10000037e-1-b4ee14.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-INT50000' AND m.file_path = '/uploads/library/importados/tg-ic-int50000-1-b1cf24.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-INT50000' AND m2.file_path = '/uploads/library/importados/tg-ic-int50000-1-b1cf24.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-INT50006' AND m.file_path = '/uploads/library/importados/tg-ic-int50006-1-34bf3e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-INT50006' AND m2.file_path = '/uploads/library/importados/tg-ic-int50006-1-34bf3e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-INT50006' AND m.file_path = '/uploads/library/importados/tg-ic-int50006-2-be96b5.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-INT50006' AND m2.file_path = '/uploads/library/importados/tg-ic-int50006-2-be96b5.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-INT50006' AND m.file_path = '/uploads/library/importados/tg-ic-int50006-3-294106.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-INT50006' AND m2.file_path = '/uploads/library/importados/tg-ic-int50006-3-294106.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-PMB10001' AND m.file_path = '/uploads/library/importados/tg-ic-pmb10001-1-b33b36.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-PMB10001' AND m2.file_path = '/uploads/library/importados/tg-ic-pmb10001-1-b33b36.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-PMB7000251E' AND m.file_path = '/uploads/library/importados/tg-ic-pmb7000251e-1-bd8664.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-PMB7000251E' AND m2.file_path = '/uploads/library/importados/tg-ic-pmb7000251e-1-bd8664.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-PMB7000252E' AND m.file_path = '/uploads/library/importados/tg-ic-pmb7000252e-1-c1ba7f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-PMB7000252E' AND m2.file_path = '/uploads/library/importados/tg-ic-pmb7000252e-1-c1ba7f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IC-PMB7000253E' AND m.file_path = '/uploads/library/importados/tg-ic-pmb7000253e-1-4bffac.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IC-PMB7000253E' AND m2.file_path = '/uploads/library/importados/tg-ic-pmb7000253e-1-4bffac.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-INR-VREC12' AND m.file_path = '/uploads/library/importados/tg-inr-vrec12-1-56b527.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-INR-VREC12' AND m2.file_path = '/uploads/library/importados/tg-inr-vrec12-1-56b527.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BBTK001' AND m.file_path = '/uploads/library/importados/tg-iy-bbtk001-1-79a091.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BBTK001' AND m2.file_path = '/uploads/library/importados/tg-iy-bbtk001-1-79a091.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BBTK002' AND m.file_path = '/uploads/library/importados/tg-iy-bbtk002-1-47620b.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BBTK002' AND m2.file_path = '/uploads/library/importados/tg-iy-bbtk002-1-47620b.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BBTK003' AND m.file_path = '/uploads/library/importados/tg-iy-bbtk003-1-b98e90.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BBTK003' AND m2.file_path = '/uploads/library/importados/tg-iy-bbtk003-1-b98e90.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BBTK004' AND m.file_path = '/uploads/library/importados/tg-iy-bbtk004-1-ff532c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BBTK004' AND m2.file_path = '/uploads/library/importados/tg-iy-bbtk004-1-ff532c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BBTK005' AND m.file_path = '/uploads/library/importados/tg-iy-bbtk005-1-731c56.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BBTK005' AND m2.file_path = '/uploads/library/importados/tg-iy-bbtk005-1-731c56.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BBTK006' AND m.file_path = '/uploads/library/importados/tg-iy-bbtk006-1-d21541.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BBTK006' AND m2.file_path = '/uploads/library/importados/tg-iy-bbtk006-1-d21541.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU170-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu170-pc-1-418496.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU170-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu170-pc-1-418496.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU170-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu170-pc-2-b7b5f6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU170-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu170-pc-2-b7b5f6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU24-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu24-pc-1-c21cd7.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU24-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu24-pc-1-c21cd7.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU24-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu24-pc-2-2a8487.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU24-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu24-pc-2-2a8487.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU32-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu32-pc-1-5cb490.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU32-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu32-pc-1-5cb490.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU32-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu32-pc-2-f8c089.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU32-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu32-pc-2-f8c089.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU46-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu46-pc-1-d63e01.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU46-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu46-pc-1-d63e01.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU46-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu46-pc-2-4b823b.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU46-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu46-pc-2-4b823b.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU70W' AND m.file_path = '/uploads/library/importados/tg-iy-bu70w-1-8c0622.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU70W' AND m2.file_path = '/uploads/library/importados/tg-iy-bu70w-1-8c0622.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU70W' AND m.file_path = '/uploads/library/importados/tg-iy-bu70w-2-d70327.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU70W' AND m2.file_path = '/uploads/library/importados/tg-iy-bu70w-2-d70327.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU85-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu85-pc-1-22e4cd.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU85-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu85-pc-1-22e4cd.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-BU85-PC' AND m.file_path = '/uploads/library/importados/tg-iy-bu85-pc-2-de917c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-BU85-PC' AND m2.file_path = '/uploads/library/importados/tg-iy-bu85-pc-2-de917c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR1200K' AND m.file_path = '/uploads/library/importados/tg-iy-cr1200k-1-b6a212.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR1200K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr1200k-1-b6a212.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR1200K' AND m.file_path = '/uploads/library/importados/tg-iy-cr1200k-2-c8ea58.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR1200K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr1200k-2-c8ea58.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR1200K' AND m.file_path = '/uploads/library/importados/tg-iy-cr1200k-3-7aa03d.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR1200K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr1200k-3-7aa03d.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR1600K' AND m.file_path = '/uploads/library/importados/tg-iy-cr1600k-1-d20696.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR1600K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr1600k-1-d20696.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR1600K' AND m.file_path = '/uploads/library/importados/tg-iy-cr1600k-2-c52a91.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR1600K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr1600k-2-c52a91.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR1600K' AND m.file_path = '/uploads/library/importados/tg-iy-cr1600k-3-c0ae89.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR1600K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr1600k-3-c0ae89.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR2100K' AND m.file_path = '/uploads/library/importados/tg-iy-cr2100k-1-d20ec0.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR2100K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr2100k-1-d20ec0.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR2100K' AND m.file_path = '/uploads/library/importados/tg-iy-cr2100k-2-f4ffbc.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR2100K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr2100k-2-f4ffbc.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR2100K' AND m.file_path = '/uploads/library/importados/tg-iy-cr2100k-3-389242.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR2100K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr2100k-3-389242.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR500K' AND m.file_path = '/uploads/library/importados/tg-iy-cr500k-1-8f80e4.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR500K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr500k-1-8f80e4.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR500K' AND m.file_path = '/uploads/library/importados/tg-iy-cr500k-2-b2da4d.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR500K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr500k-2-b2da4d.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR500K' AND m.file_path = '/uploads/library/importados/tg-iy-cr500k-3-ba474f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR500K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr500k-3-ba474f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR700K' AND m.file_path = '/uploads/library/importados/tg-iy-cr700k-1-7a7512.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR700K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr700k-1-7a7512.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR700K' AND m.file_path = '/uploads/library/importados/tg-iy-cr700k-2-6936fd.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR700K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr700k-2-6936fd.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR700K' AND m.file_path = '/uploads/library/importados/tg-iy-cr700k-3-b449a3.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR700K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr700k-3-b449a3.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR900K' AND m.file_path = '/uploads/library/importados/tg-iy-cr900k-1-13ebcf.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR900K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr900k-1-13ebcf.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR900K' AND m.file_path = '/uploads/library/importados/tg-iy-cr900k-2-347201.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR900K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr900k-2-347201.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CR900K' AND m.file_path = '/uploads/library/importados/tg-iy-cr900k-3-f20863.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CR900K' AND m2.file_path = '/uploads/library/importados/tg-iy-cr900k-3-f20863.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CRV1200K' AND m.file_path = '/uploads/library/importados/tg-iy-crv1200k-1-aea943.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CRV1200K' AND m2.file_path = '/uploads/library/importados/tg-iy-crv1200k-1-aea943.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CRV1200K' AND m.file_path = '/uploads/library/importados/tg-iy-crv1200k-2-8f6c90.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CRV1200K' AND m2.file_path = '/uploads/library/importados/tg-iy-crv1200k-2-8f6c90.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CRV1600K' AND m.file_path = '/uploads/library/importados/tg-iy-crv1600k-1-52b352.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CRV1600K' AND m2.file_path = '/uploads/library/importados/tg-iy-crv1600k-1-52b352.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CRV1600K' AND m.file_path = '/uploads/library/importados/tg-iy-crv1600k-2-8c2f48.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CRV1600K' AND m2.file_path = '/uploads/library/importados/tg-iy-crv1600k-2-8c2f48.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CRV2100K' AND m.file_path = '/uploads/library/importados/tg-iy-crv2100k-1-b98429.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CRV2100K' AND m2.file_path = '/uploads/library/importados/tg-iy-crv2100k-1-b98429.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-CRV2100K' AND m.file_path = '/uploads/library/importados/tg-iy-crv2100k-2-be9856.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-CRV2100K' AND m2.file_path = '/uploads/library/importados/tg-iy-crv2100k-2-be9856.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-LSDPET1024' AND m.file_path = '/uploads/library/importados/tg-iy-lsdpet1024-1-5c17ec.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-LSDPET1024' AND m2.file_path = '/uploads/library/importados/tg-iy-lsdpet1024-1-5c17ec.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-LSDPET1024' AND m.file_path = '/uploads/library/importados/tg-iy-lsdpet1024-2-3cc542.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-LSDPET1024' AND m2.file_path = '/uploads/library/importados/tg-iy-lsdpet1024-2-3cc542.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-LSDPET1024' AND m.file_path = '/uploads/library/importados/tg-iy-lsdpet1024-3-13a697.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-LSDPET1024' AND m2.file_path = '/uploads/library/importados/tg-iy-lsdpet1024-3-13a697.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS05' AND m.file_path = '/uploads/library/importados/tg-iy-pcs05-1-a29701.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS05' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs05-1-a29701.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS075' AND m.file_path = '/uploads/library/importados/tg-iy-pcs075-1-66b526.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS075' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs075-1-66b526.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS10' AND m.file_path = '/uploads/library/importados/tg-iy-pcs10-1-48af0a.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS10' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs10-1-48af0a.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS10' AND m.file_path = '/uploads/library/importados/tg-iy-pcs10-2-74653e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS10' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs10-2-74653e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS15' AND m.file_path = '/uploads/library/importados/tg-iy-pcs15-1-9d39b2.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS15' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs15-1-9d39b2.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS20' AND m.file_path = '/uploads/library/importados/tg-iy-pcs20-1-1ac899.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS20' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs20-1-1ac899.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS20B' AND m.file_path = '/uploads/library/importados/tg-iy-pcs20b-1-a9b977.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS20B' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs20b-1-a9b977.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS25' AND m.file_path = '/uploads/library/importados/tg-iy-pcs25-1-48bf73.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS25' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs25-1-48bf73.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS325' AND m.file_path = '/uploads/library/importados/tg-iy-pcs325-1-92e3b1.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS325' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs325-1-92e3b1.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS325B' AND m.file_path = '/uploads/library/importados/tg-iy-pcs325b-1-389a9e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS325B' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs325b-1-389a9e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PCS325B' AND m.file_path = '/uploads/library/importados/tg-iy-pcs325b-2-036f8f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PCS325B' AND m2.file_path = '/uploads/library/importados/tg-iy-pcs325b-2-036f8f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PPC10T' AND m.file_path = '/uploads/library/importados/tg-iy-ppc10t-1-e825cc.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PPC10T' AND m2.file_path = '/uploads/library/importados/tg-iy-ppc10t-1-e825cc.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PZBOXCH' AND m.file_path = '/uploads/library/importados/tg-iy-pzboxch-1-4a6ec0.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PZBOXCH' AND m2.file_path = '/uploads/library/importados/tg-iy-pzboxch-1-4a6ec0.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PZBOXCH' AND m.file_path = '/uploads/library/importados/tg-iy-pzboxch-2-4d5d1a.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PZBOXCH' AND m2.file_path = '/uploads/library/importados/tg-iy-pzboxch-2-4d5d1a.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PZBOXGD' AND m.file_path = '/uploads/library/importados/tg-iy-pzboxgd-1-21d8db.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PZBOXGD' AND m2.file_path = '/uploads/library/importados/tg-iy-pzboxgd-1-21d8db.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PZBOXGD' AND m.file_path = '/uploads/library/importados/tg-iy-pzboxgd-2-0d8536.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PZBOXGD' AND m2.file_path = '/uploads/library/importados/tg-iy-pzboxgd-2-0d8536.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PZBOXMD' AND m.file_path = '/uploads/library/importados/tg-iy-pzboxmd-1-4d8d1d.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PZBOXMD' AND m2.file_path = '/uploads/library/importados/tg-iy-pzboxmd-1-4d8d1d.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-PZBOXMD' AND m.file_path = '/uploads/library/importados/tg-iy-pzboxmd-2-b1bad6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-PZBOXMD' AND m2.file_path = '/uploads/library/importados/tg-iy-pzboxmd-2-b1bad6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-RBP16SSK' AND m.file_path = '/uploads/library/importados/tg-iy-rbp16ssk-1-df2637.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-RBP16SSK' AND m2.file_path = '/uploads/library/importados/tg-iy-rbp16ssk-1-df2637.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-RBP26SSK' AND m.file_path = '/uploads/library/importados/tg-iy-rbp26ssk-1-2d5533.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-RBP26SSK' AND m2.file_path = '/uploads/library/importados/tg-iy-rbp26ssk-1-2d5533.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-RBP32SSK' AND m.file_path = '/uploads/library/importados/tg-iy-rbp32ssk-1-06d269.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-RBP32SSK' AND m2.file_path = '/uploads/library/importados/tg-iy-rbp32ssk-1-06d269.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-SL08' AND m.file_path = '/uploads/library/importados/tg-iy-sl08-1-4aef97.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-SL08' AND m2.file_path = '/uploads/library/importados/tg-iy-sl08-1-4aef97.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-SL12/16' AND m.file_path = '/uploads/library/importados/tg-iy-sl12-16-1-62a03e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-SL12/16' AND m2.file_path = '/uploads/library/importados/tg-iy-sl12-16-1-62a03e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-ST6197B' AND m.file_path = '/uploads/library/importados/tg-iy-st6197b-1-5f9c3e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-ST6197B' AND m2.file_path = '/uploads/library/importados/tg-iy-st6197b-1-5f9c3e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-ST6197W' AND m.file_path = '/uploads/library/importados/tg-iy-st6197w-1-0ec810.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-ST6197W' AND m2.file_path = '/uploads/library/importados/tg-iy-st6197w-1-0ec810.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-ST8254B' AND m.file_path = '/uploads/library/importados/tg-iy-st8254b-1-0c0e96.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-ST8254B' AND m2.file_path = '/uploads/library/importados/tg-iy-st8254b-1-0c0e96.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-ST8254W' AND m.file_path = '/uploads/library/importados/tg-iy-st8254w-1-9f682c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-ST8254W' AND m2.file_path = '/uploads/library/importados/tg-iy-st8254w-1-9f682c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-WST6197B' AND m.file_path = '/uploads/library/importados/tg-iy-wst6197b-1-01565b.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-WST6197B' AND m2.file_path = '/uploads/library/importados/tg-iy-wst6197b-1-01565b.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-WST6197W' AND m.file_path = '/uploads/library/importados/tg-iy-wst6197w-1-bd0365.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-WST6197W' AND m2.file_path = '/uploads/library/importados/tg-iy-wst6197w-1-bd0365.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-WST8254B' AND m.file_path = '/uploads/library/importados/tg-iy-wst8254b-1-f0d745.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-WST8254B' AND m2.file_path = '/uploads/library/importados/tg-iy-wst8254b-1-f0d745.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-IY-WST8254W' AND m.file_path = '/uploads/library/importados/tg-iy-wst8254w-1-e21ca0.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-IY-WST8254W' AND m2.file_path = '/uploads/library/importados/tg-iy-wst8254w-1-e21ca0.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-AL300100' AND m.file_path = '/uploads/library/importados/tg-ly-al300100-1-0379f5.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-AL300100' AND m2.file_path = '/uploads/library/importados/tg-ly-al300100-1-0379f5.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C10NCL' AND m.file_path = '/uploads/library/importados/tg-ly-c10ncl-1-c5313f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C10NCL' AND m2.file_path = '/uploads/library/importados/tg-ly-c10ncl-1-c5313f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C10NCL' AND m.file_path = '/uploads/library/importados/tg-ly-c10ncl-2-837809.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C10NCL' AND m2.file_path = '/uploads/library/importados/tg-ly-c10ncl-2-837809.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C10NT' AND m.file_path = '/uploads/library/importados/tg-ly-c10nt-1-60564c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C10NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c10nt-1-60564c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C10NT' AND m.file_path = '/uploads/library/importados/tg-ly-c10nt-2-e00475.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C10NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c10nt-2-e00475.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C18NCL' AND m.file_path = '/uploads/library/importados/tg-ly-c18ncl-1-1c77db.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C18NCL' AND m2.file_path = '/uploads/library/importados/tg-ly-c18ncl-1-1c77db.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C18NCL' AND m.file_path = '/uploads/library/importados/tg-ly-c18ncl-2-d0f0e9.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C18NCL' AND m2.file_path = '/uploads/library/importados/tg-ly-c18ncl-2-d0f0e9.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C18NT' AND m.file_path = '/uploads/library/importados/tg-ly-c18nt-1-b77082.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C18NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c18nt-1-b77082.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C18NT' AND m.file_path = '/uploads/library/importados/tg-ly-c18nt-2-0dfa24.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C18NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c18nt-2-0dfa24.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C30NCL' AND m.file_path = '/uploads/library/importados/tg-ly-c30ncl-1-aec301.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C30NCL' AND m2.file_path = '/uploads/library/importados/tg-ly-c30ncl-1-aec301.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C30NCL' AND m.file_path = '/uploads/library/importados/tg-ly-c30ncl-2-d130d1.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C30NCL' AND m2.file_path = '/uploads/library/importados/tg-ly-c30ncl-2-d130d1.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C30NT' AND m.file_path = '/uploads/library/importados/tg-ly-c30nt-1-01fdf4.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C30NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c30nt-1-01fdf4.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C30NT' AND m.file_path = '/uploads/library/importados/tg-ly-c30nt-2-67ecc0.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C30NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c30nt-2-67ecc0.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C40NCL' AND m.file_path = '/uploads/library/importados/tg-ly-c40ncl-1-28b1dc.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C40NCL' AND m2.file_path = '/uploads/library/importados/tg-ly-c40ncl-1-28b1dc.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C40NCL' AND m.file_path = '/uploads/library/importados/tg-ly-c40ncl-2-2118b8.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C40NCL' AND m2.file_path = '/uploads/library/importados/tg-ly-c40ncl-2-2118b8.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C40NT' AND m.file_path = '/uploads/library/importados/tg-ly-c40nt-1-389a02.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C40NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c40nt-1-389a02.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C40NT' AND m.file_path = '/uploads/library/importados/tg-ly-c40nt-2-47f4c8.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C40NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c40nt-2-47f4c8.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C5NT' AND m.file_path = '/uploads/library/importados/tg-ly-c5nt-1-4f593b.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C5NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c5nt-1-4f593b.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-C5NT' AND m.file_path = '/uploads/library/importados/tg-ly-c5nt-2-d8a5d5.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-C5NT' AND m2.file_path = '/uploads/library/importados/tg-ly-c5nt-2-d8a5d5.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-LY-Y465' AND m.file_path = '/uploads/library/importados/tg-ly-y465-1-6fe09e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-LY-Y465' AND m2.file_path = '/uploads/library/importados/tg-ly-y465-1-6fe09e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-ND-CS1R-TG' AND m.file_path = '/uploads/library/importados/tg-nd-cs1r-tg-1-e3c530.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-ND-CS1R-TG' AND m2.file_path = '/uploads/library/importados/tg-nd-cs1r-tg-1-e3c530.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-ND-CS1R-TG' AND m.file_path = '/uploads/library/importados/tg-nd-cs1r-tg-2-2e8482.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-ND-CS1R-TG' AND m2.file_path = '/uploads/library/importados/tg-nd-cs1r-tg-2-2e8482.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-ND-CS2R-TG' AND m.file_path = '/uploads/library/importados/tg-nd-cs2r-tg-1-385c8e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-ND-CS2R-TG' AND m2.file_path = '/uploads/library/importados/tg-nd-cs2r-tg-1-385c8e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-ND-CS2R-TG' AND m.file_path = '/uploads/library/importados/tg-nd-cs2r-tg-2-76d7a8.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-ND-CS2R-TG' AND m2.file_path = '/uploads/library/importados/tg-nd-cs2r-tg-2-76d7a8.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-ND-CS3R-TG' AND m.file_path = '/uploads/library/importados/tg-nd-cs3r-tg-1-3f5460.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-ND-CS3R-TG' AND m2.file_path = '/uploads/library/importados/tg-nd-cs3r-tg-1-3f5460.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-ND-CS3R-TG' AND m.file_path = '/uploads/library/importados/tg-nd-cs3r-tg-2-231761.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-ND-CS3R-TG' AND m2.file_path = '/uploads/library/importados/tg-nd-cs3r-tg-2-231761.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-SN-PETCI98' AND m.file_path = '/uploads/library/importados/tg-sn-petci98-1-c7e004.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-SN-PETCI98' AND m2.file_path = '/uploads/library/importados/tg-sn-petci98-1-c7e004.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-SN-PETPCI4' AND m.file_path = '/uploads/library/importados/tg-sn-petpci4-1-cd6dc6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-SN-PETPCI4' AND m2.file_path = '/uploads/library/importados/tg-sn-petpci4-1-cd6dc6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-SN-PLACI4' AND m.file_path = '/uploads/library/importados/tg-sn-placi4-1-3a38e7.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-SN-PLACI4' AND m2.file_path = '/uploads/library/importados/tg-sn-placi4-1-3a38e7.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-SN-PLACI98' AND m.file_path = '/uploads/library/importados/tg-sn-placi98-1-3abdad.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-SN-PLACI98' AND m2.file_path = '/uploads/library/importados/tg-sn-placi98-1-3abdad.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-SW-LSRC26' AND m.file_path = '/uploads/library/importados/tg-sw-lsrc26-1-8b8b2e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-SW-LSRC26' AND m2.file_path = '/uploads/library/importados/tg-sw-lsrc26-1-8b8b2e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-SW-LSRC40' AND m.file_path = '/uploads/library/importados/tg-sw-lsrc40-1-e5a196.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-SW-LSRC40' AND m2.file_path = '/uploads/library/importados/tg-sw-lsrc40-1-e5a196.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-SW-SB26S' AND m.file_path = '/uploads/library/importados/tg-sw-sb26s-1-cfc86a.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-SW-SB26S' AND m2.file_path = '/uploads/library/importados/tg-sw-sb26s-1-cfc86a.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-SW-SB26S' AND m.file_path = '/uploads/library/importados/tg-sw-sb26s-2-198870.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-SW-SB26S' AND m2.file_path = '/uploads/library/importados/tg-sw-sb26s-2-198870.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-SW-SB40S' AND m.file_path = '/uploads/library/importados/tg-sw-sb40s-1-5fb841.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-SW-SB40S' AND m2.file_path = '/uploads/library/importados/tg-sw-sb40s-1-5fb841.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-10857' AND m.file_path = '/uploads/library/importados/tg-tg-10857-1-131d68.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-10857' AND m2.file_path = '/uploads/library/importados/tg-tg-10857-1-131d68.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-10865' AND m.file_path = '/uploads/library/importados/tg-tg-10865-1-78b602.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-10865' AND m2.file_path = '/uploads/library/importados/tg-tg-10865-1-78b602.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-10865' AND m.file_path = '/uploads/library/importados/tg-tg-10865-2-2d8f2f.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-10865' AND m2.file_path = '/uploads/library/importados/tg-tg-10865-2-2d8f2f.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-8000' AND m.file_path = '/uploads/library/importados/tg-tg-8000-1-577ed6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-8000' AND m2.file_path = '/uploads/library/importados/tg-tg-8000-1-577ed6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-8010' AND m.file_path = '/uploads/library/importados/tg-tg-8010-1-20ed90.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-8010' AND m2.file_path = '/uploads/library/importados/tg-tg-8010-1-20ed90.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-8010N' AND m.file_path = '/uploads/library/importados/tg-tg-8010n-1-439100.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-8010N' AND m2.file_path = '/uploads/library/importados/tg-tg-8010n-1-439100.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-8012' AND m.file_path = '/uploads/library/importados/tg-tg-8012-1-d03912.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-8012' AND m2.file_path = '/uploads/library/importados/tg-tg-8012-1-d03912.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-8012N' AND m.file_path = '/uploads/library/importados/tg-tg-8012n-1-738a53.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-8012N' AND m2.file_path = '/uploads/library/importados/tg-tg-8012n-1-738a53.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-8012N' AND m.file_path = '/uploads/library/importados/tg-tg-8012n-2-43a636.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-8012N' AND m2.file_path = '/uploads/library/importados/tg-tg-8012n-2-43a636.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-CE47100' AND m.file_path = '/uploads/library/importados/tg-tg-ce47100-1-0939f3.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-CE47100' AND m2.file_path = '/uploads/library/importados/tg-tg-ce47100-1-0939f3.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-CE75100' AND m.file_path = '/uploads/library/importados/tg-tg-ce75100-1-a3814c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-CE75100' AND m2.file_path = '/uploads/library/importados/tg-tg-ce75100-1-a3814c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-CG6510' AND m.file_path = '/uploads/library/importados/tg-tg-cg6510-1-4f80cc.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-CG6510' AND m2.file_path = '/uploads/library/importados/tg-tg-cg6510-1-4f80cc.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-CT08' AND m.file_path = '/uploads/library/importados/tg-tg-ct08-1-459592.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-CT08' AND m2.file_path = '/uploads/library/importados/tg-tg-ct08-1-459592.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-CT08' AND m.file_path = '/uploads/library/importados/tg-tg-ct08-2-0ad757.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-CT08' AND m2.file_path = '/uploads/library/importados/tg-tg-ct08-2-0ad757.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-CT12' AND m.file_path = '/uploads/library/importados/tg-tg-ct12-1-2d9a57.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-CT12' AND m2.file_path = '/uploads/library/importados/tg-tg-ct12-1-2d9a57.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCR160B' AND m.file_path = '/uploads/library/importados/tg-tg-dcr160b-1-319b9c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCR160B' AND m2.file_path = '/uploads/library/importados/tg-tg-dcr160b-1-319b9c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCR60B' AND m.file_path = '/uploads/library/importados/tg-tg-dcr60b-1-f75aa1.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCR60B' AND m2.file_path = '/uploads/library/importados/tg-tg-dcr60b-1-f75aa1.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCS110BC' AND m.file_path = '/uploads/library/importados/tg-tg-dcs110bc-1-856c0d.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCS110BC' AND m2.file_path = '/uploads/library/importados/tg-tg-dcs110bc-1-856c0d.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCS110BC' AND m.file_path = '/uploads/library/importados/tg-tg-dcs110bc-2-279e04.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCS110BC' AND m2.file_path = '/uploads/library/importados/tg-tg-dcs110bc-2-279e04.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCS220BC' AND m.file_path = '/uploads/library/importados/tg-tg-dcs220bc-1-e893b8.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCS220BC' AND m2.file_path = '/uploads/library/importados/tg-tg-dcs220bc-1-e893b8.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCS220BC' AND m.file_path = '/uploads/library/importados/tg-tg-dcs220bc-2-6eb446.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCS220BC' AND m2.file_path = '/uploads/library/importados/tg-tg-dcs220bc-2-6eb446.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCT180BC' AND m.file_path = '/uploads/library/importados/tg-tg-dct180bc-1-0cf239.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCT180BC' AND m2.file_path = '/uploads/library/importados/tg-tg-dct180bc-1-0cf239.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCT180BC' AND m.file_path = '/uploads/library/importados/tg-tg-dct180bc-2-cca6fa.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCT180BC' AND m2.file_path = '/uploads/library/importados/tg-tg-dct180bc-2-cca6fa.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCT80BC' AND m.file_path = '/uploads/library/importados/tg-tg-dct80bc-1-78cdbc.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCT80BC' AND m2.file_path = '/uploads/library/importados/tg-tg-dct80bc-1-78cdbc.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-DCT80BC' AND m.file_path = '/uploads/library/importados/tg-tg-dct80bc-2-da3c75.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-DCT80BC' AND m2.file_path = '/uploads/library/importados/tg-tg-dct80bc-2-da3c75.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FC04' AND m.file_path = '/uploads/library/importados/tg-tg-fc04-1-146272.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FC04' AND m2.file_path = '/uploads/library/importados/tg-tg-fc04-1-146272.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FC045' AND m.file_path = '/uploads/library/importados/tg-tg-fc045-1-583be3.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FC045' AND m2.file_path = '/uploads/library/importados/tg-tg-fc045-1-583be3.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPA15' AND m.file_path = '/uploads/library/importados/tg-tg-fpa15-1-11b945.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPA15' AND m2.file_path = '/uploads/library/importados/tg-tg-fpa15-1-11b945.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM2' AND m.file_path = '/uploads/library/importados/tg-tg-fpm2-1-57d50d.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM2' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm2-1-57d50d.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM2' AND m.file_path = '/uploads/library/importados/tg-tg-fpm2-2-d070e8.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM2' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm2-2-d070e8.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM217' AND m.file_path = '/uploads/library/importados/tg-tg-fpm217-1-cfa455.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM217' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm217-1-cfa455.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM217' AND m.file_path = '/uploads/library/importados/tg-tg-fpm217-2-2e68f8.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM217' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm217-2-2e68f8.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM2N' AND m.file_path = '/uploads/library/importados/tg-tg-fpm2n-1-84e06e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM2N' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm2n-1-84e06e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM2N' AND m.file_path = '/uploads/library/importados/tg-tg-fpm2n-2-55d93e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM2N' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm2n-2-55d93e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM2N' AND m.file_path = '/uploads/library/importados/tg-tg-fpm2n-3-1b5216.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM2N' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm2n-3-1b5216.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM2R' AND m.file_path = '/uploads/library/importados/tg-tg-fpm2r-1-9d875c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM2R' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm2r-1-9d875c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM2R' AND m.file_path = '/uploads/library/importados/tg-tg-fpm2r-2-39f326.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM2R' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm2r-2-39f326.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPM2R' AND m.file_path = '/uploads/library/importados/tg-tg-fpm2r-3-16aff8.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPM2R' AND m2.file_path = '/uploads/library/importados/tg-tg-fpm2r-3-16aff8.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPMPER2' AND m.file_path = '/uploads/library/importados/tg-tg-fpmper2-1-2b22de.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPMPER2' AND m2.file_path = '/uploads/library/importados/tg-tg-fpmper2-1-2b22de.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPMPER2' AND m.file_path = '/uploads/library/importados/tg-tg-fpmper2-2-6f31b3.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPMPER2' AND m2.file_path = '/uploads/library/importados/tg-tg-fpmper2-2-6f31b3.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-FPMPER2' AND m.file_path = '/uploads/library/importados/tg-tg-fpmper2-3-04018a.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-FPMPER2' AND m2.file_path = '/uploads/library/importados/tg-tg-fpmper2-3-04018a.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-GC001' AND m.file_path = '/uploads/library/importados/tg-tg-gc001-1-0e9edf.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-GC001' AND m2.file_path = '/uploads/library/importados/tg-tg-gc001-1-0e9edf.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-GC001' AND m.file_path = '/uploads/library/importados/tg-tg-gc001-2-6d234c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-GC001' AND m2.file_path = '/uploads/library/importados/tg-tg-gc001-2-6d234c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-GPE10000' AND m.file_path = '/uploads/library/importados/tg-tg-gpe10000-1-2a829a.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-GPE10000' AND m2.file_path = '/uploads/library/importados/tg-tg-gpe10000-1-2a829a.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-GVF001' AND m.file_path = '/uploads/library/importados/tg-tg-gvf001-1-e6f2df.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-GVF001' AND m2.file_path = '/uploads/library/importados/tg-tg-gvf001-1-e6f2df.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-GVF002' AND m.file_path = '/uploads/library/importados/tg-tg-gvf002-1-f4e799.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-GVF002' AND m2.file_path = '/uploads/library/importados/tg-tg-gvf002-1-f4e799.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-GVF003' AND m.file_path = '/uploads/library/importados/tg-tg-gvf003-1-1460df.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-GVF003' AND m2.file_path = '/uploads/library/importados/tg-tg-gvf003-1-1460df.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-M003' AND m.file_path = '/uploads/library/importados/tg-tg-m003-1-9142cd.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-M003' AND m2.file_path = '/uploads/library/importados/tg-tg-m003-1-9142cd.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-M003' AND m.file_path = '/uploads/library/importados/tg-tg-m003-2-89fc08.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-M003' AND m2.file_path = '/uploads/library/importados/tg-tg-m003-2-89fc08.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PB26PP3D' AND m.file_path = '/uploads/library/importados/tg-tg-pb26pp3d-1-01d004.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PB26PP3D' AND m2.file_path = '/uploads/library/importados/tg-tg-pb26pp3d-1-01d004.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PB26PP3D' AND m.file_path = '/uploads/library/importados/tg-tg-pb26pp3d-2-bc04da.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PB26PP3D' AND m2.file_path = '/uploads/library/importados/tg-tg-pb26pp3d-2-bc04da.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PE001' AND m.file_path = '/uploads/library/importados/tg-tg-pe001-1-3c025b.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PE001' AND m2.file_path = '/uploads/library/importados/tg-tg-pe001-1-3c025b.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PE001' AND m.file_path = '/uploads/library/importados/tg-tg-pe001-2-71761e.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PE001' AND m2.file_path = '/uploads/library/importados/tg-tg-pe001-2-71761e.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PVFE301400' AND m.file_path = '/uploads/library/importados/tg-tg-pvfe301400-1-bb69f8.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PVFE301400' AND m2.file_path = '/uploads/library/importados/tg-tg-pvfe301400-1-bb69f8.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PVFE301400' AND m.file_path = '/uploads/library/importados/tg-tg-pvfe301400-2-571812.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PVFE301400' AND m2.file_path = '/uploads/library/importados/tg-tg-pvfe301400-2-571812.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PVFE381400' AND m.file_path = '/uploads/library/importados/tg-tg-pvfe381400-1-793132.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PVFE381400' AND m2.file_path = '/uploads/library/importados/tg-tg-pvfe381400-1-793132.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PVFE381400' AND m.file_path = '/uploads/library/importados/tg-tg-pvfe381400-2-5de8d4.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PVFE381400' AND m2.file_path = '/uploads/library/importados/tg-tg-pvfe381400-2-5de8d4.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PVFE451400' AND m.file_path = '/uploads/library/importados/tg-tg-pvfe451400-1-86bcce.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PVFE451400' AND m2.file_path = '/uploads/library/importados/tg-tg-pvfe451400-1-86bcce.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-PVFE451400' AND m.file_path = '/uploads/library/importados/tg-tg-pvfe451400-2-ed2ca0.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-PVFE451400' AND m2.file_path = '/uploads/library/importados/tg-tg-pvfe451400-2-ed2ca0.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-R001' AND m.file_path = '/uploads/library/importados/tg-tg-r001-1-02b601.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-R001' AND m2.file_path = '/uploads/library/importados/tg-tg-r001-1-02b601.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-SC001' AND m.file_path = '/uploads/library/importados/tg-tg-sc001-1-ec7fb3.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-SC001' AND m2.file_path = '/uploads/library/importados/tg-tg-sc001-1-ec7fb3.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-SEL1414' AND m.file_path = '/uploads/library/importados/tg-tg-sel1414-1-d44479.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-SEL1414' AND m2.file_path = '/uploads/library/importados/tg-tg-sel1414-1-d44479.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-SL08/10' AND m.file_path = '/uploads/library/importados/tg-tg-sl08-10-1-522db7.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-SL08/10' AND m2.file_path = '/uploads/library/importados/tg-tg-sl08-10-1-522db7.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-SL12/20' AND m.file_path = '/uploads/library/importados/tg-tg-sl12-20-1-ffb2eb.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-SL12/20' AND m2.file_path = '/uploads/library/importados/tg-tg-sl12-20-1-ffb2eb.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-SO16R' AND m.file_path = '/uploads/library/importados/tg-tg-so16r-1-f2e922.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-SO16R' AND m2.file_path = '/uploads/library/importados/tg-tg-so16r-1-f2e922.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-SO16R' AND m.file_path = '/uploads/library/importados/tg-tg-so16r-2-b67d24.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-SO16R' AND m2.file_path = '/uploads/library/importados/tg-tg-so16r-2-b67d24.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-SO16R' AND m.file_path = '/uploads/library/importados/tg-tg-so16r-3-416f1b.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-SO16R' AND m2.file_path = '/uploads/library/importados/tg-tg-so16r-3-416f1b.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-TG-TCG10' AND m.file_path = '/uploads/library/importados/tg-tg-tcg10-1-fb355a.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-TG-TCG10' AND m2.file_path = '/uploads/library/importados/tg-tg-tcg10-1-fb355a.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-BS20025' AND m.file_path = '/uploads/library/importados/tg-ys-bs20025-1-6ef804.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-BS20025' AND m2.file_path = '/uploads/library/importados/tg-ys-bs20025-1-6ef804.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-BS20025' AND m.file_path = '/uploads/library/importados/tg-ys-bs20025-2-92feb0.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-BS20025' AND m2.file_path = '/uploads/library/importados/tg-ys-bs20025-2-92feb0.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-F160B' AND m.file_path = '/uploads/library/importados/tg-ys-f160b-1-ee5ef8.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-F160B' AND m2.file_path = '/uploads/library/importados/tg-ys-f160b-1-ee5ef8.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-F160B' AND m.file_path = '/uploads/library/importados/tg-ys-f160b-2-3600e6.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-F160B' AND m2.file_path = '/uploads/library/importados/tg-ys-f160b-2-3600e6.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-F160B' AND m.file_path = '/uploads/library/importados/tg-ys-f160b-3-43830a.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-F160B' AND m2.file_path = '/uploads/library/importados/tg-ys-f160b-3-43830a.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-IS1110' AND m.file_path = '/uploads/library/importados/tg-ys-is1110-1-9e6e34.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-IS1110' AND m2.file_path = '/uploads/library/importados/tg-ys-is1110-1-9e6e34.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-IS70A' AND m.file_path = '/uploads/library/importados/tg-ys-is70a-1-bcfe20.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-IS70A' AND m2.file_path = '/uploads/library/importados/tg-ys-is70a-1-bcfe20.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-IS70A' AND m.file_path = '/uploads/library/importados/tg-ys-is70a-2-ca31fe.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-IS70A' AND m2.file_path = '/uploads/library/importados/tg-ys-is70a-2-ca31fe.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 2, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-IS70A' AND m.file_path = '/uploads/library/importados/tg-ys-is70a-3-27d84a.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-IS70A' AND m2.file_path = '/uploads/library/importados/tg-ys-is70a-3-27d84a.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-K160B' AND m.file_path = '/uploads/library/importados/tg-ys-k160b-1-2f6a26.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-K160B' AND m2.file_path = '/uploads/library/importados/tg-ys-k160b-1-2f6a26.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-K160B' AND m.file_path = '/uploads/library/importados/tg-ys-k160b-2-3cb34a.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-K160B' AND m2.file_path = '/uploads/library/importados/tg-ys-k160b-2-3cb34a.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-S160B' AND m.file_path = '/uploads/library/importados/tg-ys-s160b-1-26bb4c.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-S160B' AND m2.file_path = '/uploads/library/importados/tg-ys-s160b-1-26bb4c.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 1, 0 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-S160B' AND m.file_path = '/uploads/library/importados/tg-ys-s160b-2-de6274.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-S160B' AND m2.file_path = '/uploads/library/importados/tg-ys-s160b-2-de6274.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-WSET5' AND m.file_path = '/uploads/library/importados/tg-ys-wset5-1-ee5d89.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-WSET5' AND m2.file_path = '/uploads/library/importados/tg-ys-wset5-1-ee5d89.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-WSET5N' AND m.file_path = '/uploads/library/importados/tg-ys-wset5n-1-f228ae.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-WSET5N' AND m2.file_path = '/uploads/library/importados/tg-ys-wset5n-1-f228ae.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-WSET6' AND m.file_path = '/uploads/library/importados/tg-ys-wset6-1-e419ea.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-WSET6' AND m2.file_path = '/uploads/library/importados/tg-ys-wset6-1-e419ea.webp');
INSERT INTO product_images (product_id, media_id, sort_order, is_primary)
  SELECT p.id, m.id, 0, 1 FROM products p, media_library m
  WHERE p.sku = 'TG-YS-WSET6N' AND m.file_path = '/uploads/library/importados/tg-ys-wset6n-1-518c69.webp'
  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id
                  WHERE p2.sku = 'TG-YS-WSET6N' AND m2.file_path = '/uploads/library/importados/tg-ys-wset6n-1-518c69.webp');
