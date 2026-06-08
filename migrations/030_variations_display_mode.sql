-- Modo de visualización de variaciones en la ficha de producto.
-- Global (no por producto): se decide en admin → Configuración.
--   `swatches` (default): grid de botones tipo chip (look actual).
--   `select`:             dropdowns. Mejor cuando un atributo tiene muchos
--                         valores (ej. 15+ tamaños) y los chips se desbordan.
INSERT INTO settings (setting_key, setting_value) VALUES
    ('variations_display_mode', 'swatches')
ON DUPLICATE KEY UPDATE setting_key = setting_key;
