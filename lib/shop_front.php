<?php
/**
 * Front público de la tienda. Router + render de:
 *   /tienda                 → grilla de productos + categorías
 *   /categoria/{slug}       → productos de la categoría (con breadcrumb)
 *   /producto/{slug}        → ficha con galería, precio, SEO + JSON-LD Product
 *   /carrito                → (stub hasta Fase 2)
 *
 * shopFrontRoute() devuelve true si manejó la URL (y ya renderizó la salida).
 */

function shopAbsUrl(string $path): string {
    $host  = $_SERVER['HTTP_HOST'] ?? '';
    $proto = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    if ($path === '' || preg_match('#^https?://#', $path)) return $path;
    return ($host ? $proto . '://' . $host : '') . (str_starts_with($path, '/') ? $path : '/' . $path);
}

function shopFrontRoute(string $path): bool {
    $seg = explode('/', $path);

    if (count($seg) === 2 && $seg[0] === 'producto' && $seg[1] !== '') {
        $p = productGetBySlug($seg[1], true);
        if (!$p) return false;
        shopRenderProduct($p);
        return true;
    }
    if (count($seg) === 2 && $seg[0] === 'categoria' && $seg[1] !== '') {
        $c = categoryGetBySlug($seg[1]);
        if (!$c) return false;
        shopRenderCategory($c);
        return true;
    }
    if ($path === 'tienda') {
        shopRenderShopIndex();
        return true;
    }
    if ($path === 'carrito') {
        shopRenderCart();
        return true;
    }
    if (checkoutRoute($path)) {
        return true;
    }
    return false;
}

/* ===================== Render ===================== */

function shopRenderShopIndex(): void {
    $products = productsPublished(['perPage' => 24, 'page' => max(1, (int) ($_GET['p'] ?? 1))]);
    $cats     = categoryList(true);
    layoutStart([
        'title'       => 'Tienda',
        'description' => (string) getSetting('business_description', ''),
        'canonical'   => '/tienda',
    ]);
    echo '<main class="container shop"><h1>Tienda</h1>';
    if ($cats) {
        echo '<nav class="shop-cats">';
        foreach ($cats as $c) {
            echo '<a class="shop-cats__link" href="/categoria/' . htmlspecialchars($c['slug']) . '">'
               . htmlspecialchars($c['name']) . '</a>';
        }
        echo '</nav>';
    }
    shopRenderGrid($products);
    echo '</main>';
    layoutEnd();
}

function shopRenderCategory(array $c): void {
    $page     = max(1, (int) ($_GET['p'] ?? 1));
    $products = productsPublished(['category_id' => (int) $c['id'], 'perPage' => 24, 'page' => $page]);
    $title    = (string) ($c['meta_title'] ?: $c['name']);

    $breadcrumb = [
        '@context' => 'https://schema.org',
        '@type'    => 'BreadcrumbList',
        'itemListElement' => [
            ['@type' => 'ListItem', 'position' => 1, 'name' => 'Tienda', 'item' => shopAbsUrl('/tienda')],
            ['@type' => 'ListItem', 'position' => 2, 'name' => $c['name'], 'item' => shopAbsUrl('/categoria/' . $c['slug'])],
        ],
    ];
    layoutStart([
        'title'       => $title,
        'description' => (string) ($c['meta_description'] ?: $c['description']),
        'canonical'   => '/categoria/' . $c['slug'],
        'jsonld'      => [$breadcrumb],
    ]);
    echo '<main class="container shop">';
    echo '<nav class="shop-breadcrumb"><a href="/tienda">Tienda</a> <span>/</span> '
       . htmlspecialchars($c['name']) . '</nav>';
    echo '<h1>' . htmlspecialchars($c['name']) . '</h1>';
    if (trim((string) $c['description']) !== '') {
        echo '<div class="shop-cat__desc">' . $c['description'] . '</div>';
    }
    shopRenderGrid($products);
    echo '</main>';
    layoutEnd();
}

