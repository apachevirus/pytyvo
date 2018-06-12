<?php

include_once 'app/User.inc.php';

class UserRepository {

    public static function get_all($connection) {
        $users = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_user_get_all()';

                $stmt = $connection->prepare($sql);
                $stmt->execute();

                $result = $stmt->fetchAll();

                if (count($result)) {
                    foreach ($result as $row) {
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

    public static function get_reccount($connection) {
        $total_users = null;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_user_reccount() reccount';

                $stmt = $connection->prepare($sql);
                $stmt->execute();

                $result = $stmt->fetch();

                $total_users = $result['reccount'];
            } catch (PDOException $ex) {
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $total_users;
    }

    public static function insert($connection, $user) {
        $user_inserted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_user_insert(0, :name, :username, :password, :email, :admin, :active)';

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
                print 'ERROR: ' . $ex->getMessage() . '<br>';
            }
        }

        return $user_inserted;
    }

    public static function name_exists($connection, $name) {
        $name_exists = true;

        if (isset($connection)) {
            try {
                $sql = 'SELECT fn_user_name_exists(:name) name_exists';

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
                $sql = 'SELECT fn_user_username_exists(:username) username_exists';

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
                $sql = 'SELECT fn_user_email_exists(:email) email_exists';

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

    public static function get_by_username($connection, $username) {
        $user = null;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_user_get_by_username(:username)';

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

}