<?php
/**
 * Sistema de cotizaciones (RFQ).
 *
 *   draft   → carrito de cotización en cookie (token UUID `pse_quote`)
 *   submitted → el cliente envió sus datos; aparece en el admin
 *   responded → el admin respondió por mail
 *   won|lost|expired → estados finales
 *
 * Convive con `cart.php`: las dos tablas son independientes (`quotes` /
 * `quote_items`) y el cliente puede usar ambos flujos si el setting
 * `quotes_enabled` está activo.
 *
 * Diseño:
 *   - Mismo token-en-cookie que el carrito: el visitante mantiene su draft
 *     entre visitas durante 1 año.
 *   - `quote_items` guarda `name_snapshot` y `sku_snapshot` por si el producto
 *     cambia o se borra del catálogo después de enviada.
 *   - `unit_price_est` puede quedar NULL: en muchos B2B el cliente arma su lista
 *     sin precios y el vendedor cotiza en el siguiente paso.
 */

/** UUID v4 estable en cookie HttpOnly. */
function quoteToken(): string {
    if (!empty($_COOKIE['pse_quote']) && preg_match(
        '/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i',
        (string) $_COOKIE['pse_quote']
    )) {
        return (string) $_COOKIE['pse_quote'];
    }
    $b = random_bytes(16);
    $b[6] = chr((ord($b[6]) & 0x0f) | 0x40);
    $b[8] = chr((ord($b[8]) & 0x3f) | 0x80);
    $tok = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($b), 4));
    setcookie('pse_quote', $tok, [
        'expires'  => time() + 60 * 60 * 24 * 365,
        'path'     => '/',
        'httponly' => true,
        'samesite' => 'Lax',
        'secure'   => !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off',
    ]);
    $_COOKIE['pse_quote'] = $tok;
    return $tok;
}

/** Devuelve TRUE si el módulo está activo (setting + tablas presentes). */
function quotesEnabled(): bool {
    return (string) getSetting('quotes_enabled', '0') === '1';
}

/** Settings agrupados para no llamar getSetting() repetido. */
function quoteSettings(): array {
    return [
        'enabled'           => quotesEnabled(),
        'number_prefix'     => (string) getSetting('quote_number_prefix', 'COT-'),
        'show_prices'       => (string) getSetting('quote_show_prices', '0') === '1',
        'button_label'      => (string) getSetting('quote_button_label', 'Agregar a cotización'),
        'submit_label'      => (string) getSetting('quote_submit_label', 'Solicitar cotización'),
        'drawer_title'      => (string) getSetting('quote_drawer_title', 'Mi cotización'),
        'thanks_slug'       => (string) getSetting('quote_thanks_slug', 'gracias-cotizacion'),
        'expiration_days'   => max(0, (int) getSetting('quote_expiration_days', '14')),
        'require_company'   => (string) getSetting('quote_require_company', '0') === '1',
        'require_taxid'     => (string) getSetting('quote_require_taxid', '0') === '1',
        'intro_text'        => (string) getSetting('quote_intro_text', ''),
    ];
}

/** Cotización activa (draft) del visitante. Con $create=true la genera. */
function quoteCurrent(bool $create = false): ?array {
    $tok = quoteToken();
    $st = getDB()->prepare("SELECT * FROM quotes WHERE token = ? AND status = 'draft'");
    $st->execute([$tok]);
    $q = $st->fetch() ?: null;
    if ($q || !$create) return $q;

    $currency = function_exists('shopCurrency') ? shopCurrency()['code'] : 'CLP';
    getDB()->prepare("INSERT INTO quotes (token, currency) VALUES (?, ?)")
           ->execute([$tok, $currency]);
    return [
        'id'       => (int) getDB()->lastInsertId(),
        'token'    => $tok,
        'status'   => 'draft',
        'currency' => $currency,
    ];
}

/* =================== Items del carrito de cotización =================== */

