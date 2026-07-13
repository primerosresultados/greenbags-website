<?php
/* ===========================================================================
 * Front público de /mi-cuenta y /favoritos
 * ---------------------------------------------------------------------------
 * /mi-cuenta
 *   - GET  sin sesión → login + registro (tabs)
 *   - GET  con sesión → dashboard (perfil + historial de cotizaciones)
 *   - POST → acciones (login, register, logout, update_profile, ...)
 *   - /mi-cuenta/salir | /verificar | /recuperar | /restablecer
 *
 * /favoritos → página cliente (wishlist en localStorage, ver favorites.js)
 * ========================================================================= */

/** Router de /mi-cuenta y subrutas. Devuelve true si tomó el request. */
function accountFrontRoute(string $path): bool {
    $seg = explode('/', $path);
    if ($seg[0] !== 'mi-cuenta') return false;

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        accountHandlePost();
        return true;
    }

    $sub = $seg[1] ?? '';
    switch ($sub) {
        case '':
            accountRenderMain();
            return true;
        case 'salir':
            customerLogout();
            flashSet('account_msg', 'Cerraste sesión. ¡Hasta pronto!');
            redirect('/mi-cuenta');
        case 'verificar':
            accountRenderVerify();
            return true;
        case 'recuperar':
            accountRenderRecover();
            return true;
        case 'restablecer':
            accountRenderReset();
            return true;
        default:
            return false; // subruta desconocida → 404 normal
    }
}

/* -------------------- POST -------------------- */

function accountHandlePost(): void {
    csrfCheck();
    $action = (string) ($_POST['action'] ?? '');

    switch ($action) {
        case 'login': {
            $res = customerLogin((string) ($_POST['email'] ?? ''), (string) ($_POST['password'] ?? ''));
            if ($res['ok']) redirect('/mi-cuenta');
            flashSet('account_login_err', $res['error'] ?? 'No pudimos iniciar sesión.');
            flashSet('account_email', trim((string) ($_POST['email'] ?? '')));
            redirect('/mi-cuenta?tab=login');
        }
        case 'register': {
            $res = customerRegister($_POST);
            if ($res['ok']) {
                flashSet('account_msg', '¡Cuenta creada! Te enviamos un correo para verificar tu email.');
                redirect('/mi-cuenta');
            }
            flashSet('account_reg_err', $res['error'] ?? 'No pudimos crear la cuenta.');
            flashSet('account_email', strtolower(trim((string) ($_POST['email'] ?? ''))));
            flashSet('account_name',  trim((string) ($_POST['name'] ?? '')));
            redirect('/mi-cuenta?tab=registro');
        }
        case 'logout': {
            customerLogout();
            flashSet('account_msg', 'Cerraste sesión.');
            redirect('/mi-cuenta');
        }
        case 'update_profile': {
            $c = currentCustomer();
            if (!$c) redirect('/mi-cuenta');
            $res = customerUpdateProfile((int) $c['id'], $_POST);
            flashSet($res['ok'] ? 'account_msg' : 'account_err',
                $res['ok'] ? 'Datos actualizados.' : ($res['error'] ?? 'No se pudo guardar.'));
            redirect('/mi-cuenta');
        }
        case 'resend_verification': {
            $c = currentCustomer();
            if (!$c) redirect('/mi-cuenta');
            $res = customerResendVerification((int) $c['id']);
            if (!empty($res['already'])) {
                flashSet('account_msg', 'Tu email ya está verificado.');
            } else {
                flashSet($res['ok'] ? 'account_msg' : 'account_err',
                    $res['ok'] ? 'Te reenviamos el correo de verificación.' : ($res['error'] ?? 'No se pudo enviar.'));
            }
            redirect('/mi-cuenta');
        }
        case 'request_reset': {
            customerRequestReset((string) ($_POST['email'] ?? ''));
            flashSet('account_msg', 'Si el email está registrado, te enviamos un enlace para restablecer tu contraseña.');
            redirect('/mi-cuenta');
        }
        case 'reset_password': {
            $token = (string) ($_POST['token'] ?? '');
            $res = customerPerformReset($token, (string) ($_POST['password'] ?? ''));
            if ($res['ok']) {
                flashSet('account_msg', 'Tu contraseña fue actualizada. Ya iniciaste sesión.');
                redirect('/mi-cuenta');
            }
            flashSet('account_err', $res['error'] ?? 'No se pudo restablecer.');
            redirect('/mi-cuenta/restablecer?token=' . urlencode($token));
        }
        default:
            redirect('/mi-cuenta');
    }
}

