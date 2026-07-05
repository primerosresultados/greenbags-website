-- ============================================================================
-- CLIENTE: GreenBags — Feedback PDF (14 puntos) sobre el landing.
-- ----------------------------------------------------------------------------
-- Aplica de forma idempotente los ajustes de contenido/branding pedidos:
--   1. Logo más grande            → CSS (site_header.css), no requiere seed.
--   2. Redes sociales correctas   → Instagram oficial; se limpian las demás.
--   3. Eliminar topbar/anuncio     → header_show_topbar=0, announce_enabled=0.
--   4. Hero: imagen de packaging clara (el texto ya se limpió en 040).
--   5. Eliminar tira de beneficios → home_show_benefits=0.
--   7. Eliminar "Lo más buscado"   → home_show_featured=0.
--   8. Bloque "15 años" tras el hero + texto revisado (reorden en home.php).
--   9. "Nuestros clientes" al final (marquesina con logo genérico).
--  10. Contactos y dirección reales (Lope de Vega 4516, Estación Central).
--  11. Retiro en bodega previa coordinación (nota en contacto).
--  12. "Sobre GreenBags": reescrito (sin duplicar dueños, sin foodtruck,
--      sin bloque de stats repetido, sin sección de equipo pendiente).
--  13. "Compromiso sustentable": estructura Ley 21368 + certificaciones.
--   6/14. Categorías e importación: quedan como tarea de datos aparte.
--
-- Nota: los UPDATE de settings pisan ediciones de admin sobre esas claves.
-- ============================================================================

-- --- 2. Redes sociales: Instagram oficial y limpiar cuentas equivocadas ------
INSERT INTO settings (setting_key, setting_value) VALUES
    ('social_instagram', 'https://www.instagram.com/greenbagsspa'),
    ('social_facebook',  ''),
    ('social_linkedin',  ''),
    ('social_youtube',   ''),
    ('social_tiktok',    ''),
    ('social_x',         '')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- --- 3. Ocultar topbar de contacto y barra de anuncio ------------------------
INSERT INTO settings (setting_key, setting_value) VALUES
    ('header_show_topbar', '0'),
    ('announce_enabled',   '0')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- --- 5 y 7. Ocultar beneficios y "Lo más buscado" ---------------------------
INSERT INTO settings (setting_key, setting_value) VALUES
    ('home_show_benefits', '0'),
    ('home_show_featured', '0')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- --- 8. Bloque "Más de 15 años" (story) — texto revisado --------------------
INSERT INTO settings (setting_key, setting_value) VALUES
    ('home_show_story',       '1'),
    ('home_story_title',      'Más de 15 años junto a empresas chilenas'),
    ('home_story_body',       'Somos una empresa chilena dedicada a entregar soluciones de packaging, higiene y aseo a empresas que valoran la rapidez, la atención personalizada y la responsabilidad ambiental. Garantizamos respuestas concretas y entregas confiables. Acompañamos a clientes de canal Horeca, retail, industria y emprendedores con productos certificados y opciones sustentables que se adaptan a su escala.'),
    ('home_story_cta_label',  'Conocer GreenBags'),
    ('home_story_cta_url',    '/sobre-greenbags'),
    ('home_story_image',      '/uploads/library/greenbags/horeca-alimentos.jpg')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- --- 9. Marquesina de clientes al final -------------------------------------
INSERT INTO settings (setting_key, setting_value) VALUES
    ('home_show_clients',  '1'),
    ('home_clients_title', 'Nuestros clientes'),
    ('home_clients_names', 'Ají Seco|Fuente Suiza|Buenos Muchachos|Hotel Hilton|Banco Santander'),
    ('home_clients_logo',  '/uploads/library/greenbags/cliente-logo.svg')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- --- 10. Dirección real y contactos comerciales -----------------------------
INSERT INTO settings (setting_key, setting_value) VALUES
    ('business_address',        'Lope de Vega 4516'),
    ('business_city',           'Estación Central'),
    ('business_region',         'Región Metropolitana'),
    ('business_country',        'Chile'),
    ('contact_person_1_name',   'Felipe Tapia'),
    ('contact_person_1_role',   'Contacto comercial'),
    ('contact_person_1_phone',  '+56 9 9822 0252'),
    ('contact_person_1_email',  'ftapia@greenbags.cl'),
    ('contact_person_2_name',   'Alvaro Merello'),
    ('contact_person_2_role',   'Contacto comercial'),
    ('contact_person_2_phone',  '+56 9 8358 2322'),
    ('contact_person_2_email',  'amerello@greenbags.cl')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- --- 11. Retiro en bodega (nota en la intro de contacto) ---------------------
