<?php
// Feed de productos (Google Shopping / catálogo de Meta).
// Accesible como /feed.xml (ver regla en .htaccess) o /feed.xml.php directo.
require __DIR__ . '/lib/bootstrap.php';
require __DIR__ . '/lib/feed.php';

header('Content-Type: application/xml; charset=utf-8');
feedOutputGoogleRss();
