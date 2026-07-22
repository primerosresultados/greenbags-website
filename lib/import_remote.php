<?php
/**
 * Importador de catálogo desde sitios externos (esquinablanca.cl, tugou.cl).
 *
 * Helpers reutilizables, sin estado de scraping (eso vive en tools/scrape_*.php).
 * Reusa la maquinaria existente:
 *   - productSave()        lib/catalog.php   (alta/edición de producto)
 *   - categorySave()       lib/catalog.php   (alta de categoría)
 *   - mediaLibraryUpload() lib/media_library.php (procesa + registra imagen)
 *
 * Idempotente:
 *   - Productos: clave natural = SKU (UNIQUE). Re-correr hace UPDATE, no duplica.
 *   - Imágenes:  clave natural = media_library.seo_name. Si ya existe, reusa.
 *   - Categorías: por slug.
 *
 * NO se carga en bootstrap.php (es tooling). Los scripts CLI lo requieren a mano.
 */

/* ============================ HTTP ============================ */

const IMPORT_UA = 'GreenBagsCatalogImporter/1.0 (+https://greenbags.cl)';

/** GET con curl: follow redirects, UA propio, timeout y reintentos. */
function importHttpGet(string $url, array $opts = []): array {
    $tries   = (int) ($opts['tries'] ?? 3);
    $timeout = (int) ($opts['timeout'] ?? 30);
    $headers = $opts['headers'] ?? ['Accept: text/html,application/json,*/*'];

    $lastErr = '';
    for ($i = 1; $i <= $tries; $i++) {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_MAXREDIRS      => 5,
            CURLOPT_CONNECTTIMEOUT => 15,
            CURLOPT_TIMEOUT        => $timeout,
            CURLOPT_SSL_VERIFYPEER => true,
            CURLOPT_USERAGENT      => IMPORT_UA,
            CURLOPT_HTTPHEADER     => $headers,
            CURLOPT_ENCODING       => '', // acepta gzip
        ]);
        $body = curl_exec($ch);
        $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $ct   = (string) curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
        $err  = curl_error($ch);
        // curl_close() es no-op y está deprecado desde PHP 8.0; no se llama.

        if ($body !== false && $code >= 200 && $code < 400) {
            return ['ok' => true, 'code' => $code, 'body' => (string) $body, 'content_type' => $ct];
        }
        $lastErr = $err !== '' ? $err : ('HTTP ' . $code);
        if ($i < $tries) usleep(500000 * $i); // backoff lineal
    }
    return ['ok' => false, 'code' => 0, 'body' => '', 'content_type' => '', 'error' => $lastErr];
}

/* ============================ Imágenes ============================ */

/** Carpeta de media library find-or-create por nombre. Devuelve folder_id. */
function importEnsureFolder(string $name): ?int {
    foreach (mediaFoldersAll() as $f) {
        if (mb_strtolower($f['name']) === mb_strtolower($name)) return (int) $f['id'];
    }
    return mediaFolderCreate($name);
}

/** ¿Ya existe una media con este seo_name? Devuelve su id o null (idempotencia). */
function importMediaIdBySeoName(string $seoName): ?int {
    if ($seoName === '') return null;
    $st = getDB()->prepare('SELECT id FROM media_library WHERE seo_name = ? ORDER BY id LIMIT 1');
    $st->execute([$seoName]);
    $id = $st->fetchColumn();
    return $id ? (int) $id : null;
}

/**
 * Descarga una imagen remota, la procesa (WebP + srcset) y la registra en media.
 * Devuelve media_id o null. Idempotente por $seoName.
 */
