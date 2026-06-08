<?php
/**
 * Home estándar (landing de venta).
 *
 * Diseñada como base reutilizable para sitios de tiendas chicas:
 *   1. Hero con título + subtítulo + 2 CTAs (Tienda + WhatsApp).
 *   2. Tira de beneficios (envíos / pago seguro / devoluciones / atención).
 *   3. Grilla de categorías destacadas (top 6 por sort_order).
 *   4. Productos destacados (featured=1, fallback a últimos publicados).
 *   5. Bloque de marca / storytelling (imagen + texto + CTA).
 *   6. Banda de CTA final.
 *   7. Contacto rápido (form de leads existente).
 *
 * Todo es opcional y configurable desde admin → Configuración → "Página de
 * inicio". Sin configuración, usa defaults razonables tomados del negocio.
 */

function homeSettings(): array {
    return [
        'hero_eyebrow'  => trim((string) getSetting('home_hero_eyebrow', 'Nueva colección')),
        'hero_title'    => trim((string) getSetting('home_hero_title', '')) ?: (string) getSetting('site_name', 'Bienvenidos'),
        'hero_subtitle' => trim((string) getSetting('home_hero_subtitle', '')) ?: trim((string) getSetting('business_description', 'Descubre nuestros productos cuidadosamente seleccionados.')),
        'hero_cta_label'=> trim((string) getSetting('home_hero_cta_label', 'Ver tienda')),
        'hero_cta_url'  => trim((string) getSetting('home_hero_cta_url', '/tienda')),
        'hero_image'    => trim((string) getSetting('home_hero_image', '')),
        'show_benefits' => getSetting('home_show_benefits', '1') === '1',
        'show_categories'=> getSetting('home_show_categories', '1') === '1',
        'show_featured' => getSetting('home_show_featured', '1') === '1',
        'show_story'    => getSetting('home_show_story', '1') === '1',
        'story_title'   => trim((string) getSetting('home_story_title', 'Hechos con dedicación')),
        'story_body'    => trim((string) getSetting('home_story_body', 'Atendemos cada pedido como si fuera para nosotros. Productos seleccionados, envíos rápidos y atención cercana.')),
        'story_cta_label'=> trim((string) getSetting('home_story_cta_label', 'Conócenos')),
        'story_cta_url' => trim((string) getSetting('home_story_cta_url', '/nosotros')),
        'story_image'   => trim((string) getSetting('home_story_image', '')),
        'cta_title'     => trim((string) getSetting('home_cta_title', 'Suscríbete y recibe nuestras novedades')),
        'cta_subtitle'  => trim((string) getSetting('home_cta_subtitle', 'Ofertas exclusivas, descuentos y lanzamientos en tu correo.')),
        'cta_label'     => trim((string) getSetting('home_cta_label', 'Suscríbete')),
    ];
}

/** Productos destacados; si no hay featured=1, cae a últimos publicados. */
function homeFeaturedProducts(int $limit = 8): array {
    $db = getDB();
    $sql = "SELECT p.*,
                   (SELECT m.file_path FROM product_images pi JOIN media_library m ON m.id = pi.media_id
                    WHERE pi.product_id = p.id ORDER BY pi.is_primary DESC, pi.sort_order LIMIT 1) AS img,
                   (SELECT m.alt FROM product_images pi JOIN media_library m ON m.id = pi.media_id
                    WHERE pi.product_id = p.id ORDER BY pi.is_primary DESC, pi.sort_order LIMIT 1) AS img_alt
            FROM products p
            WHERE p.status = 'published' AND p.featured = 1
            ORDER BY p.sort_order ASC, p.created_at DESC LIMIT ?";
    $st = $db->prepare($sql);
    $st->bindValue(1, $limit, PDO::PARAM_INT);
    $st->execute();
    $rows = $st->fetchAll();
    if ($rows) return $rows;
    return productsPublished(['perPage' => $limit, 'page' => 1]);
}

/**
 * Devuelve un ícono SVG inline elegido por palabras del nombre/slug.
 * Es el fallback "innovador" cuando una categoría no tiene imagen cargada.
 */
