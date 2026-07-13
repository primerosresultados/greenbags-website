<?php

require __DIR__ . '/lib/bootstrap.php';

// Router de la tienda: /tienda, /categoria/{slug}, /producto/{slug}, /carrito,
// /cotizacion (módulo quotes, sólo si está activo).
$reqPath = trim(parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH), '/');
if ($reqPath !== '') {
    if (quotesEnabled() && quoteFrontRoute($reqPath)) exit;
    if (shopFrontRoute($reqPath)) exit;
    // Cuenta de cliente (/mi-cuenta y subrutas) y favoritos: renderers a medida
    // que reemplazan las páginas placeholder de la tabla `pages`.
    if (function_exists('accountFrontRoute') && accountFrontRoute($reqPath)) exit;
    if (function_exists('favoritesFrontRoute') && favoritesFrontRoute($reqPath)) exit;
    // URLs de tienda inexistentes → 404 real (evita indexar productos borrados).
    // Se renderiza inline: el bootstrap ya está cargado, no re-incluir 404.php.
    if (preg_match('#^(producto|categoria)/#', $reqPath)) {
        http_response_code(404);
        layoutStart([
            'title'       => 'Página no encontrada (404)',
            'description' => 'El producto que buscás no existe o fue movido.',
        ]);
        echo '<main class="container" style="padding:3rem 1.2rem;text-align:center;">'
           . '<h1 style="font-size:2.4rem;margin:0 0 .5rem;">404</h1>'
           . '<p style="font-size:1.1rem;color:#64748b;margin:0 0 1.5rem;">No encontramos lo que buscás.</p>'
           . '<p><a href="/catalogo" class="btn">← Volver al catálogo</a></p></main>';
        layoutEnd();
        exit;
    }
}

// Router mínimo: si el path no es "/" y coincide con un slug publicado, renderizar esa página.
$path = trim(parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH), '/');
if ($path !== '' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $slug = slugify($path);
    if ($slug === $path) {
        try {
            $stmt = getDB()->prepare('SELECT title, body, meta_description, og_image, hide_chrome FROM pages WHERE slug = ? AND is_published = 1');
            $stmt->execute([$slug]);
            $cms = $stmt->fetch();
        } catch (Throwable $e) {
            $cms = null; // tabla todavía no migrada (instalación vieja sin admin visita)
        }
        if (!empty($cms)) {
            // /contacto usa un template a medida (cards + form + mapa + sucursales)
            // que toma datos de settings business_* y contact_*. El body de la
            // página en la tabla se ignora: la entrada existe solo para controlar
            // la visibilidad en el menú (is_published / exclude_from_menu) y el
            // título mostrado en el nav.
            if ($slug === 'contacto' && function_exists('contactPageRender')) {
                contactPageRender();
            }
            layoutStart([
                'title'        => (string) $cms['title'],
                'description'  => (string) ($cms['meta_description'] ?? ''),
                'og_image'     => (string) ($cms['og_image'] ?? ''),
                'current_slug' => $slug,
                'hide_chrome'  => !empty($cms['hide_chrome']),
            ]);
            ?>
<main class="container">
    <article class="page">
        <h1><?= htmlspecialchars($cms['title']) ?></h1>
        <?= pageBodyRender($cms['body']) /* HTML confiado: solo lo edita el admin autenticado. pageBodyRender resuelve tokens {{img:...}} editables por panel */ ?>
    </article>
</main>
<?php
            layoutEnd();
            exit;
        }
    }
}

$error = '';

