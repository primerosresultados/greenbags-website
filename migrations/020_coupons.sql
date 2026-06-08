-- Cupones / códigos de descuento + registro de uso.

CREATE TABLE IF NOT EXISTS coupons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(60) NOT NULL UNIQUE,
    type ENUM('percent','fixed_cart','fixed_product','free_shipping') NOT NULL DEFAULT 'percent',
    amount DECIMAL(12,2) NOT NULL DEFAULT 0,
    min_subtotal DECIMAL(12,2) DEFAULT NULL,
    max_uses INT DEFAULT NULL,
    used_count INT NOT NULL DEFAULT 0,
    max_uses_per_customer INT DEFAULT NULL,
    individual_use TINYINT(1) NOT NULL DEFAULT 0,
    starts_at DATETIME DEFAULT NULL,
    expires_at DATETIME DEFAULT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_coupon_active (is_active, expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS coupon_usage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    coupon_id INT NOT NULL,
    order_id INT NOT NULL,
    customer_id INT DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_cu_coupon (coupon_id),
    CONSTRAINT fk_cu_coupon FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Evolución (Fase 4+): coupon_products / coupon_categories para restringir por ítem.
