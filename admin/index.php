<?php

require __DIR__ . '/../lib/bootstrap.php';
require __DIR__ . '/../lib/admin_shop.php';

$LEAD_STATUSES    = ['new', 'contacted', 'qualified', 'closed', 'discarded'];
$SETTING_KEYS     = [
    'site_name', 'timezone',
    'logo_image', 'favicon_image',
    // Alto del logo (px) en header y footer, escritorio y celular.
    'logo_height_desktop', 'logo_height_mobile',
    'footer_logo_height_desktop', 'footer_logo_height_mobile',
    'header_style',
    // Paleta de marca.
    'theme_primary', 'theme_secondary',
    // Announce bar (barra superior editable).
    'announce_enabled', 'announce_text', 'announce_link_url', 'announce_link_label',
    'announce_bg', 'announce_fg',
    'notification_email', 'notification_from',
    'autoreply_enabled', 'autoreply_subject', 'autoreply_body',
    'ga_id', 'pixel_id',
    // Home estándar (landing).
    'home_hero_eyebrow', 'home_hero_title', 'home_hero_subtitle',
    'home_hero_cta_label', 'home_hero_cta_url', 'home_hero_image',
    'home_show_benefits', 'home_show_categories', 'home_show_featured', 'home_show_story',
    'home_categories_layout',
    'home_story_title', 'home_story_body', 'home_story_cta_label', 'home_story_cta_url', 'home_story_image',
    'home_cta_title', 'home_cta_subtitle', 'home_cta_label', 'home_cta_url',
    // Imágenes de páginas internas (editables por panel vía tokens {{img:...}}).
    'about_media_image', 'sustentabilidad_media_image',
    // Catálogo: cómo se muestran los atributos de variación en la ficha.
    'variations_display_mode',
];
// Contenido de la página de inicio, editable desde su propia vista
// (admin → Páginas → Inicio). Se guarda con la acción save_home para no
// pisar toggles de otras secciones (announce/autoreply) al guardar el home.
$HOME_KEYS        = [
    'home_hero_eyebrow', 'home_hero_title', 'home_hero_subtitle',
    'home_hero_cta_label', 'home_hero_cta_url', 'home_hero_image',
    'home_show_benefits', 'home_show_categories', 'home_show_featured',
    'home_show_story', 'home_show_clients',
    'home_categories_layout',
    'home_story_title', 'home_story_body', 'home_story_cta_label', 'home_story_cta_url', 'home_story_image',
    'home_cta_title', 'home_cta_subtitle', 'home_cta_label', 'home_cta_url',
    'home_clients_title',
];
$HOME_TOGGLES     = ['home_show_benefits', 'home_show_categories', 'home_show_featured', 'home_show_story', 'home_show_clients'];
// Settings exclusivas del módulo "Mailing" (separadas para no mezclarse con
// los toggles generales).
$MAILING_KEYS     = [
    'mail_provider',
    'resend_api_key', 'resend_from_name', 'resend_from_email', 'resend_reply_to',
    'notification_email', 'notification_subject', 'notification_body',
    'autoreply_enabled', 'autoreply_subject', 'autoreply_body', 'autoreply_body_html',
];
// Settings de pasarelas y métodos de pago (admin → Pagos).
$PAYMENT_KEYS     = [
    'pay_flow_enabled', 'flow_environment', 'flow_api_key', 'flow_secret_key',
    'pay_mercadopago_enabled', 'mp_public_key', 'mp_access_token',
    'pay_transbank_enabled', 'tbk_environment', 'tbk_commerce_code', 'tbk_api_key',
    'pay_bank_transfer_enabled', 'pay_bank_transfer_instructions',
    'pay_cod_enabled', 'pay_cod_instructions',
];

$action     = $_POST['action'] ?? $_GET['action'] ?? '';
$view       = $_GET['view'] ?? '';
$loginError = '';
$pwError    = '';
$pageError  = '';

// -------------------- acciones públicas (sin login) --------------------
if ($action === 'login') {
    csrfCheck();
    $result = login($_POST['email'] ?? '', $_POST['password'] ?? '');
    if ($result === 'ok') redirect('/admin/');
    $loginError = $result === 'rate_limited'
        ? 'Demasiados intentos fallidos. Esperá 15 minutos.'
        : 'Credenciales inválidas.';
}

if ($action === 'logout') {
    csrfCheck();
    logout();
    redirect('/admin/');
}

// -------------------- acciones autenticadas --------------------
$user = currentUser();

