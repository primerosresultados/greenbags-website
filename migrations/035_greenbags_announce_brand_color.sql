-- ============================================================
-- SEED: Announce bar con color de marca para GreenBags.
-- ============================================================
-- La franja superior (announce bar, donde dice "Despachos en 24-48 hs...")
-- pasa del verde oscuro `#1f3a2b` al primario de marca `#73BF6D`. El texto
-- queda en blanco; el negrita del título lo mantiene legible sobre el verde
-- más claro.
--
-- Estrategia: pisa el `announce_bg` SOLO si:
--   - está vacío/NULL, o
--   - sigue siendo el viejo default (#1f3a2b).
-- Si el cliente ya eligió otro color desde admin → Configuración, no se toca.
-- Idempotente.
-- ============================================================

UPDATE settings
   SET setting_value = '#73BF6D'
 WHERE setting_key = 'announce_bg'
   AND (setting_value IS NULL
        OR setting_value = ''
        OR LOWER(setting_value) = '#1f3a2b');

-- El fg blanco ya es el default — solo lo aseguramos si quedó vacío.
UPDATE settings
   SET setting_value = '#ffffff'
 WHERE setting_key = 'announce_fg'
   AND (setting_value IS NULL OR setting_value = '');
