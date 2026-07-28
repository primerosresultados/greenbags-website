-- ============================================================================
-- Editor de bloques para las páginas del CMS.
-- ----------------------------------------------------------------------------
-- Hasta ahora el contenido de una página vivía como un único blob de HTML en
-- pages.body (20 KB con <style> incluido en "Sobre GreenBags"): imposible de
-- editar desde el panel sin romper el diseño. A partir de acá cada página es
-- una lista ordenada de bloques tipados; el admin sólo llena campos (títulos,
-- textos, imágenes) y el HTML/CSS lo pone el template.
--
-- `data` guarda los campos del bloque como JSON (LONGTEXT por compatibilidad
-- con MySQL 5.7 en hostings compartidos; se valida contra el schema de
-- lib/blocks.php al guardar, no en la BD).
--
-- pages.body se conserva: una página sin bloques sigue renderizando su HTML
-- como siempre (fallback), así ninguna instalación existente se rompe.
-- ============================================================================

CREATE TABLE IF NOT EXISTS page_blocks (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    page_id    INT NOT NULL,
    type       VARCHAR(40) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active  TINYINT(1) NOT NULL DEFAULT 1,
    data       LONGTEXT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_page_blocks_page (page_id, sort_order),
    CONSTRAINT fk_page_blocks_page FOREIGN KEY (page_id) REFERENCES pages (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
