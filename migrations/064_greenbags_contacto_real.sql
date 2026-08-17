-- ============================================================
-- CLIENTE: GreenBags — reemplaza los teléfonos demo por los reales.
-- ============================================================
-- La migración 033_contact_page_seed sembró datos de ejemplo con estrategia
-- "fill if empty" (las claves estaban vacías, así que se llenaron con demo) y
-- nunca se pisaron. Resultado en producción:
--
--   business_phone    = '+56 2 2234 5678'   ← inventado
--   business_whatsapp = '56912345678'       ← inventado, y es el número que
--                                             dispara el botón flotante de
--                                             WhatsApp (components/whatsapp_float.php)
--
-- Los números reales ya estaban cargados desde la 037, pero en otras claves
-- (contact_person_1_* / contact_person_2_*), que sólo alimentan la página de
-- contacto. Esta migración los promueve a los settings de negocio.
--
-- WhatsApp principal: Felipe Tapia (contact_person_1). El sistema soporta un
-- solo número flotante; el de Álvaro sigue visible en /contacto y puede
-- agregarse como sucursal desde admin → Negocio → Sucursales.
--
-- Sólo pisa si el valor sigue siendo el demo: si el cliente ya lo corrigió
-- desde el admin, no se toca. Idempotente.
-- ============================================================

-- ── Teléfono de contacto ──
UPDATE settings
   SET setting_value = '+56 9 9822 0252'
 WHERE setting_key = 'business_phone'
   AND (setting_value IS NULL OR setting_value = '' OR setting_value IN ('+56 2 2234 5678', '+56 9 1234 5678'));

-- ── WhatsApp del botón flotante (sólo dígitos, wa.me) ──
UPDATE settings
   SET setting_value = '56998220252'
 WHERE setting_key = 'business_whatsapp'
   AND (setting_value IS NULL OR setting_value = '' OR setting_value = '56912345678');

-- ── Email corporativo: el demo apuntaba a una casilla que puede no existir ──
-- No se pisa acá porque no tenemos confirmado el correo real; queda anotado
-- para setear desde admin → Negocio cuando los correos corporativos estén
-- activos (pendiente 1 del brief).

-- ── Dirección: ya la corrigió la 037 (Lope de Vega 4516, Estación Central).
-- Se re-afirma por si alguna instalación quedó con el demo de Providencia.
UPDATE settings
   SET setting_value = 'Lope de Vega 4516'
 WHERE setting_key = 'business_address'
   AND setting_value IN ('Av. Providencia 1234, Of. 503', 'Av. Providencia 1234, Of. 501');

-- Ciudad y región las fijó la 037 (Estación Central / Santiago); no se tocan.

-- ── Código postal demo: se limpia (no se usa y era inventado) ──
UPDATE settings
   SET setting_value = ''
 WHERE setting_key = 'business_postal_code'
   AND setting_value = '7500000';

-- ============================================================
-- Sucursales ("nuestros puntos de atención" en /contacto)
-- ============================================================
-- La 033 sembró DOS sucursales inventadas que siguen publicadas:
--   1. "Casa Matriz Providencia"          → Av. Providencia 1234, Of. 503
--   2. "Centro de Distribución Quilicura" → Av. Industrial 4567, Bodega 12
--
-- La dirección real es una sola bodega (Lope de Vega 4516, Estación Central),
-- con retiro previa coordinación. La #1 se reescribe con los datos reales y la
-- #2 se DESACTIVA (no se borra: queda recuperable desde admin → Negocio).
--
-- Se limpian también el email, el horario y el link de Maps: eran inventados.
-- El maps_url apuntaba a una ubicación de Providencia — un cliente que tocaba
-- "cómo llegar" terminaba en la dirección equivocada. Mejor vacío que erróneo.
-- Horario y correo quedan pendientes de confirmar con el cliente y se cargan
-- desde admin → Negocio → Sucursales.
--
-- Cada UPDATE exige que la fila siga teniendo el dato demo: si alguien ya la
-- corrigió desde el panel, no se toca. Idempotente.
-- ============================================================

UPDATE branches
   SET name        = 'Bodega Estación Central',
       address     = 'Lope de Vega 4516',
       city        = 'Estación Central',
       region      = 'Región Metropolitana',
       postal_code = '',
       phone       = '+56 9 9822 0252',
       whatsapp    = '56998220252',
       email       = '',
       hours       = '',
       maps_url    = ''
 WHERE address = 'Av. Providencia 1234, Of. 503'
   AND phone   = '+56 2 2234 5678';

UPDATE branches
   SET is_active = 0
 WHERE address = 'Av. Industrial 4567, Bodega 12'
   AND phone   = '+56 2 2987 6543';
