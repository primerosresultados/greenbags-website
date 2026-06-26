<?php
/**
 * Genera una migración-semilla idempotente con los productos importados
 * (sku LIKE 'EB-%' / 'TG-%'), su media y los joins (categorías + imágenes).
 *
 * Usa CLAVES NATURALES (no IDs autoincrementales):
 *   - products:           ON DUPLICATE KEY UPDATE por `sku` (UNIQUE)
 *   - media_library:      INSERT ... WHERE NOT EXISTS por `file_path`
 *   - product_categories: INSERT IGNORE resolviendo ids por sku + slug
 *   - product_images:     INSERT ... WHERE NOT EXISTS por sku + file_path
 *
 * Así producción queda idéntica a local al aplicar la migración (los archivos
 * WebP en uploads/library/importados/ viajan commiteados con el repo).
 *
 * Uso: php tools/dump_catalog_seed.php > migrations/041_greenbags_catalog_seed.sql
 */
require __DIR__ . '/_cli.php';

function sqlStr(?string $s): string {
    if ($s === null) return 'NULL';
    $s = str_replace('\\', '\\\\', $s);
    $s = str_replace("'", "''", $s);
    return "'" . $s . "'";
}
function sqlNum($n): string { return $n === null ? 'NULL' : (string) (0 + $n); }

$db = getDB();
$prods = $db->query(
    "SELECT * FROM products WHERE sku LIKE 'EB-%' OR sku LIKE 'TG-%' ORDER BY sku"
)->fetchAll();

$out = '';
$out .= "-- ============================================================\n";
$out .= "-- CLIENTE: GreenBags - SEMILLA de catálogo importado.\n";
$out .= "-- Generado por tools/dump_catalog_seed.php desde esquinablanca.cl + tugou.cl.\n";
$out .= "-- Productos: " . count($prods) . ". Idempotente (claves naturales: sku/file_path/slug).\n";
$out .= "-- Requiere que los WebP en uploads/library/importados/ estén commiteados.\n";
$out .= "-- Al forkear el starter, borrar este archivo (catálogo específico del cliente).\n";
$out .= "-- ============================================================\n\n";

$cols = ['type','sku','gtin','mpn','name','slug','short_description','description','brand',
    'item_condition','google_category','status','price','sale_price','min_price','max_price',
    'manage_stock','min_order_qty','stock_qty','stock_status','weight','featured',
    'meta_title','meta_description'];
$strCols = ['type','sku','gtin','mpn','name','slug','short_description','description','brand',
    'item_condition','google_category','status','stock_status','meta_title','meta_description'];

foreach ($prods as $p) {
    $vals = [];
    foreach ($cols as $c) {
        $v = $p[$c] ?? null;
        $vals[] = in_array($c, $strCols, true) ? sqlStr($v === null ? null : (string) $v) : sqlNum($v);
    }
    $colList = implode(', ', $cols);
    $valList = implode(', ', $vals);
    // ON DUPLICATE: refresca todo menos sku (la clave).
    $upd = [];
    foreach ($cols as $c) {
        if ($c === 'sku') continue;
        $upd[] = "$c=VALUES($c)";
    }
    $out .= "INSERT INTO products ($colList) VALUES ($valList)\n  ON DUPLICATE KEY UPDATE " . implode(', ', $upd) . ";\n";
}
$out .= "\n";

// --- media_library (solo la usada por los productos importados) ---
$media = $db->query(
    "SELECT DISTINCT m.* FROM media_library m
     JOIN product_images pi ON pi.media_id = m.id
     JOIN products p ON p.id = pi.product_id
     WHERE p.sku LIKE 'EB-%' OR p.sku LIKE 'TG-%' ORDER BY m.id"
)->fetchAll();

foreach ($media as $m) {
    $out .= "INSERT INTO media_library (file_path, thumb_path, path_md, path_sm, seo_name, mime, width, height, bytes, folder_id, sort_order)\n"
          . "  SELECT " . sqlStr($m['file_path']) . ", " . sqlStr($m['thumb_path']) . ", " . sqlStr($m['path_md']) . ", "
          . sqlStr($m['path_sm']) . ", " . sqlStr($m['seo_name']) . ", " . sqlStr($m['mime']) . ", "
          . sqlNum($m['width']) . ", " . sqlNum($m['height']) . ", " . sqlNum($m['bytes']) . ", NULL, " . sqlNum($m['sort_order']) . "\n"
          . "  FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM media_library WHERE file_path = " . sqlStr($m['file_path']) . ");\n";
}
$out .= "\n";

// --- product_categories ---
$pcs = $db->query(
    "SELECT p.sku, c.slug FROM product_categories pc
     JOIN products p ON p.id = pc.product_id
     JOIN categories c ON c.id = pc.category_id
     WHERE p.sku LIKE 'EB-%' OR p.sku LIKE 'TG-%' ORDER BY p.sku, c.slug"
)->fetchAll();
foreach ($pcs as $pc) {
    $out .= "INSERT IGNORE INTO product_categories (product_id, category_id)\n"
          . "  SELECT p.id, c.id FROM products p, categories c WHERE p.sku = " . sqlStr($pc['sku'])
          . " AND c.slug = " . sqlStr($pc['slug']) . ";\n";
}
$out .= "\n";

// --- product_images ---
$pis = $db->query(
    "SELECT p.sku, m.file_path, pi.sort_order, pi.is_primary FROM product_images pi
     JOIN products p ON p.id = pi.product_id
     JOIN media_library m ON m.id = pi.media_id
     WHERE p.sku LIKE 'EB-%' OR p.sku LIKE 'TG-%' ORDER BY p.sku, pi.sort_order"
)->fetchAll();
foreach ($pis as $pi) {
    $out .= "INSERT INTO product_images (product_id, media_id, sort_order, is_primary)\n"
          . "  SELECT p.id, m.id, " . sqlNum($pi['sort_order']) . ", " . sqlNum($pi['is_primary'])
          . " FROM products p, media_library m\n"
          . "  WHERE p.sku = " . sqlStr($pi['sku']) . " AND m.file_path = " . sqlStr($pi['file_path']) . "\n"
          . "  AND NOT EXISTS (SELECT 1 FROM product_images pi2 JOIN products p2 ON p2.id=pi2.product_id JOIN media_library m2 ON m2.id=pi2.media_id\n"
          . "                  WHERE p2.sku = " . sqlStr($pi['sku']) . " AND m2.file_path = " . sqlStr($pi['file_path']) . ");\n";
}

fwrite(STDOUT, $out);
fwrite(STDERR, "Seed generado: " . count($prods) . " productos, " . count($media) . " media, "
    . count($pcs) . " cat-links, " . count($pis) . " imágenes.\n");