function shopRenderProduct(array $p): void {
    $images     = productImages((int) $p['id']);
    $tiers      = function_exists('productTiers')  ? productTiers((int) $p['id'])  : [];
    $videos     = function_exists('productVideos') ? productVideos((int) $p['id']) : [];
    $moq        = max(1, (int) ($p['min_order_qty'] ?? 1));
    $isVariable = ($p['type'] ?? 'simple') === 'variable';

    // Galería unificada: VIDEOS primero, luego imágenes (carrusel con miniaturas).
    $gallery = [];
    foreach ($videos as $vd) {
        $gallery[] = ['type' => 'video', 'provider' => (string) ($vd['provider'] ?? 'file'),
                      'html' => videoEmbedHtml($vd), 'thumb' => videoThumb($vd)];
    }
    foreach ($images as $img) {
        $gallery[] = ['type' => 'image', 'full' => (string) $img['file_path'],
                      'thumb' => (string) ($img['thumb_path'] ?: $img['file_path']), 'alt' => (string) ($img['alt'] ?? '')];
    }
    $matrix     = $isVariable ? productVariationMatrix((int) $p['id']) : ['attributes' => [], 'variations' => []];
    $effective  = productEffectivePrice($p);
    $onSale     = productIsOnSale($p);
    $outOfStock = !$isVariable && (int) $p['manage_stock'] === 1 && (int) $p['stock_qty'] <= 0 && $p['stock_status'] !== 'backorder';

    // Imágenes absolutas para JSON-LD / OG.
    $imgAbs = [];
    foreach ($images as $img) $imgAbs[] = shopAbsUrl((string) $img['file_path']);
    $url = shopAbsUrl('/producto/' . $p['slug']);

    $ld = [
        '@context'    => 'https://schema.org',
        '@type'       => 'Product',
        'name'        => (string) $p['name'],
        'description' => mb_substr(trim(strip_tags((string) ($p['short_description'] ?: $p['description']))), 0, 500),
        'sku'         => (string) ($p['sku'] ?? ''),
    ];
    if (!empty($imgAbs)) $ld['image'] = $imgAbs;
    if (!empty($p['brand'])) $ld['brand'] = ['@type' => 'Brand', 'name' => (string) $p['brand']];

    if ($isVariable) {
        $anyAvail = false;
        foreach ($matrix['variations'] as $vv) { if ($vv['available']) { $anyAvail = true; break; } }
        $ld['offers'] = [
            '@type'         => 'AggregateOffer',
            'lowPrice'      => (string) shopAmountForGateway($p['min_price']),
            'highPrice'     => (string) shopAmountForGateway($p['max_price']),
            'priceCurrency' => shopCurrency()['code'],
            'offerCount'    => count($matrix['variations']),
            'availability'  => $anyAvail ? 'https://schema.org/InStock' : 'https://schema.org/OutOfStock',
            'url'           => $url,
        ];
    } else {
        $ld['offers'] = [
            '@type'         => 'Offer',
            'price'         => (string) shopAmountForGateway($effective),
            'priceCurrency' => shopCurrency()['code'],
            'availability'  => productAvailability($p),
            'url'           => $url,
        ];
    }

    // Datos para el selector de variaciones (front).
    $jsVars = [];
    foreach ($matrix['variations'] as $vv) {
        $jsVars[] = [
            'id'        => $vv['id'],
            'values'    => $vv['values'],
            'available' => $vv['available'],
            'price'     => shopFormatPrice($vv['effective']),
            'old'       => $vv['effective'] < $vv['price'] ? shopFormatPrice($vv['price']) : '',
            'image'     => $vv['image'] ?? '',
        ];
    }

    // VideoObject JSON-LD por cada video (SEO).
    $videoLd = [];
    foreach ($videos as $vd) {
        $obj = [
            '@context'    => 'https://schema.org', '@type' => 'VideoObject',
            'name'        => (string) $p['name'] . ' — video',
            'description' => mb_substr(trim(strip_tags((string) ($p['short_description'] ?: $p['name']))), 0, 300) ?: (string) $p['name'],
        ];
        $thumb = videoThumb($vd);
        if ($thumb) $obj['thumbnailUrl'] = $thumb;
        if (($vd['provider'] ?? '') === 'youtube' && !empty($vd['video_id'])) $obj['embedUrl'] = 'https://www.youtube.com/embed/' . $vd['video_id'];
        elseif (($vd['provider'] ?? '') === 'file') $obj['contentUrl'] = (string) $vd['url'];
        $videoLd[] = $obj;
    }

    layoutStart([
        'title'       => (string) ($p['meta_title'] ?: $p['name']),
        'description' => (string) ($p['meta_description'] ?: $p['short_description']),
        'og_image'    => $imgAbs[0] ?? '',
        'canonical'   => '/producto/' . $p['slug'],
        'jsonld'      => array_merge([$ld], $videoLd),
    ]);
    ?>
<?php
// Datos extras para el nuevo layout estilo "Trendo".
$catIds       = function_exists('productCategoryIds') ? productCategoryIds((int) $p['id']) : [];
$primaryCat   = $catIds ? categoryGet((int) $catIds[0]) : null;
$brand        = trim((string) ($p['brand'] ?? ''));
$brandInitial = $brand !== '' ? mb_strtoupper(mb_substr($brand, 0, 1)) : mb_strtoupper(mb_substr((string) $p['name'], 0, 1));
$freeship     = trim((string) getSetting('shop_freeship_text', 'Envío gratis en compras desde $50.000'));
// Helper: distinguir atributos de tamaño (talle/size) para usar grid compacta.
$isSizeAttr = fn(string $name) => (bool) preg_match('/(talle|size|tama|n[uú]mero|talla)/iu', $name);

// Modo cotización vs compra: el setting `quotes_enabled` decide a dónde van
// los forms del CTA "Agregar a ...". El resto del rendering (galería, swatches,
// precios) es idéntico — sólo cambian action/name/label del CTA.
$buyMode       = (function_exists('quotesEnabled') && quotesEnabled()) ? 'quote' : 'cart';
$buyAction     = $buyMode === 'quote' ? '/cotizacion' : '/carrito';
$buyActionName = $buyMode === 'quote' ? 'add_to_quote' : 'add_to_cart';
$buyLabel      = $buyMode === 'quote'
    ? (string) getSetting('quote_button_label', 'Agregar a cotización')
    : 'Agregar al carrito';
$hidePrices    = $buyMode === 'quote' && getSetting('quote_show_prices', '0') !== '1';
?>
<main class="container shop-product">
    <nav class="shop-breadcrumb">
        <a href="/tienda">Tienda</a> <span>/</span>
        <?php if ($primaryCat): ?>
            <a href="/categoria/<?= htmlspecialchars($primaryCat['slug']) ?>"><?= htmlspecialchars($primaryCat['name']) ?></a> <span>/</span>
        <?php endif; ?>
        <span class="shop-breadcrumb__current"><?= htmlspecialchars($p['name']) ?></span>
    </nav>

    <div class="shop-product__card">
        <div class="shop-product__grid">

            <!-- ===== Media: thumbs verticales + stage ===== -->
            <div class="shop-product__media shop-gallery" id="shop-gallery">
                <?php if ($gallery): ?>
                    <?php if (count($gallery) > 1): ?>
                        <div class="shop-gallery__thumbs shop-gallery__thumbs--vertical">
                            <?php foreach ($gallery as $i => $g): ?>
                                <button type="button" class="shop-gallery__thumb<?= $i === 0 ? ' is-active' : '' ?>" data-idx="<?= $i ?>" aria-label="<?= $g['type'] === 'video' ? 'Ver video' : 'Ver imagen' ?>">
                                    <?php if ($g['type'] === 'video'): ?>
                                        <?php if ($g['thumb']): ?><img src="<?= htmlspecialchars($g['thumb']) ?>" alt="video" loading="lazy"><?php else: ?><span class="shop-gallery__vph"></span><?php endif; ?>
                                        <span class="shop-gallery__play">▶</span>
                                    <?php else: ?>
                                        <img src="<?= htmlspecialchars($g['thumb']) ?>" alt="<?= htmlspecialchars($g['alt']) ?>" loading="lazy">
                                    <?php endif; ?>
                                </button>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>
                    <div class="shop-gallery__stage" id="gallery-stage"></div>
                    <script>
                    (function(){
                        var G = <?= json_encode($gallery, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) ?>;
                        var gal = document.getElementById('shop-gallery');
                        var stage = document.getElementById('gallery-stage');
                        if (!gal || !stage) return;
                        function show(i){
                            var g = G[i]; if (!g) return;
                            stage.__html = null;
                            if (g.type === 'video'){
                                if (g.provider === 'file'){ stage.innerHTML = g.html; }
                                else {
                                    stage.innerHTML = '<div class="shop-gallery__facade">'
                                        + (g.thumb ? '<img src="'+g.thumb+'" alt="video">' : '<span class="shop-gallery__vph"></span>')
                                        + '<button type="button" class="shop-gallery__facade-play" aria-label="Reproducir video">▶</button></div>';
                                    stage.__html = g.html;
                                }
                            } else {
                                stage.innerHTML = '<img src="'+g.full+'" alt="'+(g.alt||'').replace(/"/g,'&quot;')+'">';
                            }
                            gal.querySelectorAll('.shop-gallery__thumb').forEach(function(t,k){ t.classList.toggle('is-active', k===i); });
                        }
                        gal.addEventListener('click', function(e){
                            var b = e.target.closest('.shop-gallery__thumb');
                            if (b){ show(parseInt(b.dataset.idx,10)); return; }
                            var play = e.target.closest('.shop-gallery__facade-play');
                            if (play && stage.__html){ stage.innerHTML = stage.__html; }
                        });
                        window.__galleryShowImage = function(src){
                            stage.innerHTML = '<img src="'+src+'" alt="">';
                            gal.querySelectorAll('.shop-gallery__thumb').forEach(function(t){ t.classList.remove('is-active'); });
                        };
                        show(0);
                    })();
                    </script>
                <?php else: ?>
                    <div class="shop-product__noimg">Sin imagen</div>
                <?php endif; ?>
            </div>

            <!-- ===== Info: brand + title + price + swatches + cta ===== -->
            <div class="shop-product__info">
                <?php if ($brand !== ''): ?>
                    <div class="shop-brand">
                        <span class="shop-brand__badge"><?= htmlspecialchars($brandInitial) ?></span>
                        <span class="shop-brand__name"><?= htmlspecialchars($brand) ?></span>
                    </div>
                <?php endif; ?>

                <h1 class="shop-product__title"><?= htmlspecialchars($p['name']) ?></h1>

                <?php if ($primaryCat): ?>
                    <p class="shop-product__subcat"><?= htmlspecialchars($primaryCat['name']) ?></p>
                <?php endif; ?>

                <?php if ($hidePrices): ?>
                    <p class="shop-product__price" id="shop-price">
                        <span class="shop-price__now shop-price__quote">Precio bajo cotización</span>
                    </p>
                <?php elseif ($isVariable): ?>
                    <p class="shop-product__price" id="shop-price">
                        <span class="shop-price__now">Desde <?= shopFormatPrice($p['min_price']) ?></span>
                    </p>
                <?php else: ?>
                    <p class="shop-product__price">
                        <?php if ($onSale): ?><span class="shop-price__old"><?= shopFormatPrice($p['price']) ?></span><?php endif; ?>
                        <span class="shop-price__now"><?= shopFormatPrice($effective) ?></span>
                    </p>
                <?php endif; ?>

                <?php if (!empty($p['short_description'])): ?>
                    <p class="shop-product__short"><?= htmlspecialchars($p['short_description']) ?></p>
                <?php endif; ?>

                <?php if ($isVariable): ?>
                    <form method="post" action="<?= $buyAction ?>" class="shop-product__buy shop-varform" id="buyform">
                        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                        <input type="hidden" name="action" value="<?= $buyActionName ?>">
                        <input type="hidden" name="return_to" value="/producto/<?= htmlspecialchars($p['slug']) ?>">
                        <input type="hidden" name="product_id" value="<?= (int) $p['id'] ?>">
                        <input type="hidden" name="variation_id" id="variation_id" value="">

                        <?php foreach ($matrix['attributes'] as $a):
                            $isSize = $isSizeAttr((string) $a['name']);
                        ?>
                            <div class="shop-swatchgroup<?= $isSize ? ' shop-swatchgroup--size' : '' ?>" data-attr="<?= (int) $a['id'] ?>">
                                <div class="shop-swatchgroup__head">
                                    <span class="shop-swatchgroup__label"><?= $isSize ? 'Elige tu ' : '' ?><?= htmlspecialchars(mb_strtolower($a['name'])) ?></span>
                                    <?php if ($isSize): ?>
                                        <a href="#" class="shop-swatchgroup__guide" onclick="return false;">Guía de talles</a>
                                    <?php endif; ?>
                                </div>
                                <div class="shop-swatches" role="radiogroup" aria-label="<?= htmlspecialchars($a['name']) ?>">
                                    <?php foreach ($a['values'] as $val): ?>
                                        <button type="button" class="shop-swatch" data-val="<?= (int) $val['id'] ?>" role="radio" aria-checked="false">
                                            <?= htmlspecialchars($val['value']) ?>
                                        </button>
                                    <?php endforeach; ?>
                                </div>
                            </div>
                        <?php endforeach; ?>

                        <p class="shop-varstock" id="shop-varstock"></p>

                        <div class="shop-product__buyrow">
                            <div class="shop-qtybox">
                                <button type="button" class="shop-qtybox__btn" data-step="-1" aria-label="Disminuir">−</button>
                                <input type="number" name="qty" value="<?= $moq ?>" min="<?= $moq ?>" class="shop-qty" id="shop-qty">
                                <button type="button" class="shop-qtybox__btn" data-step="1" aria-label="Aumentar">+</button>
                            </div>
                            <button type="submit" class="shop-addcart" id="addcart" disabled>
                                <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.7 13.4a2 2 0 0 0 2 1.6h9.7a2 2 0 0 0 2-1.6L23 6H6"/></svg>
                                <span>Selecciona las opciones</span>
                            </button>
                            <button type="button" class="shop-wishlist" aria-label="Guardar en favoritos">
                                <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
                            </button>
                        </div>
                    </form>
                    <script>
                    (function(){
                        var VARS = <?= json_encode($jsVars, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) ?>;
                        var groups = document.querySelectorAll('#buyform .shop-swatchgroup');
                        var priceBox = document.getElementById('shop-price');
                        var stockEl = document.getElementById('shop-varstock');
                        var btn = document.getElementById('addcart');
                        var btnLabel = btn.querySelector('span');
                        var hid = document.getElementById('variation_id');
                        var qty = document.getElementById('shop-qty');
                        // Click → marcar swatch + actualizar todo.
                        groups.forEach(function(g){
                            g.addEventListener('click', function(e){
                                var s = e.target.closest('.shop-swatch');
                                if (!s) return;
                                g.querySelectorAll('.shop-swatch').forEach(function(x){ x.classList.remove('is-active'); x.setAttribute('aria-checked','false'); });
                                s.classList.add('is-active'); s.setAttribute('aria-checked','true');
                                update();
                            });
                        });
                        // Stepper qty.
                        document.querySelectorAll('.shop-qtybox__btn').forEach(function(b){
                            b.addEventListener('click', function(){
                                var step = parseInt(b.dataset.step,10) || 1;
                                var min = parseInt(qty.min,10) || 1;
                                qty.value = Math.max(min, (parseInt(qty.value,10) || min) + step);
                            });
                        });
                        function current(){
                            var sel = {}, done = true;
                            groups.forEach(function(g){
                                var a = g.querySelector('.shop-swatch.is-active');
                                if (a) sel[g.dataset.attr] = a.dataset.val;
                                else done = false;
                            });
                            return done ? sel : null;
                        }
                        function match(sel){
                            return VARS.find(function(v){
                                for (var a in sel) { if (String(v.values[a]) !== String(sel[a])) return false; }
                                return true;
                            });
                        }
                        function update(){
                            var sel = current();
                            if (!sel){ btn.disabled = true; btnLabel.textContent = 'Selecciona las opciones'; hid.value=''; stockEl.textContent=''; return; }
                            var v = match(sel);
                            if (!v){ btn.disabled = true; btnLabel.textContent = 'No disponible'; hid.value=''; stockEl.textContent=''; return; }
                            priceBox.innerHTML = (v.old ? '<span class="shop-price__old">'+v.old+'</span> ' : '') + '<span class="shop-price__now">'+v.price+'</span>';
                            hid.value = v.id;
                            if (v.image && window.__galleryShowImage){ window.__galleryShowImage(v.image); }
                            if (v.available){ btn.disabled=false; btnLabel.textContent=<?= json_encode($buyLabel) ?>; stockEl.textContent=''; }
                            else { btn.disabled=true; btnLabel.textContent='Sin stock'; stockEl.textContent='Sin stock para esta combinación.'; }
                        }
                    })();
                    </script>
                <?php else: ?>
                    <?php if ($outOfStock): ?>
                        <p class="shop-product__stock shop-product__stock--out">Sin stock</p>
                    <?php else: ?>
                        <form method="post" action="<?= $buyAction ?>" class="shop-product__buy">
                            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                            <input type="hidden" name="action" value="<?= $buyActionName ?>">
                            <input type="hidden" name="return_to" value="/producto/<?= htmlspecialchars($p['slug']) ?>">
                            <input type="hidden" name="product_id" value="<?= (int) $p['id'] ?>">
                            <div class="shop-product__buyrow">
                                <div class="shop-qtybox">
                                    <button type="button" class="shop-qtybox__btn" data-step="-1" aria-label="Disminuir">−</button>
                                    <input type="number" name="qty" value="<?= $moq ?>" min="<?= $moq ?>" class="shop-qty" id="shop-qty-s">
                                    <button type="button" class="shop-qtybox__btn" data-step="1" aria-label="Aumentar">+</button>
                                </div>
                                <button type="submit" class="shop-addcart">
                                    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.7 13.4a2 2 0 0 0 2 1.6h9.7a2 2 0 0 0 2-1.6L23 6H6"/></svg>
                                    <span><?= htmlspecialchars($buyLabel) ?></span>
                                </button>
                                <button type="button" class="shop-wishlist" aria-label="Guardar en favoritos">
                                    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
                                </button>
                            </div>
                        </form>
                        <script>
                        (function(){
                            var qty = document.getElementById('shop-qty-s');
                            if (!qty) return;
                            document.querySelectorAll('.shop-qtybox__btn').forEach(function(b){
                                b.addEventListener('click', function(){
                                    var step = parseInt(b.dataset.step,10) || 1;
                                    var min = parseInt(qty.min,10) || 1;
                                    qty.value = Math.max(min, (parseInt(qty.value,10) || min) + step);
                                });
                            });
                        })();
                        </script>
                    <?php endif; ?>
                <?php endif; ?>

                <?php if ($freeship !== ''): ?>
                    <p class="shop-freeship">
                        <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M1 3h15v13H1z"/><path d="M16 8h4l3 3v5h-7"/><circle cx="6" cy="19" r="2"/><circle cx="18" cy="19" r="2"/></svg>
                        <span><?= htmlspecialchars($freeship) ?></span>
                    </p>
                <?php endif; ?>

                <?php if ($tiers): ?>
                    <details class="shop-tiers shop-tiers--collapsible">
                        <summary>Ver precios por mayor</summary>
                        <table class="shop-tiers__table">
                            <thead><tr><th>Cantidad</th><th>Precio unit.</th></tr></thead>
                            <tbody>
                                <tr><td>1+</td><td><?= shopFormatPrice($isVariable ? $p['min_price'] : $effective) ?></td></tr>
                                <?php foreach ($tiers as $t): ?>
                                    <tr><td><?= (int) $t['min_qty'] ?>+</td><td><?= shopFormatPrice($t['unit_price']) ?></td></tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                        <?php if ($moq > 1): ?><p class="shop-tiers__moq">Compra mínima: <?= (int) $moq ?> unidades.</p><?php endif; ?>
                    </details>
                <?php endif; ?>
            </div>

        </div>
    </div>

    <?php if (trim((string) $p['description']) !== ''): ?>
        <section class="shop-product__desc">
            <h2>Descripción</h2>
            <div><?= $p['description'] /* HTML confiado: lo edita el admin */ ?></div>
        </section>
    <?php endif; ?>

</main>
    <?php
    layoutEnd();
}

function shopRenderGrid(array $products): void {
    if (!$products) { echo '<p class="shop-empty">No hay productos para mostrar.</p>'; return; }
    $hidePrices = function_exists('quotesEnabled') && quotesEnabled() && getSetting('quote_show_prices', '0') !== '1';
    echo '<div class="shop-grid">';
    foreach ($products as $p) {
        $eff   = productEffectivePrice($p);
        $sale  = productIsOnSale($p);
        $url   = '/producto/' . htmlspecialchars($p['slug']);
        echo '<a class="shop-card" href="' . $url . '">';
        if (!empty($p['img'])) {
            echo '<div class="shop-card__img"><img src="' . htmlspecialchars($p['img']) . '" alt="'
               . htmlspecialchars($p['img_alt'] ?? $p['name']) . '" loading="lazy"></div>';
        } else {
            echo '<div class="shop-card__img shop-card__img--empty"></div>';
        }
        echo '<div class="shop-card__body"><h3 class="shop-card__name">' . htmlspecialchars($p['name']) . '</h3>';
        echo '<p class="shop-card__price">';
        if ($hidePrices) {
            echo '<span class="shop-price__now shop-price__quote">Cotizar</span>';
        } elseif (($p['type'] ?? 'simple') === 'variable') {
            echo '<span class="shop-price__now">Desde ' . shopFormatPrice($p['min_price'] ?: $eff) . '</span>';
        } else {
            if ($sale) echo '<span class="shop-price__old">' . shopFormatPrice($p['price']) . '</span> ';
            echo '<span class="shop-price__now">' . shopFormatPrice($eff) . '</span>';
        }
        echo '</p></div></a>';
    }
    echo '</div>';
}

function shopRenderCart(): void {
    // POST: añadir/actualizar/eliminar/vaciar. Patrón POST-redirect-GET para
    // evitar reenvíos al refrescar y consolidar el feedback en flash.
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        csrfCheck();
        $action     = (string) ($_POST['action'] ?? '');
        $fromDrawer = !empty($_POST['from_drawer']);
        // return_to: solo aceptamos paths relativos del mismo sitio para
        // evitar open-redirect.
        $rawReturn = (string) ($_POST['return_to'] ?? '');
        $returnTo  = (preg_match('#^/[a-zA-Z0-9_\-/?=&%.,~]*$#', $rawReturn) && !str_contains($rawReturn, '//'))
            ? $rawReturn : '';

        $resOk = true; $resErr = null;
        switch ($action) {
            case 'add_to_cart':
                $res = cartAddItem(
                    (int) ($_POST['product_id'] ?? 0),
                    ($_POST['variation_id'] ?? '') !== '' ? (int) $_POST['variation_id'] : null,
                    (int) ($_POST['qty'] ?? 1)
                );
                $resOk = !empty($res['ok']);
                $resErr = $res['error'] ?? null;
                if (!$fromDrawer) {
                    flashSet($resOk ? 'cart_msg' : 'cart_err',
                        $resOk ? 'Producto agregado al carrito.' : ($resErr ?: 'No se pudo agregar.'));
                    if ($resOk) {
                        flashSet('cart_just_added', '1');
                        if ($returnTo !== '') redirect($returnTo);
                    }
                }
                break;
            case 'update_qty':
                cartUpdateQty((int) ($_POST['item_id'] ?? 0), (int) ($_POST['qty'] ?? 0));
                if (!$fromDrawer) {
                    flashSet('cart_msg', 'Carrito actualizado.');
                    if ($returnTo !== '') {
                        flashSet('cart_just_added', '1');
                        redirect($returnTo);
                    }
                }
                break;
            case 'remove':
                cartRemoveItem((int) ($_POST['item_id'] ?? 0));
                if (!$fromDrawer) {
                    flashSet('cart_msg', 'Producto quitado del carrito.');
                    if ($returnTo !== '') {
                        flashSet('cart_just_added', '1');
                        redirect($returnTo);
                    }
                }
                break;
            case 'clear':
                cartClear();
                if (!$fromDrawer) flashSet('cart_msg', 'Carrito vaciado.');
                break;
        }

        // Respuesta JSON con el HTML del drawer ya renderizado (lo replicamos en el cliente).
        if ($fromDrawer) {
            ob_start();
            require __DIR__ . '/../components/cart_drawer.php';
            $full = (string) ob_get_clean();
            // Extraemos solo el contenido interior del <aside id="cart-drawer">.
            $inner = '';
            if (preg_match('#<aside[^>]*id="cart-drawer"[^>]*>(.*?)</aside>#s', $full, $m)) {
                $inner = $m[1];
            }
            header('Content-Type: application/json; charset=utf-8');
            header('Cache-Control: no-store');
            echo json_encode([
                'ok'       => $resOk,
                'error'    => $resErr,
                'innerHtml'=> $inner,
                'count'    => cartCount(),
            ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            exit;
        }

        redirect('/carrito');
    }

    $items  = cartItems();
    $totals = cartTotals();
    $msg    = flashGet('cart_msg');
    $err    = flashGet('cart_err');

    layoutStart(['title' => 'Carrito', 'canonical' => '/carrito']);
    echo '<main class="container shop shop-cart"><h1>Carrito</h1>';
    if ($msg) echo '<p class="alert alert--ok shop-cart__alert">' . htmlspecialchars($msg) . '</p>';
    if ($err) echo '<p class="alert alert--error shop-cart__alert">' . htmlspecialchars($err) . '</p>';

    if (!$items) {
        echo '<p class="shop-cart__empty">Tu carrito está vacío.</p>'
           . '<p><a href="/tienda" class="btn">← Ir a la tienda</a></p></main>';
        layoutEnd();
        return;
    }
    ?>
<div class="shop-cart__wrap">
<table class="shop-cart__table">
    <thead>
        <tr>
            <th colspan="2">Producto</th>
            <th class="shop-cart__th-num">Precio unit.</th>
            <th class="shop-cart__th-num">Cantidad</th>
            <th class="shop-cart__th-num">Subtotal</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    <?php foreach ($items as $it): $moq = max(1, (int) ($it['min_order_qty'] ?? 1)); ?>
        <tr>
            <td class="shop-cart__thumb">
                <?php if (!empty($it['thumb'])): ?>
                    <a href="/producto/<?= htmlspecialchars($it['slug']) ?>">
                        <img src="<?= htmlspecialchars($it['thumb']) ?>" alt="<?= htmlspecialchars($it['name']) ?>" loading="lazy">
                    </a>
                <?php else: ?>
                    <div class="shop-cart__noimg"></div>
                <?php endif; ?>
            </td>
            <td class="shop-cart__name">
                <a href="/producto/<?= htmlspecialchars($it['slug']) ?>"><?= htmlspecialchars($it['name']) ?></a>
                <?php if ($it['variation_label']): ?>
                    <p class="shop-cart__var"><?= htmlspecialchars($it['variation_label']) ?></p>
                <?php endif; ?>
            </td>
            <td class="shop-cart__price"><?= shopFormatPrice($it['unit_price']) ?></td>
            <td class="shop-cart__qty">
                <form method="post" action="/carrito" class="shop-cart__qtyform">
                    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                    <input type="hidden" name="action" value="update_qty">
                    <input type="hidden" name="item_id" value="<?= (int) $it['id'] ?>">
                    <input type="number" name="qty" value="<?= (int) $it['qty'] ?>" min="<?= $moq ?>" class="shop-qty">
                    <button type="submit" class="shop-cart__update" aria-label="Actualizar cantidad" title="Actualizar">⟳</button>
                </form>
            </td>
            <td class="shop-cart__line"><?= shopFormatPrice($it['line_total']) ?></td>
            <td class="shop-cart__rm">
                <form method="post" action="/carrito" class="shop-cart__rmform" onsubmit="return confirm('¿Quitar este producto del carrito?');">
                    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="item_id" value="<?= (int) $it['id'] ?>">
                    <button type="submit" class="shop-cart__rmbtn" aria-label="Quitar producto" title="Quitar">×</button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="4" class="shop-cart__totlbl">Subtotal (<?= (int) $totals['qty'] ?> u.)</td>
            <td colspan="2" class="shop-cart__tot"><?= shopFormatPrice($totals['subtotal']) ?></td>
        </tr>
    </tfoot>
</table>
</div>

<div class="shop-cart__actions">
    <a href="/tienda" class="btn btn--ghost">← Seguir comprando</a>
    <form method="post" action="/carrito" class="shop-cart__clearform" onsubmit="return confirm('¿Vaciar todo el carrito?');">
        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
        <input type="hidden" name="action" value="clear">
        <button type="submit" class="btn btn--ghost">Vaciar carrito</button>
    </form>
    <a href="/checkout" class="btn">Finalizar compra</a>
</div>
</main>
    <?php
    layoutEnd();
}
