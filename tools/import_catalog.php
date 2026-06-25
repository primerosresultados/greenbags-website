<?php
/**
 * Importa a la base los productos normalizados de tools/out/*.json.
 * Publica los productos, descarga imágenes y asigna categorías (mapeadas).
 *
 * Idempotente: re-correr actualiza por SKU, no duplica (imágenes por seo_name).
 *
 * Uso:
 *   php tools/import_catalog.php                 # importa esquinablanca + tugou
 *   php tools/import_catalog.php --source=tugou  # solo una fuente
 *   php tools/import_catalog.php --limit=20      # corta en N productos (prueba)
 *   php tools/import_catalog.php --no-images     # omite descarga de imágenes
 */
require __DIR__ . '/_cli.php';

$only       = (string) cliOpt('source', '');
$limit      = (int) cliOpt('limit', 0);
$noImages   = (bool) cliOpt('no-images', false);
$publishAll = (bool) cliOpt('publish-all', false); // fuerza published aunque price=0

$sources = $only !== '' ? [$only] : ['esquinablanca', 'tugou'];
$folderId = importEnsureFolder('Importados');
cliLog("Carpeta media 'Importados' → id " . ($folderId ?? 'null'));

$summary = ['created' => 0, 'updated' => 0, 'no_image' => 0, 'errors' => 0, 'images' => 0];
$count = 0;

foreach ($sources as $src) {
    $file = cliOutDir() . "/$src.json";
    if (!is_file($file)) { cliLog("! No existe $file (corré el scraper primero). Salto."); continue; }
    $rows = json_decode((string) file_get_contents($file), true);
    if (!is_array($rows)) { cliLog("! $file inválido. Salto."); continue; }

    cliLog("\n=== Importando $src (" . count($rows) . " productos) ===");
    foreach ($rows as $row) {
        if ($limit > 0 && $count >= $limit) break 2;
        $count++;

        if ($noImages) $row['image_urls'] = [];
        if ($publishAll) $row['force_status'] = 'published';
        $r = importUpsertProduct($row, $folderId);

        if (empty($r['ok'])) {
            $summary['errors']++;
            cliLog(sprintf("  [%d] ✗ %s — %s", $count, mb_substr($row['name'] ?? '?', 0, 50), $r['error'] ?? ''));
            continue;
        }
        $summary[$r['action']]++;
        $summary['images'] += (int) $r['images'];
        if ((int) $r['images'] === 0) $summary['no_image']++;

        if ($count % 10 === 0 || ($r['images'] ?? 0) > 0) {
            cliLog(sprintf("  [%d] %s #%d \"%s\" (img:%d)",
                $count, $r['action'], $r['id'], mb_substr($row['name'] ?? '', 0, 45), $r['images']));
        }
    }
}

cliLog("\n========== RESUMEN ==========");
cliLog("  creados:    {$summary['created']}");
cliLog("  actualizados:{$summary['updated']}");
cliLog("  imágenes:   {$summary['images']}");
cliLog("  sin imagen: {$summary['no_image']}");
cliLog("  errores:    {$summary['errors']}");
cliLog("=============================");
