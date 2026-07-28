<?php
/** Bloque "Aviso destacado": recuadro con ícono para resaltar un dato. */
if ($b['title'] === '' && $b['body'] === '') return;
?>
<section class="blk blk-callout">
    <div class="container">
        <div class="blk-callout__box">
            <span class="blk-callout__ico" aria-hidden="true"><?= blockIcon($b['icon']) ?></span>
            <div class="blk-callout__txt">
                <?php if ($b['title'] !== ''): ?>
                    <strong class="blk-callout__title"><?= blkH($b['title']) ?></strong>
                <?php endif; ?>
                <?php if ($b['body'] !== ''): ?>
                    <div class="blk-rich"><?= $b['body'] ?></div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</section>