function homeCategoryIcon(string $name): string {
    $n = mb_strtolower(iconv('UTF-8', 'ASCII//TRANSLIT//IGNORE', $name) ?: $name);
    $map = [
        'ropa|remera|camisa|polera|buzo|jeans|pantal|abrigo|vestido|chomba|short' =>
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M16 3l-4 3-4-3-5 4 2 4 3-1v11h8V10l3 1 2-4-5-4z"/></svg>',
        'calzado|zapato|bot|zapatill|sandali|tenis' =>
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M2 17h20l-2 4H4l-2-4z"/><path d="M4 17V7c0-1 1-2 2-2h2v4l4 1 6 3v4"/></svg>',
        'accesorio|gorro|gorra|sombrero|bolso|cartera|mochila|bols|cintur|reloj|lente' =>
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M6 8h12l-1 13H7L6 8z"/><path d="M9 8V6a3 3 0 0 1 6 0v2"/></svg>',
        'belleza|perfume|cosmet|maquill|cuidado|skincare' =>
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><rect x="8" y="9" width="8" height="12" rx="1"/><rect x="10" y="3" width="4" height="6"/><line x1="8" y1="13" x2="16" y2="13"/></svg>',
        'hogar|casa|cocina|deco|mueble|jard' =>
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M3 11l9-8 9 8v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V11z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>',
        'tecno|electron|computad|celular|smart|gadget|audio|sonido' =>
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="3" width="14" height="18" rx="2"/><circle cx="12" cy="17" r="1"/></svg>',
        'deporte|fitness|gym|running|outdoor' =>
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M6 6L4 8l2 2 4-4 4 4 2-2-2-2"/><path d="M14 14l2 2-2 2-4-4-4 4-2-2 2-2"/></svg>',
        'nin|kids|bebe|jugu|infantil' =>
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M5 21v-2a4 4 0 0 1 4-4h6a4 4 0 0 1 4 4v2"/></svg>',
        'mascot|perro|gato|pet' =>
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><circle cx="5" cy="10" r="2"/><circle cx="9" cy="6" r="2"/><circle cx="15" cy="6" r="2"/><circle cx="19" cy="10" r="2"/><path d="M12 22c-4 0-6-3-6-6 0-2 2-4 6-4s6 2 6 4c0 3-2 6-6 6z"/></svg>',
    ];
    foreach ($map as $pat => $svg) {
        if (preg_match('~(' . $pat . ')~', $n)) return $svg;
    }
    // Genérico: shopping bag.
    return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4H6z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>';
}

/** Hue HSL estable derivado del slug, para gradientes únicos por categoría. */
function homeCategoryHue(string $slug): int {
    $crc = crc32($slug);
    return (int) ($crc % 360);
}

/** Categorías activas con imagen, hasta $limit, ordenadas por sort_order. */
function homeTopCategories(int $limit = 6): array {
    $db = getDB();
    $sql = "SELECT c.id, c.name, c.slug, c.description,
                   m.file_path AS img, m.alt AS img_alt
            FROM categories c
            LEFT JOIN media_library m ON m.id = c.image_id
            WHERE c.is_active = 1
            ORDER BY c.sort_order ASC, c.name ASC LIMIT ?";
    $st = $db->prepare($sql);
    $st->bindValue(1, $limit, PDO::PARAM_INT);
    $st->execute();
    return $st->fetchAll();
}

