<?php
include_once 'app/core/BaseValidator.inc.php';
include_once 'app/core/Utils.inc.php';
include_once 'app/modules/depar/model/DeparRepository.inc.php';
include_once 'CityRepository.inc.php';

class CityValidator extends BaseValidator {

    private $depar_id = 0;
    private $error_depar_id = '';

    public function __construct($connection, $company_id, $id, $name, $depar_id, $active) {
        $this->repository = 'CityRepository';

        $this->error_company_id = $this->validate_company_id($connection, $company_id);
        $this->error_id = $this->validate_id($id);
        $this->error_depar_id = $this->validate_depar_id($connection, $this->company_id, $depar_id);
        $this->error_name = $this->validate_name($connection, $this->company_id, $name, $this->depar_id);
        $this->error_active = $this->validate_active($active);
    }

    private function validate_depar_id($connection, $company_id, $depar_id) {
        if (!isset($depar_id) || !is_int($depar_id)) {
            return 'Por favor, selecciona un departamento.';
        } else {
            $this->depar_id = $depar_id;
        }

        if ($depar_id < 0) {
            return 'El c&#243;digo del departamento debe ser mayor que cero.';
        }

        if ($depar_id > 16777215) {
            return 'El c&#243;digo del departamento debe ser menor a 16777215.';
        }

        if (!DeparRepository::id_exists($connection, $company_id, $this->depar_id)) {
            return 'El c&#243;digo del departamento no existe.';
        }

        if (!DeparRepository::is_active($connection, $company_id, $this->depar_id)) {
            return 'El c&#243;digo del departamento no est&#225; vigente.';
        }

        return '';
    }

    public function __call($method, $arguments) {
        if ($method == 'validate_name') {
            if (count($arguments) == 4 || count($arguments) == 5) {
                $connection = $arguments[0];
                $company_id = $arguments[1];
                $name = $arguments[2];
                $depar_id = $arguments[3];
                $options = count($arguments) == 4 ? null : $arguments[4];

                $min = isset($options['min']) ? $options['min'] : 3;
                $max = isset($options['max']) ? $options['max'] : 50;

                if (!$this->variable_initiated($name)) {
                    return 'Por favor, escribe un nombre.';
                } else {
                    $this->name = Utils::alltrim(Utils::upper($name));
                }

                if (strlen($this->name) < $min) {
                    return 'El nombre es demasiado corto.';
                }

                if (strlen($this->name) > $max) {
                    return 'El nombre es demasiado largo.';
                }

                if (is_int($this->id) && empty($this->id)) {
                    if ($this->repository::name_exists($connection, $company_id, $this->name, $depar_id)) {
                        return 'Este nombre ya est&#225; en uso. Elige otro.';
                    }
                } elseif (is_int($this->id) && !empty($this->id)) {
                    $results = $this->repository::get_by_name($connection, $company_id, $this->name, $depar_id);

                    if (count($results)) {
                        foreach ($results as $row) {
                            if ((int) $row->get_id() !== $this->id) {
                                return 'Este nombre ya est&#225; en uso. Elige otro.';
                            }
                        }
                    }
                }

                return '';
            }
        }
    }

    // protected function validate_name($connection, $company_id, $name, $depar_id) {
    //     if (!$this->variable_initiated($name)) {
    //         return 'Por favor, escribe un nombre.';
    //     } else {
    //         $this->name = Utils::alltrim(Utils::upper($name));
    //     }

    //     if (strlen($this->name) < 3) {
    //         return 'El nombre es demasiado corto.';
    //     }

    //     if (strlen($this->name) > 50) {
    //         return 'El nombre es demasiado largo.';
    //     }

    //     if (is_int($this->id) && empty($this->id)) {
    //         if ($this->repository::name_exists($connection, $company_id, $this->name, $depar_id)) {
    //             return 'Este nombre ya est&#225; en uso. Elige otro.';
    //         }
    //     } elseif (is_int($this->id) && !empty($this->id)) {
    //         $results = $this->repository::get_by_name($connection, $company_id, $this->name, $depar_id);

    //         if (count($results)) {
    //             foreach ($results as $row) {
    //                 if ((int) $row->get_id() !== $this->id) {
    //                     return 'Este nombre ya est&#225; en uso. Elige otro.';
    //                 }
    //             }
    //         }
    //     }

    //     return '';
    // }

    public function get_depar_id() {
        return $this->depar_id;
    }

    public function show_depar_id() {
        if ($this->depar_id !== '') {
            echo 'value="' . $this->depar_id . '"';
        }
    }

    public function get_error_depar_id() {
        return $this->error_depar_id;
    }

    public function show_error_depar_id() {
        if ($this->error_depar_id !== '') {
            echo $this->notice_begin . $this->error_depar_id . $this->notice_end;
        }
    }

    public function is_valid() {
        if (parent::is_valid() &&
                $this->error_depar_id === '') {
            return true;
        } else {
            return false;
        }
    }

}
?>