<?php
include_once 'app/core/BaseModel.inc.php';

class Neighborhood extends BaseModel {

    private $depar_id;
    private $city_id;
    private $full_name;

    public function __construct($company_id, $id, $name, $depar_id, $city_id, $full_name, $active, $created_at, $updated_at) {
        parent::__construct($company_id, $id, $name, $active, $created_at, $updated_at);
        $this->depar_id = $depar_id;
        $this->city_id = $city_id;
        $this->full_name = $full_name;
    }

    public function get_depar_id() {
        return $this->depar_id;
    }

    public function set_depar_id($depar_id) {
        $this->depar_id = $depar_id;
    }

    public function get_city_id() {
        return $this->city_id;
    }

    public function set_city_id($city_id) {
        $this->city_id = $city_id;
    }

    public function get_full_name() {
        return $this->full_name;
    }

    public function set_full_name($full_name) {
        $this->full_name = $full_name;
    }

}
?>