/* -------------------- helpers de render -------------------- */

function accountFlashBanner(): void {
    $ok  = flashGet('account_msg');
    $err = flashGet('account_err');
    if ($ok)  echo '<div class="acct-flash acct-flash--ok">' . htmlspecialchars($ok) . '</div>';
    if ($err) echo '<div class="acct-flash acct-flash--err">' . htmlspecialchars($err) . '</div>';
}

function accountQuoteStatusLabel(string $status): array {
    // [texto, clase]
    switch ($status) {
        case 'submitted': return ['Enviada', 'is-submitted'];
        case 'responded': return ['Respondida', 'is-responded'];
        case 'won':       return ['Ganada', 'is-won'];
        case 'lost':      return ['Cerrada', 'is-lost'];
        case 'expired':   return ['Expirada', 'is-expired'];
        default:          return [ucfirst($status), ''];
    }
}

/* -------------------- render: principal -------------------- */

function accountRenderMain(): void {
    $c = currentCustomer();
    if ($c) { accountRenderDashboard($c); return; }
    accountRenderAuth();
}

function accountRenderDashboard(array $c): void {
    layoutStart([
        'title'        => 'Mi cuenta',
        'description'  => 'Tu cuenta de GreenBags — cotizaciones, datos y favoritos.',
        'current_slug' => 'mi-cuenta',
    ]);
    $quotes   = customerQuotes((int) $c['id']);
    $verified = customerIsVerified($c);
    $showPrices = function_exists('quotesEnabled') && quotesEnabled() && getSetting('quote_show_prices', '0') === '1';
    ?>
<main class="container acct">
    <div class="acct-head">
        <div>
            <p class="acct-eyebrow">Mi cuenta</p>
            <h1 class="acct-title">Hola, <?= htmlspecialchars(customerDisplayName($c)) ?></h1>
        </div>
        <form method="post" action="/mi-cuenta" class="acct-logout">
            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="btn btn--ghost">Cerrar sesión</button>
        </form>
    </div>

    <?php accountFlashBanner(); ?>

    <?php if (!$verified): ?>
        <div class="acct-verify">
            <div>
                <strong>Verificá tu email.</strong>
                Te enviamos un correo a <?= htmlspecialchars((string) $c['email']) ?>. Revisá tu bandeja (y el spam).
            </div>
            <form method="post" action="/mi-cuenta">
                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                <input type="hidden" name="action" value="resend_verification">
                <button type="submit" class="btn btn--small btn--secondary">Reenviar correo</button>
            </form>
        </div>
    <?php endif; ?>

    <div class="acct-grid">
        <section class="acct-card acct-card--quotes">
            <h2 class="acct-card__title">Mis cotizaciones</h2>
            <?php if (!$quotes): ?>
                <div class="acct-empty">
                    <p>Todavía no enviaste ninguna cotización.</p>
                    <a href="/catalogo" class="btn">Explorar catálogo</a>
                </div>
            <?php else: ?>
                <div class="acct-table-wrap">
                    <table class="acct-table">
                        <thead>
                            <tr>
                                <th>N.º</th><th>Fecha</th><th>Ítems</th>
                                <?php if ($showPrices): ?><th>Estimado</th><?php endif; ?>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                        <?php foreach ($quotes as $q):
                            [$lbl, $cls] = accountQuoteStatusLabel((string) $q['status']);
                            $when = $q['submitted_at'] ?: $q['created_at'];
                        ?>
                            <tr>
                                <td class="acct-table__num"><?= htmlspecialchars((string) ($q['quote_number'] ?: '—')) ?></td>
                                <td><?= $when ? htmlspecialchars(date('d/m/Y', strtotime((string) $when))) : '—' ?></td>
                                <td><?= (int) $q['items_count'] ?></td>
                                <?php if ($showPrices): ?>
                                    <td><?= $q['subtotal_est'] !== null ? htmlspecialchars(shopFormatPrice((float) $q['subtotal_est'])) : '—' ?></td>
                                <?php endif; ?>
                                <td><span class="acct-badge <?= $cls ?>"><?= htmlspecialchars($lbl) ?></span></td>
                            </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
                <?php $bizEmail = trim((string) getSetting('business_email', '')) ?: 'contacto@greenbags.cl'; ?>
                <p class="acct-note">¿Consultas sobre una cotización? Escribinos a
                    <a href="mailto:<?= htmlspecialchars($bizEmail) ?>"><?= htmlspecialchars($bizEmail) ?></a>
                    con el número.</p>
            <?php endif; ?>
        </section>

        <aside class="acct-side">
            <section class="acct-card">
                <h2 class="acct-card__title">Mis datos</h2>
                <form method="post" action="/mi-cuenta" class="acct-form">
                    <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                    <input type="hidden" name="action" value="update_profile">
                    <div class="acct-field">
                        <label for="pf-name">Nombre</label>
                        <input type="text" id="pf-name" name="name" value="<?= htmlspecialchars((string) $c['name']) ?>" required>
                    </div>
                    <div class="acct-field">
                        <label>Email</label>
                        <input type="email" value="<?= htmlspecialchars((string) $c['email']) ?>" disabled>
                    </div>
                    <div class="acct-field">
                        <label for="pf-phone">Teléfono</label>
                        <input type="text" id="pf-phone" name="phone" value="<?= htmlspecialchars((string) ($c['phone'] ?? '')) ?>">
                    </div>
                    <div class="acct-field">
                        <label for="pf-company">Empresa</label>
                        <input type="text" id="pf-company" name="company" value="<?= htmlspecialchars((string) ($c['company'] ?? '')) ?>">
                    </div>
                    <div class="acct-field">
                        <label for="pf-taxid">RUT / identificación tributaria</label>
                        <input type="text" id="pf-taxid" name="taxid" value="<?= htmlspecialchars((string) ($c['taxid'] ?? '')) ?>">
                    </div>
                    <button type="submit" class="btn">Guardar datos</button>
                </form>
            </section>

            <section class="acct-card acct-card--links">
                <h2 class="acct-card__title">Accesos rápidos</h2>
                <a href="/favoritos" class="acct-quicklink">
                    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
                    Mis favoritos
                </a>
                <a href="/cotizacion" class="acct-quicklink">
                    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                    Mi cotización en curso
                </a>
                <a href="/catalogo" class="acct-quicklink">
                    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                    Ver catálogo
                </a>
            </section>
        </aside>
    </div>
</main>
    <?php
    layoutEnd();
}

