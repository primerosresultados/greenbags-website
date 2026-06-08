# Forkear el starter para un cliente nuevo

Guía para empezar otro proyecto desde esta base sin arrastrar lo específico de
GreenBags (ni de ningún cliente anterior).

## El modelo mental

El repo tiene **dos capas**:

1. **Starter (reutilizable)** — código + estructura + módulos genéricos:
   admin, leads, catálogo, carrito, cotizaciones, mailing, banners, pages CMS,
   media library, sucursales, tracking. Todo esto se queda como está.

2. **Seed del cliente actual (descartable)** — settings, categorías iniciales,
   páginas, banner hero. Vive en **una sola migración**: hoy
   `migrations/028_greenbags_seed.sql`. Para un cliente nuevo se reemplaza
   completa.

> El skill `cpanel-hpanel-starter` dice "forkear el starter y borrar lo que no
> usás es más honesto que inventar abstracciones para reutilización que nunca
> se materializa." Esta guía es la versión disciplinada de eso.

## Workflow paso a paso

### 1. Clonar el repo a una nueva carpeta

```bash
cd ~/dev
git clone <repo-url> php-cliente-nuevo
cd php-cliente-nuevo
rm -rf .git                          # opcional: empezar repo limpio
git init && git add . && git commit -m "init from starter"
```

(Si querés mantener el historial de mejoras del starter, no hagas
`rm -rf .git` — usás un branch o un nuevo remote.)

### 2. Reemplazar la migración de seed

Tenés **dos opciones**:

**Opción A — Borrar la migración de GreenBags y crear la del cliente nuevo:**

```bash
rm migrations/028_greenbags_seed.sql
# crear:
$EDITOR migrations/028_<cliente>_seed.sql
```

**Opción B — Renombrarla con prefijo `_` para conservarla como template:**

```bash
mv migrations/028_greenbags_seed.sql migrations/_seed_template.sql
$EDITOR migrations/028_<cliente>_seed.sql
```

El prefijo `_` hace que la migración **no se ejecute automáticamente** — queda
en la carpeta como referencia.

### 3. Editar la migración nueva

Mínimo a tocar (usando el seed de GreenBags como template):

| Bloque | Ejemplo (GreenBags) | Para un cliente nuevo |
|---|---|---|
| Identidad | `site_name = GreenBags`, `business_legal_name = GreenBags SpA` | Tu nombre/razón social |
| Zona horaria | `timezone = America/Santiago` | La del país del cliente |
| Branding | `theme_primary = #2f7a3a` (verde), `theme_secondary = #a8c896` | La paleta del cliente |
| Announce bar | `announce_text = "Despachos en 24-48 hs..."` | Mensaje promo o vacío + `announce_enabled = 0` |
| Hero del home | `home_hero_title`, `home_hero_subtitle`, `home_hero_cta_*` | Copy del cliente |
| Story | `home_story_title`, `home_story_body`, `home_story_cta_*` | Sección "Nosotros" en home |
| Quotes | `quotes_enabled = 1`, `quote_show_prices = 0`, `quote_require_company = 1`, `quote_number_prefix = GB-` | Activar sólo si el cliente es B2B; quitar `quote_*` si es retail |
| Categorías base | Las 7 de GreenBags (`INSERT IGNORE INTO categories ...`) | Las del cliente nuevo (o vacío si las crea él desde admin) |
| Páginas base | `sobre-greenbags`, `sustentabilidad`, `gracias-cotizacion` | Páginas que el cliente quiera prepoblar |
| Banner hero | "Packaging sustentable para empresas" | El del cliente |

Importante: **mantené el patrón** `ON DUPLICATE KEY UPDATE setting_key = setting_key`
para settings. Esto hace que la migración NO pise valores ya editados desde el
admin. En una instalación fresca, igual inserta todo bien.

Para categorías y páginas, usar `INSERT IGNORE` (slug es UNIQUE → no inserta si
ya existe). Para banners (no tiene UNIQUE), usar
`INSERT INTO ... SELECT ... WHERE NOT EXISTS (SELECT 1 FROM banners WHERE title = '...')`.

### 4. Decidir si activar o desactivar módulos

