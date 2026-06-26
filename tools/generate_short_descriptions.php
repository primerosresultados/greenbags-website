<?php
/**
 * Genera descripciones cortas atractivas (short_description) para cada producto
 * del catálogo a partir de su nombre + descripción cruda del seed 041.
 *
 * No inventa datos: extrae tipo de producto, color, medida, unidades y material
 * desde el nombre/descripción reales, y arma una frase de venta con un gancho
 * comercial (despacho inmediato, atención a urgencias, compra por mayor...).
 *
 * Uso:  php tools/generate_short_descriptions.php > migrations/043_greenbags_short_descriptions.sql
 *
 * Idempotente: la migración solo escribe donde short_description está vacío,
 * por SKU (clave natural). Re-ejecutable sin pisar ediciones del admin.
 */

$seed = __DIR__ . '/../migrations/041_greenbags_catalog_seed.sql';
if (!is_file($seed)) {
    fwrite(STDERR, "No existe $seed\n");
    exit(1);
}
$sql = file_get_contents($seed);

/* ---- Parseo de los INSERT INTO products ... VALUES (...) ---- */
// Extraemos sku (campo 2), name (campo 5) y description (campo 8).
// Los valores son strings SQL con comillas simples escapadas como ''.
function sqlUnescape(string $s): string {
    return str_replace("''", "'", $s);
}

$rows = [];
$re = "/INSERT INTO products \([^)]*\) VALUES \((.*?)\)\s*\n\s*ON DUPLICATE/s";
if (!preg_match_all($re, $sql, $matches)) {
    fwrite(STDERR, "No se encontraron productos.\n");
    exit(1);
}
foreach ($matches[1] as $tuple) {
    // Tokenizamos respetando comillas simples (con '' como escape).
    $vals = [];
    $cur = '';
    $inStr = false;
    $len = strlen($tuple);
    for ($i = 0; $i < $len; $i++) {
        $ch = $tuple[$i];
        if ($inStr) {
            if ($ch === "'") {
                if ($i + 1 < $len && $tuple[$i + 1] === "'") { $cur .= "''"; $i++; }
                else { $inStr = false; }
            } else { $cur .= $ch; }
        } else {
            if ($ch === "'") { $inStr = true; }
            elseif ($ch === ',') { $vals[] = trim($cur); $cur = ''; }
            else { $cur .= $ch; }
        }
    }
    $vals[] = trim($cur);
    // Campos: 0 type,1 sku,2 gtin,3 mpn,4 name,5 slug,6 short_description,7 description...
    if (count($vals) < 8) continue;
    $sku  = sqlUnescape($vals[1]);
    $name = sqlUnescape($vals[4]);
    $desc = sqlUnescape($vals[7]);
    if ($sku === '' || $name === '') continue;
    $rows[$sku] = ['name' => $name, 'desc' => $desc];
}

fwrite(STDERR, "Productos parseados: " . count($rows) . "\n");

/* ---- Helpers de generación ---- */

function titleCaseName(string $name): string {
    // Toma la parte antes del primer "(" o " x " como nombre legible.
    $base = $name;
    if (preg_match('/^(.*?)\s*\(/u', $name, $m)) $base = $m[1];
    $base = preg_replace('/\s+x\s+\d.*$/iu', '', $base);
    $base = trim($base);
    // Pasa de MAYÚSCULAS a Capitalización por palabra, dejando unidades como "3oz".
    $words = preg_split('/\s+/u', mb_strtolower($base));
    $small = ['de','con','y','para','la','el','en','sin','a','por'];
    $out = [];
    foreach ($words as $i => $w) {
        if ($w === '') continue;
        // Mantener tokens con números/medidas tal cual (3oz, 8oz, 36x40).
        if (preg_match('/\d/u', $w)) { $out[] = $w; continue; }
        if ($i > 0 && in_array($w, $small, true)) { $out[] = $w; continue; }
        $out[] = mb_strtoupper(mb_substr($w, 0, 1)) . mb_substr($w, 1);
    }
    return implode(' ', $out);
}

function extractUnits(string $name): ?string {
    // (25 unidades) | x 500 uds | x 2.000 sachets | x300uds
    if (preg_match('/\(\s*([\d\.]+)\s*unidades?\s*\)/iu', $name, $m)) return formatPack($m[1], 'unidades');
    if (preg_match('/x\s*([\d\.]+)\s*(uds?|unidades?|sachets?|bolsas?|rollos?|pliegos?|metros?)/iu', $name, $m)) {
        $u = mb_strtolower($m[2]);
        $u = preg_match('/^ud/', $u) ? 'unidades' : rtrim($u, 's') . 's';
        return formatPack($m[1], $u === 'unidadess' ? 'unidades' : $u);
    }
    return null;
}

function formatPack(string $num, string $unit): string {
    $n = (int) str_replace('.', '', $num);
    if ($n <= 1) return "unidad individual";
    $nf = number_format($n, 0, ',', '.');
    return "pack de $nf $unit";
}

