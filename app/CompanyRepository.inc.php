<?php

include_once 'app/Company.inc.php';

class CompanyRepository {

    public static function get_by_id($connection, $id) {
        $company = null;

        if (isset($connection)) {
            try {
                $sql = 'CALL sp_company_get_by_id(:id)';

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

}