-- ============================================================================
-- El copy fijo del home pasa a settings editables (admin → Inicio).
-- ----------------------------------------------------------------------------
-- Hasta ahora estos textos estaban escritos dentro de lib/home.php: los puntos
-- del hero, la franja de beneficios, los ítems del bloque de marca, los títulos
-- de cada sección y todos los textos del formulario de cotización. Cambiar una
-- coma requería tocar código y desplegar.
--
-- Se siembran con los valores que el sitio ya mostraba, así el panel aparece
-- pre-cargado y el cliente ve exactamente lo que hay publicado.
--
-- Importante: getSetting() sólo aplica el default del código cuando la clave NO
-- existe. Al sembrarla acá, vaciar el campo en el panel pasa a significar
-- "ocultar este texto" (que es lo que un cliente espera), en vez de reaparecer
-- el default.
--
-- ON DUPLICATE KEY ... = setting_key es un no-op deliberado: si la clave ya
-- existe (instalación que ya editó el texto) no se pisa nada.
-- ============================================================================

INSERT INTO settings (setting_key, setting_value) VALUES
    -- Hero: puntos con ícono + botón de WhatsApp
    ('home_hero_point_1',  'Despacho en 24-48 hs'),
    ('home_hero_point_2',  'Packaging certificado'),
    ('home_hero_point_3',  '+15 años de experiencia'),
    ('home_hero_wa_label', 'Escribir por WhatsApp'),

    -- Franja de beneficios (íconos fijos por posición)
    ('home_benefit_1_title', 'Envíos rápidos'),
    ('home_benefit_1_desc',  'Despacho en 24-48 horas.'),
    ('home_benefit_2_title', 'Pago seguro'),
    ('home_benefit_2_desc',  'Múltiples medios de pago.'),
    ('home_benefit_3_title', 'Cambios y devoluciones'),
    ('home_benefit_3_desc',  'Hasta 10 días.'),
    ('home_benefit_4_title', 'Atención al cliente'),
    ('home_benefit_4_desc',  'Te respondemos por WhatsApp.'),

    -- Bloque de marca
    ('home_story_kicker',     'Empresa chilena'),
    ('home_story_chip',       'Entregas confiables'),
    ('home_story_badge_num',  '+15'),
    -- El salto de línea reproduce el <br> que tenía el template.
    ('home_story_badge_text', CONCAT('años de', CHAR(10), 'experiencia')),
    ('home_story_feat_1_title', 'Atención personalizada'),
    ('home_story_feat_1_desc',  'Rapidez y trato directo con quienes toman las decisiones.'),
    ('home_story_feat_2_title', 'Responsabilidad ambiental'),
    ('home_story_feat_2_desc',  'Productos certificados y opciones sustentables a tu escala.'),
    ('home_story_feat_3_title', 'Para cada canal'),
    ('home_story_feat_3_desc',  'Horeca, retail, industria y emprendedores.'),

    -- Encabezados de sección
    ('home_cats_title',       'Nuestras Categorías'),
    ('home_cats_link',        'Ver catálogo →'),
    ('home_sellers_title',    'Habla con un ejecutivo'),
    ('home_sellers_subtitle', 'Atención directa y sin intermediarios'),
    ('home_featured_title',   'Lo más buscado'),
    ('home_featured_link',    'Ver todo →'),

    -- Modal de cotización
    ('home_quote_title',    'Cotiza tu packaging'),
    ('home_quote_subtitle', 'Cuéntanos qué necesitas y te respondemos en menos de 24 hs hábiles, sin compromiso.'),
    ('home_quote_button',   'Solicitar cotización'),
    ('home_quote_trust',    'Sin compromiso · Respuesta por WhatsApp o email'),
    ('home_quote_ok_title', '¡Gracias por escribirnos!'),
    ('home_quote_ok_text',  'Te responderemos a la brevedad.')
ON DUPLICATE KEY UPDATE setting_key = setting_key;
