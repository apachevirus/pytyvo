<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'Model.inc.php';

class ModelRepository extends BaseRepository {

    protected static $table = 'model';

    public static function get_all($connection, $company_id) {
        $models = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $models[] = new Model(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['machine_id'],
                    $row['brand_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $models;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $models = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $models[] = new Model(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['machine_id'],
                    $row['brand_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $models;
    }

    public static function get_all_active($connection, $company_id) {
        $models = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $models[] = new Model(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['machine_id'],
                    $row['brand_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $models;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $model = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $model = new Model(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['machine_id'],
                $result['brand_id'],
                $result['full_name'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $model;
    }

    public static function __callStatic($method, $arguments) {
        if ($method == 'name_exists') {
            if (count($arguments) == 5) {
                $connection = $arguments[0];
                $company_id = $arguments[1];
                $name = $arguments[2];
                $machine_id = $arguments[3];
                $brand_id = $arguments[4];

                $name_exists = true;

                if (isset($connection)) {
                    try {
                        $sql = 'SELECT fn_' . static::$table . '_name_exists(:company_id, :name, :machine_id, :brand_id) name_exists';

                        $stmt = $connection->prepare($sql);

                        $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                        $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                        $stmt->bindParam(':machine_id', $machine_id, PDO::PARAM_INT);
                        $stmt->bindParam(':brand_id', $brand_id, PDO::PARAM_INT);

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
                $machine_id = $arguments[3];
                $brand_id = $arguments[4];

                $models = array();

                if (isset($connection)) {
                    try {
                        $sql = 'CALL sp_' . static::$table . '_get_by_name(:company_id, :name, :machine_id, :brand_id)';

                        $stmt = $connection->prepare($sql);

                        $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                        $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                        $stmt->bindParam(':machine_id', $machine_id, PDO::PARAM_INT);
                        $stmt->bindParam(':brand_id', $brand_id, PDO::PARAM_INT);

                        $stmt->execute();

                        $results = $stmt->fetchAll();

                        if (count($results)) {
                            foreach ($results as $row) {
                                $models[] = new Model(
                                    $row['company_id'],
                                    $row['id'],
                                    $row['name'],
                                    $row['machine_id'],
                                    $row['brand_id'],
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

                return $models;
            }
        }   //  { method: get_by_name() }
    }

    // public static function get_by_name($connection, $company_id, $name, $machine_id, $brand_id) {
    //     $models = array();

    //     if (isset($connection)) {
    //         try {
    //             $sql = 'CALL sp_' . static::$table . '_get_by_name(:company_id, :name, :machine_id, :brand_id)';

    //             $stmt = $connection->prepare($sql);

    //             $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
    //             $stmt->bindParam(':name', $name, PDO::PARAM_STR);
    //             $stmt->bindParam(':machine_id', $machine_id, PDO::PARAM_INT);
    //             $stmt->bindParam(':brand_id', $brand_id, PDO::PARAM_INT);

    //             $stmt->execute();

    //             $results = $stmt->fetchAll();

    //             if (count($results)) {
    //                 foreach ($results as $row) {
    //                     $models[] = new Model(
    //                         $row['company_id'],
    //                         $row['id'],
    //                         $row['name'],
    //                         $row['machine_id'],
    //                         $row['brand_id'],
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

    //     return $models;
    // }

    public static function get_by_any($connection, $company_id, $any) {
        $models = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $models[] = new Model(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['machine_id'],
                    $row['brand_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $models;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $models = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $models[] = new Model(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['machine_id'],
                    $row['brand_id'],
                    $row['full_name'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $models;
    }

    public static function insert($connection, $user_id, $model) {
        $model_inserted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_insert(:user_id, :company_id, 0, :name, :machine_id, :brand_id, :active)';

                $company_id = $model->get_company_id();
                $name = $model->get_name();
                $machine_id = $model->get_machine_id();
                $brand_id = $model->get_brand_id();
                $active = $model->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':machine_id', $machine_id, PDO::PARAM_INT);
                $stmt->bindParam(':brand_id', $brand_id, PDO::PARAM_INT);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $model_inserted = $stmt->execute();
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

        return $model_inserted;
    }

    public static function update($connection, $user_id, $model) {
        $model_updated = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_update(:user_id, :company_id, :id, :name, :machine_id, :brand_id, :active)';

                $company_id = $model->get_company_id();
                $id = $model->get_id();
                $name = $model->get_name();
                $machine_id = $model->get_machine_id();
                $brand_id = $model->get_brand_id();
                $active = $model->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':machine_id', $machine_id, PDO::PARAM_INT);
                $stmt->bindParam(':brand_id', $brand_id, PDO::PARAM_INT);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $model_updated = $stmt->execute();
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

        return $model_updated;
    }

}
?>