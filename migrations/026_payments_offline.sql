-- Métodos de pago "offline" (sin pasarela): transferencia bancaria y contra
-- entrega. Las pasarelas digitales (Transbank, Flow, MercadoPago) ya tienen
-- sus settings en 014_shop_settings.sql.
--
-- Estos dos son útiles para clientes que recién arrancan y aún no integraron
-- una pasarela: el comprador completa el checkout y el admin coordina el cobro
-- por afuera. Las instrucciones se muestran en la pantalla de "orden creada".

INSERT INTO settings (setting_key, setting_value) VALUES
    ('pay_bank_transfer_enabled',      '0'),
    ('pay_bank_transfer_instructions', ''),
    ('pay_cod_enabled',                '0'),
    ('pay_cod_instructions',           '')
ON DUPLICATE KEY UPDATE setting_key = setting_key;
