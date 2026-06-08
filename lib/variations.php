<?php
/**
 * Variaciones de producto (estilo WooCommerce/Shopify).
 *
 * Modelo: un producto "variable" define opciones (atributos, ej. Color/Talle)
 * con valores; cada combinación de valores es una VARIACIÓN con su propio
 * precio, oferta, stock, SKU e imagen.
 *
 * Tablas: attributes, attribute_values, product_attributes,
 *         product_variations, variation_attribute_values.
 */

/* ============ Atributos y valores (globales, reutilizables) ============ */

function attributeEnsure(string $name): int {
    $name = trim($name);
    if ($name === '') return 0;
    $slug = slugify($name) ?: substr(md5($name), 0, 8);
    $db = getDB();
    $st = $db->prepare('SELECT id FROM attributes WHERE slug = ?');
    $st->execute([$slug]);
    $id = $st->fetchColumn();
    if ($id) return (int) $id;
    $db->prepare('INSERT INTO attributes (name, slug) VALUES (?, ?)')
       ->execute([mb_substr($name, 0, 120), mb_substr($slug, 0, 140)]);
    return (int) $db->lastInsertId();
}

function attributeValueEnsure(int $attrId, string $value): int {
    $value = trim($value);
    if ($attrId <= 0 || $value === '') return 0;
    $slug = slugify($value) ?: substr(md5($value), 0, 8);
    $db = getDB();
    $st = $db->prepare('SELECT id FROM attribute_values WHERE attribute_id = ? AND slug = ?');
    $st->execute([$attrId, $slug]);
    $id = $st->fetchColumn();
    if ($id) return (int) $id;
    $db->prepare('INSERT INTO attribute_values (attribute_id, value, slug) VALUES (?, ?, ?)')
       ->execute([$attrId, mb_substr($value, 0, 150), mb_substr($slug, 0, 170)]);
    return (int) $db->lastInsertId();
}

/* ============ Combinaciones ============ */

/** Producto cartesiano de [attrId => [valueId,...]] → lista de [attrId=>valueId]. */
function variationsCartesian(array $lists): array {
    $result = [[]];
    foreach ($lists as $attrId => $vals) {
        if (!$vals) continue;
        $next = [];
        foreach ($result as $combo) {
            foreach ($vals as $v) {
                $c = $combo; $c[$attrId] = (int) $v; $next[] = $c;
            }
        }
        $result = $next;
    }
    return ($result === [[]]) ? [] : $result;
}

/** Firma estable de una combinación (para comparar/deduplicar). */
function variationSig(array $combo): string {
    ksort($combo);
    $p = [];
    foreach ($combo as $a => $v) $p[] = "$a:$v";
    return implode('|', $p);
}

/* ============ Aplicar opciones + regenerar variaciones ============ */

/**
 * Persiste las opciones de un producto variable.
 * @param array $options [ ['name'=>'Color','values'=>['Rojo','Azul']|'Rojo, Azul'], ... ]
 * @return array map attribute_id => [value_id,...]
 */
function productApplyOptions(int $productId, array $options): array {
    $db = getDB();
    $map = [];
    $attrIds = [];
    $sort = 0;
    foreach ($options as $opt) {
        $name = trim((string) ($opt['name'] ?? ''));
        $raw  = $opt['values'] ?? [];
        if (is_string($raw)) $raw = preg_split('/[,\r\n]+/', $raw) ?: [];
        $values = array_values(array_unique(array_filter(array_map('trim', (array) $raw))));
        if ($name === '' || !$values) continue;

        $attrId = attributeEnsure($name);
        if ($attrId <= 0) continue;
        $attrIds[] = $attrId;
        $valIds = [];
        foreach ($values as $v) {
            $vid = attributeValueEnsure($attrId, $v);
            if ($vid) $valIds[] = $vid;
        }
        $map[$attrId] = $valIds;
        $db->prepare(
            'INSERT INTO product_attributes (product_id, attribute_id, is_variation, sort_order)
             VALUES (?, ?, 1, ?) ON DUPLICATE KEY UPDATE sort_order = VALUES(sort_order), is_variation = 1'
        )->execute([$productId, $attrId, $sort++]);
    }
    // Quitar atributos del producto que ya no están en el set enviado.
    if ($attrIds) {
        $place  = implode(',', array_fill(0, count($attrIds), '?'));
        $params = array_merge([$productId], $attrIds);
        $db->prepare("DELETE FROM product_attributes WHERE product_id = ? AND attribute_id NOT IN ($place)")->execute($params);
    } else {
        $db->prepare('DELETE FROM product_attributes WHERE product_id = ?')->execute([$productId]);
    }
    return $map;
}

