<?php
include_once 'app/core/BaseValidator.inc.php';
include_once 'app/core/Utils.inc.php';
include_once 'WOStatusRepository.inc.php';

class WOStatusValidator extends BaseValidator {

    public function __construct($connection, $company_id, $id, $name, $active) {
        $this->repository = 'WOStatusRepository';

        $this->error_company_id = $this->validate_company_id($connection, $company_id);
        $this->error_id = $this->validate_id($id);
        $this->error_name = $this->validate_name($connection, $this->company_id, $name);
        $this->error_active = $this->validate_active($active);
    }

}
?>