-- ============================================================
-- SEED: Datos demo de contacto + redes para footer.
-- ============================================================
-- Llena settings de contacto (teléfono, email, dirección, horario) y redes
-- sociales con datos demo de GreenBags. Sirve para que el footer rediseñado
-- (logo + tagline + contacto + redes) muestre información real sin que el
-- cliente tenga que entrar al admin primero.
--
-- Estrategia "fill if empty": cada UPDATE pisa el valor SOLO si la clave
-- está vacía/NULL. Si el cliente ya editó algo desde el admin (ej. su mail
-- real), no se sobreescribe.
--
-- Idempotente: se puede correr varias veces sin efecto si ya hay datos.
-- ============================================================

-- ── Identidad: tagline (bajada del logo en el footer) ──
UPDATE settings
   SET setting_value = 'Packaging sustentable para empresas que valoran calidad, rapidez y compromiso ambiental.'
 WHERE setting_key = 'business_tagline'
   AND (setting_value IS NULL OR setting_value = '');

-- ── Contacto ──
UPDATE settings
   SET setting_value = '+56 9 1234 5678'
 WHERE setting_key = 'business_phone'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = 'contacto@greenbags.cl'
 WHERE setting_key = 'business_email'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = '56912345678'
 WHERE setting_key = 'business_whatsapp'
   AND (setting_value IS NULL OR setting_value = '');

-- ── Dirección ──
UPDATE settings
   SET setting_value = 'Av. Providencia 1234, Of. 501'
 WHERE setting_key = 'business_address'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = 'Santiago'
 WHERE setting_key = 'business_city'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = 'Región Metropolitana'
 WHERE setting_key = 'business_region'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = 'Chile'
 WHERE setting_key = 'business_country'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = 'Lun-Vie 9:00-18:00'
 WHERE setting_key = 'business_hours'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = 'https://maps.google.com/?q=Av.+Providencia+1234,+Santiago,+Chile'
 WHERE setting_key = 'business_maps_url'
   AND (setting_value IS NULL OR setting_value = '');

-- ── Redes sociales (demo, links a páginas oficiales si existieran) ──
UPDATE settings
   SET setting_value = 'https://www.facebook.com/greenbags'
 WHERE setting_key = 'social_facebook'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = 'https://www.instagram.com/greenbags'
 WHERE setting_key = 'social_instagram'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = 'https://www.linkedin.com/company/greenbags'
 WHERE setting_key = 'social_linkedin'
   AND (setting_value IS NULL OR setting_value = '');

UPDATE settings
   SET setting_value = 'https://www.tiktok.com/@greenbags'
 WHERE setting_key = 'social_tiktok'
   AND (setting_value IS NULL OR setting_value = '');
