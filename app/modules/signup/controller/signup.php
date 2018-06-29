<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/Connection.inc.php';
include_once 'app/core/Redirection.inc.php';
include_once 'app/modules/user/model/User.inc.php';
include_once 'app/modules/user/model/UserRepository.inc.php';
include_once dirname(__DIR__) . '/model/SignupValidator.inc.php';

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

include_once 'template/document-declaration.inc.phtml';
include_once dirname(__DIR__) . '/view/signup.inc.phtml';
include_once 'template/document-close.inc.phtml';
?>