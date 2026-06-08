<?php
/**
 * Pasarelas y métodos de pago.
 *
 * Cada método publicado se identifica con una `key` (también guardada en
 * `orders.payment_method`). Los métodos offline (`bank_transfer`, `cod`)
 * cierran el checkout localmente y solo muestran instrucciones; los online
 * (`flow`, `mercadopago`, `transbank`) redirigen al gateway externo.
 *
 * `paymentsAvailable()` devuelve solo los métodos habilitados Y con
 * credenciales completas — así nunca se ofrece al comprador una opción que
 * fallará al intentar cobrar.
 *
 * Integración:
 *   - flow:        API REST de Flow con firma HMAC-SHA256 (sandbox|production).
 *                  Necesita credenciales en admin → Pagos.
 *   - mercadopago: pendiente (se valida credenciales pero el botón devuelve
 *                  error claro hasta integrar el SDK / API).
 *   - transbank:   pendiente (idem).
 *   - bank_transfer / cod: redirigen a /orden/{number} mostrando las
 *                  instrucciones configuradas. La orden queda en `pending`.
 */

/** Configuración + estado por método (enabled, credenciales completas, label, etc.). */
function paymentsAllMethods(): array {
    return [
        'flow' => [
            'label'       => 'Flow',
            'description' => 'Tarjetas, Webpay, transferencia y otros — pago seguro vía Flow.cl.',
            'enabled'     => getSetting('pay_flow_enabled', '0') === '1',
            'configured'  => trim((string) getSetting('flow_api_key', '')) !== ''
                          && trim((string) getSetting('flow_secret_key', '')) !== '',
            'kind'        => 'online',
        ],
        'mercadopago' => [
            'label'       => 'MercadoPago',
            'description' => 'Pagás con tarjeta, débito o saldo en MercadoPago.',
            'enabled'     => getSetting('pay_mercadopago_enabled', '0') === '1',
            'configured'  => trim((string) getSetting('mp_access_token', '')) !== ''
                          && trim((string) getSetting('mp_public_key', '')) !== '',
            'kind'        => 'online',
        ],
        'transbank' => [
            'label'       => 'Webpay Plus (Transbank)',
            'description' => 'Pago con tarjetas chilenas vía Webpay.',
            'enabled'     => getSetting('pay_transbank_enabled', '0') === '1',
            'configured'  => trim((string) getSetting('tbk_commerce_code', '')) !== ''
                          && trim((string) getSetting('tbk_api_key', '')) !== '',
            'kind'        => 'online',
        ],
        'bank_transfer' => [
            'label'       => 'Transferencia bancaria',
            'description' => 'Te enviamos los datos bancarios para que transfieras y nos avises.',
            'enabled'     => getSetting('pay_bank_transfer_enabled', '0') === '1',
            'configured'  => trim((string) getSetting('pay_bank_transfer_instructions', '')) !== '',
            'kind'        => 'offline',
        ],
        'cod' => [
            'label'       => 'Pago contra entrega',
            'description' => 'Pagás cuando recibís el pedido.',
            'enabled'     => getSetting('pay_cod_enabled', '0') === '1',
            'configured'  => true,
            'kind'        => 'offline',
        ],
    ];
}

/**
 * Métodos que se ofrecen al comprador: habilitados + configurados +
 * efectivamente implementados. Los pendientes (MP/TBK) se filtran acá hasta
 * que se integren para no engañar al cliente.
 */
function paymentsAvailable(): array {
    $out = [];
    foreach (paymentsAllMethods() as $key => $m) {
        if (!$m['enabled'] || !$m['configured']) continue;
        // Filtramos los que aún no tienen integración real al gateway.
        if (in_array($key, ['mercadopago', 'transbank'], true)) continue;
        $out[$key] = $m;
    }
    return $out;
}

/**
 * Inicia el flujo de pago para una orden recién creada.
 *
 * - `online`: hace la llamada al gateway y devuelve la URL externa de redirect.
 * - `offline`: registra el pago en pending y devuelve la URL local /orden/{n}.
 *
 * Retorna ['ok' => bool, 'redirect' => url, 'error' => ?string].
 */
function paymentsStart(array $order, string $method): array {
    switch ($method) {
        case 'flow':
            return paymentsFlowStart($order);
        case 'bank_transfer':
        case 'cod':
            return [
                'ok'       => true,
                'redirect' => '/orden/' . rawurlencode($order['order_number']),
            ];
        default:
            return [
                'ok'    => false,
                'error' => 'Método de pago no disponible.',
            ];
    }
}

/* ===================== Flow ===================== */

function paymentsFlowBaseUrl(): string {
    $env = (string) getSetting('flow_environment', 'sandbox');
    return $env === 'production' ? 'https://www.flow.cl/api' : 'https://sandbox.flow.cl/api';
}

/**
 * Firma Flow: los pares key=value se ordenan por key y se concatenan como
 * "k1v1k2v2..." (sin separadores) y se hashean con HMAC-SHA256 usando el
 * secretKey. Devuelve el hex de 64 chars.
 */
function paymentsFlowSign(array $params, string $secret): string {
    ksort($params);
    $raw = '';
    foreach ($params as $k => $v) {
        $raw .= $k . $v;
    }
    return hash_hmac('sha256', $raw, $secret);
}

