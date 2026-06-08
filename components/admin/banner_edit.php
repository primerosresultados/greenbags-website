<?php
/** Requiere: $banner (?array), $allMedia (array) */
$isNew = !$banner;
$b = $banner ?? [
    'id' => 0, 'eyebrow' => '', 'title' => '', 'subtitle' => '',
    'image_id' => null, 'image_path' => '',
    'cta_label' => '', 'cta_url' => '', 'text_align' => 'left',
    'sort_order' => 0, 'is_active' => 1,
];
?>
<header class="admin-header">
    <div>
        <h1><?= $isNew ? 'Nuevo banner' : 'Editar banner' ?></h1>
        <div class="admin-header__sub"><a href="/admin/?view=banners">← Volver a banners</a></div>
    </div>
</header>

<?php if ($msg = flashGet('banner_err')): ?>
    <div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

<form method="post">
    <input type="hidden" name="action" value="banner_save">
    <input type="hidden" name="id" value="<?= (int) $b['id'] ?>">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">

    <div class="card">
        <h3 class="card__title">Contenido</h3>
        <p class="form__field"><label>Eyebrow <small class="text-muted">(texto pequeño arriba del título)</small>
            <input name="eyebrow" maxlength="120" value="<?= htmlspecialchars((string) ($b['eyebrow'] ?? '')) ?>" placeholder="Nueva colección">
        </label></p>
        <p class="form__field"><label>Título <span class="form-required">*</span>
            <input name="title" maxlength="200" required value="<?= htmlspecialchars((string) $b['title']) ?>" placeholder="Verano 2026">
        </label></p>
        <p class="form__field" style="margin:0;"><label>Subtítulo
            <textarea name="subtitle" rows="2" maxlength="400"><?= htmlspecialchars((string) ($b['subtitle'] ?? '')) ?></textarea>
        </label></p>
    </div>

    <div class="card">
        <h3 class="card__title">Imagen de fondo</h3>
        <p class="text-muted" style="margin:0 0 .8rem;font-size:.88rem;">Opcional. Si no se asigna, el banner usa el gradient oscuro por defecto.</p>
        <?php
            $sifName  = 'image_id';
            $sifValue = (string) ($b['image_id'] ?? '');
            $sifLabel = '';
            $sifPlaceholder = '';
            require __DIR__ . '/_single_image_field.php';
        ?>
    </div>

    <div class="card">
        <h3 class="card__title">Botón (CTA)</h3>
        <div style="display:grid;gap:.8rem;grid-template-columns:1fr 1fr;">
            <p class="form__field"><label>Texto del botón
                <input name="cta_label" maxlength="80" value="<?= htmlspecialchars((string) ($b['cta_label'] ?? '')) ?>" placeholder="Ver colección">
            </label></p>
            <p class="form__field"><label>URL del botón
                <input name="cta_url" maxlength="255" value="<?= htmlspecialchars((string) ($b['cta_url'] ?? '')) ?>" placeholder="/tienda">
            </label></p>
        </div>
    </div>

    <div class="card">
        <h3 class="card__title">Diseño</h3>
        <p class="form__field"><label>Alineación del texto
            <select name="text_align">
                <?php foreach (['left' => 'Izquierda', 'center' => 'Centrada', 'right' => 'Derecha'] as $k => $lbl): ?>
                    <option value="<?= $k ?>" <?= ($b['text_align'] ?? 'left') === $k ? 'selected' : '' ?>><?= $lbl ?></option>
                <?php endforeach; ?>
            </select>
        </label></p>
        <div style="display:grid;gap:.8rem;grid-template-columns:1fr 1fr;align-items:end;">
            <p class="form__field"><label>Orden (menor = antes)
                <input type="number" name="sort_order" value="<?= (int) $b['sort_order'] ?>" min="0">
            </label></p>
            <p class="form__field" style="margin:0;">
                <label style="display:flex;align-items:center;gap:.5rem;">
                    <input type="checkbox" name="is_active" value="1" <?= (int) $b['is_active'] === 1 ? 'checked' : '' ?> style="width:auto;">
                    <span>Banner activo (visible en la home)</span>
                </label>
            </p>
        </div>
    </div>

    <div style="margin-top:1.5rem;display:flex;gap:.5rem;justify-content:space-between;align-items:center;flex-wrap:wrap;">
        <button type="submit" class="btn">Guardar</button>
        <?php if (!$isNew): ?>
            <form method="post" style="margin:0;" onsubmit="return confirm('¿Eliminar este banner? La acción no se puede deshacer.');">
                <input type="hidden" name="action" value="banner_delete">
                <input type="hidden" name="id" value="<?= (int) $b['id'] ?>">
                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                <button type="submit" class="btn btn--danger">Eliminar banner</button>
            </form>
        <?php endif; ?>
    </div>
</form>
