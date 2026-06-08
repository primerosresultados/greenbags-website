<?php
/** Requiere: $categories (categoryList con products_count) */
$msg = flashGet('shop_msg');
$err = flashGet('shop_err');
?>
<header class="admin-header">
    <div><h1>Categorías</h1><div class="admin-header__sub"><?= count($categories) ?> categoría(s)</div></div>
    <a class="btn" href="/admin/?view=category&id=new">+ Nueva categoría</a>
</header>

<?php if ($msg): ?><div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div><?php endif; ?>
<?php if ($err): ?><div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($err) ?></span></div><?php endif; ?>

<div class="card" style="padding:0;overflow-x:auto;">
<table class="shop-table">
    <thead><tr><th>Nombre</th><th>Slug</th><th>Productos</th><th>Estado</th><th></th></tr></thead>
    <tbody>
    <?php if (!$categories): ?>
        <tr><td colspan="5" style="text-align:center;padding:2rem;color:#6b7280;">No hay categorías. <a href="/admin/?view=category&id=new">Creá la primera →</a></td></tr>
    <?php endif; ?>
    <?php foreach ($categories as $c): ?>
        <tr>
            <td><a href="/admin/?view=category&id=<?= (int) $c['id'] ?>"><strong><?= htmlspecialchars($c['name']) ?></strong></a></td>
            <td class="text-muted">/categoria/<?= htmlspecialchars($c['slug']) ?></td>
            <td><?= (int) $c['products_count'] ?></td>
            <td><?= (int) $c['is_active'] ? '<span class="shop-badge shop-badge--published">Activa</span>' : '<span class="shop-badge shop-badge--archived">Inactiva</span>' ?></td>
            <td><a class="btn btn--ghost" href="/admin/?view=category&id=<?= (int) $c['id'] ?>">Editar</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
</div>

<?php require __DIR__ . '/_shop_admin_styles.php'; ?>
