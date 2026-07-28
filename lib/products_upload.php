<?php
/**
 * Carga masiva de productos por CSV (altas + actualizaciones) desde el admin.
 *
 * Flujo: el usuario baja el CSV de ejemplo (productsUploadTemplateCsv), lo llena
 * y lo sube. Cada fila resuelve su destino así:
 *   - Si trae "id", actualiza ese producto.
 *   - Si no, busca por SKU: si existe lo actualiza, si no crea uno nuevo.
 * Celda vacía = "no tocar" (en altas, queda el valor por defecto).
 *
 * Las altas pasan por productSave(); las ediciones usan un UPDATE acotado a las
 * columnas que vinieron en el archivo, para no pisar SEO, variaciones ni datos
 * que el CSV no conoce.
 */

const PRODUCTS_UPLOAD_MAX_ROWS   = 3000; // filas procesadas por archivo
const PRODUCTS_UPLOAD_MAX_IMAGES = 200;  // descargas de imagen por archivo
const PRODUCTS_UPLOAD_MAX_ERRORS = 40;   // detalles mostrados al usuario
const PRODUCTS_UPLOAD_DELIM      = ';';  // separador del ejemplo (Excel es-CL)

/**
 * Columnas del formato, en orden, con su ayuda para el ejemplo y la vista.
 * @return array<int,array{col:string,help:string}>
 */
function productsUploadSpec(): array {
    return [
        ['col' => 'id',                'help' => 'Vacío = producto nuevo. Con id, actualiza ese producto.'],
        ['col' => 'nombre',            'help' => 'Obligatorio para crear. Ej: BOLSA KRAFT CON ASA 20x25 (50 uds)'],
        ['col' => 'sku',               'help' => 'Código único. Si el SKU ya existe, la fila actualiza ese producto.'],
        ['col' => 'precio',            'help' => 'Solo números. Acepta 4990, 4.990 o $4.990.'],
        ['col' => 'precio_oferta',     'help' => 'Opcional. Vacío = sin oferta.'],
        ['col' => 'stock',             'help' => 'Cantidad. Solo aplica si gestiona_stock = si.'],
        ['col' => 'gestiona_stock',    'help' => 'si / no. "no" = stock infinito (∞).'],
        ['col' => 'estado_stock',      'help' => 'en stock / sin stock / bajo pedido.'],
        ['col' => 'estado',            'help' => 'publicado / borrador / archivado. Vacío = publicado.'],
        ['col' => 'destacado',         'help' => 'si / no.'],
        ['col' => 'categorias',        'help' => 'Nombres separados por | . Si no existen, se crean.'],
        ['col' => 'marca',             'help' => 'Opcional.'],
        ['col' => 'descripcion_corta', 'help' => 'Resumen breve (máx. 500 caracteres).'],
        ['col' => 'descripcion',       'help' => 'Descripción larga. Acepta HTML.'],
        ['col' => 'imagen_url',        'help' => 'URL(s) de foto separadas por | . Se descargan al subir.'],
    ];
}

/** Encabezados aceptados → columna canónica (tolera sinónimos y acentos). */
function productsUploadAliases(): array {
    return [
        'id' => 'id', 'id_producto' => 'id',
        'nombre' => 'nombre', 'producto' => 'nombre', 'titulo' => 'nombre', 'name' => 'nombre',
        'sku' => 'sku', 'codigo' => 'sku',
        'precio' => 'precio', 'precio_normal' => 'precio', 'price' => 'precio',
        'precio_oferta' => 'precio_oferta', 'oferta' => 'precio_oferta', 'precio_rebajado' => 'precio_oferta',
        'stock' => 'stock', 'cantidad' => 'stock', 'stock_qty' => 'stock',
        'gestiona_stock' => 'gestiona_stock', 'gestionar_stock' => 'gestiona_stock', 'controla_stock' => 'gestiona_stock',
        'estado_stock' => 'estado_stock', 'disponibilidad' => 'estado_stock',
        'estado' => 'estado', 'status' => 'estado',
        'destacado' => 'destacado', 'featured' => 'destacado',
        'categorias' => 'categorias', 'categoria' => 'categorias',
        'marca' => 'marca', 'brand' => 'marca',
        'descripcion_corta' => 'descripcion_corta', 'resumen' => 'descripcion_corta',
        'descripcion' => 'descripcion', 'descripcion_larga' => 'descripcion',
        'imagen_url' => 'imagen_url', 'imagen' => 'imagen_url', 'imagenes' => 'imagen_url',
        'url_imagen' => 'imagen_url', 'foto' => 'imagen_url', 'fotos' => 'imagen_url',
    ];
}

