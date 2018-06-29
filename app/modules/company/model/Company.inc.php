<?php

class Company {

    private $id;
    private $name;
    private $tin;
    private $active;
    private $created_at;
    private $updated_at;

    public function __construct($id, $name, $tin, $active, $created_at, $updated_at) {
        $this->id = $id;
        $this->name = $name;
        $this->tin = $tin;
        $this->active = $active;
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

    public function get_tin() {
        return $this->tin;
    }

    public function set_tin($tin) {
        $this->tin = $tin;
    }

    public function is_active() {
        return $this->active;
    }

    public function set_active($active) {
        $this->active = $active;
    }

    public function get_created_at() {
        return $this->created_at;
    }

    public function get_updated_at() {
        return $this->updated_at;
    }

}