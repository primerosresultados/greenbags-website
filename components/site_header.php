<?php
/**
 * Header público con 3 variantes seleccionables desde admin (setting
 * `header_style`):
 *   - classic:   logo izq · menú horizontal · acciones derecha (default).
 *   - centered:  logo centrado arriba · menú centrado debajo · acciones flotantes.
 *   - hamburger: sólo logo + carrito + hamburguesa; el menú vive en el drawer
 *                en TODOS los tamaños de pantalla (estilo agencia/marca premium).
 *
 * En todas las variantes:
 *   - Topbar opcional con contacto + socials.
 *   - CTA WhatsApp y badge de carrito (cartCount()) visibles.
 *   - Drawer mobile siempre disponible (desktop tambien en `hamburger`).
 *
 * Variables esperadas (opcionales):
 *   $currentSlug : slug de la página actual para marcar activo.
 *
 * Requiere <link rel="stylesheet" href="/assets/css/site_header.css"> en <head>.
 */
$currentSlug = $currentSlug ?? '';
$siteName    = (string) getSetting('site_name', 'Mi Sitio');
$logoPath    = (string) getSetting('logo_image', '');
$logoExists  = $logoPath !== '' && @file_exists(__DIR__ . '/..' . $logoPath);
$headerStyle = (string) getSetting('header_style', 'classic');
if (!in_array($headerStyle, ['classic', 'centered', 'hamburger'], true)) $headerStyle = 'classic';

$bizPhone     = trim((string) getSetting('business_phone', ''));
$bizEmail     = trim((string) getSetting('business_email', ''));
$bizHours     = trim((string) getSetting('business_hours', ''));
// Topbar (contacto + horario + socials) ocultable desde settings.
$showTopbar   = getSetting('header_show_topbar', '1') === '1';

$menu      = publishedPagesMenu();
$socials   = socialLinks();
$quotesOn  = function_exists('quotesEnabled') && quotesEnabled();
$cartCount = $quotesOn
    ? (function_exists('quoteCount') ? quoteCount() : 0)
    : (function_exists('cartCount') ? cartCount() : 0);

// Categorías activas para el dropdown del menú (flat). Si la tabla no existe
// todavía (instalación nueva sin tienda), categoryList lanza y devolvemos []
// para no romper el header.
$cats = [];
if (function_exists('categoryList')) {
    try { $cats = categoryList(true); } catch (Throwable $e) { $cats = []; }
}

// "Contacto" se renderiza alineado a la derecha. Lo separamos del resto para
// que no quede mezclado entre las páginas alfabéticas.
$pageContact = null;
$pagesMain   = [];
foreach ($menu as $p) {
    if ($pageContact === null && (string) $p['slug'] === 'contacto') {
        $pageContact = $p;
    } else {
        $pagesMain[] = $p;
    }
}

