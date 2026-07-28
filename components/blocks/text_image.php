<?php
/** Bloque "Texto + imagen": dos columnas, la foto a un lado u otro. */
$hTag = $isFirst ? 'h1' : 'h2';
?>
<section class="blk blk-ti blk-ti--<?= blkH($b['side']) ?><?= $b['image'] === '' ? ' blk-ti--nomedia' : '' ?>">
    <div class="container blk-ti__inner">
        <div class="blk-ti__copy">
            <?php if ($b['kicker'] !== ''): ?>
                <p class="blk-kicker"><?= blkH($b['kicker']) ?></p>
            <?php endif; ?>
            <?php if ($b['title'] !== ''): ?>
                <<?= $hTag ?> class="blk-title"><?= blkH($b['title']) ?></<?= $hTag ?>>
            <?php endif; ?>
            <?php if ($b['body'] !== ''): ?>
                <div class="blk-rich"><?= $b['body'] ?></div>
            <?php endif; ?>
            <?php if ($b['cta_label'] !== '' && $b['cta_url'] !== ''): ?>
                <a class="btn blk-ti__cta" href="<?= blkH($b['cta_url']) ?>">
                    <span><?= blkH($b['cta_label']) ?></span>
                    <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </a>
            <?php endif; ?>
        </div>
        <?php if ($b['image'] !== ''): ?>
            <div class="blk-ti__media">
                <img src="<?= blkH($b['image']) ?>" alt="" loading="lazy">
                <span class="blk-ti__frame" aria-hidden="true"></span>
            </div>
        <?php endif; ?>
    </div>
</section>
