<?php
include_once 'app/core/BaseValidator.inc.php';
include_once 'app/core/Utils.inc.php';
include_once 'MeasurementUnitRepository.inc.php';

class MeasurementUnitValidator extends BaseValidator {

    private $symbol = '';
    private $divisible = 0;

    private $error_symbol = '';
    private $error_divisible = '';

    public function __construct($connection, $company_id, $id, $name, $symbol, $divisible, $active) {
        $this->repository = 'MeasurementUnitRepository';

        $this->error_company_id = $this->validate_company_id($connection, $company_id);
        $this->error_id = $this->validate_id($id);
        $this->error_name = $this->validate_name($connection, $this->company_id, $name);
        $this->error_symbol = $this->validate_symbol($connection, $this->company_id, $symbol);
        $this->error_divisible = $this->validate_divisible($divisible);
        $this->error_active = $this->validate_active($active);
    }

    private function validate_symbol($connection, $company_id, $symbol) {
        if (!$this->variable_initiated($symbol)) {
            return 'Por favor, escribe un s&#237;mbolo.';
        } else {
            $this->symbol = Utils::alltrim(Utils::upper($symbol));
        }

        if (strlen($this->symbol) > 5) {
            return 'El s&#237;mbolo es demasiado largo.';
        }

        if (is_int($this->id) && empty($this->id)) {
            if ($this->repository::symbol_exists($connection, $company_id, $this->symbol)) {
                return 'Este s&#237;mbolo ya est&#225; en uso. Elige otro.';
            }
        } elseif (is_int($this->id) && !empty($this->id)) {
            $results = $this->repository::get_by_symbol($connection, $company_id, $this->symbol);

            if (count($results)) {
                foreach ($results as $row) {
                    if ((int) $row->get_id() !== $this->id) {
                        return 'Este s&#237;mbolo ya est&#225; en uso. Elige otro.';
                    }
                }
            }
        }

        return '';
    }

    private function validate_divisible($divisible) {
        if (!isset($divisible) || !is_bool($divisible)) {
            return 'Por favor, escribe si es divisible.';
        } else {
            $this->divisible = $divisible;
        }

        if ($divisible < 0 || $divisible > 1) {
            return 'La divisibilidad est&#225; determinada por un valor entre 0 y 1.';
        }

        return '';
    }

    public function get_symbol() {
        return $this->symbol;
    }

    public function is_divisible() {
        return $this->divisible;
    }

    public function show_symbol() {
        if ($this->symbol !== '') {
            echo 'value="' . $this->symbol . '"';
        }
    }

    public function show_divisible() {
        if ($this->divisible) {
            echo 'checked';
        }
    }

    public function get_error_symbol() {
        return $this->error_symbol;
    }

    public function get_error_divisible() {
        return $this->error_divisible;
    }

    public function show_error_symbol() {
        if ($this->error_symbol !== '') {
            echo $this->notice_begin . $this->error_symbol . $this->notice_end;
        }
    }

    public function show_error_divisible() {
        if ($this->error_divisible !== '') {
            echo $this->notice_begin . $this->error_divisible . $this->notice_end;
        }
    }

    public function is_valid() {
        if (parent::is_valid() &&
                $this->error_symbol === '' &&
                $this->error_divisible === '') {
            return true;
        } else {
            return false;
        }
    }

}
?>