// Path actual para marcar "activo" en items que no usan $currentSlug (Tienda
// y categorías viven en /tienda y /categoria/{slug} y shop_front no setea
// current_slug).
$reqPathActive = trim(parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/', '/');
$isShopActive  = $reqPathActive === 'tienda';
$isCatActive   = str_starts_with($reqPathActive, 'categoria/');

$socialIcon = function (string $key): string {
    return [
        'social_facebook'  => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M22 12a10 10 0 1 0-11.6 9.9v-7H8v-2.9h2.4V9.8c0-2.4 1.4-3.7 3.6-3.7 1 0 2.1.2 2.1.2v2.3h-1.2c-1.2 0-1.5.7-1.5 1.5V12h2.6l-.4 2.9h-2.2v7A10 10 0 0 0 22 12z"/></svg>',
        'social_instagram' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="17.5" cy="6.5" r="1" fill="currentColor"/></svg>',
        'social_linkedin'  => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M4.98 3.5a2.5 2.5 0 1 1 0 5 2.5 2.5 0 0 1 0-5zM3 9h4v12H3zM9 9h3.8v1.7h.1c.5-.9 1.8-1.9 3.7-1.9 4 0 4.7 2.6 4.7 6V21h-4v-5.4c0-1.3 0-3-1.8-3s-2.1 1.4-2.1 2.9V21H9z"/></svg>',
        'social_youtube'   => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M23 7.2s-.2-1.6-.9-2.3c-.8-.9-1.8-.9-2.2-1C16.7 3.6 12 3.6 12 3.6s-4.7 0-7.9.3c-.4.1-1.4.1-2.2 1C1.2 5.6 1 7.2 1 7.2S.8 9 .8 10.9v1.8C.8 14.5 1 16.3 1 16.3s.2 1.6.9 2.3c.8.9 1.9.9 2.4 1 1.7.2 7.7.3 7.7.3s4.7 0 7.9-.3c.4-.1 1.4-.1 2.2-1 .7-.7.9-2.3.9-2.3s.2-1.8.2-3.6v-1.8c0-1.9-.2-3.7-.2-3.7zM9.7 14.6V8l6.2 3.3-6.2 3.3z"/></svg>',
        'social_tiktok'    => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M19.5 8.6a6.7 6.7 0 0 1-4-1.3v7.4a5.7 5.7 0 1 1-5.7-5.7c.3 0 .6 0 .9.1v3a2.8 2.8 0 1 0 2 2.7V2h2.9a4 4 0 0 0 4 4v2.6z"/></svg>',
        'social_x'         => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M18.9 2H22l-7.4 8.5L23 22h-6.8l-5.3-7-6.1 7H1.6l8-9.1L1 2h6.9l4.8 6.4L18.9 2zm-2.4 18h1.9L7.7 4H5.6l10.9 16z"/></svg>',
    ][$key] ?? '';
};

// SVGs reutilizables (carrito / cotización).
$cartSvg = $quotesOn
    ? '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="9" y1="14" x2="15" y2="14"/><line x1="9" y1="18" x2="13" y2="18"/></svg>'
    : '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.7 13.4a2 2 0 0 0 2 1.6h9.7a2 2 0 0 0 2-1.6L23 6H6"/></svg>';
$cartHref  = $quotesOn ? '/cotizacion' : '/carrito';
$cartBtnId = $quotesOn ? 'header-quote-btn' : 'header-cart-btn';
$cartLabel = $quotesOn ? 'Ver cotización' : 'Ver carrito';
$drawerBtnId = $quotesOn ? 'drawer-quote-btn' : 'drawer-cart-btn';
$drawerLabel = $quotesOn ? 'Cotización' : 'Carrito';

// Marca + acciones se reusan entre variantes via render helpers locales.
$renderBrand = function (string $cls = 'site-navbar__brand') use ($logoExists, $logoPath, $siteName) {
    echo '<a href="/" class="' . $cls . '" aria-label="' . htmlspecialchars($siteName) . '">';
    if ($logoExists) {
        echo '<img src="' . htmlspecialchars($logoPath) . '" alt="' . htmlspecialchars($siteName) . '">';
    } else {
        echo '<span class="site-navbar__brand-text">' . htmlspecialchars($siteName) . '</span>';
    }
    echo '</a>';
};

$renderMenu = function () use ($pagesMain, $pageContact, $cats, $currentSlug, $isShopActive, $isCatActive) {
    $isHome = $currentSlug === '' && !$isShopActive && !$isCatActive;
    echo '<nav class="site-navbar__menu" aria-label="Principal">';
    echo '<a href="/" class="' . ($isHome ? 'is-active' : '') . '">Inicio</a>';
    echo '<a href="/tienda" class="' . ($isShopActive ? 'is-active' : '') . '">Tienda</a>';

    if ($cats) {
        echo '<div class="site-navbar__dropdown" data-dropdown>'
           . '<button type="button" class="site-navbar__dropdown-toggle' . ($isCatActive ? ' is-active' : '') . '"'
           . ' aria-haspopup="true" aria-expanded="false">'
           . 'Categorías'
           . '<svg class="site-navbar__dropdown-caret" viewBox="0 0 24 24" width="14" height="14" fill="none"'
           . ' stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">'
           . '<polyline points="6 9 12 15 18 9"/></svg>'
           . '</button>'
           . '<div class="site-navbar__dropdown-panel" role="menu">';
        foreach ($cats as $cat) {
            echo '<a href="/categoria/' . htmlspecialchars($cat['slug']) . '" role="menuitem">'
               . htmlspecialchars($cat['name']) . '</a>';
        }
        echo '</div></div>';
    }

    foreach ($pagesMain as $p) {
        echo '<a href="/' . htmlspecialchars($p['slug']) . '" class="'
           . ($currentSlug === $p['slug'] ? 'is-active' : '') . '">'
           . htmlspecialchars($p['title']) . '</a>';
    }

    // Botón "Catálogo" (CTA secundario) a la izquierda de Contacto → grilla de
    // productos (vive en /catalogo tras el swap Inicio/Tienda).
    $isCatalogActive = trim(parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/', '/') === 'catalogo';
    echo '<a href="/catalogo" class="site-navbar__menu-cta' . ($isCatalogActive ? ' is-active' : '') . '">Catálogo</a>';

    if ($pageContact) {
        $cls = 'site-navbar__menu-right' . ($currentSlug === $pageContact['slug'] ? ' is-active' : '');
        echo '<a href="/' . htmlspecialchars($pageContact['slug']) . '" class="' . $cls . '">'
           . htmlspecialchars($pageContact['title']) . '</a>';
    }

    echo '</nav>';
};

// SVGs reutilizables (favoritos + cuenta) — quedan a la izquierda del carrito.
$favSvg = '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>';
$accSvg = '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>';

$renderActions = function () use ($cartCount, $cartSvg, $cartHref, $cartBtnId, $cartLabel, $favSvg, $accSvg) {
    echo '<div class="site-navbar__actions">';
    echo '<a href="/favoritos" class="site-navbar__iconbtn site-navbar__iconbtn--fav" aria-label="Mis favoritos">'
       . $favSvg . '</a>';
    echo '<a href="/mi-cuenta" class="site-navbar__iconbtn site-navbar__iconbtn--acc" aria-label="Mi cuenta">'
       . $accSvg . '</a>';
    echo '<a href="' . $cartHref . '" id="' . $cartBtnId . '" class="site-navbar__cart" aria-label="' . htmlspecialchars($cartLabel) . ' (' . (int) $cartCount . ' ítems)">'
       . $cartSvg
       . ($cartCount > 0 ? '<span class="site-navbar__cart-badge">' . (int) $cartCount . '</span>' : '')
       . '</a>';
    echo '<button type="button" class="site-navbar__burger" id="site-burger" aria-label="Abrir menú" aria-controls="site-drawer" aria-expanded="false">'
       . '<span></span><span></span><span></span></button>';
    echo '</div>';
};

// Announce bar editable (texto promo + link opcional).
$annOn    = getSetting('announce_enabled', '0') === '1';
$annText  = trim((string) getSetting('announce_text', ''));
$annLabel = trim((string) getSetting('announce_link_label', ''));
$annUrl   = trim((string) getSetting('announce_link_url', ''));
$annBg    = trim((string) getSetting('announce_bg', '#0f172a'));
$annFg    = trim((string) getSetting('announce_fg', '#ffffff'));
?>
<header class="site-header" id="site-header" data-style="<?= htmlspecialchars($headerStyle) ?>">

    <?php if ($annOn && $annText !== ''): ?>
        <div class="site-announce" style="--ann-bg: <?= htmlspecialchars($annBg) ?>; --ann-fg: <?= htmlspecialchars($annFg) ?>;">
            <div class="site-announce__inner">
                <span class="site-announce__text"><?= htmlspecialchars($annText) ?></span>
                <?php if ($annUrl !== '' && $annLabel !== ''): ?>
                    <a href="<?= htmlspecialchars($annUrl) ?>" class="site-announce__link"><?= htmlspecialchars($annLabel) ?> <span aria-hidden="true">→</span></a>
                <?php endif; ?>
            </div>
        </div>
    <?php endif; ?>

    <?php if ($showTopbar && ($bizPhone || $bizEmail || $bizHours || $socials)): ?>
    <div class="site-topbar">
        <div class="site-topbar__inner">
            <div class="site-topbar__contact">
                <?php if ($bizPhone): ?>
                    <a href="tel:<?= htmlspecialchars(preg_replace('/\s+/', '', $bizPhone)) ?>">
                        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6A19.79 19.79 0 0 1 2.12 4.18 2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7 2 2 0 0 1 1.72 2.03z"/></svg>
                        <span><?= htmlspecialchars($bizPhone) ?></span>
                    </a>
                <?php endif; ?>
                <?php if ($bizEmail): ?>
                    <a href="mailto:<?= htmlspecialchars($bizEmail) ?>">
                        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                        <span><?= htmlspecialchars($bizEmail) ?></span>
                    </a>
                <?php endif; ?>
                <?php if ($bizHours): ?>
                    <span class="site-topbar__hours">
                        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                        <span><?= htmlspecialchars($bizHours) ?></span>
                    </span>
                <?php endif; ?>
            </div>
            <?php if ($socials): ?>
                <div class="site-topbar__socials">
                    <?php foreach ($socials as $key => $s): ?>
                        <a href="<?= htmlspecialchars($s['url']) ?>" target="_blank" rel="noopener" aria-label="<?= htmlspecialchars($s['label']) ?>">
                            <?= $socialIcon($key) ?>
                        </a>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>
        </div>
    </div>
    <?php endif; ?>

    <?php if ($headerStyle === 'centered'): ?>
        <!-- Variante: logo centrado arriba, menú centrado debajo. -->
        <div class="site-navbar site-navbar--centered">
            <div class="site-navbar__inner">
                <div class="site-navbar__row site-navbar__row--brand">
                    <?php $renderBrand('site-navbar__brand site-navbar__brand--center'); ?>
                </div>
                <div class="site-navbar__row site-navbar__row--menu">
                    <?php $renderMenu(); ?>
                    <?php $renderActions(); ?>
                </div>
            </div>
        </div>
    <?php else: ?>
        <!-- Variantes: classic / hamburger -->
        <div class="site-navbar">
            <div class="site-navbar__inner">
                <?php $renderBrand(); ?>
                <?php if ($headerStyle === 'classic') $renderMenu(); ?>
                <?php $renderActions(); ?>
            </div>
        </div>
    <?php endif; ?>

    <!-- Drawer: usado siempre en mobile, y en desktop cuando el estilo es 'hamburger'. -->
    <div class="site-drawer__backdrop" id="site-drawer-backdrop" aria-hidden="true"></div>
    <aside class="site-drawer" id="site-drawer" aria-hidden="true">
        <div class="site-drawer__head">
            <a href="/" class="site-drawer__brand">
                <?php if ($logoExists): ?>
                    <img src="<?= htmlspecialchars($logoPath) ?>" alt="<?= htmlspecialchars($siteName) ?>">
                <?php else: ?>
                    <span><?= htmlspecialchars($siteName) ?></span>
                <?php endif; ?>
            </a>
            <button type="button" class="site-drawer__close" id="site-drawer-close" aria-label="Cerrar menú">
                <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
            </button>
        </div>

        <nav class="site-drawer__menu" aria-label="Principal (mobile)">
            <a href="/" class="<?= ($currentSlug === '' && !$isShopActive && !$isCatActive) ? 'is-active' : '' ?>">Inicio</a>
            <a href="/tienda" class="<?= $isShopActive ? 'is-active' : '' ?>">Tienda</a>
            <?php if ($cats): ?>
                <details class="site-drawer__sub"<?= $isCatActive ? ' open' : '' ?>>
                    <summary>
                        <span>Categorías</span>
                        <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="6 9 12 15 18 9"/></svg>
                    </summary>
                    <div class="site-drawer__sub-list">
                        <?php foreach ($cats as $cat): ?>
                            <a href="/categoria/<?= htmlspecialchars($cat['slug']) ?>"><?= htmlspecialchars($cat['name']) ?></a>
                        <?php endforeach; ?>
                    </div>
                </details>
            <?php endif; ?>
            <?php foreach ($pagesMain as $p): ?>
                <a href="/<?= htmlspecialchars($p['slug']) ?>" class="<?= $currentSlug === $p['slug'] ? 'is-active' : '' ?>">
                    <?= htmlspecialchars($p['title']) ?>
                </a>
            <?php endforeach; ?>
            <?php if ($pageContact): ?>
                <a href="/<?= htmlspecialchars($pageContact['slug']) ?>" class="<?= $currentSlug === $pageContact['slug'] ? 'is-active' : '' ?>">
                    <?= htmlspecialchars($pageContact['title']) ?>
                </a>
            <?php endif; ?>
            <a href="/favoritos" class="<?= $currentSlug === 'favoritos' ? 'is-active' : '' ?>">Favoritos</a>
            <a href="/mi-cuenta" class="<?= $currentSlug === 'mi-cuenta' ? 'is-active' : '' ?>">Mi cuenta</a>
            <a href="<?= htmlspecialchars($cartHref) ?>" class="site-drawer__cart" id="<?= htmlspecialchars($drawerBtnId) ?>">
                <span><?= htmlspecialchars($drawerLabel) ?></span>
                <?php if ($cartCount > 0): ?><span class="site-drawer__cart-badge"><?= (int) $cartCount ?></span><?php endif; ?>
            </a>
        </nav>

        <?php if ($bizPhone || $bizEmail): ?>
            <div class="site-drawer__contact">
                <?php if ($bizPhone): ?>
                    <a href="tel:<?= htmlspecialchars(preg_replace('/\s+/', '', $bizPhone)) ?>"><?= htmlspecialchars($bizPhone) ?></a>
                <?php endif; ?>
                <?php if ($bizEmail): ?>
                    <a href="mailto:<?= htmlspecialchars($bizEmail) ?>"><?= htmlspecialchars($bizEmail) ?></a>
                <?php endif; ?>
            </div>
        <?php endif; ?>

        <?php if ($socials): ?>
            <div class="site-drawer__socials">
                <?php foreach ($socials as $key => $s): ?>
                    <a href="<?= htmlspecialchars($s['url']) ?>" target="_blank" rel="noopener" aria-label="<?= htmlspecialchars($s['label']) ?>">
                        <?= $socialIcon($key) ?>
                    </a>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </aside>
</header>

<script>
(function(){
    var hdr = document.getElementById('site-header');
    var b   = document.getElementById('site-burger');
    var d   = document.getElementById('site-drawer');
    var bk  = document.getElementById('site-drawer-backdrop');
    var cl  = document.getElementById('site-drawer-close');

    // Sombra sutil al hacer scroll: feedback de "sticky" sin saltos.
    if (hdr) {
        var onScroll = function(){
            if (window.scrollY > 8) hdr.classList.add('is-scrolled');
            else hdr.classList.remove('is-scrolled');
        };
        onScroll();
        window.addEventListener('scroll', onScroll, { passive: true });
    }

    if (b && d && bk) {
        var open  = function(){ d.classList.add('is-open'); bk.classList.add('is-open'); b.classList.add('is-open'); b.setAttribute('aria-expanded','true'); d.setAttribute('aria-hidden','false'); document.body.style.overflow='hidden'; };
        var close = function(){ d.classList.remove('is-open'); bk.classList.remove('is-open'); b.classList.remove('is-open'); b.setAttribute('aria-expanded','false'); d.setAttribute('aria-hidden','true'); document.body.style.overflow=''; };
        b.addEventListener('click', function(){ d.classList.contains('is-open') ? close() : open(); });
        bk.addEventListener('click', close);
        if (cl) cl.addEventListener('click', close);
        document.addEventListener('keydown', function(e){ if (e.key === 'Escape') close(); });
    }

    // Dropdown "Categorías" (desktop): toggle por click, cierra fuera/Escape.
    document.querySelectorAll('[data-dropdown]').forEach(function(dd){
        var t = dd.querySelector('.site-navbar__dropdown-toggle');
        if (!t) return;
        var closeDd = function(){ dd.classList.remove('is-open'); t.setAttribute('aria-expanded','false'); };
        var openDd  = function(){ dd.classList.add('is-open');    t.setAttribute('aria-expanded','true');  };
        t.addEventListener('click', function(e){
            e.stopPropagation();
            dd.classList.contains('is-open') ? closeDd() : openDd();
        });
        document.addEventListener('click', function(e){
            if (!dd.contains(e.target)) closeDd();
        });
        document.addEventListener('keydown', function(e){ if (e.key === 'Escape') closeDd(); });
    });
})();
</script>
