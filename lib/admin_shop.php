<?php
/**
 * Acciones del admin para la tienda (catálogo).
 * Se incluye desde admin/index.php dentro del bloque autenticado.
 * Cada acción valida CSRF y redirige (patrón POST-redirect-GET del proyecto).
 */

require_once __DIR__ . '/products_upload.php';

/** Devuelve true si la acción fue de tienda y ya se manejó (con redirect). */
function handleShopAdminActions(array $user, string $action): bool {
    switch ($action) {

        case 'cat_save':
            csrfCheck();
            $res = categorySave($_POST);
            if ($res['ok']) {
                flashSet('shop_msg', 'Categoría guardada.');
                redirect('/admin/?view=categories');
            }
            flashSet('shop_err', $res['error'] ?? 'No se pudo guardar.');
            redirect('/admin/?view=category&id=' . (int) ($_POST['id'] ?? 0));
            return true;

        case 'cat_delete':
            csrfCheck();
            categoryDelete((int) ($_POST['id'] ?? 0));
            flashSet('shop_msg', 'Categoría eliminada.');
            redirect('/admin/?view=categories');
            return true;

        case 'product_save':
            csrfCheck();
            $res = productSave($_POST);
            if ($res['ok']) {
                flashSet('shop_msg', 'Producto guardado.');
                redirect('/admin/?view=product&id=' . $res['id']);
            }
            flashSet('shop_err', $res['error'] ?? 'No se pudo guardar.');
            redirect('/admin/?view=product&id=' . (int) ($_POST['id'] ?? 0));
            return true;

        case 'product_delete':
            csrfCheck();
            productDelete((int) ($_POST['id'] ?? 0));
            flashSet('shop_msg', 'Producto eliminado.');
            redirect('/admin/?view=products');
            return true;

        case 'variations_save':
            csrfCheck();
            $pid = (int) ($_POST['id'] ?? 0);
            variationUpdateBulk($pid, (array) ($_POST['variations'] ?? []));
            flashSet('shop_msg', 'Variaciones actualizadas.');
            redirect('/admin/?view=product&id=' . $pid);
            return true;

        case 'products_bulk_save':
            csrfCheck();
            $n = productBulkUpdate((array) ($_POST['rows'] ?? []));
            flashSet('shop_msg', $n . ' producto(s) actualizados.');
            redirect('/admin/?' . http_build_query(array_filter([
                'view'   => 'products_bulk',
                'search' => trim((string) ($_POST['search'] ?? '')),
                'status' => (string) ($_POST['status'] ?? ''),
            ])));
            return true;

        case 'products_bulk_delete':
            csrfCheck();
            $n = productBulkDelete((array) ($_POST['del'] ?? []));
            flashSet('shop_msg', $n . ' producto(s) eliminados.');
            redirect('/admin/?' . http_build_query(array_filter([
                'view'   => 'products_bulk',
                'search' => trim((string) ($_POST['search'] ?? '')),
                'status' => (string) ($_POST['status'] ?? ''),
            ])));
            return true;

        case 'products_export':
            productsExportCsv($_GET); // imprime y hace exit
            return true;

        case 'products_import':
            csrfCheck();
            $res = productsImportCsv($_FILES['file'] ?? null);
            if (!empty($res['ok'])) {
                flashSet('shop_msg', $res['updated'] . ' producto(s) actualizados desde el archivo.'
                    . (!empty($res['skipped']) ? ' ' . $res['skipped'] . ' fila(s) omitida(s).' : ''));
            } else {
                flashSet('shop_err', $res['error'] ?? 'No se pudo importar el archivo.');
            }
            redirect('/admin/?view=products_bulk');
            return true;

        case 'products_template':
            productsUploadTemplateCsv(); // imprime y hace exit
            return true;

        case 'products_upload':
            csrfCheck();
            $res = productsUploadCsv($_FILES['file'] ?? null);
            if (!empty($res['ok'])) {
                flashSet('shop_msg', ($res['created'] ?? 0) . ' producto(s) creados y '
                    . ($res['updated'] ?? 0) . ' actualizado(s).'
                    . (!empty($res['skipped']) ? ' ' . $res['skipped'] . ' fila(s) omitida(s).' : ''));
            } else {
                flashSet('shop_err', $res['error'] ?? 'No se pudo procesar el archivo.');
            }
            if (!empty($res['errors'])) {
                flashSet('shop_upload_detail', json_encode(array_values($res['errors']), JSON_UNESCAPED_UNICODE));
            }
            redirect('/admin/?view=products_upload');
            return true;
    }
    return false;
}

/**
 * Exporta el catálogo a CSV para Excel en español: BOM UTF-8, separador «;»
 * y precios sin decimales, así se abre en columnas y Excel no confunde
 * «12990.00» con miles. Respeta los filtros de búsqueda/estado.
 */
function productsExportCsv(array $o): void {
    $rows = productBulkList([
        'search' => trim((string) ($o['search'] ?? '')),
        'status' => (string) ($o['status'] ?? ''),
    ]);
    $num = fn($v) => $v === null || $v === '' ? '' : (floor((float) $v) == (float) $v
        ? (string) (int) $v : str_replace('.', ',', (string) (float) $v));
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="productos-' . date('Ymd-His') . '.csv"');
    $out = fopen('php://output', 'w');
    fwrite($out, "\xEF\xBB\xBF"); // BOM UTF-8 para Excel
    fputcsv($out, ['id', 'nombre', 'sku', 'precio', 'precio_oferta', 'stock',
                   'gestiona_stock', 'estado_stock', 'estado', 'destacado', 'descripcion_corta'], ';', '"', '');
    foreach ($rows as $r) {
        fputcsv($out, [
            $r['id'], $r['name'], $r['sku'], $num($r['price']), $num($r['sale_price']),
            $r['stock_qty'], $r['manage_stock'], $r['stock_status'],
            $r['status'], $r['featured'], $r['short_description'],
        ], ';', '"', '');
    }
    fclose($out);
    exit;
}

