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
    $layout = (string) getSetting('home_categories_layout', 'bento');
    if (!in_array($layout, ['bento', 'grid', 'carousel', 'masonry'], true)) {
        $layout = 'bento';
    }
    return [
        'hero_eyebrow'  => trim((string) getSetting('home_hero_eyebrow', 'Nueva colección')),
        'hero_title'    => trim((string) getSetting('home_hero_title', '')) ?: (string) getSetting('site_name', 'Bienvenidos'),
        'hero_subtitle' => trim((string) getSetting('home_hero_subtitle', '')) ?: trim((string) getSetting('business_description', 'Descubre nuestros productos cuidadosamente seleccionados.')),
        'hero_cta_label'=> trim((string) getSetting('home_hero_cta_label', 'Ver tienda')),
        'hero_cta_url'  => trim((string) getSetting('home_hero_cta_url', '/tienda')),
        'hero_image'    => trim((string) getSetting('home_hero_image', '')),
        'show_benefits' => getSetting('home_show_benefits', '1') === '1',
        'show_categories'=> getSetting('home_show_categories', '1') === '1',
        'categories_layout' => $layout,
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
        'show_clients'  => getSetting('home_show_clients', '0') === '1',
        'clients_title' => trim((string) getSetting('home_clients_title', 'Nuestros clientes')),
        'clients_names' => array_values(array_filter(array_map(
            'trim',
            explode('|', (string) getSetting('home_clients_names', ''))
        ), fn($v) => $v !== '')),
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
    // Carrusel y masonry lucen mejor con más tiles; bento/grid se quedan en 6.
    $catLimit   = in_array($s['categories_layout'], ['carousel', 'masonry'], true) ? 12 : 6;
    $categories = $s['show_categories'] ? homeTopCategories($catLimit) : [];
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
                    <div class="home-hero__slide home-hero__slide--<?= htmlspecialchars($align) ?><?= $img ? ' home-hero__slide--image' : '' ?><?= $i === 0 ? ' is-active' : '' ?>"
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
                                <ul class="home-hero__points">
                                    <li><span class="home-hero__point-ico" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M1 3h15v13H1z"/><path d="M16 8h4l3 3v5h-7"/><circle cx="6" cy="19" r="2"/><circle cx="18" cy="19" r="2"/></svg></span>Despacho en 24-48 hs</li>
                                    <li><span class="home-hero__point-ico" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M9 12l2 2 4-4"/><circle cx="12" cy="12" r="9"/></svg></span>Packaging certificado</li>
                                    <li><span class="home-hero__point-ico" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="5"/><path d="M8.5 13L7 22l5-3 5 3-1.5-9"/></svg></span>+15 años de experiencia</li>
                                </ul>
                                <div class="home-hero__cta">
                                    <?php if (!empty($b['cta_label']) && !empty($b['cta_url'])):
                                        // Los CTA de cotización abren el modal "Cotiza tu packaging"
                                        // en vez de navegar (así el hero muestra la imagen completa).
                                        $ctaIsQuote = in_array(trim((string) $b['cta_url']), ['/cotizacion', '/cotización', '#cotizar'], true);
                                    ?>
                                        <?php if ($ctaIsQuote): ?>
                                            <button type="button" class="btn btn--lg" data-cotizar><?= htmlspecialchars($b['cta_label']) ?></button>
                                        <?php else: ?>
                                            <a href="<?= htmlspecialchars($b['cta_url']) ?>" class="btn btn--lg"><?= htmlspecialchars($b['cta_label']) ?></a>
                                        <?php endif; ?>
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

            <?php if (count($banners) > 1): ?>
                <div class="home-hero__controls">
                    <span class="home-hero__count" aria-hidden="true">
                        <span class="home-hero__count-cur">01</span><span class="home-hero__count-sep">/</span><span class="home-hero__count-tot"><?= sprintf('%02d', count($banners)) ?></span>
                    </span>
                    <div class="home-hero__navdots">
                        <button type="button" class="home-hero__nav home-hero__nav--prev" aria-label="Banner anterior">
                            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 6 9 12 15 18"/></svg>
                        </button>
                        <div class="home-hero__dots" role="tablist" aria-label="Seleccionar banner">
                            <?php foreach ($banners as $i => $b): ?>
                                <button type="button" class="home-hero__dot<?= $i === 0 ? ' is-active' : '' ?>" data-idx="<?= $i ?>" role="tab" aria-label="Banner <?= ($i + 1) ?>" aria-selected="<?= $i === 0 ? 'true' : 'false' ?>"><span class="home-hero__dot-fill"></span></button>
                            <?php endforeach; ?>
                        </div>
                        <button type="button" class="home-hero__nav home-hero__nav--next" aria-label="Banner siguiente">
                            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 6 15 12 9 18"/></svg>
                        </button>
                    </div>
                </div>
            <?php endif; ?>
        </div>

        <!-- El formulario de cotización ya no vive fijo en el hero (tapaba las
             imágenes de los banners). Ahora se abre en un modal desde cualquier
             botón "Solicitar cotización" (ver #cotizar-modal al final del main). -->

        <script>
        (function(){
            var root = document.currentScript.parentElement;
            var track = root.querySelector('.home-hero__track');
            var slides = root.querySelectorAll('.home-hero__slide');
            if (!track || slides.length < 2) return;
            // is-ready habilita las animaciones de entrada (sin JS todo queda visible).
            root.classList.add('is-ready');
            var prev  = root.querySelector('.home-hero__nav--prev');
            var next  = root.querySelector('.home-hero__nav--next');
            var dots  = root.querySelectorAll('.home-hero__dot');
            var curEl = root.querySelector('.home-hero__count-cur');
            var INTERVAL = 6000;
            root.style.setProperty('--hero-interval', (INTERVAL / 1000) + 's');
            var idx = 0, timer = null, paused = false;
            function pad(n){ return (n < 10 ? '0' : '') + n; }
            // Reinicia la animación de "relleno" del dot activo (barra de progreso).
            function resetFill(){
                dots.forEach(function(d){
                    var f = d.querySelector('.home-hero__dot-fill');
                    if (!f) return;
                    f.style.animation = 'none';
                    void f.offsetWidth;          // fuerza reflow → reinicia el keyframe
                    f.style.animation = '';
                });
            }
            function go(i, manual){
                idx = ((i % slides.length) + slides.length) % slides.length;
                track.style.transform = 'translateX(' + (-idx * 100) + '%)';
                slides.forEach(function(s, k){ s.classList.toggle('is-active', k === idx); });
                dots.forEach(function(d, k){
                    var on = k === idx;
                    d.classList.toggle('is-active', on);
                    d.setAttribute('aria-selected', on ? 'true' : 'false');
                });
                if (curEl) curEl.textContent = pad(idx + 1);
                resetFill();
                if (manual) restart();
            }
            function restart(){
                if (timer) clearInterval(timer);
                if (paused) return;
                timer = setInterval(function(){ go(idx + 1); }, INTERVAL);
            }
            if (prev) prev.addEventListener('click', function(){ go(idx - 1, true); });
            if (next) next.addEventListener('click', function(){ go(idx + 1, true); });
            dots.forEach(function(d, k){ d.addEventListener('click', function(){ go(k, true); }); });
            // Pausar autoplay al hover (y pausar la barra de progreso vía CSS).
            root.addEventListener('mouseenter', function(){ paused = true; root.classList.add('is-paused'); if (timer) clearInterval(timer); });
            root.addEventListener('mouseleave', function(){ paused = false; root.classList.remove('is-paused'); go(idx); restart(); });
            // Teclado.
            root.addEventListener('keydown', function(e){
                if (e.key === 'ArrowLeft')  { go(idx - 1, true); }
                if (e.key === 'ArrowRight') { go(idx + 1, true); }
            });
            go(0);
            restart();
        })();
        </script>
    </section>

    <?php if ($s['show_story']): ?>
    <!-- ============ Storytelling / marca (va justo después del hero) ============
         Panel de marca: foto con badge flotante + copy con kicker y bullets con
         íconos. Los textos (título/cuerpo/CTA) siguen siendo editables vía
         settings; los bullets y el badge son fijos del template (como los
         beneficios). Reveal-on-scroll progresivo: solo si hay JS (.js-reveal). -->
    <section class="home-story container" id="home-story">
        <div class="home-story__panel">
            <div class="home-story__media" data-reveal>
                <?php if ($s['story_image']): ?>
                    <img src="<?= htmlspecialchars($s['story_image']) ?>" alt="" loading="lazy">
                <?php else: ?>
                    <div class="home-story__media--empty"></div>
                <?php endif; ?>
                <span class="home-story__media-frame" aria-hidden="true"></span>
                <div class="home-story__chip" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M1 3h15v13H1z"/><path d="M16 8h4l3 3v5h-7"/><circle cx="6" cy="19" r="2"/><circle cx="18" cy="19" r="2"/></svg>
                    <span>Entregas confiables</span>
                </div>
                <div class="home-story__badge" aria-hidden="true">
                    <span class="home-story__badge-num">+15</span>
                    <span class="home-story__badge-txt">años de<br>experiencia</span>
                </div>
            </div>
            <div class="home-story__copy">
                <p class="home-story__kicker" data-reveal>
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0Z"/><circle cx="12" cy="10" r="3"/></svg>
                    Empresa chilena
                </p>
                <h2 class="home-story__title" data-reveal style="--reveal-delay:.08s"><?= htmlspecialchars($s['story_title']) ?></h2>
                <p class="home-story__body" data-reveal style="--reveal-delay:.16s"><?= nl2br(htmlspecialchars($s['story_body'])) ?></p>
                <ul class="home-story__feats">
                    <?php foreach ([
                        ['ico' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>',
                         'title' => 'Atención personalizada', 'desc' => 'Rapidez y trato directo con quienes toman las decisiones.', 'delay' => '.22s'],
                        ['ico' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/></svg>',
                         'title' => 'Responsabilidad ambiental', 'desc' => 'Productos certificados y opciones sustentables a tu escala.', 'delay' => '.3s'],
                        ['ico' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M6 22V4a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v18"/><path d="M6 12H4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-9a2 2 0 0 0-2-2h-2"/><path d="M10 6h4"/><path d="M10 10h4"/><path d="M10 14h4"/><path d="M10 18h4"/></svg>',
                         'title' => 'Para cada canal', 'desc' => 'Horeca, retail, industria y emprendedores.', 'delay' => '.38s'],
                    ] as $f): ?>
                        <li class="home-story__feat" data-reveal style="--reveal-delay:<?= $f['delay'] ?>">
                            <span class="home-story__feat-ico" aria-hidden="true"><?= $f['ico'] ?></span>
                            <span class="home-story__feat-txt">
                                <strong><?= $f['title'] ?></strong>
                                <span><?= $f['desc'] ?></span>
                            </span>
                        </li>
                    <?php endforeach; ?>
                </ul>
                <?php if ($s['story_cta_label'] && $s['story_cta_url']): ?>
                    <a href="<?= htmlspecialchars($s['story_cta_url']) ?>" class="btn home-story__cta" data-reveal style="--reveal-delay:.46s">
                        <span><?= htmlspecialchars($s['story_cta_label']) ?></span>
                        <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                    </a>
                <?php endif; ?>
            </div>
        </div>
        <script>
        (function(){
            var root = document.getElementById('home-story');
            if (!root || !('IntersectionObserver' in window)) return;
            // El estado oculto solo se activa con esta clase → sin JS todo queda visible.
            root.classList.add('js-reveal');
            var io = new IntersectionObserver(function(entries){
                entries.forEach(function(e){
                    if (e.isIntersecting) { e.target.classList.add('is-in'); io.unobserve(e.target); }
                });
            }, { threshold: .15, rootMargin: '0px 0px -8% 0px' });
            root.querySelectorAll('[data-reveal]').forEach(function(el){ io.observe(el); });
        })();
        </script>
    </section>
    <?php endif; ?>

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

    <?php if ($s['show_categories'] && $categories):
        $layout    = $s['categories_layout'];
        $catCount  = count($categories);
        // Para bento usamos los modificadores de span; para otros layouts no.
        $sectionMod = 'home-cats--' . $layout;
        // Bento ajusta su patrón según cuántos tiles hay (evita celdas gigantes
        // cuando hay menos de 6 categorías). Con >= 6 usamos el patrón base.
        $bentoBucket = ($layout === 'bento' && $catCount < 6)
            ? 'home-cats__bento--n' . $catCount
            : '';
        // En carrusel duplicamos la lista para el efecto de marquesina infinita.
        $renderList  = $layout === 'carousel' ? array_merge($categories, $categories) : $categories;
    ?>
    <!-- ============ Categorías ============ -->
    <section class="home-cats <?= $sectionMod ?> container" data-layout="<?= htmlspecialchars($layout) ?>">
        <header class="home-section__head">
            <h2 class="home-section__title">Nuestras Categorías</h2>
            <a href="/catalogo" class="home-section__link">Ver catálogo →</a>
        </header>

        <?php if ($layout === 'carousel'): ?>
            <div class="home-cats__carousel">
                <div class="home-cats__track" tabindex="0" role="region" aria-label="Categorías (deslizar)">
                    <?php foreach ($renderList as $idx => $c):
                        $hue    = homeCategoryHue((string) $c['slug']);
                        $hasImg = !empty($c['img']);
                        $dup    = $idx >= $catCount;
                    ?>
                        <a href="/categoria/<?= htmlspecialchars($c['slug']) ?>" class="home-cat home-cat--carousel<?= $hasImg ? ' home-cat--has-img' : ' home-cat--no-img' ?>"
                            style="--cat-hue: <?= $hue ?>;"<?= $dup ? ' aria-hidden="true" tabindex="-1"' : '' ?>>
                            <?php if ($hasImg): ?>
                                <img class="home-cat__img" src="<?= htmlspecialchars($c['img']) ?>" alt="<?= htmlspecialchars($c['img_alt'] ?: $c['name']) ?>" loading="lazy">
                            <?php else: ?>
                                <span class="home-cat__icon" aria-hidden="true"><?= homeCategoryIcon((string) $c['name']) ?></span>
                            <?php endif; ?>
                            <div class="home-cat__body">
                                <span class="home-cat__kicker">Categoría</span>
                                <span class="home-cat__name"><?= htmlspecialchars($c['name']) ?></span>
                            </div>
                        </a>
                    <?php endforeach; ?>
                </div>
                <button type="button" class="home-cats__nav home-cats__nav--prev" aria-label="Anterior">
                    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 6 9 12 15 18"/></svg>
                </button>
                <button type="button" class="home-cats__nav home-cats__nav--next" aria-label="Siguiente">
                    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 6 15 12 9 18"/></svg>
                </button>
            </div>

            <script>
            (function(){
                var root  = document.currentScript.parentElement;
                var car   = root.querySelector('.home-cats__carousel');
                var track = car && car.querySelector('.home-cats__track');
                if (!car || !track) return;
                var prev  = car.querySelector('.home-cats__nav--prev');
                var next  = car.querySelector('.home-cats__nav--next');
                function step(){
                    var item = track.querySelector('.home-cat');
                    if (!item) return track.clientWidth * 0.9;
                    var w = item.getBoundingClientRect().width;
                    var gap = parseFloat(getComputedStyle(track).gap) || 0;
                    return (w + gap) * Math.max(1, Math.floor(track.clientWidth / (w + gap)) - 1);
                }
                if (prev) prev.addEventListener('click', function(){ track.scrollBy({ left: -step(), behavior: 'smooth' }); });
                if (next) next.addEventListener('click', function(){ track.scrollBy({ left:  step(), behavior: 'smooth' }); });
                // Loop infinito: la lista está duplicada (1ª y 2ª mitad iguales).
                // Cuando el scroll llega al final, saltamos al equivalente de la
                // 1ª mitad sin animación (el contenido es idéntico, así que el
                // salto pasa desapercibido).
                var jumping = false;
                track.addEventListener('scroll', function(){
                    if (jumping) return;
                    var max  = track.scrollWidth - track.clientWidth;
                    var half = Math.floor(track.scrollWidth / 2);
                    if (track.scrollLeft >= max - 2) {
                        jumping = true;
                        track.scrollLeft = track.scrollLeft - half;
                        requestAnimationFrame(function(){ jumping = false; });
                    } else if (track.scrollLeft <= 0) {
                        jumping = true;
                        track.scrollLeft = half;
                        requestAnimationFrame(function(){ jumping = false; });
                    }
                }, { passive: true });
            })();
            </script>
        <?php else: ?>
            <?php
                $containerCls = 'home-cats__bento';
                if ($layout === 'grid')    $containerCls = 'home-cats__grid';
                if ($layout === 'masonry') $containerCls = 'home-cats__masonry';
            ?>
            <div class="<?= $containerCls ?> <?= $bentoBucket ?>">
                <?php foreach ($categories as $idx => $c):
                    $hue   = homeCategoryHue((string) $c['slug']);
                    $hasImg = !empty($c['img']);
                    // Sólo el bento usa los modificadores de span.
                    $tileMod = $layout === 'bento' ? ' home-cat--' . ($idx % 6) : ' home-cat--' . $layout;
                ?>
                    <a href="/categoria/<?= htmlspecialchars($c['slug']) ?>" class="home-cat<?= $tileMod ?><?= $hasImg ? ' home-cat--has-img' : ' home-cat--no-img' ?>"
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
        <?php endif; ?>
    </section>
    <?php endif; ?>

    <?php if ($s['show_featured'] && $featured): ?>
    <!-- ============ Productos destacados ============ -->
    <section class="home-featured container">
        <header class="home-section__head">
            <h2 class="home-section__title">Lo más buscado</h2>
            <a href="/catalogo" class="home-section__link">Ver todo →</a>
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

    <?php if ($s['show_clients'] && $s['clients_names']):
        // Logos en movimiento (marquesina). Placeholder: logo genérico + nombre
        // del cliente. Cuando lleguen los archivos reales, se reemplazan desde
        // el panel (Configuración → home_clients_logos con rutas por cliente).
        $clientLogo  = trim((string) getSetting('home_clients_logo', '/uploads/library/greenbags/cliente-logo.svg'));
        $clientsLoop = array_merge($s['clients_names'], $s['clients_names']);
    ?>
    <!-- ============ Nuestros clientes (marquesina) ============ -->
    <section class="home-clients">
        <div class="container">
            <h2 class="home-clients__title"><?= htmlspecialchars($s['clients_title']) ?></h2>
        </div>
        <div class="home-clients__marquee" aria-label="<?= htmlspecialchars($s['clients_title']) ?>">
            <div class="home-clients__track">
                <?php foreach ($clientsLoop as $idx => $name): ?>
                    <span class="home-clients__logo"<?= $idx >= count($s['clients_names']) ? ' aria-hidden="true"' : '' ?>>
                        <?php if ($clientLogo): ?>
                            <img src="<?= htmlspecialchars($clientLogo) ?>" alt="<?= htmlspecialchars($name) ?>" loading="lazy">
                        <?php endif; ?>
                        <span class="home-clients__name"><?= htmlspecialchars($name) ?></span>
                    </span>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php endif; ?>

    <!-- ============ Banda CTA final (cotización) ============ -->
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
            <div class="home-cta__actions">
                <button type="button" class="btn btn--lg btn--invert home-cta__btn" data-cotizar><?= htmlspecialchars($s['cta_label'] ?: 'Solicitar cotización') ?></button>
            </div>
        </div>
    </section>

    <!-- ============ Modal de cotización ("Cotiza tu packaging") ============
         Se abre desde cualquier botón con [data-cotizar] (hero + banda final).
         Reusa los estilos de la vieja tarjeta del hero (.home-hero__contact-*).
         Auto-abre si hubo error de validación o si el envío ya se registró. -->
    <?php $cotizarAutoOpen = ($error !== '' || !empty($_GET['sent'])); ?>
    <div class="cotizar-modal" id="cotizar-modal"<?= $cotizarAutoOpen ? '' : ' hidden' ?> data-auto-open="<?= $cotizarAutoOpen ? '1' : '0' ?>">
        <div class="cotizar-modal__backdrop" data-cotizar-close></div>
        <div class="cotizar-modal__dialog" role="dialog" aria-modal="true" aria-labelledby="cotizar-modal-title">
            <button type="button" class="cotizar-modal__close" data-cotizar-close aria-label="Cerrar">
                <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
            </button>
            <div class="home-hero__contact-card">
                <?php if (!empty($_GET['sent'])): ?>
                    <span class="home-hero__contact-icon--ok" aria-hidden="true">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
                    </span>
                    <h2 class="home-hero__contact-title" id="cotizar-modal-title">¡Gracias por escribirnos!</h2>
                    <p class="home-hero__contact-sub">Te responderemos a la brevedad.</p>
                <?php else: ?>
                    <div class="home-hero__contact-head">
                        <span class="home-hero__contact-badge" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
                        </span>
                        <h2 class="home-hero__contact-title" id="cotizar-modal-title">Cotiza tu packaging</h2>
                    </div>
                    <p class="home-hero__contact-sub">Contanos qué necesitás y te respondemos en menos de 24 hs hábiles, sin compromiso.</p>
                    <?php if ($error): ?>
                        <p class="home-hero__contact-error"><?= htmlspecialchars($error) ?></p>
                    <?php endif; ?>
                    <form method="post" action="/" class="home-hero__contact-form">
                        <input type="hidden" name="action" value="submit_lead">
                        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                        <input type="hidden" name="form_started" value="<?= time() ?>">
                        <input type="hidden" name="source" value="cotizador">
                        <input type="text" name="website" value="" tabindex="-1" autocomplete="off" style="position:absolute;left:-9999px;opacity:0;pointer-events:none;" aria-hidden="true">
                        <div class="home-hero__contact-row">
                            <p>
                                <label class="visually-hidden" for="hh-name">Nombre</label>
                                <input id="hh-name" type="text" name="name" placeholder="Nombre" required>
                            </p>
                            <p>
                                <label class="visually-hidden" for="hh-phone">Teléfono</label>
                                <input id="hh-phone" type="tel" name="phone" placeholder="Teléfono">
                            </p>
                        </div>
                        <p>
                            <label class="visually-hidden" for="hh-email">Email</label>
                            <input id="hh-email" type="email" name="email" placeholder="Email" required>
                        </p>
                        <p>
                            <label class="visually-hidden" for="hh-company">Empresa</label>
                            <input id="hh-company" type="text" name="company" placeholder="Empresa (opcional)">
                        </p>
                        <p>
                            <label class="visually-hidden" for="hh-message">Mensaje</label>
                            <textarea id="hh-message" name="message" rows="3" placeholder="¿Qué packaging necesitás? Cantidades, tipo de producto, etc."></textarea>
                        </p>
                        <button type="submit" class="btn home-hero__contact-btn">Solicitar cotización</button>
                        <p class="home-hero__contact-trust">
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="20 6 9 17 4 12"/></svg>
                            Sin compromiso · Respuesta por WhatsApp o email
                        </p>
                    </form>
                <?php endif; ?>
            </div>
        </div>
        <script>
        (function(){
            var modal = document.getElementById('cotizar-modal');
            if (!modal) return;
            var firstField = modal.querySelector('input:not([type=hidden]), textarea');
            function open(){
                modal.hidden = false;
                document.body.classList.add('cotizar-open');
                if (firstField) setTimeout(function(){ try { firstField.focus(); } catch(e){} }, 60);
            }
            function close(){
                modal.hidden = true;
                document.body.classList.remove('cotizar-open');
            }
            document.addEventListener('click', function(e){
                if (e.target.closest('[data-cotizar]'))       { e.preventDefault(); open();  return; }
                if (e.target.closest('[data-cotizar-close]'))  { e.preventDefault(); close(); }
            });
            document.addEventListener('keydown', function(e){
                if (e.key === 'Escape' && !modal.hidden) close();
            });
            if (modal.dataset.autoOpen === '1') open();
        })();
        </script>
    </div>

</main>
    <?php
    layoutEnd();
}
