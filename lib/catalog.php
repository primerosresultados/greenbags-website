<?php
/**
 * Capa de dominio del catálogo: categorías y productos.
 * Estilo del proyecto: funciones globales sobre PDO (getDB()), sin clases.
 * Las imágenes se referencian por media_id contra la media_library existente
 * (que ya entrega WebP + srcset vía renderResponsiveImg()).
 */

/* ===================== Helpers ===================== */

/**
 * Genera un slug único para una tabla dada (products|categories), agregando
 * sufijo -2, -3… si ya existe. Excluye el propio id en updates.
 */
function catalogUniqueSlug(string $table, string $base, int $excludeId = 0): string {
    $table = in_array($table, ['products', 'categories'], true) ? $table : 'products';
    $slug  = slugify($base);
    if ($slug === '') $slug = substr(md5($base . microtime()), 0, 8);
    $candidate = $slug;
    $i = 2;
    while (true) {
        $stmt = getDB()->prepare("SELECT COUNT(*) FROM {$table} WHERE slug = ? AND id <> ?");
        $stmt->execute([$candidate, $excludeId]);
        if ((int) $stmt->fetchColumn() === 0) return $candidate;
        $candidate = $slug . '-' . $i++;
    }
}

/** Precio vigente: sale_price si está dentro de la ventana, si no price. */
function productEffectivePrice(array $p): float {
    $price = (float) ($p['price'] ?? 0);
    $sale  = $p['sale_price'] ?? null;
    if ($sale !== null && $sale !== '' && (float) $sale > 0) {
        $now   = time();
        $start = !empty($p['sale_starts_at']) ? strtotime((string) $p['sale_starts_at']) : null;
        $end   = !empty($p['sale_ends_at'])   ? strtotime((string) $p['sale_ends_at'])   : null;
        if (($start === null || $now >= $start) && ($end === null || $now <= $end)) {
            return (float) $sale;
        }
    }
    return $price;
}

function productIsOnSale(array $p): bool {
    return productEffectivePrice($p) < (float) ($p['price'] ?? 0);
}

/** availability schema.org a partir del stock. */
function productAvailability(array $p): string {
    $status = (string) ($p['stock_status'] ?? 'in_stock');
    if ((int) ($p['manage_stock'] ?? 1) === 1 && (int) ($p['stock_qty'] ?? 0) <= 0 && $status !== 'backorder') {
        return 'https://schema.org/OutOfStock';
    }
    return $status === 'out_of_stock'
        ? 'https://schema.org/OutOfStock'
        : 'https://schema.org/InStock';
}

/* ===================== Categorías ===================== */

function categoryList(bool $activeOnly = false): array {
    $sql = 'SELECT c.*, (SELECT COUNT(*) FROM product_categories pc WHERE pc.category_id = c.id) AS products_count
            FROM categories c';
    if ($activeOnly) $sql .= ' WHERE c.is_active = 1';
    $sql .= ' ORDER BY c.sort_order ASC, c.name ASC';
    return getDB()->query($sql)->fetchAll();
}

function categoryGet(int $id): ?array {
    if ($id <= 0) return null;
    $stmt = getDB()->prepare('SELECT * FROM categories WHERE id = ?');
    $stmt->execute([$id]);
    return $stmt->fetch() ?: null;
}

function categoryGetBySlug(string $slug): ?array {
    $stmt = getDB()->prepare('SELECT * FROM categories WHERE slug = ? AND is_active = 1');
    $stmt->execute([$slug]);
    return $stmt->fetch() ?: null;
}

/** Opciones [id => label] para selects (con sangría por jerarquía). */
function categoryOptions(int $excludeId = 0): array {
    $rows = categoryList(false);
    $byParent = [];
    foreach ($rows as $r) $byParent[(int) ($r['parent_id'] ?? 0)][] = $r;
    $out = [];
    $walk = function ($pid, $depth) use (&$walk, $byParent, &$out, $excludeId) {
        foreach ($byParent[$pid] ?? [] as $r) {
            if ((int) $r['id'] === $excludeId) continue;
            $out[(int) $r['id']] = str_repeat('— ', $depth) . $r['name'];
            $walk((int) $r['id'], $depth + 1);
        }
    };
    $walk(0, 0);
    return $out;
}

