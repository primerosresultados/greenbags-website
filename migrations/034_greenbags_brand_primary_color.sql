-- ============================================================
-- SEED: Color primario de marca para GreenBags.
-- ============================================================
-- Establece `theme_primary` en #73BF6D (verde marca real, más claro y vibrante
-- que el #2f7a3a que dejó el seed inicial).
--
-- Estrategia: pisa el valor SOLO si:
--   - está vacío/NULL, o
--   - sigue siendo el viejo default (#2f7a3a).
-- Si el cliente ya eligió otro color desde el admin, no se toca.
-- Idempotente.
-- ============================================================

UPDATE settings
   SET setting_value = '#73BF6D'
 WHERE setting_key = 'theme_primary'
   AND (setting_value IS NULL
        OR setting_value = ''
        OR LOWER(setting_value) = '#2f7a3a');
