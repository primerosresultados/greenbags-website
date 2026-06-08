<?php
/*
 * Detalle de cotización (admin).
 * ------------------------------------------------------------
 * Requiere: $quote, $quoteItemsList, $quoteNotesList, $quoteHistory, $user
 *
 * Bloques:
 *   - Cabecera con número, estado y datos del solicitante.
 *   - Tabla de ítems (con SKU, qty, precio estimado y notas del cliente).
 *   - Cambio de estado (workflow draft → submitted → responded → won|lost).
 *   - Form para enviar la respuesta por email (asunto + cuerpo).
 *   - Notas internas + historial de estados.
 * ------------------------------------------------------------
 */
$statusLabels = [
    'submitted' => 'Recibida',
    'responded' => 'Respondida',
    'won'       => 'Ganada',
    'lost'      => 'Perdida',
    'expired'   => 'Expirada',
    'draft'     => 'Borrador',
];
$qMsg = flashGet('quote_msg');
$qErr = flashGet('quote_err');

$defaultSubj = 'Cotización ' . ($quote['quote_number'] ?? '') . ' — ' . getSetting('site_name', 'Mi Sitio');
$defaultBody = "Hola " . ($quote['contact_name'] ?? '') . ",\n\n"
             . "Gracias por solicitarnos una cotización. Adjuntamos a continuación los detalles:\n\n"
             . "[ ESCRIBÍ ACÁ TU PROPUESTA: precios, condiciones de pago, plazos, descuentos por volumen, etc. ]\n\n"
             . "Si tenés dudas, podemos ayudarte por WhatsApp o teléfono.\n\n"
             . "Saludos,\n"
             . "Equipo " . getSetting('site_name', 'Mi Sitio');
?>
<header class="admin-header">
    <div>
        <div style="margin-bottom:.3rem;">
            <a href="/admin/?view=quotes" class="text-muted" style="font-size:.88rem;">← Volver a cotizaciones</a>
        </div>
        <h1>
            <?= htmlspecialchars($quote['quote_number'] ?? ('Cotización #' . (int) $quote['id'])) ?>
            <span class="badge badge--<?= htmlspecialchars($quote['status']) ?>" style="font-size:.7rem;vertical-align:middle;">
                <?= htmlspecialchars($statusLabels[$quote['status']] ?? $quote['status']) ?>
            </span>
        </h1>
        <div class="admin-header__sub">
            Enviada <?= htmlspecialchars($quote['submitted_at'] ?: $quote['created_at']) ?>
            <?php if (!empty($quote['expires_at'])): ?>
                · Expira <?= htmlspecialchars($quote['expires_at']) ?>
            <?php endif; ?>
        </div>
    </div>
    <div class="admin-header__actions">
        <a class="btn btn--secondary" href="mailto:<?= htmlspecialchars((string) $quote['contact_email']) ?>?subject=<?= rawurlencode((string) $defaultSubj) ?>">
            Responder por email
        </a>
        <?php
        $waLink = !empty($quote['contact_phone'])
            ? whatsappLink((string) $quote['contact_phone'], 'Hola ' . $quote['contact_name'] . ', te escribimos por tu cotización ' . ($quote['quote_number'] ?? ''))
            : '';
        ?>
        <?php if ($waLink): ?>
            <a class="btn btn--secondary" href="<?= htmlspecialchars($waLink) ?>" target="_blank" rel="noopener">WhatsApp</a>
        <?php endif; ?>
    </div>
</header>

<?php if ($qMsg): ?><div class="alert alert--ok"><?= htmlspecialchars($qMsg) ?></div><?php endif; ?>
<?php if ($qErr): ?><div class="alert alert--error"><?= htmlspecialchars($qErr) ?></div><?php endif; ?>

