<?php
/** Bloque "Galería": grilla de fotos con epígrafe opcional. */
if (empty($b['items'])) return;
$hTag = $isFirst ? 'h1' : 'h2';
?>
<section class="blk blk-gallery">
    <div class="container">
        <?php if ($b['title'] !== ''): ?>
            <header class="blk-head">
                <<?= $hTag ?> class="blk-title"><?= blkH($b['title']) ?></<?= $hTag ?>>
            </header>
        <?php endif; ?>
        <div class="blk-gallery__grid" data-cols="<?= blkH($b['cols']) ?>">
            <?php foreach ($b['items'] as $it): ?>
                <figure class="blk-gallery__item">
                    <img src="<?= blkH($it['image']) ?>" alt="<?= blkH($it['caption']) ?>" loading="lazy">
                    <?php if ($it['caption'] !== ''): ?>
                        <figcaption><?= blkH($it['caption']) ?></figcaption>
                    <?php endif; ?>
                </figure>
            <?php endforeach; ?>
        </div>
    </div>
</section>
