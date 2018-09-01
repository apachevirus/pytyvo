<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'Depar.inc.php';

class DeparRepository extends BaseRepository {

    protected static $table = 'depar';

    public static function get_all($connection, $company_id) {
        $depars = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $depars[] = new Depar(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $depars;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $depars = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $depars[] = new Depar(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $depars;
    }

    public static function get_all_active($connection, $company_id) {
        $depars = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $depars[] = new Depar(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $depars;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $depar = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $depar = new Depar(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $depar;
    }

    public static function get_by_name($connection, $company_id, $name) {
        $depars = array();

        $results = parent::get_by_name($connection, $company_id, $name);

        if (count($results)) {
            foreach ($results as $row) {
                $depars[] = new Depar(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $depars;
    }

    public static function get_by_any($connection, $company_id, $any) {
        $depars = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $depars[] = new Depar(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $depars;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $depars = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $depars[] = new Depar(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $depars;
    }

}
?>