<?php

include_once 'app/Company.inc.php';

class CompanyRepository {

    protected static $table = 'company';

    public static function get_reccount($connection) {
        $reccount = null;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_reccount() reccount';

                $stmt = $connection->prepare($sql);
                $stmt->execute();

                $result = $stmt->fetch();

                $reccount = $result['reccount'];
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $reccount;
    }

    public static function id_exists($connection, $id) {
        $id_exists = true;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_id_exists(:id) id_exists';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->execute();

                $result = $stmt->fetch();

                if (!$result['id_exists']) {
                    $id_exists = false;
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $id_exists;
    }

    public static function name_exists($connection, $name) {
        $name_exists = true;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_name_exists(:name) name_exists';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
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

    public static function tin_exists($connection, $tin) {
        $tin_exists = true;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_tin_exists(:tin) tin_exists';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':tin', $tin, PDO::PARAM_STR);
                $stmt->execute();

                $result = $stmt->fetch();

                if (!$result['tin_exists']) {
                    $tin_exists = false;
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $tin_exists;
    }

    public static function is_active($connection, $id) {
        $is_active = false;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_is_active(:id) is_active';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->execute();

                $result = $stmt->fetch();

                if ($result['is_active']) {
                    $is_active = true;
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $is_active;
    }

    public static function new_id($connection) {
        $new_id = null;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_new_id() new_id';

                $stmt = $connection->prepare($sql);
                $stmt->execute();

                $result = $stmt->fetch();

                $new_id = $result['new_id'];
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $new_id;
    }

    public static function get_all($connection) {
        $companies = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_all()';

                $stmt = $connection->prepare($sql);
                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $companies[] = new Company(
                            $row['id'],
                            $row['name'],
                            $row['tin'],
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

        return $companies;
    }

    public static function get_all_active($connection) {
        $companies = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_all_active()';

                $stmt = $connection->prepare($sql);
                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $companies[] = new Company(
                            $row['id'],
                            $row['name'],
                            $row['tin'],
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

        return $companies;
    }

    public static function get_by_id($connection, $id) {
        $company = null;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_id(:id)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->execute();

                $result = $stmt->fetch();

                if (!empty($result)) {
                    $company = new Company(
                        $result['id'],
                        $result['name'],
                        $result['tin'],
                        $result['active'],
                        $result['created_at'],
                        $result['updated_at']
                    );
                }
             } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $company;
    }

    public static function get_by_name($connection, $name) {
        $companies = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_by_name(:name)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $companies[] = new Company(
                            $row['id'],
                            $row['name'],
                            $row['tin'],
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

        return $companies;
    }

    public static function get_by_tin($connection, $tin) {
        $companies = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_by_tin(:tin)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':tin', $tin, PDO::PARAM_STR);
                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $companies[] = new Company(
                            $row['id'],
                            $row['name'],
                            $row['tin'],
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

        return $companies;
    }

}