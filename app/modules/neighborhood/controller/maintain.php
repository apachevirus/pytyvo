<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/functions.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';
include_once 'app/core/Connection.inc.php';
include_once 'app/modules/depar/model/DeparRepository.inc.php';
include_once 'app/modules/city/model/CityRepository.inc.php';
include_once dirname(__DIR__) . '/model/Neighborhood.inc.php';
include_once dirname(__DIR__) . '/model/NeighborhoodRepository.inc.php';
include_once dirname(__DIR__) . '/model/NeighborhoodValidator.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

# begin { variables and constants setup }
$entity = 'neighborhood';
$entity_repository = ucfirst($entity) . 'Repository';
$entity_validator = ucfirst($entity) . 'Validator';
$title = 'barrio';

define('ROUTE_MANAGER', ROUTE_ADMINISTRATION_SETUP_GENERAL_NEIGHBORHOOD_MANAGER);
define('ROUTE_MAINTAIN', ROUTE_ADMINISTRATION_SETUP_GENERAL_NEIGHBORHOOD_MAINTAIN);
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
            (int) $_POST['depar_id'],
            (int) $_POST['city_id'],
            (bool) ((isset($_POST['active']) && $_POST['active'] == "on") ? 1 : 0)
        );

        if ($validator->is_valid()) {
            $model = new $entity(
                $validator->get_company_id(),
                $validator->get_id(),
                $validator->get_name(),
                $validator->get_depar_id(),
                $validator->get_city_id(),
                '',   // full_name
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

$depars = DeparRepository::get_all_active(
    Connection::get_connection(),
    $_SESSION['company_id']
);

# begin { gets the depar_id value }
if (isset($model)) {
    // view, edit, edit validated and delete.
    if (isset($validator)) {
        $depar_id = $validator->get_depar_id();
    } else {
        $depar_id = $model->get_depar_id();
    }
} elseif (isset($_POST['depar_id'])) {
    // new and new validated.
    $depar_id = $_POST['depar_id'];
} else {
    // new.
    $depar_id = 0;
}
# end { gets the depar_id value }

if ($depar_id > 0) {
    $cities = CityRepository::get_all_active_filtered_by_depar(
        Connection::get_connection(),
        $_SESSION['company_id'],
        $depar_id
    );
}

Connection::disconnect();

$title = get_title($request, $title);

include_once 'template/document-declaration.inc.phtml';
include_once 'template/navbar.inc.phtml';
include_once dirname(__DIR__) . '/view/maintain.inc.phtml';
include_once 'template/document-close.inc.phtml';
?>