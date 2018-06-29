<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

include_once 'template/document-declaration.inc.phtml';
include_once 'template/navbar.inc.phtml';
?>

<div class="container rounded mt-5">
    <div class="row p-4" style="background: white;">
        <div class="col-md-12">
            <a class="quick-btn" href="<?php echo ROUTE_ADMINISTRATION; ?>">
                <i class="icofont icofont-copy-black" style="font-size: 1.5rem;"></i>
                <span>Gesti&#243;n</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="fas fa-chart-line" style="font-size: 1.5rem;"></i>
                <span>Finanzas</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="icofont icofont-sale-discount" style="font-size: 1.5rem;"></i>
                <span>Ventas</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="fas fa-shopping-cart" style="font-size: 1.5rem;"></i>
                <span>Compras</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="fas fa-handshake" style="font-size: 1.5rem;"></i>
                <span>Socios de negocios</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="icofont icofont-bank-alt" style="font-size: 1.5rem;"></i>
                <span>Gesti&#243;n de bancos</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="fas fa-boxes" style="font-size: 1.5rem;"></i>
                <span>Inventario</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="fas fa-cog" style="font-size: 1.5rem;"></i>
                <span>Producci&#243;n</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="fas fa-wrench" style="font-size: 1.5rem;"></i>
                <span>Servicio</span>
            </a>
            <a class="quick-btn" href="#">
                <i class="icofont icofont-users-alt-4" style="font-size: 1.5rem;"></i>
                <span>Recursos humanos</span>
            </a>
        </div>
    </div>
</div>

<?php
include_once 'template/document-close.inc.phtml';
?>