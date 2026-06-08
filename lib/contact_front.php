<?php

/**
 * Página de Contacto: render moderno con todos los medios de contacto.
 *
 * - Toma los datos "duros" (email, teléfono, WhatsApp, dirección, horarios,
 *   redes) de `business_*` en settings (editables desde admin → Negocio).
 * - Los textos editoriales (eyebrow, título hero, intro, etc.) viven en
 *   `contact_*` para que el cliente pueda ajustar el copy desde
 *   admin → Contacto sin tocar la página HTML.
 * - El form usa el mismo handler que el resto del sitio (action=submit_lead
 *   en /index.php), con source `contact_page` para attribution.
 * - La entrada en `pages` (slug=contacto) controla SOLO la visibilidad en
 *   el menú (is_published + exclude_from_menu) — el body es ignorado.
 */

const CONTACT_KEYS = [
    // Contenido editorial.
    'contact_eyebrow', 'contact_title', 'contact_intro',
    'contact_methods_title',
    'contact_form_title', 'contact_form_intro',
    'contact_form_success_title', 'contact_form_success_body',
    'contact_map_title', 'contact_map_embed',
    'contact_branches_title',
    // Toggles de secciones.
    'contact_show_methods', 'contact_show_form', 'contact_show_map', 'contact_show_branches',
    // SEO.
    'contact_meta_description',
];

/** Defaults razonables para cuando una key no está seteada. */
function contactSettings(): array {
    $defaults = [
        'contact_eyebrow'             => 'Estamos para ayudarte',
        'contact_title'               => 'Hablemos',
        'contact_intro'               => 'Elegí el canal que más te acomode. Respondemos en horario hábil, normalmente en menos de 4 horas.',
        'contact_methods_title'       => 'Canales directos',
        'contact_form_title'          => 'Escribinos un mensaje',
        'contact_form_intro'          => 'Contanos en qué podemos ayudarte y un ejecutivo te responde a la brevedad.',
        'contact_form_success_title'  => '¡Gracias por escribirnos!',
        'contact_form_success_body'   => 'Recibimos tu mensaje y te vamos a contactar en las próximas horas hábiles.',
        'contact_map_title'           => 'Dónde estamos',
        'contact_map_embed'           => '',
        'contact_branches_title'      => 'Nuestras sucursales',
        'contact_show_methods'        => '1',
        'contact_show_form'           => '1',
        'contact_show_map'            => '1',
        'contact_show_branches'       => '1',
        'contact_meta_description'    => '',
    ];
    $out = [];
    foreach (CONTACT_KEYS as $k) {
        $v = getSetting($k, null);
        $out[$k] = $v !== null && $v !== '' ? (string) $v : ($defaults[$k] ?? '');
    }
    // Toggles con default '1': si nunca se setearon, default arriba ya cubre.
    return $out;
}

/** Devuelve el título de la página `contacto` desde la tabla pages, o 'Contacto'. */
function contactPageTitle(): string {
    try {
        $stmt = getDB()->prepare('SELECT title FROM pages WHERE slug = ? LIMIT 1');
        $stmt->execute(['contacto']);
        $t = (string) ($stmt->fetchColumn() ?: '');
        return $t !== '' ? $t : 'Contacto';
    } catch (Throwable $e) {
        return 'Contacto';
    }
}

/**
 * Render principal de la página /contacto.
 * Asume que el caller ya validó que el método es GET. Sale con exit.
 */