/** Renderiza la home completa. $error: error opcional del form de leads. */
function homeRender(string $error = ''): void {
    $s          = homeSettings();
    $featured   = $s['show_featured']   ? homeFeaturedProducts(8) : [];
    $categories = $s['show_categories'] ? homeTopCategories(6)    : [];
    $waUrl      = whatsappLink((string) getSetting('business_whatsapp', ''), (string) getSetting('business_whatsapp_text', ''));
    $siteName   = (string) getSetting('site_name', 'Mi Sitio');

    // Banners del hero. Si no hay ninguno en DB, generamos uno desde los
    // settings home_hero_* (compat con instalaciones que ya tenían hero único).
    $banners = function_exists('bannersGet') ? bannersGet('home_hero', true) : [];
    if (!$banners) {
        $banners = [[
            'eyebrow'    => $s['hero_eyebrow'],
            'title'      => $s['hero_title'],
            'subtitle'   => $s['hero_subtitle'],
            'image_path' => $s['hero_image'],
            'cta_label'  => $s['hero_cta_label'],
            'cta_url'    => $s['hero_cta_url'],
            'text_align' => 'left',
        ]];
    }

    layoutStart([
        'title'        => '',  // home: solo el site_name
        'description'  => $s['hero_subtitle'],
        'current_slug' => '',
    ]);
    ?>
<main class="home">

    <!-- ============ Hero (slider) ============ -->
    <section class="home-hero home-hero--slider<?= count($banners) > 1 ? ' home-hero--multi' : '' ?>" aria-roledescription="carousel" aria-label="Banners destacados">
        <div class="home-hero__viewport">
            <div class="home-hero__track">
                <?php foreach ($banners as $i => $b):
                    $img   = trim((string) ($b['image_path'] ?? ''));
                    $align = $b['text_align'] ?? 'left';
                ?>
                    <div class="home-hero__slide home-hero__slide--<?= htmlspecialchars($align) ?><?= $img ? ' home-hero__slide--image' : '' ?>"
                        <?php if ($img): ?>style="--hero-img: url('<?= htmlspecialchars($img) ?>');"<?php endif; ?>
                        role="group" aria-roledescription="slide" aria-label="<?= ($i + 1) ?> de <?= count($banners) ?>">
                        <div class="container home-hero__inner">
                            <div class="home-hero__copy">
                                <?php if (!empty($b['eyebrow'])): ?>
                                    <p class="home-hero__eyebrow"><?= htmlspecialchars($b['eyebrow']) ?></p>
                                <?php endif; ?>
                                <h1 class="home-hero__title"><?= htmlspecialchars((string) $b['title']) ?></h1>
                                <?php if (!empty($b['subtitle'])): ?>
                                    <p class="home-hero__subtitle"><?= htmlspecialchars($b['subtitle']) ?></p>
                                <?php endif; ?>
                                <div class="home-hero__cta">
                                    <?php if (!empty($b['cta_label']) && !empty($b['cta_url'])): ?>
                                        <a href="<?= htmlspecialchars($b['cta_url']) ?>" class="btn btn--lg"><?= htmlspecialchars($b['cta_label']) ?></a>
                                    <?php endif; ?>
                                    <?php if ($i === 0 && $waUrl): ?>
                                        <a href="<?= htmlspecialchars($waUrl) ?>" target="_blank" rel="noopener" class="btn btn--ghost btn--lg">Escribir por WhatsApp</a>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>

        <?php if (count($banners) > 1): ?>
            <button type="button" class="home-hero__nav home-hero__nav--prev" aria-label="Banner anterior">
                <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 6 9 12 15 18"/></svg>
            </button>
            <button type="button" class="home-hero__nav home-hero__nav--next" aria-label="Banner siguiente">
                <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 6 15 12 9 18"/></svg>
            </button>
            <div class="home-hero__dots" role="tablist" aria-label="Seleccionar banner">
                <?php foreach ($banners as $i => $b): ?>
                    <button type="button" class="home-hero__dot<?= $i === 0 ? ' is-active' : '' ?>" data-idx="<?= $i ?>" role="tab" aria-label="Banner <?= ($i + 1) ?>" aria-selected="<?= $i === 0 ? 'true' : 'false' ?>"></button>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>

        <script>
        (function(){
            var root = document.currentScript.parentElement;
            var track = root.querySelector('.home-hero__track');
            var slides = root.querySelectorAll('.home-hero__slide');
            if (!track || slides.length < 2) return;
            var prev = root.querySelector('.home-hero__nav--prev');
            var next = root.querySelector('.home-hero__nav--next');
            var dots = root.querySelectorAll('.home-hero__dot');
            var idx = 0;
            var timer = null;
            function go(i, manual){
                idx = ((i % slides.length) + slides.length) % slides.length;
                track.style.transform = 'translateX(' + (-idx * 100) + '%)';
                dots.forEach(function(d, k){
                    var on = k === idx;
                    d.classList.toggle('is-active', on);
                    d.setAttribute('aria-selected', on ? 'true' : 'false');
                });
                if (manual) restart();
            }
            function restart(){
                if (timer) clearInterval(timer);
                timer = setInterval(function(){ go(idx + 1); }, 7000);
            }
            if (prev) prev.addEventListener('click', function(){ go(idx - 1, true); });
            if (next) next.addEventListener('click', function(){ go(idx + 1, true); });
            dots.forEach(function(d, k){ d.addEventListener('click', function(){ go(k, true); }); });
            // Pausar autoplay al hover.
            root.addEventListener('mouseenter', function(){ if (timer) clearInterval(timer); });
            root.addEventListener('mouseleave', restart);
            // Keyboard.
            root.addEventListener('keydown', function(e){
                if (e.key === 'ArrowLeft')  { go(idx - 1, true); }
                if (e.key === 'ArrowRight') { go(idx + 1, true); }
            });
            restart();
        })();
        </script>
    </section>

    <?php if ($s['show_benefits']): ?>
    <!-- ============ Beneficios ============ -->
    <section class="home-benefits container">
        <?php foreach ([
            ['ico' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M1 3h15v13H1z"/><path d="M16 8h4l3 3v5h-7"/><circle cx="6" cy="19" r="2"/><circle cx="18" cy="19" r="2"/></svg>',
             'title' => 'Envíos rápidos', 'desc' => 'Despacho en 24-48 horas.'],
            ['ico' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="6" width="18" height="13" rx="2"/><line x1="3" y1="10" x2="21" y2="10"/></svg>',
             'title' => 'Pago seguro',    'desc' => 'Múltiples medios de pago.'],
            ['ico' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><polyline points="1 4 1 10 7 10"/><path d="M3.51 15a9 9 0 1 0 2.13-9.36L1 10"/></svg>',
             'title' => 'Cambios y devoluciones', 'desc' => 'Hasta 10 días.'],
            ['ico' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>',
             'title' => 'Atención al cliente', 'desc' => 'Te respondemos por WhatsApp.'],
        ] as $b): ?>
            <div class="home-benefit">
                <span class="home-benefit__ico"><?= $b['ico'] ?></span>
                <div>
                    <strong class="home-benefit__title"><?= $b['title'] ?></strong>
                    <p class="home-benefit__desc"><?= $b['desc'] ?></p>
                </div>
            </div>
        <?php endforeach; ?>
    </section>
    <?php endif; ?>

    <?php if ($s['show_categories'] && $categories): ?>
    <!-- ============ Categorías (bento) ============ -->
    <section class="home-cats container">
        <header class="home-section__head">
            <h2 class="home-section__title">Compra por categoría</h2>
            <a href="/tienda" class="home-section__link">Ver tienda →</a>
        </header>
        <div class="home-cats__bento">
            <?php foreach ($categories as $idx => $c):
                $hue   = homeCategoryHue((string) $c['slug']);
                $hasImg = !empty($c['img']);
                $tile  = 'home-cat home-cat--' . ($idx % 6); // patrón bento
            ?>
                <a href="/categoria/<?= htmlspecialchars($c['slug']) ?>" class="<?= $tile ?><?= $hasImg ? ' home-cat--has-img' : ' home-cat--no-img' ?>"
                    style="--cat-hue: <?= $hue ?>;">
                    <?php if ($hasImg): ?>
                        <img class="home-cat__img" src="<?= htmlspecialchars($c['img']) ?>" alt="<?= htmlspecialchars($c['img_alt'] ?: $c['name']) ?>" loading="lazy">
                    <?php else: ?>
                        <span class="home-cat__icon" aria-hidden="true"><?= homeCategoryIcon((string) $c['name']) ?></span>
                    <?php endif; ?>
                    <div class="home-cat__body">
                        <span class="home-cat__kicker">Categoría</span>
                        <span class="home-cat__name"><?= htmlspecialchars($c['name']) ?></span>
                        <span class="home-cat__cta">Explorar <span aria-hidden="true">→</span></span>
                    </div>
                </a>
            <?php endforeach; ?>
        </div>
    </section>
    <?php endif; ?>

    <?php if ($s['show_featured'] && $featured): ?>
    <!-- ============ Productos destacados ============ -->
    <section class="home-featured container">
        <header class="home-section__head">
            <h2 class="home-section__title">Lo más buscado</h2>
            <a href="/tienda" class="home-section__link">Ver todo →</a>
        </header>
        <div class="shop-grid">
            <?php foreach ($featured as $p):
                $eff  = productEffectivePrice($p);
                $sale = productIsOnSale($p);
                $url  = '/producto/' . htmlspecialchars($p['slug']);
            ?>
                <a class="shop-card" href="<?= $url ?>">
                    <div class="shop-card__img<?= empty($p['img']) ? ' shop-card__img--empty' : '' ?>">
                        <?php if (!empty($p['img'])): ?>
                            <img src="<?= htmlspecialchars($p['img']) ?>" alt="<?= htmlspecialchars($p['img_alt'] ?? $p['name']) ?>" loading="lazy">
                        <?php endif; ?>
                        <?php if ($sale): ?><span class="shop-card__badge">Oferta</span><?php endif; ?>
                    </div>
                    <div class="shop-card__body">
                        <h3 class="shop-card__name"><?= htmlspecialchars($p['name']) ?></h3>
                        <p class="shop-card__price">
                            <?php if (($p['type'] ?? 'simple') === 'variable'): ?>
                                <span class="shop-price__now">Desde <?= shopFormatPrice($p['min_price'] ?: $eff) ?></span>
                            <?php else: ?>
                                <?php if ($sale): ?><span class="shop-price__old"><?= shopFormatPrice($p['price']) ?></span> <?php endif; ?>
                                <span class="shop-price__now"><?= shopFormatPrice($eff) ?></span>
                            <?php endif; ?>
                        </p>
                    </div>
                </a>
            <?php endforeach; ?>
        </div>
    </section>
    <?php endif; ?>

    <?php if ($s['show_story']): ?>
    <!-- ============ Storytelling / marca ============ -->
    <section class="home-story container">
        <div class="home-story__media">
            <?php if ($s['story_image']): ?>
                <img src="<?= htmlspecialchars($s['story_image']) ?>" alt="" loading="lazy">
            <?php else: ?>
                <div class="home-story__media--empty"></div>
            <?php endif; ?>
        </div>
        <div class="home-story__copy">
            <h2 class="home-story__title"><?= htmlspecialchars($s['story_title']) ?></h2>
            <p class="home-story__body"><?= nl2br(htmlspecialchars($s['story_body'])) ?></p>
            <?php if ($s['story_cta_label'] && $s['story_cta_url']): ?>
                <a href="<?= htmlspecialchars($s['story_cta_url']) ?>" class="btn btn--ghost"><?= htmlspecialchars($s['story_cta_label']) ?></a>
            <?php endif; ?>
        </div>
    </section>
    <?php endif; ?>

    <!-- ============ Banda CTA final (newsletter) ============ -->
    <?php $subOk = flashGet('subscribe_ok'); $subErr = flashGet('subscribe_err'); ?>
    <section class="home-cta" id="suscripcion">
        <!-- Decoración: sobres + @ flotantes difuminados (sólo visual). -->
        <div class="home-cta__decor" aria-hidden="true">
            <svg class="home-cta__icn home-cta__icn--1" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></svg>
            <svg class="home-cta__icn home-cta__icn--2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></svg>
            <svg class="home-cta__icn home-cta__icn--3" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></svg>
            <svg class="home-cta__icn home-cta__icn--4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></svg>
            <svg class="home-cta__icn home-cta__icn--5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="4"/><path d="M16 12v1.5a2.5 2.5 0 0 0 5 0V12a9 9 0 1 0-3.5 7.1"/></svg>
            <svg class="home-cta__icn home-cta__icn--6" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><circle cx="12" cy="12" r="9"/><circle cx="12" cy="12" r="4"/><path d="M16 12v1.5a2.5 2.5 0 0 0 5 0V12a9 9 0 1 0-3.5 7.1"/></svg>
            <svg class="home-cta__icn home-cta__icn--7" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2"><path d="M3 8l9 6 9-6v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8z"/><path d="M3 8l9-5 9 5"/></svg>
        </div>
        <div class="container home-cta__inner">
            <div class="home-cta__copy">
                <h2 class="home-cta__title"><?= htmlspecialchars($s['cta_title']) ?></h2>
                <?php if ($s['cta_subtitle']): ?>
                    <p class="home-cta__sub"><?= htmlspecialchars($s['cta_subtitle']) ?></p>
                <?php endif; ?>
            </div>

            <?php if ($subOk): ?>
                <p class="home-cta__alert home-cta__alert--ok"><?= htmlspecialchars($subOk) ?></p>
            <?php else: ?>
                <form method="post" action="/" class="home-cta__form" autocomplete="on">
                    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                    <input type="hidden" name="action" value="subscribe">
                    <input type="hidden" name="form_started" value="<?= time() ?>">
                    <input type="text" name="website" value="" tabindex="-1" autocomplete="off" style="position:absolute;left:-9999px;opacity:0;pointer-events:none;" aria-hidden="true">
                    <label class="visually-hidden" for="subscribe-email">Tu email</label>
                    <input id="subscribe-email" type="email" name="email" placeholder="tucorreo@ejemplo.com" required class="home-cta__input">
                    <button type="submit" class="btn btn--lg btn--invert home-cta__btn"><?= htmlspecialchars($s['cta_label']) ?></button>
                </form>
                <?php if ($subErr): ?>
                    <p class="home-cta__alert home-cta__alert--err"><?= htmlspecialchars($subErr) ?></p>
                <?php endif; ?>
            <?php endif; ?>
        </div>
    </section>

</main>
    <?php
    layoutEnd();
}