/**
 * Resuelve precio unitario para mostrar en el draft. Devuelve NULL si el
 * producto no tiene precio (o si el setting quote_show_prices = 0).
 */
function quoteResolveUnitPrice(array $product, ?array $variation, int $qty): ?float {
    if (!function_exists('cartResolveUnitPrice')) return null;
    $p = cartResolveUnitPrice($product, $variation, $qty);
    return $p > 0 ? (float) $p : null;
}

/** @return array{ok:bool, error?:string} */
function quoteAddItem(int $productId, ?int $variationId, int $qty, ?string $itemNotes = null): array {
    $p = function_exists('productGet') ? productGet($productId) : null;
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
    } else {
        $variationId = null;
    }

    $quote = quoteCurrent(true);
    $qid   = (int) $quote['id'];
    $unit  = quoteResolveUnitPrice($p, $v, $qty);

    // Suma si la misma línea existe (mismo producto + variación).
    $st = getDB()->prepare(
        'SELECT id, qty FROM quote_items
         WHERE quote_id = ? AND product_id = ? AND (variation_id <=> ?) LIMIT 1'
    );
    $st->execute([$qid, $productId, $variationId]);
    $existing = $st->fetch() ?: null;

    if ($existing) {
        $newQty = (int) $existing['qty'] + $qty;
        getDB()->prepare(
            'UPDATE quote_items SET qty = ?, unit_price_est = ?,
             item_notes = COALESCE(NULLIF(?, ""), item_notes)
             WHERE id = ?'
        )->execute([$newQty, $unit, (string) $itemNotes, (int) $existing['id']]);
    } else {
        $sku  = '';
        if ($v && !empty($v['sku'])) $sku = (string) $v['sku'];
        elseif (!empty($p['sku']))   $sku = (string) $p['sku'];
        $name = (string) $p['name'];
        if ($v) {
            $lblSt = getDB()->prepare(
                'SELECT av.value FROM variation_attribute_values vav
                 JOIN attribute_values av ON av.id = vav.attribute_value_id
                 WHERE vav.variation_id = ? ORDER BY vav.attribute_id'
            );
            $lblSt->execute([(int) $v['id']]);
            $vals = array_column($lblSt->fetchAll(), 'value');
            if ($vals) $name .= ' — ' . implode(' / ', $vals);
        }
        getDB()->prepare(
            'INSERT INTO quote_items
             (quote_id, product_id, variation_id, sku_snapshot, name_snapshot, qty, unit_price_est, item_notes)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?)'
        )->execute([$qid, $productId, $variationId, $sku ?: null, $name, $qty, $unit, $itemNotes ?: null]);
    }
    quoteTouch($qid);
    return ['ok' => true];
}

/** Línea libre (sin product_id): el cliente describe lo que quiere. */
function quoteAddCustomItem(string $name, int $qty = 1, ?string $itemNotes = null): array {
    $name = trim($name);
    if ($name === '') return ['ok' => false, 'error' => 'Falta el nombre del ítem.'];
    $quote = quoteCurrent(true);
    getDB()->prepare(
        'INSERT INTO quote_items (quote_id, name_snapshot, qty, item_notes) VALUES (?, ?, ?, ?)'
    )->execute([(int) $quote['id'], $name, max(1, $qty), $itemNotes ?: null]);
    quoteTouch((int) $quote['id']);
    return ['ok' => true];
}