<div class="lead-detail">
    <dl>
        <dt>Nombre</dt>      <dd><strong><?= htmlspecialchars((string) $quote['contact_name']) ?></strong></dd>
        <?php if (!empty($quote['contact_company'])): ?>
            <dt>Empresa</dt> <dd><?= htmlspecialchars((string) $quote['contact_company']) ?></dd>
        <?php endif; ?>
        <?php if (!empty($quote['contact_taxid'])): ?>
            <dt>RUT</dt>     <dd class="text-tabular"><?= htmlspecialchars((string) $quote['contact_taxid']) ?></dd>
        <?php endif; ?>
        <?php if (!empty($quote['contact_position'])): ?>
            <dt>Cargo</dt>   <dd><?= htmlspecialchars((string) $quote['contact_position']) ?></dd>
        <?php endif; ?>
        <dt>Email</dt>       <dd><a href="mailto:<?= htmlspecialchars((string) $quote['contact_email']) ?>"><?= htmlspecialchars((string) $quote['contact_email']) ?></a></dd>
        <dt>Teléfono</dt>    <dd><?= htmlspecialchars((string) $quote['contact_phone']) ?: '—' ?></dd>
        <?php if (!empty($quote['contact_city']) || !empty($quote['contact_region'])): ?>
            <dt>Ubicación</dt><dd><?= htmlspecialchars(trim((string) $quote['contact_city'] . ' ' . (string) $quote['contact_region'])) ?></dd>
        <?php endif; ?>
        <?php if (!empty($quote['message'])): ?>
            <dt>Mensaje</dt> <dd><?= nl2br(htmlspecialchars((string) $quote['message'])) ?></dd>
        <?php endif; ?>
        <dt>IP</dt>          <dd class="text-muted"><?= htmlspecialchars((string) $quote['ip_address']) ?: '—' ?></dd>
    </dl>
</div>

<section class="admin-section">
    <h2>Ítems solicitados (<?= count($quoteItemsList) ?>)</h2>
    <?php if (empty($quoteItemsList)): ?>
        <p class="text-muted">No agregaron productos del catálogo — la solicitud se hizo por el mensaje libre.</p>
    <?php else: ?>
        <table class="table">
            <thead>
                <tr>
                    <th style="width:60px;">Cant.</th>
                    <th>Producto</th>
                    <th>SKU</th>
                    <th>Precio est.</th>
                    <th>Notas del cliente</th>
                </tr>
            </thead>
            <tbody>
                <?php $totalEst = 0; foreach ($quoteItemsList as $it): ?>
                    <tr>
                        <td class="text-tabular" style="text-align:right;"><strong><?= (int) $it['qty'] ?></strong></td>
                        <td>
                            <?php if (!empty($it['product_slug'])): ?>
                                <a href="/producto/<?= htmlspecialchars($it['product_slug']) ?>" target="_blank" rel="noopener">
                                    <?= htmlspecialchars((string) $it['name_snapshot']) ?>
                                </a>
                            <?php else: ?>
                                <?= htmlspecialchars((string) $it['name_snapshot']) ?>
                                <span class="text-muted" style="font-size:.85rem;">(libre)</span>
                            <?php endif; ?>
                        </td>
                        <td class="text-muted text-tabular"><?= htmlspecialchars((string) $it['sku_snapshot']) ?: '—' ?></td>
                        <td class="text-tabular">
                            <?php if ($it['unit_price_est'] !== null): $totalEst += (float) $it['unit_price_est'] * (int) $it['qty']; ?>
                                <?= function_exists('shopFormatPrice') ? shopFormatPrice($it['unit_price_est']) : htmlspecialchars((string) $it['unit_price_est']) ?>
                            <?php else: ?>
                                <span class="text-muted">a cotizar</span>
                            <?php endif; ?>
                        </td>
                        <td class="text-muted" style="font-size:.9rem;">
                            <?= nl2br(htmlspecialchars((string) ($it['item_notes'] ?? ''))) ?: '—' ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
            <?php if ($totalEst > 0): ?>
                <tfoot>
                    <tr>
                        <td colspan="3" style="text-align:right;"><strong>Estimado (precios catálogo)</strong></td>
                        <td class="text-tabular"><strong><?= function_exists('shopFormatPrice') ? shopFormatPrice($totalEst) : (string) $totalEst ?></strong></td>
                        <td></td>
                    </tr>
                </tfoot>
            <?php endif; ?>
        </table>
        <p class="text-muted" style="font-size:.85rem;margin-top:.4rem;">
            Los precios de catálogo son referenciales — la cotización final puede contemplar descuentos por volumen,
            condiciones de pago y otros ajustes.
        </p>
    <?php endif; ?>
</section>

<section class="admin-section">
    <h2>Cambiar estado</h2>
    <form method="post" class="inline-form" style="margin:0;">
        <input type="hidden" name="action" value="quote_update_status">
        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
        <input type="hidden" name="id" value="<?= (int) $quote['id'] ?>">
        <select name="status">
            <?php foreach (QUOTE_STATUSES as $s): if ($s === 'draft') continue; ?>
                <option value="<?= $s ?>" <?= $quote['status'] === $s ? 'selected' : '' ?>>
                    <?= htmlspecialchars($statusLabels[$s] ?? $s) ?>
                </option>
            <?php endforeach; ?>
        </select>
        <button type="submit" class="btn">Guardar</button>
    </form>
