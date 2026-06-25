<?php
/**
 * Scraper de tugou.cl (WooCommerce) vía Store API pública.
 *   GET /wp-json/wc/store/v1/products?per_page=100&page=N   (sin auth)
 *
 * Salida: tools/out/tugou.json  (array de rows normalizadas)
 * Flags:  --limit=N   (corta en N productos, para pruebas)
 *
 * Nota: tugou oculta precios (price=0) e imágenes (images=[]) en la API.
 * Se importan igual: nombre, SKU, categorías y descripción.
 */
require __DIR__ . '/_cli.php';

const TUGOU_API = 'https://tugou.cl/wp-json/wc/store/v1/products';

$limit = (int) cliOpt('limit', 0);
$perPage = 100;
$page = 1;
$rows = [];

cliLog("Scrapeando tugou.cl (WooCommerce Store API)…");

while (true) {
    $url = TUGOU_API . '?per_page=' . $perPage . '&page=' . $page;
    $res = importHttpGet($url, ['headers' => ['Accept: application/json']]);
    if (!$res['ok']) { cliLog("  ! Error página $page: " . ($res['error'] ?? '')); break; }

    $items = json_decode($res['body'], true);
    if (!is_array($items) || !$items) break;

    foreach ($items as $it) {
        $sku = trim((string) ($it['sku'] ?? ''));
        if ($sku === '') $sku = 'wc-' . (int) ($it['id'] ?? 0); // fallback
        $name = html_entity_decode((string) ($it['name'] ?? ''), ENT_QUOTES | ENT_HTML5, 'UTF-8');

        // Precio: prices.price viene en "minor units" (entero); CLP minor_unit=0.
        $pr = $it['prices'] ?? [];
        $minor = (int) ($pr['currency_minor_unit'] ?? 0);
        $rawPrice = (string) ($pr['price'] ?? '0');
        $price = $minor > 0 ? ((float) $rawPrice) / (10 ** $minor) : (float) $rawPrice;

        $imgs = [];
        foreach ((array) ($it['images'] ?? []) as $im) {
            $src = trim((string) ($im['src'] ?? ''));
            if ($src !== '') $imgs[] = $src;
        }

        $cats = [];
        foreach ((array) ($it['categories'] ?? []) as $c) {
            $cn = trim((string) ($c['name'] ?? ''));
            if ($cn !== '') $cats[] = $cn;
        }

        $rows[] = [
            'source'            => 'tugou',
            'sku'               => 'TG-' . $sku,
            'name'              => $name,
            'price'             => $price,
            'currency'          => (string) ($pr['currency_code'] ?? 'CLP'),
            'description'       => strip_tags((string) ($it['description'] ?? '')),
            'short_description' => strip_tags((string) ($it['short_description'] ?? '')),
            'image_urls'        => $imgs,
            'source_categories' => $cats,
            'permalink'         => (string) ($it['permalink'] ?? ''),
        ];

        if ($limit > 0 && count($rows) >= $limit) break 2;
    }

    cliLog("  página $page: " . count($items) . " items (acumulado " . count($rows) . ")");
    if (count($items) < $perPage) break;
    $page++;
    usleep(250000); // cortesía
}

$out = cliOutDir() . '/tugou.json';
file_put_contents($out, json_encode($rows, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
cliLog("OK → $out  (" . count($rows) . " productos)");
