-- ============================================================================
-- "Nuestros clientes" del home → tabla propia para poder editar cada cliente
-- (nombre + su logo) desde el admin, en vez del logo genérico único que había.
-- ----------------------------------------------------------------------------
-- El logo se guarda como ruta (logo_path), igual que home_story_image, para
-- reutilizar el selector de Medios (_single_image_field.php).
-- Idempotente: CREATE IF NOT EXISTS + INSERT ... WHERE NOT EXISTS por nombre.
-- ============================================================================

CREATE TABLE IF NOT EXISTS home_clients (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(160) NOT NULL,
    logo_path  VARCHAR(255) DEFAULT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active  TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed inicial: los nombres que ya mostraba la home (migración 044). Sin logo
-- todavía (se cargan desde el admin). Solo se insertan si la tabla está vacía
-- para no pisar ediciones posteriores.
INSERT INTO home_clients (name, sort_order, is_active)
SELECT * FROM (
    SELECT 'Ají Seco' AS name, 1 AS sort_order, 1 AS is_active UNION ALL
    SELECT 'Fuente Suiza', 2, 1 UNION ALL
    SELECT 'Buenos Muchachos', 3, 1 UNION ALL
    SELECT 'Hotel Hilton', 4, 1 UNION ALL
    SELECT 'Banco Santander', 5, 1
) AS seed
WHERE NOT EXISTS (SELECT 1 FROM home_clients LIMIT 1);
