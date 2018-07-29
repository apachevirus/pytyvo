<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'MeasurementUnit.inc.php';

class MeasurementUnitRepository extends BaseRepository {

    protected static $table = 'measurement_unit';

    public static function symbol_exists($connection, $company_id, $symbol) {
        $symbol_exists = true;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_symbol_exists(:company_id, :symbol) symbol_exists';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':symbol', $symbol, PDO::PARAM_STR);

                $stmt->execute();

                $result = $stmt->fetch();

                if (!$result['symbol_exists']) {
                    $symbol_exists = false;
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $symbol_exists;
    }

    public static function get_all($connection, $company_id) {
        $measurement_units = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $measurement_units[] = new MeasurementUnit(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['symbol'],
                    $row['divisible'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $measurement_units;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $measurement_units = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $measurement_units[] = new MeasurementUnit(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['symbol'],
                    $row['divisible'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $measurement_units;
    }

    public static function get_all_active($connection, $company_id) {
        $measurement_units = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $measurement_units[] = new MeasurementUnit(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['symbol'],
                    $row['divisible'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $measurement_units;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $measurement_unit = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $measurement_unit = new MeasurementUnit(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['symbol'],
                $result['divisible'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $measurement_unit;
    }

    public static function get_by_name($connection, $company_id, $name) {
        $measurement_units = array();

        $results = parent::get_by_name($connection, $company_id, $name);

        if (count($results)) {
            foreach ($results as $row) {
                $measurement_units[] = new MeasurementUnit(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['symbol'],
                    $row['divisible'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $measurement_units;
    }

    public static function get_by_any($connection, $company_id, $any) {
        $measurement_units = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $measurement_units[] = new MeasurementUnit(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['symbol'],
                    $row['divisible'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $measurement_units;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $measurement_units = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $measurement_units[] = new MeasurementUnit(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['symbol'],
                    $row['divisible'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $measurement_units;
    }

}
?>