/** @return array{ok:bool,id?:int,error?:string} */
function categorySave(array $d): array {
    $id     = (int) ($d['id'] ?? 0);
    $name   = trim((string) ($d['name'] ?? ''));
    if ($name === '') return ['ok' => false, 'error' => 'El nombre es obligatorio.'];

    $slug   = catalogUniqueSlug('categories', $d['slug'] ?? $name, $id);
    $parent = (int) ($d['parent_id'] ?? 0) ?: null;
    if ($parent === $id && $id > 0) $parent = null; // no puede ser su propio padre
    $params = [
        'parent_id'        => $parent,
        'name'             => mb_substr($name, 0, 180),
        'slug'             => $slug,
        'description'      => (string) ($d['description'] ?? ''),
        'image_id'         => (int) ($d['image_id'] ?? 0) ?: null,
        'meta_title'       => mb_substr(trim((string) ($d['meta_title'] ?? '')), 0, 255) ?: null,
        'meta_description' => mb_substr(trim((string) ($d['meta_description'] ?? '')), 0, 300) ?: null,
        'sort_order'       => (int) ($d['sort_order'] ?? 0),
        'is_active'        => !empty($d['is_active']) ? 1 : 0,
    ];
    try {
        if ($id > 0) {
            $stmt = getDB()->prepare(
                'UPDATE categories SET parent_id=:parent_id, name=:name, slug=:slug, description=:description,
                 image_id=:image_id, meta_title=:meta_title, meta_description=:meta_description,
                 sort_order=:sort_order, is_active=:is_active WHERE id=:id'
            );
            $params['id'] = $id;
            $stmt->execute($params);
            return ['ok' => true, 'id' => $id];
        }
        $stmt = getDB()->prepare(
            'INSERT INTO categories (parent_id, name, slug, description, image_id, meta_title, meta_description, sort_order, is_active)
             VALUES (:parent_id, :name, :slug, :description, :image_id, :meta_title, :meta_description, :sort_order, :is_active)'
        );
        $stmt->execute($params);
        return ['ok' => true, 'id' => (int) getDB()->lastInsertId()];
    } catch (PDOException $e) {
        return ['ok' => false, 'error' => 'No se pudo guardar la categoría.'];
    }
}

function categoryDelete(int $id): bool {
    if ($id <= 0) return false;
    return getDB()->prepare('DELETE FROM categories WHERE id = ?')->execute([$id]);
}

/* ===================== Productos ===================== */

/** Listado para el admin con filtros + paginación. @return array{rows:array,total:int} */
function productAdminList(array $o): array {
    $where = []; $params = [];
    $search = trim((string) ($o['search'] ?? ''));
    if ($search !== '') {
        $where[] = '(p.name LIKE ? OR p.sku LIKE ?)';
        $like = '%' . $search . '%';
        array_push($params, $like, $like);
    }
    if (!empty($o['status']) && in_array($o['status'], ['draft', 'published', 'archived'], true)) {
        $where[] = 'p.status = ?';
        $params[] = $o['status'];
    }
    $whereSql = $where ? 'WHERE ' . implode(' AND ', $where) : '';

    $cnt = getDB()->prepare("SELECT COUNT(*) FROM products p $whereSql");
    $cnt->execute($params);
    $total = (int) $cnt->fetchColumn();

    $perPage = max(1, (int) ($o['perPage'] ?? 25));
    $page    = max(1, (int) ($o['page'] ?? 1));
    $offset  = ($page - 1) * $perPage;

    $sql = "SELECT p.id, p.name, p.slug, p.sku, p.type, p.status, p.price, p.sale_price,
                   p.sale_starts_at, p.sale_ends_at, p.stock_qty, p.stock_status, p.manage_stock,
                   (SELECT m.thumb_path FROM product_images pi JOIN media_library m ON m.id = pi.media_id
                    WHERE pi.product_id = p.id ORDER BY pi.is_primary DESC, pi.sort_order LIMIT 1) AS thumb
            FROM products p $whereSql ORDER BY p.created_at DESC LIMIT ? OFFSET ?";
    $stmt = getDB()->prepare($sql);
    $i = 1;
    foreach ($params as $p) $stmt->bindValue($i++, $p, PDO::PARAM_STR);
    $stmt->bindValue($i++, $perPage, PDO::PARAM_INT);
    $stmt->bindValue($i++, $offset,  PDO::PARAM_INT);
    $stmt->execute();
    return ['rows' => $stmt->fetchAll(), 'total' => $total];
}

