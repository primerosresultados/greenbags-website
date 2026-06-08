<?php /** Requiere: $banners (array) */ ?>
<header class="admin-header">
    <div>
        <h1>Banners del hero</h1>
        <div class="admin-header__sub">Carrusel del bloque destacado de la home. Arrastrá el orden con <code>sort_order</code>.</div>
    </div>
    <a href="/admin/?view=banner&id=new" class="btn">+ Nuevo banner</a>
</header>

<?php if ($msg = flashGet('banner_msg')): ?>
    <div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>
<?php if ($msg = flashGet('banner_err')): ?>
    <div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

<?php if (!$banners): ?>
    <div class="card" style="text-align:center;padding:2.5rem 1rem;">
        <p class="text-muted" style="margin:0 0 .8rem;">Todavía no creaste banners. La home muestra los textos por defecto de "Página de inicio".</p>
        <a href="/admin/?view=banner&id=new" class="btn">Crear el primero</a>
    </div>
<?php else: ?>
    <div class="card" style="padding:0;overflow:hidden;">
        <table class="adminbl-table" style="width:100%;border-collapse:collapse;">
            <thead>
                <tr style="background:#f8fafc;text-align:left;">
                    <th style="padding:.8rem 1rem;font-size:.78rem;text-transform:uppercase;color:#64748b;letter-spacing:.04em;">Imagen</th>
                    <th style="padding:.8rem 1rem;font-size:.78rem;text-transform:uppercase;color:#64748b;letter-spacing:.04em;">Título</th>
                    <th style="padding:.8rem 1rem;font-size:.78rem;text-transform:uppercase;color:#64748b;letter-spacing:.04em;">CTA</th>
                    <th style="padding:.8rem 1rem;font-size:.78rem;text-transform:uppercase;color:#64748b;letter-spacing:.04em;">Orden</th>
                    <th style="padding:.8rem 1rem;font-size:.78rem;text-transform:uppercase;color:#64748b;letter-spacing:.04em;">Estado</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($banners as $b): ?>
                    <tr style="border-top:1px solid #eef0f2;">
                        <td style="padding:.7rem 1rem;width:100px;">
                            <?php if (!empty($b['image_path'])): ?>
                                <img src="<?= htmlspecialchars($b['image_path']) ?>" alt="" style="width:80px;height:48px;object-fit:cover;border-radius:6px;display:block;">
                            <?php else: ?>
                                <span style="display:inline-block;width:80px;height:48px;background:linear-gradient(135deg,#0f172a,#334155);border-radius:6px;"></span>
                            <?php endif; ?>
                        </td>
                        <td style="padding:.7rem 1rem;">
                            <strong style="display:block;color:#0f172a;"><?= htmlspecialchars($b['title']) ?></strong>
                            <?php if (!empty($b['eyebrow'])): ?>
                                <small class="text-muted"><?= htmlspecialchars($b['eyebrow']) ?></small>
                            <?php endif; ?>
                        </td>
                        <td style="padding:.7rem 1rem;font-size:.88rem;color:#475569;">
                            <?php if (!empty($b['cta_label'])): ?>
                                <?= htmlspecialchars($b['cta_label']) ?>
                                <br><small class="text-muted"><?= htmlspecialchars((string) ($b['cta_url'] ?? '')) ?></small>
                            <?php else: ?>
                                <span class="text-muted">—</span>
                            <?php endif; ?>
                        </td>
                        <td style="padding:.7rem 1rem;color:#64748b;"><?= (int) $b['sort_order'] ?></td>
                        <td style="padding:.7rem 1rem;">
                            <form method="post" style="margin:0;">
                                <input type="hidden" name="action" value="banner_toggle">
                                <input type="hidden" name="id" value="<?= (int) $b['id'] ?>">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <button type="submit" class="btn btn--ghost" style="padding:.35rem .7rem;font-size:.8rem;">
                                    <?= (int) $b['is_active'] === 1 ? '✓ Activo' : '○ Inactivo' ?>
                                </button>
                            </form>
                        </td>
                        <td style="padding:.7rem 1rem;text-align:right;white-space:nowrap;">
                            <a href="/admin/?view=banner&id=<?= (int) $b['id'] ?>" class="btn btn--ghost" style="padding:.35rem .7rem;font-size:.8rem;">Editar</a>
                            <form method="post" style="display:inline-block;margin:0;" onsubmit="return confirm('¿Eliminar este banner?');">
                                <input type="hidden" name="action" value="banner_delete">
                                <input type="hidden" name="id" value="<?= (int) $b['id'] ?>">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <button type="submit" class="btn btn--danger" style="padding:.35rem .7rem;font-size:.8rem;">Eliminar</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
<?php endif; ?>
