/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
 *                                    DATA                                    *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
INSERT INTO companies (id, name, tin, active)
    VALUES (1, 'A & A IMPORTACIONES S.R.L.', '80004234-4', 1);
INSERT INTO companies (id, name, tin, active)
    VALUES (2, 'ALL PARTS S.R.L.', '80051608-7', 1);

INSERT INTO users (name, username, password, admin, active)
    VALUES ('Administrador', 'admin', 'admin', 1, 1);
INSERT INTO users (name, username, password, email, active)
    VALUES ('José Acuña', 'jaqnya', '123456', 'jaqnya@gmail.com', 1);

INSERT INTO company_users (company_id, user_id, active)
    VALUES (1, 2, 1);
INSERT INTO company_users (company_id, user_id, active)
    VALUES (2, 2, 1);

INSERT INTO user_privileges (company_id, user_id, program, access, append, modify, remove)
    VALUES (1, 2, 'family', 1, 1, 1, 1);
INSERT INTO user_privileges (company_id, user_id, program, access, append, modify, remove)
    VALUES (1, 2, 'brand', 1, 1, 1, 1);
INSERT INTO user_privileges (company_id, user_id, program, access, append, modify, remove)
    VALUES (1, 2, 'wo_brand', 1, 1, 1, 1);

CALL sp_family_insert(2, 1, 0, '-', 0.00, 0.00, 0.00, 0.00, 0.00, 1);
CALL sp_family_insert(2, 1, 0, 'TRAPP MAQUINAS', 30.00, 20.00, 0.00, 0.00, 0.00, 1);
CALL sp_family_insert(2, 1, 0, 'FAPASISA MAQUINAS', 30.00, 20.00, 0.00, 0.00, 0.00, 1);
CALL sp_family_insert(2, 1, 0, 'OUTSOURCED SERVICE', 20.00, 0.00, 0.00, 0.00, 0.00, 1);
CALL sp_family_insert(2, 1, 0, 'AÇOTECNICA/ARCHER', 70.00, 50.00, 30.00, 0.00, 0.00, 1);
CALL sp_family_insert(2, 1, 0, 'FAPASISA REPUESTOS STIHL', 32.00, 25.00, 18.00, 0.00, 0.00, 1);
CALL sp_family_insert(2, 1, 0, 'TRAPP REPUESTOS', 80.00, 70.00, 45.00, 0.00, 0.00, 1);
CALL sp_family_insert(2, 1, 0, 'CHACOMER OREGON REPUESTOS', 40.00, 30.00, 20.00, 0.00, 0.00, 1);
CALL sp_family_insert(2, 1, 0, 'CHACOMER REPUESTOS CORTACESPED', 40.00, 30.00, 0.00, 0.00, 0.00, 1);
CALL sp_family_insert(2, 1, 0, 'CHACOMER OREGON ESPADA', 35.00, 25.00, 20.00, 0.00, 0.00, 1);

CALL sp_brand_insert(2, 1, 0, '-', 1);
CALL sp_brand_insert(2, 1, 0, 'STIHL', 1);
CALL sp_brand_insert(2, 1, 0, 'HUSQVARNA', 1);
CALL sp_brand_insert(2, 1, 0, 'UNDEFINED', 1);
CALL sp_brand_insert(2, 1, 0, 'STENS', 1);
CALL sp_brand_insert(2, 1, 0, 'SILVER', 1);
CALL sp_brand_insert(2, 1, 0, 'BRIGGS & STRATTON', 1);
CALL sp_brand_insert(2, 1, 0, 'RAISMAN', 1);
CALL sp_brand_insert(2, 1, 0, 'MURRAY', 1);
CALL sp_brand_insert(2, 1, 0, 'OLEO MAC', 1);

CALL sp_wo_brand_insert(2, 1, 0, '-', 1);
CALL sp_wo_brand_insert(2, 1, 0, 'STIHL', 1);
CALL sp_wo_brand_insert(2, 1, 0, 'HUSQVARNA', 1);
CALL sp_wo_brand_insert(2, 1, 0, 'UNDEFINED', 1);
CALL sp_wo_brand_insert(2, 1, 0, 'STENS', 1);
CALL sp_wo_brand_insert(2, 1, 0, 'SILVER', 1);
CALL sp_wo_brand_insert(2, 1, 0, 'BRIGGS & STRATTON', 1);
CALL sp_wo_brand_insert(2, 1, 0, 'RAISMAN', 1);
CALL sp_wo_brand_insert(2, 1, 0, 'MURRAY', 1);
CALL sp_wo_brand_insert(2, 1, 0, 'OLEO MAC', 1);