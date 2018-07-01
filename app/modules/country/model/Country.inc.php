<?php
include_once 'app/core/BaseModel.inc.php';

class Country extends BaseModel {

    private $area_code;

    public function __construct($company_id, $id, $name, $area_code, $active, $created_at, $updated_at) {
        parent::__construct($company_id, $id, $name, $active, $created_at, $updated_at);
        $this->area_code = $area_code;
    }

    public function get_area_code() {
        return $this->area_code;
    }

    public function set_area_code($area_code) {
        $this->area_code = $area_code;
    }

}
?>