<?php

include_once 'UserRepository.inc.php';

class SigninValidator {

    private $user;
    private $token;
    private $error;

    public function __construct($connection, $username, $password, $token) {
        $this->error = "";

        if (!$this->variable_initiated($username) || !$this->variable_initiated($password) || !$this->variable_initiated($token)) {
            $this->user = null;
            $this->token = null;
            $this->error = "Debe ingresar su nombre de usuario y contrase&#241;a.";
        } else {
            $this->user = UserRepository::get_by_username($connection, $username);
            $this->token = $token;

            if (is_null($this->user) || !password_verify($password, $this->user->get_password())) {
                $this->error = "Nombre de usuario o contrase&#241;a incorrectos.";
            } else if (!$this->user->is_active()) {
                    $this->error = "La cuenta que intentas utilizar est&#225; bloqueda.";
            }
        }
    }

    private function variable_initiated($variable) {
        if (isset($variable) && !empty($variable)) {
            return true;
        } else {
            return false;
        }
    }

    public function get_user() {
        return $this->user;
    }

    public function get_token() {
        return $this->token;
    }

    public function get_error() {
        return $this->error;
    }

    public function show_error() {
        if ($this->error !== '') {
            echo '<div class="alert alert-danger" role="alert" style="border-radius: 5px; font-size: 0.8rem; margin-top: 0.5rem; padding: 0.2rem;">';
            echo $this->error;
            echo '</div>';
        }
    }
}