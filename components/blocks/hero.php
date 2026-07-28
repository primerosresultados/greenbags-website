<?php
/**
 * Bloque "Portada (hero)". Recibe $b (datos normalizados) y $isFirst.
 * Si es el primer bloque de la página imprime el <h1> (el router omite el suyo).
 */
$hasMedia = $b['image'] !== '';
$hasBadge = $b['badge_num'] !== '' || $b['badge_text'] !== '';
$hTag     = $isFirst ? 'h1' : 'h2';
?>
<section class="blk blk-hero<?= $hasMedia ? ' blk-hero--media' : '' ?>">
    <div class="container blk-hero__panel">
        <div class="blk-hero__copy">
            <?php if ($b['kicker'] !== ''): ?>
                <p class="blk-kicker"><?= blkH($b['kicker']) ?></p>
            <?php endif; ?>
            <<?= $hTag ?> class="blk-hero__title"><?= blkH($b['title']) ?></<?= $hTag ?>>
            <?php if ($b['body'] !== ''): ?>
                <div class="blk-hero__body blk-rich"><?= $b['body'] ?></div>
            <?php endif; ?>
            <?php if (($b['cta_label'] !== '' && $b['cta_url'] !== '') || ($b['cta2_label'] !== '' && $b['cta2_url'] !== '')): ?>
                <div class="blk-hero__actions">
                    <?php if ($b['cta_label'] !== '' && $b['cta_url'] !== ''): ?>
                        <a class="btn blk-hero__cta" href="<?= blkH($b['cta_url']) ?>">
                            <span><?= blkH($b['cta_label']) ?></span>
                            <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                        </a>
                    <?php endif; ?>
                    <?php if ($b['cta2_label'] !== '' && $b['cta2_url'] !== ''): ?>
                        <a class="blk-hero__cta2" href="<?= blkH($b['cta2_url']) ?>"><?= blkH($b['cta2_label']) ?></a>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>

        <?php if ($hasMedia): ?>
            <div class="blk-hero__media">
                <img src="<?= blkH($b['image']) ?>" alt="" loading="eager">
                <span class="blk-hero__frame" aria-hidden="true"></span>
                <?php if ($hasBadge): ?>
                    <div class="blk-hero__badge" aria-hidden="true">
                        <span class="blk-hero__badge-num"><?= blkH($b['badge_num']) ?></span>
                        <span class="blk-hero__badge-txt"><?= blkH($b['badge_text']) ?></span>
                    </div>
                <?php endif; ?>
            </div>
        <?php endif; ?>
    </div>
</section>
