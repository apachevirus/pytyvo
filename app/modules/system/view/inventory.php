<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

include_once 'template/document-declaration.inc.php';
include_once 'template/navbar.inc.php';
?>

<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="<?php echo SERVER; ?>">Inicio</a></li>
        <li class="breadcrumb-item"><a href="<?php echo ROUTE_ADMINISTRATION; ?>">Gesti&#243;n</a></li>
        <li class="breadcrumb-item"><a href="<?php echo ROUTE_ADMINISTRATION_SETUP; ?>">Definiciones</a></li>
        <li class="breadcrumb-item active" aria-current="page">Inventario</li>
    </ol>
</nav>

<div class="container rounded">
    <div class="row p-4" style="background: white;">
        <div class="col-md-12">
            <a class="quick-btn" href="#">
                <i class="far fa-window-maximize" style="font-size: 1.5rem;"></i>
                <span>Usuarios</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="far fa-window-maximize" style="font-size: 1.5rem;"></i>
                <span>Familias</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="far fa-window-maximize" style="font-size: 1.5rem;"></i>
                <span>Rubros</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="far fa-window-maximize" style="font-size: 1.5rem;"></i>
                <span>Subrubros</span>
            </a>
            <a class="quick-btn" href="<?php echo ROUTE_ADMINISTRATION_SETUP_INVENTORY_BRAND_MANAGER; ?>">
                <i class="far fa-window-maximize" style="font-size: 1.5rem;"></i>
                <span>Marcas</span>
            </a>
        </div>
    </div>
</div>

<?php
include_once 'template/document-close.inc.php';
?>