-- Banners reutilizables. La columna `position` permite tener banners para
-- distintas zonas (home_hero, tienda_top, etc.); por ahora se usa home_hero.
-- image_id apunta a la mediateca; alt cae a `eyebrow` o `title` si no existe.

CREATE TABLE IF NOT EXISTS banners (
    id INT AUTO_INCREMENT PRIMARY KEY,
    position VARCHAR(40) NOT NULL DEFAULT 'home_hero',
    eyebrow VARCHAR(120) DEFAULT NULL,
    title VARCHAR(200) NOT NULL,
    subtitle VARCHAR(400) DEFAULT NULL,
    image_id INT DEFAULT NULL,
    cta_label VARCHAR(80) DEFAULT NULL,
    cta_url VARCHAR(255) DEFAULT NULL,
    text_align ENUM('left','center','right') NOT NULL DEFAULT 'left',
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_banner_pos (position, is_active, sort_order),
    CONSTRAINT fk_banner_img FOREIGN KEY (image_id) REFERENCES media_library(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
