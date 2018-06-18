<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/functions.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';
include_once 'app/core/Connection.inc.php';
include_once 'app/Country.inc.php';
include_once 'app/CountryRepository.inc.php';
include_once 'app/CountryValidator.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

// begin: variables and contants setup.
$entity = 'Country';
$entity_repository = $entity. 'Repository';
$entity_validator = $entity. 'Validator';

define('ROUTE_MANAGER', ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY_MANAGER);
define('ROUTE_MAINTAIN', ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY_MAINTAIN);
// end: variables and contants setup.

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
            $_POST['area_code'],
            (bool) ((isset($_POST['active']) && $_POST['active'] == "on") ? 1 : 0)
        );

        if ($validator->is_valid()) {
            $model = new $entity(
                $validator->get_company_id(),
                $validator->get_id(),
                $validator->get_name(),
                $validator->get_area_code(),
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

$title = get_title($request, 'pa&#237;s');

include_once 'templates/document-declaration.inc.php';
include_once 'templates/navbar.inc.php';
?>

<!-- begin: Breadcrumb -->
<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<?php echo SERVER; ?>">Inicio</a></li>
        <li class="breadcrumb-item"><a href="<?php echo ROUTE_ADMINISTRATION; ?>">Gesti&#243;n</a></li>
        <li class="breadcrumb-item"><a href="<?php echo ROUTE_ADMINISTRATION_SETUP; ?>">Definiciones</a></li>
        <li class="breadcrumb-item"><a href="<?php echo ROUTE_ADMINISTRATION_SETUP_GENERAL; ?>">General</a></li>
        <li class="breadcrumb-item"><a href="<?php echo ROUTE_MANAGER; ?>">Pa&#237;ses</a></li>
        <li class="breadcrumb-item active" aria-current="page"><?php echo $title; ?></li>
    </ol>
</nav>
<!-- end: Breadcrumb -->

<div class="container">
    <div class="row pl-5 pr-5">
        <div class="col-md-3">
        </div>
        <div class="col-md-6 card mb-3 p-0">
            <div class="card-header">
                <h4><b><?php echo $title; ?></b></h4>
            </div>
            <div class="card-body">
                <!-- begin: SQL exception -->
                <?php
                if (isset($_POST['request']) && isset($response)) {
                    $sql_exception = $entity_repository::get_sql_exception();

                    if (isset($sql_exception)) {
                        ?>
                        <div class="alert alert-info" role="alert">
                            <?php echo $sql_exception; ?>
                        </div>
                        <?php
                    }
                }
                ?>
                <!-- end: SQL exception -->
                <form class="form" role="form" autocomplete="off" method="post" enctype="application/x-www-form-urlencoded" action="<?php echo ROUTE_MAINTAIN; ?>">
                    <input type="hidden" name="authenticity_token" value="<?php echo $_SESSION['token']; ?>">
                    <input type="hidden" name="requested_action" value="<?php echo $request; ?>">
                    <?php include_once 'templates/' . strtolower($entity) . '.inc.php'; ?>
                    <div class="float-right">
                        <?php
                        if ($request !== 'view') {
                            ?>
                            <button
                                type="submit"
                                class="<?php echo get_submit_button_class($request); ?>"
                                name="request"
                                title="<?php echo get_submit_button_title($request); ?>">
                                <?php echo get_request_button_text($request); ?>
                            </button>
                            <?php
                        }
                        ?>
                        <a
                            href="<?php echo ROUTE_MANAGER; ?>"
                            class="btn btn-outline-secondary btn-md"
                            role="button"
                            title="<?php echo get_cancel_button_title($request); ?>">
                            <?php echo get_cancel_button_text($request); ?>
                        </a>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-md-3">
        </div>
    </div>
</div>

<?php
include_once 'templates/document-close.inc.php';
?>