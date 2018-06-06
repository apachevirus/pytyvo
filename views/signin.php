<?php
include_once 'app/config.inc.php';
include_once 'app/SessionControl.inc.php';
include_once 'app/Redirection.inc.php';
include_once 'app/Connection.inc.php';
include_once 'app/SigninValidator.inc.php';
include_once 'app/CompanyRepository.inc.php';

if (SessionControl::session_started()) {
    Redirection::redirect(SERVER);
}

if (isset($_POST['signin'])) {
    Connection::connect();

    $validator = new SigninValidator(Connection::get_connection(), $_POST['username'], $_POST['password'], $_POST['authenticity_token']);

    if ($validator->get_error() === '' && !is_null($validator->get_user())) {
        $company = CompanyRepository::get_by_id(Connection::get_connection(), $validator->get_user()->get_company_id());

        if (isset($company) && !empty($company)) {
            $company_name = $company->get_name();
        } else {
            $company_name = '';
        }

        SessionControl::start_session(
            $validator->get_user()->get_id(),
            $validator->get_user()->get_name(),
            $validator->get_token(),
            $validator->get_user()->get_company_id(),
            $company_name
        );

        Redirection::redirect(SERVER);
    }

    Connection::disconnect();
}

$title = 'Iniciar sesi&#243;n';

include_once 'templates/document-declaration.inc.php';
?>

<div class="container">
    <div class="row mt-3">
        <div class="col-md-12 text-center">
            <img src="<?php echo ROUTE_IMG ?>spirit-animal-logo.png" alt="spirit animal logo" width="100" height="100">
        </div>
    </div>
    <div class="row pl-5 pr-5">
        <div class="col-md-3">
        </div>
        <div class="col-md-6 card p-0">
            <div class="card-header">
                <h4><b>Sistema de Gesti&#243;n Pytyv&#245;</b></h4>
            </div>
            <div class="card-body">
                <form class="form" role="form" autocomplete="off" method="post" enctype="application/x-www-form-urlencoded" action="<?php echo ROUTE_SIGNIN; ?>">
                    <input type="hidden" name="authenticity_token" value="<?php echo bin2hex(random_bytes(32)); ?>">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12">
                                <label for="inputUserName" class="label">Nombre de usuario</label>
                                <input type="text" maxlength="25" name="username" id="inputUserName" class="form-control" placeholder="" required autofocus>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12">
                                <label for="inputPassword" class="label">Contrase&#241;a</label>
                                <input type="password" maxlength="25" name="password" id="inputPassword" class="form-control" placeholder="" required>
                            </div>
                        </div>
                    </div>

                    <?php
                    if (isset($_POST['signin'])) {
                        $validator->show_error();
                    }
                    ?>

                    <button type="submit" class="btn btn-success btn-lg btn-block" name="signin">Ingresar</button>
                </form>
                <div class="row mt-3">
                    <div class="col-md-7 text-left">
                        <a href="<?php echo '#'; ?>">¿Olvidaste tu contrase&#241;a?</a>
                    </div>
                    <div class="col-md-5 text-right">
                        <a href="<?php echo ROUTE_SIGNUP; ?>">Crea una cuenta</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
        </div>
    </div>
    <div class="row mt-3">
        <div class="col-md-12 text-center">
            <p class="mt-3 text-muted">&copy; 2000-2018, Turtle Software Paraguay</p>
        </div>
    </div>
</div>

<?php
include_once 'templates/document-close.inc.php';
?>