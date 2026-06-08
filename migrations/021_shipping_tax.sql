-- Envíos (zonas + métodos) e impuestos.
-- En Chile el IVA (19%) va incluido en el precio: para ese caso alcanza con
-- `tax_rate` en settings. La tabla tax_rates queda lista por si en el futuro
-- se vende a otras jurisdicciones.

CREATE TABLE IF NOT EXISTS shipping_zones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    regions VARCHAR(500) DEFAULT NULL,   -- CSV de regiones/comunas de Chile, o países
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    sort_order INT NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS shipping_methods (
    id INT AUTO_INCREMENT PRIMARY KEY,
    zone_id INT NOT NULL,
    name VARCHAR(120) NOT NULL,
    type ENUM('flat','free','weight','pickup') NOT NULL DEFAULT 'flat',
    cost DECIMAL(12,2) NOT NULL DEFAULT 0,
    free_over DECIMAL(12,2) DEFAULT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    sort_order INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_sm_zone FOREIGN KEY (zone_id) REFERENCES shipping_zones(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tax_rates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(2) DEFAULT NULL,
    region VARCHAR(120) DEFAULT NULL,
    name VARCHAR(80) NOT NULL,
    rate DECIMAL(7,4) NOT NULL,
    priority INT NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