INSERT INTO settings (setting_key, setting_value) VALUES
    ('contact_intro', 'Elige el canal que más te acomode; respondemos en horario hábil, normalmente en menos de 4 horas. También puedes retirar tu pedido en bodega (Lope de Vega 4516, Estación Central) previa coordinación.')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- --- 4. Imagen del hero: registrar en media_library y asignar al banner ------
INSERT INTO media_library (file_path, alt, title, mime, folder_id)
SELECT '/uploads/library/greenbags/hero-packaging.jpg',
       'Packaging sustentable de GreenBags',
       'Hero packaging GreenBags',
       'image/jpeg',
       (SELECT id FROM media_folders WHERE slug = 'marca' LIMIT 1)
WHERE NOT EXISTS (
    SELECT 1 FROM media_library WHERE file_path = '/uploads/library/greenbags/hero-packaging.jpg'
);

UPDATE banners
SET image_id = (SELECT id FROM media_library WHERE file_path = '/uploads/library/greenbags/hero-packaging.jpg' LIMIT 1)
WHERE position = 'home_hero';

-- Fallback (instalaciones sin banners): setting de imagen del hero.
INSERT INTO settings (setting_key, setting_value) VALUES
    ('home_hero_image', '/uploads/library/greenbags/hero-packaging.jpg')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- --- 12. "Sobre GreenBags": reescritura limpia ------------------------------
