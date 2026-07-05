-- ============================================================================
-- 046: Bloque "Más de 15 años" (story) del home — rediseño visual.
-- ----------------------------------------------------------------------------
-- El bloque ahora tiene kicker, badge "+15 años" sobre la foto y bullets con
-- íconos (atención personalizada / responsabilidad ambiental / canales) que
-- viven en el template (lib/home.php), igual que los beneficios.
-- El cuerpo largo se acorta para no repetir lo que ya dicen los bullets:
-- mismo copy del cliente (migración 044), solo redistribuido.
-- ============================================================================

INSERT INTO settings (setting_key, setting_value) VALUES
    ('home_story_body', 'Somos una empresa chilena dedicada a entregar soluciones de packaging, higiene y aseo, con respuestas concretas y entregas confiables para empresas de toda escala.')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);
