<?php
/** Requiere: $category (record|null), $categoryParentOptions ([id=>label]), $allMedia */
$isNew = empty($category['id']);
$err   = flashGet('shop_err');
$v     = fn(string $k, $d = '') => htmlspecialchars((string) ($category[$k] ?? $d));
$curImg = (int) ($category['image_id'] ?? 0);
?>
<header class="admin-header">
    <div>
        <div style="margin-bottom:.3rem;"><a href="/admin/?view=categories" class="text-muted" style="font-size:.88rem;">← Volver a categorías</a></div>
        <h1><?= $isNew ? 'Nueva categoría' : 'Editar categoría' ?></h1>
    </div>
</header>

<?php if ($err): ?><div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($err) ?></span></div><?php endif; ?>

<form method="post">
    <input type="hidden" name="action" value="cat_save">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
    <input type="hidden" name="id" value="<?= (int) ($category['id'] ?? 0) ?>">

    <div class="card">
        <p class="form__field"><label>Nombre <input name="name" value="<?= $v('name') ?>" required></label></p>
        <p class="form__field"><label>Slug <small class="text-muted">(auto si vacío)</small><input name="slug" value="<?= $v('slug') ?>" pattern="[a-z0-9-]*"></label></p>
        <p class="form__field"><label>Categoría padre
            <select name="parent_id">
                <option value="0">— Ninguna (raíz) —</option>
                <?php foreach ($categoryParentOptions as $cid => $label): ?>
                    <option value="<?= (int) $cid ?>" <?= (int) ($category['parent_id'] ?? 0) === (int) $cid ? 'selected' : '' ?>><?= htmlspecialchars($label) ?></option>
                <?php endforeach; ?>
            </select>
        </label></p>
        <p class="form__field" style="margin:0;"><label>Descripción <small class="text-muted">(HTML permitido)</small>
            <textarea name="description" rows="5"><?= htmlspecialchars((string) ($category['description'] ?? '')) ?></textarea>
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title">Imagen de categoría</h3>
        <?php if (!$allMedia): ?>
            <p class="text-muted">La mediateca está vacía. <a href="/admin/?view=media" target="_blank">Sube imágenes →</a></p>
        <?php else: ?>
            <div class="shop-imgpick">
                <label class="shop-imgpick__item <?= $curImg === 0 ? 'is-on' : '' ?>" style="display:flex;align-items:center;justify-content:center;color:#9ca3af;font-size:.8rem;">
                    <input type="radio" name="image_id" value="0" <?= $curImg === 0 ? 'checked' : '' ?>> Ninguna
                </label>
                <?php foreach ($allMedia as $m): $mid = (int) $m['id']; ?>
                    <label class="shop-imgpick__item <?= $curImg === $mid ? 'is-on' : '' ?>">
                        <input type="radio" name="image_id" value="<?= $mid ?>" <?= $curImg === $mid ? 'checked' : '' ?>>
                        <img src="<?= htmlspecialchars($m['thumb_path'] ?: $m['file_path']) ?>" alt="<?= htmlspecialchars($m['alt'] ?? '') ?>" loading="lazy">
                    </label>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>

    <div class="card">
        <h3 class="card__title">SEO & orden</h3>
        <p class="form__field"><label>Meta título <input name="meta_title" maxlength="255" value="<?= $v('meta_title') ?>"></label></p>
        <p class="form__field"><label>Meta description <input name="meta_description" maxlength="300" value="<?= $v('meta_description') ?>"></label></p>
        <div class="shop-form__row">
            <p class="form__field"><label>Orden <input type="number" name="sort_order" value="<?= htmlspecialchars((string) ($category['sort_order'] ?? '0')) ?>"></label></p>
            <p class="form__field"><label style="display:flex;align-items:center;gap:.5rem;margin-top:1.8rem;">
                <input type="checkbox" name="is_active" value="1" style="width:auto;" <?= $isNew || !empty($category['is_active']) ? 'checked' : '' ?>>
                <span>Activa (visible en el sitio)</span>
            </label></p>
        </div>
    </div>

    <div style="margin-top:1.5rem;display:flex;gap:.5rem;justify-content:space-between;align-items:center;flex-wrap:wrap;">
        <button type="submit" class="btn">Guardar categoría</button>
        <?php if (!$isNew): ?>
            <button type="submit" name="action" value="cat_delete" class="btn btn--danger" onclick="return confirm('¿Eliminar esta categoría? Los productos no se borran.')">Eliminar</button>
        <?php endif; ?>
    </div>
</form>

<?php require __DIR__ . '/_shop_admin_styles.php'; ?>
