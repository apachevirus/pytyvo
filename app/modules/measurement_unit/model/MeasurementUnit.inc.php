<?php
include_once 'app/core/BaseModel.inc.php';

class MeasurementUnit extends BaseModel {

    private $symbol;
    private $divisible;

    public function __construct($company_id, $id, $name, $symbol, $divisible, $active, $created_at, $updated_at) {
        parent::__construct($company_id, $id, $name, $active, $created_at, $updated_at);
        $this->symbol = $symbol;
        $this->divisible = $divisible;
    }

    public function get_symbol() {
        return $this->symbol;
    }

    public function set_symbol($symbol) {
        $this->symbol = $symbol;
    }

    public function is_divisible() {
        return $this->divisible;
    }

    public function set_divisible($divisible) {
        $this->divisible = $divisible;
    }

}
?>