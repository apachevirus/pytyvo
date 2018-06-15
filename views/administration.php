<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

include_once 'templates/document-declaration.inc.php';
include_once 'templates/navbar.inc.php';
?>

<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<?php echo SERVER; ?>">Inicio</a></li>
        <li class="breadcrumb-item active" aria-current="page">Gesti&#243;n</li>
    </ol>
</nav>

<div class="container rounded">
    <div class="row p-4" style="background: white;">
        <div class="col-md-12">
            <a class="quick-btn" href="<?php echo ROUTE_ADMINISTRATION_SETUP; ?>">
                <i class="fas fa-folder" style="font-size: 1.5rem;"></i>
                <span>Definiciones</span>
            </a>
        </div>
    </div>
</div>

<?php
include_once 'templates/document-close.inc.php';
?>