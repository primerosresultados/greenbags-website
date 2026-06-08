-- ============================================================
-- CLIENTE: GreenBags — fijar URL del CTA "Conocer GreenBags"
-- ============================================================
-- La seed 028 inserta home_story_cta_url = '/sobre-greenbags' pero usa
-- ON DUPLICATE KEY UPDATE setting_key = setting_key (no-op), así que
-- instalaciones donde la fila ya existía (con otro valor o vacía) no
-- quedaron apuntando a la página correcta.
--
-- Esta migración fuerza el valor a '/sobre-greenbags' para garantizar
-- que el CTA del bloque story del home (lib/home.php) vaya a la página
-- de marca "Sobre GreenBags". También deja el label canónico por si
-- alguien lo cambió.
--
-- Idempotente. Al forkear el starter, borrar este archivo junto con
-- 028, 029, 030, 031.
-- ============================================================

INSERT INTO settings (setting_key, setting_value) VALUES
    ('home_story_cta_url',   '/sobre-greenbags'),
    ('home_story_cta_label', 'Conocer GreenBags')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);