// ============ Suscripción al newsletter (form en la banda CTA) ============
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'subscribe') {
    // Honeypot + timing.
    if (!empty($_POST['website']) || (time() - (int) ($_POST['form_started'] ?? 0)) < 2) {
        flashSet('subscribe_ok', '¡Gracias por suscribirte!');
        redirect('/#suscripcion');
    }
    csrfCheck();
    $email = trim((string) ($_POST['email'] ?? ''));
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        flashSet('subscribe_err', 'Por favor ingresa un correo válido.');
        redirect('/#suscripcion');
    }
    // Dedup últimos 30 días para evitar duplicar suscriptor existente.
    $dup = getDB()->prepare(
        "SELECT COUNT(*) FROM leads WHERE email = ? AND source = 'newsletter'
         AND created_at > DATE_SUB(NOW(), INTERVAL 30 DAY)"
    );
    $dup->execute([$email]);
    if ((int) $dup->fetchColumn() === 0) {
        $stmt = getDB()->prepare(
            'INSERT INTO leads (name, email, phone, message, source, status, ip_address, user_agent)
             VALUES (?, ?, ?, ?, ?, "new", ?, ?)'
        );
        $stmt->execute([
            'Suscriptor newsletter', $email, '', '', 'newsletter',
            clientIp(),
            substr((string) ($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 500),
        ]);
    }
    flashSet('subscribe_ok', '¡Gracias por suscribirte! Te enviaremos novedades pronto.');
    redirect('/#suscripcion');
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'submit_lead') {

    // Anti-spam: honeypot + timing. Fake success (los bots no se enteran).
    $honeypotTripped = !empty($_POST['website']);
    $tooFast         = !isset($_POST['form_started']) || (time() - (int) $_POST['form_started']) < 2;

    // Redirect destino para el lead form (la página de contacto vuelve a sí misma
    // con flash; el resto sigue al /gracias clásico).
    $source  = trim($_POST['source']  ?? 'website');
    $fromContactPage = ($source === 'contact_page');

    if ($honeypotTripped || $tooFast) {
        if ($fromContactPage) {
            flashSet('contact_ok', '1');
            redirect('/contacto?sent=1');
        }
        redirect('/?sent=1');
    }

    csrfCheck();
    $name    = trim($_POST['name']    ?? '');
    $email   = trim($_POST['email']   ?? '');
    $phone   = trim($_POST['phone']   ?? '');
    $company = trim($_POST['company'] ?? '');
    $message = trim($_POST['message'] ?? '');
    // La tabla leads no tiene columna "empresa" propia; se antepone al mensaje
    // para no requerir una migración solo por este campo opcional del form.
    if ($company !== '') {
        $message = "Empresa: {$company}" . ($message !== '' ? "\n\n{$message}" : '');
    }

    if (!$name || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        if ($fromContactPage) {
            flashSet('contact_err', 'Nombre y email válido son requeridos.');
            redirect('/contacto#contact-form');
        }
        $error = 'Nombre y email válido son requeridos.';
    } else {
        // Duplicate check: mismo email en los últimos 5 minutos → fake success.
        $dupe = getDB()->prepare(
            'SELECT COUNT(*) FROM leads
             WHERE email = ? AND created_at > DATE_SUB(NOW(), INTERVAL 5 MINUTE)'
        );
        $dupe->execute([$email]);

        if ((int) $dupe->fetchColumn() > 0) {
            if ($fromContactPage) {
                flashSet('contact_ok', '1');
                redirect('/contacto?sent=1');
            }
            redirect('/?sent=1');
        }

        $db = getDB();
        $stmt = $db->prepare(
            'INSERT INTO leads (name, email, phone, message, source, status, ip_address, user_agent)
             VALUES (?, ?, ?, ?, ?, "new", ?, ?)'
        );
        $stmt->execute([
            $name, $email, $phone, $message, $source,
            clientIp(),
            substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 500),
        ]);

        $lead = [
            'id'      => (int) $db->lastInsertId(),
            'name'    => $name,
            'email'   => $email,
            'phone'   => $phone,
            'message' => $message,
            'source'  => $source,
        ];

        // Notificaciones: no deben romper el flujo si fallan.
        try { notifyLeadCreated($lead); }   catch (Throwable $e) { error_log('notifyLead: ' . $e->getMessage()); }
        try { sendLeadAutoReply($lead); }   catch (Throwable $e) { error_log('autoReply: ' . $e->getMessage()); }

        if ($fromContactPage) {
            flashSet('contact_ok', '1');
            redirect('/contacto?sent=1');
        }
        redirect('/gracias');
    }
}

// Home (/) = landing comercial de venta (homeRender: hero + beneficios +
// categorías + destacados + storytelling + CTA). "Sobre GreenBags" vive en su
// propio slug (/sobre-greenbags) y /tienda redirige a /catalogo (ver
// shopFrontRoute) para no duplicar este landing.
homeRender($error);

