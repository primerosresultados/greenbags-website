<?php
/**
 * Footer público:
 *   1. Brand zone   — logo + tagline (bajada blanca).
 *   2. Contact zone — teléfono, email, dirección y horario.
 *   3. Social zone  — íconos de redes + copyright.
 *
 * Cada bloque se renderiza sólo si hay datos. Si el sitio recién se instaló y
 * todo está vacío, queda únicamente el logo + copyright (degrada limpio).
 */
$siteName   = (string) getSetting('site_name', 'Mi Sitio');
$logoPath   = (string) getSetting('logo_image', '');
$logoExists = $logoPath !== '' && @file_exists(__DIR__ . '/..' . $logoPath);
$tagline    = trim((string) getSetting('business_tagline', ''));

// El cliente pidió sacar del footer el teléfono y el email genéricos
// (+56 2 2234 5678 / contacto@greenbags.cl): quedan redundantes con los
// "Contactos directos" de más abajo. Se ocultan sólo acá; la página de
// contacto y el resto del sitio los siguen usando desde business_*.
$phone      = '';
$email      = '';
$address    = trim((string) getSetting('business_address', ''));
$city       = trim((string) getSetting('business_city', ''));
$region     = trim((string) getSetting('business_region', ''));
$country    = trim((string) getSetting('business_country', ''));
$hours      = trim((string) getSetting('business_hours', ''));
$mapsUrl    = trim((string) getSetting('business_maps_url', ''));

// Compone la dirección como string legible. Si sólo hay ciudad, la usa sola.
$addressParts = array_filter([$address, $city, $region, $country]);
$addressFull  = implode(', ', $addressParts);

$socials    = socialLinks();

// Contactos directos (personas) + nota de retiro en bodega.
$people = [];
for ($i = 1; $i <= 2; $i++) {
    $name = trim((string) getSetting("contact_person_{$i}_name", ''));
    if ($name === '') continue;
    $people[] = [
        'name'  => $name,
        'role'  => trim((string) getSetting("contact_person_{$i}_role", '')),
        'phone' => trim((string) getSetting("contact_person_{$i}_phone", '')),
        'email' => trim((string) getSetting("contact_person_{$i}_email", '')),
    ];
}
$pickupNote = trim((string) getSetting('business_pickup_note', ''));

$socialIcon = function (string $key): string {
    return [
        'social_facebook'  => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M22 12a10 10 0 1 0-11.6 9.9v-7H8v-2.9h2.4V9.8c0-2.4 1.4-3.7 3.6-3.7 1 0 2.1.2 2.1.2v2.3h-1.2c-1.2 0-1.5.7-1.5 1.5V12h2.6l-.4 2.9h-2.2v7A10 10 0 0 0 22 12z"/></svg>',
        'social_instagram' => '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="17.5" cy="6.5" r="1" fill="currentColor"/></svg>',
        'social_linkedin'  => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M4.98 3.5a2.5 2.5 0 1 1 0 5 2.5 2.5 0 0 1 0-5zM3 9h4v12H3zM9 9h3.8v1.7h.1c.5-.9 1.8-1.9 3.7-1.9 4 0 4.7 2.6 4.7 6V21h-4v-5.4c0-1.3 0-3-1.8-3s-2.1 1.4-2.1 2.9V21H9z"/></svg>',
        'social_youtube'   => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M23 7.2s-.2-1.6-.9-2.3c-.8-.9-1.8-.9-2.2-1C16.7 3.6 12 3.6 12 3.6s-4.7 0-7.9.3c-.4.1-1.4.1-2.2 1C1.2 5.6 1 7.2 1 7.2S.8 9 .8 10.9v1.8C.8 14.5 1 16.3 1 16.3s.2 1.6.9 2.3c.8.9 1.9.9 2.4 1 1.7.2 7.7.3 7.7.3s4.7 0 7.9-.3c.4-.1 1.4-.1 2.2-1 .7-.7.9-2.3.9-2.3s.2-1.8.2-3.6v-1.8c0-1.9-.2-3.7-.2-3.7zM9.7 14.6V8l6.2 3.3-6.2 3.3z"/></svg>',
        'social_tiktok'    => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M19.5 8.6a6.7 6.7 0 0 1-4-1.3v7.4a5.7 5.7 0 1 1-5.7-5.7c.3 0 .6 0 .9.1v3a2.8 2.8 0 1 0 2 2.7V2h2.9a4 4 0 0 0 4 4v2.6z"/></svg>',
        'social_x'         => '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M18.9 2H22l-7.4 8.5L23 22h-6.8l-5.3-7-6.1 7H1.6l8-9.1L1 2h6.9l4.8 6.4L18.9 2zm-2.4 18h1.9L7.7 4H5.6l10.9 16z"/></svg>',
    ][$key] ?? '';
};

