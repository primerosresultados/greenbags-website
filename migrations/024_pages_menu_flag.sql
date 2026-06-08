-- Permite ocultar páginas del menú principal sin despublicarlas (por ejemplo
-- la página "Gracias" después de un lead, términos legales, FAQ extenso).
-- La marca por defecto a slugs típicos para que la home no las exponga.

ALTER TABLE pages
    ADD COLUMN exclude_from_menu TINYINT(1) NOT NULL DEFAULT 0 AFTER is_published;

UPDATE pages
SET exclude_from_menu = 1
WHERE slug IN ('gracias', 'thanks', 'thank-you', 'gracias-por-comprar', 'thank-you-purchase');
