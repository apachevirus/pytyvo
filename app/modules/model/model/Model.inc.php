<?php
include_once 'app/core/BaseModel.inc.php';

class Model extends BaseModel {

    private $machine_id;
    private $brand_id;
    private $full_name;

    public function __construct($company_id, $id, $name, $machine_id, $brand_id, $full_name, $active, $created_at, $updated_at) {
        parent::__construct($company_id, $id, $name, $active, $created_at, $updated_at);
        $this->machine_id = $machine_id;
        $this->brand_id = $brand_id;
        $this->full_name = $full_name;
    }

    public function get_machine_id() {
        return $this->machine_id;
    }

    public function set_machine_id($machine_id) {
        $this->machine_id = $machine_id;
    }

    public function get_brand_id() {
        return $this->brand_id;
    }

    public function set_brand_id($brand_id) {
        $this->brand_id = $brand_id;
    }

    public function get_full_name() {
        return $this->full_name;
    }

    public function set_full_name($full_name) {
        $this->full_name = $full_name;
    }

}
?>