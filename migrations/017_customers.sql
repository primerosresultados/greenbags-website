-- Compradores (separados de `users`, que son administradores del panel).
-- Soporta cuenta con contraseña o invitado (guest checkout, password_hash NULL).

CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) DEFAULT NULL,
    first_name VARCHAR(120) DEFAULT NULL,
    last_name VARCHAR(120) DEFAULT NULL,
    phone VARCHAR(60) DEFAULT NULL,
    is_guest TINYINT(1) NOT NULL DEFAULT 0,
    email_verified_at DATETIME DEFAULT NULL,
    marketing_opt_in TINYINT(1) NOT NULL DEFAULT 0,
    last_login_at DATETIME DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_cust_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS customer_addresses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    type ENUM('shipping','billing') NOT NULL DEFAULT 'shipping',
    full_name VARCHAR(180) DEFAULT NULL,
    line1 VARCHAR(255) DEFAULT NULL,
    line2 VARCHAR(255) DEFAULT NULL,
    city VARCHAR(120) DEFAULT NULL,
    region VARCHAR(120) DEFAULT NULL,
    postal_code VARCHAR(30) DEFAULT NULL,
    country VARCHAR(2) NOT NULL DEFAULT 'CL',
    phone VARCHAR(60) DEFAULT NULL,
    is_default TINYINT(1) NOT NULL DEFAULT 0,
    INDEX idx_addr_customer (customer_id),
    CONSTRAINT fk_addr_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
