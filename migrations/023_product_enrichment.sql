-- Enriquecimiento de producto:
--  * Campos para feeds (Google Shopping / catálogo de Meta): gtin, mpn,
--    condición, categoría de Google.
--  * Venta por mayor: min_order_qty + tabla price_tiers (precio por cantidad).
--  * Videos por URL (YouTube/Vimeo/archivo/Cloudinary): tabla product_videos.
--  * GTIN/MPN por variación (Google pide identificadores por variante).
--
-- NOTA: la columna se llama `item_condition` porque CONDITION es palabra
-- reservada en MySQL.

ALTER TABLE products
    ADD COLUMN gtin VARCHAR(50) DEFAULT NULL AFTER sku,
    ADD COLUMN mpn VARCHAR(80) DEFAULT NULL AFTER gtin,
    ADD COLUMN item_condition ENUM('new','refurbished','used') NOT NULL DEFAULT 'new' AFTER brand,
    ADD COLUMN google_category VARCHAR(255) DEFAULT NULL AFTER item_condition,
    ADD COLUMN min_order_qty INT NOT NULL DEFAULT 1 AFTER manage_stock;

ALTER TABLE product_variations
    ADD COLUMN gtin VARCHAR(50) DEFAULT NULL AFTER sku,
    ADD COLUMN mpn VARCHAR(80) DEFAULT NULL AFTER gtin;

CREATE TABLE IF NOT EXISTS price_tiers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    variation_id INT DEFAULT NULL,
    min_qty INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(12,2) NOT NULL,
    INDEX idx_tier_product (product_id, min_qty),
    CONSTRAINT fk_tier_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_videos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    provider VARCHAR(20) NOT NULL DEFAULT 'youtube',   -- youtube | vimeo | file
    url VARCHAR(600) NOT NULL,
    video_id VARCHAR(160) DEFAULT NULL,
    title VARCHAR(200) DEFAULT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    INDEX idx_pvid_product (product_id, sort_order),
    CONSTRAINT fk_pvid_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
