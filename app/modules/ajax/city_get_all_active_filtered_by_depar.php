<?php
header('Content-Type: application/json');

include_once 'app/core/config.inc.php';
include_once 'app/core/functions.inc.php';
include_once 'app/core/SessionControl.inc.php';
include_once 'app/core/Connection.inc.php';
include_once 'app/modules/city/model/CityRepository.inc.php';

if (!SessionControl::session_started()) {
    $answer = array('info' => array('ok' => false,
                                    'status' => 'failed',
                                    'message' => 'Access denied.'));
    die(json_encode($answer));
}

// begin { validate: depar_id }
if (!isset($_GET['depar_id'])) {
    $answer = array('info' => array('ok' => false,
                                    'status' => 'failed',
                                    'message' => 'Invalid department ID.'));
    die(json_encode($answer));
} else {
    $depar_id = (int) $_GET['depar_id'];

    if ($depar_id <= 0 || $depar_id > 16777215) {
        $answer = array('info' => array('ok' => false,
                                        'status' => 'failed',
                                        'message' => 'Invalid department ID.'));
        die(json_encode($answer));
    }
}
// end { validate: depar_id }

Connection::connect();

$rows = CityRepository::get_all_active_filtered_by_depar(
    Connection::get_connection(),
    $_SESSION['company_id'],
    $depar_id
);

Connection::disconnect();

$cities = array();

foreach ($rows as $row) {
    $cities[] = array('company_id' => (int) $row->get_company_id(),
                      'id' => (int) $row->get_id(),
                      'name' => $row->get_name(),
                      'depar_id' => (int) $row->get_depar_id(),
                      'active' => (bool) $row->is_active(),
                      'created_at' => $row->get_created_at(),
                      'updated_at' => $row->get_updated_at()
    );
}

$answer = array('results' => $cities,
                'info' => array('ok' => true,
                                'status' => 'successful',
                                'results' => count($cities),
                                'version' => '1.0'));
echo json_encode($answer);