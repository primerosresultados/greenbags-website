-- Catálogo: categorías (jerárquicas) y productos (simple/variable).
-- Las imágenes reutilizan la media_library existente (WebP + srcset ya resueltos).

CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    parent_id INT DEFAULT NULL,
    name VARCHAR(180) NOT NULL,
    slug VARCHAR(200) NOT NULL UNIQUE,
    description MEDIUMTEXT,
    image_id INT DEFAULT NULL,
    meta_title VARCHAR(255) DEFAULT NULL,
    meta_description VARCHAR(300) DEFAULT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_cat_parent (parent_id, sort_order),
    INDEX idx_cat_active (is_active),
    CONSTRAINT fk_cat_parent FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL,
    CONSTRAINT fk_cat_image  FOREIGN KEY (image_id)  REFERENCES media_library(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('simple','variable') NOT NULL DEFAULT 'simple',
    sku VARCHAR(100) DEFAULT NULL,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    short_description VARCHAR(500) DEFAULT NULL,
    description MEDIUMTEXT,
    brand VARCHAR(120) DEFAULT NULL,
    status ENUM('draft','published','archived') NOT NULL DEFAULT 'draft',
    price DECIMAL(12,2) NOT NULL DEFAULT 0,
    sale_price DECIMAL(12,2) DEFAULT NULL,
    sale_starts_at DATETIME DEFAULT NULL,
    sale_ends_at DATETIME DEFAULT NULL,
    min_price DECIMAL(12,2) DEFAULT NULL,
    max_price DECIMAL(12,2) DEFAULT NULL,
    manage_stock TINYINT(1) NOT NULL DEFAULT 1,
    stock_qty INT NOT NULL DEFAULT 0,
    stock_status ENUM('in_stock','out_of_stock','backorder') NOT NULL DEFAULT 'in_stock',
    weight DECIMAL(10,3) DEFAULT NULL,
    featured TINYINT(1) NOT NULL DEFAULT 0,
    meta_title VARCHAR(255) DEFAULT NULL,
    meta_description VARCHAR(300) DEFAULT NULL,
    og_image_id INT DEFAULT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_sku (sku),
    INDEX idx_prod_status (status, featured),
    INDEX idx_prod_price (price),
    CONSTRAINT fk_prod_ogimg FOREIGN KEY (og_image_id) REFERENCES media_library(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_categories (
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (product_id, category_id),
    INDEX idx_pc_cat (category_id),
    CONSTRAINT fk_pc_product  FOREIGN KEY (product_id)  REFERENCES products(id)   ON DELETE CASCADE,
    CONSTRAINT fk_pc_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    media_id INT NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_primary TINYINT(1) NOT NULL DEFAULT 0,
    INDEX idx_pi_product (product_id, sort_order),
    CONSTRAINT fk_pi_product FOREIGN KEY (product_id) REFERENCES products(id)      ON DELETE CASCADE,
    CONSTRAINT fk_pi_media   FOREIGN KEY (media_id)   REFERENCES media_library(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