/** Filas de ejemplo del CSV descargable (mismo orden que productsUploadSpec()). */
function productsUploadSampleRows(): array {
    return [
        ['', 'BOLSA KRAFT CON ASA TROQUELADA 20x25 (50 unidades)', 'EJ-BKA2025', '4990', '4490', '0', 'no',
         'en stock', 'publicado', 'si', 'Bolsas de papel', 'GreenBags',
         'Bolsa de papel kraft con asa troquelada, pack de 50 unidades.',
         '<p>Bolsa de papel kraft de 90 g, resistente y 100% reciclable. Ideal para retail y delivery.</p>', ''],
        ['', 'VASO DE PAPEL 8oz (50 unidades)', 'EJ-VP8', '3290', '', '120', 'si',
         'en stock', 'publicado', 'no', 'Vasos|Packaging desechable', 'GreenBags',
         'Vaso de papel para bebidas calientes, 8 onzas, pack de 50.',
         '', ''],
        ['', 'TAPA PARA VASO 8oz NEGRA (50 unidades)', 'EJ-TV8N', '1990', '', '0', 'no',
         'bajo pedido', 'borrador', 'no', 'Vasos', '',
         'Tapa con boquilla para vaso de 8 onzas, pack de 50.', '', ''],
    ];
}

/** Descarga el CSV de ejemplo (BOM UTF-8 + separador ";" para Excel). Termina la ejecución. */
function productsUploadTemplateCsv(): void {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="ejemplo-carga-masiva-productos.csv"');
    $out = fopen('php://output', 'w');
    fwrite($out, "\xEF\xBB\xBF");
    fputcsv($out, array_column(productsUploadSpec(), 'col'), PRODUCTS_UPLOAD_DELIM, '"', '');
    foreach (productsUploadSampleRows() as $row) fputcsv($out, $row, PRODUCTS_UPLOAD_DELIM, '"', '');
    fclose($out);
    exit;
}

/* ===================== Parseo de celdas ===================== */

/** "$4.990" / "4990" / "4.990,50" → float. null si está vacío o no es número. */
function productsUploadNumber(string $v): ?float {
    $v = preg_replace('/[^0-9,.\-]/', '', trim($v));
    if ($v === '' || $v === '-') return null;
    $dot = strrpos($v, '.');
    $com = strrpos($v, ',');
    if ($dot !== false && $com !== false) {
        // El separador más a la derecha es el decimal.
        $v = $com > $dot ? str_replace(['.', ','], ['', '.'], $v) : str_replace(',', '', $v);
    } elseif ($com !== false) {
        $v = str_replace(',', '.', $v);
    } elseif ($dot !== false && preg_match('/^-?\d{1,3}(\.\d{3})+$/', $v)) {
        $v = str_replace('.', '', $v); // miles a la chilena: 1.700 → 1700
    }
    return is_numeric($v) ? (float) $v : null;
}

/** si/no/1/0/true/false → 1|0. null si no se reconoce o está vacío. */
function productsUploadBool(string $v): ?int {
    $v = mb_strtolower(trim($v));
    if ($v === '') return null;
    if (in_array($v, ['1', 'si', 'sí', 's', 'yes', 'y', 'true', 'x', 'verdadero'], true)) return 1;
    if (in_array($v, ['0', 'no', 'n', 'false', 'falso'], true)) return 0;
    return null;
}

/** "publicado"/"draft"/… → estado válido de products.status. null si no se reconoce. */
function productsUploadStatus(string $v): ?string {
    $map = [
        'publicado' => 'published', 'published' => 'published', 'publicar' => 'published',
        'activo' => 'published', 'visible' => 'published',
        'borrador' => 'draft', 'draft' => 'draft', 'oculto' => 'draft',
        'archivado' => 'archived', 'archived' => 'archived',
    ];
    return $map[slugify($v)] ?? null;
}

/** "en stock"/"agotado"/… → products.stock_status. null si no se reconoce. */
function productsUploadStockStatus(string $v): ?string {
    $map = [
        'en-stock' => 'in_stock', 'in-stock' => 'in_stock', 'disponible' => 'in_stock', 'stock' => 'in_stock',
        'sin-stock' => 'out_of_stock', 'out-of-stock' => 'out_of_stock', 'agotado' => 'out_of_stock',
        'bajo-pedido' => 'backorder', 'backorder' => 'backorder', 'a-pedido' => 'backorder',
        'sobre-pedido' => 'backorder',
    ];
    return $map[slugify($v)] ?? null;
}

