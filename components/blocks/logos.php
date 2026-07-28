<?php
/** Bloque "Logos": franja de clientes, certificaciones o marcas. */
if (empty($b['items'])) return;
$hTag = $isFirst ? 'h1' : 'h2';
?>
<section class="blk blk-logos">
    <div class="container">
        <?php if ($b['title'] !== ''): ?>
            <header class="blk-head">
                <<?= $hTag ?> class="blk-title"><?= blkH($b['title']) ?></<?= $hTag ?>>
            </header>
        <?php endif; ?>
        <ul class="blk-logos__grid">
            <?php foreach ($b['items'] as $it): ?>
                <li class="blk-logo">
                    <?php if ($it['url'] !== ''): ?><a href="<?= blkH($it['url']) ?>" target="_blank" rel="noopener"><?php endif; ?>
                        <img src="<?= blkH($it['image']) ?>" alt="<?= blkH($it['alt']) ?>" loading="lazy">
                    <?php if ($it['url'] !== ''): ?></a><?php endif; ?>
                </li>
            <?php endforeach; ?>
        </ul>
    </div>
</section>
