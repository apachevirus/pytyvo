<?php
include_once 'app/core/config.inc.php';

$title = '¡Registro exitoso!';

include_once 'template/document-declaration.inc.phtml'
?>

<div class="card" style="float: none; margin: 0 auto; margin-top: 1.5rem; width: 23rem;">
    <div class="card-header text-success">
        <h4><i class="far fa-check-circle"></i> <b>Registro correcto</b></h4>
    </div>
    <div class="card-body">
        <p class="card-text">¡Gracias por registrarte <b><?php echo urldecode($name); ?></b>!</p>
        <p><a href="<?php echo ROUTE_SIGNIN ?>" class="card-link">Inicia sesión</a> para comenzar a usar tu cuenta.</p>
    </div>
</div>

<?php
include_once 'template/document-close.inc.phtml'
?>