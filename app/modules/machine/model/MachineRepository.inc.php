<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'Machine.inc.php';

class MachineRepository extends BaseRepository {

    protected static $table = 'machine';

    public static function get_all($connection, $company_id) {
        $machines = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $machines[] = new Machine(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $machines;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $machines = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $machines[] = new Machine(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $machines;
    }

    public static function get_all_active($connection, $company_id) {
        $machines = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $machines[] = new Machine(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $machines;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $machine = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $machine = new Machine(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $machine;
    }

    public static function get_by_name($connection, $company_id, $name) {
        $machines = array();

        $results = parent::get_by_name($connection, $company_id, $name);

        if (count($results)) {
            foreach ($results as $row) {
                $machines[] = new Machine(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $machines;
    }

    public static function get_by_any($connection, $company_id, $any) {
        $machines = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $machines[] = new Machine(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $machines;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $machines = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $machines[] = new Machine(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $machines;
    }

}
?>