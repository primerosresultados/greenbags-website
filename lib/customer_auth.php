<?php
/* ===========================================================================
 * Autenticación de clientes (login público en /mi-cuenta)
 * ---------------------------------------------------------------------------
 * Separado por completo de lib/auth.php (staff del panel /admin). Aquí el
 * "usuario" es un cliente que se registra desde el sitio, y su sesión vive en
 * $_SESSION['customer_id'] (nunca 'user_id', para no mezclar privilegios).
 *
 * Verificación de email NO bloqueante: el cliente puede usar su cuenta al toque;
 * el link de verificación solo confirma la titularidad del email (y saca el
 * banner). Así, si el envío de mail falla, nadie queda encerrado afuera.
 * ========================================================================= */

/** Cliente logueado, o null. Lee de sesión y refresca desde BD. */
function currentCustomer(): ?array {
    if (empty($_SESSION['customer_id'])) return null;
    try {
        $st = getDB()->prepare(
            'SELECT id, first_name, last_name, email, phone, company, taxid,
                    email_verified_at, created_at, last_login_at
             FROM customers WHERE id = ? AND is_active = 1'
        );
        $st->execute([(int) $_SESSION['customer_id']]);
        $c = $st->fetch();
    } catch (Throwable $e) {
        return null; // tabla aún no migrada
    }
    if (!$c) { unset($_SESSION['customer_id']); return null; }
    // La tabla guarda first_name/last_name; exponemos un `name` unificado para
    // el resto del código (dashboard, saludos, emails).
    $c['name'] = trim(trim((string) ($c['first_name'] ?? '')) . ' ' . trim((string) ($c['last_name'] ?? '')));
    return $c;
}

function customerDisplayName(array $c): string {
    $n = trim((string) ($c['name'] ?? ''));
    if ($n === '') return (string) ($c['email'] ?? '');
    // Solo el primer nombre para saludos.
    return explode(' ', $n)[0];
}

function customerIsVerified(array $c): bool {
    return !empty($c['email_verified_at']);
}

/** Parte un nombre completo en [first_name, last_name] (last puede ser ''). */
function customerSplitName(string $full): array {
    $full = trim(preg_replace('/\s+/', ' ', $full));
    if ($full === '') return ['', ''];
    $sp = strpos($full, ' ');
    if ($sp === false) return [$full, ''];
    return [substr($full, 0, $sp), substr($full, $sp + 1)];
}

/* -------------------- rate limit (email + IP) -------------------- */

function customerRateLimitOk(string $email, string $ip): bool {
    $db = getDB();
    $db->exec('DELETE FROM customer_login_attempts WHERE attempted_at < DATE_SUB(NOW(), INTERVAL 1 DAY)');

    $st = $db->prepare(
        'SELECT COUNT(*) FROM customer_login_attempts
         WHERE ip_address = ? AND attempted_at > DATE_SUB(NOW(), INTERVAL 15 MINUTE)'
    );
    $st->execute([$ip]);
    if ((int) $st->fetchColumn() >= 12) return false;

    if ($email !== '') {
        $st = $db->prepare(
            'SELECT COUNT(*) FROM customer_login_attempts
             WHERE email = ? AND attempted_at > DATE_SUB(NOW(), INTERVAL 15 MINUTE)'
        );
        $st->execute([$email]);
        if ((int) $st->fetchColumn() >= 6) return false;
    }
    return true;
}

function customerRateLimitRecord(string $email, string $ip): void {
    getDB()->prepare('INSERT INTO customer_login_attempts (ip_address, email) VALUES (?, ?)')
           ->execute([$ip, $email ?: null]);
}

function customerRateLimitClear(string $email, string $ip): void {
    getDB()->prepare('DELETE FROM customer_login_attempts WHERE ip_address = ? OR email = ?')
           ->execute([$ip, $email]);
}

/* -------------------- sesión -------------------- */

function customerStartSession(int $customerId): void {
    session_regenerate_id(true);
    $_SESSION['customer_id']       = $customerId;
    $_SESSION['customer_login_at'] = time();
    try {
        getDB()->prepare('UPDATE customers SET last_login_at = NOW() WHERE id = ?')->execute([$customerId]);
    } catch (Throwable $e) { /* ignore */ }
}

function customerLogout(): void {
    unset($_SESSION['customer_id'], $_SESSION['customer_login_at']);
}

/* -------------------- registro / login -------------------- */

