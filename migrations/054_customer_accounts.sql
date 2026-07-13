-- ============================================================
-- Cuentas de cliente (login real en /mi-cuenta)
-- ============================================================
-- La tabla `customers` ya existe (migración 017: soporta cuenta con
-- contraseña o invitado para checkout). Reutilizamos esa tabla —la misma
-- a la que apunta quotes.customer_id (migración 027)— y le agregamos las
-- columnas que faltan para el flujo de cuenta pública: verificación de
-- email, recuperación de contraseña, datos comerciales y baja lógica.
--
-- MySQL 8/9 no soporta ADD COLUMN IF NOT EXISTS; la migración corre una sola
-- vez (registrada en la tabla `migrations`), así que las columnas no existen
-- todavía al aplicarla.
-- ============================================================

ALTER TABLE customers
    ADD COLUMN company          VARCHAR(180) DEFAULT NULL,
    ADD COLUMN taxid            VARCHAR(40)  DEFAULT NULL,
    ADD COLUMN verify_token     CHAR(64)     DEFAULT NULL,
    ADD COLUMN verify_sent_at   DATETIME     DEFAULT NULL,
    ADD COLUMN reset_token      CHAR(64)     DEFAULT NULL,
    ADD COLUMN reset_expires_at DATETIME     DEFAULT NULL,
    ADD COLUMN is_active        TINYINT(1)   NOT NULL DEFAULT 1;

ALTER TABLE customers ADD INDEX idx_cust_verify (verify_token);
ALTER TABLE customers ADD INDEX idx_cust_reset  (reset_token);

-- Rate-limit de login de clientes (independiente del de staff `login_attempts`).
CREATE TABLE IF NOT EXISTS customer_login_attempts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ip_address   VARCHAR(45)  DEFAULT NULL,
    email        VARCHAR(190) DEFAULT NULL,
    attempted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_cla_ip    (ip_address, attempted_at),
    INDEX idx_cla_email (email, attempted_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
