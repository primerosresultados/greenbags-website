<?php
/**
 * Scraper de esquinablanca.cl (plataforma Bsale).
 *
 * Enumera productos desde el sitemap (/sitemap.xml tiene las URLs /product/...),
 * y de cada página extrae el/los bloques JSON-LD `Product` (name, sku, price,
 * image, description). Las categorías se toman del BreadcrumbList JSON-LD.
 *
 * Una página puede traer varios Product (variantes de tamaño) → cada uno es una
 * row independiente (producto simple con su propio SKU/precio).
 *
 * Salida: tools/out/esquinablanca.json
 * Flags:  --limit=N  (corta en N páginas de producto, para pruebas)
 */
require __DIR__ . '/_cli.php';

const EB_BASE    = 'https://www.esquinablanca.cl';
const EB_SITEMAP = EB_BASE . '/sitemap.xml';

$limit = (int) cliOpt('limit', 0);

cliLog("Scrapeando esquinablanca.cl (Bsale)…");

// 1) Sitemap → URLs de producto únicas.
$sm = importHttpGet(EB_SITEMAP);
if (!$sm['ok']) { cliLog("! No pude leer el sitemap: " . ($sm['error'] ?? '')); exit(1); }
preg_match_all('~https://www\.esquinablanca\.cl/product/[A-Za-z0-9\-_%]+~', $sm['body'], $m);
$urls = array_values(array_unique($m[0] ?? []));
cliLog("  productos en sitemap: " . count($urls));
if ($limit > 0) $urls = array_slice($urls, 0, $limit);

// 2) Cada producto → JSON-LD.
$rows = [];
$done = 0;
foreach ($urls as $url) {
    $done++;
    $res = importHttpGet($url);
    if (!$res['ok']) { cliLog("  ! [$done] fallo $url"); usleep(300000); continue; }

    $blocks = ebExtractLdJson($res['body']);
    $cats   = ebBreadcrumbCategories($blocks);
    $prods  = ebProducts($blocks);

    foreach ($prods as $p) {
        if ($p['sku'] === '' || $p['name'] === '') continue;
        $rows[] = [
            'source'            => 'esquinablanca',
            'sku'               => 'EB-' . $p['sku'],
            'name'              => $p['name'],
            'price'             => $p['price'],
            'currency'          => $p['currency'] ?: 'CLP',
            'description'       => $p['description'],
            'short_description' => '',
            'image_urls'        => $p['images'],
            'source_categories' => $cats,
            'permalink'         => $url,
        ];
    }
    if ($done % 10 === 0) cliLog("  $done/" . count($urls) . " páginas (rows: " . count($rows) . ")");
    usleep(300000); // cortesía ~3 req/s
}

$out = cliOutDir() . '/esquinablanca.json';
file_put_contents($out, json_encode($rows, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
cliLog("OK → $out  (" . count($rows) . " productos de " . count($urls) . " páginas)");

/* ----------------- helpers de parseo JSON-LD ----------------- */

/** Devuelve todos los objetos JSON-LD de la página (aplana @graph). */
function ebExtractLdJson(string $html): array {
    if (!preg_match_all('~<script[^>]*type=["\']application/ld\+json["\'][^>]*>(.*?)</script>~is', $html, $mm)) {
        return [];
    }
    $out = [];
    foreach ($mm[1] as $json) {
        $data = json_decode(trim($json), true);
        if (!is_array($data)) continue;
        $items = isset($data['@graph']) && is_array($data['@graph']) ? $data['@graph']
               : (array_is_list($data) ? $data : [$data]);
        foreach ($items as $it) {
            if (is_array($it)) $out[] = $it;
        }
    }
    return $out;
}

/** @return array{name:string,sku:string,price:float,currency:string,description:string,images:string[]}[] */
function ebProducts(array $blocks): array {
    $prods = [];
    foreach ($blocks as $b) {
        $type = $b['@type'] ?? '';
        $type = is_array($type) ? implode(',', $type) : (string) $type;
        if (stripos($type, 'Product') === false) continue;

        $offers = $b['offers'] ?? [];
        if (isset($offers['@type']) || isset($offers['price'])) $offers = [$offers];
        $price = 0.0; $cur = '';
        foreach ((array) $offers as $of) {
            if (!is_array($of)) continue;
            if (isset($of['price'])) { $price = (float) $of['price']; $cur = (string) ($of['priceCurrency'] ?? ''); break; }
        }

        $imgs = [];
        $img = $b['image'] ?? [];
        foreach ((is_string($img) ? [$img] : (array) $img) as $u) {
            $u = trim((string) $u);
            if ($u !== '') $imgs[] = $u;
        }

        $prods[] = [
            'name'        => ebClean((string) ($b['name'] ?? '')),
            'sku'         => trim((string) ($b['sku'] ?? ($b['mpn'] ?? ''))),
            'price'       => $price,
            'currency'    => $cur,
            'description' => ebClean((string) ($b['description'] ?? '')),
            'images'      => array_values(array_unique($imgs)),
        ];
    }
    return $prods;
}

/** Nombres de categorías desde los BreadcrumbList (excluye Inicio/Home). */
function ebBreadcrumbCategories(array $blocks): array {
    $cats = [];
    foreach ($blocks as $b) {
        $type = $b['@type'] ?? '';
        $type = is_array($type) ? implode(',', $type) : (string) $type;
        if (stripos($type, 'BreadcrumbList') === false) continue;
        foreach ((array) ($b['itemListElement'] ?? []) as $el) {
            $name = '';
            if (isset($el['name'])) $name = (string) $el['name'];
            elseif (isset($el['item']['name'])) $name = (string) $el['item']['name'];
            $name = ebClean($name);
            if ($name === '') continue;
            $low = mb_strtolower($name);
            if (in_array($low, ['inicio', 'home', 'esquina blanca', 'productos'], true)) continue;
            $cats[$name] = true;
        }
    }
    return array_keys($cats);
}

/** Decodifica entidades HTML, quita tags y normaliza espacios. */
function ebClean(string $s): string {
    $s = html_entity_decode($s, ENT_QUOTES | ENT_HTML5, 'UTF-8');
    $s = strip_tags($s);
    $s = preg_replace('/\s+/u', ' ', $s);
    return trim($s);
}