$hasContact = $phone || $email || $addressFull || $hours || $pickupNote;
?>
<footer class="site-footer">
    <div class="site-footer__inner">

        <!-- Tres columnas: marca · contactos de vendedores · contacto general.
             Los vendedores van antes que el contacto general (clientes). -->
        <div class="site-footer__columns">

            <!-- ── Columna 1: Brand ── -->
            <div class="site-footer__col site-footer__brand-block">
                <a href="/" class="site-footer__brand" aria-label="<?= htmlspecialchars($siteName) ?>">
                    <?php if ($logoExists): ?>
                        <img src="<?= htmlspecialchars($logoPath) ?>" alt="<?= htmlspecialchars($siteName) ?>">
                    <?php else: ?>
                        <span class="site-footer__brand-text"><?= htmlspecialchars($siteName) ?></span>
                    <?php endif; ?>
                </a>
                <?php if ($tagline !== ''): ?>
                    <p class="site-footer__tagline"><?= htmlspecialchars($tagline) ?></p>
                <?php endif; ?>
            </div>

            <?php foreach ($people as $p): ?>
            <!-- ── Columna: contacto de vendedor (una por vendedor) ── -->
            <div class="site-footer__col site-footer__people">
                <h3 class="site-footer__col-title"><?= htmlspecialchars($p['role'] !== '' ? $p['role'] : 'Contacto directo') ?></h3>
                <div class="site-footer__person">
                    <strong class="site-footer__person-name"><?= htmlspecialchars($p['name']) ?></strong>
                    <?php if ($p['phone'] !== ''): ?>
                        <a href="tel:<?= htmlspecialchars(preg_replace('/\s+/', '', $p['phone'])) ?>"><?= htmlspecialchars($p['phone']) ?></a>
                    <?php endif; ?>
                    <?php if ($p['email'] !== ''): ?>
                        <a href="mailto:<?= htmlspecialchars($p['email']) ?>"><?= htmlspecialchars($p['email']) ?></a>
                    <?php endif; ?>
                </div>
            </div>
            <?php endforeach; ?>

            <?php if ($hasContact): ?>
            <!-- ── Columna: Contacto general ── -->
            <div class="site-footer__col site-footer__contact-col">
                <h3 class="site-footer__col-title">Contacto</h3>
                <ul class="site-footer__contact">
                    <?php if ($phone): ?>
                        <li class="site-footer__contact-item">
                            <span class="site-footer__contact-ico">
                                <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6A19.79 19.79 0 0 1 2.12 4.18 2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7 2 2 0 0 1 1.72 2.03z"/></svg>
                            </span>
                            <a href="tel:<?= htmlspecialchars(preg_replace('/\s+/', '', $phone)) ?>"><?= htmlspecialchars($phone) ?></a>
                        </li>
                    <?php endif; ?>
                    <?php if ($email): ?>
                        <li class="site-footer__contact-item">
                            <span class="site-footer__contact-ico">
                                <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                            </span>
                            <a href="mailto:<?= htmlspecialchars($email) ?>"><?= htmlspecialchars($email) ?></a>
                        </li>
                    <?php endif; ?>
                    <?php if ($addressFull !== ''): ?>
                        <li class="site-footer__contact-item">
                            <span class="site-footer__contact-ico">
                                <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
                            </span>
                            <?php if ($mapsUrl): ?>
                                <a href="<?= htmlspecialchars($mapsUrl) ?>" target="_blank" rel="noopener"><?= htmlspecialchars($addressFull) ?></a>
                            <?php else: ?>
                                <span><?= htmlspecialchars($addressFull) ?></span>
                            <?php endif; ?>
                        </li>
                    <?php endif; ?>
                    <?php if ($hours): ?>
                        <li class="site-footer__contact-item">
                            <span class="site-footer__contact-ico">
                                <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                            </span>
                            <span><?= htmlspecialchars($hours) ?></span>
                        </li>
                    <?php endif; ?>
                </ul>
                <?php if ($pickupNote !== ''): ?>
                    <p class="site-footer__pickup">
                        <svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M3 9l1-5h16l1 5"/><path d="M4 9v11a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1V9"/><path d="M9 13h6"/></svg>
                        <span><?= htmlspecialchars($pickupNote) ?></span>
                    </p>
                <?php endif; ?>
            </div>
            <?php endif; ?>

        </div>

        <!-- ── Social zone + copyright ── -->
        <div class="site-footer__bottom">
            <?php if ($socials): ?>
                <div class="site-footer__socials">
                    <?php foreach ($socials as $key => $s): ?>
                        <a href="<?= htmlspecialchars($s['url']) ?>" target="_blank" rel="noopener" aria-label="<?= htmlspecialchars($s['label']) ?>">
                            <?= $socialIcon($key) ?: htmlspecialchars($s['label']) ?>
                        </a>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>
            <p class="site-footer__copyright">© <?= date('Y') ?> <?= htmlspecialchars($siteName) ?>. Todos los derechos reservados.</p>
        </div>

    </div>
</footer>