function contactPageRender(): void {
    $c  = contactSettings();
    $b  = businessInfo();
    $socials = socialLinks();

    $branches = [];
    if ($c['contact_show_branches'] === '1') {
        try { $branches = branchesActive(); } catch (Throwable $e) { $branches = []; }
    }

    $pageTitle = contactPageTitle();
    $metaDesc  = $c['contact_meta_description'] !== ''
        ? $c['contact_meta_description']
        : (string) $c['contact_intro'];

    // Mensajes de éxito/error del form (vienen via flash redirect desde index.php).
    $okFlash  = function_exists('flashGet') ? flashGet('contact_ok')  : null;
    $errFlash = function_exists('flashGet') ? flashGet('contact_err') : null;

    layoutStart([
        'title'        => $pageTitle,
        'description'  => $metaDesc,
        'current_slug' => 'contacto',
    ]);
    ?>
    <link rel="stylesheet" href="/assets/css/contact.css?v=<?= @filemtime(__DIR__ . '/../assets/css/contact.css') ?: time() ?>">

    <main class="contact-page">

        <!-- ====== HERO ====== -->
        <section class="contact-hero">
            <div class="container">
                <?php if ($c['contact_eyebrow'] !== ''): ?>
                    <p class="contact-hero__eyebrow"><?= htmlspecialchars($c['contact_eyebrow']) ?></p>
                <?php endif; ?>
                <h1 class="contact-hero__title"><?= htmlspecialchars($c['contact_title']) ?></h1>
                <?php if ($c['contact_intro'] !== ''): ?>
                    <p class="contact-hero__intro"><?= htmlspecialchars($c['contact_intro']) ?></p>
                <?php endif; ?>
            </div>
        </section>

        <?php if ($okFlash): ?>
            <div class="container">
                <div class="contact-alert contact-alert--success">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                    <div>
                        <strong><?= htmlspecialchars($c['contact_form_success_title']) ?></strong>
                        <p><?= htmlspecialchars($c['contact_form_success_body']) ?></p>
                    </div>
                </div>
            </div>
        <?php endif; ?>

        <?php if ($errFlash): ?>
            <div class="container">
                <div class="contact-alert contact-alert--error">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                    <div><strong>No pudimos enviar tu mensaje</strong><p><?= htmlspecialchars($errFlash) ?></p></div>
                </div>
            </div>
        <?php endif; ?>

        <?php
        // ====== MÉTODOS DE CONTACTO (cards) ======
        $methods = [];

        $waUrl = whatsappLink((string) $b['business_whatsapp'], (string) $b['business_whatsapp_text']);
        if ($waUrl !== '') {
            $methods[] = [
                'icon'  => '<svg viewBox="0 0 24 24" width="28" height="28" fill="currentColor" aria-hidden="true"><path d="M20 3.5A11 11 0 0 0 3.6 18.2L2 22l3.9-1.6A11 11 0 1 0 20 3.5zm-8 18a9 9 0 0 1-4.6-1.3l-.3-.2-2.3 1 .8-2.3-.2-.3a9 9 0 1 1 6.6 3zm5-7c-.3-.1-1.7-.8-1.9-.9-.3-.1-.4-.1-.6.1-.2.2-.7.9-.9 1.1-.2.2-.3.2-.6.1-.3-.1-1.2-.4-2.3-1.4a8.6 8.6 0 0 1-1.5-2c-.2-.3 0-.4.1-.6.1-.1.3-.4.4-.5.1-.2.2-.3.3-.5 0-.2 0-.4 0-.5 0-.1-.6-1.4-.8-2-.2-.5-.4-.4-.6-.4h-.5c-.2 0-.5.1-.7.3-.3.3-.9.9-.9 2.2 0 1.3.9 2.6 1 2.8.1.2 1.8 2.8 4.5 3.9a15 15 0 0 0 1.6.6c.7.2 1.3.2 1.7.1.5-.1 1.7-.7 2-1.4.2-.6.2-1.2.2-1.4-.1-.1-.3-.2-.6-.3z"/></svg>',
                'label' => 'WhatsApp',
                'value' => '+' . whatsappDigits((string) $b['business_whatsapp']),
                'hint'  => 'Lo más rápido — atendemos en horario hábil',
                'href'  => $waUrl,
                'cta'   => 'Abrir chat',
                'tone'  => 'wa',
                'attrs' => 'target="_blank" rel="noopener"',
            ];
        }
        if ($b['business_email'] !== '') {
            $methods[] = [
                'icon'  => '<svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22 6 12 13 2 6"/></svg>',
                'label' => 'Email',
                'value' => (string) $b['business_email'],
                'hint'  => 'Respondemos dentro del día hábil',
                'href'  => 'mailto:' . $b['business_email'],
                'cta'   => 'Enviar correo',
                'tone'  => 'mail',
                'attrs' => '',
            ];
        }
        if ($b['business_phone'] !== '') {
            $telHref = preg_replace('/\s+/', '', (string) $b['business_phone']);
            $methods[] = [
                'icon'  => '<svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6A19.79 19.79 0 0 1 2.12 4.18 2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7 2 2 0 0 1 1.72 2.03z"/></svg>',
                'label' => 'Teléfono',
                'value' => (string) $b['business_phone'],
                'hint'  => $b['business_hours'] !== '' ? (string) $b['business_hours'] : 'Llamanos en horario comercial',
                'href'  => 'tel:' . $telHref,
                'cta'   => 'Llamar ahora',
                'tone'  => 'phone',
                'attrs' => '',
            ];
        }
        if ($b['business_address'] !== '' || $b['business_maps_url'] !== '') {
            $addrLine = trim(
                (string) $b['business_address']
                . ($b['business_city'] !== '' ? ', ' . $b['business_city'] : '')
                . ($b['business_region'] !== '' ? ', ' . $b['business_region'] : ''),
                ", \t\n"
            );
            $methods[] = [
                'icon'  => '<svg viewBox="0 0 24 24" width="28" height="28" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>',
                'label' => 'Visitanos',
                'value' => $addrLine !== '' ? $addrLine : 'Ver ubicación en el mapa',
                'hint'  => $b['business_hours'] !== '' ? (string) $b['business_hours'] : 'Coordiná tu visita por WhatsApp',
                'href'  => $b['business_maps_url'] !== '' ? (string) $b['business_maps_url'] : '#contact-map',
                'cta'   => 'Cómo llegar',
                'tone'  => 'map',
                'attrs' => $b['business_maps_url'] !== '' ? 'target="_blank" rel="noopener"' : '',
            ];
        }
        ?>

        <?php if ($c['contact_show_methods'] === '1' && $methods): ?>
            <section class="contact-methods">
                <div class="container">
                    <?php if ($c['contact_methods_title'] !== ''): ?>
                        <h2 class="contact-section-title"><?= htmlspecialchars($c['contact_methods_title']) ?></h2>
                    <?php endif; ?>
                    <div class="contact-methods__grid">
                        <?php foreach ($methods as $m): ?>
                            <a href="<?= htmlspecialchars($m['href']) ?>" <?= $m['attrs'] ?> class="contact-method contact-method--<?= htmlspecialchars($m['tone']) ?>">
                                <span class="contact-method__icon"><?= $m['icon'] ?></span>
                                <span class="contact-method__label"><?= htmlspecialchars($m['label']) ?></span>
                                <span class="contact-method__value"><?= htmlspecialchars($m['value']) ?></span>
                                <?php if (!empty($m['hint'])): ?>
                                    <span class="contact-method__hint"><?= htmlspecialchars($m['hint']) ?></span>
                                <?php endif; ?>
                                <span class="contact-method__cta">
                                    <?= htmlspecialchars($m['cta']) ?>
                                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                                </span>
                            </a>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <!-- ====== FORM + SIDEBAR INFO ====== -->
        <?php if ($c['contact_show_form'] === '1'): ?>
            <section class="contact-form-section" id="contact-form">
                <div class="container">
                    <div class="contact-form-section__grid">

                        <div class="contact-form-card">
                            <?php if ($c['contact_form_title'] !== ''): ?>
                                <h2 class="contact-form-card__title"><?= htmlspecialchars($c['contact_form_title']) ?></h2>
                            <?php endif; ?>
                            <?php if ($c['contact_form_intro'] !== ''): ?>
                                <p class="contact-form-card__intro"><?= htmlspecialchars($c['contact_form_intro']) ?></p>
                            <?php endif; ?>

                            <form method="post" action="/" class="contact-form">
                                <input type="hidden" name="action" value="submit_lead">
                                <input type="hidden" name="csrf" value="<?= csrfToken() ?>">
                                <input type="hidden" name="form_started" value="<?= time() ?>">
                                <input type="hidden" name="source" value="contact_page">
                                <input type="text" name="website" value="" style="display:none" tabindex="-1" autocomplete="off">

                                <div class="contact-form__row">
                                    <label class="contact-form__field">
                                        <span class="contact-form__label">Nombre <em>*</em></span>
                                        <input type="text" name="name" required placeholder="Tu nombre">
                                    </label>
                                    <label class="contact-form__field">
                                        <span class="contact-form__label">Email <em>*</em></span>
                                        <input type="email" name="email" required placeholder="tu@email.com">
                                    </label>
                                </div>
                                <label class="contact-form__field">
                                    <span class="contact-form__label">Teléfono <span class="contact-form__optional">(opcional)</span></span>
                                    <input type="text" name="phone" placeholder="+56 9 1234 5678">
                                </label>
                                <label class="contact-form__field">
                                    <span class="contact-form__label">Mensaje <em>*</em></span>
                                    <textarea name="message" rows="5" required placeholder="Contanos en qué podemos ayudarte"></textarea>
                                </label>
                                <div class="contact-form__submit">
                                    <button type="submit" class="btn contact-form__btn">
                                        Enviar mensaje
                                        <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
                                    </button>
                                    <span class="contact-form__hint">No compartimos tus datos con terceros.</span>
                                </div>
                            </form>
                        </div>

                        <aside class="contact-info">
                            <h3 class="contact-info__title">Información de contacto</h3>

                            <?php if ($b['business_legal_name'] !== '' || $b['business_tagline'] !== ''): ?>
                                <div class="contact-info__brand">
                                    <?php if ($b['business_legal_name'] !== ''): ?>
                                        <strong><?= htmlspecialchars($b['business_legal_name']) ?></strong>
                                    <?php endif; ?>
                                    <?php if ($b['business_tagline'] !== ''): ?>
                                        <span><?= htmlspecialchars($b['business_tagline']) ?></span>
                                    <?php endif; ?>
                                </div>
                            <?php endif; ?>

                            <ul class="contact-info__list">
                                <?php if ($b['business_email'] !== ''): ?>
                                    <li>
                                        <span class="contact-info__ico"><svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22 6 12 13 2 6"/></svg></span>
                                        <div><span class="contact-info__lbl">Email</span><a href="mailto:<?= htmlspecialchars($b['business_email']) ?>"><?= htmlspecialchars($b['business_email']) ?></a></div>
                                    </li>
                                <?php endif; ?>
                                <?php if ($b['business_phone'] !== ''): ?>
                                    <li>
                                        <span class="contact-info__ico"><svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6A19.79 19.79 0 0 1 2.12 4.18 2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7 2 2 0 0 1 1.72 2.03z"/></svg></span>
                                        <div><span class="contact-info__lbl">Teléfono</span><a href="tel:<?= htmlspecialchars(preg_replace('/\s+/', '', (string) $b['business_phone'])) ?>"><?= htmlspecialchars($b['business_phone']) ?></a></div>
                                    </li>
                                <?php endif; ?>
                                <?php if ($waUrl !== ''): ?>
                                    <li>
                                        <span class="contact-info__ico"><svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" aria-hidden="true"><path d="M20 3.5A11 11 0 0 0 3.6 18.2L2 22l3.9-1.6A11 11 0 1 0 20 3.5z"/></svg></span>
                                        <div><span class="contact-info__lbl">WhatsApp</span><a href="<?= htmlspecialchars($waUrl) ?>" target="_blank" rel="noopener">+<?= htmlspecialchars(whatsappDigits((string) $b['business_whatsapp'])) ?></a></div>
                                    </li>
                                <?php endif; ?>
                                <?php if ($b['business_address'] !== ''): ?>
                                    <li>
                                        <span class="contact-info__ico"><svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg></span>
                                        <div>
                                            <span class="contact-info__lbl">Dirección</span>
                                            <span><?= htmlspecialchars((string) $b['business_address']) ?></span>
                                            <?php if ($b['business_city'] !== '' || $b['business_region'] !== ''): ?>
                                                <span class="contact-info__sub"><?= htmlspecialchars(trim((string) $b['business_city'] . ($b['business_region'] !== '' ? ', ' . $b['business_region'] : ''), ', ')) ?></span>
                                            <?php endif; ?>
                                        </div>
                                    </li>
                                <?php endif; ?>
                                <?php if ($b['business_hours'] !== ''): ?>
                                    <li>
                                        <span class="contact-info__ico"><svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg></span>
                                        <div><span class="contact-info__lbl">Horarios</span><span><?= htmlspecialchars((string) $b['business_hours']) ?></span></div>
                                    </li>
                                <?php endif; ?>
                            </ul>

                            <?php if ($socials): ?>
                                <div class="contact-info__socials">
                                    <span class="contact-info__lbl">Seguinos</span>
                                    <div class="contact-info__socials-row">
                                        <?php foreach ($socials as $key => $s): ?>
                                            <a href="<?= htmlspecialchars($s['url']) ?>" target="_blank" rel="noopener" aria-label="<?= htmlspecialchars($s['label']) ?>" title="<?= htmlspecialchars($s['label']) ?>">
                                                <?= contactSocialIcon($key) ?>
                                            </a>
                                        <?php endforeach; ?>
                                    </div>
                                </div>
                            <?php endif; ?>
                        </aside>

                    </div>
                </div>
            </section>
        <?php endif; ?>

        <!-- ====== MAPA ====== -->
        <?php if ($c['contact_show_map'] === '1' && $c['contact_map_embed'] !== ''): ?>
            <section class="contact-map" id="contact-map">
                <div class="container">
                    <?php if ($c['contact_map_title'] !== ''): ?>
                        <h2 class="contact-section-title"><?= htmlspecialchars($c['contact_map_title']) ?></h2>
                    <?php endif; ?>
                    <div class="contact-map__frame">
                        <iframe
                            src="<?= htmlspecialchars($c['contact_map_embed']) ?>"
                            style="border:0;width:100%;height:100%;"
                            allowfullscreen=""
                            loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade"
                            title="Mapa de ubicación"></iframe>
                    </div>
                </div>
            </section>
        <?php endif; ?>

        <!-- ====== SUCURSALES ====== -->
        <?php if ($c['contact_show_branches'] === '1' && $branches): ?>
            <section class="contact-branches">
                <div class="container">
                    <?php if ($c['contact_branches_title'] !== ''): ?>
                        <h2 class="contact-section-title"><?= htmlspecialchars($c['contact_branches_title']) ?></h2>
                    <?php endif; ?>
                    <div class="contact-branches__grid">
                        <?php foreach ($branches as $br): ?>
                            <article class="contact-branch">
                                <h3 class="contact-branch__name"><?= htmlspecialchars((string) $br['name']) ?></h3>
                                <?php if (!empty($br['address'])): ?>
                                    <p class="contact-branch__addr"><?= htmlspecialchars((string) $br['address']) ?><?php
                                        $sub = trim((string) ($br['city'] ?? '') . ((!empty($br['region'])) ? ', ' . $br['region'] : ''), ', ');
                                        if ($sub !== '') echo '<br><span>' . htmlspecialchars($sub) . '</span>';
                                    ?></p>
                                <?php endif; ?>
                                <ul class="contact-branch__list">
                                    <?php if (!empty($br['phone'])): ?>
                                        <li><a href="tel:<?= htmlspecialchars(preg_replace('/\s+/', '', (string) $br['phone'])) ?>">📞 <?= htmlspecialchars((string) $br['phone']) ?></a></li>
                                    <?php endif; ?>
                                    <?php if (!empty($br['email'])): ?>
                                        <li><a href="mailto:<?= htmlspecialchars((string) $br['email']) ?>">✉️ <?= htmlspecialchars((string) $br['email']) ?></a></li>
                                    <?php endif; ?>
                                    <?php if (!empty($br['hours'])): ?>
                                        <li>🕒 <?= htmlspecialchars((string) $br['hours']) ?></li>
                                    <?php endif; ?>
                                </ul>
                                <?php if (!empty($br['maps_url'])): ?>
                                    <a class="contact-branch__map" href="<?= htmlspecialchars((string) $br['maps_url']) ?>" target="_blank" rel="noopener">Cómo llegar →</a>
                                <?php endif; ?>
                            </article>
                        <?php endforeach; ?>
                    </div>
                </div>
            </section>
        <?php endif; ?>

    </main>
    <?php
    layoutEnd();
    exit;
}

