<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'Neighborhood.inc.php';

class NeighborhoodRepository extends BaseRepository {

    protected static $table = 'neighborhood';

    public static function city_belongs_to_depar($connection, $company_id, $depar_id, $city_id) {
        $belongs = false;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_city_belongs_to_depar(:company_id, :depar_id, :city_id) belongs';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);
                $stmt->bindParam(':city_id', $city_id, PDO::PARAM_INT);

                $stmt->execute();

                $result = $stmt->fetch();

                if ($result['belongs']) {
                    $belongs = true;
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $belongs;
    }

    public static function get_all($connection, $company_id) {
        $neighborhoods = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $neighborhoods[] = new Neighborhood(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['city_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $neighborhoods;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $neighborhoods = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $neighborhoods[] = new Neighborhood(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['city_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $neighborhoods;
    }

    public static function get_all_active($connection, $company_id) {
        $neighborhoods = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $neighborhoods[] = new Neighborhood(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['city_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $neighborhoods;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $neighborhood = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $neighborhood = new Neighborhood(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['depar_id'],
                $result['city_id'],
                $result['full_name'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $neighborhood;
    }

    public static function __callStatic($method, $arguments) {
        if ($method == 'name_exists') {
            if (count($arguments) == 5) {
                $connection = $arguments[0];
                $company_id = $arguments[1];
                $name = $arguments[2];
                $depar_id = $arguments[3];
                $city_id = $arguments[4];

                $name_exists = true;

                if (isset($connection)) {
                    try {
                        $sql = 'SELECT fn_' . static::$table . '_name_exists(:company_id, :name, :depar_id, :city_id) name_exists';

                        $stmt = $connection->prepare($sql);

                        $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                        $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                        $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);
                        $stmt->bindParam(':city_id', $city_id, PDO::PARAM_INT);

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
            if (count($arguments) == 5) {
                $connection = $arguments[0];
                $company_id = $arguments[1];
                $name = $arguments[2];
                $depar_id = $arguments[3];
                $city_id = $arguments[4];

                $neighborhoods = array();

                if (isset($connection)) {
                    try {
                        $sql = 'CALL sp_' . static::$table . '_get_by_name(:company_id, :name, :depar_id, :city_id)';

                        $stmt = $connection->prepare($sql);

                        $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                        $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                        $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);
                        $stmt->bindParam(':city_id', $city_id, PDO::PARAM_INT);

                        $stmt->execute();

                        $results = $stmt->fetchAll();

                        if (count($results)) {
                            foreach ($results as $row) {
                                $neighborhoods[] = new Neighborhood(
                                    $row['company_id'],
                                    $row['id'],
                                    $row['name'],
                                    $row['depar_id'],
                                    $row['city_id'],
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

                return $neighborhoods;
            }
        }   //  { method: get_by_name() }
    }

    // public static function get_by_name($connection, $company_id, $name, $depar_id, $city_id) {
    //     $neighborhoods = array();

    //     if (isset($connection)) {
    //         try {
    //             $sql = 'CALL sp_' . static::$table . '_get_by_name(:company_id, :name, :depar_id, :city_id)';

    //             $stmt = $connection->prepare($sql);

    //             $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
    //             $stmt->bindParam(':name', $name, PDO::PARAM_STR);
    //             $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);
    //             $stmt->bindParam(':city_id', $city_id, PDO::PARAM_INT);

    //             $stmt->execute();

    //             $results = $stmt->fetchAll();

    //             if (count($results)) {
    //                 foreach ($results as $row) {
    //                     $neighborhoods[] = new Neighborhood(
    //                         $row['company_id'],
    //                         $row['id'],
    //                         $row['name'],
    //                         $row['depar_id'],
    //                         $row['city_id'],
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

    //     return $neighborhoods;
    // }

    public static function get_by_any($connection, $company_id, $any) {
        $neighborhoods = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $neighborhoods[] = new Neighborhood(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['city_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $neighborhoods;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $neighborhoods = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $neighborhoods[] = new Neighborhood(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['depar_id'],
                    $row['city_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $neighborhoods;
    }

    public static function insert($connection, $user_id, $neighborhood) {
        $neighborhood_inserted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_insert(:user_id, :company_id, 0, :name, :depar_id, :city_id, :active)';

                $company_id = $neighborhood->get_company_id();
                $name = $neighborhood->get_name();
                $depar_id = $neighborhood->get_depar_id();
                $city_id = $neighborhood->get_city_id();
                $active = $neighborhood->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);
                $stmt->bindParam(':city_id', $city_id, PDO::PARAM_INT);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $neighborhood_inserted = $stmt->execute();
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

        return $neighborhood_inserted;
    }

    public static function update($connection, $user_id, $neighborhood) {
        $neighborhood_updated = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_update(:user_id, :company_id, :id, :name, :depar_id, :city_id, :active)';

                $company_id = $neighborhood->get_company_id();
                $id = $neighborhood->get_id();
                $name = $neighborhood->get_name();
                $depar_id = $neighborhood->get_depar_id();
                $city_id = $neighborhood->get_city_id();
                $active = $neighborhood->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':depar_id', $depar_id, PDO::PARAM_INT);
                $stmt->bindParam(':city_id', $city_id, PDO::PARAM_INT);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $neighborhood_updated = $stmt->execute();
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

        return $neighborhood_updated;
    }

}
?>