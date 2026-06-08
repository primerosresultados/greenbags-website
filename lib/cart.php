<?php
/**
 * Carrito persistente para visitantes (invitados y clientes con cuenta).
 *
 * Diseño:
 *   - Cookie HttpOnly `pse_cart` con un UUID estable (1 año). El UUID es el
 *     `token` de la fila en `carts`; así un mismo navegador conserva el
 *     carrito entre visitas y permite recuperar carritos abandonados.
 *   - `cart_items.unit_price` se resnapshea en cada add/update y se refresca
 *     al listar (cartItems()): si el cliente alcanza un escalón de mayoreo
 *     (`price_tiers`), el precio unitario baja automáticamente.
 *   - Las "tiers" hoy se aplican a nivel producto (variation_id NULL en
 *     price_tiers). Las variaciones usan su propio price/sale_price y
 *     después comparan contra el tier del producto: gana el menor.
 */

/** UUID v4 del carrito; lo genera y persiste en cookie la primera vez. */
function cartToken(): string {
    if (!empty($_COOKIE['pse_cart']) && preg_match(
        '/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i',
        (string) $_COOKIE['pse_cart']
    )) {
        return (string) $_COOKIE['pse_cart'];
    }
    $b = random_bytes(16);
    $b[6] = chr((ord($b[6]) & 0x0f) | 0x40);
    $b[8] = chr((ord($b[8]) & 0x3f) | 0x80);
    $tok = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($b), 4));
    setcookie('pse_cart', $tok, [
        'expires'  => time() + 60 * 60 * 24 * 365,
        'path'     => '/',
        'httponly' => true,
        'samesite' => 'Lax',
        'secure'   => !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off',
    ]);
    $_COOKIE['pse_cart'] = $tok;
    return $tok;
}

/** Carrito activo del visitante. Con $create=true lo crea si no existe. */
function cartCurrent(bool $create = false): ?array {
    $tok = cartToken();
    $st = getDB()->prepare("SELECT * FROM carts WHERE token = ? AND status = 'active'");
    $st->execute([$tok]);
    $cart = $st->fetch() ?: null;
    if ($cart || !$create) return $cart;

    getDB()->prepare("INSERT INTO carts (token, currency) VALUES (?, ?)")
           ->execute([$tok, shopCurrency()['code']]);
    return [
        'id'          => (int) getDB()->lastInsertId(),
        'token'       => $tok,
        'customer_id' => null,
        'currency'    => shopCurrency()['code'],
        'status'      => 'active',
    ];
}

/**
 * Precio unitario resuelto para una línea: el menor entre el efectivo
 * (sale > price) y el del escalón de mayoreo aplicable a esa cantidad.
 */
function cartResolveUnitPrice(array $product, ?array $variation, int $qty): float {
    if ($variation) {
        $base = (float) $variation['price'];
        $sale = $variation['sale_price'] ?? null;
        $effective = ($sale !== null && $sale !== '' && (float) $sale > 0) ? (float) $sale : $base;
    } else {
        $effective = productEffectivePrice($product);
    }
    $tier = productTierPrice((int) $product['id'], max(1, $qty));
    if ($tier !== null && $tier < $effective) return (float) $tier;
    return (float) $effective;
}

/** @return array{ok:bool, error?:string} */
function cartAddItem(int $productId, ?int $variationId, int $qty): array {
    $p = productGet($productId);
    if (!$p || ($p['status'] ?? '') !== 'published') {
        return ['ok' => false, 'error' => 'Producto no disponible.'];
    }
    $moq = max(1, (int) ($p['min_order_qty'] ?? 1));
    $qty = max($moq, $qty);

    $v = null;
    if (($p['type'] ?? 'simple') === 'variable') {
        if (!$variationId) return ['ok' => false, 'error' => 'Selecciona las opciones del producto.'];
        $st = getDB()->prepare(
            'SELECT * FROM product_variations WHERE id = ? AND product_id = ? AND is_active = 1'
        );
        $st->execute([$variationId, $productId]);
        $v = $st->fetch() ?: null;
        if (!$v) return ['ok' => false, 'error' => 'Esa combinación no está disponible.'];
        // Stock: si maneja stock y está en 0 (y no es backorder) → no agregar.
        if (($v['stock_status'] ?? '') !== 'backorder' && (int) $v['stock_qty'] <= 0) {
            return ['ok' => false, 'error' => 'Sin stock para esa combinación.'];
        }
    } else {
        $variationId = null;
        if ((int) ($p['manage_stock'] ?? 1) === 1
            && (int) ($p['stock_qty'] ?? 0) <= 0
            && ($p['stock_status'] ?? 'in_stock') !== 'backorder') {
            return ['ok' => false, 'error' => 'Producto sin stock.'];
        }
    }

    $cart = cartCurrent(true);
    $cid  = (int) $cart['id'];

    // Sumar si la misma línea ya existe (mismo producto + variación).
    $st = getDB()->prepare(
        'SELECT id, qty FROM cart_items
         WHERE cart_id = ? AND product_id = ? AND (variation_id <=> ?) LIMIT 1'
    );
    $st->execute([$cid, $productId, $variationId]);
    $existing = $st->fetch() ?: null;

    if ($existing) {
        $newQty = (int) $existing['qty'] + $qty;
        $unit   = cartResolveUnitPrice($p, $v, $newQty);
        getDB()->prepare('UPDATE cart_items SET qty = ?, unit_price = ? WHERE id = ?')
               ->execute([$newQty, $unit, (int) $existing['id']]);
    } else {
        $unit = cartResolveUnitPrice($p, $v, $qty);
        getDB()->prepare(
            'INSERT INTO cart_items (cart_id, product_id, variation_id, qty, unit_price)
             VALUES (?, ?, ?, ?, ?)'
        )->execute([$cid, $productId, $variationId, $qty, $unit]);
    }
    getDB()->prepare('UPDATE carts SET updated_at = NOW() WHERE id = ?')->execute([$cid]);
    return ['ok' => true];
}