/* ===================== Búsquedas / escrituras ===================== */

/** Busca un producto por SKU exacto. Devuelve id o 0. */
function productsUploadFindIdBySku(string $sku): int {
    $sku = trim($sku);
    if ($sku === '') return 0;
    $st = getDB()->prepare('SELECT id FROM products WHERE sku = ? LIMIT 1');
    $st->execute([$sku]);
    return (int) ($st->fetchColumn() ?: 0);
}

/**
 * Resuelve nombres de categorías a ids (por slug o por nombre). Crea las que
 * falten. $cache se reusa entre filas para no pegarle a la base por cada una.
 * @return int[]
 */
function productsUploadCategoryIds(string $raw, array &$cache): array {
    if ($cache === []) {
        foreach (categoryList(false) as $c) {
            $cache[(string) $c['slug']] = (int) $c['id'];
            $cache[slugify((string) $c['name'])] = (int) $c['id'];
        }
    }
    $ids = [];
    foreach (preg_split('/[|;,\/]+/', $raw) ?: [] as $part) {
        $name = trim($part);
        if ($name === '') continue;
        $key = slugify($name);
        if ($key === '') continue;
        if (!isset($cache[$key])) {
            $res = categorySave(['name' => $name, 'is_active' => 1]);
            if (empty($res['ok'])) continue;
            $cache[$key] = (int) $res['id'];
        }
        $ids[] = $cache[$key];
    }
    return array_values(array_unique($ids));
}

/**
 * Descarga las imágenes de una celda "imagen_url" y devuelve sus media_id.
 * $budget se descuenta por descarga para acotar el tiempo de la request.
 * @return int[]
 */
function productsUploadImageIds(string $raw, string $seoBase, int &$budget, array &$errors, int $line): array {
    $urls = array_values(array_filter(array_map('trim', preg_split('/[|\s]+/', $raw) ?: [])));
    if (!$urls) return [];
    if (!function_exists('importImageFromUrl')) require_once __DIR__ . '/import_remote.php';

    static $folderId = null;
    if ($folderId === null) $folderId = importEnsureFolder('Carga masiva') ?: 0;

    $ids = [];
    foreach ($urls as $i => $url) {
        if ($budget <= 0) {
            $errors[] = "Fila $line: no se descargaron más fotos (límite de " . PRODUCTS_UPLOAD_MAX_IMAGES . " por archivo).";
            break;
        }
        if (!preg_match('~^https?://~i', $url)) {
            $errors[] = "Fila $line: la URL de imagen debe empezar con http:// o https://.";
            continue;
        }
        $budget--;
        @set_time_limit(60);
        $seo = $seoBase . ($i > 0 ? '-' . ($i + 1) : '');
        $mid = importImageFromUrl($url, $folderId ?: null, $seo);
        if ($mid) $ids[] = $mid;
        else $errors[] = "Fila $line: no se pudo descargar la imagen ($url).";
    }
    return $ids;
}

/**
 * UPDATE acotado: escribe solo las columnas presentes en $f (las que vinieron
 * con dato en el CSV). Recalcula min/max price si cambió algún precio.
 * No toca slug (para no romper URLs) ni variaciones.
 */
function productsUploadUpdate(int $id, array $f): bool {
    $allowed = ['name', 'sku', 'price', 'sale_price', 'stock_qty', 'manage_stock',
                'stock_status', 'status', 'featured', 'short_description', 'description', 'brand'];
    $existing = productGet($id);
    if (!$existing) return false;

    $set = []; $params = ['id' => $id];
    foreach ($allowed as $k) {
        if (!array_key_exists($k, $f)) continue;
        $set[] = "$k = :$k";
        $params[$k] = $f[$k];
    }
    if (!$set) return true; // fila sin cambios: no es un error

    if (array_key_exists('price', $f) || array_key_exists('sale_price', $f)) {
        $price = (float) ($f['price'] ?? $existing['price']);
        $sale  = array_key_exists('sale_price', $f) ? $f['sale_price'] : $existing['sale_price'];
        $set[] = 'min_price = :min_price';
        $set[] = 'max_price = :max_price';
        $params['min_price'] = $sale !== null ? min($price, (float) $sale) : $price;
        $params['max_price'] = $price;
    }

    $stmt = getDB()->prepare('UPDATE products SET ' . implode(', ', $set) . ' WHERE id = :id');
    return $stmt->execute($params);
}