if ($user) {
    // Migraciones solo para usuarios autenticados (evita pingback anónimo).
    runMigrations();

    // Si la sesión arrastra la flag must_change_password, forzamos vista
    // "Mi cuenta" hasta que se cambie. Solo permitimos las acciones mínimas
    // necesarias para resolverlo o salir.
    if (!empty($user['must_change_password'])) {
        $allowedActions = ['change_password', 'logout', ''];
        if (!in_array($action, $allowedActions, true) || ($action === '' && $view !== 'account')) {
            flashSet('pw_must_change', 'Debés cambiar tu contraseña antes de continuar.');
            redirect('/admin/?view=account');
        }
        $view = 'account';
    }

    // Acciones de la tienda (catálogo). Redirige si la acción es de tienda.
    handleShopAdminActions($user, $action);

    // ─── Banners (hero slider) ───
    if ($action === 'banner_save') {
        csrfCheck();
        $res = bannerSave($_POST);
        if ($res['ok']) {
            flashSet('banner_msg', 'Banner guardado.');
            redirect('/admin/?view=banner&id=' . (int) $res['id']);
        }
        flashSet('banner_err', $res['error'] ?? 'No se pudo guardar.');
        redirect('/admin/?view=banner&id=' . (int) ($_POST['id'] ?? 0));
    }
    if ($action === 'banner_delete') {
        csrfCheck();
        bannerDelete((int) ($_POST['id'] ?? 0));
        flashSet('banner_msg', 'Banner eliminado.');
        redirect('/admin/?view=banners');
    }
    if ($action === 'banner_toggle') {
        csrfCheck();
        bannerToggleActive((int) ($_POST['id'] ?? 0));
        redirect('/admin/?view=banners');
    }

    // ─── Clientes ("Nuestros clientes" del home) ───
    if ($action === 'client_save') {
        csrfCheck();
        $res = clientSave($_POST);
        if ($res['ok']) {
            flashSet('client_msg', 'Cliente guardado.');
            redirect('/admin/?view=client&id=' . (int) $res['id']);
        }
        flashSet('client_err', $res['error'] ?? 'No se pudo guardar.');
        redirect('/admin/?view=client&id=' . (int) ($_POST['id'] ?? 0));
    }
    if ($action === 'client_delete') {
        csrfCheck();
        clientDelete((int) ($_POST['id'] ?? 0));
        flashSet('client_msg', 'Cliente eliminado.');
        redirect('/admin/?view=clients');
    }
    if ($action === 'client_toggle') {
        csrfCheck();
        clientToggleActive((int) ($_POST['id'] ?? 0));
        redirect('/admin/?view=clients');
    }

    // ─── Cotizaciones ───
    if ($action === 'quote_update_status') {
        csrfCheck();
        $qid = (int) ($_POST['id'] ?? 0);
        $st  = (string) ($_POST['status'] ?? '');
        if (quoteUpdateStatus($qid, $st, (int) $user['id'])) {
            flashSet('quote_msg', 'Estado actualizado.');
        }
        redirect('/admin/?view=quote&id=' . $qid);
    }
    if ($action === 'quote_add_note') {
        csrfCheck();
        $qid  = (int) ($_POST['id'] ?? 0);
        $body = (string) ($_POST['note'] ?? '');
        quoteAddInternalNote($qid, (int) $user['id'], $body);
        redirect('/admin/?view=quote&id=' . $qid);
    }
    if ($action === 'quote_send_response') {
        csrfCheck();
        $qid  = (int) ($_POST['id'] ?? 0);
        $subj = (string) ($_POST['subject'] ?? '');
        $body = (string) ($_POST['body']    ?? '');
        if (trim($subj) === '' || trim($body) === '') {
            flashSet('quote_err', 'Falta asunto o cuerpo de la respuesta.');
            redirect('/admin/?view=quote&id=' . $qid);
        }
        $res = quoteSendResponse($qid, (int) $user['id'], $subj, $body);
        flashSet($res['ok'] ? 'quote_msg' : 'quote_err',
            $res['ok'] ? 'Respuesta enviada por email.' : ($res['error'] ?? 'No se pudo enviar.'));
        redirect('/admin/?view=quote&id=' . $qid);
    }
    if ($action === 'quote_delete') {
        csrfCheck();
        $qid = (int) ($_POST['id'] ?? 0);
        quoteDelete($qid);
        flashSet('quote_msg', 'Cotización eliminada.');
        redirect('/admin/?view=quotes');
    }
    if ($action === 'quote_export_csv') {
        $search = trim((string) ($_GET['search'] ?? ''));
        $stf    = (string) ($_GET['status'] ?? '');
        $rows = quoteList(['search' => $search, 'status' => $stf]);
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="cotizaciones-' . date('Ymd-His') . '.csv"');
        $out = fopen('php://output', 'w');
        fwrite($out, "\xEF\xBB\xBF");
        fputcsv($out, ['id','numero','estado','nombre','email','empresa','items','subtotal','moneda','enviada_el']);
        foreach ($rows as $r) {
            fputcsv($out, [
                $r['id'], $r['quote_number'], $r['status'], $r['contact_name'],
                $r['contact_email'], $r['contact_company'], $r['items_count'],
                $r['subtotal_est'], $r['currency'], $r['submitted_at'],
            ]);
        }
        fclose($out);
        exit;
    }

    if ($action === 'change_password') {
        csrfCheck();
        $current = $_POST['current_password'] ?? '';
        $new     = $_POST['new_password']     ?? '';
        $confirm = $_POST['confirm_password'] ?? '';

        if (strlen($new) < 8)               $pwError = 'La nueva contraseña debe tener al menos 8 caracteres.';
        elseif ($new !== $confirm)          $pwError = 'Las contraseñas no coinciden.';
        elseif (!changePassword($_SESSION['user_id'], $current, $new))
                                             $pwError = 'Contraseña actual incorrecta.';
        else {
            flashSet('pw_success', 'Contraseña actualizada.');
            redirect('/admin/?view=account');
        }
        $view = 'account';
    }

    if ($action === 'update_lead_status') {
        csrfCheck();
        $id     = (int) ($_POST['id'] ?? 0);
        $status = in_array($_POST['status'] ?? '', $LEAD_STATUSES, true) ? $_POST['status'] : 'new';
        $stmt = getDB()->prepare('UPDATE leads SET status = ? WHERE id = ?');
        $stmt->execute([$status, $id]);
        redirect('/admin/?id=' . $id);
    }

    if ($action === 'add_note') {
        csrfCheck();
        $id   = (int) ($_POST['id'] ?? 0);
        $body = trim($_POST['note'] ?? '');
        if ($body !== '' && $id > 0) {
            $stmt = getDB()->prepare(
                'INSERT INTO lead_notes (lead_id, user_id, body) VALUES (?, ?, ?)'
            );
            $stmt->execute([$id, $user['id'], $body]);
        }
        redirect('/admin/?id=' . $id);
    }

    if ($action === 'delete_lead') {
        csrfCheck();
        $id = (int) ($_POST['id'] ?? 0);
        $stmt = getDB()->prepare('DELETE FROM leads WHERE id = ?');
        $stmt->execute([$id]);
        redirect('/admin/');
    }

    if ($action === 'save_settings') {
        csrfCheck();
        $submitted = $_POST['s'] ?? [];
        // Checkboxes: si no viene, es 0.
        $submitted['autoreply_enabled'] = !empty($submitted['autoreply_enabled']) ? '1' : '0';
        foreach (['home_show_benefits','home_show_categories','home_show_featured','home_show_story','announce_enabled'] as $sw) {
            $submitted[$sw] = !empty($submitted[$sw]) ? '1' : '0';
        }
        foreach ($SETTING_KEYS as $k) {
            if (array_key_exists($k, $submitted)) {
                setSetting($k, (string) $submitted[$k]);
            }
        }
        flashSet('settings_success', 'Configuración actualizada.');
        redirect('/admin/?view=settings');
    }

    // Guardado del editor de "Inicio" (solo toca las claves del home).
    if ($action === 'save_home') {
        csrfCheck();
        $submitted = $_POST['s'] ?? [];
        foreach ($HOME_TOGGLES as $sw) {
            $submitted[$sw] = !empty($submitted[$sw]) ? '1' : '0';
        }
        foreach ($HOME_KEYS as $k) {
            if (array_key_exists($k, $submitted)) {
                setSetting($k, (string) $submitted[$k]);
            }
        }
        flashSet('home_success', 'Página de inicio actualizada.');
        redirect('/admin/?view=home_edit');
    }

    if ($action === 'save_contact') {
        csrfCheck();
        $submitted = $_POST['c'] ?? [];
        if (!is_array($submitted)) $submitted = [];

        // Toggles (vacíos = 0).
        foreach (['contact_show_methods','contact_show_form','contact_show_map','contact_show_branches'] as $sw) {
            $submitted[$sw] = !empty($submitted[$sw]) ? '1' : '0';
        }

        // Settings de texto / toggles → tabla settings.
        foreach (CONTACT_KEYS as $k) {
            if (array_key_exists($k, $submitted)) {
                setSetting($k, (string) $submitted[$k]);
            }
        }

        // Entrada en `pages` (controla visibilidad en menú y el título del nav).
        $pageTitle = trim((string) ($submitted['page_title'] ?? 'Contacto'));
        if ($pageTitle === '') $pageTitle = 'Contacto';
        $pagePub   = !empty($submitted['is_published']) ? 1 : 0;
        try {
            $stmt = getDB()->prepare(
                'INSERT INTO pages (slug, title, body, meta_description, is_published, exclude_from_menu)
                 VALUES ("contacto", ?, "", ?, ?, 0)
                 ON DUPLICATE KEY UPDATE title = VALUES(title), is_published = VALUES(is_published), exclude_from_menu = 0'
            );
            $metaForPage = (string) ($submitted['contact_meta_description'] ?? '');
            $stmt->execute([$pageTitle, $metaForPage, $pagePub]);
        } catch (Throwable $e) {
            error_log('save_contact pages upsert: ' . $e->getMessage());
        }

        flashSet('contact_success', 'Página de contacto actualizada.');
        redirect('/admin/?view=contact');
    }

    if ($action === 'save_business') {
        csrfCheck();
        $submitted = $_POST['b'] ?? [];
        $submitted['business_seo_jsonld'] = !empty($submitted['business_seo_jsonld']) ? '1' : '0';
        foreach (BUSINESS_KEYS as $k) {
            if (array_key_exists($k, $submitted)) {
                setSetting($k, (string) $submitted[$k]);
            }
        }
        flashSet('business_success', 'Información del negocio actualizada.');
        redirect('/admin/?view=business');
    }

    if ($action === 'branch_save') {
        csrfCheck();
        $bid  = (int) ($_POST['id'] ?? 0);
        $data = $_POST['br'] ?? [];
        $res  = branchSave($bid > 0 ? $bid : null, is_array($data) ? $data : []);
        if ($res['ok']) {
            flashSet('business_success', $bid > 0 ? 'Sucursal actualizada.' : 'Sucursal creada.');
        } else {
            flashSet('business_error', $res['error'] ?? 'No se pudo guardar la sucursal.');
        }
        redirect('/admin/?view=business');
    }

    if ($action === 'branch_delete') {
        csrfCheck();
        branchDelete((int) ($_POST['id'] ?? 0));
        flashSet('business_success', 'Sucursal eliminada.');
        redirect('/admin/?view=business');
    }

    if ($action === 'branch_toggle') {
        csrfCheck();
        branchToggleActive((int) ($_POST['id'] ?? 0));
        redirect('/admin/?view=business');
    }

    if ($action === 'save_payments') {
        csrfCheck();
        $submitted = $_POST['p'] ?? [];
        // Checkboxes: si no viene la key, queda en 0.
        foreach (['pay_flow_enabled','pay_mercadopago_enabled','pay_transbank_enabled','pay_bank_transfer_enabled','pay_cod_enabled'] as $sw) {
            $submitted[$sw] = !empty($submitted[$sw]) ? '1' : '0';
        }
        // Ambientes con whitelist (evita guardar basura).
        if (isset($submitted['flow_environment'])) {
            $submitted['flow_environment'] = in_array($submitted['flow_environment'], ['sandbox','production'], true)
                ? $submitted['flow_environment'] : 'sandbox';
        }
        if (isset($submitted['tbk_environment'])) {
            $submitted['tbk_environment'] = in_array($submitted['tbk_environment'], ['integration','production'], true)
                ? $submitted['tbk_environment'] : 'integration';
        }
        foreach ($PAYMENT_KEYS as $k) {
            if (array_key_exists($k, $submitted)) {
                setSetting($k, (string) $submitted[$k]);
            }
        }
        flashSet('payments_success', 'Configuración de pagos actualizada.');
        redirect('/admin/?view=payments');
    }

    if ($action === 'save_mailing') {
        csrfCheck();
        $submitted = $_POST['m'] ?? [];
        $submitted['autoreply_enabled'] = !empty($submitted['autoreply_enabled']) ? '1' : '0';
        $provider = ($submitted['mail_provider'] ?? 'mail') === 'resend' ? 'resend' : 'mail';
        $submitted['mail_provider'] = $provider;
        foreach ($MAILING_KEYS as $k) {
            if (array_key_exists($k, $submitted)) {
                setSetting($k, (string) $submitted[$k]);
            }
        }
        flashSet('mailing_success', 'Configuración de mailing actualizada.');
        redirect('/admin/?view=mailing');
    }

    if ($action === 'send_test_email') {
        csrfCheck();
        $to = trim((string) ($_POST['to'] ?? ''));
        if (!$to) $to = (string) getSetting('notification_email', '');
        $res = sendTestNotificationEmail($to);
        if ($res['ok']) flashSet('mailing_success', 'Correo de prueba enviado a ' . $to . '.');
        else flashSet('mailing_error', 'No se pudo enviar: ' . ($res['error'] ?? 'error desconocido'));
        redirect('/admin/?view=mailing');
    }

    if ($action === 'export_csv') {
        $search       = trim($_GET['search'] ?? '');
        $statusFilter = $_GET['status_filter'] ?? '';
        $where  = [];
        $params = [];
        if ($search !== '') {
            $where[] = '(name LIKE ? OR email LIKE ? OR phone LIKE ?)';
            $like = '%' . $search . '%';
            array_push($params, $like, $like, $like);
        }
        if (in_array($statusFilter, $LEAD_STATUSES, true)) {
            $where[] = 'status = ?';
            $params[] = $statusFilter;
        }
        $whereSql = $where ? 'WHERE ' . implode(' AND ', $where) : '';

        $stmt = getDB()->prepare(
            "SELECT id, name, email, phone, message, source, status, ip_address, created_at
             FROM leads $whereSql ORDER BY created_at DESC"
        );
        $stmt->execute($params);

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="leads-' . date('Ymd-His') . '.csv"');
        $out = fopen('php://output', 'w');
        fwrite($out, "\xEF\xBB\xBF"); // BOM UTF-8 para Excel
        fputcsv($out, ['id', 'nombre', 'email', 'telefono', 'mensaje', 'source', 'estado', 'ip', 'fecha']);
        while ($row = $stmt->fetch()) {
            fputcsv($out, $row);
        }
        fclose($out);
        exit;
    }

    // ─── Gestión de usuarios ───
    if ($action === 'create_user') {
        csrfCheck();
        $newEmail = (string) ($_POST['email'] ?? '');
        $newName  = (string) ($_POST['name'] ?? '');
        $newPw    = (string) ($_POST['password'] ?? '');
        $mustChange = !empty($_POST['must_change_password']);
        $res = userCreate($newEmail, $newPw, $newName, $mustChange);
        if ($res['ok']) {
            flashSet('user_success', 'Usuario creado: ' . trim($newEmail));
            redirect('/admin/?view=users');
        }
        $userFormError = $res['error'] ?? 'No se pudo crear.';
        $userFormEmail = trim($newEmail);
        $userFormName  = trim($newName);
        $view = 'users';
    }

    if ($action === 'update_user_profile') {
        csrfCheck();
        $targetId = (int) ($_POST['id'] ?? 0);
        if ($targetId <= 0) redirect('/admin/?view=users');
        $res = userUpdateProfile(
            $targetId,
            (string) ($_POST['email'] ?? ''),
            (string) ($_POST['name'] ?? '')
        );
        if ($res['ok']) {
            flashSet('user_success', 'Perfil actualizado.');
            redirect('/admin/?view=user&id=' . $targetId);
        }
        flashSet('user_error', $res['error']);
        redirect('/admin/?view=user&id=' . $targetId);
    }

    if ($action === 'reset_user_password') {
        csrfCheck();
        $targetId = (int) ($_POST['id'] ?? 0);
        $newPw    = (string) ($_POST['new_password'] ?? '');
        if ($targetId <= 0) redirect('/admin/?view=users');
        $res = adminResetPassword($targetId, $newPw);
        if ($res['ok']) {
            flashSet('user_success', 'Contraseña actualizada.');
            redirect('/admin/?view=user&id=' . $targetId);
        }
        $userPwError = $res['error'];
        $view = 'user';
        $_GET['id'] = (string) $targetId;
    }

    if ($action === 'toggle_user_active') {
        csrfCheck();
        $targetId = (int) ($_POST['id'] ?? 0);
        if ($targetId <= 0 || $targetId === (int) $user['id']) {
            flashSet('user_error', 'No podés modificar tu propio estado de acceso.');
            redirect('/admin/?view=users');
        }
        $target = userGet($targetId);
        if (!$target) {
            flashSet('user_error', 'Usuario no encontrado.');
            redirect('/admin/?view=users');
        }
        $willDeactivate = (int) $target['is_active'] === 1;
        if ($willDeactivate && activeUserCount() <= 1) {
            flashSet('user_error', 'No podés desactivar al último usuario activo.');
            redirect('/admin/?view=user&id=' . $targetId);
        }
        userSetActive($targetId, !$willDeactivate);
        flashSet('user_success', $willDeactivate ? 'Usuario desactivado.' : 'Usuario reactivado.');
        redirect('/admin/?view=user&id=' . $targetId);
    }

    if ($action === 'delete_user') {
        csrfCheck();
        $targetId = (int) ($_POST['id'] ?? 0);
        if ($targetId <= 0 || $targetId === (int) $user['id']) {
            flashSet('user_error', 'No podés eliminar tu propia cuenta.');
            redirect('/admin/?view=users');
        }
        $target = userGet($targetId);
        if (!$target) {
            flashSet('user_error', 'Usuario no encontrado.');
            redirect('/admin/?view=users');
        }
        if ((int) $target['is_active'] === 1 && activeUserCount() <= 1) {
            flashSet('user_error', 'No podés eliminar al último usuario activo.');
            redirect('/admin/?view=user&id=' . $targetId);
        }
        userDelete($targetId);
        flashSet('user_success', 'Usuario eliminado: ' . $target['email']);
        redirect('/admin/?view=users');
    }

    if ($action === 'favicon_upload') {
        csrfCheck();
        $f = $_FILES['favicon'] ?? null;
        if (!$f || ($f['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
            flashSet('settings_error', 'No se recibió un archivo válido.');
            redirect('/admin/?view=settings');
        }
        if ((int) ($f['size'] ?? 0) > 2 * 1024 * 1024) {
            flashSet('settings_error', 'El archivo supera 2MB.');
            redirect('/admin/?view=settings');
        }
        $mime = function_exists('mime_content_type') ? (mime_content_type($f['tmp_name']) ?: '') : '';
        $allowed = [
            'image/png'                => 'png',
            'image/svg+xml'            => 'svg',
            'image/svg'                => 'svg',
            'image/x-icon'             => 'ico',
            'image/vnd.microsoft.icon' => 'ico',
        ];
        $ext      = strtolower(pathinfo((string) ($f['name'] ?? ''), PATHINFO_EXTENSION));
        $finalExt = $allowed[$mime] ?? null;
        if (!$finalExt && in_array($ext, ['png', 'svg', 'ico'], true)) $finalExt = $ext;
        if (!$finalExt) {
            flashSet('settings_error', 'Formato no permitido. Sube un PNG, SVG o ICO.');
            redirect('/admin/?view=settings');
        }
        $brandDir = __DIR__ . '/../uploads/brand';
        if (!is_dir($brandDir)) @mkdir($brandDir, 0755, true);
        foreach (['png', 'svg', 'ico'] as $oldExt) {
            @unlink($brandDir . '/favicon.' . $oldExt);
        }
        $dest = $brandDir . '/favicon.' . $finalExt;
        if ($finalExt === 'svg') {
            $svg = sanitizeSvgString((string) @file_get_contents($f['tmp_name']));
            if ($svg === null) {
                flashSet('settings_error', 'El SVG no se pudo procesar de forma segura.');
                redirect('/admin/?view=settings');
            }
            if (@file_put_contents($dest, $svg) === false) {
                flashSet('settings_error', 'No se pudo guardar el favicon.');
                redirect('/admin/?view=settings');
            }
        } else {
            if (!@move_uploaded_file($f['tmp_name'], $dest)) {
                flashSet('settings_error', 'No se pudo guardar el favicon.');
                redirect('/admin/?view=settings');
            }
        }
        setSetting('favicon_image', '/uploads/brand/favicon.' . $finalExt);
        flashSet('settings_success', 'Favicon actualizado.');
        redirect('/admin/?view=settings');
    }

    if ($action === 'favicon_remove') {
        csrfCheck();
        $brandDir = __DIR__ . '/../uploads/brand';
        foreach (['png', 'svg', 'ico'] as $oldExt) {
            @unlink($brandDir . '/favicon.' . $oldExt);
        }
        setSetting('favicon_image', '');
        flashSet('settings_success', 'Favicon eliminado.');
        redirect('/admin/?view=settings');
    }

    // ─── Central de Medios ───
    if ($action === 'media_folder_create') {
        csrfCheck();
        $name   = trim($_POST['name'] ?? '');
        $parent = (int) ($_POST['parent_id'] ?? 0) ?: null;
        $id = mediaFolderCreate($name, $parent);
        flashSet($id ? 'media_msg' : 'media_err', $id ? 'Carpeta creada.' : 'No se pudo crear la carpeta (¿slug duplicado?).');
        redirect('/admin/?view=media' . ($id ? '&folder=' . $id : ''));
    }
    if ($action === 'media_folder_delete') {
        csrfCheck();
        mediaFolderDelete((int) ($_POST['id'] ?? 0));
        flashSet('media_msg', 'Carpeta eliminada.');
        redirect('/admin/?view=media');
    }
    if ($action === 'media_upload_inline') {
        csrfCheck();
        header('Content-Type: application/json; charset=utf-8');
        $folderId = (int) ($_POST['folder_id'] ?? 0) ?: null;
        if (empty($_FILES['file']) || ($_FILES['file']['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
            echo json_encode(['ok' => false, 'error' => 'No se recibió un archivo válido.']);
            exit;
        }
        $r = mediaLibraryUpload($_FILES['file'], $folderId);
        if (empty($r['ok'])) {
            echo json_encode(['ok' => false, 'error' => $r['error'] ?? 'Falló la subida.']);
            exit;
        }
        echo json_encode(['ok' => true, 'id' => (int) ($r['id'] ?? 0), 'path' => $r['path'], 'name' => basename($r['path'])]);
        exit;
    }
    if ($action === 'media_upload') {
        csrfCheck();
        $folderId = (int) ($_POST['folder_id'] ?? 0) ?: null;
        $okN = 0; $errs = [];
        if (!empty($_FILES['files']['name']) && is_array($_FILES['files']['name'])) {
            $count = count($_FILES['files']['name']);
            for ($i = 0; $i < $count; $i++) {
                if (($_FILES['files']['error'][$i] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) continue;
                $f = [
                    'name'     => $_FILES['files']['name'][$i],
                    'type'     => $_FILES['files']['type'][$i],
                    'tmp_name' => $_FILES['files']['tmp_name'][$i],
                    'error'    => $_FILES['files']['error'][$i],
                    'size'     => $_FILES['files']['size'][$i],
                ];
                $r = mediaLibraryUpload($f, $folderId);
                if ($r['ok']) $okN++; else $errs[] = $r['error'] ?? 'fallo';
            }
        }
        flashSet('media_msg', "$okN imagen(es) subida(s)." . ($errs ? ' Errores: ' . implode('; ', $errs) : ''));
        redirect('/admin/?view=media' . ($folderId ? '&folder=' . $folderId : ''));
    }
    if ($action === 'media_delete') {
        csrfCheck();
        $id  = (int) ($_POST['id'] ?? 0);
        $row = mediaLibraryGet($id);
        $folderId = $row ? (int) $row['folder_id'] : 0;
        if ($id) mediaLibraryDelete($id);
        flashSet('media_msg', 'Imagen eliminada.');
        redirect('/admin/?view=media' . ($folderId ? '&folder=' . $folderId : ''));
    }
    if ($action === 'media_update') {
        csrfCheck();
        $mid = (int) ($_POST['id'] ?? 0);
        mediaLibraryUpdateAlt($mid, (string) ($_POST['alt'] ?? ''));
        $row = mediaLibraryGet($mid);
        $folderId = $row ? (int) $row['folder_id'] : 0;
        flashSet('media_msg', 'Texto alternativo actualizado.');
        redirect('/admin/?view=media' . ($folderId ? '&folder=' . $folderId : ''));
    }
    if ($action === 'media_move') {
        csrfCheck();
        $ids = (array) ($_POST['ids'] ?? []);
        $folderId = $_POST['folder_id'] !== '' ? (int) $_POST['folder_id'] : null;
        if ($folderId === 0) $folderId = null;
        mediaLibraryMove($ids, $folderId);
        flashSet('media_msg', 'Imagen(es) movida(s).');
        redirect('/admin/?view=media' . ($folderId ? '&folder=' . $folderId : ''));
    }

    if ($action === 'save_page' || $action === 'delete_page') {
        csrfCheck();
        $id = (int) ($_POST['id'] ?? 0);

        if ($action === 'delete_page' && $id > 0) {
            $stmt = getDB()->prepare('DELETE FROM pages WHERE id = ?');
            $stmt->execute([$id]);
            flashSet('page_success', 'Página eliminada.');
            redirect('/admin/?view=pages');
        }

        $slug    = slugify($_POST['slug'] ?? '');
        $title   = trim($_POST['title'] ?? '');
        $body    = $_POST['body'] ?? '';
        $meta    = trim($_POST['meta_description'] ?? '');
        $ogImage = trim($_POST['og_image'] ?? '');
        $hide    = !empty($_POST['hide_chrome']) ? 1 : 0;
        $pub     = !empty($_POST['is_published']) ? 1 : 0;
        $exclMenu = !empty($_POST['exclude_from_menu']) ? 1 : 0;

        if (!$slug || !$title) {
            $pageError = 'Slug y título son requeridos.';
            $pageFormData = ['id' => $id, 'slug' => $slug, 'title' => $title, 'body' => $body,
                             'meta_description' => $meta, 'og_image' => $ogImage,
                             'hide_chrome' => $hide, 'is_published' => $pub, 'exclude_from_menu' => $exclMenu];
            $view = 'page';
        } else {
            try {
                if ($id > 0) {
                    $stmt = getDB()->prepare(
                        'UPDATE pages SET slug=?, title=?, body=?, meta_description=?, og_image=?, hide_chrome=?, is_published=?, exclude_from_menu=? WHERE id=?'
                    );
                    $stmt->execute([$slug, $title, $body, $meta, $ogImage, $hide, $pub, $exclMenu, $id]);
                } else {
                    $stmt = getDB()->prepare(
                        'INSERT INTO pages (slug, title, body, meta_description, og_image, hide_chrome, is_published, exclude_from_menu) VALUES (?, ?, ?, ?, ?, ?, ?, ?)'
                    );
                    $stmt->execute([$slug, $title, $body, $meta, $ogImage, $hide, $pub, $exclMenu]);
                }
                flashSet('page_success', 'Página guardada.');
                redirect('/admin/?view=pages');
            } catch (PDOException $e) {
                $pageError = 'No se pudo guardar (¿slug duplicado?).';
                $pageFormData = ['id' => $id, 'slug' => $slug, 'title' => $title, 'body' => $body,
                                 'meta_description' => $meta, 'og_image' => $ogImage,
                                 'hide_chrome' => $hide, 'is_published' => $pub, 'exclude_from_menu' => $exclMenu];
                $view = 'page';
            }
        }
    }
}

// -------------------- datos para views --------------------
$lead     = null;
$notes    = [];
$leads    = [];
$leadId   = isset($_GET['id']) && $_GET['id'] !== 'new' ? (int) $_GET['id'] : 0;
$stats    = ['total' => 0, 'today' => 0, 'this_week' => 0, 'new' => 0];
$search       = trim($_GET['search'] ?? '');
$statusFilter = $_GET['status_filter'] ?? '';
$page         = max(1, (int) ($_GET['page'] ?? 1));
$perPage      = 25;
$totalLeads   = 0;
$totalPages   = 1;
$settings     = [];
$pages        = [];
$pageRec      = $pageFormData ?? null; // datos del registro/form (distinto de $page paginación)
$users        = [];
$userRec      = null;
$userFormError = $userFormError ?? '';
$userFormEmail = $userFormEmail ?? '';
$userFormName  = $userFormName  ?? '';
$userPwError   = $userPwError   ?? '';
$userSearch    = $userSearch    ?? '';

if ($user) {
    $db = getDB();

    if ($view === 'settings') {
        foreach ($SETTING_KEYS as $k) {
            $settings[$k] = (string) getSetting($k, '');
        }
    } elseif ($view === 'home_edit') {
        foreach ($HOME_KEYS as $k) {
            $settings[$k] = (string) getSetting($k, '');
        }
        $homeBannerCount = count(bannerListAll());
        $homeClientCount = count(clientsListAll());
    } elseif ($view === 'mailing') {
        foreach ($MAILING_KEYS as $k) {
            $settings[$k] = (string) getSetting($k, '');
        }
    } elseif ($view === 'payments') {
        foreach ($PAYMENT_KEYS as $k) {
            $settings[$k] = (string) getSetting($k, '');
        }
    } elseif ($view === 'business') {
        $settings = businessInfo();
        $branches = branchesAll();
        $branchEdit = null;
        $editId = (int) ($_GET['branch'] ?? 0);
        if ($editId > 0) $branchEdit = branchGet($editId);
    } elseif ($view === 'contact') {
        $settings = contactSettings();
        try {
            $stmt = $db->prepare('SELECT id, slug, title, is_published, exclude_from_menu FROM pages WHERE slug = ? LIMIT 1');
            $stmt->execute(['contacto']);
            $contactPage = $stmt->fetch() ?: null;
        } catch (Throwable $e) {
            $contactPage = null;
        }
    } elseif ($view === 'pages') {
        $pages = $db->query('SELECT id, slug, title, is_published, updated_at FROM pages ORDER BY updated_at DESC')->fetchAll();
    } elseif ($view === 'page') {
        if ($pageRec === null) { // no vino de una re-render por error
            $pid = $_GET['id'] ?? '';
            if ($pid !== 'new' && $pid !== '') {
                $stmt = $db->prepare('SELECT * FROM pages WHERE id = ?');
                $stmt->execute([(int) $pid]);
                $pageRec = $stmt->fetch() ?: null;
            }
        }
    } elseif ($view === 'users') {
        $userSearch = trim($_GET['q'] ?? '');
        $users = usersList($userSearch);
    } elseif ($view === 'user') {
        $uid = (int) ($_GET['id'] ?? 0);
        $userRec = $uid > 0 ? userGet($uid) : null;
        if (!$userRec) redirect('/admin/?view=users');
    } elseif ($view === 'products') {
        $shopSearch  = trim($_GET['search'] ?? '');
        $shopStatus  = $_GET['status'] ?? '';
        $shopPage    = max(1, (int) ($_GET['page'] ?? 1));
        $shopPerPage = 25;
        $shopProducts = productAdminList(['search' => $shopSearch, 'status' => $shopStatus, 'page' => $shopPage, 'perPage' => $shopPerPage]);
    } elseif ($view === 'products_bulk') {
        $bulkSearch   = trim($_GET['search'] ?? '');
        $bulkStatus   = $_GET['status'] ?? '';
        $bulkProducts = productBulkList(['search' => $bulkSearch, 'status' => $bulkStatus]);
    } elseif ($view === 'product') {
        $pid = $_GET['id'] ?? '';
        $product = ($pid !== 'new' && $pid !== '') ? productGet((int) $pid) : null;
        $productCatIds   = $product ? productCategoryIds((int) $product['id']) : [];
        $productImageIds = $product ? array_map(fn($i) => (int) $i['id'], productImages((int) $product['id'])) : [];
        $productOptions  = $product ? productOptions((int) $product['id']) : [];
        $productVariationsList = $product ? productVariations((int) $product['id']) : [];
        $productTiers    = $product ? productTiers((int) $product['id']) : [];
        $productVideos   = $product ? productVideos((int) $product['id']) : [];
        $allCategoryOptions = categoryOptions();
        $allMedia = mediaLibraryAll(500);
    } elseif ($view === 'categories') {
        $categories = categoryList(false);
    } elseif ($view === 'category') {
        $cid = $_GET['id'] ?? '';
        $category = ($cid !== 'new' && $cid !== '') ? categoryGet((int) $cid) : null;
        $categoryParentOptions = categoryOptions($category ? (int) $category['id'] : 0);
        $allMedia = mediaLibraryAll(500);
    } elseif ($view === 'banners') {
        $banners = bannerListAll();
    } elseif ($view === 'banner') {
        $bid = $_GET['id'] ?? '';
        $banner = ($bid !== 'new' && $bid !== '') ? bannerGet((int) $bid) : null;
        $allMedia = mediaLibraryAll(500);
    } elseif ($view === 'clients') {
        $clients = clientsListAll();
    } elseif ($view === 'client') {
        $cid = $_GET['id'] ?? '';
        $client = ($cid !== 'new' && $cid !== '') ? clientGet((int) $cid) : null;
    } elseif ($view === 'quotes') {
        quoteExpireOverdue();   // marca como expired las vencidas (idempotente, barato)
        $quoteSearch = trim((string) ($_GET['search'] ?? ''));
        $quoteStatus = (string) ($_GET['status'] ?? '');
        $quotes      = quoteList(['search' => $quoteSearch, 'status' => $quoteStatus]);
        $quoteStats  = quoteStats();
    } elseif ($view === 'quote') {
        $qid = (int) ($_GET['id'] ?? 0);
        $quote = $qid > 0 ? quoteGet($qid) : null;
        if (!$quote) redirect('/admin/?view=quotes');
        $quoteItemsList = quoteGetItems($qid);
        $quoteNotesList = quoteGetNotes($qid);
        $quoteHistory   = quoteGetHistory($qid);
    } elseif ($leadId > 0) {
        $stmt = $db->prepare('SELECT * FROM leads WHERE id = ?');
        $stmt->execute([$leadId]);
        $lead = $stmt->fetch() ?: null;
        if ($lead) {
            $stmt = $db->prepare(
                'SELECT n.body, n.created_at, u.email AS author_email
                 FROM lead_notes n LEFT JOIN users u ON u.id = n.user_id
                 WHERE n.lead_id = ? ORDER BY n.created_at DESC'
            );
            $stmt->execute([$leadId]);
            $notes = $stmt->fetchAll();
        }
    } elseif (!in_array($view, ['account', 'media', 'users', 'user', 'mailing', 'business', 'contact', 'quotes', 'quote'], true)) {
        $stats['total']     = (int) $db->query('SELECT COUNT(*) FROM leads')->fetchColumn();
        $stats['today']     = (int) $db->query('SELECT COUNT(*) FROM leads WHERE DATE(created_at) = CURDATE()')->fetchColumn();
        $stats['this_week'] = (int) $db->query('SELECT COUNT(*) FROM leads WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)')->fetchColumn();
        $stats['new']       = (int) $db->query("SELECT COUNT(*) FROM leads WHERE status = 'new'")->fetchColumn();

        $where  = [];
        $params = [];
        if ($search !== '') {
            $where[] = '(name LIKE ? OR email LIKE ? OR phone LIKE ?)';
            $like = '%' . $search . '%';
            array_push($params, $like, $like, $like);
        }
        if (in_array($statusFilter, $LEAD_STATUSES, true)) {
            $where[] = 'status = ?';
            $params[] = $statusFilter;
        }
        $whereSql = $where ? 'WHERE ' . implode(' AND ', $where) : '';

        $cnt = $db->prepare("SELECT COUNT(*) FROM leads $whereSql");
        $cnt->execute($params);
        $totalLeads = (int) $cnt->fetchColumn();
        $totalPages = max(1, (int) ceil($totalLeads / $perPage));
        $page       = min($page, $totalPages);
        $offset     = ($page - 1) * $perPage;

        $sql = "SELECT id, name, email, source, status, created_at
                FROM leads $whereSql ORDER BY created_at DESC LIMIT ? OFFSET ?";
        $stmt = $db->prepare($sql);
        $i = 1;
        foreach ($params as $p) $stmt->bindValue($i++, $p, PDO::PARAM_STR);
        $stmt->bindValue($i++, $perPage, PDO::PARAM_INT);
        $stmt->bindValue($i++, $offset,  PDO::PARAM_INT);
        $stmt->execute();
        $leads = $stmt->fetchAll();
    }
}

$paginationUrl = function (int $p) use ($search, $statusFilter): string {
    $params = array_filter([
        'search' => $search, 'status_filter' => $statusFilter, 'page' => $p,
    ], fn($v) => $v !== '' && $v !== null);
    return '/admin/?' . http_build_query($params);
};

// -------------------- render: login --------------------
if (!$user) {
    $siteName = getSetting('site_name', 'Mi Sitio');
    $initial  = strtoupper(mb_substr($siteName, 0, 1)) ?: 'A';
    require __DIR__ . '/../components/auth/login.php';
    exit;
}
?>
<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin — <?= htmlspecialchars(getSetting('site_name', 'Admin')) ?></title>
<?php
$faviconPath = (string) getSetting('favicon_image', '');
$faviconAbs  = $faviconPath ? __DIR__ . '/..' . $faviconPath : '';
if ($faviconPath && @file_exists($faviconAbs)):
    $faviconHref = htmlspecialchars($faviconPath . '?v=' . @filemtime($faviconAbs));
?>
<link rel="icon" href="<?= $faviconHref ?>">
<?php endif; ?>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap">
<link rel="stylesheet" href="/assets/css/base.css">
<link rel="stylesheet" href="/assets/css/components.css">
<link rel="stylesheet" href="/assets/css/admin.css">
</head>
<body class="admin-body">
<div class="admin-shell">

    <?php require __DIR__ . '/../components/admin_nav.php'; ?>

    <main class="admin-main">
        <?php
        if ($view === 'account') {
            require __DIR__ . '/../components/admin/account.php';
        } elseif ($view === 'settings') {
            require __DIR__ . '/../components/admin/settings.php';
        } elseif ($view === 'home_edit') {
            require __DIR__ . '/../components/admin/home_edit.php';
        } elseif ($view === 'mailing') {
            require __DIR__ . '/../components/admin/mailing.php';
        } elseif ($view === 'payments') {
            require __DIR__ . '/../components/admin/payments.php';
        } elseif ($view === 'business') {
            require __DIR__ . '/../components/admin/business.php';
        } elseif ($view === 'contact') {
            require __DIR__ . '/../components/admin/contact.php';
        } elseif ($view === 'pages') {
            require __DIR__ . '/../components/admin/pages_list.php';
        } elseif ($view === 'page') {
            $page = $pageRec;
            require __DIR__ . '/../components/admin/page_edit.php';
        } elseif ($view === 'media') {
            require __DIR__ . '/../components/admin/media_library.php';
        } elseif ($view === 'users') {
            require __DIR__ . '/../components/admin/users_list.php';
        } elseif ($view === 'user') {
            require __DIR__ . '/../components/admin/user_edit.php';
        } elseif ($view === 'products') {
            require __DIR__ . '/../components/admin/shop/products_list.php';
        } elseif ($view === 'products_bulk') {
            require __DIR__ . '/../components/admin/shop/products_bulk.php';
        } elseif ($view === 'product') {
            require __DIR__ . '/../components/admin/shop/product_edit.php';
        } elseif ($view === 'categories') {
            require __DIR__ . '/../components/admin/shop/categories_list.php';
        } elseif ($view === 'category') {
            require __DIR__ . '/../components/admin/shop/category_edit.php';
        } elseif ($view === 'banners') {
            require __DIR__ . '/../components/admin/banners_list.php';
        } elseif ($view === 'banner') {
            require __DIR__ . '/../components/admin/banner_edit.php';
        } elseif ($view === 'clients') {
            require __DIR__ . '/../components/admin/clients_list.php';
        } elseif ($view === 'client') {
            require __DIR__ . '/../components/admin/client_edit.php';
        } elseif ($view === 'quotes') {
            require __DIR__ . '/../components/admin/quotes_list.php';
        } elseif ($view === 'quote') {
            require __DIR__ . '/../components/admin/quote_detail.php';
        } elseif ($lead) {
            require __DIR__ . '/../components/admin/lead_detail.php';
        } else {
            require __DIR__ . '/../components/admin/dashboard.php';
        }
        ?>
    </main>

</div>

<script>
(function(){
    const toggle = document.getElementById('sidebar-toggle');
    const sidebar = document.getElementById('admin-sidebar');
    const backdrop = document.getElementById('sidebar-backdrop');
    if (!toggle || !sidebar || !backdrop) return;
    const close = () => { sidebar.classList.remove('is-open'); backdrop.classList.remove('is-open'); };
    toggle.addEventListener('click', () => {
        sidebar.classList.toggle('is-open');
        backdrop.classList.toggle('is-open');
    });
    backdrop.addEventListener('click', close);
    document.addEventListener('keydown', e => { if (e.key === 'Escape') close(); });
})();
</script>

</body>
</html>
