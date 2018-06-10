<?php
include_once 'app/config.inc.php';
include_once 'app/SessionControl.inc.php';
include_once 'app/Redirection.inc.php';
include_once 'app/Connection.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

if (isset($_POST['save'])) {
    Connection::connect();

    $validator = new CountryValidator(
        Connection::get_connection(),
        $_POST['id'],
        $_POST['name'],
        $_POST['area_code'],
        $_POST['active']
    );
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