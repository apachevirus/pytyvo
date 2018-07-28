<?php
include_once 'app/core/BaseModel.inc.php';

class Family extends BaseModel {

    private $p1;
    private $p2;
    private $p3;
    private $p4;
    private $p5;

    public function __construct($company_id, $id, $name, $p1, $p2, $p3, $p4, $p5, $active, $created_at, $updated_at) {
        parent::__construct($company_id, $id, $name, $active, $created_at, $updated_at);
        $this->p1 = $p1;
        $this->p2 = $p2;
        $this->p3 = $p3;
        $this->p4 = $p4;
        $this->p5 = $p5;
    }

    public function get_p1() {
        return $this->p1;
    }

    public function set_p1($p1) {
        $this->p1 = $p1;
    }

    public function get_p2() {
        return $this->p2;
    }

    public function set_p2($p2) {
        $this->p2 = $p2;
    }

    public function get_p3() {
        return $this->p3;
    }

    public function set_p3($p3) {
        $this->p3 = $p3;
    }

    public function get_p4() {
        return $this->p4;
    }

    public function set_p4($p4) {
        $this->p4 = $p4;
    }

    public function get_p5() {
        return $this->p5;
    }

    public function set_p5($p5) {
        $this->p5 = $p5;
    }

}
?>