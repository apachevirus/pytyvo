<?php
include_once 'app/core/BaseValidator.inc.php';
include_once 'app/core/Utils.inc.php';
include_once 'app/modules/machine/model/MachineRepository.inc.php';
include_once 'app/modules/wo_brand/model/WOBrandRepository.inc.php';
include_once 'ModelRepository.inc.php';

class ModelValidator extends BaseValidator {

    private $machine_id = 0;
    private $brand_id = 0;

    private $error_machine_id = '';
    private $error_brand_id = '';

    public function __construct($connection, $company_id, $id, $name, $machine_id, $brand_id, $active) {
        $this->repository = 'ModelRepository';

        $this->error_company_id = $this->validate_company_id($connection, $company_id);
        $this->error_id = $this->validate_id($id);
        $this->error_machine_id = $this->validate_machine_id($connection, $this->company_id, $machine_id);
        $this->error_brand_id = $this->validate_brand_id($connection, $this->company_id, $brand_id);
        $this->error_name = $this->validate_name($connection, $this->company_id, $name, $this->machine_id, $this->brand_id);
        $this->error_active = $this->validate_active($active);
    }

    private function validate_machine_id($connection, $company_id, $machine_id) {
        if (!isset($machine_id) || !is_int($machine_id)) {
            return 'Por favor, selecciona una m&#225;quina.';
        } else {
            $this->machine_id = $machine_id;
        }

        if ($machine_id < 0) {
            return 'El c&#243;digo de la m&#225;quina debe ser mayor que cero.';
        }

        if ($machine_id > 16777215) {
            return 'El c&#243;digo de la m&#225;quina debe ser menor a 16777215.';
        }

        if (!MachineRepository::id_exists($connection, $company_id, $this->machine_id)) {
            return 'El c&#243;digo de la m&#225;quina no existe.';
        }

        if (!MachineRepository::is_active($connection, $company_id, $this->machine_id)) {
            return 'El c&#243;digo de la m&#225;quina no est&#225; vigente.';
        }

        return '';
    }

    private function validate_brand_id($connection, $company_id, $brand_id) {
        if (!isset($brand_id) || !is_int($brand_id)) {
            return 'Por favor, selecciona una marca.';
        } else {
            $this->brand_id = $brand_id;
        }

        if ($brand_id < 0) {
            return 'El c&#243;digo de la marca debe ser mayor que cero.';
        }

        if ($brand_id > 16777215) {
            return 'El c&#243;digo de la marca debe ser menor a 16777215.';
        }

        if (!WOBrandRepository::id_exists($connection, $company_id, $this->brand_id)) {
            return 'El c&#243;digo de la marca no existe.';
        }

        if (!WOBrandRepository::is_active($connection, $company_id, $this->brand_id)) {
            return 'El c&#243;digo de la marca no est&#225; vigente.';
        }

        return '';
    }

    public function __call($method, $arguments) {
        if ($method == 'validate_name') {
            if (count($arguments) == 5 || count($arguments) == 6) {
                $connection = $arguments[0];
                $company_id = $arguments[1];
                $name = $arguments[2];
                $machine_id = $arguments[3];
                $brand_id = $arguments[4];
                $options = count($arguments) == 5 ? null : $arguments[5];

                $min = isset($options['min']) ? $options['min'] : 2;
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
                    if ($this->repository::name_exists($connection, $company_id, $this->name, $machine_id, $brand_id)) {
                        return 'Este nombre ya est&#225; en uso. Elige otro.';
                    }
                } elseif (is_int($this->id) && !empty($this->id)) {
                    $results = $this->repository::get_by_name($connection, $company_id, $this->name, $machine_id, $brand_id);

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

    // protected function validate_name($connection, $company_id, $name, $machine_id, $brand_id) {
    //     if (!$this->variable_initiated($name)) {
    //         return 'Por favor, escribe un nombre.';
    //     } else {
    //         $this->name = Utils::alltrim(Utils::upper($name));
    //     }

    //     if (strlen($this->name) < 2) {
    //         return 'El nombre es demasiado corto.';
    //     }

    //     if (strlen($this->name) > 50) {
    //         return 'El nombre es demasiado largo.';
    //     }

    //     if (is_int($this->id) && empty($this->id)) {
    //         if ($this->repository::name_exists($connection, $company_id, $this->name, $machine_id, $brand_id)) {
    //             return 'Este nombre ya est&#225; en uso. Elige otro.';
    //         }
    //     } elseif (is_int($this->id) && !empty($this->id)) {
    //         $results = $this->repository::get_by_name($connection, $company_id, $this->name, $machine_id, $brand_id);

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

    public function get_machine_id() {
        return $this->machine_id;
    }

    public function get_brand_id() {
        return $this->brand_id;
    }

    public function show_machine_id() {
        if ($this->machine_id !== '') {
            echo 'value="' . $this->machine_id . '"';
        }
    }

    public function show_brand_id() {
        if ($this->brand_id !== '') {
            echo 'value="' . $this->brand_id . '"';
        }
    }

    public function get_error_machine_id() {
        return $this->error_machine_id;
    }

    public function get_error_brand_id() {
        return $this->error_brand_id;
    }

    public function show_error_machine_id() {
        if ($this->error_machine_id !== '') {
            echo $this->notice_begin . $this->error_machine_id . $this->notice_end;
        }
    }

    public function show_error_brand_id() {
        if ($this->error_brand_id !== '') {
            echo $this->notice_begin . $this->error_brand_id . $this->notice_end;
        }
    }

    public function is_valid() {
        if (parent::is_valid() &&
                $this->error_machine_id === '' &&
                $this->error_brand_id === '') {
            return true;
        } else {
            return false;
        }
    }

}
?>