function extractMeasure(string $name): ?string {
    if (preg_match('/(\d+(?:[\.,]\d+)?\s?oz)/iu', $name, $m)) return trim($m[1]);
    if (preg_match('/(\d+\s?x\s?\d+(?:\s?cms?)?)/iu', $name, $m)) return trim($m[1]);
    if (preg_match('/(\d+\s?cms?)\b/iu', $name, $m)) return trim($m[1]);
    if (preg_match('/(\d+\s?(?:ml|cc|lt|litros?))/iu', $name, $m)) return trim($m[1]);
    return null;
}

// Uso por tipo de producto (keyword en nombre). Primer match gana.
$USE_CASES = [
    '/vaso/iu'                      => 'Perfecto para servir bebidas frías o calientes en cafeterías, food trucks y eventos',
    '/(porta|envase|contenedor|bandeja|pote|caja\s*alim)/iu' => 'Hecho para delivery y comida para llevar, resiste sin derrames ni filtraciones',
    '/^tapa|\btapa para\b/iu'       => 'El complemento ideal para tus vasos: cierra firme y evita derrames en cada despacho',
    '/bolsa.*(camiseta|riñon)/iu'   => 'Pensada para entregar compras y pedidos en almacenes, tiendas y ferias',
    '/bolsa.*basura/iu'             => 'Resistente para la basura y residuos de tu local, oficina o cocina',
    '/bolsa/iu'                     => 'Ideal para empacar y entregar productos en tu local, tienda o delivery',
    '/(sachet|salsa|condimento)/iu' => 'Práctico para acompañar pedidos y mantener tus salsas frescas y selladas',
    '/(servilleta|toalla)/iu'       => 'Suaves y absorbentes, listas para tu mesa, baño o estación de servicio',
    '/(cuchar|tenedor|cubierto|palito|bombilla|revolved)/iu' => 'Resistentes y desechables, perfectos para servir sin complicaciones',
    '/(film|alusa|aluminio|papel)/iu' => 'Conserva y protege tus alimentos para cocina, almacenaje y delivery',
    '/(guante|gorro|cofia|mascar|delantal)/iu' => 'Insumo de higiene esencial para cocinas, locales de comida y manipulación de alimentos',
    '/(detergente|cloro|limpia|aseo|desinfect|jabon)/iu' => 'Mantén tu local impecable: rendidor y eficaz para la limpieza diaria',
    '/(caja|carton)/iu'             => 'Resistente para embalar, transportar y despachar tus productos con seguridad',
    '/(removed|agitador|stirrer)/iu'=> 'Detalle práctico para tu barra de café o estación de bebidas',
];

$ECO = '/compost|biodegrad|kraft|ca(ñ|n)a de az(ú|u)car|bagazo|cartón|carton|reciclad|ecol(ó|o)g|bamb(ú|u)|madera/iu';

// Ganchos comerciales (rotan por índice para evitar repetición).
$HOOKS = [
    'Despacho inmediato a todo Chile y atención por WhatsApp para tus urgencias.',
    'Stock disponible para entrega rápida y precios especiales por mayor.',
    'Atención inmediata y despacho el mismo día: nunca te quedes sin insumos.',
    'Compra al por mayor con asesoría directa y envíos a todo el país.',
    'Entrega ágil y soporte cercano para que tu negocio no se detenga.',
];

function buildShort(string $name, string $desc, int $idx, array $useCases, string $ecoRe, array $hooks): string {
    $pretty  = titleCaseName($name);
    $units   = extractUnits($name);
    $measure = extractMeasure($name);

    // Frase de uso
    $use = 'Insumo confiable para tu negocio gastronómico, retail o de servicios';
    foreach ($useCases as $re => $phrase) {
        if (preg_match($re, $name)) { $use = $phrase; break; }
    }

    $eco = preg_match($ecoRe, $name . ' ' . $desc) ? ' Producto compostable y amigable con el medio ambiente.' : '';

    // Encabezado: nombre + medida + pack
    $head = $pretty;
    $bits = [];
    if ($measure) $bits[] = $measure;
    if ($units)   $bits[] = $units;
    if ($bits)    $head .= ' (' . implode(', ', $bits) . ')';

    $hook = $hooks[$idx % count($hooks)];

    $text = "$head. $use.$eco $hook";
    // Limpieza y tope a 500 chars (VARCHAR(500)).
    $text = preg_replace('/\s+/u', ' ', trim($text));
    if (mb_strlen($text) > 500) $text = mb_substr($text, 0, 497) . '...';
    return $text;
}

/* ---- Emisión de la migración ---- */
$lines = [];
$lines[] = "-- 043_greenbags_short_descriptions.sql";
$lines[] = "-- Descripciones cortas atractivas generadas con tools/generate_short_descriptions.php";
$lines[] = "-- Idempotente: solo rellena short_description vacío, por SKU. No pisa ediciones manuales del admin.";
$lines[] = "";

$i = 0;
foreach ($rows as $sku => $r) {
    $short = buildShort($r['name'], $r['desc'], $i, $USE_CASES, $ECO, $HOOKS);
    $skuE   = str_replace("'", "''", $sku);
    $shortE = str_replace("'", "''", $short);
    $lines[] = "UPDATE products SET short_description = '$shortE' "
             . "WHERE sku = '$skuE' AND (short_description IS NULL OR short_description = '');";
    $i++;
}

echo implode("\n", $lines) . "\n";
fwrite(STDERR, "Descripciones generadas: $i\n");