UPDATE pages SET body =
'<style>
  .gb-about{--gb:#51af3f;--gb-d:#3c8a2e;}
  .gb-about p{color:#475569;line-height:1.7;max-width:70ch;}
  .gb-about h2{color:#0f172a;font-size:1.5rem;margin:2.4rem 0 .8rem;}
  .gb-about .gb-lead{font-size:1.15rem;color:#334155;}
  .gb-about__media{margin:1.6rem 0;border-radius:18px;overflow:hidden;max-height:360px;}
  .gb-about__media img{width:100%;height:100%;object-fit:cover;display:block;}
  .gb-pillars{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1rem;margin:1.4rem 0;}
  .gb-pillar{background:#f6faf4;border:1px solid #e1ebdd;border-radius:16px;padding:1.4rem;}
  .gb-pillar h3{margin:.2rem 0 .5rem;color:#0f172a;font-size:1.1rem;}
  .gb-pillar p{margin:0;font-size:.95rem;}
  .gb-pillar__ico{width:42px;height:42px;border-radius:12px;background:rgba(81,175,63,.14);color:var(--gb-d);display:flex;align-items:center;justify-content:center;margin-bottom:.6rem;}
  .gb-note{background:#f1f5f9;border-left:4px solid var(--gb);border-radius:8px;padding:1rem 1.2rem;color:#334155;margin:1.6rem 0;}
</style>
<div class="gb-about">
  <p class="gb-lead">GreenBags nació con la misión de entregar a las empresas soluciones de packaging, higiene y aseo industrial que combinen calidad, rapidez y responsabilidad ambiental.</p>
  <div class="gb-about__media"><img src="/uploads/library/greenbags/eco-sustentable.jpg" alt="Compromiso ecológico de GreenBags" loading="lazy"></div>
  <h2>Una empresa chilena con foco en el detalle</h2>
  <p>Después de más de 15 años en el rubro, somos una alternativa real para quienes valoran la atención cercana y necesitan un proveedor que cumpla. Sin intermediarios: trabajas directamente con quienes toman las decisiones.</p>
  <p>Acompañamos a clientes de canal Horeca, retail, industria y emprendedores, con productos biodegradables y compostables certificados y despachos confiables en 24-48 horas dentro de la Región Metropolitana.</p>
  <h2>Tres pilares que marcan la diferencia</h2>
  <div class="gb-pillars">
    <div class="gb-pillar">
      <div class="gb-pillar__ico"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg></div>
      <h3>Atención cercana</h3>
      <p>Hablas con quienes resuelven, sin call centers ni capas intermedias.</p>
    </div>
    <div class="gb-pillar">
      <div class="gb-pillar__ico"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M11 20A7 7 0 0 1 4 13c0-5 4-9 16-10 0 12-4 16-9 17z"/><path d="M4 21c2-6 6-9 12-10"/></svg></div>
      <h3>Sustentables y certificados</h3>
      <p>Productos biodegradables y compostables certificados, alineados a la Ley REP y políticas ESG.</p>
    </div>
    <div class="gb-pillar">
      <div class="gb-pillar__ico"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M13 2 3 14h7l-1 8 10-12h-7l1-8z"/></svg></div>
      <h3>Despachos en 24-48 horas</h3>
      <p>Logística confiable en la Región Metropolitana y cobertura nacional coordinada.</p>
    </div>
  </div>
  <div class="gb-note">Retiro en bodega disponible en Lope de Vega 4516, Estación Central, previa coordinación.</div>
</div>'
WHERE slug = 'sobre-greenbags';

-- --- 13. "Compromiso sustentable": Ley 21368 + certificaciones --------------
UPDATE pages SET body =
'<style>
  .gb-sust{--gb:#51af3f;--gb-d:#3c8a2e;}
  .gb-sust p{color:#475569;line-height:1.7;max-width:70ch;}
  .gb-sust h2{color:#0f172a;font-size:1.5rem;margin:2.4rem 0 .8rem;}
  .gb-sust__media{margin:1.6rem 0;border-radius:18px;overflow:hidden;max-height:360px;}
  .gb-sust__media img{width:100%;height:100%;object-fit:cover;display:block;}
  .gb-law{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:1rem;margin:1.4rem 0;}
  .gb-law__card{background:#f6faf4;border:1px solid #e1ebdd;border-radius:16px;padding:1.4rem;}
  .gb-law__card h3{margin:0 0 .5rem;color:var(--gb-d);font-size:1.05rem;}
  .gb-law__card p{margin:0;font-size:.95rem;}
  .gb-certs a{color:var(--gb-d);font-weight:600;}
  .gb-pending{display:inline-block;background:#fef9c3;color:#854d0e;border-radius:999px;padding:.15rem .7rem;font-size:.8rem;font-weight:600;margin-left:.4rem;vertical-align:middle;}
</style>
<div class="gb-sust">
  <p style="font-size:1.15rem;color:#334155;">En GreenBags trabajamos por una economía circular real: reducir, reutilizar y reemplazar los plásticos de un solo uso por alternativas certificadas.</p>
  <div class="gb-sust__media"><img src="/uploads/library/greenbags/eco-sustentable.jpg" alt="Compromiso ecológico y sustentable" loading="lazy"></div>
  <h2>Marco legal: Ley 21.368 <span class="gb-pending">Info en actualización</span></h2>
  <p>La Ley 21.368 regula la entrega de productos de plástico de un solo uso y promueve el uso de envases certificados como compostables o reutilizables. Acompañamos a nuestros clientes en el cumplimiento con soluciones alineadas a esta normativa.</p>
  <div class="gb-law">
    <div class="gb-law__card"><h3>Plásticos de un solo uso</h3><p>Reemplazo por materiales de origen vegetal (fibra de caña, cartón y papel kraft) certificados.</p></div>
    <div class="gb-law__card"><h3>Certificación de compostabilidad</h3><p>Productos con certificación de compostabilidad y biodegradabilidad según normas vigentes.</p></div>
    <div class="gb-law__card"><h3>Ley REP</h3><p>Responsabilidad Extendida del Productor: apoyamos la gestión responsable de residuos de envases y embalajes.</p></div>
  </div>
  <h2>Certificaciones</h2>
  <p class="gb-certs">El detalle de nuestras certificaciones está en actualización. Referencias:
    <a href="https://tugou.cl/eco-tugou/" target="_blank" rel="noopener">tugou.cl/eco-tugou</a> ·
    <a href="https://ecoitalia.cl/certificaciones" target="_blank" rel="noopener">ecoitalia.cl/certificaciones</a>.
  </p>
</div>'
WHERE slug = 'sustentabilidad';
