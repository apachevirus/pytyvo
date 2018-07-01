<?php
include_once 'app/core/BaseValidator.inc.php';
include_once 'app/core/Utils.inc.php';
include_once 'CountryRepository.inc.php';

class CountryValidator extends BaseValidator {

    protected $area_code = '';
    protected $error_area_code = '';

    public function __construct($connection, $company_id, $id, $name, $area_code, $active) {
        $this->repository = 'CountryRepository';

        $this->error_company_id = $this->validate_company_id($connection, $company_id);
        $this->error_id = $this->validate_id($id);
        $this->error_name = $this->validate_name($connection, $this->company_id, $name);
        $this->error_area_code = $this->validate_area_code($connection, $this->company_id, $area_code);
        $this->error_active = $this->validate_active($active);
    }

    protected function validate_area_code($connection, $company_id, $area_code) {
        if (!$this->variable_initiated($area_code)) {
            return 'Por favor, escribe un prefijo telef&#243;nico.';
        } else {
            $this->area_code = Utils::alltrim(Utils::upper($area_code));
        }

        if (strlen($this->area_code) > 5) {
            return 'El prefijo telef&#243;nico es demasiado largo.';
        }

        if (!preg_match('/^([1-9]|[1-9][0-9]|[1-9][0-9][0-9])$/', $this->area_code)) {
            return 'El prefijo telef&#243;nico debe ser un n&#250;mero entre 1 y 999.';
        }

        if (is_int($this->id) && empty($this->id)) {
            if ($this->repository::area_code_exists($connection, $company_id, $this->area_code)) {
                return 'Este prefijo telef&#243;nico ya est&#225; en uso. Elige otro.';
            }
        } elseif (is_int($this->id) && !empty($this->id)) {
            $results = $this->repository::get_by_area_code($connection, $company_id, $this->area_code);

            if (count($results)) {
                foreach ($results as $row) {
                    if ((int) $row->get_id() !== $this->id) {
                        return 'Este prefijo telef&#243;nico ya est&#225; en uso. Elige otro.';
                    }
                }
            }
        }

        return '';
    }

    public function get_area_code() {
        return $this->area_code;
    }

    public function show_area_code() {
        if ($this->area_code !== '') {
            echo 'value="' . $this->area_code . '"';
        }
    }

    public function get_error_area_code() {
        return $this->error_area_code;
    }

    public function show_error_area_code() {
        if ($this->error_area_code !== '') {
            echo $this->notice_begin . $this->error_area_code . $this->notice_end;
        }
    }

    public function is_valid() {
        if (parent::is_valid() && $this->error_area_code === '') {
            return true;
        } else {
            return false;
        }
    }

}
?>