/**
 * Regenera las variaciones para que coincidan con las combinaciones válidas:
 * conserva las existentes (con su precio/stock), crea las faltantes y elimina
 * las que ya no aplican.
 */
function productRegenerateVariations(int $productId, array $map): void {
    $db = getDB();
    $base = (float) ($db->query('SELECT price FROM products WHERE id = ' . (int) $productId)->fetchColumn() ?: 0);

    $combos = variationsCartesian($map);
    $validSigs = [];
    foreach ($combos as $c) $validSigs[variationSig($c)] = $c;

    // Variaciones existentes → firma.
    $existing = [];
    $vs = $db->prepare('SELECT id FROM product_variations WHERE product_id = ?');
    $vs->execute([$productId]);
    foreach ($vs->fetchAll(PDO::FETCH_COLUMN) as $vid) {
        $vv = $db->prepare('SELECT attribute_id, attribute_value_id FROM variation_attribute_values WHERE variation_id = ?');
        $vv->execute([$vid]);
        $combo = [];
        foreach ($vv->fetchAll() as $r) $combo[(int) $r['attribute_id']] = (int) $r['attribute_value_id'];
        $sig = variationSig($combo);
        if (isset($validSigs[$sig]) && !isset($existing[$sig])) {
            $existing[$sig] = (int) $vid;
        } else {
            $db->prepare('DELETE FROM product_variations WHERE id = ?')->execute([$vid]);
        }
    }

    // Crear las que faltan.
    $sort = 0;
    foreach ($validSigs as $sig => $combo) {
        if (isset($existing[$sig])) continue;
        $db->prepare('INSERT INTO product_variations (product_id, price, stock_qty, stock_status, is_active, sort_order) VALUES (?, ?, 0, ?, 1, ?)')
           ->execute([$productId, $base, 'in_stock', $sort++]);
        $vid = (int) $db->lastInsertId();
        $ins = $db->prepare('INSERT INTO variation_attribute_values (variation_id, attribute_id, attribute_value_id) VALUES (?, ?, ?)');
        foreach ($combo as $aid => $valId) $ins->execute([$vid, $aid, $valId]);
    }

    productRecalcPriceRange($productId);
}

/** Recalcula min_price/max_price (y price=min) de un producto variable. */
function productRecalcPriceRange(int $productId): void {
    $db = getDB();
    $type = $db->query('SELECT type FROM products WHERE id = ' . (int) $productId)->fetchColumn();
    if ($type !== 'variable') return;
    $st = $db->prepare(
        'SELECT MIN(COALESCE(NULLIF(sale_price,0), price)) AS lo, MAX(price) AS hi
         FROM product_variations WHERE product_id = ? AND is_active = 1'
    );
    $st->execute([$productId]);
    $r  = $st->fetch();
    $lo = ($r && $r['lo'] !== null) ? (float) $r['lo'] : 0;
    $hi = ($r && $r['hi'] !== null) ? (float) $r['hi'] : 0;
    $db->prepare('UPDATE products SET min_price = ?, max_price = ?, price = ? WHERE id = ?')
       ->execute([$lo, $hi, $lo, $productId]);
}

/* ============ Lectura ============ */

/** Opciones del producto para el editor: [ ['attribute_id','name','values'=>[str,...]], ... ]. */
function productOptions(int $productId): array {
    $db = getDB();
    $pa = $db->prepare(
        'SELECT pa.attribute_id, a.name FROM product_attributes pa
         JOIN attributes a ON a.id = pa.attribute_id
         WHERE pa.product_id = ? AND pa.is_variation = 1 ORDER BY pa.sort_order, a.name'
    );
    $pa->execute([$productId]);
    $opts = [];
    foreach ($pa->fetchAll() as $row) {
        $aid = (int) $row['attribute_id'];
        $vv = $db->prepare(
            'SELECT DISTINCT av.value, av.id FROM variation_attribute_values vav
             JOIN product_variations pv ON pv.id = vav.variation_id
             JOIN attribute_values av ON av.id = vav.attribute_value_id
             WHERE pv.product_id = ? AND vav.attribute_id = ? ORDER BY av.id'
        );
        $vv->execute([$productId, $aid]);
        $opts[] = ['attribute_id' => $aid, 'name' => $row['name'], 'values' => $vv->fetchAll(PDO::FETCH_COLUMN)];
    }
    return $opts;
}

