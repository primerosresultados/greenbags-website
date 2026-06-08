<?php
/** Requiere: $shopProducts (['rows','total']), $shopSearch, $shopStatus, $shopPage, $shopPerPage */
$rows  = $shopProducts['rows'] ?? [];
$total = (int) ($shopProducts['total'] ?? 0);
$pages = max(1, (int) ceil($total / max(1, $shopPerPage)));
$msg   = flashGet('shop_msg');
$err   = flashGet('shop_err');
$badge = fn(string $s) => '<span class="shop-badge shop-badge--' . $s . '">'
    . ['draft' => 'Borrador', 'published' => 'Publicado', 'archived' => 'Archivado'][$s] ?? $s . '</span>';
?>
<header class="admin-header">
    <div><h1>Productos</h1><div class="admin-header__sub"><?= $total ?> producto(s)</div></div>
    <a class="btn" href="/admin/?view=product&id=new">+ Nuevo producto</a>
</header>

<?php if ($msg): ?><div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div><?php endif; ?>
<?php if ($err): ?><div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($err) ?></span></div><?php endif; ?>

<form method="get" class="shop-filters">
    <input type="hidden" name="view" value="products">
    <input type="search" name="search" value="<?= htmlspecialchars($shopSearch) ?>" placeholder="Buscar por nombre o SKU…">
    <select name="status">
        <option value="">Todos los estados</option>
        <?php foreach (['draft' => 'Borrador', 'published' => 'Publicado', 'archived' => 'Archivado'] as $k => $v): ?>
            <option value="<?= $k ?>" <?= $shopStatus === $k ? 'selected' : '' ?>><?= $v ?></option>
        <?php endforeach; ?>
    </select>
    <button class="btn btn--ghost" type="submit">Filtrar</button>
</form>

<div class="card" style="padding:0;overflow-x:auto;">
<table class="shop-table">
    <thead><tr><th></th><th>Producto</th><th>SKU</th><th>Precio</th><th>Stock</th><th>Estado</th><th></th></tr></thead>
    <tbody>
    <?php if (!$rows): ?>
        <tr><td colspan="7" style="text-align:center;padding:2rem;color:#6b7280;">No hay productos. <a href="/admin/?view=product&id=new">Creá el primero →</a></td></tr>
    <?php endif; ?>
    <?php foreach ($rows as $p):
        $eff = productEffectivePrice($p);
        $sale = productIsOnSale($p);
    ?>
        <tr>
            <td><?php if (!empty($p['thumb'])): ?><img class="shop-table__thumb" src="<?= htmlspecialchars($p['thumb']) ?>" alt="" loading="lazy"><?php else: ?><span class="shop-table__thumb shop-table__thumb--empty"></span><?php endif; ?></td>
            <td><a href="/admin/?view=product&id=<?= (int) $p['id'] ?>"><strong><?= htmlspecialchars($p['name']) ?></strong></a><?php if ($p['type'] === 'variable'): ?> <small class="text-muted">(variable)</small><?php endif; ?></td>
            <td class="text-muted"><?= htmlspecialchars($p['sku'] ?? '—') ?></td>
            <td><?php if ($sale): ?><span class="shop-price__old"><?= shopFormatPrice($p['price']) ?></span> <?php endif; ?><?= shopFormatPrice($eff) ?></td>
            <td><?= (int) $p['manage_stock'] === 1 ? (int) $p['stock_qty'] : '∞' ?></td>
            <td><?= $badge($p['status']) ?></td>
            <td><a class="btn btn--ghost" href="/admin/?view=product&id=<?= (int) $p['id'] ?>">Editar</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
</div>

<?php if ($pages > 1): ?>
<div class="shop-pagination">
    <?php for ($i = 1; $i <= $pages; $i++):
        $q = http_build_query(array_filter(['view' => 'products', 'search' => $shopSearch, 'status' => $shopStatus, 'page' => $i]));
    ?>
        <a class="<?= $i === $shopPage ? 'is-active' : '' ?>" href="/admin/?<?= $q ?>"><?= $i ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>

<?php require __DIR__ . '/_shop_admin_styles.php'; ?>