</section>

<section class="admin-section">
    <h2>Enviar respuesta por email</h2>
    <p class="text-muted" style="margin:0 0 .8rem;font-size:.9rem;">
        Se envía a <strong><?= htmlspecialchars((string) $quote['contact_email']) ?></strong>.
        Acepta plantillas: <code>{{contact_name}}</code>, <code>{{quote_number}}</code>, <code>{{items_list}}</code>, <code>{{site_name}}</code>, <code>{{business_phone}}</code>, etc.
    </p>
    <form method="post" style="margin:0;">
        <input type="hidden" name="action" value="quote_send_response">
        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
        <input type="hidden" name="id" value="<?= (int) $quote['id'] ?>">
        <p class="form__field">
            <label>Asunto<br>
                <input type="text" name="subject" value="<?= htmlspecialchars($defaultSubj) ?>" required>
            </label>
        </p>
        <p class="form__field">
            <label>Cuerpo del email<br>
                <textarea name="body" rows="10" required><?= htmlspecialchars($quote['response_text'] ?: $defaultBody) ?></textarea>
            </label>
        </p>
        <p class="form__submit" style="margin:0;">
            <button type="submit" class="btn">Enviar respuesta</button>
            <?php if (!empty($quote['response_text'])): ?>
                <span class="text-muted" style="font-size:.85rem;margin-left:.8rem;">
                    Última respuesta guardada el <?= htmlspecialchars((string) $quote['responded_at']) ?>.
                </span>
            <?php endif; ?>
        </p>
    </form>
</section>

<section class="admin-section">
    <h2>Notas internas</h2>
    <?php if (empty($quoteNotesList)): ?>
        <p class="text-muted" style="margin:0 0 1rem;">Todavía no hay notas internas.</p>
    <?php else: ?>
        <ul class="notes-list">
            <?php foreach ($quoteNotesList as $n): ?>
                <li>
                    <div class="note__meta">
                        <span><?= htmlspecialchars((string) $n['created_at']) ?></span>
                        <?php if (!empty($n['user_email'])): ?>
                            <span class="dot"></span><span><?= htmlspecialchars((string) $n['user_email']) ?></span>
                        <?php endif; ?>
                    </div>
                    <div><?= nl2br(htmlspecialchars((string) $n['body'])) ?></div>
                </li>
            <?php endforeach; ?>
        </ul>
    <?php endif; ?>
    <form method="post" style="margin-top:1rem;">
        <input type="hidden" name="action" value="quote_add_note">
        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
        <input type="hidden" name="id" value="<?= (int) $quote['id'] ?>">
        <p class="form__field"><textarea name="note" rows="3" placeholder="Nota interna (solo visible para el equipo)..." required></textarea></p>
        <p class="form__submit" style="margin:0;"><button type="submit" class="btn">Agregar nota</button></p>
    </form>
</section>

<?php if (!empty($quoteHistory)): ?>
<section class="admin-section">
    <h2>Historial de estados</h2>
    <ul class="notes-list">
        <?php foreach ($quoteHistory as $h): ?>
            <li>
                <div class="note__meta">
                    <span><?= htmlspecialchars((string) $h['created_at']) ?></span>
                    <span class="dot"></span>
                    <span class="badge badge--<?= htmlspecialchars((string) $h['status']) ?>"><?= htmlspecialchars($statusLabels[$h['status']] ?? $h['status']) ?></span>
                    <?php if (!empty($h['user_email'])): ?>
                        <span class="dot"></span><span><?= htmlspecialchars((string) $h['user_email']) ?></span>
                    <?php endif; ?>
                </div>
                <?php if (!empty($h['note'])): ?>
                    <div><?= htmlspecialchars((string) $h['note']) ?></div>
                <?php endif; ?>
            </li>
        <?php endforeach; ?>
    </ul>
</section>
<?php endif; ?>

<section class="admin-section" style="border-color:#fecaca;background:#fef9f9;">
    <h2 style="color:#991b1b;">Zona peligrosa</h2>
    <p class="text-muted" style="margin-bottom:.8rem;font-size:.88rem;">
        Eliminar la cotización es permanente. También borra los ítems, notas internas y el historial de estados.
    </p>
    <form method="post" onsubmit="return confirm('¿Eliminar esta cotización? Esta acción no se puede deshacer.')" style="margin:0;">
        <input type="hidden" name="action" value="quote_delete">
        <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
        <input type="hidden" name="id" value="<?= (int) $quote['id'] ?>">
        <button type="submit" class="btn btn--danger">Eliminar cotización</button>
    </form>
</section>