function quoteUpdateQty(int $itemId, int $qty): void {
    $q = quoteCurrent(false);
    if (!$q) return;
    if ($qty <= 0) { quoteRemoveItem($itemId); return; }

    $st = getDB()->prepare(
        'SELECT qi.id, qi.product_id, qi.variation_id, p.min_order_qty
         FROM quote_items qi LEFT JOIN products p ON p.id = qi.product_id
         WHERE qi.id = ? AND qi.quote_id = ?'
    );
    $st->execute([$itemId, (int) $q['id']]);
    $row = $st->fetch() ?: null;
    if (!$row) return;

    $moq = max(1, (int) ($row['min_order_qty'] ?? 1));
    $qty = max($moq, $qty);

    $unit = null;
    if (!empty($row['product_id'])) {
        $product = productGet((int) $row['product_id']);
        $v = null;
        if (!empty($row['variation_id'])) {
            $sv = getDB()->prepare('SELECT * FROM product_variations WHERE id = ?');
            $sv->execute([(int) $row['variation_id']]);
            $v = $sv->fetch() ?: null;
        }
        if ($product) $unit = quoteResolveUnitPrice($product, $v, $qty);
    }
    getDB()->prepare('UPDATE quote_items SET qty = ?, unit_price_est = ? WHERE id = ?')
           ->execute([$qty, $unit, $itemId]);
    quoteTouch((int) $q['id']);
}

function quoteUpdateNotes(int $itemId, string $notes): void {
    $q = quoteCurrent(false);
    if (!$q) return;
    getDB()->prepare('UPDATE quote_items SET item_notes = ? WHERE id = ? AND quote_id = ?')
           ->execute([trim($notes) === '' ? null : trim($notes), $itemId, (int) $q['id']]);
    quoteTouch((int) $q['id']);
}

function quoteRemoveItem(int $itemId): void {
    $q = quoteCurrent(false);
    if (!$q) return;
    getDB()->prepare('DELETE FROM quote_items WHERE id = ? AND quote_id = ?')
           ->execute([$itemId, (int) $q['id']]);
    quoteTouch((int) $q['id']);
}

function quoteClear(): void {
    $q = quoteCurrent(false);
    if (!$q) return;
    getDB()->prepare('DELETE FROM quote_items WHERE quote_id = ?')->execute([(int) $q['id']]);
    quoteTouch((int) $q['id']);
}

function quoteTouch(int $quoteId): void {
    // Refresca items_count y subtotal_est sobre el draft.
    $st = getDB()->prepare(
        'SELECT COALESCE(SUM(qty), 0)  AS qty_total,
                COALESCE(SUM(qty * COALESCE(unit_price_est, 0)), 0) AS sub_total,
                COUNT(*) AS lines
         FROM quote_items WHERE quote_id = ?'
    );
    $st->execute([$quoteId]);
    $r = $st->fetch() ?: ['qty_total' => 0, 'sub_total' => 0, 'lines' => 0];
    getDB()->prepare(
        'UPDATE quotes
         SET items_count = ?, subtotal_est = ?, updated_at = NOW()
         WHERE id = ?'
    )->execute([(int) $r['lines'], (float) $r['sub_total'] ?: null, $quoteId]);
}

/** Líneas del draft enriquecidas para render. */
function quoteItems(): array {
    $q = quoteCurrent(false);
    if (!$q) return [];
    $st = getDB()->prepare(
        "SELECT qi.id, qi.product_id, qi.variation_id, qi.qty, qi.unit_price_est,
                qi.name_snapshot, qi.sku_snapshot, qi.item_notes,
                p.slug AS product_slug,
                (SELECT m.thumb_path FROM product_images pi JOIN media_library m ON m.id = pi.media_id
                 WHERE pi.product_id = qi.product_id ORDER BY pi.is_primary DESC, pi.sort_order LIMIT 1) AS thumb
         FROM quote_items qi LEFT JOIN products p ON p.id = qi.product_id
         WHERE qi.quote_id = ? ORDER BY qi.id ASC"
    );
    $st->execute([(int) $q['id']]);
    $rows = $st->fetchAll();
    foreach ($rows as &$r) {
        $r['line_total_est'] = ($r['unit_price_est'] !== null)
            ? round((float) $r['unit_price_est'] * (int) $r['qty'], 2)
            : null;
    }
    return $rows;
}

