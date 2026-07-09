<?php
/** Requiere: $pages (array) */
?>
<header class="admin-header">
    <div>
        <h1>Páginas</h1>
        <div class="admin-header__sub">Contenido estático accesible desde /slug.</div>
    </div>
    <div class="admin-header__actions">
        <a class="btn" href="/admin/?view=page&amp;id=new">+ Nueva página</a>
    </div>
</header>

<?php if ($msg = flashGet('page_success')): ?>
    <div class="auth-alert auth-alert--success"><span><?= htmlspecialchars($msg) ?></span></div>
<?php endif; ?>

    <table class="table">
        <thead>
            <tr>
                <th>Slug</th>
                <th>Título</th>
                <th style="width:120px;">Estado</th>
                <th style="width:170px;">Actualizada</th>
                <th style="width:120px;"></th>
            </tr>
        </thead>
        <tbody>
            <!-- Inicio: no es una página del CMS, se edita en su propia vista. -->
            <tr style="background:#f8fafc;">
                <td><code>/</code></td>
                <td><strong>🏠 Inicio</strong><br><small class="text-muted">Página principal (hero, marca, clientes, cotización)</small></td>
                <td><span class="badge badge--qualified">principal</span></td>
                <td class="text-muted">—</td>
                <td>
                    <a href="/admin/?view=home_edit">Editar</a>
                     · <a href="/" target="_blank">Ver →</a>
                </td>
            </tr>
            <?php foreach ($pages as $p): ?>
                <tr>
                    <td><code><?= htmlspecialchars($p['slug']) ?></code></td>
                    <td><strong><?= htmlspecialchars($p['title']) ?></strong></td>
                    <td>
                        <?php if ((int) $p['is_published']): ?>
                            <span class="badge badge--qualified">publicada</span>
                        <?php else: ?>
                            <span class="badge badge--closed">borrador</span>
                        <?php endif; ?>
                    </td>
                    <td class="text-muted text-tabular"><?= htmlspecialchars($p['updated_at']) ?></td>
                    <td>
                        <a href="/admin/?view=page&amp;id=<?= (int) $p['id'] ?>">Editar</a>
                        <?php if ((int) $p['is_published']): ?>
                             · <a href="/<?= htmlspecialchars($p['slug']) ?>" target="_blank">Ver →</a>
                        <?php endif; ?>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
