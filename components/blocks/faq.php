<?php
/**
 * Bloque "Preguntas frecuentes". Usa <details>: se abre y cierra sin JS.
 */
if (empty($b['items'])) return;
$hTag = $isFirst ? 'h1' : 'h2';
?>
<section class="blk blk-faq">
    <div class="container"><div class="blk-faq__inner">
        <?php if ($b['title'] !== ''): ?>
            <header class="blk-head">
                <<?= $hTag ?> class="blk-title"><?= blkH($b['title']) ?></<?= $hTag ?>>
            </header>
        <?php endif; ?>
        <?php foreach ($b['items'] as $it): ?>
            <details class="blk-faq__item">
                <summary class="blk-faq__q">
                    <span><?= blkH($it['q']) ?></span>
                    <svg class="blk-faq__chev" viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="6 9 12 15 18 9"/></svg>
                </summary>
                <div class="blk-faq__a blk-rich"><?= $it['a'] ?></div>
            </details>
        <?php endforeach; ?>
    </div></div>
</section>
