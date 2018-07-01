<?php
header($_SERVER['SERVER_PROTOCOL'] . ' 403 Forbidden', true, 403);

include_once 'app/core/config.inc.php';

$title = '403 - Prohibido';

include_once 'template/document-declaration.inc.phtml';
?>

<div class="card" style="float: none; margin: 0 auto; margin-top: 1.5rem; width: 23rem;">
    <div class="card-header text-danger">
        <h4><i class="far fa-hand-paper"></i> Error 403</h4>
    </div>
    <div class="card-body">
        <h5 class="card-title">¡Prohibido!</h5>
        <p class="card-text text-secondary text-justify">No tienes permiso para acceder al recurso que solicitaste en este servidor.</p>
        <a href="<?php echo SERVER; ?>" class="btn btn-primary"><i class="fas fa-home"></i> Ir al inicio</a>
    </div>
</div>

<?php
include_once './template/document-close.inc.phtml';
?>