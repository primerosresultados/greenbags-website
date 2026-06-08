<?php
/**
 * Acciones del admin para la tienda (catálogo).
 * Se incluye desde admin/index.php dentro del bloque autenticado.
 * Cada acción valida CSRF y redirige (patrón POST-redirect-GET del proyecto).
 */

/** Devuelve true si la acción fue de tienda y ya se manejó (con redirect). */
function handleShopAdminActions(array $user, string $action): bool {
    switch ($action) {

        case 'cat_save':
            csrfCheck();
            $res = categorySave($_POST);
            if ($res['ok']) {
                flashSet('shop_msg', 'Categoría guardada.');
                redirect('/admin/?view=categories');
            }
            flashSet('shop_err', $res['error'] ?? 'No se pudo guardar.');
            redirect('/admin/?view=category&id=' . (int) ($_POST['id'] ?? 0));
            return true;

        case 'cat_delete':
            csrfCheck();
            categoryDelete((int) ($_POST['id'] ?? 0));
            flashSet('shop_msg', 'Categoría eliminada.');
            redirect('/admin/?view=categories');
            return true;

        case 'product_save':
            csrfCheck();
            $res = productSave($_POST);
            if ($res['ok']) {
                flashSet('shop_msg', 'Producto guardado.');
                redirect('/admin/?view=product&id=' . $res['id']);
            }
            flashSet('shop_err', $res['error'] ?? 'No se pudo guardar.');
            redirect('/admin/?view=product&id=' . (int) ($_POST['id'] ?? 0));
            return true;

        case 'product_delete':
            csrfCheck();
            productDelete((int) ($_POST['id'] ?? 0));
            flashSet('shop_msg', 'Producto eliminado.');
            redirect('/admin/?view=products');
            return true;

        case 'variations_save':
            csrfCheck();
            $pid = (int) ($_POST['id'] ?? 0);
            variationUpdateBulk($pid, (array) ($_POST['variations'] ?? []));
            flashSet('shop_msg', 'Variaciones actualizadas.');
            redirect('/admin/?view=product&id=' . $pid);
            return true;
    }
    return false;
}
