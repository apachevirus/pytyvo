<?php
include_once 'app/core/BaseRepository.inc.php';
include_once 'Family.inc.php';

class FamilyRepository extends BaseRepository {

    protected static $table = 'family';

    public static function get_all($connection, $company_id) {
        $families = array();

        $results = parent::get_all($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $families[] = new Family(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['p1'],
                    $row['p2'],
                    $row['p3'],
                    $row['p4'],
                    $row['p5'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $families;
    }

    public static function get_all_with_limit_and_offset($connection, $company_id, $limit, $offset) {
        $families = array();

        $results = parent::get_all_with_limit_and_offset($connection, $company_id, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $families[] = new Family(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['p1'],
                    $row['p2'],
                    $row['p3'],
                    $row['p4'],
                    $row['p5'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $families;
    }

    public static function get_all_active($connection, $company_id) {
        $families = array();

        $results = parent::get_all_active($connection, $company_id);

        if (count($results)) {
            foreach ($results as $row) {
                $families[] = new Family(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['p1'],
                    $row['p2'],
                    $row['p3'],
                    $row['p4'],
                    $row['p5'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $families;
    }

    public static function get_by_id($connection, $company_id, $id) {
        $family = null;

        $result = parent::get_by_id($connection, $company_id, $id);

        if (!empty($result)) {
            $family = new Family(
                $result['company_id'],
                $result['id'],
                $result['name'],
                $result['p1'],
                $result['p2'],
                $result['p3'],
                $result['p4'],
                $result['p5'],
                $result['active'],
                $result['created_at'],
                $result['updated_at']
            );
        }

        return $family;
    }

    public static function get_by_name($connection, $company_id, $name) {
        $families = array();

        $results = parent::get_by_name($connection, $company_id, $name);

        if (count($results)) {
            foreach ($results as $row) {
                $families[] = new Family(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['p1'],
                    $row['p2'],
                    $row['p3'],
                    $row['p4'],
                    $row['p5'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $families;
    }

    public static function get_by_any($connection, $company_id, $any) {
        $families = array();

        $results = parent::get_by_any($connection, $company_id, $any);

        if (count($results)) {
            foreach ($results as $row) {
                $families[] = new Family(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['p1'],
                    $row['p2'],
                    $row['p3'],
                    $row['p4'],
                    $row['p5'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $families;
    }

    public static function get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset) {
        $families = array();

        $results = parent::get_by_any_with_limit_and_offset($connection, $company_id, $any, $limit, $offset);

        if (count($results)) {
            foreach ($results as $row) {
                $families[] = new Family(
                    $row['company_id'],
                    $row['id'],
                    $row['name'],
                    $row['p1'],
                    $row['p2'],
                    $row['p3'],
                    $row['p4'],
                    $row['p5'],
                    $row['active'],
                    $row['created_at'],
                    $row['updated_at']
                );
            }
        }

        return $families;
    }

    public static function insert($connection, $user_id, $family) {
        $family_inserted = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_insert(:user_id, :company_id, 0, :name, :p1, :p2, :p3, :p4, :p5, :active)';

                $company_id = $family->get_company_id();
                $name = $family->get_name();
                $p1 = $family->get_p1();
                $p2 = $family->get_p2();
                $p3 = $family->get_p3();
                $p4 = $family->get_p4();
                $p5 = $family->get_p5();
                $active = $family->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':p1', $p1, PDO::PARAM_STR);
                $stmt->bindParam(':p2', $p2, PDO::PARAM_STR);
                $stmt->bindParam(':p3', $p3, PDO::PARAM_STR);
                $stmt->bindParam(':p4', $p4, PDO::PARAM_STR);
                $stmt->bindParam(':p5', $p5, PDO::PARAM_STR);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $family_inserted = $stmt->execute();
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

        return $family_inserted;
    }

    public static function update($connection, $user_id, $family) {
        $family_updated = false;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_' . static::$table . '_update(:user_id, :company_id, :id, :name, :p1, :p2, :p3, :p4, :p5, :active)';

                $company_id = $family->get_company_id();
                $id = $family->get_id();
                $name = $family->get_name();
                $p1 = $family->get_p1();
                $p2 = $family->get_p2();
                $p3 = $family->get_p3();
                $p4 = $family->get_p4();
                $p5 = $family->get_p5();
                $active = $family->is_active();

                $stmt = $connection->prepare($sql);

                $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
                $stmt->bindParam(':company_id', $company_id, PDO::PARAM_INT);
                $stmt->bindParam(':id', $id, PDO::PARAM_INT);
                $stmt->bindParam(':name', $name, PDO::PARAM_STR);
                $stmt->bindParam(':p1', $p1, PDO::PARAM_STR);
                $stmt->bindParam(':p2', $p2, PDO::PARAM_STR);
                $stmt->bindParam(':p3', $p3, PDO::PARAM_STR);
                $stmt->bindParam(':p4', $p4, PDO::PARAM_STR);
                $stmt->bindParam(':p5', $p5, PDO::PARAM_STR);
                $stmt->bindParam(':active', $active, PDO::PARAM_BOOL);

                $family_updated = $stmt->execute();
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

        return $family_updated;
    }

}
?>