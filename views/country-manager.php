<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/functions.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';
include_once 'app/core/Connection.inc.php';
include_once 'app/core/Utils.inc.php';
include_once 'app/CountryRepository.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

// begin: variables and contants setup.
$entity_repository = 'CountryRepository';

define('ROUTE_MANAGER', ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY_MANAGER);
define('ROUTE_MAINTAIN', ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY_MAINTAIN);
// end: variables and contants setup.

Connection::connect();

if (variable_initiated($_POST['search'])) {
    $search = $_POST['search'];
    $any = Utils::prepare_for_search($search);

    $rows = $entity_repository::get_by_any(
        Connection::get_connection(),
        $_SESSION['company_id'],
        $any
    );
} else {
    $rows = $entity_repository::get_all(
        Connection::get_connection(),
        $_SESSION['company_id']
    );
}

$reccount = count($rows);

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
        <div class="col-md-6">
            <h1>
                <i class="icofont icofont-earth"></i> Pa&#237;ses
                <span class="badge badge-secondary" style="font-size: 0.75rem; vertical-align: middle;" title="Cantidad de registros"><?php echo $reccount; ?></span>
                <a class="btn btn-outline-secondary btn-sm" role="button" href="<?php echo ROUTE_MANAGER; ?>" title="Recargar la p&#225;gina">
                    <span class="icofont icofont-refresh"></span>
                </a>
            </h1>
            <form method="post" action="<?php echo ROUTE_MAINTAIN; ?>">
                <button type="submit" class="btn btn-success mt-3" name="new" title="Crear un nuevo registro"><i class="icofont icofont-plus"></i> Nuevo</button>
            </form>
        </div>
        <div class="col-md-6">
            <form class="form-inline mt-2 mt-md-2 float-right" method="post" action="<?php echo ROUTE_MANAGER; ?>">
                <input type="text" class="form-control mr-sm-2" id="inputSearch" name="search" maxlength="50" placeholder="Buscar..." aria-label="Buscar" value="<?php if (isset($search)) echo $search; ?>">
                <button type="submit" class="btn btn-outline-secondary my-2 my-sm-0" name="" title="Buscar">Buscar</button>
            </form>
        </div>
    </div>
    <!-- end: Header -->

    <!-- begin: Detail -->
    <div class="row pb-3">
        <div class="col-md-12">
            <?php
            if (count($rows) > 0) {
                ?>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th class="text-center">C&#243;digo</th>
                            <th>Nombre</th>
                            <th class="text-center">Prefijo telef&#243;nico</th>
                            <th class="text-center">Vigente</th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        for ($i = 0; $i < count($rows); $i++) {
                            $row = $rows[$i];
                            ?>
                            <tr>
                                <td class="text-center"><?php echo $row->get_id(); ?></td>
                                <td><?php echo $row->get_name(); ?></td>
                                <td class="text-center"><?php echo $row->get_area_code(); ?></td>
                                <td class="text-center"><?php if ($row->is_active()) echo 'S&#237;'; else echo 'No'; ?></td>
                                <td class="text-right">
                                    <form method="post" action="<?php echo ROUTE_MAINTAIN; ?>">
                                        <input type="hidden" name="id" value="<?php echo $row->get_id(); ?>">
                                        <button type="submit" class="btn btn-outline-secondary btn-sm" name="view" title="Ver"><i class="far fa-eye"></i></button>
                                    </form>
                                </td>
                                <td class="text-center">
                                    <form method="post" action="<?php echo ROUTE_MAINTAIN ?>">
                                        <input type="hidden" name="id" value="<?php echo $row->get_id(); ?>">
                                        <button type="submit" class="btn btn-outline-secondary btn-sm" name="edit" title="Editar"><i class="fas fa-edit"></i></button>
                                    </form>
                                </td>
                                <td class="text-left">
                                    <form method="post" action="<?php echo ROUTE_MAINTAIN; ?>">
                                        <input type="hidden" name="id" value="<?php echo $row->get_id(); ?>">
                                        <button type="submit" class="btn btn-outline-danger btn-sm" name="delete" title="Eliminar"><i class="fas fa-trash-alt"></i></button>
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