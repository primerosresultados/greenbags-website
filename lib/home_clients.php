<?php
/**
 * "Nuestros clientes" del home. Cada cliente tiene nombre + logo propio
 * (logo_path como ruta de imagen), editable desde el admin. Mismo estilo de
 * API que lib/banners.php. Todo protegido contra la tabla aún sin migrar.
 */

/** Clientes para el front (por defecto solo activos), ordenados. */
function clientsGet(bool $activeOnly = true): array {
    try {
        $sql = 'SELECT id, name, logo_path, sort_order, is_active FROM home_clients';
        if ($activeOnly) $sql .= ' WHERE is_active = 1';
        $sql .= ' ORDER BY sort_order ASC, id ASC';
        return getDB()->query($sql)->fetchAll();
    } catch (Throwable $e) {
        return [];
    }
}

/** Todos los clientes (para el admin), sin filtrar por activo. */
function clientsListAll(): array {
    return clientsGet(false);
}

function clientGet(int $id): ?array {
    if ($id <= 0) return null;
    try {
        $st = getDB()->prepare('SELECT * FROM home_clients WHERE id = ?');
        $st->execute([$id]);
        return $st->fetch() ?: null;
    } catch (Throwable $e) {
        return null;
    }
}

/** @return array{ok:bool,id?:int,error?:string} */
function clientSave(array $d): array {
    $id   = (int) ($d['id'] ?? 0);
    $name = trim((string) ($d['name'] ?? ''));
    if ($name === '') return ['ok' => false, 'error' => 'El nombre del cliente es obligatorio.'];

    $params = [
        'name'       => mb_substr($name, 0, 160),
        'logo_path'  => mb_substr(trim((string) ($d['logo_path'] ?? '')), 0, 255) ?: null,
        'sort_order' => (int) ($d['sort_order'] ?? 0),
        'is_active'  => !empty($d['is_active']) ? 1 : 0,
    ];

    try {
        if ($id > 0) {
            $params['id'] = $id;
            $st = getDB()->prepare(
                'UPDATE home_clients SET name=:name, logo_path=:logo_path,
                 sort_order=:sort_order, is_active=:is_active WHERE id=:id'
            );
            $st->execute($params);
            return ['ok' => true, 'id' => $id];
        }
        $st = getDB()->prepare(
            'INSERT INTO home_clients (name, logo_path, sort_order, is_active)
             VALUES (:name, :logo_path, :sort_order, :is_active)'
        );
        $st->execute($params);
        return ['ok' => true, 'id' => (int) getDB()->lastInsertId()];
    } catch (PDOException $e) {
        return ['ok' => false, 'error' => 'No se pudo guardar el cliente.'];
    }
}

function clientDelete(int $id): bool {
    if ($id <= 0) return false;
    try {
        return getDB()->prepare('DELETE FROM home_clients WHERE id = ?')->execute([$id]);
    } catch (Throwable $e) {
        return false;
    }
}

function clientToggleActive(int $id): void {
    try {
        getDB()->prepare('UPDATE home_clients SET is_active = 1 - is_active WHERE id = ?')
               ->execute([$id]);
    } catch (Throwable $e) {}
}
