<?php

class User {

    private $id;
    private $name;
    private $username;
    private $password;
    private $email;
    private $admin;
    private $active;
    private $company_id;
    private $created_at;
    private $updated_at;

    public function __construct($id, $name, $username, $password, $email, $admin, $active, $company_id, $created_at, $updated_at) {
        $this->id = $id;
        $this->name = $name;
        $this->username = $username;
        $this->password = $password;
        $this->email = $email;
        $this->admin = $admin;
        $this->active = $active;
        $this->company_id = $company_id;
        $this->created_at = $created_at;
        $this->updated_at = $updated_at;
    }

    public function get_id() {
        return $this->id;
    }

    public function get_name() {
        return $this->name;
    }

    public function set_name($name) {
        $this->name = $name;
    }

    public function get_username() {
        return $this->username;
    }

    public function get_password() {
        return $this->password;
    }

    public function set_password($password) {
        $this->password = $password;
    }

    public function get_email() {
        return $this->email;
    }

    public function set_email($email) {
        $this->email = $email;
    }

    public function is_admin() {
        return $this->admin;
    }

    public function is_active() {
        return $this->active;
    }

    public function set_active($active) {
        $this->active = $active;
    }

    public function get_company_id() {
        return $this->company_id;
    }

    public function set_company_id($company_id) {
        $this->company_id = $company_id;
    }

    public function get_created_at() {
        return $this->created_at;
    }

    public function get_updated_at() {
        return $this->updated_at;
    }

}