/** Sumario para drawer / footer / badges. */
function quoteTotals(): array {
    $items = quoteItems();
    $sub = 0.0; $qty = 0; $hasPrices = false;
    foreach ($items as $i) {
        $qty += (int) $i['qty'];
        if ($i['unit_price_est'] !== null) {
            $sub += (float) $i['line_total_est'];
            $hasPrices = true;
        }
    }
    return [
        'subtotal_est' => $hasPrices ? round($sub, 2) : null,
        'qty'          => $qty,
        'count'        => count($items),
    ];
}

/** Total de unidades (badge del header). Barato. */
function quoteCount(): int {
    if (empty($_COOKIE['pse_quote'])) return 0;
    $q = quoteCurrent(false);
    if (!$q) return 0;
    $st = getDB()->prepare('SELECT COALESCE(SUM(qty), 0) FROM quote_items WHERE quote_id = ?');
    $st->execute([(int) $q['id']]);
    return (int) $st->fetchColumn();
}

/* =================== Envío =================== */

function quoteGenerateNumber(): string {
    $prefix = (string) getSetting('quote_number_prefix', 'COT-');
    $year   = date('Y');
    $st = getDB()->prepare(
        "SELECT COUNT(*) FROM quotes WHERE submitted_at IS NOT NULL
         AND YEAR(submitted_at) = ?"
    );
    $st->execute([$year]);
    $seq = ((int) $st->fetchColumn()) + 1;
    return sprintf('%s%s-%04d', $prefix, $year, $seq);
}

/**
 * Valida + convierte el draft en una cotización formal.
 * @return array{ok:bool, id?:int, number?:string, error?:string}
 */
