<?php
include_once 'app/config.inc.php';
include_once 'app/SessionControl.inc.php';
include_once 'app/Redirection.inc.php';
include_once 'app/Connection.inc.php';
include_once 'app/CountryValidator.inc.php';
include_once 'app/Country.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

if (isset($_POST['save'])) {
    Connection::connect();

    $validator = new CountryValidator(
        Connection::get_connection(),
        $_SESSION['company_id'],
        (int) $_POST['id'],
        $_POST['name'],
        $_POST['area_code'],
        (bool) ((isset($_POST['active']) && $_POST['active'] == "on") ? 1 : 0)
    );

    if ($validator->is_valid()) {
        $country = new Country(
            $validator->get_company_id(),
            $validator->get_id(),
            $validator->get_name(),
            $validator->get_area_code(),
            $validator->is_active(),
            '',   // created_at
            ''    // updated_at
        );

        $country_inserted = CountryRepository::insert(
            Connection::get_connection(),
            $_SESSION['user_id'],
            $country
        );

        if ($country_inserted) {
            Redirection::redirect(ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY);
        }
    }

    Connection::disconnect();
}

$title = 'Nuevo pa&#237;s';

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
        <li class="breadcrumb-item"><a href="<?php echo ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY; ?>">Pa&#237;ses</a></li>
        <li class="breadcrumb-item active" aria-current="page">Nuevo pa&#237;s</li>
    </ol>
</nav>
<!-- end: Breadcrumb -->

<!-- begin: SQL exception modal-->
<?php
if (isset($_POST['save']) && isset($country_inserted)) {
    $sql_exception = CountryRepository::get_sql_exception();

    if (isset($sql_exception)) {
        ?>
        <div class="modal" id="sqlExceptionModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Modal header -->
                    <div class="modal-header alert-danger">
                        <h5 class="modal-title">No se pudo completar la solicitud &#160;<i class="icofont icofont-emo-sad"></i></h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <!-- Modal body -->
                    <div class="modal-body">
                        <?php echo $sql_exception; ?>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        <?php
    }
}
?>
<!-- end: SQL exception modal-->

<div class="container">
    <div class="row pl-5 pr-5">
        <div class="col-md-3">
        </div>
        <div class="col-md-6 card mb-3 p-0">
            <div class="card-header">
                <h4><b>Nuevo pa&#237;s</b></h4>
            </div>
            <div class="card-body">
                <form class="form" role="form" autocomplete="off" method="post" enctype="application/x-www-form-urlencoded" action="<?php echo ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY_NEW_COUNTRY; ?>">
                    <input type="hidden" name="authenticity_token" value="<?php echo $_SESSION['token']; ?>">
                    <?php
                    if (isset($_POST['save'])) {
                        include_once 'templates/new-country-validated.inc.php';
                    } else {
                        include_once 'templates/new-country-empty.inc.php';
                    }
                    ?>
                    <div class="float-right">
                        <button type="submit" class="btn btn-primary btn-md" name="save" title="Aceptar los cambios y cerrar formulario">Guardar</button>
                        <a href="<?php echo ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY; ?>" class="btn btn-outline-secondary btn-md" role="button" title="Cancelar los cambios y cerrar formulario">Cancelar</a>
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