<?php
/**
 * Acciones del admin para la tienda (catálogo).
 * Se incluye desde admin/index.php dentro del bloque autenticado.
 * Cada acción valida CSRF y redirige (patrón POST-redirect-GET del proyecto).
 */

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
    }
    return false;
}

/**
 * Exporta el catálogo a CSV (compatible con Excel: BOM UTF-8 + separador coma).
 * Respeta los filtros de búsqueda/estado. Imprime y termina la ejecución.
 */
function productsExportCsv(array $o): void {
    $rows = productBulkList([
        'search' => trim((string) ($o['search'] ?? '')),
        'status' => (string) ($o['status'] ?? ''),
    ]);
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="productos-' . date('Ymd-His') . '.csv"');
    $out = fopen('php://output', 'w');
    fwrite($out, "\xEF\xBB\xBF"); // BOM UTF-8 para Excel
    fputcsv($out, ['id', 'nombre', 'sku', 'precio', 'precio_oferta', 'stock',
                   'gestiona_stock', 'estado_stock', 'estado', 'destacado', 'descripcion_corta']);
    foreach ($rows as $r) {
        fputcsv($out, [
            $r['id'], $r['name'], $r['sku'], $r['price'], $r['sale_price'],
            $r['stock_qty'], $r['manage_stock'], $r['stock_status'],
            $r['status'], $r['featured'], $r['short_description'],
        ]);
    }
    fclose($out);
    exit;
}

/**
 * Importa un CSV (el mismo formato del export) y actualiza productos por id.
 * Mapea columnas por nombre de encabezado, así que tolera reordenamientos.
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

    $header = fgetcsv($fh);
    if (!$header) { fclose($fh); return ['ok' => false, 'error' => 'El archivo está vacío.']; }
    // Quita BOM del primer encabezado y arma el mapa nombre → índice.
    $header[0] = preg_replace('/^\xEF\xBB\xBF/', '', (string) $header[0]);
    $map = [];
    foreach ($header as $i => $h) $map[strtolower(trim((string) $h))] = $i;
    if (!isset($map['id'])) { fclose($fh); return ['ok' => false, 'error' => 'Falta la columna "id" en el archivo.']; }

    $col = function (array $row, string $key) use ($map) {
        return isset($map[$key]) && isset($row[$map[$key]]) ? $row[$map[$key]] : null;
    };

    $bulk = []; $skipped = 0;
    while (($row = fgetcsv($fh)) !== false) {
        if ($row === [null] || (count($row) === 1 && trim((string) $row[0]) === '')) continue;
        $id = (int) $col($row, 'id');
        if ($id <= 0) { $skipped++; continue; }
        $bulk[$id] = [
            'name'              => $col($row, 'nombre'),
            'sku'               => $col($row, 'sku'),
            'price'             => $col($row, 'precio'),
            'sale_price'        => $col($row, 'precio_oferta'),
            'stock_qty'         => $col($row, 'stock'),
            'manage_stock'      => $col($row, 'gestiona_stock'),
            'stock_status'      => $col($row, 'estado_stock'),
            'status'            => $col($row, 'estado'),
            'featured'          => $col($row, 'destacado'),
            'short_description' => $col($row, 'descripcion_corta'),
        ];
    }
    fclose($fh);

    $updated = productBulkUpdate($bulk);
    $skipped += count($bulk) - $updated;
    return ['ok' => true, 'updated' => $updated, 'skipped' => $skipped];
}