/**
 * Importa un CSV (el formato del export) y actualiza productos por id.
 * Tolera lo que hace Excel al guardar: separador «;» o «,», precios como
 * «$12.990» o «12.990,50», columnas reordenadas o borradas. Una columna que
 * no viene, o una celda vacía, deja el valor actual del producto (salvo
 * precio_oferta, donde vacío = sin oferta, igual que en la tabla).
 * @return array{ok:bool,updated?:int,skipped?:int,error?:string}
 */
function productsImportCsv(?array $file): array {
    if (!$file || ($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
        return ['ok' => false, 'error' => 'No se recibió un archivo válido.'];
    }
    if (($file['size'] ?? 0) > 5 * 1024 * 1024) {
        return ['ok' => false, 'error' => 'El archivo supera 5MB.'];
    }
    $fh = @fopen($file['tmp_name'], 'r');
    if (!$fh) return ['ok' => false, 'error' => 'No se pudo abrir el archivo.'];

    $firstLine = (string) fgets($fh);
    if (strncmp($firstLine, "PK\x03\x04", 4) === 0) {
        fclose($fh);
        return ['ok' => false, 'error' => 'Subiste un archivo .xlsx. En Excel usa «Guardar como» → «CSV UTF-8 (delimitado por comas)» y sube ese .csv.'];
    }
    if (trim($firstLine) === '') { fclose($fh); return ['ok' => false, 'error' => 'El archivo está vacío.']; }
    $delim = productsUploadDelimiter($firstLine);
    rewind($fh);

    $header = fgetcsv($fh, 0, $delim, '"', '');
    // Quita BOM del primer encabezado y arma el mapa nombre → índice.
    $header[0] = preg_replace('/^\xEF\xBB\xBF/', '', (string) $header[0]);
    $map = [];
    foreach ($header as $i => $h) $map[strtolower(trim((string) $h))] = $i;
    if (!isset($map['id'])) { fclose($fh); return ['ok' => false, 'error' => 'Falta la columna "id" en el archivo. Usa el archivo que entrega «Exportar».']; }

    // null = la columna no viene o la celda está vacía → se conserva el valor actual.
    $col = function (array $row, string $key) use ($map): ?string {
        if (!isset($map[$key]) || !isset($row[$map[$key]])) return null;
        $v = trim((string) $row[$map[$key]]);
        return $v === '' ? null : $v;
    };

    $current = [];
    foreach (productBulkList(['limit' => 100000]) as $p) $current[(int) $p['id']] = $p;

    $bulk = []; $skipped = 0;
    while (($row = fgetcsv($fh, 0, $delim, '"', '')) !== false) {
        if ($row === [null] || (count($row) === 1 && trim((string) $row[0]) === '')) continue;
        $id = (int) $col($row, 'id');
        if ($id <= 0 || !isset($current[$id])) { $skipped++; continue; }
        $p = $current[$id];

        $price = $col($row, 'precio') !== null ? productsUploadNumber($col($row, 'precio')) : null;
        $sale  = $p['sale_price'];
        if (isset($map['precio_oferta'])) {
            $raw  = $col($row, 'precio_oferta');
            $sale = $raw === null ? '' : productsUploadNumber($raw);
        }
        $bool = fn(string $k, $cur) => ($v = $col($row, $k)) !== null && ($b = productsUploadBool($v)) !== null ? $b : (int) $cur;
        $stockStat = $col($row, 'estado_stock');
        $status    = $col($row, 'estado');

        $bulk[$id] = [
            'name'              => $col($row, 'nombre') ?? $p['name'],
            'sku'               => $col($row, 'sku') ?? $p['sku'],
            'price'             => $price ?? $p['price'],
            'sale_price'        => $sale === null ? '' : $sale,
            'stock_qty'         => ($q = $col($row, 'stock')) !== null ? (int) productsUploadNumber($q) : $p['stock_qty'],
            'manage_stock'      => $bool('gestiona_stock', $p['manage_stock']),
            'stock_status'      => ($stockStat !== null ? (in_array($stockStat, ['in_stock', 'out_of_stock', 'backorder'], true) ? $stockStat : productsUploadStockStatus($stockStat)) : null) ?? $p['stock_status'],
            'status'            => ($status !== null ? (in_array($status, ['draft', 'published', 'archived'], true) ? $status : productsUploadStatus($status)) : null) ?? $p['status'],
            'featured'          => $bool('destacado', $p['featured']),
            'short_description' => $col($row, 'descripcion_corta') ?? $p['short_description'],
        ];
    }
    fclose($fh);

    if (!$bulk) {
        return ['ok' => false, 'error' => 'No se encontró ningún producto del archivo. Revisa que la columna "id" tenga los números que entrega «Exportar».'];
    }
    $updated = productBulkUpdate($bulk);
    $skipped += count($bulk) - $updated;
    return ['ok' => true, 'updated' => $updated, 'skipped' => $skipped];
}