/** Variaciones del producto con etiqueta y precio efectivo. */
function productVariations(int $productId): array {
    $db = getDB();
    $vs = $db->prepare(
        'SELECT pv.*, m.file_path AS image_path, m.thumb_path AS image_thumb
         FROM product_variations pv LEFT JOIN media_library m ON m.id = pv.image_id
         WHERE pv.product_id = ? ORDER BY pv.sort_order, pv.id'
    );
    $vs->execute([$productId]);
    $vars = $vs->fetchAll();
    if (!$vars) return [];

    $ids = array_column($vars, 'id');
    $place = implode(',', array_fill(0, count($ids), '?'));
    $vv = $db->prepare(
        "SELECT vav.variation_id, vav.attribute_id, a.name AS attr_name, av.id AS value_id, av.value AS value_label
         FROM variation_attribute_values vav
         JOIN attributes a ON a.id = vav.attribute_id
         JOIN attribute_values av ON av.id = vav.attribute_value_id
         WHERE vav.variation_id IN ($place) ORDER BY a.id"
    );
    $vv->execute($ids);
    $byVar = [];
    foreach ($vv->fetchAll() as $r) $byVar[(int) $r['variation_id']][] = $r;

    foreach ($vars as &$v) {
        $v['values']    = $byVar[(int) $v['id']] ?? [];
        $v['label']     = implode(' / ', array_map(fn($x) => $x['value_label'], $v['values']));
        $v['effective'] = ($v['sale_price'] !== null && (float) $v['sale_price'] > 0) ? (float) $v['sale_price'] : (float) $v['price'];
    }
    unset($v);
    return $vars;
}

/** Matriz para el front: atributos con sus valores + variaciones activas. */
function productVariationMatrix(int $productId): array {
    $db = getDB();
    $opts = productOptions($productId);
    $attrs = [];
    foreach ($opts as $o) {
        $aid = (int) $o['attribute_id'];
        $vv = $db->prepare(
            'SELECT DISTINCT av.id, av.value FROM variation_attribute_values vav
             JOIN product_variations pv ON pv.id = vav.variation_id
             JOIN attribute_values av ON av.id = vav.attribute_value_id
             WHERE pv.product_id = ? AND vav.attribute_id = ? ORDER BY av.id'
        );
        $vv->execute([$productId, $aid]);
        $attrs[] = ['id' => $aid, 'name' => $o['name'], 'values' => $vv->fetchAll()];
    }

    $variations = [];
    foreach (productVariations($productId) as $v) {
        if (!(int) $v['is_active']) continue;
        $vmap = [];
        foreach ($v['values'] as $x) $vmap[(int) $x['attribute_id']] = (int) $x['value_id'];
        $stock = (int) $v['stock_qty'];
        $variations[] = [
            'id'        => (int) $v['id'],
            'values'    => $vmap,
            'price'     => (float) $v['price'],
            'effective' => (float) $v['effective'],
            'available' => $v['stock_status'] === 'backorder' ? true : ($stock > 0),
            'stock'     => $stock,
            'image'     => (string) ($v['image_path'] ?? ''),
        ];
    }
    return ['attributes' => $attrs, 'variations' => $variations];
}

/* ============ Edición masiva de variaciones ============ */

function variationUpdateBulk(int $productId, array $rows): void {
    $db = getDB();
    $st = $db->prepare(
        'UPDATE product_variations SET price = ?, sale_price = ?, stock_qty = ?, stock_status = ?, sku = ?,
         gtin = ?, mpn = ?, image_id = ?, is_active = ? WHERE id = ? AND product_id = ?'
    );
    foreach ($rows as $vid => $r) {
        $vid = (int) $vid;
        if ($vid <= 0 || !is_array($r)) continue;
        $price   = max(0, (float) ($r['price'] ?? 0));
        $sale    = ($r['sale_price'] ?? '') !== '' ? max(0, (float) $r['sale_price']) : null;
        $stock   = (int) ($r['stock_qty'] ?? 0);
        $status  = in_array($r['stock_status'] ?? '', ['in_stock', 'out_of_stock', 'backorder'], true) ? $r['stock_status'] : 'in_stock';
        $sku     = trim((string) ($r['sku'] ?? '')) ?: null;
        $gtin    = trim((string) ($r['gtin'] ?? '')) ?: null;
        $mpn     = trim((string) ($r['mpn'] ?? '')) ?: null;
        $imageId = (int) ($r['image_id'] ?? 0) ?: null;
        $active  = !empty($r['is_active']) ? 1 : 0;
        $st->execute([$price, $sale, $stock, $status, $sku, $gtin, $mpn, $imageId, $active, $vid, $productId]);
    }
    productRecalcPriceRange($productId);
}

function variationCount(int $productId): int {
    $st = getDB()->prepare('SELECT COUNT(*) FROM product_variations WHERE product_id = ?');
    $st->execute([$productId]);
    return (int) $st->fetchColumn();
}
