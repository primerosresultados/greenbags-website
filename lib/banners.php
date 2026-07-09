<?php
/**
 * Banners (slides) reutilizables. Hoy se usan en el hero de la home, pero la
 * columna `position` permite ampliar a otras zonas sin nuevas tablas.
 */

function bannersGet(string $position = 'home_hero', bool $activeOnly = true): array {
    try {
        $sql = 'SELECT b.*, m.file_path AS image_path, m.alt AS image_alt
                FROM banners b LEFT JOIN media_library m ON m.id = b.image_id
                WHERE b.position = ?';
        if ($activeOnly) $sql .= ' AND b.is_active = 1';
        $sql .= ' ORDER BY b.sort_order ASC, b.id ASC';
        $st = getDB()->prepare($sql);
        $st->execute([$position]);
        return $st->fetchAll();
    } catch (Throwable $e) {
        // Migración aún no corrida.
        return [];
    }
}

function bannerGet(int $id): ?array {
    if ($id <= 0) return null;
    try {
        $st = getDB()->prepare(
            'SELECT b.*, m.file_path AS image_path FROM banners b
             LEFT JOIN media_library m ON m.id = b.image_id
             WHERE b.id = ?'
        );
        $st->execute([$id]);
        return $st->fetch() ?: null;
    } catch (Throwable $e) {
        return null;
    }
}

/**
 * Resuelve el valor del campo de imagen a un `image_id` de la mediateca.
 * El field genérico (_single_image_field) guarda un PATH; acá lo mapeamos a la
 * fila de media_library. Acepta también un id numérico directo (compatibilidad).
 */
function bannerResolveImageId(array $d): ?int {
    $path = trim((string) ($d['image_path'] ?? ''));
    if ($path !== '') {
        try {
            $st = getDB()->prepare('SELECT id FROM media_library WHERE file_path = ? ORDER BY id DESC LIMIT 1');
            $st->execute([$path]);
            $id = (int) ($st->fetchColumn() ?: 0);
            return $id > 0 ? $id : null;
        } catch (Throwable $e) {
            return null;
        }
    }
    // Fallback: id numérico enviado directamente.
    $id = (int) ($d['image_id'] ?? 0);
    return $id > 0 ? $id : null;
}

/** @return array{ok:bool,id?:int,error?:string} */
function bannerSave(array $d): array {
    $id    = (int) ($d['id'] ?? 0);
    $title = trim((string) ($d['title'] ?? ''));
    if ($title === '') return ['ok' => false, 'error' => 'El título del banner es obligatorio.'];

    $alignAllowed = ['left', 'center', 'right'];
    $align = in_array($d['text_align'] ?? 'left', $alignAllowed, true) ? $d['text_align'] : 'left';

    $params = [
        'position'   => 'home_hero',
        'eyebrow'    => mb_substr(trim((string) ($d['eyebrow'] ?? '')), 0, 120) ?: null,
        'title'      => mb_substr($title, 0, 200),
        'subtitle'   => mb_substr(trim((string) ($d['subtitle'] ?? '')), 0, 400) ?: null,
        'image_id'   => bannerResolveImageId($d),
        'cta_label'  => mb_substr(trim((string) ($d['cta_label'] ?? '')), 0, 80) ?: null,
        'cta_url'    => mb_substr(trim((string) ($d['cta_url'] ?? '')), 0, 255) ?: null,
        'text_align' => $align,
        'sort_order' => (int) ($d['sort_order'] ?? 0),
        'is_active'  => !empty($d['is_active']) ? 1 : 0,
    ];

    try {
        if ($id > 0) {
            $params['id'] = $id;
            $st = getDB()->prepare(
                'UPDATE banners SET position=:position, eyebrow=:eyebrow, title=:title,
                 subtitle=:subtitle, image_id=:image_id, cta_label=:cta_label,
                 cta_url=:cta_url, text_align=:text_align,
                 sort_order=:sort_order, is_active=:is_active
                 WHERE id=:id'
            );
            $st->execute($params);
            return ['ok' => true, 'id' => $id];
        }
        $st = getDB()->prepare(
            'INSERT INTO banners (position, eyebrow, title, subtitle, image_id,
             cta_label, cta_url, text_align, sort_order, is_active)
             VALUES (:position, :eyebrow, :title, :subtitle, :image_id,
             :cta_label, :cta_url, :text_align, :sort_order, :is_active)'
        );
        $st->execute($params);
        return ['ok' => true, 'id' => (int) getDB()->lastInsertId()];
    } catch (PDOException $e) {
        return ['ok' => false, 'error' => 'No se pudo guardar el banner.'];
    }
}

function bannerDelete(int $id): bool {
    if ($id <= 0) return false;
    try {
        return getDB()->prepare('DELETE FROM banners WHERE id = ?')->execute([$id]);
    } catch (Throwable $e) {
        return false;
    }
}

function bannerToggleActive(int $id): void {
    try {
        getDB()->prepare('UPDATE banners SET is_active = 1 - is_active WHERE id = ?')
               ->execute([$id]);
    } catch (Throwable $e) {}
}

function bannerListAll(): array {
    try {
        return getDB()->query(
            'SELECT b.*, m.file_path AS image_path FROM banners b
             LEFT JOIN media_library m ON m.id = b.image_id
             ORDER BY b.position, b.sort_order, b.id'
        )->fetchAll();
    } catch (Throwable $e) {
        return [];
    }
}