function cartUpdateQty(int $itemId, int $qty): void {
    $cart = cartCurrent(false);
    if (!$cart) return;
    $st = getDB()->prepare(
        'SELECT ci.id, ci.product_id, ci.variation_id, p.min_order_qty
         FROM cart_items ci JOIN products p ON p.id = ci.product_id
         WHERE ci.id = ? AND ci.cart_id = ?'
    );
    $st->execute([$itemId, (int) $cart['id']]);
    $row = $st->fetch() ?: null;
    if (!$row) return;

    if ($qty <= 0) { cartRemoveItem($itemId); return; }
    $moq = max(1, (int) ($row['min_order_qty'] ?? 1));
    $qty = max($moq, $qty);

    $product = productGet((int) $row['product_id']);
    $v = null;
    if (!empty($row['variation_id'])) {
        $sv = getDB()->prepare('SELECT * FROM product_variations WHERE id = ?');
        $sv->execute([(int) $row['variation_id']]);
        $v = $sv->fetch() ?: null;
    }
    $unit = cartResolveUnitPrice($product, $v, $qty);
    getDB()->prepare('UPDATE cart_items SET qty = ?, unit_price = ? WHERE id = ?')
           ->execute([$qty, $unit, $itemId]);
    getDB()->prepare('UPDATE carts SET updated_at = NOW() WHERE id = ?')->execute([(int) $cart['id']]);
}

function cartRemoveItem(int $itemId): void {
    $cart = cartCurrent(false);
    if (!$cart) return;
    getDB()->prepare('DELETE FROM cart_items WHERE id = ? AND cart_id = ?')
           ->execute([$itemId, (int) $cart['id']]);
}

function cartClear(): void {
    $cart = cartCurrent(false);
    if (!$cart) return;
    getDB()->prepare('DELETE FROM cart_items WHERE cart_id = ?')->execute([(int) $cart['id']]);
}

/**
 * Líneas del carrito enriquecidas (nombre, thumb, slug, etiqueta de variación,
 * line_total). Refresca unit_price si cambió la tier o el sale_price.
 */
function cartItems(): array {
    $cart = cartCurrent(false);
    if (!$cart) return [];
    $st = getDB()->prepare(
        "SELECT ci.id, ci.product_id, ci.variation_id, ci.qty, ci.unit_price,
                p.name, p.slug, p.type, p.min_order_qty, p.manage_stock,
                p.stock_qty, p.stock_status,
                (SELECT m.thumb_path FROM product_images pi JOIN media_library m ON m.id = pi.media_id
                 WHERE pi.product_id = p.id ORDER BY pi.is_primary DESC, pi.sort_order LIMIT 1) AS thumb
         FROM cart_items ci JOIN products p ON p.id = ci.product_id
         WHERE ci.cart_id = ? ORDER BY ci.id ASC"
    );
    $st->execute([(int) $cart['id']]);
    $rows = $st->fetchAll();
    if (!$rows) return [];

    $varSt   = getDB()->prepare('SELECT * FROM product_variations WHERE id = ?');
    $labelSt = getDB()->prepare(
        'SELECT av.value FROM variation_attribute_values vav
         JOIN attribute_values av ON av.id = vav.attribute_value_id
         WHERE vav.variation_id = ? ORDER BY vav.attribute_id'
    );
    $upd = getDB()->prepare('UPDATE cart_items SET unit_price = ? WHERE id = ?');

    foreach ($rows as &$r) {
        $product = productGet((int) $r['product_id']);
        $v = null;
        if (!empty($r['variation_id'])) {
            $varSt->execute([(int) $r['variation_id']]);
            $v = $varSt->fetch() ?: null;
            $labelSt->execute([(int) $r['variation_id']]);
            $r['variation_label'] = implode(' / ', array_map(
                fn($x) => $x['value'], $labelSt->fetchAll()
            ));
        } else {
            $r['variation_label'] = '';
        }
        $fresh = cartResolveUnitPrice($product, $v, (int) $r['qty']);
        if (abs($fresh - (float) $r['unit_price']) > 0.001) {
            $upd->execute([$fresh, (int) $r['id']]);
            $r['unit_price'] = $fresh;
        }
        $r['line_total'] = shopRound((float) $r['unit_price'] * (int) $r['qty']);
    }
    unset($r);
    return $rows;
}

/** Sumario para footer de carrito y badges. */
function cartTotals(): array {
    $items = cartItems();
    $subtotal = 0.0;
    $qty = 0;
    foreach ($items as $i) {
        $subtotal += (float) $i['line_total'];
        $qty      += (int) $i['qty'];
    }
    return [
        'subtotal' => shopRound($subtotal),
        'qty'      => $qty,
        'count'    => count($items),
    ];
}

/** Total de unidades en el carrito (para el badge del header). Barato. */
function cartCount(): int {
    if (empty($_COOKIE['pse_cart'])) return 0;
    $cart = cartCurrent(false);
    if (!$cart) return 0;
    $st = getDB()->prepare('SELECT COALESCE(SUM(qty), 0) FROM cart_items WHERE cart_id = ?');
    $st->execute([(int) $cart['id']]);
    return (int) $st->fetchColumn();
}
