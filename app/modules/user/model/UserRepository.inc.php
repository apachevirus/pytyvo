<?php
include_once 'app/core/DefaultRepository.inc.php';
include_once 'User.inc.php';

class UserRepository extends DefaultRepository {

    protected static $table = 'user';

    public static function username_exists($connection, $username) {
        $username_exists = true;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_' . static::$table . '_username_exists(:username) username_exists';

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

    public static function get_all($connection) {
        $users = array();

        $results = parent::get_all($connection);

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

        return $users;
    }

    public static function get_all_with_limit_and_offset($connection, $limit, $offset) {
        $users = array();

        $results = parent::get_all_with_limit_and_offset($connection, $limit, $offset);

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

        return $users;
    }

    public static function get_all_active($connection) {
        $users = array();

        $results = parent::get_all_active($connection);

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

        return $users;
    }

    public static function get_by_id($connection, $id) {
        $user = null;

        $result = parent::get_by_id($connection, $id);

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

        return $user;
    }

    public static function get_by_name($connection, $name) {
        $users = array();

        $results = parent::get_by_name($connection, $name);

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

    public static function get_by_email($connection, $email) {
        $user = null;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_email(:email)';

                $stmt = $connection->prepare($sql);
                $stmt->bindParam(':email', $email, PDO::PARAM_STR);
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

        $results = parent::get_by_any($connection, $any);

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

        return $users;
    }

    public static function get_by_any_with_limit_and_offset($connection, $any, $limit, $offset) {
        $users = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $any, $limit, $offset);

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

        return $users;
    }

    public static function insert($connection, $user) {
        $user_inserted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_insert(0, :name, :username, :password, :email, :admin, :active)';

                $name = $user->get_name();
                $username = $user->get_username();
                $password = $user->get_password();
                $email = $user->get_email();
                $admin = $user->is_admin();
                $active = $user->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':username', $username, PDO::PARAM_STR);
                $stmt->bindParam(':password', $password, PDO::PARAM_STR);
                $stmt->bindParam(':email', $email, PDO::PARAM_STR);
                $stmt->bindParam(':admin', $admin, PDO::PARAM_BOOL);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $user_inserted = $stmt->execute();
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

        return $user_inserted;
    }

    public static function update($connection, $user) {
        $user_updated = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_update(:id, :name, :username, :password, :email, :admin, :active)';

                $id = $user->get_id();
                $name = $user->get_name();
                $username = $user->get_username();
                $password = $user->get_password();
                $email = $user->get_email();
                $admin = $user->is_admin();
                $active = $user->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':username', $username, PDO::PARAM_STR);
                $stmt->bindParam(':password', $password, PDO::PARAM_STR);
                $stmt->bindParam(':email', $email, PDO::PARAM_STR);
                $stmt->bindParam(':admin', $admin, PDO::PARAM_BOOL);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $user_updated = $stmt->execute();
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

        return $user_updated;
    }

}
?>