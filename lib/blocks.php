<?php

/**
 * Bloques de contenido para las páginas del CMS.
 *
 * Una página = una lista ordenada de bloques tipados. Cada tipo declara sus
 * campos acá (blockTypes()) y el admin genera el formulario solo, sin escribir
 * HTML por bloque. El markup del front vive en components/blocks/{type}.php y
 * los estilos en assets/css/blocks.css: quien edita nunca ve HTML ni CSS.
 *
 * Para agregar un tipo nuevo:
 *   1. Sumarlo al array de blockTypes() con sus campos.
 *   2. Crear components/blocks/{type}.php (recibe $b = datos ya normalizados).
 *   3. Estilarlo en assets/css/blocks.css con el prefijo .blk-{type}.
 *
 * Tipos de campo soportados por el editor:
 *   text · textarea · richtext · image · url · select · checkbox · icon · repeater
 */

/* ============================ Íconos ============================ */

/**
 * Set curado de íconos para los campos `icon`. Line-art 24x24 en el mismo
 * lenguaje que el resto del sitio (stroke currentColor, sin fill).
 * @return array<string,array{label:string,svg:string}>
 */
function blockIcons(): array {
    static $icons = null;
    if ($icons !== null) return $icons;

    $p = fn(string $d): string =>
        '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' . $d . '</svg>';

    $icons = [
        'check'     => ['label' => 'Check',        'svg' => $p('<circle cx="12" cy="12" r="9"/><path d="M8.5 12.5l2.5 2.5 4.5-5"/>')],
        'leaf'      => ['label' => 'Hoja',         'svg' => $p('<path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/>')],
        'recycle'   => ['label' => 'Reciclaje',    'svg' => $p('<path d="M7 19H4.8a2 2 0 0 1-1.7-3l1.9-3.2"/><path d="M11 19h6.2a2 2 0 0 0 1.7-3l-1-1.7"/><path d="M9.6 5.5l-1.1 1.9"/><path d="M14.4 5.5l3.1 5.3"/><polyline points="6.5 15.5 4.2 15.9 4.6 18.2"/><polyline points="17.9 12.6 18.4 10.3 20.7 10.7"/><polyline points="12.5 4.3 10.2 4.7 10.6 7"/>')],
        'truck'     => ['label' => 'Camión',       'svg' => $p('<path d="M1 3h15v13H1z"/><path d="M16 8h4l3 3v5h-7"/><circle cx="6" cy="19" r="2"/><circle cx="18" cy="19" r="2"/>')],
        'shield'    => ['label' => 'Escudo',       'svg' => $p('<path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/><path d="M9 12l2 2 4-4"/>')],
        'award'     => ['label' => 'Certificado',  'svg' => $p('<circle cx="12" cy="8" r="5"/><path d="M8.5 13L7 22l5-3 5 3-1.5-9"/>')],
        'users'     => ['label' => 'Personas',     'svg' => $p('<path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>')],
        'chat'      => ['label' => 'Conversación', 'svg' => $p('<path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/>')],
        'clock'     => ['label' => 'Reloj',        'svg' => $p('<circle cx="12" cy="12" r="9"/><polyline points="12 7 12 12 15.5 14"/>')],
        'box'       => ['label' => 'Caja',         'svg' => $p('<path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4H6z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/>')],
        'store'     => ['label' => 'Local',        'svg' => $p('<path d="M3 9l1.5-5h15L21 9"/><path d="M4 9v11h16V9"/><path d="M3 9a3 3 0 0 0 6 0 3 3 0 0 0 6 0 3 3 0 0 0 6 0"/><path d="M10 20v-6h4v6"/>')],
        'factory'   => ['label' => 'Industria',    'svg' => $p('<path d="M3 21V10l6 4V10l6 4V6l6 15z"/><line x1="3" y1="21" x2="21" y2="21"/>')],
        'pin'       => ['label' => 'Ubicación',    'svg' => $p('<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0Z"/><circle cx="12" cy="10" r="3"/>')],
        'heart'     => ['label' => 'Corazón',      'svg' => $p('<path d="M20.8 5.6a5 5 0 0 0-7.1 0L12 7.3l-1.7-1.7a5 5 0 1 0-7.1 7.1L12 21.5l8.8-8.8a5 5 0 0 0 0-7.1z"/>')],
        'star'      => ['label' => 'Estrella',     'svg' => $p('<polygon points="12 2.5 15 9 22 9.8 17 14.5 18.3 21.5 12 18.1 5.7 21.5 7 14.5 2 9.8 9 9"/>')],
        'sparkle'   => ['label' => 'Destello',     'svg' => $p('<path d="M12 3l1.9 5.6L19.5 10l-5.6 1.9L12 17.5l-1.9-5.6L4.5 10l5.6-1.4z"/><path d="M18.5 16.5l.8 2.2 2.2.8-2.2.8-.8 2.2-.8-2.2-2.2-.8 2.2-.8z"/>')],
        'globe'     => ['label' => 'Mundo',        'svg' => $p('<circle cx="12" cy="12" r="9"/><line x1="3" y1="12" x2="21" y2="12"/><path d="M12 3a15 15 0 0 1 0 18 15 15 0 0 1 0-18z"/>')],
        'doc'       => ['label' => 'Documento',    'svg' => $p('<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="8" y1="13" x2="16" y2="13"/><line x1="8" y1="17" x2="13" y2="17"/>')],
        'phone'     => ['label' => 'Teléfono',     'svg' => $p('<path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1 1 .4 1.9.7 2.8a2 2 0 0 1-.5 2.1L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5c.9.3 1.8.6 2.8.7a2 2 0 0 1 1.7 2z"/>')],
        'mail'      => ['label' => 'Email',        'svg' => $p('<rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="22 6 12 13 2 6"/>')],
    ];
    return $icons;
}

