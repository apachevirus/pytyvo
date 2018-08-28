<?php
header('Content-Type: application/json');

include_once 'app/core/config.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Connection.inc.php';
include_once 'app/modules/wo_brand/model/WOBrandRepository.inc.php';

if (!SessionControl::session_started()) {
    $answer = array('info' => array('ok' => false,
                                    'status' => 'failed',
                                    'message' => 'Access denied.'));
    die(json_encode($answer));
}

Connection::connect();

$rows = WOBrandRepository::get_all_active(
    Connection::get_connection(),
    $_SESSION['company_id']
);

Connection::disconnect();

$wo_brands = array();

foreach ($rows as $row) {
    $wo_brands[] = array('company_id' => (int) $row->get_company_id(),
                         'id' => (int) $row->get_id(),
                         'name' => $row->get_name(),
                         'active' => (bool) $row->is_active(),
                         'created_at' => $row->get_created_at(),
                         'updated_at' => $row->get_updated_at()
    );
}

$answer = array('results' => $wo_brands,
                'info' => array('ok' => true,
                                'status' => 'successful',
                                'results' => count($wo_brands),
                                'version' => '1.0'));
echo json_encode($answer);