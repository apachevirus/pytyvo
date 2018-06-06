<?php

abstract class BaseRepository {

    protected static $table;

    public static function get_reccount($connection) {
        $reccount = null;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_reccount(:company_id) reccount';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
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
                $sql = 'SELECT fn_' . static::$table . '_id_exists(:company_id, :id) id_exists';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
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
                $sql = 'SELECT fn_' . static::$table . '_name_exists(:company_id, :name) name_exists';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
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

    public static function is_active($connection, $id) {
        $is_active = false;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_is_active(:company_id, :id) is_active';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
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
                $sql = 'SELECT fn_' . static::$table . '_new_id(:company_id) new_id';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
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
        $results = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_all(:company_id)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
                $stmt->execute();

                $results = $stmt->fetchAll();
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $results;
    }

    public static function get_all_active($connection) {
        $results = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_all_active(:company_id)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
                $stmt->execute();

                $results = $stmt->fetchAll();
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $results;
    }

    public static function get_by_id($connection, $id) {
        $result = null;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_id(:company_id, :id)';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);

                $stmt->execute();

                $result = $stmt->fetch();
             } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $result;
    }

    public static function get_by_name($connection, $name) {
        $results = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_by_name(:company_id, :name)';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);

                $stmt->execute();

                $results = $stmt->fetchAll();
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $results;
    }

    public static function delete($connection, $id) {
        $deleted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_delete(:user_id, :company_id, :id)';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $_SESSION['user_id'], PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $_SESSION['company_id'], PDO::PARAM_INT);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);

                $deleted = $stmt->execute();
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $deleted;
    }

}