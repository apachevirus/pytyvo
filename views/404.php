<?php
header($_SERVER['SERVER_PROTOCOL'] . ' 404 Not Found', true, 404);

include_once 'app/config.inc.php';

$title = '404 - Página no encontrada';

include_once 'templates/document-declaration.inc.php';
?>

<div class="card" style="float: none; margin: 0 auto; margin-top: 1.5rem; width: 23rem;">
    <div class="card-header text-danger">
        <h4><i class="fas fa-times"></i> <b>¡OH NO!</b></h4>
    </div>
    <div class="card-body">
        <h5 class="card-title">¡Página no encontrada!</h5>
        <p class="card-text text-secondary">Asegúrate de escribir la dirección de la página correctamente o vuelve a la página anterior.</p>
    </div>
</div>

<?php
include_once './templates/document-close.inc.php';
?>