/* -------------------- render: login + registro -------------------- */

function accountRenderAuth(): void {
    $tab = ($_GET['tab'] ?? '') === 'registro' ? 'registro' : 'login';
    $loginErr = flashGet('account_login_err');
    $regErr   = flashGet('account_reg_err');
    $oldEmail = (string) (flashGet('account_email') ?? '');
    $oldName  = (string) (flashGet('account_name') ?? '');
    $msg      = flashGet('account_msg');
    if ($loginErr) $tab = 'login';
    if ($regErr)   $tab = 'registro';

    layoutStart([
        'title'        => 'Mi cuenta — Ingresar',
        'description'  => 'Ingresá o creá tu cuenta de GreenBags para seguir tus cotizaciones.',
        'current_slug' => 'mi-cuenta',
    ]);
    ?>
<main class="container acct acct--auth">
    <div class="acct-authcard">
        <div class="acct-authhead">
            <h1>Mi cuenta</h1>
            <p>Ingresá para ver tus cotizaciones, tu historial y tus datos.</p>
        </div>

        <?php if ($msg): ?><div class="acct-flash acct-flash--ok"><?= htmlspecialchars($msg) ?></div><?php endif; ?>

        <div class="acct-tabs" role="tablist">
            <button type="button" class="acct-tab<?= $tab === 'login' ? ' is-active' : '' ?>" data-acct-tab="login">Ingresar</button>
            <button type="button" class="acct-tab<?= $tab === 'registro' ? ' is-active' : '' ?>" data-acct-tab="registro">Crear cuenta</button>
        </div>

        <form method="post" action="/mi-cuenta" class="acct-form acct-pane" data-acct-pane="login"<?= $tab === 'login' ? '' : ' hidden' ?>>
            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
            <input type="hidden" name="action" value="login">
            <?php if ($loginErr): ?><div class="acct-flash acct-flash--err"><?= htmlspecialchars($loginErr) ?></div><?php endif; ?>
            <div class="acct-field">
                <label for="lg-email">Email</label>
                <input type="email" id="lg-email" name="email" value="<?= htmlspecialchars($oldEmail) ?>" required autocomplete="email">
            </div>
            <div class="acct-field">
                <label for="lg-pass">Contraseña</label>
                <input type="password" id="lg-pass" name="password" required autocomplete="current-password">
            </div>
            <button type="submit" class="btn acct-submit">Ingresar</button>
            <p class="acct-alt"><a href="/mi-cuenta/recuperar">¿Olvidaste tu contraseña?</a></p>
        </form>

        <form method="post" action="/mi-cuenta" class="acct-form acct-pane" data-acct-pane="registro"<?= $tab === 'registro' ? '' : ' hidden' ?>>
            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
            <input type="hidden" name="action" value="register">
            <?php if ($regErr): ?><div class="acct-flash acct-flash--err"><?= htmlspecialchars($regErr) ?></div><?php endif; ?>
            <div class="acct-field">
                <label for="rg-name">Nombre</label>
                <input type="text" id="rg-name" name="name" value="<?= htmlspecialchars($oldName) ?>" required autocomplete="name">
            </div>
            <div class="acct-field">
                <label for="rg-email">Email</label>
                <input type="email" id="rg-email" name="email" value="<?= htmlspecialchars($oldEmail) ?>" required autocomplete="email">
            </div>
            <div class="acct-field">
                <label for="rg-phone">Teléfono <span class="acct-opt">(opcional)</span></label>
                <input type="text" id="rg-phone" name="phone" autocomplete="tel">
            </div>
            <div class="acct-field">
                <label for="rg-company">Empresa <span class="acct-opt">(opcional)</span></label>
                <input type="text" id="rg-company" name="company" autocomplete="organization">
            </div>
            <div class="acct-field">
                <label for="rg-pass">Contraseña</label>
                <input type="password" id="rg-pass" name="password" required minlength="8" autocomplete="new-password">
                <span class="acct-hint">Mínimo 8 caracteres.</span>
            </div>
            <button type="submit" class="btn acct-submit">Crear cuenta</button>
        </form>
    </div>
</main>
<script>
(function () {
    var tabs = document.querySelectorAll('[data-acct-tab]');
    var panes = document.querySelectorAll('[data-acct-pane]');
    tabs.forEach(function (t) {
        t.addEventListener('click', function () {
            var key = t.getAttribute('data-acct-tab');
            tabs.forEach(function (x) { x.classList.toggle('is-active', x === t); });
            panes.forEach(function (p) { p.hidden = p.getAttribute('data-acct-pane') !== key; });
        });
    });
})();
</script>
    <?php
    layoutEnd();
}

