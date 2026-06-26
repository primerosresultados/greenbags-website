-- ============================================================
-- CLIENTE: GreenBags - banner hero: quita "Atencion directa de los duenos".
-- (PDF jun 2026, punto 4). El hero del home usa el banner home_hero, no el
-- setting home_hero_subtitle, asi que el texto vive en la tabla banners.
-- REPLACE idempotente; respeta ediciones desde admin -> Banners.
-- ============================================================

UPDATE banners SET subtitle = REPLACE(subtitle, 'Despachos en 24-48 horas en Región Metropolitana · Atención directa de los dueños · Productos ecológicos certificados.', 'Despachos en 24-48 horas en Región Metropolitana · Productos ecológicos certificados.')
 WHERE position = 'home_hero';
