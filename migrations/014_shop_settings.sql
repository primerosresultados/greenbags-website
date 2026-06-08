-- Configuración de tienda (Chile) + pasarelas de pago + tracking de conversión.
--
-- Moneda CLP: en la práctica NO usa decimales. Se guarda como DECIMAL(12,2) por
-- flexibilidad, pero se cobra/muestra redondeado a entero ($19.990).
-- IVA 19% incluido en el precio (estándar B2C en Chile).
--
-- Pasarelas: Transbank (Webpay Plus), Flow y MercadoPago. Cada una se habilita
-- por flag y guarda sus credenciales + ambiente (sandbox/producción).

INSERT INTO settings (setting_key, setting_value) VALUES
    -- ── Tienda ──
    ('store_currency',          'CLP'),
    ('currency_symbol',         '$'),
    ('currency_decimals',       '0'),
    ('price_includes_tax',      '1'),
    ('tax_rate',                '19.0'),
    ('weight_unit',             'kg'),
    ('store_country',           'CL'),
    ('checkout_guest_enabled',  '1'),
    ('stock_low_threshold',     '3'),
    ('order_number_prefix',     'ORD-'),

    -- ── Pasarelas habilitadas (1/0) ──
    ('pay_transbank_enabled',   '1'),
    ('pay_flow_enabled',        '1'),
    ('pay_mercadopago_enabled', '1'),

    -- ── Transbank Webpay Plus ──
    ('tbk_environment',         'integration'),  -- integration | production
    ('tbk_commerce_code',       ''),
    ('tbk_api_key',             ''),

    -- ── Flow ──
    ('flow_environment',        'sandbox'),       -- sandbox | production
    ('flow_api_key',            ''),
    ('flow_secret_key',         ''),

    -- ── MercadoPago (Checkout Pro) ──
    ('mp_public_key',           ''),
    ('mp_access_token',         ''),

    -- ── Tracking de conversión (ga_id y pixel_id ya existen desde 005) ──
    ('ga4_measurement_id',      ''),
    ('ga4_api_secret',          ''),   -- Measurement Protocol (server-side)
    ('meta_capi_token',         ''),   -- Conversions API token
    ('meta_test_event_code',    ''),
    ('google_ads_id',           ''),
    ('google_ads_purchase_label',''),
    ('gtm_id',                  '')
ON DUPLICATE KEY UPDATE setting_key = setting_key;
