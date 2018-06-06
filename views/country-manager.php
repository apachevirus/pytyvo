<?php
include_once 'app/config.inc.php';
include_once 'app/SessionControl.inc.php';
include_once 'app/Redirection.inc.php';
include_once 'app/Connection.inc.php';
include_once 'app/CountryRepository.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

Connection::connect();
$total_countries = CountryRepository::get_reccount(Connection::get_connection());
$countries = CountryRepository::get_all(Connection::get_connection());
Connection::disconnect();

$title = 'Gesti&#243;n de pa&#237;ses';

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
        <li class="breadcrumb-item active" aria-current="page">Pa&#237;ses</li>
    </ol>
</nav>
<!-- end: Breadcrumb -->

<div class="container rounded pt-3" style="background: white;">
    <!-- begin: Header -->
    <div class="row mb-5">
        <div class="col-md-12">
            <h2>
                <i class="icofont icofont-earth"></i> Pa&#237;ses
                <span class="badge badge-secondary" style="font-size: 0.75rem; vertical-align: middle;" title="Cantidad de registros"><?php echo $total_countries; ?></span>
                <a class="btn btn-outline-secondary btn-sm" role="button" href="<?php echo ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY; ?>" title="Recargar la p&#225;gina">
                    <span class="icofont icofont-refresh"></span>
                </a>
            </h2>
            <a href="<?php echo ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY_NEW_COUNTRY; ?>" class="btn btn-success btn-sm mt-3" role="button" id="btn-new-country" title="Crear un nuevo registro">
                <i class="icofont icofont-plus"></i> Nuevo
            </a>
        </div>
    </div>
    <!-- end: Header -->

    <!-- begin: Detail -->
    <div class="row pb-3">
        <div class="col-md-12">
            <?php
            if (count($countries) > 0) {
                ?>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th class="text-center">C&#243;digo</th>
                            <th>Nombre</th>
                            <th class="text-center">Vigente</th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        for ($i = 0; $i < count($countries); $i++) {
                            $country = $countries[$i];
                            ?>
                            <tr>
                                <td class="text-center"><?php echo $country->get_id(); ?></td>
                                <td><?php echo $country->get_name(); ?></td>
                                <td class="text-center"><?php if ($country->is_active()) echo 'S&#237;'; else echo 'No'; ?></td>
                                <td class="text-right">
                                    <form method="post" action="">
                                        <input type="hidden" name="id-to-view" value="<?php echo $country->get_id(); ?>">
                                        <button type="submit" class="btn btn-outline-secondary btn-sm" name="btn-view-country" title="Ver"><i class="far fa-eye"></i></button>
                                    </form>
                                </td>
                                <td class="text-center">
                                    <form method="post" action="">
                                        <input type="hidden" name="id-to-edit" value="<?php echo $country->get_id(); ?>">
                                        <button type="submit" class="btn btn-outline-secondary btn-sm" name="btn-edit-country" title="Editar"><i class="fas fa-edit"></i></button>
                                    </form>
                                </td>
                                <td class="text-left">
                                    <form method="post" action="">
                                        <input type="hidden" name="id-to-delete" value="<?php echo $country->get_id(); ?>">
                                        <button type="submit" class="btn btn-outline-danger btn-sm" name="btn-delete-country" title="Eliminar"><i class="fas fa-trash-alt"></i></button>
                                    </form>
                                </td>
                            </tr>
                            <?php
                        }
                        ?>
                    </tbody>
                </table>
                <?php
            } else {
                ?>
                <hr>
                <h4 class="text-center">No hay datos para mostrar.</h4>
                <?php
            }    
            ?>
        </div>
    </div>
    <!-- end: Detail -->
</div>

<?php
include_once 'templates/document-close.inc.php';
?>