function quoteSubmit(array $data): array {
    $q = quoteCurrent(false);
    if (!$q) return ['ok' => false, 'error' => 'No hay una cotización en curso.'];

    $name  = trim((string) ($data['name']  ?? ''));
    $email = trim((string) ($data['email'] ?? ''));
    $phone = trim((string) ($data['phone'] ?? ''));
    $company  = trim((string) ($data['company'] ?? ''));
    $taxid    = trim((string) ($data['taxid']   ?? ''));
    $position = trim((string) ($data['position'] ?? ''));
    $city     = trim((string) ($data['city']     ?? ''));
    $region   = trim((string) ($data['region']   ?? ''));
    $message  = trim((string) ($data['message']  ?? ''));

    $set = quoteSettings();
    if ($name === '')                                return ['ok' => false, 'error' => 'Falta tu nombre.'];
    if (!filter_var($email, FILTER_VALIDATE_EMAIL))  return ['ok' => false, 'error' => 'Email inválido.'];
    if ($phone === '')                               return ['ok' => false, 'error' => 'Falta el teléfono de contacto.'];
    if ($set['require_company'] && $company === '')  return ['ok' => false, 'error' => 'Falta el nombre de la empresa.'];
    if ($set['require_taxid']   && $taxid   === '')  return ['ok' => false, 'error' => 'Falta el RUT / identificación tributaria.'];

    $items = quoteItems();
    if (!$items && $message === '') {
        return ['ok' => false, 'error' => 'Agregá productos o un mensaje describiendo qué necesitás.'];
    }

    $number  = quoteGenerateNumber();
    $expires = $set['expiration_days'] > 0
        ? date('Y-m-d H:i:s', time() + 86400 * $set['expiration_days'])
        : null;
    $userAgent = substr((string) ($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 500);
    $ip = function_exists('clientIp') ? clientIp() : ($_SERVER['REMOTE_ADDR'] ?? null);

    // Si hay un cliente logueado, ligamos la cotización a su cuenta (sin pisar
    // un vínculo previo). Así aparece en el historial de /mi-cuenta.
    $customerId = (function_exists('currentCustomer') && ($cust = currentCustomer()))
        ? (int) $cust['id'] : null;

    getDB()->prepare(
        "UPDATE quotes SET
            customer_id      = COALESCE(customer_id, ?),
            quote_number     = ?,
            status           = 'submitted',
            contact_name     = ?,
            contact_email    = ?,
            contact_phone    = ?,
            contact_company  = ?,
            contact_taxid    = ?,
            contact_position = ?,
            contact_city     = ?,
            contact_region   = ?,
            message          = ?,
            submitted_at     = NOW(),
            expires_at       = ?,
            ip_address       = ?,
            user_agent       = ?
         WHERE id = ?"
    )->execute([
        $customerId,
        $number, $name, $email, $phone,
        $company ?: null, $taxid ?: null, $position ?: null,
        $city ?: null, $region ?: null,
        $message ?: null, $expires,
        $ip, $userAgent, (int) $q['id'],
    ]);

    quoteAddStatusEntry((int) $q['id'], 'submitted', null, null);

    // Limpiamos la cookie así el cliente empieza una nueva si vuelve.
    setcookie('pse_quote', '', [
        'expires'  => time() - 3600,
        'path'     => '/',
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
    unset($_COOKIE['pse_quote']);

    // Notificaciones (no rompen el flujo si fallan).
    $full = quoteGet((int) $q['id']);
    if ($full) {
        try { notifyQuoteSubmitted($full, $items); } catch (Throwable $e) { error_log('notifyQuote: ' . $e->getMessage()); }
        try { sendQuoteAutoReply($full, $items); }  catch (Throwable $e) { error_log('quoteAutoReply: ' . $e->getMessage()); }
    }

    return ['ok' => true, 'id' => (int) $q['id'], 'number' => $number];
}

/* =================== Admin (queries de lectura) =================== */

function quoteGet(int $id): ?array {
    if ($id <= 0) return null;
    $st = getDB()->prepare('SELECT * FROM quotes WHERE id = ?');
    $st->execute([$id]);
    return $st->fetch() ?: null;
}

function quoteGetItems(int $quoteId): array {
    $st = getDB()->prepare(
        'SELECT qi.*, p.slug AS product_slug
         FROM quote_items qi LEFT JOIN products p ON p.id = qi.product_id
         WHERE qi.quote_id = ? ORDER BY qi.id ASC'
    );
    $st->execute([$quoteId]);
    return $st->fetchAll();
}

function quoteGetNotes(int $quoteId): array {
    $st = getDB()->prepare(
        'SELECT qn.*, u.email AS user_email, u.name AS user_name
         FROM quote_notes qn LEFT JOIN users u ON u.id = qn.user_id
         WHERE qn.quote_id = ? ORDER BY qn.created_at DESC'
    );
    $st->execute([$quoteId]);
    return $st->fetchAll();
}

function quoteGetHistory(int $quoteId): array {
    $st = getDB()->prepare(
        'SELECT qsh.*, u.email AS user_email
         FROM quote_status_history qsh LEFT JOIN users u ON u.id = qsh.created_by
         WHERE qsh.quote_id = ? ORDER BY qsh.created_at DESC'
    );
    $st->execute([$quoteId]);
    return $st->fetchAll();
}

const QUOTE_STATUSES = ['draft', 'submitted', 'responded', 'won', 'lost', 'expired'];

function quoteList(array $filters = []): array {
    $where  = ["status != 'draft'"];   // los drafts no aparecen en el admin
    $params = [];
    if (!empty($filters['search'])) {
        $like = '%' . trim((string) $filters['search']) . '%';
        $where[] = '(contact_name LIKE ? OR contact_email LIKE ? OR contact_company LIKE ? OR quote_number LIKE ?)';
        array_push($params, $like, $like, $like, $like);
    }
    if (!empty($filters['status']) && in_array($filters['status'], QUOTE_STATUSES, true)) {
        $where[] = 'status = ?';
        $params[] = $filters['status'];
    }
    $whereSql = 'WHERE ' . implode(' AND ', $where);
    $sql = "SELECT id, quote_number, status, contact_name, contact_email,
                   contact_company, items_count, subtotal_est, currency,
                   submitted_at, created_at
            FROM quotes $whereSql ORDER BY submitted_at DESC, id DESC";
    $st = getDB()->prepare($sql);
    $st->execute($params);
    return $st->fetchAll();
}

function quoteStats(): array {
    $st = getDB()->query(
        "SELECT
            SUM(status = 'submitted') AS new_count,
            SUM(status = 'responded') AS responded_count,
            SUM(status = 'won')       AS won_count,
            SUM(status IN ('submitted','responded'))
              AS open_count,
            SUM(DATE(submitted_at) = CURDATE()) AS today_count
         FROM quotes WHERE status != 'draft'"
    );
    return $st->fetch() ?: [];
}

/* =================== Admin (acciones) =================== */

function quoteUpdateStatus(int $id, string $status, ?int $userId = null, ?string $note = null): bool {
    if (!in_array($status, QUOTE_STATUSES, true)) return false;
    $now = date('Y-m-d H:i:s');
    $extra = [];
    if ($status === 'responded') $extra['responded_at'] = $now;
    if ($status === 'won')       $extra['won_at']       = $now;
    if ($status === 'lost')      $extra['lost_at']      = $now;

    $sets = ['status = ?'];
    $vals = [$status];
    foreach ($extra as $k => $v) { $sets[] = "$k = ?"; $vals[] = $v; }
    $vals[] = $id;
    $sql = 'UPDATE quotes SET ' . implode(', ', $sets) . ' WHERE id = ?';
    $ok = getDB()->prepare($sql)->execute($vals);
    if ($ok) quoteAddStatusEntry($id, $status, $userId, $note);
    return $ok;
}

function quoteAddStatusEntry(int $id, string $status, ?int $userId, ?string $note): void {
    getDB()->prepare(
        'INSERT INTO quote_status_history (quote_id, status, note, created_by) VALUES (?, ?, ?, ?)'
    )->execute([$id, $status, $note ?: null, $userId]);
}

function quoteAddInternalNote(int $id, int $userId, string $body): void {
    $body = trim($body);
    if ($body === '') return;
    getDB()->prepare(
        'INSERT INTO quote_notes (quote_id, user_id, body) VALUES (?, ?, ?)'
    )->execute([$id, $userId, $body]);
}

function quoteSaveResponseText(int $id, string $text): void {
    getDB()->prepare('UPDATE quotes SET response_text = ? WHERE id = ?')
           ->execute([trim($text) === '' ? null : trim($text), $id]);
}

function quoteSendResponse(int $id, int $userId, string $subject, string $body): array {
    $q = quoteGet($id);
    if (!$q) return ['ok' => false, 'error' => 'Cotización no encontrada.'];
    if (empty($q['contact_email'])) return ['ok' => false, 'error' => 'La cotización no tiene email de contacto.'];

    $vars  = quoteTemplateVars($q, quoteGetItems($id));
    $subjR = renderTemplate($subject, $vars);
    $bodyR = renderTemplate($body, $vars);

    $res = sendMailDetailed($q['contact_email'], $subjR, $bodyR);
    if ($res['ok']) {
        quoteSaveResponseText($id, $bodyR);
        quoteUpdateStatus($id, 'responded', $userId, 'Respuesta enviada por email');
    }
    return $res;
}

function quoteDelete(int $id): bool {
    return getDB()->prepare('DELETE FROM quotes WHERE id = ?')->execute([$id]);
}

/* =================== Plantillas de mail =================== */

function quoteItemsAsText(array $items): string {
    if (!$items) return '— (sin productos: ver mensaje del cliente)';
    $out = [];
    foreach ($items as $i) {
        $line = '• ' . str_pad((string) $i['qty'] . ' x', 6, ' ', STR_PAD_LEFT)
              . ' ' . (string) $i['name_snapshot'];
        if (!empty($i['sku_snapshot'])) $line .= ' [SKU ' . $i['sku_snapshot'] . ']';
        if (!empty($i['item_notes']))   $line .= "\n      Notas: " . $i['item_notes'];
        if (isset($i['unit_price_est']) && $i['unit_price_est'] !== null) {
            $line .= ' — ' . (function_exists('shopFormatPrice') ? shopFormatPrice($i['unit_price_est']) : (string) $i['unit_price_est']);
        }
        $out[] = $line;
    }
    return implode("\n", $out);
}

function quoteTemplateVars(array $quote, array $items): array {
    $host  = $_SERVER['HTTP_HOST'] ?? '';
    $proto = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $vars = [
        'quote_number'    => (string) ($quote['quote_number']   ?? '—'),
        'contact_name'    => (string) ($quote['contact_name']   ?? ''),
        'contact_email'   => (string) ($quote['contact_email']  ?? ''),
        'contact_phone'   => (string) ($quote['contact_phone']  ?? '') ?: '—',
        'contact_company' => (string) ($quote['contact_company']?? '') ?: '—',
        'contact_taxid'   => (string) ($quote['contact_taxid']  ?? '') ?: '—',
        'contact_city'    => (string) ($quote['contact_city']   ?? '') ?: '—',
        'contact_region'  => (string) ($quote['contact_region'] ?? '') ?: '—',
        'items_count'     => (string) (int) ($quote['items_count'] ?? count($items)),
        'items_list'      => quoteItemsAsText($items),
        'message'         => (string) ($quote['message'] ?? '') ?: '—',
        'submitted_at'    => (string) ($quote['submitted_at'] ?? date('Y-m-d H:i')),
        'admin_url'       => $host ? ($proto . '://' . $host . '/admin/?view=quote&id=' . (int) $quote['id']) : '',
        'site_name'       => (string) getSetting('site_name', 'Mi Sitio'),
    ];
    if (function_exists('businessInfo')) {
        foreach (businessInfo() as $k => $v) $vars[$k] = (string) $v;
        $vars['business_whatsapp_link'] = whatsappLink(
            (string) getSetting('business_whatsapp', ''),
            (string) getSetting('business_whatsapp_text', '')
        );
    }
    return $vars;
}

function notifyQuoteSubmitted(array $quote, array $items): void {
    $to = trim((string) getSetting('notification_email', ''));
    if (!$to) return;
    $subjectTpl = (string) getSetting('quote_notification_subject',
        '[{{site_name}}] Nueva cotización {{quote_number}}');
    $bodyTpl    = (string) getSetting('quote_notification_body', '');
    if ($bodyTpl === '') return;
    $vars = quoteTemplateVars($quote, $items);
    sendMailDetailed($to, renderTemplate($subjectTpl, $vars), renderTemplate($bodyTpl, $vars));
}

function sendQuoteAutoReply(array $quote, array $items): void {
    if (getSetting('quote_autoreply_enabled', '1') !== '1') return;
    if (empty($quote['contact_email'])) return;
    $vars   = quoteTemplateVars($quote, $items);
    $subject = renderTemplate((string) getSetting('quote_autoreply_subject', 'Recibimos tu cotización'), $vars);
    $body    = renderTemplate((string) getSetting('quote_autoreply_body', ''), $vars);
    if ($body === '') return;
    sendMailDetailed((string) $quote['contact_email'], $subject, $body);
}

/* =================== Mantenimiento =================== */

/** Marca como `expired` los enviados que pasaron `expires_at` sin responderse. */
function quoteExpireOverdue(): int {
    $st = getDB()->prepare(
        "UPDATE quotes SET status = 'expired'
         WHERE status IN ('submitted','responded')
           AND expires_at IS NOT NULL AND expires_at < NOW()"
    );
    $st->execute();
    return $st->rowCount();
}
