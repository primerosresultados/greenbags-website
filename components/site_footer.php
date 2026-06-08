<?php
/** Footer público minimalista: logo (en blanco) + redes sociales. */
$siteName   = (string) getSetting('site_name', 'Mi Sitio');
$logoPath   = (string) getSetting('logo_image', '');
$logoExists = $logoPath !== '' && @file_exists(__DIR__ . '/..' . $logoPath);
$socials    = socialLinks();

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
?>
<footer class="site-footer">
    <div class="site-footer__inner">
        <a href="/" class="site-footer__brand" aria-label="<?= htmlspecialchars($siteName) ?>">
            <?php if ($logoExists): ?>
                <img src="<?= htmlspecialchars($logoPath) ?>" alt="<?= htmlspecialchars($siteName) ?>">
            <?php else: ?>
                <span class="site-footer__brand-text"><?= htmlspecialchars($siteName) ?></span>
            <?php endif; ?>
        </a>

        <?php if ($socials): ?>
            <div class="site-footer__socials">
                <?php foreach ($socials as $key => $s): ?>
                    <a href="<?= htmlspecialchars($s['url']) ?>" target="_blank" rel="noopener" aria-label="<?= htmlspecialchars($s['label']) ?>">
                        <?= $socialIcon($key) ?: htmlspecialchars($s['label']) ?>
                    </a>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
</footer>