/* ===================== Import ===================== */

/** Detecta el separador del CSV mirando la línea de encabezados. */
function productsUploadDelimiter(string $headerLine): string {
    $best = ','; $bestN = 0;
    foreach ([',', ';', "\t", '|'] as $d) {
        $n = substr_count($headerLine, $d);
        if ($n > $bestN) { $best = $d; $bestN = $n; }
    }
    return $best;
}

/**
 * Procesa el CSV subido: crea y actualiza productos.
 * @return array{ok:bool,created?:int,updated?:int,skipped?:int,errors?:string[],error?:string}
 */
function productsUploadCsv(?array $file): array {
    $err = $file['error'] ?? UPLOAD_ERR_NO_FILE;
    if (!$file || $err !== UPLOAD_ERR_OK) {
        $msg = in_array($err, [UPLOAD_ERR_INI_SIZE, UPLOAD_ERR_FORM_SIZE], true)
            ? 'El archivo es demasiado grande para el servidor.'
            : 'No se recibió un archivo válido.';
        return ['ok' => false, 'error' => $msg];
    }
    if (($file['size'] ?? 0) > 10 * 1024 * 1024) {
        return ['ok' => false, 'error' => 'El archivo supera 10MB.'];
    }
    $fh = @fopen($file['tmp_name'], 'r');
    if (!$fh) return ['ok' => false, 'error' => 'No se pudo abrir el archivo.'];

    $firstLine = (string) fgets($fh);
    if (trim($firstLine) === '') { fclose($fh); return ['ok' => false, 'error' => 'El archivo está vacío.']; }
    $delim = productsUploadDelimiter($firstLine);
    rewind($fh);

    $header = fgetcsv($fh, 0, $delim, '"', '');
    if (!$header) { fclose($fh); return ['ok' => false, 'error' => 'No se pudieron leer los encabezados.']; }
    $header[0] = preg_replace('/^\xEF\xBB\xBF/', '', (string) $header[0]);

    $aliases = productsUploadAliases();
    $map = [];
    foreach ($header as $i => $h) {
        $key = str_replace('-', '_', slugify((string) $h));
        if (isset($aliases[$key])) $map[$aliases[$key]] = $i;
    }
    if (!isset($map['nombre']) && !isset($map['id'])) {
        fclose($fh);
        return ['ok' => false, 'error' => 'El archivo no tiene la columna "nombre". Descarga el ejemplo y usa esos encabezados.'];
    }

    @set_time_limit(300);
    $created = 0; $updated = 0; $skipped = 0; $processed = 0;
    $errors = []; $catCache = []; $imgBudget = PRODUCTS_UPLOAD_MAX_IMAGES;
    $line = 1;

    $addError = function (string $msg) use (&$errors) {
        if (count($errors) < PRODUCTS_UPLOAD_MAX_ERRORS) $errors[] = $msg;
    };

    while (($row = fgetcsv($fh, 0, $delim, '"', '')) !== false) {
        $line++;
        if ($row === [null] || implode('', array_map('trim', array_map('strval', $row))) === '') continue;
        if ($processed >= PRODUCTS_UPLOAD_MAX_ROWS) {
            $addError('Se procesaron las primeras ' . PRODUCTS_UPLOAD_MAX_ROWS . ' filas. Sube el resto en otro archivo.');
            break;
        }
        $processed++;

        $val = function (string $key) use ($map, $row): ?string {
            if (!isset($map[$key])) return null;
            $v = $row[$map[$key]] ?? null;
            return $v === null ? null : trim((string) $v);
        };
        $filled = fn(string $key): bool => ($val($key) ?? '') !== '';

        // --- Campos que vinieron con dato (celda vacía = no tocar) ---
        $f = [];
        if ($filled('nombre')) $f['name'] = mb_substr((string) $val('nombre'), 0, 255);
        if ($filled('sku'))    $f['sku']  = mb_substr((string) $val('sku'), 0, 100);
        if ($filled('precio')) {
            $n = productsUploadNumber((string) $val('precio'));
            if ($n === null) { $addError("Fila $line: precio inválido (" . $val('precio') . ")."); $skipped++; continue; }
            $f['price'] = max(0, $n);
        }
        if ($filled('precio_oferta')) {
            $n = productsUploadNumber((string) $val('precio_oferta'));
            if ($n === null) { $addError("Fila $line: precio_oferta inválido (" . $val('precio_oferta') . ")."); $skipped++; continue; }
            $f['sale_price'] = max(0, $n);
        }
        if ($filled('stock')) {
            $n = productsUploadNumber((string) $val('stock'));
            if ($n === null) { $addError("Fila $line: stock inválido (" . $val('stock') . ")."); $skipped++; continue; }
            $f['stock_qty'] = (int) $n;
        }
        if ($filled('gestiona_stock')) {
            $b = productsUploadBool((string) $val('gestiona_stock'));
            if ($b === null) { $addError("Fila $line: gestiona_stock debe ser \"si\" o \"no\"."); $skipped++; continue; }
            $f['manage_stock'] = $b;
        }
        if ($filled('destacado')) {
            $b = productsUploadBool((string) $val('destacado'));
            if ($b === null) { $addError("Fila $line: destacado debe ser \"si\" o \"no\"."); $skipped++; continue; }
            $f['featured'] = $b;
        }
        if ($filled('estado')) {
            $s = productsUploadStatus((string) $val('estado'));
            if ($s === null) { $addError("Fila $line: estado inválido (" . $val('estado') . "). Usa publicado, borrador o archivado."); $skipped++; continue; }
            $f['status'] = $s;
        }
        if ($filled('estado_stock')) {
            $s = productsUploadStockStatus((string) $val('estado_stock'));
            if ($s === null) { $addError("Fila $line: estado_stock inválido (" . $val('estado_stock') . ")."); $skipped++; continue; }
            $f['stock_status'] = $s;
        }
        if ($filled('descripcion_corta')) $f['short_description'] = mb_substr((string) $val('descripcion_corta'), 0, 500);
        if ($filled('descripcion'))       $f['description']       = (string) $val('descripcion');
        if ($filled('marca'))             $f['brand']             = mb_substr((string) $val('marca'), 0, 120);

        // --- ¿Alta o edición? ---
        $id = (int) ($val('id') ?? 0);
        if ($id > 0 && !productGet($id)) {
            $addError("Fila $line: no existe un producto con id $id.");
            $skipped++;
            continue;
        }
        if ($id === 0 && !empty($f['sku'])) $id = productsUploadFindIdBySku($f['sku']);

        $catIds = $filled('categorias') ? productsUploadCategoryIds((string) $val('categorias'), $catCache) : null;
        $seoBase = slugify((string) ($f['name'] ?? $f['sku'] ?? ('producto-' . $line)));
        $imgIds  = $filled('imagen_url')
            ? productsUploadImageIds((string) $val('imagen_url'), $seoBase ?: ('producto-' . $line), $imgBudget, $errors, $line)
            : [];

        if ($id === 0) {
            // Alta: el nombre es obligatorio y el resto toma valores por defecto.
            if (empty($f['name'])) { $addError("Fila $line: falta el nombre."); $skipped++; continue; }
            $data = $f + [
                'status'         => 'published', // el default del CSV es "publicado"
                'manage_stock'   => 0,
                'stock_status'   => 'in_stock',
                'featured'       => 0,
                'price'          => 0,
                'type'           => 'simple',
                'item_condition' => 'new',
            ];
            $data['categories'] = $catIds ?? [];
            if ($imgIds) $data['image_ids'] = $imgIds;
            $res = productSave($data);
            if (empty($res['ok'])) {
                $addError("Fila $line: " . ($res['error'] ?? 'no se pudo crear el producto.'));
                $skipped++;
                continue;
            }
            $created++;
            continue;
        }

        try {
            if (!productsUploadUpdate($id, $f)) {
                $addError("Fila $line: no se pudo actualizar el producto $id.");
                $skipped++;
                continue;
            }
        } catch (PDOException $e) {
            $addError("Fila $line: no se pudo actualizar (¿SKU duplicado?).");
            $skipped++;
            continue;
        }
        if ($catIds !== null && $catIds !== []) productSetCategories($id, $catIds);
        if ($imgIds) productSetImages($id, $imgIds);
        $updated++;
    }
    fclose($fh);

    return ['ok' => true, 'created' => $created, 'updated' => $updated,
            'skipped' => $skipped, 'errors' => $errors];
}
