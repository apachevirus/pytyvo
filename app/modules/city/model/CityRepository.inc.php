<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'City.inc.php';

class CityRepository extends BaseRepository {

    protected static $table = 'city';

    public static function get_all($connection, $company_id) {
        $cities = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $cities[] = new City(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $cities;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $cities = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $cities[] = new City(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $cities;
    }

    public static function get_all_active($connection, $company_id) {
        $cities = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $cities[] = new City(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $cities;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $city = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $city = new City(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['depar_id'],
                $result['full_name'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $city;
    }

    public static function __callStatic($method, $arguments) {
        if ($method == 'name_exists') {
            if (count($arguments) == 4) {
                $connection = $arguments[0];
                $company_id = $arguments[1];
                $name = $arguments[2];
                $depar_id = $arguments[3];

                $name_exists = true;

                if (isset($connection)) {
                    try {
                        $sql = 'SELECT fn_' . static::$table . '_name_exists(:company_id, :name, :depar_id) name_exists';

                        $stmt = $connection->prepare($sql);

                        $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                        $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                        $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);

                        $stmt->execute();

                        $result = $stmt->fetch();

                        if (!$result['name_exists']) {
                            $name_exists = false;
                        }
                    } catch (PDOException $ex) {
                        print 'ERROR: ' . $ex->getMessage() . '<br>';
                    }
                }

                return $name_exists;
            }
        }   //  { method: name_exists() }

        if ($method == 'get_by_name') {
            if (count($arguments) == 4) {
                $connection = $arguments[0];
                $company_id = $arguments[1];
                $name = $arguments[2];
                $depar_id = $arguments[3];

                $cities = array();

                if (isset($connection)) {
                    try {
                        $sql = 'CALL sp_' . static::$table . '_get_by_name(:company_id, :name, :depar_id)';

                        $stmt = $connection->prepare($sql);

                        $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                        $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                        $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);

                        $stmt->execute();

                        $results = $stmt->fetchAll();

                        if (count($results)) {
                            foreach ($results as $row) {
                                $cities[] = new City(
                                    $row['company_id'],
                                    $row['id'],
                                    $row['name'],
                                    $row['depar_id'],
                                    $row['full_name'],
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

                return $cities;
            }
        }   //  { method: get_by_name() }
    }

    // public static function get_by_name($connection, $company_id, $name, $depar_id) {
    //     $cities = array();

    //     if (isset($connection)) {
    //         try {
    //             $sql = 'CALL sp_' . static::$table . '_get_by_name(:company_id, :name, :depar_id)';

    //             $stmt = $connection->prepare($sql);

    //             $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
    //             $stmt->bindParam(':name', $name, PDO::PARAM_STR);
    //             $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);

    //             $stmt->execute();

    //             $results = $stmt->fetchAll();

    //             if (count($results)) {
    //                 foreach ($results as $row) {
    //                     $cities[] = new City(
    //                         $row['company_id'],
    //                         $row['id'],
    //                         $row['name'],
    //                         $row['depar_id'],
    //                         $row['full_name'],
    //                         $row['active'],
    //                         $row['created_at'],
    //                         $row['updated_at']
    //                     );
    //                 }
    //             }
    //         } catch (PDOException $ex) {
    //             print 'ERROR: ' . $ex->getMessage() . '<br>';
    //         }
    //     }

    //     return $cities;
    // }

    public static function get_by_any($connection, $company_id, $any) {
        $cities = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $cities[] = new City(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $cities;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $cities = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $cities[] = new City(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $cities;
    }

    public static function insert($connection, $user_id, $city) {
        $city_inserted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_insert(:user_id, :company_id, 0, :name, :depar_id, :active)';

                $company_id = $city->get_company_id();
                $name = $city->get_name();
                $depar_id = $city->get_depar_id();
                $active = $city->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $city_inserted = $stmt->execute();
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

        return $city_inserted;
    }

    public static function update($connection, $user_id, $city) {
        $city_updated = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_update(:user_id, :company_id, :id, :name, :depar_id, :active)';

                $company_id = $city->get_company_id();
                $id = $city->get_id();
                $name = $city->get_name();
                $depar_id = $city->get_depar_id();
                $active = $city->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $city_updated = $stmt->execute();
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

        return $city_updated;
    }

}
?>