<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'Subcategory.inc.php';

class SubcategoryRepository extends BaseRepository {

    protected static $table = 'subcategory';

    public static function get_all($connection, $company_id) {
        $subcategories = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $subcategories[] = new Subcategory(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $subcategories;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $subcategories = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $subcategories[] = new Subcategory(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $subcategories;
    }

    public static function get_all_active($connection, $company_id) {
        $subcategories = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $subcategories[] = new Subcategory(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $subcategories;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $subcategory = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $subcategory = new Subcategory(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $subcategory;
    }

    public static function get_by_name($connection, $company_id, $name) {
        $subcategories = array();

        $results = parent::get_by_name($connection, $company_id, $name);

        if (count($results)) {
            foreach ($results as $row) {
                $subcategories[] = new Subcategory(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $subcategories;
    }

    public static function get_by_any($connection, $company_id, $any) {
        $subcategories = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $subcategories[] = new Subcategory(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $subcategories;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $subcategories = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $subcategories[] = new Subcategory(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $subcategories;
    }

}
?>