function importImageFromUrl(string $url, ?int $folderId, string $seoName): ?int {
    $existing = importMediaIdBySeoName($seoName);
    if ($existing !== null) return $existing;

    $res = importHttpGet($url, ['headers' => ['Accept: image/*,*/*']]);
    if (!$res['ok'] || $res['body'] === '') return null;

    // Mime básico: solo jpg/png/webp (lo que acepta el pipeline).
    $ct = strtolower($res['content_type']);
    if ($ct !== '' && !preg_match('~image/(jpe?g|png|webp)~', $ct)) {
        // Algunos CDNs no mandan content-type fiable; dejamos que finfo decida igual.
    }

    $tmp = tempnam(sys_get_temp_dir(), 'gbimg_');
    if ($tmp === false) return null;
    if (file_put_contents($tmp, $res['body']) === false) { @unlink($tmp); return null; }

    $file = ['error' => UPLOAD_ERR_OK, 'tmp_name' => $tmp, 'size' => filesize($tmp) ?: 0];
    $up = mediaLibraryUpload($file, $folderId, $seoName);
    @unlink($tmp);

    return !empty($up['ok']) ? (int) $up['id'] : null;
}

/* ============================ Categorías ============================ */

const IMPORT_CATEGORY_FALLBACK = 'packaging-desechable';

/** Acentos → ASCII (independiente de la locale de iconv). */
function importStripAccents(string $s): string {
    $tr = [
        'á'=>'a','à'=>'a','ä'=>'a','â'=>'a','ã'=>'a','å'=>'a',
        'é'=>'e','è'=>'e','ë'=>'e','ê'=>'e',
        'í'=>'i','ì'=>'i','ï'=>'i','î'=>'i',
        'ó'=>'o','ò'=>'o','ö'=>'o','ô'=>'o','õ'=>'o',
        'ú'=>'u','ù'=>'u','ü'=>'u','û'=>'u',
        'ñ'=>'n','ç'=>'c',
    ];
    return strtr(mb_strtolower(trim($s), 'UTF-8'), $tr);
}

/** Normaliza un nombre para matching por palabra (lowercase, sin acentos, espacios). */
function importNormName(string $s): string {
    $s = importStripAccents($s);
    $s = preg_replace('/[^a-z0-9]+/', ' ', $s);
    return trim(preg_replace('/\s+/', ' ', $s));
}

/** Slug ASCII (para seo_name de imágenes y comparar categorías de origen). */
function importSlugifyCat(string $s): string {
    return trim(preg_replace('/[^a-z0-9]+/', '-', importStripAccents($s)), '-');
}

/** Prioridad de categorías (más específica → más genérica). */
function importCategoryPriority(): array {
    return [
        'aseo-y-limpieza', 'bolsas', 'packaging-ecologico', 'madera',
        'film-y-aluminio', 'carton', 'personalizacion-productos', 'packaging-desechable',
    ];
}

/**
 * Reglas por NOMBRE (señal primaria, muy confiable en packaging). Se evalúan en
 * orden de prioridad; la primera que matchea gana → categoría única y limpia.
 * @return array<string,string> slug => regex
 */
function importNameRules(): array {
    // Orden = prioridad. (?:es|s)?\b cubre plurales; \w* cubre stems.
    // Las bolsas van ANTES que ecológico: una "bolsa compostable" se agrupa en
    // Bolsas (categoría física), no en Ecológico (evita dispersar las bolsas).
    return [
        'aseo-y-limpieza'           => '/\b(?:guante|pechera|cofia|cubrezapato|gorro|redecilla|mascarilla|toalla|papel higienico|confort|jabon|cloro|desinfectante|alcohol gel|sanitiz\w*|trapero|escobillon|escoba|virutilla|esponja|limpia\w*|detergente|pano|wipe|nitrilo|vinilo)(?:es|s)?\b/',
        'bolsas'                    => '/\b(?:bolsa|saco|manilla|camiseta|courier)(?:es|s)?\b|\bprepicad\w*\b/',
        'packaging-ecologico'       => '/\b(?:compostable|biodegradable|bagazo|bagasse|fibra|compost|almidon)(?:es|s)?\b|\bc?pla\b|\bcana de azucar\b/',
        'madera'                    => '/\b(?:madera|palillo|palito|revolvedor|baja lengua|chuzo|brocheta|mondadiente)(?:es|s)?\b/',
        'film-y-aluminio'           => '/\b(?:film|alusa\w*|emboplast|papel aluminio|papel de aluminio|foil|rollo film|rollo de aluminio|osmotico|cinta de embalaje|cinta embalaje|cinta para embalaje|cinta adhesiva|strech|stretch|pull pack)(?:es|s)?\b/',
        'carton'                    => '/\b(?:caja|cartulina|papel acoplado|papel antigrasa|papel duofresh|duofresh|cartucho|brazo de reina|cucurucho|blonda|capsula|molde|resma|collarin|canoa)(?:es|s)?\b|(?<!tapa )\bcarton\b/',
        'personalizacion-productos' => '/\b(?:personaliza\w*|impreso|impresion|logo|corporativ\w*|publicit\w*|cordel|ovillo|elastico|hilo)(?:es|s)?\b/',
        'packaging-desechable'      => '/\b(?:vaso|plato|cubierto|tenedor|cuchara|cuchillo|pote|contenedor|bandeja|envase|tapa|copa|bowl|pocillo|domo|cubrevaso|balde|salsero|sorbete|pajilla|bombilla|mug|individual|portacubierto|servilleta|mantel|removedor|alambre|cubresandwich|colacion|delivery)(?:es|s)?\b/',
    ];
}

