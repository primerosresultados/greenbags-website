<?php
/*
 * Listado de cotizaciones recibidas (admin).
 * ------------------------------------------------------------
 * Requiere: $quotes, $quoteStats, $quoteSearch, $quoteStatus, $user
 *
 * Filtros: búsqueda libre (nombre / email / empresa / número) y estado.
 * Acciones: ver detalle, exportar CSV.
 * ------------------------------------------------------------
 */
$statuses = QUOTE_STATUSES;
$statusLabels = [
    'submitted' => 'Recibidas',
    'responded' => 'Respondidas',
    'won'       => 'Ganadas',
    'lost'      => 'Perdidas',
    'expired'   => 'Expiradas',
    'draft'     => 'Borrador',
];
$qMsg = flashGet('quote_msg');
$qErr = flashGet('quote_err');
?>
<header class="admin-header">
    <div>
        <h1>Cotizaciones</h1>
        <div class="admin-header__sub">Solicitudes recibidas desde el sitio.</div>
    </div>
    <div class="admin-header__actions">
        <a class="btn btn--secondary" href="/admin/?action=quote_export_csv&amp;<?= http_build_query(['search' => $quoteSearch, 'status' => $quoteStatus]) ?>">
            Exportar CSV
        </a>
    </div>
</header>

<?php if ($qMsg): ?><div class="alert alert--ok"><?= htmlspecialchars($qMsg) ?></div><?php endif; ?>
<?php if ($qErr): ?><div class="alert alert--error"><?= htmlspecialchars($qErr) ?></div><?php endif; ?>

<div class="stats">
    <div class="stat"><div class="stat__label">Sin responder</div><div class="stat__value"><?= (int) ($quoteStats['new_count'] ?? 0) ?></div></div>
    <div class="stat"><div class="stat__label">Respondidas</div><div class="stat__value"><?= (int) ($quoteStats['responded_count'] ?? 0) ?></div></div>
    <div class="stat"><div class="stat__label">Ganadas</div><div class="stat__value"><?= (int) ($quoteStats['won_count'] ?? 0) ?></div></div>
    <div class="stat"><div class="stat__label">Hoy</div><div class="stat__value"><?= (int) ($quoteStats['today_count'] ?? 0) ?></div></div>
</div>

<form method="get" class="filters">
    <input type="hidden" name="view" value="quotes">
    <div class="filters__group">
        <label for="search">Buscar</label>
        <input type="search" id="search" name="search" value="<?= htmlspecialchars($quoteSearch) ?>" placeholder="Nombre, email, empresa o número">
    </div>
    <div class="filters__group">
        <label for="status">Estado</label>
        <select id="status" name="status">
            <option value="">Todos</option>
            <?php foreach ($statuses as $s): if ($s === 'draft') continue; ?>
                <option value="<?= $s ?>" <?= $quoteStatus === $s ? 'selected' : '' ?>>
                    <?= htmlspecialchars($statusLabels[$s] ?? $s) ?>
                </option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="filters__group filters__group--actions">
        <button type="submit" class="btn">Filtrar</button>
        <?php if ($quoteSearch !== '' || $quoteStatus !== ''): ?>
            <a href="/admin/?view=quotes" class="btn btn--ghost">Limpiar</a>
        <?php endif; ?>
    </div>
</form>

<?php if (empty($quotes)): ?>
    <div class="empty">
        <h3>Todavía no hay cotizaciones</h3>
        <p>Las solicitudes de cotización del sitio van a aparecer acá.</p>
    </div>
<?php else: ?>
    <table class="table">
        <thead>
            <tr>
                <th style="width:130px;">Número</th>
                <th>Enviada</th>
                <th>Empresa / Nombre</th>
                <th>Email</th>
                <th style="width:60px;text-align:right;">Ítems</th>
                <th style="width:120px;">Estimado</th>
                <th>Estado</th>
                <th style="width:60px;"></th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($quotes as $q): ?>
                <tr>
                    <td class="text-tabular"><strong><?= htmlspecialchars($q['quote_number'] ?? '—') ?></strong></td>
                    <td class="text-muted text-tabular"><?= htmlspecialchars($q['submitted_at'] ?: $q['created_at']) ?></td>
                    <td>
                        <?php if (!empty($q['contact_company'])): ?>
                            <strong><?= htmlspecialchars($q['contact_company']) ?></strong><br>
                            <span class="text-muted" style="font-size:.85rem;"><?= htmlspecialchars($q['contact_name']) ?></span>
                        <?php else: ?>
                            <strong><?= htmlspecialchars($q['contact_name']) ?></strong>
                        <?php endif; ?>
                    </td>
                    <td><?= htmlspecialchars($q['contact_email']) ?></td>
                    <td class="text-tabular" style="text-align:right;"><?= (int) $q['items_count'] ?></td>
                    <td class="text-tabular">
                        <?php if ($q['subtotal_est'] !== null && (float) $q['subtotal_est'] > 0): ?>
                            <?= function_exists('shopFormatPrice') ? shopFormatPrice($q['subtotal_est']) : htmlspecialchars((string) $q['subtotal_est']) ?>
                        <?php else: ?>
                            <span class="text-muted">—</span>
                        <?php endif; ?>
                    </td>
                    <td><span class="badge badge--<?= htmlspecialchars($q['status']) ?>"><?= htmlspecialchars($statusLabels[$q['status']] ?? $q['status']) ?></span></td>
                    <td><a href="/admin/?view=quote&amp;id=<?= (int) $q['id'] ?>">Ver →</a></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
<?php endif; ?>