/* -------------------- render: verificar email -------------------- */

function accountRenderVerify(): void {
    $ok = customerVerifyEmail((string) ($_GET['token'] ?? ''));
    layoutStart([
        'title'        => 'Verificación de email',
        'current_slug' => 'mi-cuenta',
    ]);
    ?>
<main class="container acct acct--auth">
    <div class="acct-authcard acct-authcard--narrow" style="text-align:center;">
        <?php if ($ok): ?>
            <svg viewBox="0 0 24 24" width="56" height="56" fill="none" stroke="#22c55e" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" style="margin:0 auto 1rem;display:block;"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
            <h1>¡Email verificado!</h1>
            <p>Tu cuenta quedó confirmada. Gracias.</p>
        <?php else: ?>
            <svg viewBox="0 0 24 24" width="56" height="56" fill="none" stroke="#f59e0b" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" style="margin:0 auto 1rem;display:block;"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <h1>Enlace no válido</h1>
            <p>El enlace de verificación expiró o ya fue usado. Si ya verificaste tu email, no hace falta hacer nada.</p>
        <?php endif; ?>
        <p style="margin-top:1.5rem;"><a href="/mi-cuenta" class="btn">Ir a mi cuenta</a></p>
    </div>
</main>
    <?php
    layoutEnd();
}

