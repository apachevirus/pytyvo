<?php
include_once 'app/core/BaseValidator.inc.php';
include_once 'app/core/Utils.inc.php';
include_once 'FamilyRepository.inc.php';

class FamilyValidator extends BaseValidator {

    private $p1 = 0;
    private $p2 = 0;
    private $p3 = 0;
    private $p4 = 0;
    private $p5 = 0;

    private $error_p1 = '';
    private $error_p2 = '';
    private $error_p3 = '';
    private $error_p4 = '';
    private $error_p5 = '';

    public function __construct($connection, $company_id, $id, $name, $p1, $p2, $p3, $p4, $p5, $active) {
        $this->repository = 'FamilyRepository';

        $this->error_company_id = $this->validate_company_id($connection, $company_id);
        $this->error_id = $this->validate_id($id);
        $this->error_name = $this->validate_name($connection, $this->company_id, $name);
        $this->error_p1 = $this->validate_percentage($p1, 1);
        $this->error_p2 = $this->validate_percentage($p2, 2);
        $this->error_p3 = $this->validate_percentage($p3, 3);
        $this->error_p4 = $this->validate_percentage($p4, 4);
        $this->error_p5 = $this->validate_percentage($p5, 5);
        $this->error_active = $this->validate_active($active);
    }

    private function validate_percentage($percentage, $list) {
        if (!$this->variable_initiated($list)) {
            return 'Por favor, escribe un n&#250;mero de lista.';
        } elseif (!is_int($list)) {
            return 'Por favor, escribe un n&#250;mero de lista que sea de tipo entero.';
        } elseif ($list < 1 || $list > 5) {
            return 'El n&#250;mero de lista debe ser un valor entre 1 y 5.';
        }

        if (!isset($percentage) || !is_float($percentage)) {
            return 'Por favor, escribe el porcentaje para la lista ' . $list . '.';
        } else {
            switch ($list) {
                case 1:
                    $this->p1 = $percentage;
                    break;
                case 2:
                    $this->p2 = $percentage;
                    break;
                case 3:
                    $this->p3 = $percentage;
                    break;
                case 4:
                    $this->p4 = $percentage;
                    break;
                case 5:
                    $this->p5 = $percentage;
                    break;
            }
        }

        if ($percentage < 0) {
            return 'El porcentaje para la lista ' . $list . ' debe ser mayor o igual a cero.';
        }

        if ($percentage > 1000) {
            return 'El porcentaje para la lista ' . $list . ' debe ser menor a 1 mil.';
        }

        return '';
    }

    public function get_percentage($list) {
        if (!$this->variable_initiated($list)) {
            return 'Por favor, escribe un n&#250;mero de lista.';
        } elseif (!is_int($list)) {
            return 'Por favor, escribe un n&#250;mero de lista que sea de tipo entero.';
        } elseif ($list < 1 || $list > 5) {
            return 'El n&#250;mero de lista debe ser un valor entre 1 y 5.';
        }

        $percentage = 0;

        switch ($list) {
            case 1:
                $percentage = $this->p1;
                break;
            case 2:
                $percentage = $this->p2;
                break;
            case 3:
                $percentage = $this->p3;
                break;
            case 4:
                $percentage = $this->p4;
                break;
            case 5:
                $percentage = $this->p5;
                break;
        }

        return $percentage;
    }

    public function show_percentage($list) {
        if (!$this->variable_initiated($list)) {
            return 'Por favor, escribe un n&#250;mero de lista.';
        } elseif (!is_int($list)) {
            return 'Por favor, escribe un n&#250;mero de lista que sea de tipo entero.';
        } elseif ($list < 1 || $list > 5) {
            return 'El n&#250;mero de lista debe ser un valor entre 1 y 5.';
        }

        switch ($list) {
            case 1:
                echo 'value="' . $this->p1 . '"';
                break;
            case 2:
                echo 'value="' . $this->p2 . '"';
                break;
            case 3:
                echo 'value="' . $this->p3 . '"';
                break;
            case 4:
                echo 'value="' . $this->p4 . '"';
                break;
            case 5:
                echo 'value="' . $this->p5 . '"';
                break;
        }
    }

    public function get_error_percentage($list) {
        if (!$this->variable_initiated($list)) {
            return 'Por favor, escribe un n&#250;mero de lista.';
        } elseif (!is_int($list)) {
            return 'Por favor, escribe un n&#250;mero de lista que sea de tipo entero.';
        } elseif ($list < 1 || $list > 5) {
            return 'El n&#250;mero de lista debe ser un valor entre 1 y 5.';
        }

        $error = '';

        switch ($list) {
            case 1:
                $error = $this->error_p1;
                break;
            case 2:
                $error = $this->error_p2;
                break;
            case 3:
                $error = $this->error_p3;
                break;
            case 4:
                $error = $this->error_p4;
                break;
            case 5:
                $error = $this->error_p5;
                break;
        }

        return $error;
    }

    public function show_error_percentage($list) {
        if (!$this->variable_initiated($list)) {
            return 'Por favor, escribe un n&#250;mero de lista.';
        } elseif (!is_int($list)) {
            return 'Por favor, escribe un n&#250;mero de lista que sea de tipo entero.';
        } elseif ($list < 1 || $list > 5) {
            return 'El n&#250;mero de lista debe ser un valor entre 1 y 5.';
        }

        switch ($list) {
            case 1:
                if ($this->error_p1 !== '') {
                    echo $this->notice_begin . $this->error_p1 . $this->notice_end;
                }
                break;
            case 2:
                if ($this->error_p2 !== '') {
                    echo $this->notice_begin . $this->error_p2 . $this->notice_end;
                }
                break;
            case 3:
                if ($this->error_p3 !== '') {
                    echo $this->notice_begin . $this->error_p3 . $this->notice_end;
                }
                break;
            case 4:
                if ($this->error_p4 !== '') {
                    echo $this->notice_begin . $this->error_p4 . $this->notice_end;
                }
                break;
            case 5:
                if ($this->error_p5 !== '') {
                    echo $this->notice_begin . $this->error_p5 . $this->notice_end;
                }
                break;
        }
    }

    public function is_valid() {
        if (parent::is_valid() &&
                $this->error_p1 === '' &&
                $this->error_p2 === '' &&
                $this->error_p3 === '' &&
                $this->error_p4 === '' &&
                $this->error_p5 === '') {
            return true;
        } else {
            return false;
        }
    }

}
?>