/** SVG del ícono pedido (cae a `check` si no existe). */
function blockIcon(string $key): string {
    $icons = blockIcons();
    return $icons[$key]['svg'] ?? $icons['check']['svg'];
}

/* ========================= Registro de tipos ========================= */

/**
 * Catálogo de bloques disponibles en el editor.
 * @return array<string,array{label:string,desc:string,fields:array}>
 */
function blockTypes(): array {
    static $types = null;
    if ($types !== null) return $types;

    // Campos reutilizados por varios bloques.
    $ctaFields = [
        ['key' => 'cta_label', 'type' => 'text', 'label' => 'Texto del botón', 'placeholder' => 'Ver catálogo', 'half' => true],
        ['key' => 'cta_url',   'type' => 'url',  'label' => 'Link del botón',  'placeholder' => '/catalogo',    'half' => true],
    ];

    $types = [

        'hero' => [
            'label' => 'Portada (hero)',
            'desc'  => 'Encabezado grande con título, texto, foto y botón. Va primero en la página.',
            'fields' => array_merge([
                ['key' => 'kicker',   'type' => 'text',     'label' => 'Antetítulo', 'placeholder' => 'Sobre nosotros', 'hint' => 'Texto chico arriba del título.'],
                ['key' => 'title',    'type' => 'text',     'label' => 'Título', 'placeholder' => 'Sobre GreenBags', 'required' => true],
                ['key' => 'body',     'type' => 'richtext', 'label' => 'Texto'],
                ['key' => 'image',    'type' => 'image',    'label' => 'Foto'],
            ], $ctaFields, [
                ['key' => 'cta2_label', 'type' => 'text', 'label' => 'Segundo botón — texto', 'placeholder' => 'Contáctanos', 'half' => true],
                ['key' => 'cta2_url',   'type' => 'url',  'label' => 'Segundo botón — link',  'placeholder' => '/contacto',   'half' => true],
                ['key' => 'badge_num',  'type' => 'text', 'label' => 'Insignia — número', 'placeholder' => '+15', 'hint' => 'Opcional. Se muestra sobre la foto.', 'half' => true],
                ['key' => 'badge_text', 'type' => 'text', 'label' => 'Insignia — texto',  'placeholder' => 'años de experiencia', 'half' => true],
            ]),
        ],

        'text' => [
            'label' => 'Texto',
            'desc'  => 'Un título y párrafos. El bloque más simple.',
            'fields' => [
                ['key' => 'kicker', 'type' => 'text',     'label' => 'Antetítulo', 'placeholder' => 'Nuestra historia'],
                ['key' => 'title',  'type' => 'text',     'label' => 'Título'],
                ['key' => 'body',   'type' => 'richtext', 'label' => 'Texto'],
                ['key' => 'align',  'type' => 'select',   'label' => 'Alineación', 'default' => 'left',
                 'options' => ['left' => 'Izquierda', 'center' => 'Centrado'], 'half' => true],
                ['key' => 'width',  'type' => 'select',   'label' => 'Ancho', 'default' => 'narrow',
                 'options' => ['narrow' => 'Angosto (más legible)', 'wide' => 'Ancho completo'], 'half' => true],
            ],
        ],

        'text_image' => [
            'label' => 'Texto + imagen',
            'desc'  => 'Una foto al lado de un texto, con botón opcional.',
            'fields' => array_merge([
                ['key' => 'kicker', 'type' => 'text',     'label' => 'Antetítulo'],
                ['key' => 'title',  'type' => 'text',     'label' => 'Título'],
                ['key' => 'body',   'type' => 'richtext', 'label' => 'Texto'],
                ['key' => 'image',  'type' => 'image',    'label' => 'Imagen'],
                ['key' => 'side',   'type' => 'select',   'label' => 'Posición de la imagen', 'default' => 'right',
                 'options' => ['right' => 'A la derecha', 'left' => 'A la izquierda']],
            ], $ctaFields),
        ],

        'cards' => [
            'label' => 'Tarjetas',
            'desc'  => 'Grilla de tarjetas con ícono, título y texto. Ideal para pilares, beneficios o servicios.',
            'fields' => [
                ['key' => 'kicker', 'type' => 'text',     'label' => 'Antetítulo'],
                ['key' => 'title',  'type' => 'text',     'label' => 'Título de la sección'],
                ['key' => 'intro',  'type' => 'textarea', 'label' => 'Bajada', 'hint' => 'Opcional, debajo del título.'],
                ['key' => 'cols',   'type' => 'select',   'label' => 'Tarjetas por fila', 'default' => '3',
                 'options' => ['2' => '2', '3' => '3', '4' => '4']],
                ['key' => 'items', 'type' => 'repeater', 'label' => 'Tarjetas', 'item_label' => 'Tarjeta', 'max' => 12, 'fields' => [
                    ['key' => 'icon',  'type' => 'icon',     'label' => 'Ícono', 'default' => 'check'],
                    ['key' => 'title', 'type' => 'text',     'label' => 'Título', 'required' => true],
                    ['key' => 'body',  'type' => 'textarea', 'label' => 'Texto'],
                ]],
            ],
        ],

        'callout' => [
            'label' => 'Aviso destacado',
            'desc'  => 'Un recuadro con ícono para resaltar un dato (retiro en bodega, horario, aclaración).',
            'fields' => [
                ['key' => 'icon',  'type' => 'icon',     'label' => 'Ícono', 'default' => 'pin'],
                ['key' => 'title', 'type' => 'text',     'label' => 'Título'],
                ['key' => 'body',  'type' => 'richtext', 'label' => 'Texto'],
            ],
        ],

        'stats' => [
            'label' => 'Números',
            'desc'  => 'Cifras grandes con su descripción (+15 años, 500 clientes, etc.).',
            'fields' => [
                ['key' => 'title', 'type' => 'text', 'label' => 'Título de la sección'],
                ['key' => 'items', 'type' => 'repeater', 'label' => 'Números', 'item_label' => 'Número', 'max' => 6, 'fields' => [
                    ['key' => 'value', 'type' => 'text', 'label' => 'Cifra', 'placeholder' => '+15', 'required' => true, 'half' => true],
                    ['key' => 'label', 'type' => 'text', 'label' => 'Descripción', 'placeholder' => 'años de experiencia', 'half' => true],
                ]],
            ],
        ],

        'gallery' => [
            'label' => 'Galería',
            'desc'  => 'Grilla de fotos con epígrafe opcional.',
            'fields' => [
                ['key' => 'title', 'type' => 'text',   'label' => 'Título de la sección'],
                ['key' => 'cols',  'type' => 'select', 'label' => 'Fotos por fila', 'default' => '3',
                 'options' => ['2' => '2', '3' => '3', '4' => '4']],
                ['key' => 'items', 'type' => 'repeater', 'label' => 'Fotos', 'item_label' => 'Foto', 'max' => 24, 'fields' => [
                    ['key' => 'image',   'type' => 'image', 'label' => 'Imagen', 'required' => true],
                    ['key' => 'caption', 'type' => 'text',  'label' => 'Epígrafe'],
                ]],
            ],
        ],

        'logos' => [
            'label' => 'Logos',
            'desc'  => 'Franja de logos (clientes, certificaciones, marcas).',
            'fields' => [
                ['key' => 'title', 'type' => 'text', 'label' => 'Título de la sección', 'placeholder' => 'Certificaciones'],
                ['key' => 'items', 'type' => 'repeater', 'label' => 'Logos', 'item_label' => 'Logo', 'max' => 24, 'fields' => [
                    ['key' => 'image', 'type' => 'image', 'label' => 'Logo', 'required' => true],
                    ['key' => 'alt',   'type' => 'text',  'label' => 'Nombre', 'hint' => 'Se usa como texto alternativo.', 'half' => true],
                    ['key' => 'url',   'type' => 'url',   'label' => 'Link (opcional)', 'half' => true],
                ]],
            ],
        ],

        'faq' => [
            'label' => 'Preguntas frecuentes',
            'desc'  => 'Lista de preguntas que se abren al hacer click.',
            'fields' => [
                ['key' => 'title', 'type' => 'text', 'label' => 'Título de la sección', 'placeholder' => 'Preguntas frecuentes'],
                ['key' => 'items', 'type' => 'repeater', 'label' => 'Preguntas', 'item_label' => 'Pregunta', 'max' => 30, 'fields' => [
                    ['key' => 'q', 'type' => 'text',     'label' => 'Pregunta', 'required' => true],
                    ['key' => 'a', 'type' => 'richtext', 'label' => 'Respuesta'],
                ]],
            ],
        ],

        'cta' => [
            'label' => 'Llamado a la acción',
            'desc'  => 'Banda con un título y un botón. Suele ir al final de la página.',
            'fields' => array_merge([
                ['key' => 'title', 'type' => 'text',     'label' => 'Título', 'required' => true],
                ['key' => 'body',  'type' => 'textarea', 'label' => 'Texto'],
            ], $ctaFields, [
                ['key' => 'cta2_label', 'type' => 'text',   'label' => 'Segundo botón — texto', 'half' => true],
                ['key' => 'cta2_url',   'type' => 'url',    'label' => 'Segundo botón — link',  'half' => true],
                ['key' => 'style',      'type' => 'select', 'label' => 'Color', 'default' => 'brand',
                 'options' => ['brand' => 'Verde de marca', 'soft' => 'Claro']],
            ]),
        ],

        'html' => [
            'label' => 'HTML (avanzado)',
            'desc'  => 'Para incrustar algo que ningún bloque cubre: un mapa, un video, código a medida.',
            'advanced' => true,
            'fields' => [
                ['key' => 'code', 'type' => 'textarea', 'label' => 'Código HTML', 'rows' => 12, 'mono' => true,
                 'hint' => 'Se inserta tal cual. Si no sabés HTML, mejor usá otro bloque.'],
            ],
        ],
    ];
    return $types;
}

