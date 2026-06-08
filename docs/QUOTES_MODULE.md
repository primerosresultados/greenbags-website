# Módulo de Cotizaciones (RFQ)

Sistema de **request-for-quote** para sitios B2B donde el cliente no compra
online: arma un "carrito de cotización", lo envía con sus datos, y la empresa
responde por email. Convive con el carrito de compra clásico — se activa con
un único setting.

## Cuándo usarlo

- Empresas B2B que no exponen precios públicos.
- Productos con precio variable según volumen, condiciones de pago o cliente.
- Catálogos donde la mayoría de los SKUs requieren ajuste manual (packaging
  personalizado, insumos industriales, servicios).
- Sitios chicos que sólo necesitan **captura de leads enriquecidos** (con lista
  de productos) en vez de checkout completo.

Si necesitás checkout + pagos online → usar el módulo `cart`/`orders` que ya
existe en el starter. **Pueden coexistir**, pero la UX cambia: ver
[Activación](#activación) más abajo.

## Activación

Una sola fila en `settings`:

```sql
UPDATE settings SET setting_value = '1' WHERE setting_key = 'quotes_enabled';
-- o desde el admin (cuando la pantalla esté lista) o por seed en una migración.
```

Cuando `quotes_enabled = 1`:

- Los **botones del catálogo** ("Agregar al carrito" / "Agregar a cotización")
  apuntan a `/cotizacion` en vez de `/carrito`.
- El **ícono del header** cambia de carrito a documento y muestra el conteo
  de la cotización en curso.
- El **mini-drawer lateral** que se abre con el ícono es de cotización (no de
  cart).
- En el **admin** aparece el item "Cotizaciones" en el sidebar.
- Los precios públicos se ocultan si además `quote_show_prices = 0` (default).

Cuando `quotes_enabled = 0` (default del starter), el módulo está completamente
inactivo y nada cambia respecto al starter "tienda". Las tablas existen pero
están vacías.

## Estructura de datos

Migración: [`migrations/027_quotes.sql`](../migrations/027_quotes.sql).

```
quotes                  ← una fila por solicitud (draft o enviada)
  id, token (cookie UUID), quote_number ('GB-2026-0001'),
  status (draft|submitted|responded|won|lost|expired),
  contact_name/email/phone/company/taxid/position/city/region,
  message, internal_notes, response_text,
  currency, subtotal_est, items_count,
  submitted_at, responded_at, won_at, lost_at, expires_at,
  source, ip_address, user_agent, created_at, updated_at

quote_items             ← líneas de la cotización
  id, quote_id, product_id (NULL si es libre), variation_id,
  sku_snapshot, name_snapshot, qty, unit_price_est (NULL OK),
  item_notes ("color verde, 24 u/caja")

quote_notes             ← notas internas del admin (como lead_notes)
  id, quote_id, user_id, body, created_at

quote_status_history    ← auditoría del workflow
  id, quote_id, status, note, created_by, created_at
```

**Por qué snapshot de SKU + name en `quote_items`**: si el producto cambia o se
borra después de enviada la cotización, la historia se preserva (igual que
`order_items`).

## Workflow

```
draft  ──►  submitted  ──►  responded  ──►  won
                       │                ┊
                       └─►  expired     └─►  lost
```

- `draft`: el visitante está armando la cotización. Vive en cookie `pse_quote`
  (UUID, 1 año). No aparece en el admin.
- `submitted`: el visitante completó sus datos y envió. Aparece en el admin
  con `quote_number`. Se manda email al admin (`notification_email`) y
  autoreply al cliente.
- `responded`: el admin envió la propuesta desde `/admin/?view=quote&id=N` →
  *Enviar respuesta por email*. Se guarda lo enviado en `response_text`.
- `won` / `lost`: estados finales (manual). `expired`: automático a los
  `quote_expiration_days` días si no hubo respuesta (no rompe nada — sólo
  se marca; revivís cambiando estado a mano).

## Settings disponibles

Todos en la tabla `settings`. Defaults razonables ya cargados por la
migración 027. Editables a mano por SQL o desde el admin (cuando exista la
pantalla de config, hoy se cambian con `UPDATE settings ...`).

| Clave | Default | Uso |
|---|---|---|
| `quotes_enabled` | `0` | Master switch del módulo |
| `quote_number_prefix` | `COT-` | Prefijo del `quote_number` (ej. `GB-`, `PRO-`) |
| `quote_show_prices` | `0` | Si `1`, muestra precios de catálogo en el form de cotización |
| `quote_button_label` | `Agregar a cotización` | Texto del CTA en producto |
| `quote_submit_label` | `Solicitar cotización` | Texto del botón de envío del form |
| `quote_drawer_title` | `Mi cotización` | Header del mini-drawer lateral |
| `quote_thanks_slug` | `gracias-cotizacion` | Slug de la página CMS de "gracias" |
| `quote_expiration_days` | `14` | Días desde `submitted` antes de auto-`expired` |
| `quote_require_company` | `0` | Si `1`, "Empresa" es campo obligatorio |
| `quote_require_taxid` | `0` | Si `1`, "RUT/Identificación tributaria" obligatorio |
| `quote_intro_text` | (texto largo) | Mensaje que aparece arriba del form |
| `quote_notification_subject` | (template) | Asunto del email al admin |
| `quote_notification_body` | (template) | Cuerpo del email al admin |
| `quote_autoreply_enabled` | `1` | Si `1`, el cliente recibe confirmación |
| `quote_autoreply_subject` | (template) | Asunto del autoreply al cliente |
| `quote_autoreply_body` | (template) | Cuerpo del autoreply al cliente |

Las plantillas aceptan estas variables (`{{var}}`):

- `{{quote_number}}`, `{{contact_name}}`, `{{contact_email}}`,
  `{{contact_phone}}`, `{{contact_company}}`, `{{contact_taxid}}`,
  `{{items_count}}`, `{{items_list}}` (lista en texto plano), `{{message}}`,
  `{{submitted_at}}`, `{{admin_url}}`, `{{site_name}}`.
- Todas las claves de `businessInfo()`: `{{business_phone}}`, `{{business_email}}`,
  `{{business_whatsapp}}`, etc. + `{{business_whatsapp_link}}`.

## Frontend

**Ruta:** `/cotizacion` (también acepta `/cotizar`).

- **GET** → muestra el carrito + form para completar datos y enviar.
- **POST** → procesa `add_to_quote`, `update_qty`, `update_notes`, `remove`,
  `clear`, `submit_quote`. Patrón POST-Redirect-GET con flash.

**Anti-spam:** honeypot (`website` hidden) + timing (mínimo 2s) + CSRF token.
Mismos defensores que el form de leads.

**Mini-drawer**: [`components/quote_drawer.php`](../components/quote_drawer.php).
Comparte CSS con `cart_drawer.php` (clases `.cart-drawer__*` reusadas) — sólo
cambian los IDs (`quote-drawer`, `header-quote-btn`, `drawer-quote-btn`) y los
endpoints AJAX a `/cotizacion`. Se auto-abre cuando viene de un
"agregar a cotización" (flash `quote_just_added`).

**Botones en producto/grilla**: [`lib/shop_front.php`](../lib/shop_front.php)
detecta `quotesEnabled()` y alterna `action`/`name`/`label` del form. El resto
del rendering (galería, variaciones, tiers) no cambia.

## Admin

- `/admin/?view=quotes` — listado con filtros (búsqueda + estado), stats,
  exportar CSV.
- `/admin/?view=quote&id=N` — detalle: datos del solicitante, items
  solicitados (con SKU + qty + notas del cliente), workflow de estados, **form
  para enviar respuesta por email** (con plantillas), notas internas,
  historial de cambios de estado, eliminación.

Componentes:

- [`components/admin/quotes_list.php`](../components/admin/quotes_list.php)
- [`components/admin/quote_detail.php`](../components/admin/quote_detail.php)

El link en el sidebar se muestra sólo si `quotes_enabled = 1` —
[`components/admin_nav.php`](../components/admin_nav.php).

## API PHP (lib/quotes.php)

Funciones principales si necesitás extender:

```php
// Estado del módulo
quotesEnabled(): bool                            // Master switch
quoteSettings(): array                           // Todos los settings agrupados

// Manipular el draft (lado público)
quoteToken(): string                             // UUID en cookie (genera si falta)
quoteCurrent(bool $create = false): ?array       // Draft actual
quoteAddItem($productId, $variationId, $qty, $notes = null): array
quoteAddCustomItem($name, $qty, $notes = null): array  // Item libre sin product_id
quoteUpdateQty($itemId, $qty): void
quoteUpdateNotes($itemId, $notes): void
quoteRemoveItem($itemId): void
quoteClear(): void
quoteItems(): array                              // Items enriquecidos (thumb, slug)
quoteTotals(): array                             // [subtotal_est, qty, count]
quoteCount(): int                                // Para badge del header

// Submit
quoteSubmit($data): array                        // [ok, id, number, error?]
quoteGenerateNumber(): string                    // "GB-2026-0001"

// Admin
quoteList($filters = []): array                  // Con search + status
quoteGet($id): ?array
quoteGetItems($quoteId): array
quoteGetNotes($quoteId): array
quoteGetHistory($quoteId): array
quoteStats(): array                              // Conteos por estado
quoteUpdateStatus($id, $status, $userId = null, $note = null): bool
quoteAddStatusEntry($id, $status, $userId, $note): void
quoteAddInternalNote($id, $userId, $body): void
quoteSendResponse($id, $userId, $subject, $body): array
quoteDelete($id): bool

// Plantillas y mailing
quoteTemplateVars($quote, $items): array         // Para renderTemplate()
quoteItemsAsText($items): string                 // Lista plana para email
notifyQuoteSubmitted($quote, $items): void       // Email al admin
sendQuoteAutoReply($quote, $items): void         // Email al cliente

// Mantenimiento
quoteExpireOverdue(): int                        // Marca expired las vencidas
```

## Cómo extender

### Agregar un campo nuevo al solicitante

1. Crear migración: `migrations/029_quotes_add_field.sql`:
   ```sql
   ALTER TABLE quotes ADD COLUMN contact_industry VARCHAR(120) DEFAULT NULL AFTER contact_position;
   ```
2. Agregar el input al form en `lib/quote_front.php` (función `quoteRenderPage`).
3. Capturar en `quoteSubmit()` (lib/quotes.php) y guardarlo en el `UPDATE`.
4. Mostrarlo en `components/admin/quote_detail.php`.

### Agregar un estado al workflow

1. Editar el ENUM en una migración nueva:
   ```sql
   ALTER TABLE quotes MODIFY status ENUM('draft','submitted','responded','negotiating','won','lost','expired') NOT NULL DEFAULT 'draft';
   ```
2. Agregar el valor a la constante `QUOTE_STATUSES` en `lib/quotes.php`.
3. Agregar el label en `quote_detail.php` y `quotes_list.php` (`$statusLabels`).

### Auto-poblar la cotización desde un parámetro de URL

Caso de uso: campañas tipo `?producto=papel-higienico-90&qty=5`.

En `quote_front.php`, al inicio de `quoteRenderPage()`:

```php
if (!empty($_GET['producto']) && isset($_GET['qty'])) {
    $p = productGetBySlug($_GET['producto']);
    if ($p) quoteAddItem((int) $p['id'], null, (int) $_GET['qty']);
}
```

### Cron de expiración

```cron
0 4 * * * cd /home/user/public_html && php -r 'require "lib/bootstrap.php"; echo quoteExpireOverdue();' >> ~/logs/quote-expire.log 2>&1
```

(O dejar que se ejecute al primer hit del admin — ya lo hace en `?view=quotes`.)

## Coexistencia con el carrito de compras

Hoy el módulo asume **uno u otro** (decidido por `quotes_enabled`). Si en un
proyecto necesitás **ambos** (ej: clientes B2C pagan online y B2B cotizan):

1. Renombrar el setting a `shop_mode` con valores `cart`, `quote`, `both`.
2. En `shop_front.php`, cuando `both`, renderizar dos botones lado a lado.
3. Dejar ambos drawers en `layout.php` y mostrar los dos íconos en el header.
4. Filtrar productos por flag `b2b_only` para mostrar uno u otro CTA.

No está implementado. Si te pide un cliente, scope ~½ día.

## Archivos del módulo

```
migrations/027_quotes.sql                     ← schema + settings
lib/quotes.php                                ← API completa
lib/quote_front.php                           ← Router /cotizacion + render
components/quote_drawer.php                   ← Mini-cotización lateral
components/admin/quotes_list.php              ← Listado admin
components/admin/quote_detail.php             ← Detalle + responder
assets/css/shop.css (sección "Modo Cotización") ← Estilos puntuales
```

Integraciones en archivos existentes:

```
lib/bootstrap.php                ← require de lib/quotes.php + lib/quote_front.php
lib/layout.php                   ← incluye quote_drawer cuando quotesEnabled
lib/shop_front.php               ← alterna /carrito ↔ /cotizacion
components/site_header.php       ← cambia ícono + URL del header
components/admin_nav.php         ← link "Cotizaciones" cuando quotesEnabled
admin/index.php                  ← actions + views quotes/quote
index.php                        ← llama quoteFrontRoute() antes de shopFrontRoute()
```

## Quitar el módulo de un fork

Si en un proyecto NO necesitás cotizaciones, dejá `quotes_enabled = 0` y no
toques nada — el módulo queda dormido. No vale la pena borrar archivos: pesa
poco y permite activarlo después con un solo update.

Si querés realmente sacarlo del fork: borrar los 6 archivos listados arriba +
revertir los 7 cambios de integración (todos están comentados con
`if (quotesEnabled())` o `function_exists('quoteCount')`, fácil de identificar).
