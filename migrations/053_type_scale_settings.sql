-- ============================================================================
-- Escala tipográfica global editable desde el panel.
-- ----------------------------------------------------------------------------
-- Dos settings (porcentaje 85–140, default 100 = sin cambios) que lib/layout.php
-- convierte en CSS var + override de tamaño para TODO el sitio público:
--   - type_scale_headings → escala la raíz rem (títulos y elementos en rem).
--   - type_scale_body      → escala --font-size-base (texto de párrafos).
-- Solo se insertan si no existen (no pisa un valor ya elegido por el admin).
-- ============================================================================

INSERT INTO settings (setting_key, setting_value) VALUES
    ('type_scale_headings', '100'),
    ('type_scale_body',     '100')
ON DUPLICATE KEY UPDATE setting_value = setting_value;