/** Definición de un tipo, o null si no existe. */
function blockTypeDef(string $type): ?array {
    return blockTypes()[$type] ?? null;
}

/** Recorre los campos de un tipo (incluye los de repeater vía callback). */
function blockTypeFields(string $type): array {
    return blockTypeDef($type)['fields'] ?? [];
}

/* ========================= Lectura / escritura ========================= */

/**
 * Bloques de una página, ordenados.
 * @return array<int,array{id:int,type:string,is_active:int,data:array}>
 */
function blocksForPage(int $pageId, bool $onlyActive = true): array {
    if ($pageId <= 0) return [];
    try {
        $sql = 'SELECT id, type, sort_order, is_active, data FROM page_blocks WHERE page_id = ?'
             . ($onlyActive ? ' AND is_active = 1' : '')
             . ' ORDER BY sort_order ASC, id ASC';
        $st = getDB()->prepare($sql);
        $st->execute([$pageId]);
        $rows = $st->fetchAll();
    } catch (Throwable $e) {
        return []; // tabla todavía no migrada
    }

    $out = [];
    foreach ($rows as $r) {
        $def = blockTypeDef((string) $r['type']);
        if (!$def) continue; // tipo removido del código: se ignora, no se borra
        $data = json_decode((string) ($r['data'] ?? ''), true);
        $out[] = [
            'id'        => (int) $r['id'],
            'type'      => (string) $r['type'],
            'is_active' => (int) $r['is_active'],
            'data'      => blockNormalizeData($def['fields'], is_array($data) ? $data : []),
        ];
    }
    return $out;
}

