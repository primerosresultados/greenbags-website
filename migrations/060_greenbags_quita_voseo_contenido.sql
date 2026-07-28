-- ============================================================
-- CLIENTE: GreenBags — saca el voseo rioplatense del contenido guardado.
-- El código ya quedó en tuteo ("Escríbenos", "puedes", "necesitas"), pero los
-- textos editables viven en la base (settings, páginas CMS y banners) y ahí
-- seguían las formas con vos: "Escribinos un mensaje", "Contanos qué...",
-- "Si necesitás algo urgente, podés escribirnos".
-- Reemplazo por palabra: si el texto ya fue editado a mano, no lo toca.
-- Idempotente: REPLACE() no hace nada cuando la palabra ya no está.
-- Al forkear el starter, borrar este archivo (dato específico del cliente).
-- ============================================================

UPDATE settings SET setting_value =
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(setting_value,
    'Escribinos', 'Escríbenos'), 'escribinos', 'escríbenos'),
    'Contanos',   'Cuéntanos'),  'contanos',   'cuéntanos'),
    'Contactanos','Contáctanos'),'contactanos','contáctanos'),
    'Llamanos',   'Llámanos'),   'llamanos',   'llámanos'),
    'Contactá',   'Contacta'),   'contactá',   'contacta'),
    'Cotizá',     'Cotiza'),     'cotizá',     'cotiza'),
    'Solicitá',   'Solicita'),   'solicitá',   'solicita'),
    'Consultá',   'Consulta'),   'consultá',   'consulta'),
    'Conocé',     'Conoce'),     'conocé',     'conoce'),
    'Elegí',      'Elige'),      'elegí',      'elige'),
    'Pedí',       'Pide'),       'pedí',       'pide'),
    'tenés',      'tienes'),     'Tenés',      'Tienes'),
    'podés',      'puedes'),     'Podés',      'Puedes'),
    'necesitás',  'necesitas'),  'querés',     'quieres')
WHERE setting_value REGEXP 'Escribinos|escribinos|Contanos|contanos|Contactanos|contactanos|Llamanos|llamanos|Contactá|contactá|Cotizá|cotizá|Solicitá|solicitá|Consultá|consultá|Conocé|conocé|Elegí|elegí|Pedí|pedí|tenés|Tenés|podés|Podés|necesitás|querés';

UPDATE pages SET body =
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(body,
    'Escribinos', 'Escríbenos'), 'escribinos', 'escríbenos'),
    'Contanos',   'Cuéntanos'),  'contanos',   'cuéntanos'),
    'Contactanos','Contáctanos'),'contactanos','contáctanos'),
    'Llamanos',   'Llámanos'),   'llamanos',   'llámanos'),
    'Contactá',   'Contacta'),   'contactá',   'contacta'),
    'Cotizá',     'Cotiza'),     'cotizá',     'cotiza'),
    'Solicitá',   'Solicita'),   'solicitá',   'solicita'),
    'Consultá',   'Consulta'),   'consultá',   'consulta'),
    'Conocé',     'Conoce'),     'conocé',     'conoce'),
    'Elegí',      'Elige'),      'elegí',      'elige'),
    'Pedí',       'Pide'),       'pedí',       'pide'),
    'tenés',      'tienes'),     'Tenés',      'Tienes'),
    'podés',      'puedes'),     'Podés',      'Puedes'),
    'necesitás',  'necesitas'),  'querés',     'quieres')
WHERE body REGEXP 'Escribinos|escribinos|Contanos|contanos|Contactanos|contactanos|Llamanos|llamanos|Contactá|contactá|Cotizá|cotizá|Solicitá|solicitá|Consultá|consultá|Conocé|conocé|Elegí|elegí|Pedí|pedí|tenés|Tenés|podés|Podés|necesitás|querés';

UPDATE banners SET
    title = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(title,
        'Cotizá', 'Cotiza'), 'Solicitá', 'Solicita'), 'Conocé', 'Conoce'),
        'Elegí', 'Elige'), 'Pedí', 'Pide'), 'tenés', 'tienes'), 'podés', 'puedes'),
        'necesitás', 'necesitas'),
    subtitle = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(subtitle,
        'Cotizá', 'Cotiza'), 'Solicitá', 'Solicita'), 'Conocé', 'Conoce'),
        'Elegí', 'Elige'), 'Pedí', 'Pide'), 'tenés', 'tienes'), 'podés', 'puedes'),
        'necesitás', 'necesitas'),
    cta_label = REPLACE(REPLACE(REPLACE(REPLACE(cta_label,
        'Cotizá', 'Cotiza'), 'Solicitá', 'Solicita'), 'Conocé', 'Conoce'), 'Pedí', 'Pide')
WHERE CONCAT_WS(' ', title, subtitle, cta_label)
      REGEXP 'Cotizá|Solicitá|Conocé|Elegí|Pedí|tenés|podés|necesitás';
