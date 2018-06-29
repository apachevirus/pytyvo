<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';
include_once 'app/core/Connection.inc.php';
include_once 'app/modules/company/model/CompanyRepository.inc.php';
include_once dirname(__DIR__) . '/model/SigninValidator.inc.php';

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

include_once 'template/document-declaration.inc.phtml';
include_once dirname(__DIR__) . '/view/signin.inc.phtml';
include_once 'template/document-close.inc.phtml';
?>