-- ============================================================
-- Quita el voseo argentino de la banda CTA / suscripción del home.
-- ============================================================
-- El seed 028 de GreenBags dejó en `home_cta_subtitle`:
--   "Pedí una cotización personalizada o descargá nuestro catálogo."
-- (formas voseo: Pedí, descargá). Como GreenBags es Chile, lo normalizamos
-- al tuteo neutro: "Pide … descarga".
--
-- Estrategia: solo actualiza si el setting sigue siendo el valor exacto
-- sembrado. Si el cliente ya lo editó desde admin → Configuración, no se
-- toca. Idempotente.
-- ============================================================

UPDATE settings
   SET setting_value = 'Pide una cotización personalizada o descarga nuestro catálogo.'
 WHERE setting_key = 'home_cta_subtitle'
   AND setting_value = 'Pedí una cotización personalizada o descargá nuestro catálogo.';
