<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';
include_once 'app/core/Connection.inc.php';
include_once 'app/CountryRepository.inc.php';
include_once 'app/Country.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

if (isset($_POST['id'])) {
    Connection::connect();

    $country = CountryRepository::get_by_id(
        Connection::get_connection(),
        $_SESSION['company_id'],
        $_POST['id']
    );

    Connection::disconnect();
}

$title = 'Ver pa&#237;s';

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
        <li class="breadcrumb-item active" aria-current="page">Ver pa&#237;s</li>
    </ol>
</nav>
<!-- end: Breadcrumb -->

<div class="container">
    <div class="row pl-5 pr-5">
        <div class="col-md-3">
        </div>
        <div class="col-md-6 card mb-3 p-0">
            <div class="card-header">
                <h4><b>Ver pa&#237;s</b></h4>
            </div>
            <div class="card-body">
                <form class="form" role="form" autocomplete="off" method="post" enctype="application/x-www-form-urlencoded" action="#">
                    <input type="hidden" name="authenticity_token" value="<?php echo $_SESSION['token']; ?>">
                    <?php include_once 'templates/view-country.inc.php'; ?>
                    <div class="float-right">
                        <a href="<?php echo ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY; ?>" class="btn btn-outline-secondary btn-md" role="button" title="Cerrar formulario">Cerrar</a>
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