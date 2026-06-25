-- ============================================================
-- CLIENTE: GreenBags - hero de "Sobre GreenBags": quita repeticion duenos.
-- (PDF jun 2026, punto 12: "Eliminar: atendida directamente por sus duenos")
-- REPLACE idempotente; no-op si ya se edito desde admin.
-- ============================================================

UPDATE pages SET body = REPLACE(body, 'Somos una empresa chilena dedicada al packaging, productos de higiene y aseo industrial. Atendidos directamente por sus dueños, garantizamos respuestas concretas y entregas confiables en todo el país.', 'Somos una empresa chilena dedicada al packaging, productos de higiene y aseo industrial. Garantizamos respuestas concretas y entregas confiables en todo el país.')
 WHERE slug = 'sobre-greenbags';