/**
 * @return array{ok:bool, error?:string, id?:int}
 */
function customerRegister(array $data): array {
    $name  = trim((string) ($data['name']  ?? ''));
    $email = strtolower(trim((string) ($data['email'] ?? '')));
    $pass  = (string) ($data['password'] ?? '');
    $phone   = trim((string) ($data['phone']   ?? ''));
    $company = trim((string) ($data['company'] ?? ''));

    if ($name === '')                                 return ['ok' => false, 'error' => 'Ingresá tu nombre.'];
    if (!filter_var($email, FILTER_VALIDATE_EMAIL))   return ['ok' => false, 'error' => 'Ingresá un email válido.'];
    if (strlen($pass) < 8)                            return ['ok' => false, 'error' => 'La contraseña debe tener al menos 8 caracteres.'];

    $db = getDB();
    $st = $db->prepare('SELECT id, password_hash, is_guest FROM customers WHERE email = ?');
    $st->execute([$email]);
    $existing = $st->fetch();

    [$first, $last] = customerSplitName($name);
    $token = bin2hex(random_bytes(32));

    if ($existing) {
        // Si es un invitado sin contraseña (guest checkout previo), activamos su
        // cuenta en vez de rechazarlo. Si ya tiene contraseña, es una cuenta real.
        if (!empty($existing['password_hash'])) {
            return ['ok' => false, 'error' => 'Ya existe una cuenta con ese email. Iniciá sesión.'];
        }
        $db->prepare(
            'UPDATE customers SET first_name = ?, last_name = ?, password_hash = ?, phone = ?,
                company = ?, is_guest = 0, verify_token = ?, verify_sent_at = NOW() WHERE id = ?'
        )->execute([
            $first, $last ?: null, password_hash($pass, PASSWORD_DEFAULT),
            $phone ?: null, $company ?: null, $token, (int) $existing['id'],
        ]);
        $id = (int) $existing['id'];
    } else {
        $db->prepare(
            'INSERT INTO customers
                (first_name, last_name, email, password_hash, phone, company, is_guest, verify_token, verify_sent_at)
             VALUES (?, ?, ?, ?, ?, ?, 0, ?, NOW())'
        )->execute([
            $first, $last ?: null, $email, password_hash($pass, PASSWORD_DEFAULT),
            $phone ?: null, $company ?: null, $token,
        ]);
        $id = (int) $db->lastInsertId();
    }

    customerStartSession($id);
    customerLinkQuotes($id, $email);

    try { customerSendVerification($id, $email, $name, $token); }
    catch (Throwable $e) { error_log('customerVerify mail: ' . $e->getMessage()); }

    return ['ok' => true, 'id' => $id];
}

/**
 * @return array{ok:bool, error?:string}
 */
function customerLogin(string $email, string $password): array {
    $email = strtolower(trim($email));
    $ip = function_exists('clientIp') ? clientIp() : ($_SERVER['REMOTE_ADDR'] ?? '');

    if (!customerRateLimitOk($email, $ip)) {
        return ['ok' => false, 'error' => 'Demasiados intentos. Esperá unos minutos e intentá de nuevo.'];
    }

    $st = getDB()->prepare('SELECT id, password_hash, is_active FROM customers WHERE email = ?');
    $st->execute([$email]);
    $c = $st->fetch();

    if (!$c || !(int) $c['is_active'] || !password_verify($password, (string) $c['password_hash'])) {
        customerRateLimitRecord($email, $ip);
        return ['ok' => false, 'error' => 'Email o contraseña incorrectos.'];
    }

    customerRateLimitClear($email, $ip);
    customerStartSession((int) $c['id']);
    customerLinkQuotes((int) $c['id'], $email);
    return ['ok' => true];
}

/**
 * Liga cotizaciones sin dueño a este cliente:
 *   - la del navegador actual (cookie pse_quote), aunque sea draft.
 *   - las ya enviadas que coincidan por email de contacto.
 */
function customerLinkQuotes(int $customerId, string $email): void {
    try {
        if (function_exists('quoteToken')) {
            $tok = $_COOKIE['pse_quote'] ?? '';
            if ($tok !== '') {
                getDB()->prepare('UPDATE quotes SET customer_id = ? WHERE token = ? AND customer_id IS NULL')
                       ->execute([$customerId, $tok]);
            }
        }
        if ($email !== '') {
            getDB()->prepare(
                'UPDATE quotes SET customer_id = ?
                 WHERE contact_email = ? AND customer_id IS NULL'
            )->execute([$customerId, $email]);
        }
    } catch (Throwable $e) {
        error_log('customerLinkQuotes: ' . $e->getMessage());
    }
}

