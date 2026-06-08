<?php
/**
 * Feed de productos en formato Google RSS 2.0 (namespace g:).
 * Sirve tanto para Google Merchant Center (Google Shopping) como para el
 * catálogo de Meta (Facebook/Instagram), que aceptan el mismo formato.
 *
 * Productos variables: se emite una entrada por variación activa, todas con el
 * mismo g:item_group_id (= el producto padre), que es como ambas plataformas
 * agrupan variantes. Se mapean color/talle/material a los campos nativos.
 */

function feedOutputGoogleRss(): void {
    $db = getDB();
    $base = rtrim(shopAbsUrl('/'), '/');
    $siteName = (string) getSetting('site_name', 'Tienda');
    $currency = shopCurrency()['code'];
    $h = fn($s) => htmlspecialchars((string) $s, ENT_QUOTES | ENT_XML1, 'UTF-8');

    echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
    echo '<rss version="2.0" xmlns:g="http://base.google.com/ns/1.0"><channel>' . "\n";
    echo '<title>' . $h($siteName) . "</title>\n";
    echo '<link>' . $h($base) . "</link>\n";
    echo '<description>' . $h('Catálogo de productos de ' . $siteName) . "</description>\n";

    $emit = function (array $it) use ($h, $currency) {
        echo "<item>\n";
        echo '<g:id>' . $h($it['id']) . "</g:id>\n";
        if (!empty($it['group']))  echo '<g:item_group_id>' . $h($it['group']) . "</g:item_group_id>\n";
        echo '<g:title>' . $h(mb_substr($it['title'], 0, 150)) . "</g:title>\n";
        echo '<g:description>' . $h(mb_substr($it['description'], 0, 5000)) . "</g:description>\n";
        echo '<g:link>' . $h($it['link']) . "</g:link>\n";
        if (!empty($it['image'])) echo '<g:image_link>' . $h($it['image']) . "</g:image_link>\n";
        foreach (array_slice($it['extra_images'] ?? [], 0, 10) as $img) {
            echo '<g:additional_image_link>' . $h($img) . "</g:additional_image_link>\n";
        }
        echo '<g:availability>' . $h($it['availability']) . "</g:availability>\n";
        echo '<g:price>' . $h($it['price'] . ' ' . $currency) . "</g:price>\n";
        if (!empty($it['sale_price'])) echo '<g:sale_price>' . $h($it['sale_price'] . ' ' . $currency) . "</g:sale_price>\n";
        echo '<g:condition>' . $h($it['condition']) . "</g:condition>\n";
        echo '<g:brand>' . $h($it['brand']) . "</g:brand>\n";
        if (!empty($it['gtin'])) echo '<g:gtin>' . $h($it['gtin']) . "</g:gtin>\n";
        if (!empty($it['mpn']))  echo '<g:mpn>' . $h($it['mpn']) . "</g:mpn>\n";
        if (empty($it['gtin']) && empty($it['mpn'])) echo "<g:identifier_exists>no</g:identifier_exists>\n";
        if (!empty($it['google_category'])) echo '<g:google_product_category>' . $h($it['google_category']) . "</g:google_product_category>\n";
        if (!empty($it['product_type']))    echo '<g:product_type>' . $h($it['product_type']) . "</g:product_type>\n";
        foreach (['color', 'size', 'material', 'pattern'] as $f) {
            if (!empty($it[$f])) echo '<g:' . $f . '>' . $h($it[$f]) . '</g:' . $f . ">\n";
        }
        echo "</item>\n";
    };

    $avMap = fn($s) => ['in_stock' => 'in_stock', 'out_of_stock' => 'out_of_stock', 'backorder' => 'backorder'][$s] ?? 'in_stock';

    $products = $db->query("SELECT * FROM products WHERE status = 'published' ORDER BY id")->fetchAll();
    foreach ($products as $p) {
        $pid   = (int) $p['id'];
        $link  = shopAbsUrl('/producto/' . $p['slug']);
        $desc  = trim(strip_tags((string) ($p['short_description'] ?: $p['description'])));
        $brand = (string) ($p['brand'] ?: $siteName);
        $cond  = (string) ($p['item_condition'] ?? 'new');

        // Imágenes del producto.
        $imgs = productImages($pid);
        $imgAbs = [];
        foreach ($imgs as $im) $imgAbs[] = shopAbsUrl((string) $im['file_path']);
        $primary = $imgAbs[0] ?? '';
        $extra   = array_slice($imgAbs, 1);

        // product_type = ruta de la primera categoría.
        $ptStmt = $db->prepare(
            'SELECT c.name FROM product_categories pc JOIN categories c ON c.id = pc.category_id
             WHERE pc.product_id = ? ORDER BY c.id LIMIT 1'
        );
        $ptStmt->execute([$pid]);
        $productType = (string) ($ptStmt->fetchColumn() ?: '');

        if (($p['type'] ?? 'simple') !== 'variable') {
            $eff  = productEffectivePrice($p);
            $base = (float) $p['price'];
            $avail = (int) $p['manage_stock'] === 1 && (int) $p['stock_qty'] <= 0 && $p['stock_status'] !== 'backorder'
                ? 'out_of_stock' : $avMap($p['stock_status']);
            $emit([
                'id' => $p['sku'] ?: ('P' . $pid),
                'title' => (string) $p['name'], 'description' => $desc, 'link' => $link,
                'image' => $primary, 'extra_images' => $extra,
                'availability' => $avail,
                'price' => (string) shopAmountForGateway($base),
                'sale_price' => $eff < $base ? (string) shopAmountForGateway($eff) : '',
                'condition' => $cond, 'brand' => $brand,
                'gtin' => (string) ($p['gtin'] ?? ''), 'mpn' => (string) ($p['mpn'] ?? ''),
                'google_category' => (string) ($p['google_category'] ?? ''), 'product_type' => $productType,
            ]);
            continue;
        }

        // Variable: una entrada por variación activa.
        foreach (productVariations($pid) as $v) {
            if (!(int) $v['is_active']) continue;
            $vimg = $primary;
            if (!empty($v['image_id'])) {
                $mi = mediaLibraryGet((int) $v['image_id']);
                if ($mi) $vimg = shopAbsUrl((string) $mi['file_path']);
            }
            $attrs = ['color' => '', 'size' => '', 'material' => '', 'pattern' => ''];
            $labelParts = [];
            foreach ($v['values'] as $val) {
                $labelParts[] = $val['value_label'];
                $aslug = slugify((string) $val['attr_name']);
                if (str_contains($aslug, 'color'))                                   $attrs['color'] = $val['value_label'];
                elseif (in_array($aslug, ['talle', 'talla', 'size', 'tamano'], true)) $attrs['size'] = $val['value_label'];
                elseif (str_contains($aslug, 'material'))                            $attrs['material'] = $val['value_label'];
            }
            $base = (float) $v['price'];
            $eff  = (float) $v['effective'];
            $avail = (int) $v['stock_qty'] <= 0 && $v['stock_status'] !== 'backorder' ? 'out_of_stock' : $avMap($v['stock_status']);
            $emit([
                'id' => $v['sku'] ?: ('V' . (int) $v['id']),
                'group' => 'P' . $pid,
                'title' => $p['name'] . ($labelParts ? ' - ' . implode(' / ', $labelParts) : ''),
                'description' => $desc, 'link' => $link,
                'image' => $vimg, 'extra_images' => $extra,
                'availability' => $avail,
                'price' => (string) shopAmountForGateway($base),
                'sale_price' => $eff < $base ? (string) shopAmountForGateway($eff) : '',
                'condition' => $cond, 'brand' => $brand,
                'gtin' => (string) ($v['gtin'] ?: ($p['gtin'] ?? '')),
                'mpn'  => (string) ($v['mpn'] ?: ($p['mpn'] ?? '')),
                'google_category' => (string) ($p['google_category'] ?? ''), 'product_type' => $productType,
                'color' => $attrs['color'], 'size' => $attrs['size'], 'material' => $attrs['material'],
            ]);
        }
    }

    echo "</channel></rss>\n";
}