/* -------------------- render: recuperar contraseña -------------------- */

function accountRenderRecover(): void {
    $msg = flashGet('account_msg');
    layoutStart([
        'title'        => 'Recuperar contraseña',
        'current_slug' => 'mi-cuenta',
    ]);
    ?>
<main class="container acct acct--auth">
    <div class="acct-authcard acct-authcard--narrow">
        <div class="acct-authhead">
            <h1>Recuperar contraseña</h1>
            <p>Ingresá tu email y te enviamos un enlace para crear una nueva.</p>
        </div>
        <?php if ($msg): ?><div class="acct-flash acct-flash--ok"><?= htmlspecialchars($msg) ?></div><?php endif; ?>
        <form method="post" action="/mi-cuenta" class="acct-form">
            <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
            <input type="hidden" name="action" value="request_reset">
            <div class="acct-field">
                <label for="rc-email">Email</label>
                <input type="email" id="rc-email" name="email" required autocomplete="email">
            </div>
            <button type="submit" class="btn acct-submit">Enviar enlace</button>
            <p class="acct-alt"><a href="/mi-cuenta">← Volver a ingresar</a></p>
        </form>
    </div>
</main>
    <?php
    layoutEnd();
}

/* -------------------- render: restablecer contraseña -------------------- */

function accountRenderReset(): void {
    $token = (string) ($_GET['token'] ?? '');
    $valid = customerResetTokenValid($token);
    $err   = flashGet('account_err');
    layoutStart([
        'title'        => 'Nueva contraseña',
        'current_slug' => 'mi-cuenta',
    ]);
    ?>
<main class="container acct acct--auth">
    <div class="acct-authcard acct-authcard--narrow">
        <div class="acct-authhead">
            <h1>Nueva contraseña</h1>
        </div>
        <?php if ($err): ?><div class="acct-flash acct-flash--err"><?= htmlspecialchars($err) ?></div><?php endif; ?>
        <?php if (!$valid): ?>
            <p>El enlace expiró o no es válido. <a href="/mi-cuenta/recuperar">Pedí uno nuevo</a>.</p>
        <?php else: ?>
            <form method="post" action="/mi-cuenta" class="acct-form">
                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                <input type="hidden" name="action" value="reset_password">
                <input type="hidden" name="token" value="<?= htmlspecialchars($token) ?>">
                <div class="acct-field">
                    <label for="rs-pass">Contraseña nueva</label>
                    <input type="password" id="rs-pass" name="password" required minlength="8" autocomplete="new-password">
                    <span class="acct-hint">Mínimo 8 caracteres.</span>
                </div>
                <button type="submit" class="btn acct-submit">Guardar contraseña</button>
            </form>
        <?php endif; ?>
    </div>
</main>
    <?php
    layoutEnd();
}

/* =======================================================================
 * /favoritos — wishlist client-side
 * ===================================================================== */

function favoritesFrontRoute(string $path): bool {
    if ($path !== 'favoritos') return false;
    favoritesRenderPage();
    return true;
}

function favoritesRenderPage(): void {
    layoutStart([
        'title'        => 'Mis favoritos',
        'description'  => 'Tus productos favoritos en GreenBags — guardá lo que más te interesa.',
        'current_slug' => 'favoritos',
    ]);
    ?>
<main class="container fav" id="fav-page">
    <div class="fav-head">
        <h1 class="acct-title">Mis favoritos</h1>
        <div id="fav-toolbar" class="fav-toolbar" hidden>
            <button type="button" class="btn btn--ghost btn--small" data-fav-clear>Vaciar favoritos</button>
        </div>
    </div>

    <div id="fav-empty" class="fav-empty">
        <svg viewBox="0 0 24 24" width="56" height="56" fill="none" stroke="#73BF6D" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
        <p>Todavía no guardaste favoritos. Tocá el corazón en cualquier producto para guardarlo acá.</p>
        <p class="fav-empty__cta">
            <a href="/catalogo" class="btn">Ir a la tienda</a>
            <a href="/cotizacion" class="btn btn--secondary">Ver mi cotización</a>
        </p>
    </div>

    <div id="fav-grid" class="fav-grid"></div>
</main>
    <?php
    layoutEnd();
}