/** Cotizaciones enviadas del cliente (para el dashboard). */
function customerQuotes(int $customerId): array {
    try {
        $st = getDB()->prepare(
            "SELECT id, quote_number, status, items_count, subtotal_est, currency,
                    submitted_at, created_at
             FROM quotes
             WHERE customer_id = ? AND status <> 'draft'
             ORDER BY COALESCE(submitted_at, created_at) DESC
             LIMIT 100"
        );
        $st->execute([$customerId]);
        return $st->fetchAll();
    } catch (Throwable $e) {
        return [];
    }
}

/* -------------------- verificación de email -------------------- */

function customerSendVerification(int $id, string $email, string $name, string $token): void {
    $link = function_exists('shopAbsUrl')
        ? shopAbsUrl('/mi-cuenta/verificar?token=' . urlencode($token))
        : '/mi-cuenta/verificar?token=' . urlencode($token);
    $biz  = function_exists('getSetting') ? (string) getSetting('business_name', 'GreenBags') : 'GreenBags';

    $subject = 'Verificá tu email — ' . $biz;
    $text = "Hola " . $name . ",\n\n"
          . "Gracias por crear tu cuenta en " . $biz . ".\n"
          . "Confirmá tu email haciendo clic en este enlace:\n\n"
          . $link . "\n\n"
          . "Si no creaste esta cuenta, podés ignorar este mensaje.\n";
    $html = '<p>Hola ' . htmlspecialchars($name) . ',</p>'
          . '<p>Gracias por crear tu cuenta en <strong>' . htmlspecialchars($biz) . '</strong>.</p>'
          . '<p>Confirmá tu email:</p>'
          . '<p><a href="' . htmlspecialchars($link) . '" style="display:inline-block;background:#22c55e;color:#fff;'
          . 'padding:.7rem 1.3rem;border-radius:8px;text-decoration:none;font-weight:600;">Verificar mi email</a></p>'
          . '<p style="color:#64748b;font-size:.9rem;">O copiá este enlace: ' . htmlspecialchars($link) . '</p>'
          . '<p style="color:#64748b;font-size:.85rem;">Si no creaste esta cuenta, ignorá este mensaje.</p>';

    if (function_exists('sendMailDetailed')) {
        sendMailDetailed($email, $subject, $text, $html);
    } elseif (function_exists('sendMail')) {
        sendMail($email, $subject, $text);
    }
}

/** Reenvía la verificación (con throttle simple de 2 min). */
function customerResendVerification(int $id): array {
    $st = getDB()->prepare('SELECT email, first_name, email_verified_at, verify_token, verify_sent_at FROM customers WHERE id = ?');
    $st->execute([$id]);
    $c = $st->fetch();
    if (!$c) return ['ok' => false, 'error' => 'Cuenta no encontrada.'];
    if (!empty($c['email_verified_at'])) return ['ok' => true, 'already' => true];

    if (!empty($c['verify_sent_at']) && (time() - strtotime((string) $c['verify_sent_at'])) < 120) {
        return ['ok' => false, 'error' => 'Ya te enviamos un correo hace poco. Revisá tu bandeja (y el spam).'];
    }
    $token = (string) ($c['verify_token'] ?: bin2hex(random_bytes(32)));
    getDB()->prepare('UPDATE customers SET verify_token = ?, verify_sent_at = NOW() WHERE id = ?')
           ->execute([$token, $id]);
    try {
        customerSendVerification($id, (string) $c['email'], (string) $c['first_name'], $token);
    } catch (Throwable $e) {
        return ['ok' => false, 'error' => 'No pudimos enviar el correo. Intentá más tarde.'];
    }
    return ['ok' => true];
}

function customerVerifyEmail(string $token): bool {
    $token = trim($token);
    if ($token === '') return false;
    $st = getDB()->prepare('SELECT id FROM customers WHERE verify_token = ? AND email_verified_at IS NULL');
    $st->execute([$token]);
    $c = $st->fetch();
    if (!$c) return false;
    getDB()->prepare('UPDATE customers SET email_verified_at = NOW(), verify_token = NULL WHERE id = ?')
           ->execute([(int) $c['id']]);
    return true;
}

