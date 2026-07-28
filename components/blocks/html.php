<?php
/**
 * Bloque "HTML (avanzado)": se inserta tal cual lo escribió el admin.
 * Mismo criterio de confianza que pages.body (sólo lo edita un admin logueado).
 */
if (trim($b['code']) === '') return;
?>
<section class="blk blk-html">
    <div class="container"><?= $b['code'] ?></div>
</section>
