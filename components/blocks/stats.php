<?php
/** Bloque "Números": cifras grandes con su descripción. */
if (empty($b['items'])) return;
$hTag = $isFirst ? 'h1' : 'h2';
?>
<section class="blk blk-stats">
    <div class="container">
        <?php if ($b['title'] !== ''): ?>
            <header class="blk-head">
                <<?= $hTag ?> class="blk-title"><?= blkH($b['title']) ?></<?= $hTag ?>>
            </header>
        <?php endif; ?>
        <dl class="blk-stats__grid">
            <?php foreach ($b['items'] as $it): ?>
                <div class="blk-stat">
                    <dt class="blk-stat__value"><?= blkH($it['value']) ?></dt>
                    <dd class="blk-stat__label"><?= blkH($it['label']) ?></dd>
                </div>
            <?php endforeach; ?>
        </dl>
    </div>
</section>