/** ¿La página tiene al menos un bloque cargado? (activo o no). */
function pageHasBlocks(int $pageId): bool {
    if ($pageId <= 0) return false;
    try {
        $st = getDB()->prepare('SELECT COUNT(*) FROM page_blocks WHERE page_id = ?');
        $st->execute([$pageId]);
        return (int) $st->fetchColumn() > 0;
    } catch (Throwable $e) {
        return false;
    }
}

/** Cuántos bloques tiene cada página, indexado por page_id (para el listado). */
function blocksCountByPage(): array {
    try {
        $rows = getDB()->query('SELECT page_id, COUNT(*) AS n FROM page_blocks GROUP BY page_id')->fetchAll();
    } catch (Throwable $e) {
        return [];
    }
    $out = [];
    foreach ($rows as $r) $out[(int) $r['page_id']] = (int) $r['n'];
    return $out;
}

/**
 * Reemplaza todos los bloques de una página con lo que llegó del form.
 * $raw viene de $_POST['blocks']: lista de ['type','is_active','f'=>[...]].
 * El orden del array es el orden final (el editor reordena en el DOM).
 */
function blocksSaveForPage(int $pageId, array $raw): void {
    if ($pageId <= 0) return;
    $db = getDB();

    $clean = [];
    foreach ($raw as $item) {
        if (!is_array($item)) continue;
        $type = (string) ($item['type'] ?? '');
        $def  = blockTypeDef($type);
        if (!$def) continue;
        $fields = is_array($item['f'] ?? null) ? $item['f'] : [];
        $clean[] = [
            'type'      => $type,
            'is_active' => !empty($item['is_active']) ? 1 : 0,
            'data'      => blockNormalizeData($def['fields'], $fields),
        ];
    }

    // Borrar + reinsertar: el editor manda siempre la lista completa, y así el
    // orden queda garantizado sin arrastrar ids huérfanos.
    $db->beginTransaction();
    try {
        $del = $db->prepare('DELETE FROM page_blocks WHERE page_id = ?');
        $del->execute([$pageId]);

        $ins = $db->prepare(
            'INSERT INTO page_blocks (page_id, type, sort_order, is_active, data) VALUES (?, ?, ?, ?, ?)'
        );
        foreach ($clean as $i => $b) {
            $ins->execute([
                $pageId, $b['type'], $i, $b['is_active'],
                json_encode($b['data'], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
            ]);
        }
        $db->commit();
    } catch (Throwable $e) {
        $db->rollBack();
        throw $e;
    }
}

/**
 * Deja los datos de un bloque en la forma que declara su schema: castea,
 * aplica defaults, sanitiza el HTML rico y descarta claves desconocidas.
 */
function blockNormalizeData(array $fields, array $raw): array {
    $out = [];
    foreach ($fields as $f) {
        $key  = $f['key'];
        $type = $f['type'];
        $val  = $raw[$key] ?? null;

        if ($type === 'repeater') {
            $items = [];
            if (is_array($val)) {
                $max = (int) ($f['max'] ?? 50);
                foreach ($val as $row) {
                    if (!is_array($row)) continue;
                    $item = blockNormalizeData($f['fields'], $row);
                    // Fila totalmente vacía → se descarta (así "agregar y no
                    // llenar" no deja basura en el front).
                    if (blockRowIsEmpty($item)) continue;
                    $items[] = $item;
                    if (count($items) >= $max) break;
                }
            }
            $out[$key] = $items;
            continue;
        }

        // Los textarea del navegador mandan CRLF; se normaliza a LF para que
        // reguardar sin cambios no altere el JSON.
        $s = is_scalar($val) ? trim(str_replace("\r\n", "\n", (string) $val)) : '';

        switch ($type) {
            case 'richtext':
                $out[$key] = blockSanitizeHtml($s);
                break;
            case 'checkbox':
                $out[$key] = $s !== '' && $s !== '0' ? 1 : 0;
                break;
            case 'select':
                $opts = array_keys($f['options'] ?? []);
                $out[$key] = in_array($s, $opts, true) ? $s : (string) ($f['default'] ?? ($opts[0] ?? ''));
                break;
            case 'icon':
                $out[$key] = isset(blockIcons()[$s]) ? $s : (string) ($f['default'] ?? 'check');
                break;
            case 'url':
                $out[$key] = blockSanitizeUrl($s);
                break;
            case 'image':
                // Rutas locales o URLs absolutas; nada de javascript:/data:.
                $out[$key] = blockSanitizeUrl($s);
                break;
            default: // text, textarea
                $out[$key] = $s;
        }
    }
    return $out;
}

/** ¿Todos los valores de una fila de repeater están vacíos? */
function blockRowIsEmpty(array $row): bool {
    foreach ($row as $v) {
        if (is_array($v)) { if (!blockRowIsEmpty($v)) return false; continue; }
        if (trim((string) $v) !== '' && $v !== 0 && $v !== '0') return false;
    }
    return true;
}

/**
 * URL segura para href/src: permite rutas relativas, anclas, http(s), mailto y
 * tel. Cualquier otro esquema (javascript:, data:, vbscript:) se descarta.
 */
function blockSanitizeUrl(string $url): string {
    $url = trim($url);
    if ($url === '') return '';
    if (preg_match('~^(/|\#|\?)~', $url)) return $url;
    if (preg_match('~^(https?://|mailto:|tel:)~i', $url)) return $url;
    // Sin esquema explícito y sin barra inicial: lo tratamos como ruta interna.
    if (!preg_match('~^[a-z][a-z0-9+.-]*:~i', $url)) return '/' . ltrim($url, '/');
    return '';
}

/**
 * Sanitiza el HTML que produce el editor de texto rico: allowlist de etiquetas
 * y atributos, URLs filtradas. El contenido lo escribe un admin autenticado,
 * pero igual se limpia (evita pegar HTML de Word con estilos y scripts).
 */
function blockSanitizeHtml(string $html): string {
    $html = trim($html);
    if ($html === '') return '';

    // Etiquetas con namespace de Word (<o:p>, <w:sdt>…): DOMDocument las
    // interpreta como su parte local (<o:p> → <p>) y dejaría párrafos fantasma
    // al pegar desde Word. Se quitan antes de parsear.
    $html = preg_replace('~</?[a-z]+:[a-z0-9-]+[^>]*>~i', '', $html) ?? $html;

    $allowed = [
        'p' => [], 'br' => [], 'strong' => [], 'b' => [], 'em' => [], 'i' => [],
        'u' => [], 's' => [], 'ul' => [], 'ol' => [], 'li' => [],
        'h3' => [], 'h4' => [], 'blockquote' => [],
        'a' => ['href', 'target', 'rel'],
    ];

    $dom  = new DOMDocument();
    $prev = libxml_use_internal_errors(true);
    $ok   = $dom->loadHTML(
        '<?xml encoding="UTF-8"><div id="blk-root">' . $html . '</div>',
        LIBXML_NONET | LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD
    );
    libxml_clear_errors();
    libxml_use_internal_errors($prev);
    if (!$ok) return htmlspecialchars(strip_tags($html), ENT_QUOTES);

    $root = $dom->getElementById('blk-root');
    if (!$root) return htmlspecialchars(strip_tags($html), ENT_QUOTES);

    // Recorrido en post-orden: al desenvolver un nodo sus hijos ya fueron
    // procesados, así <div><script>..</script></div> no deja restos.
    $walk = function (DOMNode $node) use (&$walk, $allowed, $dom): void {
        $children = iterator_to_array($node->childNodes);
        foreach ($children as $child) {
            if ($child instanceof DOMElement) {
                $walk($child);
                $tag = strtolower($child->nodeName);

                if (in_array($tag, ['script', 'style', 'iframe', 'object', 'embed'], true)) {
                    $child->parentNode->removeChild($child);
                    continue;
                }
                if (!isset($allowed[$tag])) {
                    // Etiqueta no permitida (div, span, font…): se desenvuelve
                    // conservando el contenido.
                    while ($child->firstChild) {
                        $child->parentNode->insertBefore($child->firstChild, $child);
                    }
                    $child->parentNode->removeChild($child);
                    continue;
                }
                foreach (iterator_to_array($child->attributes) as $attr) {
                    if (!in_array(strtolower($attr->nodeName), $allowed[$tag], true)) {
                        $child->removeAttribute($attr->nodeName);
                    }
                }
                if ($tag === 'a') {
                    $href = blockSanitizeUrl((string) $child->getAttribute('href'));
                    if ($href === '') {
                        $child->removeAttribute('href');
                    } else {
                        $child->setAttribute('href', $href);
                        if ($child->getAttribute('target') === '_blank') {
                            $child->setAttribute('rel', 'noopener');
                        } else {
                            $child->removeAttribute('target');
                            $child->removeAttribute('rel');
                        }
                    }
                }
            } elseif ($child instanceof DOMComment) {
                $child->parentNode->removeChild($child);
            }
        }
    };
    $walk($root);

    // Bloques que quedaron sin contenido tras la limpieza (típico al pegar
    // desde Word o Google Docs) se descartan para no dejar huecos.
    $xp = new DOMXPath($dom);
    foreach ($xp->query('.//p | .//h3 | .//h4 | .//li | .//blockquote', $root) as $el) {
        if (trim($el->textContent) === '' && $el->getElementsByTagName('br')->length === 0) {
            $el->parentNode->removeChild($el);
        }
    }

    $out = '';
    foreach ($root->childNodes as $c) $out .= $dom->saveHTML($c);
    return trim($out);
}

/* ============================== Render ============================== */

/** Escape corto para los partials de bloque. */
function blkH($v): string {
    return htmlspecialchars((string) $v, ENT_QUOTES);
}

/**
 * Renderiza un bloque. $block viene de blocksForPage().
 * $isFirst permite que el hero inicial imprima el <h1> de la página.
 */
function blockRender(array $block, bool $isFirst = false): string {
    $file = __DIR__ . '/../components/blocks/' . basename($block['type']) . '.php';
    if (!is_file($file)) return '';
    $b       = $block['data'];
    $blkType = $block['type'];
    ob_start();
    include $file;
    return (string) ob_get_clean();
}

/** Renderiza todos los bloques activos de una página. */
function blocksRenderPage(int $pageId): string {
    $blocks = blocksForPage($pageId, true);
    if (!$blocks) return '';
    $out = '';
    foreach ($blocks as $i => $b) {
        $out .= blockRender($b, $i === 0);
    }
    return $out;
}

/**
 * ¿El primer bloque activo ya trae su propio <h1>? Sirve para que el router no
 * duplique el título de la página arriba del hero.
 */
function blocksProvideHeading(int $pageId): bool {
    $blocks = blocksForPage($pageId, true);
    return !empty($blocks) && $blocks[0]['type'] === 'hero';
}
