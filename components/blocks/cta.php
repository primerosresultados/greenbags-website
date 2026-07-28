<?php
/** Bloque "Llamado a la acción": banda de cierre con uno o dos botones. */
if ($b['title'] === '') return;
$hTag = $isFirst ? 'h1' : 'h2';
?>
<section class="blk blk-cta blk-cta--<?= blkH($b['style']) ?>">
    <div class="container blk-cta__inner">
        <div class="blk-cta__copy">
            <<?= $hTag ?> class="blk-cta__title"><?= blkH($b['title']) ?></<?= $hTag ?>>
            <?php if ($b['body'] !== ''): ?>
                <p class="blk-cta__body"><?= nl2br(blkH($b['body'])) ?></p>
            <?php endif; ?>
        </div>
        <?php if (($b['cta_label'] !== '' && $b['cta_url'] !== '') || ($b['cta2_label'] !== '' && $b['cta2_url'] !== '')): ?>
            <div class="blk-cta__actions">
                <?php if ($b['cta_label'] !== '' && $b['cta_url'] !== ''): ?>
                    <a class="btn blk-cta__btn" href="<?= blkH($b['cta_url']) ?>"><?= blkH($b['cta_label']) ?></a>
                <?php endif; ?>
                <?php if ($b['cta2_label'] !== '' && $b['cta2_url'] !== ''): ?>
                    <a class="btn btn--ghost blk-cta__btn" href="<?= blkH($b['cta2_url']) ?>"><?= blkH($b['cta2_label']) ?></a>
                <?php endif; ?>
            </div>
        <?php endif; ?>
    </div>
</section>
