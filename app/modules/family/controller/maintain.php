<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/functions.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';
include_once 'app/core/Connection.inc.php';
include_once dirname(__DIR__) . '/model/Family.inc.php';
include_once dirname(__DIR__) . '/model/FamilyRepository.inc.php';
include_once dirname(__DIR__) . '/model/FamilyValidator.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

# begin { variables and constants setup }
$entity = 'family';
$entity_repository = ucfirst($entity) . 'Repository';
$entity_validator = ucfirst($entity) . 'Validator';
$title = 'familia';

define('ROUTE_MANAGER', ROUTE_ADMINISTRATION_SETUP_INVENTORY_FAMILY_MANAGER);
define('ROUTE_MAINTAIN', ROUTE_ADMINISTRATION_SETUP_INVENTORY_FAMILY_MAINTAIN);
# end { variables and constants setup }

$request = get_request();

if (empty($request)) {
    Redirection::redirect(ROUTE_MANAGER);
}

Connection::connect();

if (isset($_POST['id'])) {
    if (variable_initiated($_POST['id'])) {
        $model = $entity_repository::get_by_id(
            Connection::get_connection(),
            $_SESSION['company_id'],
            $_POST['id']
        );
    }
}

if (isset($_POST['request'])) {
    if ($request == 'new' || $request == 'edit') {
        $validator = new $entity_validator(
            Connection::get_connection(),
            $_SESSION['company_id'],
            (int) $_POST['id'],
            $_POST['name'],
            (float) $_POST['p1'],
            (float) $_POST['p2'],
            (float) $_POST['p3'],
            (float) $_POST['p4'],
            (float) $_POST['p5'],
            (bool) ((isset($_POST['active']) && $_POST['active'] == "on") ? 1 : 0)
        );

        if ($validator->is_valid()) {
            $model = new $entity(
                $validator->get_company_id(),
                $validator->get_id(),
                $validator->get_name(),
                $validator->get_percentage(1),
                $validator->get_percentage(2),
                $validator->get_percentage(3),
                $validator->get_percentage(4),
                $validator->get_percentage(5),
                $validator->is_active(),
                '',   // created_at
                ''    // updated_at
            );

            if ($request == 'new') {
                $response = $entity_repository::insert(
                    Connection::get_connection(),
                    $_SESSION['user_id'],
                    $model
                );
            } elseif ($request == 'edit') {
                $response = $entity_repository::update(
                    Connection::get_connection(),
                    $_SESSION['user_id'],
                    $model
                );
            }
        }
    } elseif ($request == 'delete') {
        $response = $entity_repository::delete(
            Connection::get_connection(),
            $_SESSION['user_id'],
            $model->get_company_id(),
            $model->get_id()
        );
    }

    if (isset($response) && $response) {
        Redirection::redirect(ROUTE_MANAGER);
    }
}

Connection::disconnect();

$title = str_replace('Nuevo', 'Nueva', get_title($request, $title));

include_once 'template/document-declaration.inc.phtml';
include_once 'template/navbar.inc.phtml';
include_once dirname(__DIR__) . '/view/maintain.inc.phtml';
include_once 'template/document-close.inc.phtml';
?>