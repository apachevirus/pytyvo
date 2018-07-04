<?php
include_once 'app/core/DefaultRepository.inc.php';
include_once 'Company.inc.php';

class CompanyRepository extends DefaultRepository {

    protected static $table = 'company';

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

    public static function get_all($connection) {
        $companies = array();

        $results = parent::get_all($connection);

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

        return $companies;
    }

    public static function get_all_with_limit_and_offset($connection, $limit, $offset) {
        $companies = array();

        $results = parent::get_all_with_limit_and_offset($connection, $limit, $offset);

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

        return $companies;
    }

    public static function get_all_active($connection) {
        $companies = array();

        $results = parent::get_all_active($connection);

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

        return $companies;
    }

    public static function get_by_id($connection, $id) {
        $company = null;

        $result = parent::get_by_id($connection, $id);

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

        return $company;
    }

    public static function get_by_name($connection, $name) {
        $companies = array();

        $results = parent::get_by_name($connection, $name);

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

        return $companies;
    }

    public static function get_by_tin($connection, $tin) {
        $companies = array();

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_get_by_tin(:tin)';

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

    public static function get_by_any($connection, $any) {
        $companies = array();

        $results = parent::get_by_any($connection, $any);

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

        return $companies;
    }

    public static function get_by_any_with_limit_and_offset($connection, $any, $limit, $offset) {
        $companies = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $any, $limit, $offset);

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

        return $companies;
    }

    public static function insert($connection, $company) {
        $company_inserted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_insert(0, :name, :tin, :active)';

                $name = $company->get_name();
                $tin = $company->get_tin();
                $active = $company->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':tin', $tin, PDO::PARAM_STR);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $company_inserted = $stmt->execute();
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

        return $company_inserted;
    }

    public static function update($connection, $company) {
        $company_updated = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_update(:id, :name, :tin, :active)';

                $id = $company->get_id();
                $name = $company->get_name();
                $tin = $company->get_tin();
                $active = $company->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':tin', $tin, PDO::PARAM_STR);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $company_updated = $stmt->execute();
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

        return $company_updated;
    }

}
?>