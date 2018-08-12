<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'WOBrand.inc.php';

class WOBrandRepository extends BaseRepository {

    protected static $table = 'wo_brand';

    public static function get_all($connection, $company_id) {
        $wo_brands = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $wo_brands[] = new WOBrand(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $wo_brands;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $wo_brands = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $wo_brands[] = new WOBrand(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $wo_brands;
    }

    public static function get_all_active($connection, $company_id) {
        $wo_brands = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $wo_brands[] = new WOBrand(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $wo_brands;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $wo_brand = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $wo_brand = new WOBrand(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $wo_brand;
    }

    public static function get_by_name($connection, $company_id, $name) {
        $wo_brands = array();

        $results = parent::get_by_name($connection, $company_id, $name);

        if (count($results)) {
            foreach ($results as $row) {
                $wo_brands[] = new WOBrand(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $wo_brands;
    }

    public static function get_by_any($connection, $company_id, $any) {
        $wo_brands = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $wo_brands[] = new WOBrand(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $wo_brands;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $wo_brands = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $wo_brands[] = new WOBrand(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $wo_brands;
    }

}
?>