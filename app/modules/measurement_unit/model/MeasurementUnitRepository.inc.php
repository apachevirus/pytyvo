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

    public static function get_by_symbol($connection, $company_id, $symbol) {
        $measurement_units = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_symbol(:company_id, :symbol)';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':symbol', $symbol, PDO::PARAM_STR);

                $stmt->execute();

                $results = $stmt->fetchAll();

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
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
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

    public static function insert($connection, $user_id, $measurement_unit) {
        $measurement_unit_inserted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_insert(:user_id, :company_id, 0, :name, :symbol, :divisible, :active)';

                $company_id = $measurement_unit->get_company_id();
                $name = $measurement_unit->get_name();
                $symbol = $measurement_unit->get_symbol();
                $divisible = $measurement_unit->is_divisible();
                $active = $measurement_unit->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':symbol', $symbol, PDO::PARAM_STR);
                $stmt->bindParam(':divisible', $divisible, PDO::PARAM_BOOL);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $measurement_unit_inserted = $stmt->execute();
            } catch (PDOException $ex) {
                if ($ex->getCode() == '45000') {
                    $pdo_exception = explode('│', $ex->getMessage());
                    static::$sql_exception = $pdo_exception[1];
                } else {
                    print 'ERROR: ' . $ex->getMessage() . '<br>';
                    print 'ERROR: ' . $ex->getCode() . gettype($ex->getCode()). '<br>';
                }
            }
        }

        return $measurement_unit_inserted;
    }

    public static function update($connection, $user_id, $measurement_unit) {
        $measurement_unit_updated = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_update(:user_id, :company_id, :id, :name, :symbol, :divisible, :active)';

                $company_id = $measurement_unit->get_company_id();
                $id = $measurement_unit->get_id();
                $name = $measurement_unit->get_name();
                $symbol = $measurement_unit->get_symbol();
                $divisible = $measurement_unit->is_divisible();
                $active = $measurement_unit->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':symbol', $symbol, PDO::PARAM_STR);
                $stmt->bindParam(':divisible', $divisible, PDO::PARAM_BOOL);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $measurement_unit_updated = $stmt->execute();
            } catch (PDOException $ex) {
                if ($ex->getCode() == '45000') {
                    $pdo_exception = explode('│', $ex->getMessage());
                    static::$sql_exception = $pdo_exception[1];
                } else {
                    print 'ERROR: ' . $ex->getMessage() . '<br>';
                    print 'ERROR: ' . $ex->getCode() . gettype($ex->getCode()). '<br>';
                }
            }
        }

        return $measurement_unit_updated;
    }

}
?>