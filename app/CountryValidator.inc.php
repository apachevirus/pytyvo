<?php

include_once 'app/BaseValidator.inc.php';

class CountryValidator extends BaseValidator {

    public function __construct($connection, $id, $name, $area_code, $active) {
        $this->repository = 'CountryRepository';

        $this->error_id = $this->validate_id($id)
        $this->error_name = $this->validate_name($connection, $name);
        $this->error_area_code = $this->validate_area_code($connection, $area_code);
        $this->error_active = $this->validate_active($connection, $active);
    }

}