function productGet(int $id): ?array {
    if ($id <= 0) return null;
    $stmt = getDB()->prepare('SELECT * FROM products WHERE id = ?');
    $stmt->execute([$id]);
    return $stmt->fetch() ?: null;
}

function productGetBySlug(string $slug, bool $publishedOnly = true): ?array {
    $sql = 'SELECT * FROM products WHERE slug = ?';
    if ($publishedOnly) $sql .= " AND status = 'published'";
    $stmt = getDB()->prepare($sql);
    $stmt->execute([$slug]);
    return $stmt->fetch() ?: null;
}

/** Imágenes del producto, listas para renderResponsiveImg(). */
function productImages(int $productId): array {
    $stmt = getDB()->prepare(
        'SELECT m.id, m.file_path, m.thumb_path, m.path_md, m.path_sm, m.alt, m.title, m.width, m.height,
                pi.is_primary, pi.sort_order
         FROM product_images pi JOIN media_library m ON m.id = pi.media_id
         WHERE pi.product_id = ? ORDER BY pi.is_primary DESC, pi.sort_order ASC, pi.id ASC'
    );
    $stmt->execute([$productId]);
    return $stmt->fetchAll();
}

function productPrimaryImage(int $productId): ?array {
    $imgs = productImages($productId);
    return $imgs[0] ?? null;
}

function productSetImages(int $productId, array $mediaIds): void {
    $db = getDB();
    $db->prepare('DELETE FROM product_images WHERE product_id = ?')->execute([$productId]);
    $ids = array_values(array_unique(array_filter(array_map('intval', $mediaIds))));
    if (!$ids) return;
    $stmt = $db->prepare('INSERT INTO product_images (product_id, media_id, sort_order, is_primary) VALUES (?, ?, ?, ?)');
    foreach ($ids as $i => $mid) {
        $stmt->execute([$productId, $mid, $i, $i === 0 ? 1 : 0]);
    }
}

function productCategoryIds(int $productId): array {
    $stmt = getDB()->prepare('SELECT category_id FROM product_categories WHERE product_id = ?');
    $stmt->execute([$productId]);
    return array_map('intval', $stmt->fetchAll(PDO::FETCH_COLUMN));
}

function productSetCategories(int $productId, array $catIds): void {
    $db = getDB();
    $db->prepare('DELETE FROM product_categories WHERE product_id = ?')->execute([$productId]);
    $ids = array_values(array_unique(array_filter(array_map('intval', $catIds))));
    if (!$ids) return;
    $stmt = $db->prepare('INSERT INTO product_categories (product_id, category_id) VALUES (?, ?)');
    foreach ($ids as $cid) $stmt->execute([$productId, $cid]);
}

/**
 * Guarda un producto (tipo simple) con sus categorías e imágenes.
 * @return array{ok:bool,id?:int,error?:string}
 */
