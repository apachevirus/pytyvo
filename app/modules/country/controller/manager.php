<?php
include_once 'app/core/config.inc.php';
include_once 'app/core/functions.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Redirection.inc.php';
include_once 'app/core/Connection.inc.php';
include_once 'app/core/Utils.inc.php';
include_once dirname(__DIR__) . '/model/CountryRepository.inc.php';

if (!SessionControl::session_started()) {
    Redirection::redirect(ROUTE_SIGNIN);
}

# begin { variables and constants setup }
$entity = 'country';
$entity_repository = ucfirst($entity) . 'Repository';
$entity_search = strtolower($entity) . '_search';
$entity_page = strtolower($entity) . '_page';
$title = 'Gesti&#243;n de pa&#237;ses';

define('ROUTE_MANAGER', ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY_MANAGER);
define('ROUTE_MAINTAIN', ROUTE_ADMINISTRATION_SETUP_GENERAL_COUNTRY_MAINTAIN);
# end { variables and constants setup }

# begin { declares or retrieves the entity_search and entity_page cookies }
${$entity_search} = '';
${$entity_page} = 1;

if (isset($_POST['search'])) {
    ${$entity_search} = $_POST['search'];
} else {
    if (isset($_COOKIE[$entity_search])) {
        ${$entity_search} = $_COOKIE[$entity_search];
    }
}

if (isset($page))  {
    ${$entity_page} = $page;
} else {
    if (isset($_COOKIE[$entity_page])) {
        ${$entity_page} = $_COOKIE[$entity_page];
    }
}

setcookie($entity_search, ${$entity_search}, time() + (86400 * 30), '/');    // 86400 = 1 day.
setcookie($entity_page, ${$entity_page}, time() + (86400 * 30), '/');    // 86400 = 1 day.

$_COOKIE[$entity_search] = ${$entity_search};
$_COOKIE[$entity_page] = ${$entity_page};

$page = (int) ${$entity_page};
# end { declares or retrieves the entity_search and entity_page cookies }

Connection::connect();

if (!empty(${$entity_search})) {
    $any = Utils::prepare_for_search(${$entity_search});

    $reccount = $entity_repository::get_by_any_reccount(
        Connection::get_connection(),
        $_SESSION['company_id'],
        $any
    );
} else {
    $reccount = $entity_repository::get_reccount(
        Connection::get_connection(),
        $_SESSION['company_id']
    );
}

# begin { pagination variables }
$per_page = 7;
$start = ($page - 1) * $per_page;
$total = ceil($reccount / $per_page);

if ($page > $total) {
    $page = (int) 1;
    $start = 0;

    setcookie($entity_page, $page, time() + (86400 * 30), '/');    // 86400 = 1 day.
    $_COOKIE[$entity_page] = $page;
}
# end { pagination variables }

if (!empty(${$entity_search})) {
    $any = Utils::prepare_for_search(${$entity_search});

    $rows = $entity_repository::get_by_any_with_limit_and_offset(
        Connection::get_connection(),
        $_SESSION['company_id'],
        $any,
        $start,
        $per_page
    );
} else {
    $rows = $entity_repository::get_all_with_limit_and_offset(
        Connection::get_connection(),
        $_SESSION['company_id'],
        $start,
        $per_page
    );
}

Connection::disconnect();

include_once 'template/document-declaration.inc.phtml';
include_once 'template/navbar.inc.phtml';
include_once dirname(__DIR__) . '/view/manager.inc.phtml';
include_once 'template/document-close.inc.phtml';
?>