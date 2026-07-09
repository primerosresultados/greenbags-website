<?php
/** Requiere: $client (?array) */
$isNew = !$client;
$c = $client ?? [
    'id' => 0, 'name' => '', 'logo_path' => '',
    'sort_order' => 0, 'is_active' => 1,
];
?>
<header class="admin-header">
    <div>
        <div style="margin-bottom:.3rem;"><a href="/admin/?view=clients" class="text-muted" style="font-size:.88rem;">← Volver a clientes</a></div>
        <h1><?= $isNew ? '🤝 Nuevo cliente' : '🤝 Editar cliente' ?></h1>
        <div class="admin-header__sub">Nombre y logo del cliente para la marquesina del home.</div>
    </div>
</header>

<?php if ($msg = flashGet('client_err')): ?>
    <div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

<style>
.form-control { display:block; width:100%; padding:.75rem 1rem; font-size:.95rem; border:2px solid #e5e7eb; border-radius:8px; transition:all .2s ease; font-family:inherit; background:#fff; box-sizing:border-box; }
.form-control:focus { outline:0; border-color:#0f172a; box-shadow:0 0 0 3px rgba(15,23,42,.1); }
.form-label { display:block; font-weight:600; margin-bottom:.6rem; color:#1f2937; font-size:.95rem; }
.form-hint { display:block; font-size:.85rem; color:#6b7280; margin-top:.4rem; line-height:1.5; }
.form-required { color:#dc2626; font-weight:700; }
.form-group { margin-bottom:1.5rem; }
.form-group:last-child { margin-bottom:0; }
.form-row { display:grid; gap:1.5rem; grid-template-columns:repeat(auto-fit,minmax(260px,1fr)); }
.checkbox-wrapper { display:flex; align-items:center; gap:.75rem; padding:.85rem 1rem; background:#f9fafb; border:2px solid #e5e7eb; border-radius:8px; }
.checkbox-wrapper input[type="checkbox"] { width:20px; height:20px; accent-color:#0f172a; cursor:pointer; flex-shrink:0; }
.checkbox-wrapper label { cursor:pointer; user-select:none; font-weight:500; margin:0; flex:1; }
.settings-section-hint { padding:.75rem 1rem; background:#f0f9ff; border-left:3px solid #0f172a; border-radius:4px; font-size:.9rem; color:#1f2937; line-height:1.6; margin-bottom:1.5rem; }
.client-actions { margin-top:2rem; padding-top:1.75rem; border-top:1px solid #e5e7eb; display:flex; gap:.75rem; justify-content:space-between; align-items:center; flex-wrap:wrap; }
</style>

<form method="post" id="client-form">
    <input type="hidden" name="action" value="client_save">
    <input type="hidden" name="id" value="<?= (int) $c['id'] ?>">
    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">

    <div class="card">
        <h3 class="card__title">📝 Datos</h3>
        <div class="form-group">
            <label class="form-label">Nombre del cliente <span class="form-required">*</span></label>
            <input class="form-control" name="name" maxlength="160" required value="<?= htmlspecialchars((string) $c['name']) ?>" placeholder="Ají Seco">
            <span class="form-hint">Se usa como texto alternativo del logo. Obligatorio.</span>
        </div>
    </div>

    <div class="card">
        <h3 class="card__title">🖼️ Logo</h3>
        <div class="settings-section-hint">
            Recomendado: PNG o SVG con fondo transparente. Se muestra en la marquesina de "Nuestros clientes".
        </div>
        <?php
            $sifName  = 'logo_path';
            $sifValue = (string) ($c['logo_path'] ?? '');
            $sifLabel = '';
            $sifPlaceholder = '/uploads/library/...png';
            require __DIR__ . '/_single_image_field.php';
        ?>
    </div>

    <div class="card">
        <h3 class="card__title">⚙️ Opciones</h3>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Orden de aparición</label>
                <input class="form-control" type="number" name="sort_order" value="<?= (int) $c['sort_order'] ?>" min="0">
                <span class="form-hint">Menor número aparece antes.</span>
            </div>
            <div class="form-group">
                <label class="form-label">Visibilidad</label>
                <div class="checkbox-wrapper">
                    <input type="checkbox" id="is_active" name="is_active" value="1" <?= (int) $c['is_active'] === 1 ? 'checked' : '' ?>>
                    <label for="is_active">Cliente activo (visible en la home)</label>
                </div>
            </div>
        </div>
    </div>

</form>

<!-- Acciones fuera del <form> principal: el botón Guardar se asocia por
     form="client-form" y el de Eliminar es un form independiente. Así se
     evita anidar forms (HTML inválido) que mezclaba las dos acciones. -->
<div class="client-actions">
    <button type="submit" form="client-form" class="btn" style="padding:.85rem 2rem;font-size:.95rem;font-weight:600;">Guardar cliente</button>
    <?php if (!$isNew): ?>
        <form method="post" style="margin:0;" onsubmit="return confirm('¿Eliminar este cliente? La acción no se puede deshacer.');">
            <input type="hidden" name="action" value="client_delete">
            <input type="hidden" name="id" value="<?= (int) $c['id'] ?>">
            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
            <button type="submit" class="btn btn--danger">Eliminar cliente</button>
        </form>
    <?php endif; ?>
</div>
