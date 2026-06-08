-- Sistema de cotizaciones (request-for-quote / RFQ).
--
-- Uso típico: empresas B2B que no exponen precios públicos y quieren que el
-- cliente arme un "carrito de cotización" en vez de comprar online. El cliente
-- agrega productos al borrador (token UUID en cookie, igual que `carts`),
-- completa sus datos, envía la cotización, y el admin la responde por mail.
--
-- Convive con el carrito de compra: el setting `quotes_enabled` decide si los
-- botones del catálogo dicen "Agregar a cotización" en vez de "Agregar al
-- carrito". Si no se activa, las tablas quedan vacías sin afectar nada.
--
-- Status: draft → submitted → responded → won|lost|expired.

CREATE TABLE IF NOT EXISTS quotes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    token CHAR(36) NOT NULL UNIQUE,
    quote_number VARCHAR(40) DEFAULT NULL UNIQUE,
    customer_id INT DEFAULT NULL,
    status ENUM('draft','submitted','responded','won','lost','expired')
           NOT NULL DEFAULT 'draft',

    -- Datos del solicitante (snapshot al submit; en draft están vacíos)
    contact_name     VARCHAR(180) DEFAULT NULL,
    contact_email    VARCHAR(180) DEFAULT NULL,
    contact_phone    VARCHAR(60)  DEFAULT NULL,
    contact_company  VARCHAR(180) DEFAULT NULL,
    contact_taxid    VARCHAR(40)  DEFAULT NULL,    -- RUT / CUIT / NIT
    contact_position VARCHAR(120) DEFAULT NULL,
    contact_city     VARCHAR(120) DEFAULT NULL,
    contact_region   VARCHAR(120) DEFAULT NULL,

    message TEXT,                                  -- mensaje libre del cliente

    -- Estimaciones (opcional: si los productos tienen precio, se calcula)
    currency      VARCHAR(3) NOT NULL DEFAULT 'CLP',
    subtotal_est  DECIMAL(12,2) DEFAULT NULL,
    items_count   INT NOT NULL DEFAULT 0,

    -- Respuesta y notas internas
    internal_notes TEXT,                           -- no se envían al cliente
    response_text  TEXT,                           -- lo que el admin envió de respuesta

    -- Timestamps y trazabilidad
    submitted_at  DATETIME DEFAULT NULL,
    responded_at  DATETIME DEFAULT NULL,
    won_at        DATETIME DEFAULT NULL,
    lost_at       DATETIME DEFAULT NULL,
    expires_at    DATETIME DEFAULT NULL,
    source        VARCHAR(60) DEFAULT 'website',   -- catalog | quick_form | etc.
    ip_address    VARCHAR(45) DEFAULT NULL,
    user_agent    VARCHAR(500) DEFAULT NULL,
    created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_q_status (status, submitted_at),
    INDEX idx_q_customer (customer_id),
    INDEX idx_q_email (contact_email),
    INDEX idx_q_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS quote_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quote_id INT NOT NULL,
    product_id   INT DEFAULT NULL,                 -- NULL si producto libre
    variation_id INT DEFAULT NULL,
    sku_snapshot  VARCHAR(100) DEFAULT NULL,
    name_snapshot VARCHAR(255) NOT NULL,           -- texto libre OK
    qty INT NOT NULL DEFAULT 1,
    unit_price_est DECIMAL(12,2) DEFAULT NULL,     -- NULL si pidieron "a cotizar"
    item_notes VARCHAR(500) DEFAULT NULL,          -- ej: "color verde, 24 unidades por caja"
    INDEX idx_qi_quote (quote_id),
    CONSTRAINT fk_qi_quote FOREIGN KEY (quote_id) REFERENCES quotes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS quote_notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quote_id INT NOT NULL,
    user_id INT DEFAULT NULL,
    body TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_qn_quote (quote_id, created_at),
    CONSTRAINT fk_qn_quote FOREIGN KEY (quote_id) REFERENCES quotes(id) ON DELETE CASCADE,
    CONSTRAINT fk_qn_user  FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS quote_status_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quote_id INT NOT NULL,
    status VARCHAR(40) NOT NULL,
    note VARCHAR(500) DEFAULT NULL,
    created_by INT DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_qsh_quote (quote_id, created_at),
    CONSTRAINT fk_qsh_quote FOREIGN KEY (quote_id) REFERENCES quotes(id) ON DELETE CASCADE,
    CONSTRAINT fk_qsh_user  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Settings del módulo cotizaciones (todas opcionales, defaults sensatos).
-- Activar con quotes_enabled=1 para que aparezcan los botones en el frontend.
INSERT INTO settings (setting_key, setting_value) VALUES
    ('quotes_enabled',              '0'),
    ('quote_number_prefix',         'COT-'),
    ('quote_show_prices',           '0'),         -- 0: NO mostrar precios en form (B2B típico)
    ('quote_button_label',          'Agregar a cotización'),
    ('quote_submit_label',          'Solicitar cotización'),
    ('quote_drawer_title',          'Mi cotización'),
    ('quote_thanks_slug',           'gracias-cotizacion'),
    ('quote_expiration_days',       '14'),
    ('quote_require_company',       '0'),
    ('quote_require_taxid',         '0'),
    ('quote_intro_text',            'Completá tus datos y te enviamos una propuesta personalizada en 24-48 horas.'),
    ('quote_notification_subject',  '[{{site_name}}] Nueva cotización {{quote_number}}'),
    ('quote_notification_body',     'Recibiste una nueva cotización desde {{site_name}}.

Número:   {{quote_number}}
Nombre:   {{contact_name}}
Empresa:  {{contact_company}}
RUT:      {{contact_taxid}}
Email:    {{contact_email}}
Teléfono: {{contact_phone}}
Ítems:    {{items_count}}

Mensaje:
{{message}}

Detalle:
{{items_list}}

Ver en admin: {{admin_url}}'),
    ('quote_autoreply_enabled',     '1'),
    ('quote_autoreply_subject',     'Recibimos tu solicitud de cotización'),
    ('quote_autoreply_body',        'Hola {{contact_name}},

Gracias por solicitar una cotización a {{site_name}}. Recibimos tu pedido y te vamos a responder a la brevedad (24-48 horas hábiles).

Tu número de cotización es: {{quote_number}}

Si necesitás algo urgente, podés escribirnos por WhatsApp: {{business_whatsapp}}

Saludos,
Equipo {{site_name}}')
ON DUPLICATE KEY UPDATE setting_key = setting_key;
