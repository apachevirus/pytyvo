<?php
include_once 'app/config.inc.php';
include_once 'app/Connection.inc.php';
include_once 'app/User.inc.php';
include_once 'app/UserRepository.inc.php';
include_once 'app/SignupValidator.inc.php';
include_once 'app/Redirection.inc.php';

if (isset($_POST['submit'])) {
    Connection::connect();

    $validator = new SignupValidator(Connection::get_connection(), $_POST['name'], $_POST['email'], $_POST['username'], $_POST['password1'], $_POST['password2']);

    if ($validator->is_valid()) {
        $user = new User(
            '0',       // id
            $validator->get_name(),
            $validator->get_username(),
            password_hash($validator->get_password(), PASSWORD_DEFAULT),
            $validator->get_email(),
            '0',       // admin
            '0',       // active
            'null',    // company_id
            '',        // created_at
            ''         // updated_at
        );

        $user_inserted = UserRepository::insert(Connection::get_connection(), $user);

        if ($user_inserted) {
            Redirection::redirect(ROUTE_SUCCESSFUL_SIGNUP . '/' . $user->get_name());
        }
    }

    Connection::disconnect();
}

$title = 'Registrarte en Pytyv&#245;';

include_once 'templates/document-declaration.inc.php';
?>

<div class="container pt-5">
    <div class="row">
        <div class="col-md-3">
        </div>
        <div class="col-md-6 card p-0">
            <div class="card-header">
                <h4><b>Crea una cuenta</b></h4>
            </div>
            <div class="card-body">
                <form class="form" role="form" autocomplete="off" method="post" enctype="application/x-www-form-urlencoded" action="<?php echo ROUTE_SIGNUP; ?>">
                    <?php
                    if (isset($_POST['submit'])) {
                        include_once 'templates/signup-validated.inc.php';
                    } else {
                        include_once 'templates/signup-empty.inc.php';
                    }
                    ?>
                </form>
                <div class="row mt-3">
                    <div class="col-md-12 text-center">
                        <span>¿Ya tienes cuenta?</span>
                        <a href="<?php echo ROUTE_SIGNIN; ?>">Inicia sesi&#243;n</a>
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