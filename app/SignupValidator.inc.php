<?php

include_once 'app/UserRepository.inc.php';

class SignupValidator {

    private $notice_begin;
    private $notice_end;

    private $name;
    private $email;
    private $username;
    private $password;

    private $error_name;
    private $error_email;
    private $error_username;
    private $error_password1;
    private $error_password2;

    public function __construct($connection, $name, $email, $username, $password1, $password2) {
        $this->notice_begin = '<div class="alert alert-danger" role="alert" style="border-radius: 5px; font-size: 0.8rem; margin-top: 0.5rem; padding: 0.2rem;">';
        $this->notice_end = '</div>';

        $this->name = '';
        $this->email = '';
        $this->username = '';
        $this->password = '';

        $this->error_name = $this->validate_name($connection, $name);
        $this->error_email = $this->validate_email($connection, $email);
        $this->error_username = $this->validate_username($connection, $username);
        $this->error_password1 = $this->validate_password1($password1);
        $this->error_password2 = $this->validate_password2($password1, $password2);

        if ($this->error_password1 === '' && $this->error_password2 === '') {
            $this->password = $password1;
        }
    }

    private function variable_initiated($variable) {
        if (isset($variable) && !empty($variable)) {
            return true;
        } else {
            return false;
        }
    }

    private function validate_name($connection, $name) {
        if (!$this->variable_initiated($name)) {
            return 'Por favor, escribe tu nombre.';
        } else {
            $this->name = $name;
        }

        if (strlen($name) < 6) {
            return 'Tu nombre es demasiado corto.';
        }

        if (strlen($name) > 25) {
            return 'Tu nombre es demasiado largo.';
        }

        if (UserRepository::name_exists($connection, $name)) {
            return 'Este nombre ya est&#225; en uso. Elige otro.';
        }

        return '';
    }

    private function validate_email($connection, $email) {
        if (!$this->variable_initiated($email)) {
            return 'Por favor, escribe tu email.';
        } else {
            $this->email = $email;
        }

        if (UserRepository::email_exists($connection, $email)) {
            return 'Este email ya est&#225; en uso. Elige otro o <a href="#"> o intenta recuperar tu contrase&#241;a</a>.';
        }

        return '';
    }

    private function validate_username($connection, $username) {
        if (!$this->variable_initiated($username)) {
            return 'Por favor, escribe tu nombre de usuario.';
        } else {
            $this->username = $username;
        }

        if (strlen($username) < 6) {
            return 'Tu nombre de usuario es demasiado corto.';
        }

        if (strlen($username) > 25) {
            return 'Tu nombre de usuario es demasiado largo.';
        }

        if (UserRepository::username_exists($connection, $username)) {
            return 'Este nombre de usuario ya est&#225; en uso. Elige otro.';
        }

        return '';
    }

    private function validate_password1($password1) {
        if (!$this->variable_initiated($password1)) {
            return 'Ingresa una contrase&#241;a.';
        }

        return '';
    }

    private function validate_password2($password1, $password2) {
        if (!$this->variable_initiated($password1)) {
            return 'Primero debes ingresar una contrase&#241;a.';
        }

        if (!$this->variable_initiated($password2)) {
            return 'Confirma tu contrase&#241;a.';
        }

        if ($password1 !== $password2) {
            return 'Las contrase&#241;as no coinciden. Vuelve a intentarlo.';
        }

        return '';
    }

    public function get_name() {
        return $this->name;
    }

    public function get_email() {
        return $this->email;
    }

    public function get_username() {
        return $this->username;
    }

    public function get_password() {
        return $this->password;
    }

    public function get_error_name() {
        return $this->error_name;
    }

    public function get_error_email() {
        return $this->error_email;
    }

    public function get_error_username() {
        return $this->error_username;
    }

    public function get_error_password1() {
        return $this->error_password1;
    }

    public function get_error_password2() {
        return $this->error_password2;
    }

    public function show_name() {
        if ($this->name !== '') {
            echo 'value="' . $this->name . '"';
        }
    }

    public function show_error_name() {
        if ($this->error_name !== '') {
            echo $this->notice_begin . $this->error_name . $this->notice_end;
        }
    }

    public function show_email() {
        if ($this->email !== '') {
            echo 'value="' . $this->email . '"';
        }
    }

    public function show_error_email() {
        if ($this->error_email !== '') {
            echo $this->notice_begin . $this->error_email . $this->notice_end;
        }
    }

    public function show_username() {
        if ($this->username !== '') {
            echo 'value="' . $this->username . '"';
        }
    }

    public function show_error_username() {
        if ($this->error_username !== '') {
            echo $this->notice_begin . $this->error_username . $this->notice_end;
        }
    }

    public function show_error_password1() {
        if ($this->error_password1 !== '') {
            echo $this->notice_begin . $this->error_password1 . $this->notice_end;
        }
    }

    public function show_error_password2() {
        if ($this->error_password2 !== '') {
            echo $this->notice_begin . $this->error_password2 . $this->notice_end;
        }
    }

    public function is_valid() {
        if ($this->error_name === '' &&
                $this->error_email === '' &&
                $this->error_username === '' &&
                $this->error_password1 === '' &&
                $this->error_password2 === '') {
            return true;
        } else {
            return false;
        }
    }

}