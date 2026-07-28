<?php
/** Bloque "Texto": antetítulo + título + párrafos. */
$hTag = $isFirst ? 'h1' : 'h2';
?>
<section class="blk blk-text blk-text--<?= blkH($b['align']) ?> blk-text--<?= blkH($b['width']) ?>">
    <div class="container"><div class="blk-text__inner">
        <?php if ($b['kicker'] !== ''): ?>
            <p class="blk-kicker"><?= blkH($b['kicker']) ?></p>
        <?php endif; ?>
        <?php if ($b['title'] !== ''): ?>
            <<?= $hTag ?> class="blk-title"><?= blkH($b['title']) ?></<?= $hTag ?>>
        <?php endif; ?>
        <?php if ($b['body'] !== ''): ?>
            <div class="blk-rich"><?= $b['body'] ?></div>
        <?php endif; ?>
    </div></div>
</section>