function productSave(array $d): array {
    $id   = (int) ($d['id'] ?? 0);
    $name = trim((string) ($d['name'] ?? ''));
    if ($name === '') return ['ok' => false, 'error' => 'El nombre es obligatorio.'];

    $price     = max(0, (float) ($d['price'] ?? 0));
    $salePrice = ($d['sale_price'] ?? '') !== '' ? max(0, (float) $d['sale_price']) : null;
    $slug      = catalogUniqueSlug('products', $d['slug'] ?? $name, $id);
    $manage    = !empty($d['manage_stock']) ? 1 : 0;
    $stockQty  = (int) ($d['stock_qty'] ?? 0);
    $stockStat = in_array($d['stock_status'] ?? '', ['in_stock', 'out_of_stock', 'backorder'], true)
        ? $d['stock_status'] : 'in_stock';

    $type = in_array($d['type'] ?? 'simple', ['simple', 'variable'], true) ? $d['type'] : 'simple';
    $params = [
        'type'             => $type,
        'sku'              => trim((string) ($d['sku'] ?? '')) ?: null,
        'gtin'             => mb_substr(trim((string) ($d['gtin'] ?? '')), 0, 50) ?: null,
        'mpn'              => mb_substr(trim((string) ($d['mpn'] ?? '')), 0, 80) ?: null,
        'name'             => mb_substr($name, 0, 255),
        'slug'             => $slug,
        'short_description'=> mb_substr(trim((string) ($d['short_description'] ?? '')), 0, 500) ?: null,
        'description'      => (string) ($d['description'] ?? ''),
        'brand'            => mb_substr(trim((string) ($d['brand'] ?? '')), 0, 120) ?: null,
        'item_condition'   => in_array($d['item_condition'] ?? 'new', ['new', 'refurbished', 'used'], true) ? $d['item_condition'] : 'new',
        'google_category'  => mb_substr(trim((string) ($d['google_category'] ?? '')), 0, 255) ?: null,
        'status'           => in_array($d['status'] ?? '', ['draft', 'published', 'archived'], true) ? $d['status'] : 'draft',
        'price'            => $price,
        'sale_price'       => $salePrice,
        'sale_starts_at'   => !empty($d['sale_starts_at']) ? $d['sale_starts_at'] : null,
        'sale_ends_at'     => !empty($d['sale_ends_at'])   ? $d['sale_ends_at']   : null,
        'min_price'        => $salePrice !== null ? min($price, $salePrice) : $price,
        'max_price'        => $price,
        'manage_stock'     => $manage,
        'min_order_qty'    => max(1, (int) ($d['min_order_qty'] ?? 1)),
        'stock_qty'        => $stockQty,
        'stock_status'     => $stockStat,
        'weight'           => ($d['weight'] ?? '') !== '' ? (float) $d['weight'] : null,
        'featured'         => !empty($d['featured']) ? 1 : 0,
        'meta_title'       => mb_substr(trim((string) ($d['meta_title'] ?? '')), 0, 255) ?: null,
        'meta_description' => mb_substr(trim((string) ($d['meta_description'] ?? '')), 0, 300) ?: null,
        'og_image_id'      => (int) ($d['og_image_id'] ?? 0) ?: null,
    ];

    try {
        if ($id > 0) {
            $params['id'] = $id;
            $stmt = getDB()->prepare(
                'UPDATE products SET type=:type, sku=:sku, gtin=:gtin, mpn=:mpn, name=:name, slug=:slug, short_description=:short_description,
                 description=:description, brand=:brand, item_condition=:item_condition, google_category=:google_category,
                 status=:status, price=:price, sale_price=:sale_price,
                 sale_starts_at=:sale_starts_at, sale_ends_at=:sale_ends_at, min_price=:min_price, max_price=:max_price,
                 manage_stock=:manage_stock, min_order_qty=:min_order_qty, stock_qty=:stock_qty, stock_status=:stock_status, weight=:weight,
                 featured=:featured, meta_title=:meta_title, meta_description=:meta_description, og_image_id=:og_image_id
                 WHERE id=:id'
            );
            $stmt->execute($params);
        } else {
            $stmt = getDB()->prepare(
                'INSERT INTO products (type, sku, gtin, mpn, name, slug, short_description, description, brand,
                 item_condition, google_category, status, price,
                 sale_price, sale_starts_at, sale_ends_at, min_price, max_price, manage_stock, min_order_qty, stock_qty, stock_status,
                 weight, featured, meta_title, meta_description, og_image_id)
                 VALUES (:type, :sku, :gtin, :mpn, :name, :slug, :short_description, :description, :brand,
                 :item_condition, :google_category, :status, :price,
                 :sale_price, :sale_starts_at, :sale_ends_at, :min_price, :max_price, :manage_stock, :min_order_qty, :stock_qty,
                 :stock_status, :weight, :featured, :meta_title, :meta_description, :og_image_id)'
            );
            $stmt->execute($params);
            $id = (int) getDB()->lastInsertId();
        }

        productSetCategories($id, (array) ($d['categories'] ?? []));
        if (isset($d['image_ids'])) {
            $ids = is_array($d['image_ids']) ? $d['image_ids'] : array_filter(explode(',', (string) $d['image_ids']));
            productSetImages($id, $ids);
        }

        // Mayoreo (precios por cantidad) y videos.
        if (function_exists('productSetTiers'))  productSetTiers($id, (array) ($d['tiers'] ?? []));
        if (function_exists('productSetVideos')) productSetVideos($id, (array) ($d['videos'] ?? []));

        // Variaciones: aplicar opciones y regenerar (o limpiar si es simple).
        if ($type === 'variable' && function_exists('productApplyOptions')) {
            $map = productApplyOptions($id, (array) ($d['options'] ?? []));
            productRegenerateVariations($id, $map);
        } elseif ($type === 'simple') {
            getDB()->prepare('DELETE FROM product_attributes WHERE product_id = ?')->execute([$id]);
            getDB()->prepare('DELETE FROM product_variations WHERE product_id = ?')->execute([$id]);
        }
        return ['ok' => true, 'id' => $id];
    } catch (PDOException $e) {
        return ['ok' => false, 'error' => 'No se pudo guardar el producto (¿SKU duplicado?).'];
    }
}

