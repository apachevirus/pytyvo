<?php
include_once 'User.inc.php';

class UserRepository {

    protected static $table = 'user';
    protected static $sql_exception;

    public static function get_sql_exception() {
        return static::$sql_exception;
    }

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

    public static function username_exists($connection, $username) {
        $username_exists = true;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn' . static::$table . 'username_exists(:username) username_exists';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':username', $username, PDO::PARAM_STR);
                $stmt->execute();

                $result = $stmt->fetch();

                if (!$result['username_exists']) {
                    $username_exists = false;
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $username_exists;
    }

    public static function email_exists($connection, $email) {
        $email_exists = true;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_email_exists(:email) email_exists';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':email', $email, PDO::PARAM_STR);
                $stmt->execute();

                $result = $stmt->fetch();

                if (!$result['email_exists']) {
                    $email_exists = false;
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $email_exists;
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
        $users = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_all()';

                $stmt = $connection->prepare($sql);
                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $users[] = new User(
                            $row['id'],
                            $row['name'],
                            $row['username'],
                            $row['password'],
                            $row['email'],
                            $row['admin'],
                            $row['active'],
                            $row['company_id'],
                            $row['created_at'],
                            $row['updated_at']
                        );
                    }
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $users;
    }

    public static function get_all_with_limit_and_offset($connection, $limit, $offset) {
        $users = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_all_with_limit_and_offset(:limit, :offset)';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
                $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);

                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $users[] = new User(
                            $row['id'],
                            $row['name'],
                            $row['username'],
                            $row['password'],
                            $row['email'],
                            $row['admin'],
                            $row['active'],
                            $row['company_id'],
                            $row['created_at'],
                            $row['updated_at']
                        );
                    }
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $users;
    }

    public static function get_all_active($connection) {
        $users = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_all_active()';

                $stmt = $connection->prepare($sql);
                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $users[] = new User(
                            $row['id'],
                            $row['name'],
                            $row['username'],
                            $row['password'],
                            $row['email'],
                            $row['admin'],
                            $row['active'],
                            $row['company_id'],
                            $row['created_at'],
                            $row['updated_at']
                        );
                    }
                }
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $users;
    }

    public static function get_by_id($connection, $id) {
        $user = null;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_id(:id)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->execute();

                $result = $stmt->fetch();

                if (!empty($result)) {
                    $user = new User(
                        $result['id'],
                        $result['name'],
                        $result['username'],
                        $result['password'],
                        $result['email'],
                        $result['admin'],
                        $result['active'],
                        $result['company_id'],
                        $result['created_at'],
                        $result['updated_at']
                    );
                }
             } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $user;
    }

    public static function get_by_name($connection, $name) {
        $users = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_name(:name)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $users[] = new User(
                            $row['id'],
                            $row['name'],
                            $row['username'],
                            $row['password'],
                            $row['email'],
                            $row['admin'],
                            $row['active'],
                            $row['company_id'],
                            $row['created_at'],
                            $row['updated_at']
                        );
                    }
                }
             } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $users;
    }

    public static function get_by_username($connection, $username) {
        $user = null;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_username(:username)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':username', $username, PDO::PARAM_STR);
                $stmt->execute();

                $result = $stmt->fetch();

                if (!empty($result)) {
                    $user = new User(
                        $result['id'],
                        $result['name'],
                        $result['username'],
                        $result['password'],
                        $result['email'],
                        $result['admin'],
                        $result['active'],
                        $result['company_id'],
                        $result['created_at'],
                        $result['updated_at']
                    );
                }
             } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $user;
    }

    public static function get_by_any($connection, $any) {
        $users = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_any(:any)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':any', $any, PDO::PARAM_STR);
                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $users[] = new User(
                            $row['id'],
                            $row['name'],
                            $row['username'],
                            $row['password'],
                            $row['email'],
                            $row['admin'],
                            $row['active'],
                            $row['company_id'],
                            $row['created_at'],
                            $row['updated_at']
                        );
                    }
                }
             } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $users;
    }

    public static function get_by_any_with_limit_and_offset($connection, $any, $limit, $offset) {
        $users = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_any_with_limit_and_offset(:any, :limit, :offset)';

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':any', $any, PDO::PARAM_STR);
                $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
                $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);

                $stmt->execute();

                $results = $stmt->fetchAll();

                if (count($results)) {
                    foreach ($results as $row) {
                        $users[] = new User(
                            $row['id'],
                            $row['name'],
                            $row['username'],
                            $row['password'],
                            $row['email'],
                            $row['admin'],
                            $row['active'],
                            $row['company_id'],
                            $row['created_at'],
                            $row['updated_at']
                        );
                    }
                }
             } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $users;
    }

    public static function get_by_any_reccount($connection, $any) {
        $reccount = null;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_get_by_any_reccount(:any) reccount';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':any', $any, PDO::PARAM_STR);
                $stmt->execute();

                $result = $stmt->fetch();

                $reccount = $result['reccount'];
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $reccount;
    }

    public static function insert($connection, $model) {
        $user_inserted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_insert(0, :name, :username, :password, :email, :admin, :active)';

                $name = $model->get_name();
                $username = $model->get_username();
                $password = $model->get_password();
                $email = $model->get_email();
                $admin = $model->is_admin();
                $active = $model->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':username', $username, PDO::PARAM_STR);
                $stmt->bindParam(':password', $password, PDO::PARAM_STR);
                $stmt->bindParam(':email', $email, PDO::PARAM_STR);
                $stmt->bindParam(':admin', $admin, PDO::PARAM_BOOL);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $user_inserted = $stmt->execute();
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $user_inserted;
    }

}
?>