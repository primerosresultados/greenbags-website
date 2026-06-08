# Estándar del menú principal

Cómo decidir qué entra al menú del header, qué no, y cómo evitar duplicados
(`home` + Inicio, `sobre-nosotros` + `sobre-greenbags`, etc.).

Aplica a **cualquier cliente** del starter. La sección final tiene el mapa
canónico para **GreenBags**.

## Regla 0 — `Inicio` no es una página CMS

El home `/` lo renderiza [index.php](../index.php) (no la tabla `pages`). En el
header, "Inicio" está **hardcoded** en [components/site_header.php:76](../components/site_header.php:76).

Cualquier página CMS con slug `home` o `inicio` está **prohibida** porque
duplica el item "Inicio" del menú. La migración
[029_greenbags_cleanup_default_pages.sql](../migrations/029_greenbags_cleanup_default_pages.sql)
ya borra/oculta la `home` que siembra el instalador — si reaparece, viene de
una edición manual desde admin: borrarla.

## Regla 1 — Un slug por concepto

Si "Sobre la empresa" existe como `sobre-greenbags`, **no** crear también
`sobre-nosotros` ni `quienes-somos`. Elegí el slug canónico (el que mejor
describe la marca) y editás esa misma página. Lo mismo para `contacto` vs
`contactenos`, `productos` vs `catalogo`, etc.

**Antes de crear una página nueva:** entrar a admin → Páginas y buscar si ya
existe algo equivalente. Si sí → editar. Si no → crear con slug canónico.

## Regla 2 — Matriz de flags

Cada página tiene tres flags. Usar esta tabla para no equivocarse:

| Tipo de página                       | `is_published` | `exclude_from_menu` | `hide_chrome` |
|--------------------------------------|----------------|---------------------|---------------|
| Sección del menú principal           | 1              | 0                   | 0             |
| Página interna (linkeada del footer) | 1              | 1                   | 0             |
| "Gracias" post-form                  | 1              | 1                   | 0             |
| Legal (privacidad, términos)         | 1              | 1                   | 0             |
| Landing para Ads (sin nav)           | 1              | 1                   | **1**         |
| Borrador                             | 0              | —                   | —             |

Definiciones rápidas:

- **`is_published = 1`** → accesible en `/slug`. Si está en 0, devuelve 404.
- **`exclude_from_menu = 1`** → no aparece en el header ni en el drawer mobile.
  La página sigue accesible si alguien linkea o conoce el slug.
- **`hide_chrome = 1`** → la página se renderiza **sin** header ni footer.
  Solo para landings de campañas.

Quien lee `publishedPagesMenu()` ([lib/business.php:70](../lib/business.php:70))
es el header — filtra `is_published=1 AND exclude_from_menu=0`.

## Regla 3 — Tope de items en el menú: 5-6

Más allá de 6 entradas el header se ve abarrotado y rompe en mobile. Si
hacen falta más enlaces, van al **footer** o agrupados en una sola página
(ej. `recursos` con links internos). No estirar el menú.

## Regla 4 — El seed manda

La **fuente de verdad** de qué páginas existen al instalar es la migración
seed del cliente (hoy [028_greenbags_seed.sql](../migrations/028_greenbags_seed.sql))
+ los cleanup posteriores ([029_greenbags_cleanup_default_pages.sql](../migrations/029_greenbags_cleanup_default_pages.sql)).

Si querés que **toda instalación nueva** tenga una página dada, sumala al
seed — no solamente al admin del entorno actual. Si no, prod y local quedan
desincronizados (que es exactamente la embarrada que estamos evitando).

## Regla 5 — Limpieza: borrar > despublicar

Una página despublicada que nadie usa es ruido. Borrarla desde admin →
Páginas → Eliminar. El historial git tiene el seed por si hay que
reconstruir.

Excepción: páginas con tráfico orgánico (Google indexó) — despublicar y
poner 301 antes de borrar.

## Regla 6 — Sync prod ↔ local

Cuando prod y local muestren cosas distintas (como pasó el 2026-06-08), el
camino corto es exportar la tabla `pages` desde el lado canónico y aplicar
al otro:

```bash
# Desde prod (vía SSH):
mysqldump -h <host> -u <user> -p <db> pages settings > snapshot.sql

# En local:
mysql -h 127.0.0.1 -u pse -ppse pse_local < snapshot.sql
```

El snapshot también es buen backup antes de tocar.

---

## Mapa canónico para GreenBags

Lo que el sitio **debe** mostrar hoy (fase 1, modo cotización):

| Slug                 | Título                       | En menú | Flags                    | Origen                         |
|----------------------|------------------------------|---------|--------------------------|--------------------------------|
| (ninguno)            | Inicio                       | sí      | hardcoded en header      | [index.php](../index.php)      |
| `sobre-greenbags`    | Sobre GreenBags              | sí      | pub=1, excl=0            | seed 028                       |
| `sustentabilidad`    | Compromiso sustentable       | sí      | pub=1, excl=0            | seed 028                       |
| `gracias`            | ¡Gracias por escribirnos!    | no      | pub=1, excl=1            | instalador                     |
| `gracias-cotizacion` | ¡Gracias por tu solicitud!   | no      | pub=1, excl=1            | seed 028                       |

**Total en menú: 3** ("Inicio" + 2). Cabe dentro del tope de 5-6.

### Prohibidos por duplicación

| Slug              | Por qué                                                                                |
|-------------------|----------------------------------------------------------------------------------------|
| `home`, `inicio`  | Duplican el item hardcoded "Inicio" → `/` ya es el home renderizado por index.php      |
| `sobre-nosotros`  | Duplica `sobre-greenbags` (decisión de naming del cliente)                             |
| `quienes-somos`   | Idem                                                                                   |
| `bienvenido*`     | La bienvenida vive en el hero del home, no como página aparte                          |
| `contacto`        | Fase 1 no tiene form de contacto público (se quitó en 44aa608). El canal es WhatsApp + `/cotizacion`. Si vuelve, usar `contacto` (no `contactenos`). |

### Cleanup pendiente en producción (al 2026-06-08)

Prod muestra hoy 3 entradas extra que no deberían estar:

- `Bienvenido a Greenbags.cl` → revisar slug real y borrar.
- `Contacto` → borrar (Regla 4: el canal hoy es cotización + WhatsApp).
- `Sobre nosotros` → borrar (duplica `Sobre GreenBags`).

Antes de borrar, **conviene mirar el body** de cada una en admin → Páginas
por si el cliente cargó copy real que valga la pena mover a la página
canónica. Después:

```sql
-- Snapshot defensivo antes de tocar.
SELECT id, slug, title FROM pages WHERE slug IN
  ('bienvenido-a-greenbags-cl', 'bienvenido-a-greenbags', 'contacto', 'sobre-nosotros');

-- Confirmado el slug exacto del "Bienvenido", borrar las tres:
DELETE FROM pages WHERE slug IN
  ('<slug-bienvenido>', 'contacto', 'sobre-nosotros');
```

Si el cliente quiere conservar el contenido pero sacar del menú:
`UPDATE pages SET exclude_from_menu = 1 WHERE slug IN (...)` en vez de
`DELETE`.

## Checklist de 30 segundos antes de publicar una página

1. ¿Ya existe algo equivalente? → editá esa, no crees otra.
2. ¿Va al menú principal o es de apoyo? → setear `exclude_from_menu`.
3. ¿Es landing de Ads? → `hide_chrome=1` + `exclude_from_menu=1`.
4. ¿El menú quedaría con más de 6 entradas? → no entra al menú, va al footer.
5. ¿Debería existir en cada fresh install? → agregarla al seed del cliente.