function productDelete(int $id): bool {
    if ($id <= 0) return false;
    return getDB()->prepare('DELETE FROM products WHERE id = ?')->execute([$id]);
}

/* ===================== Front ===================== */

/** Productos publicados (opcional por categoría) con su imagen principal. */
function productsPublished(array $o = []): array {
    $where = ["p.status = 'published'"]; $params = [];
    $catId = (int) ($o['category_id'] ?? 0);
    $join  = '';
    if ($catId > 0) {
        $join = 'JOIN product_categories pc ON pc.product_id = p.id AND pc.category_id = ?';
        $params[] = $catId;
    }
    $whereSql = 'WHERE ' . implode(' AND ', $where);
    $perPage = max(1, (int) ($o['perPage'] ?? 24));
    $page    = max(1, (int) ($o['page'] ?? 1));
    $offset  = ($page - 1) * $perPage;

    $sql = "SELECT p.*,
                   (SELECT m.file_path FROM product_images pi JOIN media_library m ON m.id = pi.media_id
                    WHERE pi.product_id = p.id ORDER BY pi.is_primary DESC, pi.sort_order LIMIT 1) AS img,
                   (SELECT m.alt FROM product_images pi JOIN media_library m ON m.id = pi.media_id
                    WHERE pi.product_id = p.id ORDER BY pi.is_primary DESC, pi.sort_order LIMIT 1) AS img_alt
            FROM products p $join $whereSql ORDER BY p.featured DESC, p.sort_order ASC, p.created_at DESC
            LIMIT ? OFFSET ?";
    $stmt = getDB()->prepare($sql);
    $i = 1;
    foreach ($params as $p) $stmt->bindValue($i++, $p, PDO::PARAM_INT);
    $stmt->bindValue($i++, $perPage, PDO::PARAM_INT);
    $stmt->bindValue($i++, $offset,  PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll();
}

function productsPublishedCount(int $catId = 0): int {
    if ($catId > 0) {
        $stmt = getDB()->prepare(
            "SELECT COUNT(*) FROM products p JOIN product_categories pc ON pc.product_id = p.id
             WHERE p.status = 'published' AND pc.category_id = ?"
        );
        $stmt->execute([$catId]);
        return (int) $stmt->fetchColumn();
    }
    return (int) getDB()->query("SELECT COUNT(*) FROM products WHERE status = 'published'")->fetchColumn();
}
