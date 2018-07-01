<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'Category.inc.php';

class CategoryRepository extends BaseRepository {

    protected static $table = 'category';

    public static function get_all($connection, $company_id) {
        $categories = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $categories[] = new Category(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $categories;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $categories = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $categories[] = new Category(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $categories;
    }

    public static function get_all_active($connection, $company_id) {
        $categories = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $categories[] = new Category(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $categories;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $category = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $category = new Category(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $category;
    }

    public static function get_by_name($connection, $company_id, $name) {
        $categories = array();

        $results = parent::get_by_name($connection, $company_id, $name);

        if (count($results)) {
            foreach ($results as $row) {
                $categories[] = new Category(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $categories;
    }

    public static function get_by_any($connection, $company_id, $any) {
        $categories = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $categories[] = new Category(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $categories;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $categories = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $categories[] = new Category(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $categories;
    }

}
?>