function paymentsFlowStart(array $order): array {
    $apiKey = trim((string) getSetting('flow_api_key', ''));
    $secret = trim((string) getSetting('flow_secret_key', ''));
    if ($apiKey === '' || $secret === '') {
        return ['ok' => false, 'error' => 'Flow no está configurado.'];
    }

    $host  = $_SERVER['HTTP_HOST'] ?? '';
    $proto = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
    $base  = $host ? ($proto . '://' . $host) : '';

    $params = [
        'apiKey'          => $apiKey,
        'commerceOrder'   => (string) $order['order_number'],
        'subject'         => 'Compra #' . $order['order_number'],
        'currency'        => (string) $order['currency'],
        'amount'          => (string) shopAmountForGateway((float) $order['grand_total']),
        'email'           => (string) $order['email'],
        'urlConfirmation' => $base . '/checkout/flow/notify',
        'urlReturn'       => $base . '/checkout/flow/return',
    ];
    $params['s'] = paymentsFlowSign($params, $secret);

    $ch = curl_init(paymentsFlowBaseUrl() . '/payment/create');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => http_build_query($params),
        CURLOPT_TIMEOUT        => 12,
        CURLOPT_HTTPHEADER     => ['Content-Type: application/x-www-form-urlencoded'],
    ]);
    $body = curl_exec($ch);
    $err  = curl_error($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($body === false || $code >= 400) {
        error_log('Flow create error: code=' . $code . ' err=' . $err . ' body=' . substr((string) $body, 0, 400));
        return ['ok' => false, 'error' => 'No se pudo iniciar el pago con Flow.'];
    }

    $json = json_decode((string) $body, true);
    if (!is_array($json) || empty($json['url']) || empty($json['token'])) {
        error_log('Flow create unexpected response: ' . substr((string) $body, 0, 400));
        return ['ok' => false, 'error' => 'Respuesta inválida de Flow.'];
    }

    // Registramos el "intento" de pago para poder rastrearlo cuando vuelva.
    getDB()->prepare(
        'INSERT INTO payments (order_id, provider, provider_payment_id, status, amount, currency, raw_payload)
         VALUES (?, "flow", ?, "started", ?, ?, ?)'
    )->execute([
        (int) $order['id'],
        (string) $json['token'],
        (float) $order['grand_total'],
        (string) $order['currency'],
        json_encode($json, JSON_UNESCAPED_UNICODE),
    ]);

    return ['ok' => true, 'redirect' => $json['url'] . '?token=' . urlencode((string) $json['token'])];
}

/**
 * Consulta el estado en Flow para un token y, si corresponde, marca la orden
 * como pagada. Se llama desde el return URL y el webhook (`notify`).
 *
 * Idempotente: usa `payments.provider_payment_id` UNIQUE para no duplicar.
 */
function paymentsFlowConsumeToken(string $token): array {
    $apiKey = trim((string) getSetting('flow_api_key', ''));
    $secret = trim((string) getSetting('flow_secret_key', ''));
    if ($apiKey === '' || $secret === '' || $token === '') {
        return ['ok' => false, 'error' => 'Credenciales o token faltantes.'];
    }
    $params = ['apiKey' => $apiKey, 'token' => $token];
    $params['s'] = paymentsFlowSign($params, $secret);

    $url = paymentsFlowBaseUrl() . '/payment/getStatus?' . http_build_query($params);
    $ch  = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 12,
    ]);
    $body = curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($body === false || $code >= 400) {
        return ['ok' => false, 'error' => 'No se pudo consultar Flow.'];
    }
    $j = json_decode((string) $body, true);
    if (!is_array($j) || empty($j['commerceOrder'])) {
        return ['ok' => false, 'error' => 'Respuesta de Flow inválida.'];
    }

    $orderNumber = (string) $j['commerceOrder'];
    $st = getDB()->prepare('SELECT * FROM orders WHERE order_number = ?');
    $st->execute([$orderNumber]);
    $order = $st->fetch() ?: null;
    if (!$order) {
        return ['ok' => false, 'error' => 'Orden no encontrada.'];
    }

    $flowStatus = (int) ($j['status'] ?? 0); // 1=pendiente, 2=pagada, 3=rechazada, 4=anulada
    $paid = $flowStatus === 2;
    $providerStatus = ['1' => 'pending', '2' => 'paid', '3' => 'rejected', '4' => 'cancelled'][(string) $flowStatus] ?? 'unknown';

    // Idempotencia: el UNIQUE en provider_payment_id descarta duplicados.
    try {
        getDB()->prepare(
            'INSERT INTO payments (order_id, provider, provider_payment_id, status, amount, currency, raw_payload)
             VALUES (?, "flow", ?, ?, ?, ?, ?)'
        )->execute([
            (int) $order['id'],
            'flow_status_' . $token,
            $providerStatus,
            (float) ($j['amount'] ?? $order['grand_total']),
            (string) $order['currency'],
            json_encode($j, JSON_UNESCAPED_UNICODE),
        ]);
    } catch (PDOException $e) {
        // Repetida: el webhook llegó dos veces. Seguimos sin error.
    }

    if ($paid && $order['payment_status'] !== 'paid') {
        getDB()->prepare(
            "UPDATE orders SET status = 'paid', payment_status = 'paid', paid_at = NOW()
             WHERE id = ? AND payment_status <> 'paid'"
        )->execute([(int) $order['id']]);
        getDB()->prepare(
            'INSERT INTO order_status_history (order_id, status, note) VALUES (?, "paid", "Pago confirmado por Flow.")'
        )->execute([(int) $order['id']]);
    }

    return [
        'ok'             => true,
        'paid'           => $paid,
        'order_number'   => $orderNumber,
        'provider_status'=> $providerStatus,
    ];
}
