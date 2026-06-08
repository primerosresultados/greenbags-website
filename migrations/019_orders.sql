-- Órdenes, ítems (con snapshots), historial de estados y registro de pagos.
-- orders.event_id: UUID compartido con el Pixel para deduplicar el evento
--   Purchase entre navegador (Pixel) y servidor (Meta Conversions API).
-- payments.provider_payment_id es UNIQUE: garantiza idempotencia de webhooks
--   (una notificación repetida nunca marca dos veces la orden como pagada).

CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(40) NOT NULL UNIQUE,
    customer_id INT DEFAULT NULL,
    email VARCHAR(255) NOT NULL,
    status ENUM('pending','paid','processing','shipped','completed','cancelled','refunded')
           NOT NULL DEFAULT 'pending',
    currency VARCHAR(3) NOT NULL DEFAULT 'CLP',
    subtotal       DECIMAL(12,2) NOT NULL DEFAULT 0,
    discount_total DECIMAL(12,2) NOT NULL DEFAULT 0,
    shipping_total DECIMAL(12,2) NOT NULL DEFAULT 0,
    tax_total      DECIMAL(12,2) NOT NULL DEFAULT 0,
    grand_total    DECIMAL(12,2) NOT NULL DEFAULT 0,
    coupon_code VARCHAR(60) DEFAULT NULL,
    billing_json  JSON DEFAULT NULL,
    shipping_json JSON DEFAULT NULL,
    payment_method VARCHAR(60) DEFAULT NULL,
    payment_status ENUM('unpaid','paid','refunded','failed') NOT NULL DEFAULT 'unpaid',
    customer_note VARCHAR(1000) DEFAULT NULL,
    event_id CHAR(36) DEFAULT NULL,
    ip_address VARCHAR(45) DEFAULT NULL,
    user_agent VARCHAR(500) DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    paid_at DATETIME DEFAULT NULL,
    INDEX idx_ord_status (status, created_at),
    INDEX idx_ord_customer (customer_id),
    CONSTRAINT fk_ord_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT DEFAULT NULL,
    variation_id INT DEFAULT NULL,
    sku VARCHAR(100) DEFAULT NULL,
    name VARCHAR(255) NOT NULL,
    qty INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    line_total DECIMAL(12,2) NOT NULL,
    INDEX idx_oi_order (order_id),
    CONSTRAINT fk_oi_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS order_status_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status VARCHAR(40) NOT NULL,
    note VARCHAR(500) DEFAULT NULL,
    created_by INT DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_osh_order (order_id, created_at),
    CONSTRAINT fk_osh_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    provider VARCHAR(40) NOT NULL,                 -- transbank | flow | mercadopago
    provider_payment_id VARCHAR(190) DEFAULT NULL UNIQUE,
    status VARCHAR(40) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'CLP',
    raw_payload JSON DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_pay_order (order_id),
    CONSTRAINT fk_pay_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
