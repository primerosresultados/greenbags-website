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

/** @return array{ok:bool,id?:int,error?:string} */
function bannerSave(array $d): array {
    $id    = (int) ($d['id'] ?? 0);
    $title = trim((string) ($d['title'] ?? ''));
    if ($title === '') return ['ok' => false, 'error' => 'El título del banner es obligatorio.'];

    $alignAllowed = ['left', 'center', 'right'];
    $align = in_array($d['text_align'] ?? 'left', $alignAllowed, true) ? $d['text_align'] : 'left';

    // Overlay (degradé oscuro sobre la imagen). Si vienen, se clampan a 0-100.
    // Defaults coinciden con el degradé histórico del CSS (86% izq, 55% der).
    $overlayLeft  = isset($d['overlay_left'])  ? max(0, min(100, (int) $d['overlay_left']))  : 86;
    $overlayRight = isset($d['overlay_right']) ? max(0, min(100, (int) $d['overlay_right'])) : 55;

    $params = [
        'position'      => 'home_hero',
        'eyebrow'       => mb_substr(trim((string) ($d['eyebrow'] ?? '')), 0, 120) ?: null,
        'title'         => mb_substr($title, 0, 200),
        'subtitle'      => mb_substr(trim((string) ($d['subtitle'] ?? '')), 0, 400) ?: null,
        'image_id'      => (int) ($d['image_id'] ?? 0) ?: null,
        'cta_label'     => mb_substr(trim((string) ($d['cta_label'] ?? '')), 0, 80) ?: null,
        'cta_url'       => mb_substr(trim((string) ($d['cta_url'] ?? '')), 0, 255) ?: null,
        'text_align'    => $align,
        'overlay_left'  => $overlayLeft,
        'overlay_right' => $overlayRight,
        'sort_order'    => (int) ($d['sort_order'] ?? 0),
        'is_active'     => !empty($d['is_active']) ? 1 : 0,
    ];

    try {
        if ($id > 0) {
            $params['id'] = $id;
            $st = getDB()->prepare(
                'UPDATE banners SET position=:position, eyebrow=:eyebrow, title=:title,
                 subtitle=:subtitle, image_id=:image_id, cta_label=:cta_label,
                 cta_url=:cta_url, text_align=:text_align,
                 overlay_left=:overlay_left, overlay_right=:overlay_right,
                 sort_order=:sort_order, is_active=:is_active
                 WHERE id=:id'
            );
            $st->execute($params);
            return ['ok' => true, 'id' => $id];
        }
        $st = getDB()->prepare(
            'INSERT INTO banners (position, eyebrow, title, subtitle, image_id,
             cta_label, cta_url, text_align, overlay_left, overlay_right,
             sort_order, is_active)
             VALUES (:position, :eyebrow, :title, :subtitle, :image_id,
             :cta_label, :cta_url, :text_align, :overlay_left, :overlay_right,
             :sort_order, :is_active)'
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
