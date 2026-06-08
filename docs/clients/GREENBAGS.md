# GreenBags — Registro del setup

Primer cliente que usa esta base. Este doc es **histórico**: refleja lo que se
configuró en la primera vuelta y por qué. No actualizar línea a línea cuando
cambien settings desde el admin — sirve como referencia "lo que salió de
fábrica para este proyecto".

## Quién es el cliente

- **Empresa**: GreenBags (Chile, > 15 años).
- **Rubro**: comercialización de packaging sustentable, productos de higiene,
  aseo y manipulación de alimentos para empresas.
- **Modelo**: B2B (Horeca, retail, industria, emprendedores).
- **Cobertura**: foco RM, capacidad nacional, despachos 24-48 hs.
- **Valor**: atención directa de los dueños + soluciones biodegradables
  certificadas + rapidez.

## Decisiones de diseño

| Pregunta | Respuesta | Motivo |
|---|---|---|
| ¿Catálogo público con precios? | **No** (`quote_show_prices = 0`) | B2B típico: precios bajo cotización |
| ¿Carrito de compra o cotización? | **Cotización** (`quotes_enabled = 1`) | Fase 1 sin eCommerce; checkout queda para fase 2 |
| ¿Pasarela de pago? | No configurada | Sin checkout en fase 1 |
| ¿Campos obligatorios al cotizar? | nombre, email, teléfono, **empresa** | RUT es opcional (`quote_require_taxid = 0`) |
| Prefijo de cotización | `GB-` (ej. `GB-2026-0001`) | Branding |
| Paleta | verde corporativo `#2f7a3a` / `#a8c896` | Coherente con "Green" + sustentable |
| Página de gracias | `/gracias-cotizacion` (CMS, oculta de menú) | Generada por el seed |

## Qué hay en la migración del cliente

[`migrations/028_greenbags_seed.sql`](../../migrations/028_greenbags_seed.sql):

- **45+ settings** (identidad, branding, copy del home, módulo cotizaciones,
  mailing) usando `ON DUPLICATE KEY UPDATE setting_key = setting_key` (no
  pisa lo editado desde admin).
- **7 categorías raíz** (las del brief): Packaging Desechable, Packaging
  Sustentable, Bolsas, Productos de Higiene, Productos de Aseo, Manipulación
  de Alimentos, Personalización Corporativa.
- **3 páginas CMS**: Sobre GreenBags, Compromiso sustentable, Gracias por
  cotizar.
- **1 banner hero** con eyebrow + título + CTA a `/cotizacion`.

Idempotente: se puede correr varias veces sin duplicar nada.

## Estado del setup al cierre

| Bloque | Estado | Próximos pasos |
|---|---|---|
| Estructura del sitio | Lista | — |
| Categorías base | Cargadas (7) | Cliente agrega productos cuando tenga fotos + SKU |
| Páginas (Sobre / Sustentabilidad / Gracias) | Cargadas | Cliente revisa copy y edita desde admin |
| Banner hero | Cargado (sin imagen) | Subir imagen desde admin → Banners |
| Logo | **Pendiente** | Subir desde admin → Configuración cuando esté el archivo final |
| Favicon | **Pendiente** | Idem |
| Email de notificaciones | **Pendiente** | Setear en admin → Mailing → `notification_email` |
| WhatsApp Felipe + Álvaro | **Pendiente** | Negocio → WhatsApp principal (un solo número). El segundo número se puede agregar como "sucursal" |
| Resend API (deliverability) | **Pendiente** | Conectar desde Mailing → mejor que `mail()` para evitar spam |
| Dirección de bodega | **Pendiente** | Negocio → Dirección (cuando esté confirmada) |
| Catálogo de productos | **Pendiente** | Cliente va cargando SKUs cuando tenga fotos + descripciones |
| Tracking GA4 / Meta Pixel | **Pendiente** | Setear en admin → Configuración cuando estén las cuentas |

## Cómo está hoy el frontend

Probado localmente con `php -S 127.0.0.1:8099 pse_devserver.php`:

| Ruta | Respuesta | Notas |
|---|---|---|
| `/` | 200 | Home con hero "Packaging sustentable para empresas" + CTA "Solicitar cotización" + sección categorías + story + announce bar |
| `/cotizacion` | 200 | Form completo con campos nombre, email, teléfono, empresa (obligatoria), RUT (opcional), cargo, ciudad, región, mensaje |
| `/sobre-greenbags` | 200 | Página CMS con copy del brief |
| `/sustentabilidad` | 200 | Página CMS sobre certificaciones y Ley REP |
| `/gracias-cotizacion` | 200 | Página de confirmación post-envío |
| `/categoria/packaging-sustentable` | 200 | Grid sin precios (botón "Cotizar") |
| `/admin/` | 200 (login) | Una vez logueado, sidebar muestra "Cotizaciones" |

## Decisión sobre 2 WhatsApps (Felipe + Álvaro)

El sistema permite UN solo número de WhatsApp principal (`business_whatsapp`)
que dispara el botón flotante. Si quieren ambos visibles:

- **Opción 1 (recomendada)**: principal en `business_whatsapp` (uno de los dos),
  el otro va como **Sucursal** en admin → Negocio → Sucursales (ya tiene
  campo `whatsapp` por sucursal). Aparece en el listado de sucursales del front.
- **Opción 2**: tocar el footer/sección de contacto del home para mostrar dos
  CTAs manualmente. Pide ~½ hora de trabajo.

## Para fase 2 (eCommerce real)

Cuando el cliente quiera vender online (500+ SKUs, Webpay/Flow, etc.):

1. `UPDATE settings SET setting_value = '0' WHERE setting_key = 'quotes_enabled';`
   → vuelve al modo carrito de compra. (O ver "Coexistencia" en
   [QUOTES_MODULE.md](../QUOTES_MODULE.md) si quieren ambos.)
2. Cargar precios en cada producto, mínimos de orden, tiers por volumen.
3. Configurar pasarelas en admin → Pagos (Webpay / Flow / MercadoPago /
   transferencia / COD).
4. Configurar shipping zones + métodos en BD (`shipping_zones`, `shipping_methods`).
5. Configurar IVA en admin → Configuración (ya viene en 19% por default Chile).

Toda la infraestructura ya está en el starter — sólo es configuración + carga
de datos.

## Pendientes críticos del brief (referencia)

Del brief original — copio para que quede acá también:

1. Activar correos corporativos.
2. Definir logo final.
3. Definir colores corporativos. *(ya definimos paleta inicial verde, ajustable)*
4. Construir catálogo maestro de productos.
5. Conseguir fotografías.
6. Definir categorías definitivas. *(ya cargamos las 7 base, ajustables)*
7. Obtener listado SKU para eCommerce.
8. Definir bodega física y dirección.
9. Definir condiciones de despacho.
10. Definir proveedor logístico para regiones.

**El cuello de botella sigue siendo el catálogo** — el sitio está listo para
recibirlo en cuanto haya SKUs, fotos y descripciones.

## Cómo extender este registro

Cada vez que se haga un cambio significativo desde el admin o por migración,
agregar una línea acá si vale la pena que un futuro tú (o un colaborador) lo
sepa sin tener que reconstruirlo desde el git log. Cambios menores (editar
copy del home, agregar un producto) no van acá — ya quedan en la BD.