/** Mapa categoría de ORIGEN (slug) → slug GreenBags. Señal secundaria. */
function importSourceCategoryMap(): array {
    return [
        // desechable (envases + mesa)
        'para-envasar'=>'packaging-desechable','potes-y-tapas'=>'packaging-desechable',
        'salseros-y-tapas'=>'packaging-desechable','salseros-papel'=>'packaging-desechable',
        'envases-con-tapa-bisagra'=>'packaging-desechable','envases-y-tapas'=>'packaging-desechable',
        'bandejas-y-tapas'=>'packaging-desechable','bandejas'=>'packaging-desechable',
        'baldes'=>'packaging-desechable','potes'=>'packaging-desechable','potes-bisagra'=>'packaging-desechable',
        'para-la-mesa'=>'packaging-desechable','vasos-y-tapas'=>'packaging-desechable',
        'platos'=>'packaging-desechable','cubiertos'=>'packaging-desechable','copas'=>'packaging-desechable',
        'servilletas'=>'packaging-desechable','cubrevasos'=>'packaging-desechable','vasos'=>'packaging-desechable',
        'mug'=>'packaging-desechable','envases-para-alimentos'=>'packaging-desechable',
        'vasos-platos-cubiertos-potes-copas'=>'packaging-desechable',
        // bolsas
        'envolver-y-llevar'=>'bolsas','bolsas'=>'bolsas','bolsas-prepicadas'=>'bolsas','bolsas-contenedoras'=>'bolsas',
        // cartón
        'papel-acoplado'=>'carton','cartuchos-cajas-y-otros'=>'carton','papeleria-y-cartones'=>'carton',
        // film y aluminio
        'rollos-y-cintas-embalaje'=>'film-y-aluminio','film-y-rollo-alimentos'=>'film-y-aluminio',
        'rollos-prepicados'=>'film-y-aluminio',
        // aseo
        'para-manipular'=>'aseo-y-limpieza','guantes'=>'aseo-y-limpieza','gorros-redecillas'=>'aseo-y-limpieza',
        'mascarilla'=>'aseo-y-limpieza','pechera'=>'aseo-y-limpieza','cubrezapatos'=>'aseo-y-limpieza',
        'aseo-e-higiene'=>'aseo-y-limpieza',
        // madera
        'bombillas-revolvedores-y-palillos'=>'madera',
        // ecológico
        'linea-ecologica'=>'packaging-ecologico',
        // personalización
        'articulos-para-embalajes-y-oficina'=>'personalizacion-productos',
        'personalizacion-corporativa'=>'personalizacion-productos',
    ];
}

/** Cache slug→id de categorías GreenBags. */
function importCategoryIdBySlug(string $slug): ?int {
    static $cache = [];
    if (array_key_exists($slug, $cache)) return $cache[$slug];
    $cat = categoryGetBySlug($slug);
    return $cache[$slug] = $cat ? (int) $cat['id'] : null;
}

/**
 * Determina la ÚNICA categoría GreenBags para un producto.
 * 1) reglas por nombre (prioridad) → 2) mapa de categorías de origen
 * (la más específica por prioridad) → 3) fallback.
 */
