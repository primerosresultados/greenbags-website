<?php

/**
 * Wrapper de layout para el front público.
 *
 *   layoutStart([
 *       'title'        => 'Servicios',
 *       'description'  => '...',          // meta description / og
 *       'og_image'     => '/uploads/...', // og:image (cae a seo_default_image)
 *       'canonical'    => '/servicios',    // path o URL absoluta
 *       'current_slug' => 'servicios',
 *       'hide_chrome'  => false,           // true = no header ni footer (landing)
 *       'jsonld'       => [...],           // arrays adicionales para inyectar
 *   ]);
 *   // ... contenido de la página ...
 *   layoutEnd();
 *
 * Sin opciones, usa defaults razonables del sitio.
 */

function layoutStart(array $opts = []): void {
    $siteName = (string) getSetting('site_name', 'Mi Sitio');
    $title    = trim((string) ($opts['title'] ?? ''));
    $pageTitle = $title !== '' ? ($title . ' — ' . $siteName) : $siteName;

    $description = trim((string) ($opts['description'] ?? ''));
    if ($description === '') $description = trim((string) getSetting('business_description', ''));

    $ogImage = trim((string) ($opts['og_image'] ?? ''));
    if ($ogImage === '') $ogImage = trim((string) getSetting('seo_default_image', ''));

    $host  = $_SERVER['HTTP_HOST'] ?? '';
    $proto = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $base  = $host ? ($proto . '://' . $host) : '';
    $absolutize = function (string $p) use ($base): string {
        if ($p === '' || preg_match('#^https?://#', $p)) return $p;
        return $base . (str_starts_with($p, '/') ? $p : '/' . $p);
    };

    $canonical = trim((string) ($opts['canonical'] ?? ($_SERVER['REQUEST_URI'] ?? '/')));
    $canonical = $absolutize($canonical);
    $ogImageAbs = $ogImage !== '' ? $absolutize($ogImage) : '';

    $faviconPath = (string) getSetting('favicon_image', '');
    $faviconAbs  = $faviconPath ? __DIR__ . '/..' . $faviconPath : '';
    $faviconHref = ($faviconPath && @file_exists($faviconAbs))
        ? $faviconPath . '?v=' . @filemtime($faviconAbs) : '';

    $gaId    = trim((string) getSetting('ga_id', ''));
    $pixelId = trim((string) getSetting('pixel_id', ''));

    $hideChrome  = !empty($opts['hide_chrome']);
    $currentSlug = (string) ($opts['current_slug'] ?? '');
    $extraJsonLd = (array)  ($opts['jsonld'] ?? []);

    // Cargar el header/footer disponibles desde el caller.
    $GLOBALS['__layout_opts'] = $opts + ['hide_chrome' => $hideChrome];
    $h = htmlspecialchars(...);
    ?><!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= $h($pageTitle) ?></title>
<?php if ($description): ?>
<meta name="description" content="<?= $h($description) ?>">
<?php endif; ?>
<link rel="canonical" href="<?= $h($canonical) ?>">

<!-- Open Graph -->
<meta property="og:type" content="website">
<meta property="og:site_name" content="<?= $h($siteName) ?>">
<meta property="og:title" content="<?= $h($title !== '' ? $title : $siteName) ?>">
<?php if ($description): ?><meta property="og:description" content="<?= $h($description) ?>"><?php endif; ?>
<meta property="og:url" content="<?= $h($canonical) ?>">
<?php if ($ogImageAbs): ?><meta property="og:image" content="<?= $h($ogImageAbs) ?>"><?php endif; ?>

<!-- Twitter -->
<meta name="twitter:card" content="<?= $ogImageAbs ? 'summary_large_image' : 'summary' ?>">
<meta name="twitter:title" content="<?= $h($title !== '' ? $title : $siteName) ?>">
<?php if ($description): ?><meta name="twitter:description" content="<?= $h($description) ?>"><?php endif; ?>
<?php if ($ogImageAbs): ?><meta name="twitter:image" content="<?= $h($ogImageAbs) ?>"><?php endif; ?>

<?php if ($faviconHref): ?>
<link rel="icon" href="<?= $h($faviconHref) ?>">
<?php endif; ?>
<?php
// Cache-bust por mtime: cada cambio en el .css invalida la caché del navegador
// y del CDN sin obligar a hard-refresh manual al cliente.
$cssVer = function (string $path): string {
    $abs = __DIR__ . '/..' . $path;
    $mt  = @filemtime($abs);
    return $path . ($mt ? ('?v=' . $mt) : '');
};
?>
<link rel="stylesheet" href="<?= $h($cssVer('/assets/css/base.css')) ?>">
<link rel="stylesheet" href="<?= $h($cssVer('/assets/css/layout.css')) ?>">
<link rel="stylesheet" href="<?= $h($cssVer('/assets/css/components.css')) ?>">
<link rel="stylesheet" href="<?= $h($cssVer('/assets/css/shop.css')) ?>">
<link rel="stylesheet" href="<?= $h($cssVer('/assets/css/home.css')) ?>">
<?php if (!$hideChrome): ?>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap">
<link rel="stylesheet" href="<?= $h($cssVer('/assets/css/site_header.css')) ?>">
<?php endif; ?>
<?php
// Paleta editable desde admin → Configuración → "Colores de marca".
// Sobrescribe los tokens base de los componentes (botones, CTA, badges).
$themePrimary   = trim((string) getSetting('theme_primary', ''));
$themeSecondary = trim((string) getSetting('theme_secondary', ''));
if ($themePrimary !== '' || $themeSecondary !== ''):
    // Mezclador rápido para hover (oscurece ~10%).
    $darken = function (string $hex, float $pct = .1): string {
        if (!preg_match('/^#?([0-9a-f]{6})$/i', $hex, $m)) return $hex;
        $h = $m[1];
        $r = max(0, (int) hexdec(substr($h, 0, 2)) * (1 - $pct));
        $g = max(0, (int) hexdec(substr($h, 2, 2)) * (1 - $pct));
        $b = max(0, (int) hexdec(substr($h, 4, 2)) * (1 - $pct));
        return sprintf('#%02x%02x%02x', (int) $r, (int) $g, (int) $b);
    };
?>
<style>
:root {
<?php if ($themePrimary !== ''): ?>
    --brand-primary: <?= htmlspecialchars($themePrimary) ?>;
    --brand-primary-hover: <?= htmlspecialchars($darken($themePrimary, .12)) ?>;
    --color-primary: <?= htmlspecialchars($themePrimary) ?>;
    --color-primary-hover: <?= htmlspecialchars($darken($themePrimary, .12)) ?>;
    --color-accent: <?= htmlspecialchars($themePrimary) ?>;
<?php endif; ?>
<?php if ($themeSecondary !== ''): ?>
    --brand-secondary: <?= htmlspecialchars($themeSecondary) ?>;
    --brand-secondary-hover: <?= htmlspecialchars($darken($themeSecondary, .12)) ?>;
    --sh-accent: <?= htmlspecialchars($themeSecondary) ?>;
    --sh-accent-hover: <?= htmlspecialchars($darken($themeSecondary, .12)) ?>;
<?php endif; ?>
}
</style>
<?php endif; ?>

<?php
// Alto del logo (px) editable desde admin → Configuración → "Logo del Header".
// Alimenta las variables CSS que usa site_header.css (header y footer). Si no
// hay valor guardado, cae al default (mismo número que el fallback del CSS).
$logoClampH = function (string $key, int $def, int $min, int $max): int {
    $v = (int) getSetting($key, '');
    if ($v <= 0) $v = $def;
    return max($min, min($max, $v));
};
?>
<style>
:root {
    --logo-h-desktop: <?= $logoClampH('logo_height_desktop', 64, 40, 140) ?>px;
    --logo-h-mobile: <?= $logoClampH('logo_height_mobile', 48, 28, 90) ?>px;
    --footer-logo-h-desktop: <?= $logoClampH('footer_logo_height_desktop', 92, 40, 140) ?>px;
    --footer-logo-h-mobile: <?= $logoClampH('footer_logo_height_mobile', 74, 28, 100) ?>px;
}
</style>

<?php
// Escala tipográfica global editable desde admin → Configuración → "Tamaño del
// texto". Porcentaje 85–140 (100 = sin cambios):
//   - Títulos: escala la raíz rem (todos los títulos del sitio usan rem/clamp).
//   - Párrafos: escala --font-size-base (el texto de cuerpo hereda de acá).
// Se emite solo lo que cambie respecto del default para no tocar el render base.
$typeScaleClamp = function (string $key): int {
    $v = (int) getSetting($key, '100');
    if ($v <= 0) $v = 100;
    return max(85, min(140, $v));
};
$tsHead = $typeScaleClamp('type_scale_headings');
$tsBody = $typeScaleClamp('type_scale_body');
if ($tsHead !== 100 || $tsBody !== 100):
?>
<style>
<?php if ($tsBody !== 100): ?>
:root { --font-size-base: calc(15px * <?= $tsBody ?> / 100); }
<?php endif; ?>
<?php if ($tsHead !== 100): ?>
html { font-size: calc(100% * <?= $tsHead ?> / 100); }
<?php endif; ?>
</style>
<?php endif; ?>

<?php if ($gaId): ?>
<script async src="https://www.googletagmanager.com/gtag/js?id=<?= $h($gaId) ?>"></script>
<script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','<?= $h($gaId) ?>');</script>
<?php endif; ?>
<?php if ($pixelId): ?>
<script>!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','https://connect.facebook.net/en_US/fbevents.js');fbq('init','<?= $h($pixelId) ?>');fbq('track','PageView');</script>
<?php endif; ?>
<?php
if (function_exists('businessJsonLd') && getSetting('business_seo_jsonld', '1') === '1') {
    $ld = businessJsonLd();
    if ($ld) echo '<script type="application/ld+json">' . json_encode($ld, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) . "</script>\n";
}
foreach ($extraJsonLd as $extra) {
    if (is_array($extra)) echo '<script type="application/ld+json">' . json_encode($extra, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) . "</script>\n";
}
?>
</head>
<?php
    // Flag de "recién agregado al carrito/cotización": lo lee el JS del mini-*
    // para abrirlo automáticamente. Consumimos el flash acá (lo borra al leerlo).
    $cartJustAdded  = function_exists('flashGet') ? flashGet('cart_just_added')  : null;
    $quoteJustAdded = function_exists('flashGet') ? flashGet('quote_just_added') : null;
    $quotesOn       = function_exists('quotesEnabled') && quotesEnabled();
?>
<body<?= $cartJustAdded ? ' data-cart-open="1"' : '' ?><?= $quoteJustAdded ? ' data-quote-open="1"' : '' ?>>
<?php
    if (!$hideChrome) {
        $GLOBALS['currentSlug'] = $currentSlug;
        // Compatibilidad con site_header.php que lee $currentSlug del scope.
        // Aquí estamos en función, así que lo exponemos via include con variables.
        extract(['currentSlug' => $currentSlug]);
        require __DIR__ . '/../components/site_header.php';
        // Mini-drawer (slide-in). Quotes vs cart son mutuamente excluyentes:
        // si quotes está activo, el icono del header apunta a la cotización.
        if ($quotesOn) {
            require __DIR__ . '/../components/quote_drawer.php';
        } else {
            require __DIR__ . '/../components/cart_drawer.php';
        }
    }
}

function layoutEnd(): void {
    $opts = (array) ($GLOBALS['__layout_opts'] ?? []);
    $hideChrome = !empty($opts['hide_chrome']);
    if (!$hideChrome) {
        require __DIR__ . '/../components/site_footer.php';
        if (getSetting('whatsapp_float', '1') === '1') {
            require __DIR__ . '/../components/whatsapp_float.php';
        }
    }
    ?></body>
</html>
<?php
}
