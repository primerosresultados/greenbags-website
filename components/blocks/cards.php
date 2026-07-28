<?php
/** Bloque "Tarjetas": grilla con ícono, título y texto. */
if (empty($b['items'])) return;
$hTag = $isFirst ? 'h1' : 'h2';
?>
<section class="blk blk-cards">
    <div class="container">
        <?php if ($b['kicker'] !== '' || $b['title'] !== '' || $b['intro'] !== ''): ?>
            <header class="blk-head">
                <?php if ($b['kicker'] !== ''): ?>
                    <p class="blk-kicker"><?= blkH($b['kicker']) ?></p>
                <?php endif; ?>
                <?php if ($b['title'] !== ''): ?>
                    <<?= $hTag ?> class="blk-title"><?= blkH($b['title']) ?></<?= $hTag ?>>
                <?php endif; ?>
                <?php if ($b['intro'] !== ''): ?>
                    <p class="blk-head__intro"><?= nl2br(blkH($b['intro'])) ?></p>
                <?php endif; ?>
            </header>
        <?php endif; ?>

        <div class="blk-cards__grid" data-cols="<?= blkH($b['cols']) ?>">
            <?php foreach ($b['items'] as $it): ?>
                <article class="blk-card">
                    <span class="blk-card__ico" aria-hidden="true"><?= blockIcon($it['icon']) ?></span>
                    <h3 class="blk-card__title"><?= blkH($it['title']) ?></h3>
                    <?php if ($it['body'] !== ''): ?>
                        <p class="blk-card__body"><?= nl2br(blkH($it['body'])) ?></p>
                    <?php endif; ?>
                </article>
            <?php endforeach; ?>
        </div>
    </div>
</section>
