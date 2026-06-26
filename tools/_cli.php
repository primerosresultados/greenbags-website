<?php
/**
 * Bootstrap mínimo para scripts CLI de tooling (importador de catálogo).
 * Carga config + solo los libs necesarios (sin sesión, sin headers HTTP).
 *
 * Uso: require __DIR__ . '/_cli.php';  (al inicio de cada tool)
 */
if (PHP_SAPI !== 'cli') {
    http_response_code(403);
    exit("Solo CLI.\n");
}

$root = dirname(__DIR__);
$config = $root . '/config.php';
if (!file_exists($config)) {
    fwrite(STDERR, "Falta config.php — corré la instalación primero.\n");
    exit(1);
}

require $config;
require $root . '/lib/db.php';
require $root . '/lib/helpers.php';
require $root . '/lib/media_library.php';   // → image_pipeline.php
require $root . '/lib/catalog.php';
require $root . '/lib/variations.php';
require $root . '/lib/product_extras.php';
require $root . '/lib/import_remote.php';

error_reporting(E_ALL);
ini_set('display_errors', '1');
date_default_timezone_set(defined('APP_TIMEZONE') ? APP_TIMEZONE : 'America/Santiago');

/** Lee --flag=value de $argv. */
function cliOpt(string $name, $default = null) {
    foreach ($GLOBALS['argv'] ?? [] as $a) {
        if (str_starts_with($a, "--$name=")) return substr($a, strlen($name) + 3);
        if ($a === "--$name") return true;
    }
    return $default;
}

/** Carpeta de salida para los JSON normalizados. */
function cliOutDir(): string {
    $dir = __DIR__ . '/out';
    if (!is_dir($dir)) @mkdir($dir, 0755, true);
    return $dir;
}

function cliLog(string $msg): void {
    fwrite(STDOUT, $msg . "\n");
}
