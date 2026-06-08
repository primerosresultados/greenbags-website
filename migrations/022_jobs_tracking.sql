-- Infraestructura para shared hosting (sin workers persistentes):
--   * jobs            → cola drenada por cron (emails, reintento de webhooks).
--   * tracking_events → eventos de conversión enviados server-side a Meta CAPI,
--                       GA4 (Measurement Protocol) y Google Ads, con dedup por event_id.
--   * stock_movements → auditoría de cambios de inventario.

CREATE TABLE IF NOT EXISTS jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(60) NOT NULL,
    payload JSON NOT NULL,
    status ENUM('pending','processing','done','failed') NOT NULL DEFAULT 'pending',
    attempts INT NOT NULL DEFAULT 0,
    run_after DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_error VARCHAR(1000) DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_jobs_run (status, run_after)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tracking_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(60) NOT NULL,
    event_id CHAR(36) NOT NULL,
    order_id INT DEFAULT NULL,
    customer_id INT DEFAULT NULL,
    value DECIMAL(12,2) DEFAULT NULL,
    currency VARCHAR(3) DEFAULT NULL,
    payload JSON DEFAULT NULL,
    sent_capi TINYINT(1) NOT NULL DEFAULT 0,
    sent_ga4  TINYINT(1) NOT NULL DEFAULT 0,
    sent_gads TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_te_eventid (event_id),
    INDEX idx_te_event (event_name, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS stock_movements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT DEFAULT NULL,
    variation_id INT DEFAULT NULL,
    change_qty INT NOT NULL,
    reason VARCHAR(60) NOT NULL,
    order_id INT DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_sm_product (product_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