function importBestCategorySlug(string $name, array $sourceCats): string {
    $norm = importNormName($name);
    foreach (importNameRules() as $slug => $rx) {
        if (preg_match($rx, $norm)) return $slug;
    }
    // Señal secundaria: categorías de origen, eligiendo la más específica.
    $map = importSourceCategoryMap();
    $hits = [];
    foreach ($sourceCats as $sc) {
        $key = importSlugifyCat((string) $sc);
        if (isset($map[$key])) $hits[$map[$key]] = true;
    }
    foreach (importCategoryPriority() as $slug) {
        if (isset($hits[$slug])) return $slug;
    }
    return IMPORT_CATEGORY_FALLBACK;
}

/**
 * Devuelve el id de categoría (en array, para productSetCategories).
 * @return int[] (un único id, para un agrupamiento limpio)
 */
function importResolveCategories(string $name, array $sourceCats): array {
    $slug = importBestCategorySlug($name, $sourceCats);
    $id = importCategoryIdBySlug($slug) ?? importCategoryIdBySlug(IMPORT_CATEGORY_FALLBACK);
    return $id ? [$id] : [];
}

/* ============================ Productos ============================ */

function importFindProductIdBySku(string $sku): ?int {
    if ($sku === '') return null;
    $st = getDB()->prepare('SELECT id FROM products WHERE sku = ? LIMIT 1');
    $st->execute([$sku]);
    $id = $st->fetchColumn();
    return $id ? (int) $id : null;
}

/**
 * Upsert de un producto normalizado (publicado). Idempotente por SKU.
 *
 * $row: { source, sku, name, price, currency, description, short_description,
 *         image_urls[], source_categories[], permalink }
 * $imageFolderId: carpeta de media donde guardar las imágenes descargadas.
 *
 * @return array{ok:bool, id?:int, action?:string, images?:int, error?:string}
 */
function importUpsertProduct(array $row, ?int $imageFolderId): array {
    $sku  = trim((string) ($row['sku'] ?? ''));
    $name = trim((string) ($row['name'] ?? ''));
    if ($name === '') return ['ok' => false, 'error' => 'sin nombre'];
    if ($sku === '')  return ['ok' => false, 'error' => 'sin SKU'];

    $existingId = importFindProductIdBySku($sku);

    // Imágenes: descargar (idempotente) y juntar media ids.
    $mediaIds = [];
    foreach (array_slice((array) ($row['image_urls'] ?? []), 0, 6) as $i => $imgUrl) {
        $imgUrl = trim((string) $imgUrl);
        if ($imgUrl === '') continue;
        $seo = importSlugifyCat($sku . '-' . ($i + 1));
        $mid = importImageFromUrl($imgUrl, $imageFolderId, $seo);
        if ($mid) $mediaIds[] = $mid;
    }

    $cats = importResolveCategories($name, (array) ($row['source_categories'] ?? []));

    // Regla de publicación: con precio → publicado; sin precio (ej. tugou oculta
    // precios) → borrador, para no mostrar "$0" en la tienda en vivo. El cliente
    // los completa y publica desde el admin. Override con $row['force_status'].
    $price  = (float) ($row['price'] ?? 0);
    $status = !empty($row['force_status']) ? (string) $row['force_status']
            : ($price > 0 ? 'published' : 'draft');

    $data = [
        'name'              => $name,
        'sku'               => $sku,
        'price'             => $price,
        'description'       => (string) ($row['description'] ?? ''),
        'short_description' => (string) ($row['short_description'] ?? ''),
        'status'            => $status,
        'type'              => 'simple',
        'item_condition'    => 'new', // productSave tiene un bug si esta clave falta
        'stock_status'      => 'in_stock',
        'categories'        => $cats,
    ];
    if ($existingId) $data['id'] = $existingId;
    // Solo pisamos imágenes si conseguimos al menos una (no borrar las que ya había).
    if ($mediaIds) $data['image_ids'] = $mediaIds;

    $res = productSave($data);
    if (empty($res['ok'])) return ['ok' => false, 'error' => $res['error'] ?? 'productSave falló'];

    return [
        'ok'     => true,
        'id'     => (int) $res['id'],
        'action' => $existingId ? 'updated' : 'created',
        'images' => count($mediaIds),
    ];
}
