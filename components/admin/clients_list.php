<?php /** Requiere: $clients (array) */ ?>
<header class="admin-header">
    <div>
        <h1>Nuestros clientes</h1>
        <div class="admin-header__sub">Logos que se muestran en la marquesina del home. Cada cliente con su nombre y su logo. Menor <code>orden</code> aparece antes.</div>
    </div>
    <a href="/admin/?view=client&id=new" class="btn">+ Nuevo cliente</a>
</header>

<?php if ($msg = flashGet('client_msg')): ?>
    <div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>
<?php if ($msg = flashGet('client_err')): ?>
    <div class="auth-alert auth-alert--error"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

<?php if (!$clients): ?>
    <div class="card" style="text-align:center;padding:2.5rem 1rem;">
        <p class="text-muted" style="margin:0 0 .8rem;">Todavía no hay clientes cargados.</p>
        <a href="/admin/?view=client&id=new" class="btn">Crear el primero</a>
    </div>
<?php else: ?>
    <div class="card" style="padding:0;overflow:hidden;">
        <table class="adminbl-table" style="width:100%;border-collapse:collapse;">
            <thead>
                <tr style="background:#f8fafc;text-align:left;">
                    <th style="padding:.8rem 1rem;font-size:.78rem;text-transform:uppercase;color:#64748b;letter-spacing:.04em;">Logo</th>
                    <th style="padding:.8rem 1rem;font-size:.78rem;text-transform:uppercase;color:#64748b;letter-spacing:.04em;">Nombre</th>
                    <th style="padding:.8rem 1rem;font-size:.78rem;text-transform:uppercase;color:#64748b;letter-spacing:.04em;">Orden</th>
                    <th style="padding:.8rem 1rem;font-size:.78rem;text-transform:uppercase;color:#64748b;letter-spacing:.04em;">Estado</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($clients as $c): ?>
                    <tr style="border-top:1px solid #eef0f2;">
                        <td style="padding:.7rem 1rem;width:120px;">
                            <?php if (!empty($c['logo_path'])): ?>
                                <img src="<?= htmlspecialchars($c['logo_path']) ?>" alt="" style="width:96px;height:48px;object-fit:contain;background:#f8fafc;border:1px solid #eef0f2;border-radius:6px;display:block;padding:4px;">
                            <?php else: ?>
                                <span style="display:inline-flex;align-items:center;justify-content:center;width:96px;height:48px;background:#fef3c7;color:#92400e;border-radius:6px;font-size:.72rem;font-weight:600;">Sin logo</span>
                            <?php endif; ?>
                        </td>
                        <td style="padding:.7rem 1rem;">
                            <strong style="display:block;color:#0f172a;"><?= htmlspecialchars($c['name']) ?></strong>
                        </td>
                        <td style="padding:.7rem 1rem;color:#64748b;"><?= (int) $c['sort_order'] ?></td>
                        <td style="padding:.7rem 1rem;">
                            <form method="post" style="margin:0;">
                                <input type="hidden" name="action" value="client_toggle">
                                <input type="hidden" name="id" value="<?= (int) $c['id'] ?>">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <button type="submit" class="btn btn--ghost" style="padding:.35rem .7rem;font-size:.8rem;">
                                    <?= (int) $c['is_active'] === 1 ? '✓ Activo' : '○ Inactivo' ?>
                                </button>
                            </form>
                        </td>
                        <td style="padding:.7rem 1rem;text-align:right;white-space:nowrap;">
                            <a href="/admin/?view=client&id=<?= (int) $c['id'] ?>" class="btn btn--ghost" style="padding:.35rem .7rem;font-size:.8rem;">Editar</a>
                            <form method="post" style="display:inline-block;margin:0;" onsubmit="return confirm('¿Eliminar este cliente?');">
                                <input type="hidden" name="action" value="client_delete">
                                <input type="hidden" name="id" value="<?= (int) $c['id'] ?>">
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
