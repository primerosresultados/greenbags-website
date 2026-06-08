<?php
/**
 * Extras de producto: venta por mayor (precios por cantidad) y videos.
 */

/* ============ Precios por mayor (tiers por cantidad) ============ */

/** Tiers de un producto (nivel producto, variation_id NULL), ordenados por cantidad. */
function productTiers(int $productId): array {
    $st = getDB()->prepare(
        'SELECT id, min_qty, unit_price FROM price_tiers
         WHERE product_id = ? AND variation_id IS NULL ORDER BY min_qty ASC'
    );
    $st->execute([$productId]);
    return $st->fetchAll();
}

/** Reemplaza los tiers del producto. $rows = [ ['min_qty'=>10,'unit_price'=>9990], ... ]. */
function productSetTiers(int $productId, array $rows): void {
    $db = getDB();
    $db->prepare('DELETE FROM price_tiers WHERE product_id = ? AND variation_id IS NULL')->execute([$productId]);
    $seen = [];
    $ins = $db->prepare('INSERT INTO price_tiers (product_id, variation_id, min_qty, unit_price) VALUES (?, NULL, ?, ?)');
    foreach ($rows as $r) {
        $min = (int) ($r['min_qty'] ?? 0);
        $price = ($r['unit_price'] ?? '') !== '' ? max(0, (float) $r['unit_price']) : null;
        if ($min < 1 || $price === null) continue;
        if (isset($seen[$min])) continue;
        $seen[$min] = true;
        $ins->execute([$productId, $min, $price]);
    }
}

/**
 * Precio unitario para una cantidad dada según los tiers (o null si no aplica).
 * Toma el tier con mayor min_qty que sea <= qty.
 */
function productTierPrice(int $productId, int $qty): ?float {
    $st = getDB()->prepare(
        'SELECT unit_price FROM price_tiers
         WHERE product_id = ? AND variation_id IS NULL AND min_qty <= ?
         ORDER BY min_qty DESC LIMIT 1'
    );
    $st->execute([$productId, max(1, $qty)]);
    $v = $st->fetchColumn();
    return $v === false ? null : (float) $v;
}

/* ============ Videos ============ */

/** Detecta proveedor e id desde una URL. @return array{0:string,1:string} [provider, video_id] */
function videoDetect(string $url): array {
    $url = trim($url);
    if (preg_match('~(?:youtube\.com/(?:watch\?v=|embed/|shorts/|v/)|youtu\.be/)([A-Za-z0-9_-]{6,})~i', $url, $m)) {
        return ['youtube', $m[1]];
    }
    if (preg_match('~vimeo\.com/(?:video/)?(\d+)~i', $url, $m)) {
        return ['vimeo', $m[1]];
    }
    return ['file', '']; // mp4 directo / Cloudinary / otro
}

function productVideos(int $productId): array {
    $st = getDB()->prepare('SELECT * FROM product_videos WHERE product_id = ? ORDER BY sort_order, id');
    $st->execute([$productId]);
    return $st->fetchAll();
}

/** Reemplaza los videos del producto. $urls = lista de strings (o ['url'=>...]). */
function productSetVideos(int $productId, array $urls): void {
    $db = getDB();
    $db->prepare('DELETE FROM product_videos WHERE product_id = ?')->execute([$productId]);
    $ins = $db->prepare('INSERT INTO product_videos (product_id, provider, url, video_id, sort_order) VALUES (?, ?, ?, ?, ?)');
    $i = 0;
    foreach ($urls as $u) {
        $url = is_array($u) ? trim((string) ($u['url'] ?? '')) : trim((string) $u);
        if ($url === '' || !preg_match('~^https?://~i', $url)) continue;
        [$provider, $vid] = videoDetect($url);
        $ins->execute([$productId, $provider, mb_substr($url, 0, 600), $vid ?: null, $i++]);
    }
}

/** HTML embebido de un video (iframe para YouTube/Vimeo, <video> para archivo). */
function videoEmbedHtml(array $v): string {
    $provider = (string) ($v['provider'] ?? 'file');
    $vid = (string) ($v['video_id'] ?? '');
    $url = (string) ($v['url'] ?? '');
    $h = fn($s) => htmlspecialchars((string) $s, ENT_QUOTES, 'UTF-8');
    if ($provider === 'youtube' && $vid !== '') {
        return '<div class="shop-video"><iframe src="https://www.youtube-nocookie.com/embed/' . $h($vid)
            . '" title="Video" loading="lazy" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>';
    }
    if ($provider === 'vimeo' && $vid !== '') {
        return '<div class="shop-video"><iframe src="https://player.vimeo.com/video/' . $h($vid)
            . '" title="Video" loading="lazy" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe></div>';
    }
    return '<video class="shop-video" controls preload="metadata" src="' . $h($url) . '"></video>';
}

/** Thumbnail de un video (para JSON-LD); vacío si no se conoce. */
function videoThumb(array $v): string {
    if (($v['provider'] ?? '') === 'youtube' && !empty($v['video_id'])) {
        return 'https://img.youtube.com/vi/' . $v['video_id'] . '/hqdefault.jpg';
    }
    return '';
}
