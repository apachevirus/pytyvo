<?php
include_once 'app/core/DefaultModel.inc.php';

class Company extends DefaultModel {

    private $tin;

    public function __construct($id, $name, $tin, $active, $created_at, $updated_at) {
        parent::__construct($id, $name, $active, $created_at, $updated_at);
        $this->tin = $tin;
    }

    public function get_tin() {
        return $this->tin;
    }

    public function set_tin($tin) {
        $this->tin = $tin;
    }

}
?>