/** SVGs de redes para la sidebar del form. Mantiene el set de site_header. */
function contactSocialIcon(string $key): string {
    return [
        'social_facebook'  => '<svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" aria-hidden="true"><path d="M22 12a10 10 0 1 0-11.6 9.9v-7H8v-2.9h2.4V9.8c0-2.4 1.4-3.7 3.6-3.7 1 0 2.1.2 2.1.2v2.3h-1.2c-1.2 0-1.5.7-1.5 1.5V12h2.6l-.4 2.9h-2.2v7A10 10 0 0 0 22 12z"/></svg>',
        'social_instagram' => '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="17.5" cy="6.5" r="1" fill="currentColor"/></svg>',
        'social_linkedin'  => '<svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" aria-hidden="true"><path d="M4.98 3.5a2.5 2.5 0 1 1 0 5 2.5 2.5 0 0 1 0-5zM3 9h4v12H3zM9 9h3.8v1.7h.1c.5-.9 1.8-1.9 3.7-1.9 4 0 4.7 2.6 4.7 6V21h-4v-5.4c0-1.3 0-3-1.8-3s-2.1 1.4-2.1 2.9V21H9z"/></svg>',
        'social_youtube'   => '<svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" aria-hidden="true"><path d="M23 7.2s-.2-1.6-.9-2.3c-.8-.9-1.8-.9-2.2-1C16.7 3.6 12 3.6 12 3.6s-4.7 0-7.9.3c-.4.1-1.4.1-2.2 1C1.2 5.6 1 7.2 1 7.2S.8 9 .8 10.9v1.8C.8 14.5 1 16.3 1 16.3s.2 1.6.9 2.3c.8.9 1.9.9 2.4 1 1.7.2 7.7.3 7.7.3s4.7 0 7.9-.3c.4-.1 1.4-.1 2.2-1 .7-.7.9-2.3.9-2.3s.2-1.8.2-3.6v-1.8c0-1.9-.2-3.7-.2-3.7zM9.7 14.6V8l6.2 3.3-6.2 3.3z"/></svg>',
        'social_tiktok'    => '<svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" aria-hidden="true"><path d="M19.5 8.6a6.7 6.7 0 0 1-4-1.3v7.4a5.7 5.7 0 1 1-5.7-5.7c.3 0 .6 0 .9.1v3a2.8 2.8 0 1 0 2 2.7V2h2.9a4 4 0 0 0 4 4v2.6z"/></svg>',
        'social_x'         => '<svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" aria-hidden="true"><path d="M18.9 2H22l-7.4 8.5L23 22h-6.8l-5.3-7-6.1 7H1.6l8-9.1L1 2h6.9l4.8 6.4L18.9 2zm-2.4 18h1.9L7.7 4H5.6l10.9 16z"/></svg>',
    ][$key] ?? '';
}