/* -------------------- recuperación de contraseña -------------------- */

/** Siempre responde genérico (no revela si el email existe). */
function customerRequestReset(string $email): void {
    $email = strtolower(trim($email));
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) return;
    $st = getDB()->prepare('SELECT id, first_name FROM customers WHERE email = ? AND is_active = 1');
    $st->execute([$email]);
    $c = $st->fetch();
    if (!$c) return;
    $c['name'] = (string) ($c['first_name'] ?? '');

    $token = bin2hex(random_bytes(32));
    getDB()->prepare('UPDATE customers SET reset_token = ?, reset_expires_at = DATE_ADD(NOW(), INTERVAL 1 HOUR) WHERE id = ?')
           ->execute([$token, (int) $c['id']]);

    $link = function_exists('shopAbsUrl')
        ? shopAbsUrl('/mi-cuenta/restablecer?token=' . urlencode($token))
        : '/mi-cuenta/restablecer?token=' . urlencode($token);
    $biz  = (string) getSetting('business_name', 'GreenBags');

    $subject = 'Restablecer tu contraseña — ' . $biz;
    $text = "Hola " . $c['name'] . ",\n\n"
          . "Recibimos un pedido para restablecer la contraseña de tu cuenta en " . $biz . ".\n"
          . "Usá este enlace (válido por 1 hora):\n\n" . $link . "\n\n"
          . "Si no lo pediste, ignorá este mensaje: tu contraseña no cambia.\n";
    $html = '<p>Hola ' . htmlspecialchars((string) $c['name']) . ',</p>'
          . '<p>Recibimos un pedido para restablecer tu contraseña en <strong>' . htmlspecialchars($biz) . '</strong>.</p>'
          . '<p><a href="' . htmlspecialchars($link) . '" style="display:inline-block;background:#22c55e;color:#fff;'
          . 'padding:.7rem 1.3rem;border-radius:8px;text-decoration:none;font-weight:600;">Restablecer contraseña</a></p>'
          . '<p style="color:#64748b;font-size:.9rem;">Válido por 1 hora. Si no lo pediste, ignorá este mensaje.</p>';

    try {
        if (function_exists('sendMailDetailed')) sendMailDetailed($email, $subject, $text, $html);
        elseif (function_exists('sendMail')) sendMail($email, $subject, $text);
    } catch (Throwable $e) {
        error_log('customerReset mail: ' . $e->getMessage());
    }
}

function customerResetTokenValid(string $token): bool {
    $token = trim($token);
    if ($token === '') return false;
    $st = getDB()->prepare('SELECT id FROM customers WHERE reset_token = ? AND reset_expires_at > NOW()');
    $st->execute([$token]);
    return (bool) $st->fetch();
}

/**
 * @return array{ok:bool, error?:string}
 */
function customerPerformReset(string $token, string $newPass): array {
    $token = trim($token);
    if (strlen($newPass) < 8) return ['ok' => false, 'error' => 'La contraseña debe tener al menos 8 caracteres.'];
    $st = getDB()->prepare('SELECT id FROM customers WHERE reset_token = ? AND reset_expires_at > NOW()');
    $st->execute([$token]);
    $c = $st->fetch();
    if (!$c) return ['ok' => false, 'error' => 'El enlace expiró o no es válido. Pedí uno nuevo.'];

    getDB()->prepare(
        'UPDATE customers SET password_hash = ?, reset_token = NULL, reset_expires_at = NULL WHERE id = ?'
    )->execute([password_hash($newPass, PASSWORD_DEFAULT), (int) $c['id']]);

    customerStartSession((int) $c['id']);
    return ['ok' => true];
}

/* -------------------- edición de perfil -------------------- */

function customerUpdateProfile(int $id, array $data): array {
    $name    = trim((string) ($data['name']    ?? ''));
    $phone   = trim((string) ($data['phone']   ?? ''));
    $company = trim((string) ($data['company'] ?? ''));
    $taxid   = trim((string) ($data['taxid']   ?? ''));
    if ($name === '') return ['ok' => false, 'error' => 'El nombre no puede quedar vacío.'];

    [$first, $last] = customerSplitName($name);
    getDB()->prepare('UPDATE customers SET first_name = ?, last_name = ?, phone = ?, company = ?, taxid = ? WHERE id = ?')
           ->execute([$first, $last ?: null, $phone ?: null, $company ?: null, $taxid ?: null, $id]);
    return ['ok' => true];
}