| Módulo | Setting | Notas |
|---|---|---|
| Cotizaciones (B2B sin precio público) | `quotes_enabled = 1` | Ver [QUOTES_MODULE.md](QUOTES_MODULE.md) |
| Carrito de compras + checkout | `quotes_enabled = 0` (default) | Funciona out of the box, el cliente configura pasarelas desde `/admin/?view=payments` |
| Anuncio bar | `announce_enabled = 1` | El cliente puede editarlo desde Configuración |
| JSON-LD LocalBusiness | `business_seo_jsonld = 1` (default) | Sólo se inyecta si hay `business_legal_name` o `site_name` |
| Auto-respuesta a leads | `autoreply_enabled = 1` | Editable desde Mailing |
| Auto-respuesta a cotizaciones | `quote_autoreply_enabled = 1` | Editable por SQL hoy |
| Floating WhatsApp | `whatsapp_float = 1` (default) | Sólo se muestra si `business_whatsapp` está cargado |

Lo que **no necesitás tocar** para un cliente B2B simple: catálogo, productos,
variaciones, atributos, tiers, banners, usuarios, mailing, media library — todo
queda como está y se configura desde el admin.

### 5. Limpiar la BD local (opcional pero recomendado)

Si tu BD local arrastra el seed de GreenBags y querés empezar limpia para el
cliente nuevo:

```bash
# Asumiendo BD local pse_local + las credenciales del config.php local:
mysql -h 127.0.0.1 -u pse -ppse -e "DROP DATABASE pse_local; CREATE DATABASE pse_local DEFAULT CHARSET=utf8mb4;"

# Después corré /install/ en el browser → instala fresh con el nuevo seed.
```

O usá una BD distinta por cliente: `pse_clienteX`, `pse_clienteY`, etc. Cada
una con su `config.php` (la rama del cliente tiene el suyo, gitignored).

### 6. Pasos del primer deploy en hosting

Idénticos a [DEPLOY.md](../DEPLOY.md) — clonar el repo en `public_html`, correr
`/install/`, borrar la carpeta. El seed 028 se aplica automáticamente en la
primera visita al admin.

## Checklist mental

Antes de subir el proyecto del cliente nuevo a producción:

- [ ] `migrations/028_<cliente>_seed.sql` tiene los settings correctos.
- [ ] Probado en local que `/`, `/cotizacion` (si aplica), `/admin/` levantan
      sin errores con la BD vacía recién instalada.
- [ ] Logo + favicon subidos desde admin (no van en la migración, son binarios).
- [ ] `notification_email` configurado para que lleguen leads/cotizaciones.
- [ ] WhatsApp del negocio en `business_whatsapp` para que aparezca el floating.
- [ ] Si hay tracking: GA4 ID + Meta Pixel ID en Configuración.
- [ ] `config.php` en local Y en producción apuntan a sus BDs respectivas.
- [ ] `/install/` borrado del servidor después del primer arranque.

## Archivos que casi nunca necesitás editar al forkear

```
lib/*                    ← lógica genérica (auth, db, csrf, mail, cart, quotes, etc.)
admin/index.php          ← router del panel (sólo si agregás features nuevas)
install/index.php        ← wizard de primera instalación
assets/css/base.css      ← variables de paleta (las sobreescribe layout.php con theme_primary/secondary)
.htaccess                ← seguridad + rewrite
```

## Archivos que SÍ vas a tocar a menudo

```
migrations/NNN_*.sql     ← agregar features nuevas (nueva tabla, nuevos settings)
migrations/028_<cliente>_seed.sql   ← seed específico del cliente (mover de proyecto a proyecto)
components/admin/*.php   ← nuevas vistas del panel
components/site_header.php / site_footer.php   ← branding adicional
assets/css/*.css         ← ajustes visuales
```

## Cuando agregás una feature genérica nueva (sirve para todos los proyectos)

Hacelo en una migración numerada del starter (`029_*.sql`, `030_*.sql`...) y
en `lib/` + `components/`. Después al forkear para otros clientes, esa feature
viaja con vos. Si el cliente nuevo no la quiere, dejala desactivada por
setting (como `quotes_enabled`).

> Anti-pattern a evitar: editar la migración 028 de GreenBags para agregar
> features genéricas. Eso obliga a borrar las features genéricas cuando
> forkeás. Mantené el seed del cliente puramente como **datos del cliente**.

## Ver también

- [QUOTES_MODULE.md](QUOTES_MODULE.md) — cómo funciona el módulo de cotizaciones.
- [clients/GREENBAGS.md](clients/GREENBAGS.md) — registro del setup que hicimos
  para este primer cliente; sirve de referencia de qué se hizo.
- [../DEPLOY.md](../DEPLOY.md) — flujo de deploy en cPanel/hPanel.
- [../README.md](../README.md) — overview del starter.
