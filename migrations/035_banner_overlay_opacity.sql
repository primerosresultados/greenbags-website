-- ============================================================
-- Banners: control de opacidad del overlay (izquierda / derecha)
-- ============================================================
-- El slide del hero tiene un degradé oscuro sobre la imagen (135deg, left→
-- right) que asegura legibilidad del texto. Hasta ahora el degradé era fijo
-- en CSS: rgba(15,23,42,.86) → rgba(15,23,42,.55).
--
-- Estas columnas permiten controlar las dos paradas del degradé por banner
-- desde admin → Banners. Por ej. bajar overlay_right a 10 deja casi
-- transparente la derecha y se ve la imagen.
--
-- Tipo: TINYINT UNSIGNED (0-100, porcentaje). Defaults coinciden con el
-- gradiente original para preservar la apariencia actual de banners ya
-- creados (86% izquierda, 55% derecha).
-- ============================================================

ALTER TABLE banners
    ADD COLUMN overlay_left  TINYINT UNSIGNED NOT NULL DEFAULT 86 AFTER text_align,
    ADD COLUMN overlay_right TINYINT UNSIGNED NOT NULL DEFAULT 55 AFTER overlay_left;
