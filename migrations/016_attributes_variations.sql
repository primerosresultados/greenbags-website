-- Atributos (Color, Talle…) y variaciones de producto.
-- Una variación = combinación de valores de atributo con su propio SKU/precio/stock.

CREATE TABLE IF NOT EXISTS attributes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    slug VARCHAR(140) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS attribute_values (
    id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_id INT NOT NULL,
    value VARCHAR(150) NOT NULL,
    slug VARCHAR(170) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    UNIQUE KEY uniq_attr_val (attribute_id, slug),
    CONSTRAINT fk_av_attr FOREIGN KEY (attribute_id) REFERENCES attributes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_attributes (
    product_id INT NOT NULL,
    attribute_id INT NOT NULL,
    is_variation TINYINT(1) NOT NULL DEFAULT 1,
    sort_order INT NOT NULL DEFAULT 0,
    PRIMARY KEY (product_id, attribute_id),
    CONSTRAINT fk_pa_product FOREIGN KEY (product_id)   REFERENCES products(id)   ON DELETE CASCADE,
    CONSTRAINT fk_pa_attr    FOREIGN KEY (attribute_id) REFERENCES attributes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_variations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    sku VARCHAR(100) DEFAULT NULL UNIQUE,
    price DECIMAL(12,2) NOT NULL DEFAULT 0,
    sale_price DECIMAL(12,2) DEFAULT NULL,
    stock_qty INT NOT NULL DEFAULT 0,
    stock_status ENUM('in_stock','out_of_stock','backorder') NOT NULL DEFAULT 'in_stock',
    weight DECIMAL(10,3) DEFAULT NULL,
    image_id INT DEFAULT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    sort_order INT NOT NULL DEFAULT 0,
    INDEX idx_var_product (product_id, is_active),
    CONSTRAINT fk_var_product FOREIGN KEY (product_id) REFERENCES products(id)      ON DELETE CASCADE,
    CONSTRAINT fk_var_image   FOREIGN KEY (image_id)   REFERENCES media_library(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS variation_attribute_values (
    variation_id INT NOT NULL,
    attribute_id INT NOT NULL,
    attribute_value_id INT NOT NULL,
    PRIMARY KEY (variation_id, attribute_id),
    INDEX idx_vav_value (attribute_value_id),
    CONSTRAINT fk_vav_var   FOREIGN KEY (variation_id)       REFERENCES product_variations(id) ON DELETE CASCADE,
    CONSTRAINT fk_vav_attr  FOREIGN KEY (attribute_id)       REFERENCES attributes(id)         ON DELETE CASCADE,
    CONSTRAINT fk_vav_value FOREIGN KEY (attribute_value_id) REFERENCES attribute_values(id)   ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
