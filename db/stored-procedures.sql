/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
 *                              STORED PROCEDURES                             *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */










--
-- BEGIN: COMPANIES
--

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'companies' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_company_id_exists $$

CREATE FUNCTION fn_company_id_exists(p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        companies
    WHERE
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'companies' table.                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_company_name_exists $$

CREATE FUNCTION fn_company_name_exists(p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        companies
    WHERE
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a tin exists in the 'companies' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_company_tin_exists $$

CREATE FUNCTION fn_company_tin_exists(p_tin VARCHAR(15))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        companies
    WHERE
        UPPER(tin) LIKE UPPER(p_tin)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'companies' table.                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_company_is_active $$

CREATE FUNCTION fn_company_is_active(p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        companies
    WHERE
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'companies' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_company_new_id $$

CREATE FUNCTION fn_company_new_id()
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM companies WHERE id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'companies' table.                           *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_company_get_by_id $$

CREATE PROCEDURE sp_company_get_by_id(IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM companies WHERE id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'companies' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_company_get_by_name $$

CREATE PROCEDURE sp_company_get_by_name(IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM companies WHERE name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by tin from the 'companies' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_company_get_by_tin $$

CREATE PROCEDURE sp_company_get_by_tin(IN p_tin VARCHAR(15))
BEGIN
    SELECT * FROM companies WHERE tin LIKE p_tin ORDER BY name;
END $$

DELIMITER ;

--
-- END: COMPANIES
--










--
-- BEGIN: USERS
--

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'users' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_id_exists $$

CREATE FUNCTION fn_user_id_exists(p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        users
    WHERE
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'users' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_name_exists $$

CREATE FUNCTION fn_user_name_exists(p_name VARCHAR(25))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        users
    WHERE
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a username exists in the 'users' table.                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_username_exists $$

CREATE FUNCTION fn_user_username_exists(p_username VARCHAR(15))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        users
    WHERE
        UPPER(username) LIKE UPPER(p_username)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a email exists in the 'users' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_email_exists $$

CREATE FUNCTION fn_user_email_exists(p_email VARCHAR(255))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        users
    WHERE
        UPPER(email) LIKE UPPER(p_email)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'users' table.                    *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_is_active $$

CREATE FUNCTION fn_user_is_active(p_user_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        users
    WHERE
        id = p_user_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'users' table.                                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_new_id $$

CREATE FUNCTION fn_user_new_id()
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM users WHERE id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a user has access to a company.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_has_access $$

CREATE FUNCTION fn_user_has_access(p_company_id MEDIUMINT UNSIGNED,
                                   p_user_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        company_users
    WHERE
        company_id = p_company_id AND
        user_id = p_user_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a user can insert data into a table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_can_insert $$

CREATE FUNCTION fn_user_can_insert(p_company_id MEDIUMINT UNSIGNED,
                                   p_user_id MEDIUMINT UNSIGNED,
                                   p_program VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        user_privileges
    WHERE
        company_id = p_company_id AND
        user_id = p_user_id AND
        program LIKE p_program AND
        append = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a user can update data into a table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_can_update $$

CREATE FUNCTION fn_user_can_update(p_company_id MEDIUMINT UNSIGNED,
                                   p_user_id MEDIUMINT UNSIGNED,
                                   p_program VARCHAR(50))
    RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        user_privileges
    WHERE
        company_id = p_company_id AND
        user_id = p_user_id AND
        program LIKE p_program AND
        modify = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a user can delete data from a table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_can_delete $$

CREATE FUNCTION fn_user_can_delete(p_company_id MEDIUMINT UNSIGNED,
                                   p_user_id MEDIUMINT UNSIGNED,
                                   p_program VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        user_privileges
    WHERE
        company_id = p_company_id AND
        user_id = p_user_id AND
        program LIKE p_program AND
        remove = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'users' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_user_reccount $$

CREATE FUNCTION fn_user_reccount()
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        users
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to find out if a user has enough privileges to perform an action.       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_user_has_privilege $$

CREATE PROCEDURE sp_user_has_privilege(IN p_user_id MEDIUMINT UNSIGNED,
                                       IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_repository VARCHAR(50),
                                       IN p_privilege VARCHAR(20))
BEGIN
    -- begin { validate: user_id }
    IF p_user_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: No puede ser nulo.│';
    END IF;

    IF p_user_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: Debe ser mayor a cero.│';
    END IF;

    IF p_user_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_user_id_exists(p_user_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: No existe.│';
    END IF;

    IF NOT (SELECT fn_user_is_active(p_user_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: No está activo.│';
    END IF;
    -- end { validate: user_id }

    -- begin { validate: company_id }
    IF p_company_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Empresa: No puede ser nulo.│';
    END IF;

    IF p_company_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Empresa: Debe ser mayor a cero.│';
    END IF;

    IF p_company_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Empresa: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_company_id_exists(p_company_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Empresa: No existe.│';
    END IF;

    IF NOT (SELECT fn_company_is_active(p_company_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Empresa: No está activa.│';
    END IF;
    -- end { validate: company_id }

    -- begin { validate: repository }
    IF p_repository IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Repositorio: No puede ser nulo.│';
    END IF;

    IF p_repository = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Repositorio: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_repository) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Repositorio: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;
    -- end { validate: repository }

    -- begin { validate: privilege }
    IF p_privilege IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Privilegio: No puede ser nulo.│';
    END IF;

    IF p_privilege = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Privilegio: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_privilege) > 20 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Privilegio: La longitud debe ser como máximo de 20 caracteres.│';
    END IF;

    IF p_privilege <> 'create' AND
       p_privilege <> 'read' AND
       p_privilege <> 'write' AND
       p_privilege <> 'delete' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Privilegio: Debe ser Crear, Leer, Escribir o Suprimir.│';
    END IF;
    -- end { validate: privilege }

    IF NOT (SELECT fn_user_has_access(p_company_id, p_user_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Empresa: No está activa para el usuario.│';
    END IF;

    CASE p_privilege
    WHEN 'create' THEN
        IF NOT (SELECT fn_user_can_insert(p_company_id, p_user_id, p_repository)) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: No tiene permiso para agregar nuevos registros.│';
        END IF;
    WHEN 'read' THEN
        IF NOT (SELECT fn_user_can_select(p_company_id, p_user_id, p_repository)) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: No tiene permiso para recuperar registros.│';
        END IF;
    WHEN 'write' THEN
        IF NOT (SELECT fn_user_can_update(p_company_id, p_user_id, p_repository)) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: No tiene permiso para editar registros.│';
        END IF;
    WHEN 'delete' THEN
        IF NOT (SELECT fn_user_can_delete(p_company_id, p_user_id, p_repository)) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: No tiene permiso para eliminar registros.│';
        END IF;
    END CASE;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'users' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_user_get_all $$

CREATE PROCEDURE sp_user_get_all()
BEGIN
    SELECT
        id,
        name,
        username,
        password,
        COALESCE(email, '') email,
        admin,
        active,
        COALESCE(company_id, 0) company_id,
        created_at,
        updated_at
    FROM
        users
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get a row by username from the 'users' table.                        *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_user_get_by_username $$

CREATE PROCEDURE sp_user_get_by_username(IN p_username VARCHAR(25))
BEGIN
    SELECT
        id,
        name,
        username,
        password,
        COALESCE(email, '') email,
        admin,
        active,
        COALESCE(company_id, 0) company_id,
        created_at,
        updated_at
    FROM
        users
    WHERE
        username = p_username
    ORDER BY
        name
    LIMIT 1;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'users' table.                                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_user_insert $$

CREATE PROCEDURE sp_user_insert(IN p_id MEDIUMINT UNSIGNED,
                                IN p_name VARCHAR(25),
                                IN p_username VARCHAR(25),
                                IN p_password VARCHAR(255),
                                IN p_email VARCHAR(255),
                                IN p_admin TINYINT UNSIGNED,
                                IN p_active TINYINT UNSIGNED)
BEGIN
    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_user_new_id() INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_user_id_exists(p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 25 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 25 caracteres.│';
    END IF;

    IF (SELECT fn_user_name_exists(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: username }
    IF p_username IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre de usuario: No puede ser nulo.│';
    END IF;

    IF p_username = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre de usuario: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_username) > 25 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre de usuario: La longitud debe ser como máximo de 25 caracteres.│';
    END IF;

    IF (SELECT fn_user_username_exists(p_username)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre de usuario: Ya existe.│';
    END IF;
    -- end { validate: username }

    -- begin { validate: password }
    IF p_password IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Contraseña: No puede ser nulo.│';
    END IF;

    IF p_password = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Contraseña: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_password) < 6 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Contraseña: La longitud debe ser como mínimo de 6 caracteres.│';
    END IF;

    IF LENGTH(p_password) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Contraseña: La longitud debe ser como máximo de 255 caracteres.│';
    END IF;
    -- end { validate: password }

    -- begin { validate: email }
    IF p_email IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Correo electrónico: No puede ser nulo.│';
    END IF;

    IF p_email = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Correo electrónico: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_email) > 255 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Correo electrónico: La longitud debe ser como máximo de 255 caracteres.│';
    END IF;

    IF (SELECT fn_user_email_exists(p_email)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Correo electrónico: Ya existe.│';
    END IF;
    -- end { validate: email }

    -- begin { validate: admin }
    IF p_admin IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Administrador: No puede ser nulo.│';
    END IF;

    IF p_admin NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Administrador: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: admin }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO users (id, name, username, password, email, admin, active)
        VALUES (p_id, p_name, p_username, p_password, p_email, p_admin, p_active);
END $$

DELIMITER ;

--
-- END: USERS
--










--
-- BEGIN: FAMILIES
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'families' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_family_reccount $$

CREATE FUNCTION fn_family_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        families
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'families' table.                    *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_family_id_exists $$

CREATE FUNCTION fn_family_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                    p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        families
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'families' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_family_name_exists $$

CREATE FUNCTION fn_family_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                      p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        families
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'families' table.                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_family_is_active $$

CREATE FUNCTION fn_family_is_active(p_company_id MEDIUMINT UNSIGNED,
                                    p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        families
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'families' table.                               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_family_new_id $$

CREATE FUNCTION fn_family_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM families WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'families' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_get_all $$

CREATE PROCEDURE sp_family_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(p1, 0) p1,
        COALESCE(p2, 0) p2,
        COALESCE(p3, 0) p3,
        COALESCE(p4, 0) p4,
        COALESCE(p5, 0) p5,
        active,
        created_at,
        updated_at
    FROM
        families
    WHERE
        company_id = p_company_id
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'families' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_family_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                         IN p_limit MEDIUMINT UNSIGNED,
                                                         IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(p1, 0) p1,
        COALESCE(p2, 0) p2,
        COALESCE(p3, 0) p3,
        COALESCE(p4, 0) p4,
        COALESCE(p5, 0) p5,
        active,
        created_at,
        updated_at
    FROM
        families
    WHERE
        company_id = p_company_id
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'families' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_get_all_active $$

CREATE PROCEDURE sp_family_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(p1, 0) p1,
        COALESCE(p2, 0) p2,
        COALESCE(p3, 0) p3,
        COALESCE(p4, 0) p4,
        COALESCE(p5, 0) p5,
        active,
        created_at,
        updated_at
    FROM
        families
    WHERE
        company_id = p_company_id AND
        active = 1
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'families' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_get_by_id $$

CREATE PROCEDURE sp_family_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                     IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(p1, 0) p1,
        COALESCE(p2, 0) p2,
        COALESCE(p3, 0) p3,
        COALESCE(p4, 0) p4,
        COALESCE(p5, 0) p5,
        active,
        created_at,
        updated_at
    FROM
        families
    WHERE
        company_id = p_company_id AND
        id = p_id
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'families' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_get_by_name $$

CREATE PROCEDURE sp_family_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_name VARCHAR(50))
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(p1, 0) p1,
        COALESCE(p2, 0) p2,
        COALESCE(p3, 0) p3,
        COALESCE(p4, 0) p4,
        COALESCE(p5, 0) p5,
        active,
        created_at,
        updated_at
    FROM
        families
    WHERE
        company_id = p_company_id AND
        name LIKE p_name
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'families' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_get_by_any $$

CREATE PROCEDURE sp_family_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                      IN p_any VARCHAR(50))
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(p1, 0) p1,
        COALESCE(p2, 0) p2,
        COALESCE(p3, 0) p3,
        COALESCE(p4, 0) p4,
        COALESCE(p5, 0) p5,
        active,
        created_at,
        updated_at
    FROM
        families
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'families' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_family_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                            IN p_any VARCHAR(50),
                                                            IN p_limit MEDIUMINT UNSIGNED,
                                                            IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(p1, 0) p1,
        COALESCE(p2, 0) p2,
        COALESCE(p3, 0) p3,
        COALESCE(p4, 0) p4,
        COALESCE(p5, 0) p5,
        active,
        created_at,
        updated_at
    FROM
        families
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'families' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_family_get_by_any_reccount $$

CREATE FUNCTION fn_family_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                              p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        families
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'families' table.                               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_insert $$

CREATE PROCEDURE sp_family_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                  IN p_company_id MEDIUMINT UNSIGNED,
                                  IN p_id MEDIUMINT UNSIGNED,
                                  IN p_name VARCHAR(50),
                                  IN p_p1 DECIMAL(6,2) UNSIGNED,
                                  IN p_p2 DECIMAL(6,2) UNSIGNED,
                                  IN p_p3 DECIMAL(6,2) UNSIGNED,
                                  IN p_p4 DECIMAL(6,2) UNSIGNED,
                                  IN p_p5 DECIMAL(6,2) UNSIGNED,
                                  IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'family', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_family_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_family_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_family_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: p1 }
    IF p_p1 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: No puede ser nulo.│';
    END IF;

    IF p_p1 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p1 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p1 }

    -- begin { validate: p2 }
    IF p_p2 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: No puede ser nulo.│';
    END IF;

    IF p_p2 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p2 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p2 }

    -- begin { validate: p3 }
    IF p_p3 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: No puede ser nulo.│';
    END IF;

    IF p_p3 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p3 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p3 }

    -- begin { validate: p4 }
    IF p_p4 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: No puede ser nulo.│';
    END IF;

    IF p_p4 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p4 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p4 }

    -- begin { validate: p5 }
    IF p_p5 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: No puede ser nulo.│';
    END IF;

    IF p_p5 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p5 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p5 }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    -- begin { nullify nulifiable columns }
    IF p_p1 = 0 THEN
        SET p_p1 = NULL;
    END IF;

    IF p_p2 = 0 THEN
        SET p_p2 = NULL;
    END IF;

    IF p_p3 = 0 THEN
        SET p_p3 = NULL;
    END IF;

    IF p_p4 = 0 THEN
        SET p_p4 = NULL;
    END IF;

    IF p_p5 = 0 THEN
        SET p_p5 = NULL;
    END IF;
    -- end { nullify nulifiable columns }

    INSERT INTO families (company_id, id, name, p1, p2, p3, p4, p5, active)
        VALUES (p_company_id, p_id, p_name, p_p1, p_p2, p_p3, p_p4, p_p5, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'families' table.                               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_update $$

CREATE PROCEDURE sp_family_update(IN p_user_id MEDIUMINT UNSIGNED,
                                  IN p_company_id MEDIUMINT UNSIGNED,
                                  IN p_id MEDIUMINT UNSIGNED,
                                  IN p_name VARCHAR(50),
                                  IN p_p1 DECIMAL(6,2) UNSIGNED,
                                  IN p_p2 DECIMAL(6,2) UNSIGNED,
                                  IN p_p3 DECIMAL(6,2) UNSIGNED,
                                  IN p_p4 DECIMAL(6,2) UNSIGNED,
                                  IN p_p5 DECIMAL(6,2) UNSIGNED,
                                  IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_p1 DECIMAL(6,2) UNSIGNED;
    DECLARE v_p2 DECIMAL(6,2) UNSIGNED;
    DECLARE v_p3 DECIMAL(6,2) UNSIGNED;
    DECLARE v_p4 DECIMAL(6,2) UNSIGNED;
    DECLARE v_p5 DECIMAL(6,2) UNSIGNED;
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'family', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_family_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM families WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: p1 }
    IF p_p1 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: No puede ser nulo.│';
    END IF;

    IF p_p1 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p1 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p1 }

    -- begin { validate: p2 }
    IF p_p2 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: No puede ser nulo.│';
    END IF;

    IF p_p2 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p2 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p2 }

    -- begin { validate: p3 }
    IF p_p3 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: No puede ser nulo.│';
    END IF;

    IF p_p3 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p3 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p3 }

    -- begin { validate: p4 }
    IF p_p4 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: No puede ser nulo.│';
    END IF;

    IF p_p4 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p4 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p4 }

    -- begin { validate: p5 }
    IF p_p5 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: No puede ser nulo.│';
    END IF;

    IF p_p5 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p5 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p5 }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        COALESCE(p1, 0) p1,
        COALESCE(p2, 0) p2,
        COALESCE(p3, 0) p3,
        COALESCE(p4, 0) p4,
        COALESCE(p5, 0) p5,
        active
    FROM
        families
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_p1,
        v_p2,
        v_p3,
        v_p4,
        v_p5,
        v_active;

    IF v_name <> p_name OR
       v_p1 <> p_p1 OR
       v_p2 <> p_p2 OR
       v_p3 <> p_p3 OR
       v_p4 <> p_p4 OR
       v_p5 <> p_p5 OR
       v_active <> p_active THEN

        -- begin { nullify nulifiable columns }
        IF p_p1 = 0 THEN
            SET p_p1 = NULL;
        END IF;

        IF p_p2 = 0 THEN
            SET p_p2 = NULL;
        END IF;

        IF p_p3 = 0 THEN
            SET p_p3 = NULL;
        END IF;

        IF p_p4 = 0 THEN
            SET p_p4 = NULL;
        END IF;

        IF p_p5 = 0 THEN
            SET p_p5 = NULL;
        END IF;
        -- end { nullify nulifiable columns }

        UPDATE
            families
        SET
            name = p_name,
            p1 = p_p1,
            p2 = p_p2,
            p3 = p_p3,
            p4 = p_p4,
            p5 = p_p5,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'families' table.                               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_family_delete $$

CREATE PROCEDURE sp_family_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                  IN p_company_id MEDIUMINT UNSIGNED,
                                  IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'family', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_family_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM families WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: FAMILIES
--










--
-- BEGIN: CATEGORIES
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'categories' table.                        *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_category_reccount $$

CREATE FUNCTION fn_category_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        categories
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'categories' table.                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_category_id_exists $$

CREATE FUNCTION fn_category_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                      p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        categories
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'categories' table.                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_category_name_exists $$

CREATE FUNCTION fn_category_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                        p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        categories
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'categories' table.               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_category_is_active $$

CREATE FUNCTION fn_category_is_active(p_company_id MEDIUMINT UNSIGNED,
                                      p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        categories
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'categories' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_category_new_id $$

CREATE FUNCTION fn_category_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM categories WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'categories' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_get_all $$

CREATE PROCEDURE sp_category_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM categories WHERE company_id = p_company_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'categories' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_category_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                           IN p_limit MEDIUMINT UNSIGNED,
                                                           IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM categories WHERE company_id = p_company_id ORDER BY name LIMIT p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'categories' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_get_all_active $$

CREATE PROCEDURE sp_category_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM categories WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'categories' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_get_by_id $$

CREATE PROCEDURE sp_category_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM categories WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'categories' table.                        *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_get_by_name $$

CREATE PROCEDURE sp_category_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                         IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM categories WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'categories' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_get_by_any $$

CREATE PROCEDURE sp_category_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                        IN p_any VARCHAR(50))
BEGIN
    SELECT
        *
    FROM
        categories
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'categories' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_category_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                              IN p_any VARCHAR(50),
                                                              IN p_limit MEDIUMINT UNSIGNED,
                                                              IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        *
    FROM
        categories
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'categories' table.                        *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_category_get_by_any_reccount $$

CREATE FUNCTION fn_category_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                                p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        categories
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'categories' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_insert $$

CREATE PROCEDURE sp_category_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                    IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED,
                                    IN p_name VARCHAR(50),
                                    IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'category', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_category_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_category_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_category_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO categories (company_id, id, name, active)
        VALUES (p_company_id, p_id, p_name, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'categories' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_update $$

CREATE PROCEDURE sp_category_update(IN p_user_id MEDIUMINT UNSIGNED,
                                    IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED,
                                    IN p_name VARCHAR(50),
                                    IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'category', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_category_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM categories WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        active
    FROM
        categories
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_active;

    IF v_name <> p_name OR
       v_active <> p_active THEN

        UPDATE
            categories
        SET
            name = p_name,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'categories' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_category_delete $$

CREATE PROCEDURE sp_category_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                    IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'category', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_category_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM categories WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: CATEGORIES
--










--
-- BEGIN: SUBCATEGORIES
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'subcategories' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_subcategory_reccount $$

CREATE FUNCTION fn_subcategory_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        subcategories
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'subcategories' table.               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_subcategory_id_exists $$

CREATE FUNCTION fn_subcategory_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                         p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        subcategories
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'subcategories' table.              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_subcategory_name_exists $$

CREATE FUNCTION fn_subcategory_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                           p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        subcategories
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'subcategories' table.            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_subcategory_is_active $$

CREATE FUNCTION fn_subcategory_is_active(p_company_id MEDIUMINT UNSIGNED,
                                         p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        subcategories
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'subcategories' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_subcategory_new_id $$

CREATE FUNCTION fn_subcategory_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM subcategories WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'subcategories' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_get_all $$

CREATE PROCEDURE sp_subcategory_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM subcategories WHERE company_id = p_company_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'subcategories' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_subcategory_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                              IN p_limit MEDIUMINT UNSIGNED,
                                                              IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM subcategories WHERE company_id = p_company_id ORDER BY name LIMIT p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'subcategories' table.                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_get_all_active $$

CREATE PROCEDURE sp_subcategory_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM subcategories WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'subcategories' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_get_by_id $$

CREATE PROCEDURE sp_subcategory_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                          IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM subcategories WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'subcategories' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_get_by_name $$

CREATE PROCEDURE sp_subcategory_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                            IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM subcategories WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'subcategories' table.                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_get_by_any $$

CREATE PROCEDURE sp_subcategory_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                           IN p_any VARCHAR(50))
BEGIN
    SELECT
        *
    FROM
        subcategories
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'subcategories' table.                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_subcategory_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                                 IN p_any VARCHAR(50),
                                                                 IN p_limit MEDIUMINT UNSIGNED,
                                                                 IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        *
    FROM
        subcategories
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'subcategories' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_subcategory_get_by_any_reccount $$

CREATE FUNCTION fn_subcategory_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                                   p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        subcategories
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'subcategories' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_insert $$

CREATE PROCEDURE sp_subcategory_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                       IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_id MEDIUMINT UNSIGNED,
                                       IN p_name VARCHAR(50),
                                       IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'subcategory', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_subcategory_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_subcategory_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_subcategory_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO subcategories (company_id, id, name, active)
        VALUES (p_company_id, p_id, p_name, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'subcategories' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_update $$

CREATE PROCEDURE sp_subcategory_update(IN p_user_id MEDIUMINT UNSIGNED,
                                       IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_id MEDIUMINT UNSIGNED,
                                       IN p_name VARCHAR(50),
                                       IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'subcategory', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_subcategory_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM subcategories WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        active
    FROM
        subcategories
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_active;

    IF v_name <> p_name OR
       v_active <> p_active THEN

        UPDATE
            subcategories
        SET
            name = p_name,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'subcategories' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_subcategory_delete $$

CREATE PROCEDURE sp_subcategory_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                       IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'subcategory', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_subcategory_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM subcategories WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: SUBCATEGORIES
--










--
-- BEGIN: BRANDS
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'brands' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_brand_reccount $$

CREATE FUNCTION fn_brand_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        brands
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'brands' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_brand_id_exists $$

CREATE FUNCTION fn_brand_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                   p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        brands
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'brands' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_brand_name_exists $$

CREATE FUNCTION fn_brand_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                     p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        brands
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'brands' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_brand_is_active $$

CREATE FUNCTION fn_brand_is_active(p_company_id MEDIUMINT UNSIGNED,
                                   p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        brands
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'brands' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_brand_new_id $$

CREATE FUNCTION fn_brand_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM brands WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'brands' table.                                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_get_all $$

CREATE PROCEDURE sp_brand_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM brands WHERE company_id = p_company_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'brands' table.                                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_brand_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                        IN p_limit MEDIUMINT UNSIGNED,
                                                        IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM brands WHERE company_id = p_company_id ORDER BY name LIMIT p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'brands' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_get_all_active $$

CREATE PROCEDURE sp_brand_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM brands WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'brands' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_get_by_id $$

CREATE PROCEDURE sp_brand_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM brands WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'brands' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_get_by_name $$

CREATE PROCEDURE sp_brand_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                      IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM brands WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'brands' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_get_by_any $$

CREATE PROCEDURE sp_brand_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                     IN p_any VARCHAR(50))
BEGIN
    SELECT
        *
    FROM
        brands
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'brands' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_brand_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                           IN p_any VARCHAR(50),
                                                           IN p_limit MEDIUMINT UNSIGNED,
                                                           IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        *
    FROM
        brands
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'brands' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_brand_get_by_any_reccount $$

CREATE FUNCTION fn_brand_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                             p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        brands
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'brands' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_insert $$

CREATE PROCEDURE sp_brand_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                 IN p_company_id MEDIUMINT UNSIGNED,
                                 IN p_id MEDIUMINT UNSIGNED,
                                 IN p_name VARCHAR(50),
                                 IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'brand', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_brand_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_brand_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_brand_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO brands (company_id, id, name, active)
        VALUES (p_company_id, p_id, p_name, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'brands' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_update $$

CREATE PROCEDURE sp_brand_update(IN p_user_id MEDIUMINT UNSIGNED,
                                 IN p_company_id MEDIUMINT UNSIGNED,
                                 IN p_id MEDIUMINT UNSIGNED,
                                 IN p_name VARCHAR(50),
                                 IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'brand', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_brand_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM brands WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        active
    FROM
        brands
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_active;

    IF v_name <> p_name OR
       v_active <> p_active THEN

        UPDATE
            brands
        SET
            name = p_name,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'brands' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_brand_delete $$

CREATE PROCEDURE sp_brand_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                 IN p_company_id MEDIUMINT UNSIGNED,
                                 IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'brand', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_brand_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM brands WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: BRANDS
--










--
-- BEGIN: MEASUREMENT_UNITS
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'measurement_units' table.                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_measurement_unit_reccount $$

CREATE FUNCTION fn_measurement_unit_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        measurement_units
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'measurement_units' table.           *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_measurement_unit_id_exists $$

CREATE FUNCTION fn_measurement_unit_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                              p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        measurement_units
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'measurement_units' table.          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_measurement_unit_name_exists $$

CREATE FUNCTION fn_measurement_unit_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                                p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        measurement_units
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a area code exists in the 'measurement_units' table.     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_measurement_unit_symbol_exists $$

CREATE FUNCTION fn_measurement_unit_symbol_exists(p_company_id MEDIUMINT UNSIGNED,
                                                  p_symbol VARCHAR(5))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        measurement_units
    WHERE
        company_id = p_company_id AND
        UPPER(symbol) LIKE UPPER(p_symbol)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'measurement_units' table.        *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_measurement_unit_is_active $$

CREATE FUNCTION fn_measurement_unit_is_active(p_company_id MEDIUMINT UNSIGNED,
                                              p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        measurement_units
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'measurement_units' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_measurement_unit_new_id $$

CREATE FUNCTION fn_measurement_unit_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM measurement_units WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'measurement_units' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_get_all $$

CREATE PROCEDURE sp_measurement_unit_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'measurement_units' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_measurement_unit_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                                   IN p_limit MEDIUMINT UNSIGNED,
                                                                   IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id ORDER BY name LIMIT p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'measurement_units' table.              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_get_all_active $$

CREATE PROCEDURE sp_measurement_unit_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'measurement_units' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_get_by_id $$

CREATE PROCEDURE sp_measurement_unit_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                               IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'measurement_units' table.                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_get_by_name $$

CREATE PROCEDURE sp_measurement_unit_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                                 IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by symbol from the 'measurement_units' table.               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_get_by_symbol $$

CREATE PROCEDURE sp_measurement_unit_get_by_symbol(IN p_company_id MEDIUMINT UNSIGNED,
                                                   IN p_symbol VARCHAR(5))
BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id AND symbol LIKE p_symbol ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'measurement_units' table.            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_get_by_any $$

CREATE PROCEDURE sp_measurement_unit_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                                IN p_any VARCHAR(50))
BEGIN
    SELECT
        *
    FROM
        measurement_units
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any OR
        symbol LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'measurement_units' table.            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_measurement_unit_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                                      IN p_any VARCHAR(50),
                                                                      IN p_limit MEDIUMINT UNSIGNED,
                                                                      IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        *
    FROM
        measurement_units
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any OR
        symbol LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'measurement_units' table.                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_measurement_unit_get_by_any_reccount $$

CREATE FUNCTION fn_measurement_unit_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                                        p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        measurement_units
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any OR
        symbol LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'measurement_units' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_insert $$

CREATE PROCEDURE sp_measurement_unit_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                            IN p_company_id MEDIUMINT UNSIGNED,
                                            IN p_id MEDIUMINT UNSIGNED,
                                            IN p_name VARCHAR(50),
                                            IN p_symbol VARCHAR(5),
                                            IN p_divisible TINYINT UNSIGNED,
                                            IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'measurement_unit', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_measurement_unit_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_measurement_unit_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_measurement_unit_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: symbol }
    IF p_symbol IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: No puede ser nulo.│';
    END IF;

    IF p_symbol = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_symbol) > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: La longitud debe ser como máximo de 5 caracteres.│';
    END IF;

    IF (SELECT fn_measurement_unit_symbol_exists(p_company_id, p_symbol)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: Ya existe.│';
    END IF;
    -- end { validate: symbol }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO measurement_units (company_id, id, name, symbol, divisible, active)
        VALUES (p_company_id, p_id, p_name, p_symbol, p_divisible, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'measurement_units' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_update $$

CREATE PROCEDURE sp_measurement_unit_update(IN p_user_id MEDIUMINT UNSIGNED,
                                            IN p_company_id MEDIUMINT UNSIGNED,
                                            IN p_id MEDIUMINT UNSIGNED,
                                            IN p_name VARCHAR(50),
                                            IN p_symbol VARCHAR(5),
                                            IN p_divisible TINYINT UNSIGNED,
                                            IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_symbol VARCHAR(5);
    DECLARE v_divisible TINYINT UNSIGNED;
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'measurement_unit', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_measurement_unit_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM measurement_units WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: symbol }
    IF p_symbol IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: No puede ser nulo.│';
    END IF;

    IF p_symbol = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_symbol) > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: La longitud debe ser como máximo de 5 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM measurement_units WHERE company_id = p_company_id AND id <> p_id AND UPPER(symbol) LIKE UPPER(p_symbol)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: Ya existe.│';
    END IF;
    -- end { validate: symbol }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        symbol,
        divisible,
        active
    FROM
        measurement_units
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_symbol,
        v_divisible,
        v_active;

    IF v_name <> p_name OR
       v_symbol <> p_symbol OR
       v_divisible <> p_divisible OR
       v_active <> p_active THEN

        UPDATE
            measurement_units
        SET
            name = p_name,
            symbol = p_symbol,
            divisible = p_divisible,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'measurement_units' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_measurement_unit_delete $$

CREATE PROCEDURE sp_measurement_unit_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                            IN p_company_id MEDIUMINT UNSIGNED,
                                            IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'measurement_unit', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_measurement_unit_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM measurement_units WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: MEASUREMENT_UNITS
--










--
-- BEGIN: COUNTRIES
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'countries' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_country_reccount $$

CREATE FUNCTION fn_country_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        countries
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'countries' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_country_id_exists $$

CREATE FUNCTION fn_country_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                     p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        countries
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'countries' table.                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_country_name_exists $$

CREATE FUNCTION fn_country_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                       p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        countries
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a area code exists in the 'countries' table.             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_country_area_code_exists $$

CREATE FUNCTION fn_country_area_code_exists(p_company_id MEDIUMINT UNSIGNED,
                                            p_area_code VARCHAR(5))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        countries
    WHERE
        company_id = p_company_id AND
        UPPER(area_code) LIKE UPPER(p_area_code)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'countries' table.                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_country_is_active $$

CREATE FUNCTION fn_country_is_active(p_company_id MEDIUMINT UNSIGNED,
                                     p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        countries
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'countries' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_country_new_id $$

CREATE FUNCTION fn_country_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM countries WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'countries' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_get_all $$

CREATE PROCEDURE sp_country_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'countries' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_country_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                          IN p_limit MEDIUMINT UNSIGNED,
                                                          IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id ORDER BY name LIMIT p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'countries' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_get_all_active $$

CREATE PROCEDURE sp_country_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'countries' table.                           *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_get_by_id $$

CREATE PROCEDURE sp_country_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                      IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'countries' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_get_by_name $$

CREATE PROCEDURE sp_country_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                        IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by area_code from the 'countries' table.                    *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_get_by_area_code $$

CREATE PROCEDURE sp_country_get_by_area_code(IN p_company_id MEDIUMINT UNSIGNED,
                                             IN p_area_code VARCHAR(5))
BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id AND area_code LIKE p_area_code ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'countries' table.                    *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_get_by_any $$

CREATE PROCEDURE sp_country_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_any VARCHAR(50))
BEGIN
    SELECT
        *
    FROM
        countries
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any OR
        area_code LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'countries' table.                    *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_country_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                             IN p_any VARCHAR(50),
                                                             IN p_limit MEDIUMINT UNSIGNED,
                                                             IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        *
    FROM
        countries
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any OR
        area_code LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'countries' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_country_get_by_any_reccount $$

CREATE FUNCTION fn_country_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                               p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        countries
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any OR
        area_code LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'countries' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_insert $$

CREATE PROCEDURE sp_country_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                   IN p_company_id MEDIUMINT UNSIGNED,
                                   IN p_id MEDIUMINT UNSIGNED,
                                   IN p_name VARCHAR(50),
                                   IN p_area_code VARCHAR(5),
                                   IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'country', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_country_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_country_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_country_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: area_code }
    IF p_area_code IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Prefijo telefónico: No puede ser nulo.│';
    END IF;

    IF p_area_code = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Prefijo telefónico: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_area_code) > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Prefijo telefónico: La longitud debe ser como máximo de 5 caracteres.│';
    END IF;

    IF (SELECT fn_country_area_code_exists(p_company_id, p_area_code)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Prefijo telefónico: Ya existe.│';
    END IF;
    -- end { validate: area_code }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO countries (company_id, id, name, area_code, active)
        VALUES (p_company_id, p_id, p_name, p_area_code, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'countries' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_update $$

CREATE PROCEDURE sp_country_update(IN p_user_id MEDIUMINT UNSIGNED,
                                   IN p_company_id MEDIUMINT UNSIGNED,
                                   IN p_id MEDIUMINT UNSIGNED,
                                   IN p_name VARCHAR(50),
                                   IN p_area_code VARCHAR(5),
                                   IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_area_code VARCHAR(5);
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'country', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_country_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM countries WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: area_code }
    IF p_area_code IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Prefijo telefónico: No puede ser nulo.│';
    END IF;

    IF p_area_code = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Prefijo telefónico: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_area_code) > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Prefijo telefónico: La longitud debe ser como máximo de 5 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM countries WHERE company_id = p_company_id AND id <> p_id AND UPPER(area_code) LIKE UPPER(p_area_code)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Prefijo telefónico: Ya existe.│';
    END IF;
    -- end { validate: area_code }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        area_code,
        active
    FROM
        countries
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_area_code,
        v_active;

    IF v_name <> p_name OR
       v_area_code <> p_area_code OR
       v_active <> p_active THEN

        UPDATE
            countries
        SET
            name = p_name,
            area_code = p_area_code,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'countries' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_country_delete $$

CREATE PROCEDURE sp_country_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                   IN p_company_id MEDIUMINT UNSIGNED,
                                   IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'country', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_country_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM countries WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: COUNTRIES
--










--
-- BEGIN: DEPARS
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'depars' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_depar_reccount $$

CREATE FUNCTION fn_depar_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        depars
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'depars' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_depar_id_exists $$

CREATE FUNCTION fn_depar_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                   p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        depars
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'depars' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_depar_name_exists $$

CREATE FUNCTION fn_depar_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                     p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        depars
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'depars' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_depar_is_active $$

CREATE FUNCTION fn_depar_is_active(p_company_id MEDIUMINT UNSIGNED,
                                   p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        depars
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'depars' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_depar_new_id $$

CREATE FUNCTION fn_depar_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM depars WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'depars' table.                                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_get_all $$

CREATE PROCEDURE sp_depar_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM depars WHERE company_id = p_company_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'depars' table.                                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_depar_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                        IN p_limit MEDIUMINT UNSIGNED,
                                                        IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM depars WHERE company_id = p_company_id ORDER BY name LIMIT p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'depars' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_get_all_active $$

CREATE PROCEDURE sp_depar_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM depars WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'depars' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_get_by_id $$

CREATE PROCEDURE sp_depar_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM depars WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'depars' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_get_by_name $$

CREATE PROCEDURE sp_depar_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                      IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM depars WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'depars' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_get_by_any $$

CREATE PROCEDURE sp_depar_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                     IN p_any VARCHAR(50))
BEGIN
    SELECT
        *
    FROM
        depars
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'depars' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_depar_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                           IN p_any VARCHAR(50),
                                                           IN p_limit MEDIUMINT UNSIGNED,
                                                           IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        *
    FROM
        depars
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'depars' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_depar_get_by_any_reccount $$

CREATE FUNCTION fn_depar_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                             p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        depars
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'depars' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_insert $$

CREATE PROCEDURE sp_depar_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                 IN p_company_id MEDIUMINT UNSIGNED,
                                 IN p_id MEDIUMINT UNSIGNED,
                                 IN p_name VARCHAR(50),
                                 IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'depar', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_depar_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_depar_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_depar_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO depars (company_id, id, name, active)
        VALUES (p_company_id, p_id, p_name, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'depars' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_update $$

CREATE PROCEDURE sp_depar_update(IN p_user_id MEDIUMINT UNSIGNED,
                                 IN p_company_id MEDIUMINT UNSIGNED,
                                 IN p_id MEDIUMINT UNSIGNED,
                                 IN p_name VARCHAR(50),
                                 IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'depar', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_depar_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM depars WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        active
    FROM
        depars
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_active;

    IF v_name <> p_name OR
       v_active <> p_active THEN

        UPDATE
            depars
        SET
            name = p_name,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'depars' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_depar_delete $$

CREATE PROCEDURE sp_depar_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                 IN p_company_id MEDIUMINT UNSIGNED,
                                 IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'depar', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_depar_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM depars WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: DEPARS
--










--
-- BEGIN: CITIES
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'cities' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_city_reccount $$

CREATE FUNCTION fn_city_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        cities
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'cities' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_city_id_exists $$

CREATE FUNCTION fn_city_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                  p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        cities
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'cities' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_city_name_exists $$

CREATE FUNCTION fn_city_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                    p_name VARCHAR(50),
                                    p_depar_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        cities
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name) AND
        depar_id = p_depar_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'cities' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_city_is_active $$

CREATE FUNCTION fn_city_is_active(p_company_id MEDIUMINT UNSIGNED,
                                  p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        cities
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'cities' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_city_new_id $$

CREATE FUNCTION fn_city_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM cities WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'cities' table.                                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_get_all $$

CREATE PROCEDURE sp_city_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.depar_id,
        b.name AS depar_name,
        CONCAT(b.name, " > ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        cities a
        INNER JOIN depars b
            ON a.depar_id = b.id
    WHERE
        a.company_id = p_company_id
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'cities' table.                                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_city_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                       IN p_limit MEDIUMINT UNSIGNED,
                                                       IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.depar_id,
        b.name AS depar_name,
        CONCAT(b.name, " > ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        cities a
        INNER JOIN depars b
            ON a.depar_id = b.id
    WHERE
        a.company_id = p_company_id
    ORDER BY
        full_name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'cities' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_get_all_active $$

CREATE PROCEDURE sp_city_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.depar_id,
        b.name AS depar_name,
        CONCAT(b.name, " > ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        cities a
        INNER JOIN depars b
            ON a.depar_id = b.id
    WHERE
        a.company_id = p_company_id AND
        a.active = 1
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'cities' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_get_by_id $$

CREATE PROCEDURE sp_city_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                   IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.depar_id,
        b.name AS depar_name,
        CONCAT(b.name, " > ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        cities a
        INNER JOIN depars b
            ON a.depar_id = b.id
    WHERE
        a.company_id = p_company_id AND
        a.id = p_id
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'cities' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_get_by_name $$

CREATE PROCEDURE sp_city_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                     IN p_name VARCHAR(50),
                                     IN p_depar_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.depar_id,
        b.name AS depar_name,
        CONCAT(b.name, " > ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        cities a
        INNER JOIN depars b
            ON a.depar_id = b.id
    WHERE
        a.company_id = p_company_id AND
        a.name LIKE p_name AND
        a.depar_id = p_depar_id
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'cities' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_get_by_any $$

CREATE PROCEDURE sp_city_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_any VARCHAR(50))
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.depar_id,
        b.name AS depar_name,
        CONCAT(b.name, " > ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        cities a
        INNER JOIN depars b
            ON a.depar_id = b.id
    WHERE
        a.company_id = p_company_id AND
        (a.id LIKE p_any OR
        CONCAT(b.name, " > ", a.name) LIKE p_any)
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'cities' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_city_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                          IN p_any VARCHAR(50),
                                                          IN p_limit MEDIUMINT UNSIGNED,
                                                          IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.depar_id,
        b.name AS depar_name,
        CONCAT(b.name, " > ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        cities a
        INNER JOIN depars b
            ON a.depar_id = b.id
    WHERE
        a.company_id = p_company_id AND
        (a.id LIKE p_any OR
        CONCAT(b.name, " > ", a.name) LIKE p_any)
    ORDER BY
        full_name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'cities' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_city_get_by_any_reccount $$

CREATE FUNCTION fn_city_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                            p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        cities a
        INNER JOIN depars b
            ON a.depar_id = b.id
    WHERE
        a.company_id = p_company_id AND
        (a.id LIKE p_any OR
        CONCAT(b.name, " > ", a.name) LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'cities' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_insert $$

CREATE PROCEDURE sp_city_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                IN p_company_id MEDIUMINT UNSIGNED,
                                IN p_id MEDIUMINT UNSIGNED,
                                IN p_name VARCHAR(50),
                                IN p_depar_id MEDIUMINT UNSIGNED,
                                IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'city', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_city_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_city_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: depar_id }
    IF p_depar_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: No puede ser nulo.│';
    END IF;

    IF p_depar_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: Debe ser mayor que cero.│';
    END IF;

    IF p_depar_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_depar_id_exists(p_company_id, p_depar_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: No existe.│';
    END IF;

    IF NOT (SELECT fn_depar_is_active(p_company_id, p_depar_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: No vigente.│';
    END IF;
    -- end { validate: depar_id }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    -- begin { validate: name }
    IF (SELECT fn_city_name_exists(p_company_id, p_name, p_depar_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    INSERT INTO cities (company_id, id, name, depar_id, active)
        VALUES (p_company_id, p_id, p_name, p_depar_id, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'cities' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_update $$

CREATE PROCEDURE sp_city_update(IN p_user_id MEDIUMINT UNSIGNED,
                                IN p_company_id MEDIUMINT UNSIGNED,
                                IN p_id MEDIUMINT UNSIGNED,
                                IN p_name VARCHAR(50),
                                IN p_depar_id MEDIUMINT UNSIGNED,
                                IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_depar_id MEDIUMINT UNSIGNED;
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'city', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_city_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: depar_id }
    IF p_depar_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: No puede ser nulo.│';
    END IF;

    IF p_depar_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: Debe ser mayor que cero.│';
    END IF;

    IF p_depar_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_depar_id_exists(p_company_id, p_depar_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: No existe.│';
    END IF;

    IF NOT (SELECT fn_depar_is_active(p_company_id, p_depar_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Departamento: No vigente.│';
    END IF;
    -- end { validate: depar_id }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    -- begin { validate: name }
    IF EXISTS(SELECT * FROM cities WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name) AND depar_id = p_depar_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    SELECT
        name,
        depar_id,
        active
    FROM
        cities
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_depar_id,
        v_active;

    IF v_name <> p_name OR
       v_depar_id <> p_depar_id OR
       v_active <> p_active THEN

        UPDATE
            cities
        SET
            name = p_name,
            depar_id = p_depar_id,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'cities' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_city_delete $$

CREATE PROCEDURE sp_city_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                IN p_company_id MEDIUMINT UNSIGNED,
                                IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'city', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_city_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM cities WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: CITIES
--










--
-- BEGIN: MACHINES
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'machines' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_machine_reccount $$

CREATE FUNCTION fn_machine_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        machines
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'machines' table.                    *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_machine_id_exists $$

CREATE FUNCTION fn_machine_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                     p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        machines
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'machines' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_machine_name_exists $$

CREATE FUNCTION fn_machine_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                       p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        machines
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'machines' table.                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_machine_is_active $$

CREATE FUNCTION fn_machine_is_active(p_company_id MEDIUMINT UNSIGNED,
                                     p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        machines
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'machines' table.                               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_machine_new_id $$

CREATE FUNCTION fn_machine_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM machines WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'machines' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_get_all $$

CREATE PROCEDURE sp_machine_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM machines WHERE company_id = p_company_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'machines' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_machine_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                          IN p_limit MEDIUMINT UNSIGNED,
                                                          IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM machines WHERE company_id = p_company_id ORDER BY name LIMIT p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'machines' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_get_all_active $$

CREATE PROCEDURE sp_machine_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM machines WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'machines' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_get_by_id $$

CREATE PROCEDURE sp_machine_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                      IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM machines WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'machines' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_get_by_name $$

CREATE PROCEDURE sp_machine_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                        IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM machines WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'machines' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_get_by_any $$

CREATE PROCEDURE sp_machine_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_any VARCHAR(50))
BEGIN
    SELECT
        *
    FROM
        machines
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'machines' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_machine_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                             IN p_any VARCHAR(50),
                                                             IN p_limit MEDIUMINT UNSIGNED,
                                                             IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        *
    FROM
        machines
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'machines' table.                          *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_machine_get_by_any_reccount $$

CREATE FUNCTION fn_machine_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                               p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        machines
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'machines' table.                               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_insert $$

CREATE PROCEDURE sp_machine_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                   IN p_company_id MEDIUMINT UNSIGNED,
                                   IN p_id MEDIUMINT UNSIGNED,
                                   IN p_name VARCHAR(50),
                                   IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'machine', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_machine_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_machine_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_machine_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO machines (company_id, id, name, active)
        VALUES (p_company_id, p_id, p_name, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'machines' table.                               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_update $$

CREATE PROCEDURE sp_machine_update(IN p_user_id MEDIUMINT UNSIGNED,
                                   IN p_company_id MEDIUMINT UNSIGNED,
                                   IN p_id MEDIUMINT UNSIGNED,
                                   IN p_name VARCHAR(50),
                                   IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'machine', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_machine_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM machines WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        active
    FROM
        machines
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_active;

    IF v_name <> p_name OR
       v_active <> p_active THEN

        UPDATE
            machines
        SET
            name = p_name,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'machines' table.                               *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_machine_delete $$

CREATE PROCEDURE sp_machine_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                   IN p_company_id MEDIUMINT UNSIGNED,
                                   IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'machine', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_machine_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM machines WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: MACHINES
--










--
-- BEGIN: WO_BRANDS
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'wo_brands' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_brand_reccount $$

CREATE FUNCTION fn_wo_brand_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        wo_brands
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'wo_brands' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_brand_id_exists $$

CREATE FUNCTION fn_wo_brand_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                      p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        wo_brands
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'wo_brands' table.                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_brand_name_exists $$

CREATE FUNCTION fn_wo_brand_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                        p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        wo_brands
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'wo_brands' table.                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_brand_is_active $$

CREATE FUNCTION fn_wo_brand_is_active(p_company_id MEDIUMINT UNSIGNED,
                                      p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        wo_brands
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'wo_brands' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_brand_new_id $$

CREATE FUNCTION fn_wo_brand_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM wo_brands WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'wo_brands' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_get_all $$

CREATE PROCEDURE sp_wo_brand_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM wo_brands WHERE company_id = p_company_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'wo_brands' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_wo_brand_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                           IN p_limit MEDIUMINT UNSIGNED,
                                                           IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM wo_brands WHERE company_id = p_company_id ORDER BY name LIMIT p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'wo_brands' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_get_all_active $$

CREATE PROCEDURE sp_wo_brand_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM wo_brands WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'wo_brands' table.                           *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_get_by_id $$

CREATE PROCEDURE sp_wo_brand_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM wo_brands WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'wo_brands' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_get_by_name $$

CREATE PROCEDURE sp_wo_brand_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                         IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM wo_brands WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'wo_brands' table.                    *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_get_by_any $$

CREATE PROCEDURE sp_wo_brand_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                        IN p_any VARCHAR(50))
BEGIN
    SELECT
        *
    FROM
        wo_brands
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'wo_brands' table.                    *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_wo_brand_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                              IN p_any VARCHAR(50),
                                                              IN p_limit MEDIUMINT UNSIGNED,
                                                              IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        *
    FROM
        wo_brands
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'wo_brands' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_brand_get_by_any_reccount $$

CREATE FUNCTION fn_wo_brand_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                                p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        wo_brands
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'wo_brands' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_insert $$

CREATE PROCEDURE sp_wo_brand_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                    IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED,
                                    IN p_name VARCHAR(50),
                                    IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'wo_brand', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_wo_brand_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_wo_brand_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_wo_brand_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO wo_brands (company_id, id, name, active)
        VALUES (p_company_id, p_id, p_name, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'wo_brands' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_update $$

CREATE PROCEDURE sp_wo_brand_update(IN p_user_id MEDIUMINT UNSIGNED,
                                    IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED,
                                    IN p_name VARCHAR(50),
                                    IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'wo_brand', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_wo_brand_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM wo_brands WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        active
    FROM
        wo_brands
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_active;

    IF v_name <> p_name OR
       v_active <> p_active THEN

        UPDATE
            wo_brands
        SET
            name = p_name,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'wo_brands' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_brand_delete $$

CREATE PROCEDURE sp_wo_brand_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                    IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'wo_brand', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_wo_brand_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM wo_brands WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: WO_BRANDS
--









--
-- BEGIN: MODELS
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'models' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_model_reccount $$

CREATE FUNCTION fn_model_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        models
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'models' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_model_id_exists $$

CREATE FUNCTION fn_model_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                   p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        models
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'models' table.                     *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_model_name_exists $$

CREATE FUNCTION fn_model_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                     p_name VARCHAR(50),
                                     p_machine_id MEDIUMINT UNSIGNED,
                                     p_brand_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        models
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name) AND
        machine_id = p_machine_id AND
        brand_id = p_brand_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'models' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_model_is_active $$

CREATE FUNCTION fn_model_is_active(p_company_id MEDIUMINT UNSIGNED,
                                   p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        models
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'models' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_model_new_id $$

CREATE FUNCTION fn_model_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM models WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'models' table.                                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_get_all $$

CREATE PROCEDURE sp_model_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.machine_id,
        b.name AS machine_name,
        a.brand_id,
        c.name AS brand_name,
        CONCAT(b.name, " ", c.name, " ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        models a
        INNER JOIN machines b
            ON a.machine_id = b.id
        INNER JOIN wo_brands c
            ON a.brand_id = c.id
    WHERE
        a.company_id = p_company_id
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'models' table.                                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_model_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                        IN p_limit MEDIUMINT UNSIGNED,
                                                        IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.machine_id,
        b.name AS machine_name,
        a.brand_id,
        c.name AS brand_name,
        CONCAT(b.name, " ", c.name, " ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        models a
        INNER JOIN machines b
            ON a.machine_id = b.id
        INNER JOIN wo_brands c
            ON a.brand_id = c.id
    WHERE
        a.company_id = p_company_id
    ORDER BY
        full_name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'models' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_get_all_active $$

CREATE PROCEDURE sp_model_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.machine_id,
        b.name AS machine_name,
        a.brand_id,
        c.name AS brand_name,
        CONCAT(b.name, " ", c.name, " ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        models a
        INNER JOIN machines b
            ON a.machine_id = b.id
        INNER JOIN wo_brands c
            ON a.brand_id = c.id
    WHERE
        a.company_id = p_company_id AND
        a.active = 1
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'models' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_get_by_id $$

CREATE PROCEDURE sp_model_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.machine_id,
        b.name AS machine_name,
        a.brand_id,
        c.name AS brand_name,
        CONCAT(b.name, " ", c.name, " ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        models a
        INNER JOIN machines b
            ON a.machine_id = b.id
        INNER JOIN wo_brands c
            ON a.brand_id = c.id
    WHERE
        a.company_id = p_company_id AND
        a.id = p_id
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'models' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_get_by_name $$

CREATE PROCEDURE sp_model_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                      IN p_name VARCHAR(50),
                                      IN p_machine_id MEDIUMINT UNSIGNED,
                                      IN p_brand_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.machine_id,
        b.name AS machine_name,
        a.brand_id,
        c.name AS brand_name,
        CONCAT(b.name, " ", c.name, " ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        models a
        INNER JOIN machines b
            ON a.machine_id = b.id
        INNER JOIN wo_brands c
            ON a.brand_id = c.id
    WHERE
        a.company_id = p_company_id AND
        a.name LIKE p_name AND
        a.machine_id = p_machine_id AND
        a.brand_id = p_brand_id
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'models' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_get_by_any $$

CREATE PROCEDURE sp_model_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                     IN p_any VARCHAR(50))
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.machine_id,
        b.name AS machine_name,
        a.brand_id,
        c.name AS brand_name,
        CONCAT(b.name, " ", c.name, " ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        models a
        INNER JOIN machines b
            ON a.machine_id = b.id
        INNER JOIN wo_brands c
            ON a.brand_id = c.id
    WHERE
        a.company_id = p_company_id AND
        (a.id LIKE p_any OR
        CONCAT(b.name, " ", c.name, " ", a.name) LIKE p_any)
    ORDER BY
        full_name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'models' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_model_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                           IN p_any VARCHAR(50),
                                                           IN p_limit MEDIUMINT UNSIGNED,
                                                           IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        a.company_id,
        a.id,
        a.name,
        a.machine_id,
        b.name AS machine_name,
        a.brand_id,
        c.name AS brand_name,
        CONCAT(b.name, " ", c.name, " ", a.name) AS full_name,
        a.active,
        a.created_at,
        a.updated_at
    FROM
        models a
        INNER JOIN machines b
            ON a.machine_id = b.id
        INNER JOIN wo_brands c
            ON a.brand_id = c.id
    WHERE
        a.company_id = p_company_id AND
        (a.id LIKE p_any OR
        CONCAT(b.name, " ", c.name, " ", a.name) LIKE p_any)
    ORDER BY
        full_name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'models' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_model_get_by_any_reccount $$

CREATE FUNCTION fn_model_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                             p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        models a
        INNER JOIN machines b
            ON a.machine_id = b.id
        INNER JOIN wo_brands c
            ON a.brand_id = c.id
    WHERE
        a.company_id = p_company_id AND
        (a.id LIKE p_any OR
        CONCAT(b.name, " ", c.name, " ", a.name) LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'models' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_insert $$

CREATE PROCEDURE sp_model_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                 IN p_company_id MEDIUMINT UNSIGNED,
                                 IN p_id MEDIUMINT UNSIGNED,
                                 IN p_name VARCHAR(50),
                                 IN p_machine_id MEDIUMINT UNSIGNED,
                                 IN p_brand_id MEDIUMINT UNSIGNED,
                                 IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'model', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_model_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_model_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: machine_id }
    IF p_machine_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: No puede ser nulo.│';
    END IF;

    IF p_machine_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: Debe ser mayor que cero.│';
    END IF;

    IF p_machine_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_machine_id_exists(p_company_id, p_machine_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: No existe.│';
    END IF;

    IF NOT (SELECT fn_machine_is_active(p_company_id, p_machine_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: No vigente.│';
    END IF;
    -- end { validate: machine_id }

    -- begin { validate: brand_id }
    IF p_brand_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: No puede ser nulo.│';
    END IF;

    IF p_brand_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: Debe ser mayor que cero.│';
    END IF;

    IF p_brand_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_wo_brand_id_exists(p_company_id, p_brand_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: No existe.│';
    END IF;

    IF NOT (SELECT fn_wo_brand_is_active(p_company_id, p_brand_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: No vigente.│';
    END IF;
    -- end { validate: brand_id }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    -- begin { validate: name }
    IF (SELECT fn_model_name_exists(p_company_id, p_name, p_machine_id, p_brand_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    INSERT INTO models (company_id, id, name, machine_id, brand_id, active)
        VALUES (p_company_id, p_id, p_name, p_machine_id, p_brand_id, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'models' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_update $$

CREATE PROCEDURE sp_model_update(IN p_user_id MEDIUMINT UNSIGNED,
                                 IN p_company_id MEDIUMINT UNSIGNED,
                                 IN p_id MEDIUMINT UNSIGNED,
                                 IN p_name VARCHAR(50),
                                 IN p_machine_id MEDIUMINT UNSIGNED,
                                 IN p_brand_id MEDIUMINT UNSIGNED,
                                 IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_machine_id MEDIUMINT UNSIGNED;
    DECLARE v_brand_id MEDIUMINT UNSIGNED;
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'model', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_model_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: machine_id }
    IF p_machine_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: No puede ser nulo.│';
    END IF;

    IF p_machine_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: Debe ser mayor que cero.│';
    END IF;

    IF p_machine_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_machine_id_exists(p_company_id, p_machine_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: No existe.│';
    END IF;

    IF NOT (SELECT fn_machine_is_active(p_company_id, p_machine_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Máquina: No vigente.│';
    END IF;
    -- end { validate: machine_id }

    -- begin { validate: brand_id }
    IF p_brand_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: No puede ser nulo.│';
    END IF;

    IF p_brand_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: Debe ser mayor que cero.│';
    END IF;

    IF p_brand_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_wo_brand_id_exists(p_company_id, p_brand_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: No existe.│';
    END IF;

    IF NOT (SELECT fn_wo_brand_is_active(p_company_id, p_brand_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Marca: No vigente.│';
    END IF;
    -- end { validate: brand_id }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    -- begin { validate: name }
    IF EXISTS(SELECT * FROM models WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name) AND machine_id = p_machine_id AND brand_id = p_brand_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    SELECT
        name,
        machine_id,
        brand_id,
        active
    FROM
        models
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_machine_id,
        v_brand_id,
        v_active;

    IF v_name <> p_name OR
       v_machine_id <> p_machine_id OR
       v_brand_id <> p_brand_id OR
       v_active <> p_active THEN

        UPDATE
            models
        SET
            name = p_name,
            machine_id = p_machine_id,
            brand_id = p_brand_id,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'models' table.                                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_model_delete $$

CREATE PROCEDURE sp_model_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                 IN p_company_id MEDIUMINT UNSIGNED,
                                 IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'model', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_model_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM models WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: MODELS
--










--
-- BEGIN: WO_STATUSES
--


/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'wo_statuses' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_status_reccount $$

CREATE FUNCTION fn_wo_status_reccount(p_company_id MEDIUMINT UNSIGNED)
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        wo_statuses
    WHERE
        company_id = p_company_id
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'wo_statuses' table.                 *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_status_id_exists $$

CREATE FUNCTION fn_wo_status_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                       p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        wo_statuses
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'wo_statuses' table.                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_status_name_exists $$

CREATE FUNCTION fn_wo_status_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                         p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        wo_statuses
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'wo_statuses' table.              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_status_is_active $$

CREATE FUNCTION fn_wo_status_is_active(p_company_id MEDIUMINT UNSIGNED,
                                       p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        wo_statuses
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'wo_statuses' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_status_new_id $$

CREATE FUNCTION fn_wo_status_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM wo_statuses WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'wo_statuses' table.                           *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_get_all $$

CREATE PROCEDURE sp_wo_status_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM wo_statuses WHERE company_id = p_company_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'wo_statuses' table.                           *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_get_all_with_limit_and_offset $$

CREATE PROCEDURE sp_wo_status_get_all_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                            IN p_limit MEDIUMINT UNSIGNED,
                                                            IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM wo_statuses WHERE company_id = p_company_id ORDER BY name LIMIT p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'wo_statuses' table.                    *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_get_all_active $$

CREATE PROCEDURE sp_wo_status_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM wo_statuses WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'wo_statuses' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_get_by_id $$

CREATE PROCEDURE sp_wo_status_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                        IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT * FROM wo_statuses WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'wo_statuses' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_get_by_name $$

CREATE PROCEDURE sp_wo_status_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                          IN p_name VARCHAR(50))
BEGIN
    SELECT * FROM wo_statuses WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'wo_statuses' table.                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_get_by_any $$

CREATE PROCEDURE sp_wo_status_get_by_any(IN p_company_id MEDIUMINT UNSIGNED,
                                         IN p_any VARCHAR(50))
BEGIN
    SELECT
        *
    FROM
        wo_statuses
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by any field from the 'wo_statuses' table.                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_get_by_any_with_limit_and_offset $$

CREATE PROCEDURE sp_wo_status_get_by_any_with_limit_and_offset(IN p_company_id MEDIUMINT UNSIGNED,
                                                               IN p_any VARCHAR(50),
                                                               IN p_limit MEDIUMINT UNSIGNED,
                                                               IN p_offset MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        *
    FROM
        wo_statuses
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    ORDER BY
        name
    LIMIT
        p_limit OFFSET p_offset;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get the number of rows in 'wo_statuses' table.                       *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_wo_status_get_by_any_reccount $$

CREATE FUNCTION fn_wo_status_get_by_any_reccount(p_company_id MEDIUMINT UNSIGNED,
                                                 p_any VARCHAR(50))
       RETURNS SMALLINT UNSIGNED
BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        wo_statuses
    WHERE
        company_id = p_company_id AND
        (id LIKE p_any OR
        name LIKE p_any)
    INTO
        v_row;

    RETURN v_row;
END $$

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'wo_statuses' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_insert $$

CREATE PROCEDURE sp_wo_status_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                     IN p_company_id MEDIUMINT UNSIGNED,
                                     IN p_id MEDIUMINT UNSIGNED,
                                     IN p_name VARCHAR(50),
                                     IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'wo_status', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_wo_status_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_wo_status_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_wo_status_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    INSERT INTO wo_statuses (company_id, id, name, active)
        VALUES (p_company_id, p_id, p_name, p_active);
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'wo_statuses' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_update $$

CREATE PROCEDURE sp_wo_status_update(IN p_user_id MEDIUMINT UNSIGNED,
                                     IN p_company_id MEDIUMINT UNSIGNED,
                                     IN p_id MEDIUMINT UNSIGNED,
                                     IN p_name VARCHAR(50),
                                     IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'wo_status', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_wo_status_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM wo_statuses WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        active
    FROM
        wo_statuses
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_active;

    IF v_name <> p_name OR
       v_active <> p_active THEN

        UPDATE
            wo_statuses
        SET
            name = p_name,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to delete rows into the 'wo_statuses' table.                            *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_wo_status_delete $$

CREATE PROCEDURE sp_wo_status_delete(IN p_user_id MEDIUMINT UNSIGNED,
                                     IN p_company_id MEDIUMINT UNSIGNED,
                                     IN p_id MEDIUMINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'wo_status', 'delete');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_wo_status_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    DELETE FROM wo_statuses WHERE company_id = p_company_id AND id = p_id;
END $$

DELIMITER ;

--
-- END: WO_STATUSES
--










--
-- BEGIN: SUPPLIERS
--

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID exists in the 'suppliers' table.                   *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_supplier_id_exists $$

CREATE FUNCTION fn_supplier_id_exists(p_company_id MEDIUMINT UNSIGNED,
                                      p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        suppliers
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if a name exists in the 'suppliers' table.                  *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_supplier_name_exists $$

CREATE FUNCTION fn_supplier_name_exists(p_company_id MEDIUMINT UNSIGNED,
                                        p_name VARCHAR(50))
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        suppliers
    WHERE
        company_id = p_company_id AND
        UPPER(name) LIKE UPPER(p_name)
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to find out if an ID is active in the 'suppliers' table.                *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_supplier_is_active $$

CREATE FUNCTION fn_supplier_is_active(p_company_id MEDIUMINT UNSIGNED,
                                      p_id MEDIUMINT UNSIGNED)
       RETURNS TINYINT UNSIGNED
BEGIN
    DECLARE v_row TINYINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*)
    FROM
        suppliers
    WHERE
        company_id = p_company_id AND
        id = p_id AND
        active = 1
    INTO
        v_row;

    RETURN v_row;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * FN to get a new ID for the 'suppliers' table.                              *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP FUNCTION IF EXISTS fn_supplier_new_id $$

CREATE FUNCTION fn_supplier_new_id(p_company_id MEDIUMINT UNSIGNED)
       RETURNS MEDIUMINT UNSIGNED
BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM suppliers WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all rows from the 'suppliers' table.                             *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_supplier_get_all $$

CREATE PROCEDURE sp_supplier_get_all(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(addr1, '') addr1,
        COALESCE(addr2, '') addr2,
        COALESCE(city, '') city,
        COALESCE(phone, '') phone,
        COALESCE(fax, '') fax,
        COALESCE(email, '') email,
        COALESCE(tin, '') tin,
        COALESCE(days_term, '') days_term,
        COALESCE(owner, '') owner,
        COALESCE(ownerphone, '') ownerphone,
        COALESCE(gralmanag, '') gralmanag,
        COALESCE(gmphone, '') gmphone,
        COALESCE(salesmanag, '') salesmanag,
        COALESCE(smphone, '') smphone,
        COALESCE(mkgmanag, '') mkgmanag,
        COALESCE(mmphone, '') mmphone,
        COALESCE(techserv, '') techserv,
        COALESCE(tsaddr1, '') tsaddr1,
        COALESCE(tsaddr2, '') tsaddr2,
        COALESCE(tsphone, '') tsphone,
        COALESCE(tscontact, '') tscontact,
        COALESCE(seller1, '') seller1,
        COALESCE(artline1, '') artline1,
        COALESCE(salesphone1, '') salesphone1,
        COALESCE(seller2, '') seller2,
        COALESCE(artline2, '') artline2,
        COALESCE(salesphone2, '') salesphone2,
        COALESCE(seller3, '') seller3,
        COALESCE(artline3, '') artline3,
        COALESCE(salesphone3, '') salesphone3,
        COALESCE(seller4, '') seller4,
        COALESCE(artline4, '') artline4,
        COALESCE(salesphone4, '') salesphone4,
        COALESCE(seller5, '') seller5,
        COALESCE(artline5, '') artline5,
        COALESCE(salesphone5, '') salesphone5,
        COALESCE(pyg_balance, '') pyg_balance,
        COALESCE(usd_balance, '') usd_balance,
        active,
        created_at,
        updated_at
    FROM
        suppliers
    WHERE
        company_id = p_company_id
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get all active rows from the 'suppliers' table.                      *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_supplier_get_all_active $$

CREATE PROCEDURE sp_supplier_get_all_active(IN p_company_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(addr1, '') addr1,
        COALESCE(addr2, '') addr2,
        COALESCE(city, '') city,
        COALESCE(phone, '') phone,
        COALESCE(fax, '') fax,
        COALESCE(email, '') email,
        COALESCE(tin, '') tin,
        COALESCE(days_term, '') days_term,
        COALESCE(owner, '') owner,
        COALESCE(ownerphone, '') ownerphone,
        COALESCE(gralmanag, '') gralmanag,
        COALESCE(gmphone, '') gmphone,
        COALESCE(salesmanag, '') salesmanag,
        COALESCE(smphone, '') smphone,
        COALESCE(mkgmanag, '') mkgmanag,
        COALESCE(mmphone, '') mmphone,
        COALESCE(techserv, '') techserv,
        COALESCE(tsaddr1, '') tsaddr1,
        COALESCE(tsaddr2, '') tsaddr2,
        COALESCE(tsphone, '') tsphone,
        COALESCE(tscontact, '') tscontact,
        COALESCE(seller1, '') seller1,
        COALESCE(artline1, '') artline1,
        COALESCE(salesphone1, '') salesphone1,
        COALESCE(seller2, '') seller2,
        COALESCE(artline2, '') artline2,
        COALESCE(salesphone2, '') salesphone2,
        COALESCE(seller3, '') seller3,
        COALESCE(artline3, '') artline3,
        COALESCE(salesphone3, '') salesphone3,
        COALESCE(seller4, '') seller4,
        COALESCE(artline4, '') artline4,
        COALESCE(salesphone4, '') salesphone4,
        COALESCE(seller5, '') seller5,
        COALESCE(artline5, '') artline5,
        COALESCE(salesphone5, '') salesphone5,
        COALESCE(pyg_balance, '') pyg_balance,
        COALESCE(usd_balance, '') usd_balance,
        active,
        created_at,
        updated_at
    FROM
        suppliers
    WHERE
        company_id = p_company_id AND
        active = 1
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by ID from the 'suppliers' table.                           *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_supplier_get_by_id $$

CREATE PROCEDURE sp_supplier_get_by_id(IN p_company_id MEDIUMINT UNSIGNED,
                                       IN p_id MEDIUMINT UNSIGNED)
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(addr1, '') addr1,
        COALESCE(addr2, '') addr2,
        COALESCE(city, '') city,
        COALESCE(phone, '') phone,
        COALESCE(fax, '') fax,
        COALESCE(email, '') email,
        COALESCE(tin, '') tin,
        COALESCE(days_term, '') days_term,
        COALESCE(owner, '') owner,
        COALESCE(ownerphone, '') ownerphone,
        COALESCE(gralmanag, '') gralmanag,
        COALESCE(gmphone, '') gmphone,
        COALESCE(salesmanag, '') salesmanag,
        COALESCE(smphone, '') smphone,
        COALESCE(mkgmanag, '') mkgmanag,
        COALESCE(mmphone, '') mmphone,
        COALESCE(techserv, '') techserv,
        COALESCE(tsaddr1, '') tsaddr1,
        COALESCE(tsaddr2, '') tsaddr2,
        COALESCE(tsphone, '') tsphone,
        COALESCE(tscontact, '') tscontact,
        COALESCE(seller1, '') seller1,
        COALESCE(artline1, '') artline1,
        COALESCE(salesphone1, '') salesphone1,
        COALESCE(seller2, '') seller2,
        COALESCE(artline2, '') artline2,
        COALESCE(salesphone2, '') salesphone2,
        COALESCE(seller3, '') seller3,
        COALESCE(artline3, '') artline3,
        COALESCE(salesphone3, '') salesphone3,
        COALESCE(seller4, '') seller4,
        COALESCE(artline4, '') artline4,
        COALESCE(salesphone4, '') salesphone4,
        COALESCE(seller5, '') seller5,
        COALESCE(artline5, '') artline5,
        COALESCE(salesphone5, '') salesphone5,
        COALESCE(pyg_balance, '') pyg_balance,
        COALESCE(usd_balance, '') usd_balance,
        active,
        created_at,
        updated_at
    FROM
        suppliers
    WHERE
        company_id = p_company_id AND
        id = p_id
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to get rows by name from the 'suppliers' table.                         *
 * -------------------------------------------------------------------------- */
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_supplier_get_by_name $$

CREATE PROCEDURE sp_supplier_get_by_name(IN p_company_id MEDIUMINT UNSIGNED,
                                         IN p_name VARCHAR(50))
BEGIN
    SELECT
        company_id,
        id,
        name,
        COALESCE(addr1, '') addr1,
        COALESCE(addr2, '') addr2,
        COALESCE(city, '') city,
        COALESCE(phone, '') phone,
        COALESCE(fax, '') fax,
        COALESCE(email, '') email,
        COALESCE(tin, '') tin,
        COALESCE(days_term, '') days_term,
        COALESCE(owner, '') owner,
        COALESCE(ownerphone, '') ownerphone,
        COALESCE(gralmanag, '') gralmanag,
        COALESCE(gmphone, '') gmphone,
        COALESCE(salesmanag, '') salesmanag,
        COALESCE(smphone, '') smphone,
        COALESCE(mkgmanag, '') mkgmanag,
        COALESCE(mmphone, '') mmphone,
        COALESCE(techserv, '') techserv,
        COALESCE(tsaddr1, '') tsaddr1,
        COALESCE(tsaddr2, '') tsaddr2,
        COALESCE(tsphone, '') tsphone,
        COALESCE(tscontact, '') tscontact,
        COALESCE(seller1, '') seller1,
        COALESCE(artline1, '') artline1,
        COALESCE(salesphone1, '') salesphone1,
        COALESCE(seller2, '') seller2,
        COALESCE(artline2, '') artline2,
        COALESCE(salesphone2, '') salesphone2,
        COALESCE(seller3, '') seller3,
        COALESCE(artline3, '') artline3,
        COALESCE(salesphone3, '') salesphone3,
        COALESCE(seller4, '') seller4,
        COALESCE(artline4, '') artline4,
        COALESCE(salesphone4, '') salesphone4,
        COALESCE(seller5, '') seller5,
        COALESCE(artline5, '') artline5,
        COALESCE(salesphone5, '') salesphone5,
        COALESCE(pyg_balance, '') pyg_balance,
        COALESCE(usd_balance, '') usd_balance,
        active,
        created_at,
        updated_at
    FROM
        suppliers
    WHERE
        company_id = p_company_id AND
        name LIKE p_name
    ORDER BY
        name;
END $$

DELIMITER ;

/* -------------------------------------------------------------------------- *
 * SP to insert rows into the 'suppliers' table.                              *
 * -------------------------------------------------------------------------- */

/*
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_supplier_insert $$

CREATE PROCEDURE sp_supplier_insert(IN p_user_id MEDIUMINT UNSIGNED,
                                    IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED,
                                    IN p_name VARCHAR(50),
                                    IN p_addr1 VARCHAR(70),
                                    IN p_addr2 VARCHAR(70),
                                    IN p_city VARCHAR(35),
                                    IN p_phone VARCHAR(50),
                                    IN p_fax VARCHAR(35),
                                    IN p_email VARCHAR(70),
                                    IN p_tin VARCHAR(25),
                                    IN p_days_term MEDIUMINT UNSIGNED,
                                    IN p_owner VARCHAR(60),
                                    IN p_ownerphone VARCHAR(35),
                                    IN p_gralmanag VARCHAR(50),
                                    IN p_gmphone VARCHAR(35),
                                    IN p_salesmanag VARCHAR(50),
                                    IN p_smphone VARCHAR(35),
                                    IN p_mkgmanag VARCHAR(50),
                                    IN p_mmphone VARCHAR(35),
                                    IN p_techserv VARCHAR(50),
                                    IN p_tsaddr1 VARCHAR(70),
                                    IN p_tsaddr2 VARCHAR(70),
                                    IN p_tsphone VARCHAR(35),
                                    IN p_tscontact VARCHAR(70),
                                    IN p_seller1 VARCHAR(50),
                                    IN p_artline1 VARCHAR(35),
                                    IN p_salesphone1 VARCHAR(35),
                                    IN p_seller2 VARCHAR(50),
                                    IN p_artline2 VARCHAR(35),
                                    IN p_salesphone2 VARCHAR(35),
                                    IN p_seller3 VARCHAR(50),
                                    IN p_artline3 VARCHAR(35),
                                    IN p_salesphone3 VARCHAR(35),
                                    IN p_seller4 VARCHAR(50),
                                    IN p_artline4 VARCHAR(35),
                                    IN p_salesphone4 VARCHAR(35),
                                    IN p_seller5 VARCHAR(50),
                                    IN p_artline5 VARCHAR(35),
                                    IN p_salesphone5 VARCHAR(35),
                                    IN p_pyg_balance DECIMAL(13,2),
                                    IN p_usd_balance DECIMAL(13,2),
                                    IN p_active TINYINT UNSIGNED)
BEGIN
    CALL sp_user_has_privilege(p_user_id, p_company_id, 'supplier', 'create');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SELECT fn_supplier_new_id(p_company_id) INTO p_id;
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF (SELECT fn_supplier_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Ya existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF (SELECT fn_supplier_name_exists(p_company_id, p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: p1 }
    IF p_p1 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: No puede ser nulo.│';
    END IF;

    IF p_p1 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p1 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p1 }

    -- begin { validate: p2 }
    IF p_p2 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: No puede ser nulo.│';
    END IF;

    IF p_p2 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p2 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p2 }

    -- begin { validate: p3 }
    IF p_p3 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: No puede ser nulo.│';
    END IF;

    IF p_p3 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p3 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p3 }

    -- begin { validate: p4 }
    IF p_p4 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: No puede ser nulo.│';
    END IF;

    IF p_p4 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p4 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p4 }

    -- begin { validate: p5 }
    IF p_p5 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: No puede ser nulo.│';
    END IF;

    IF p_p5 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p5 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p5 }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    -- begin { nullify nulifiable columns }
    IF p_p1 = 0 THEN
        SET p_p1 = NULL;
    END IF;

    IF p_p2 = 0 THEN
        SET p_p2 = NULL;
    END IF;

    IF p_p3 = 0 THEN
        SET p_p3 = NULL;
    END IF;

    IF p_p4 = 0 THEN
        SET p_p4 = NULL;
    END IF;

    IF p_p5 = 0 THEN
        SET p_p5 = NULL;
    END IF;
    -- end { nullify nulifiable columns }

    INSERT INTO suppliers (company_id, id, name, p1, p2, p3, p4, p5, active)
        VALUES (p_company_id, p_id, p_name, p_p1, p_p2, p_p3, p_p4, p_p5, p_active);
END $$

DELIMITER ;*/

/* -------------------------------------------------------------------------- *
 * SP to update rows from the 'suppliers' table.                              *
 * -------------------------------------------------------------------------- */

/*
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_supplier_update $$

CREATE PROCEDURE sp_supplier_update(IN p_user_id MEDIUMINT UNSIGNED,
                                    IN p_company_id MEDIUMINT UNSIGNED,
                                    IN p_id MEDIUMINT UNSIGNED,
                                    IN p_name VARCHAR(50),
                                    IN p_addr1 VARCHAR(70),
                                    IN p_addr2 VARCHAR(70),
                                    IN p_city VARCHAR(35),
                                    IN p_phone VARCHAR(50),
                                    IN p_fax VARCHAR(35),
                                    IN p_email VARCHAR(70),
                                    IN p_tin VARCHAR(25),
                                    IN p_days_term MEDIUMINT UNSIGNED,
                                    IN p_owner VARCHAR(60),
                                    IN p_ownerphone VARCHAR(35),
                                    IN p_gralmanag VARCHAR(50),
                                    IN p_gmphone VARCHAR(35),
                                    IN p_salesmanag VARCHAR(50),
                                    IN p_smphone VARCHAR(35),
                                    IN p_mkgmanag VARCHAR(50),
                                    IN p_mmphone VARCHAR(35),
                                    IN p_techserv VARCHAR(50),
                                    IN p_tsaddr1 VARCHAR(70),
                                    IN p_tsaddr2 VARCHAR(70),
                                    IN p_tsphone VARCHAR(35),
                                    IN p_tscontact VARCHAR(70),
                                    IN p_seller1 VARCHAR(50),
                                    IN p_artline1 VARCHAR(35),
                                    IN p_salesphone1 VARCHAR(35),
                                    IN p_seller2 VARCHAR(50),
                                    IN p_artline2 VARCHAR(35),
                                    IN p_salesphone2 VARCHAR(35),
                                    IN p_seller3 VARCHAR(50),
                                    IN p_artline3 VARCHAR(35),
                                    IN p_salesphone3 VARCHAR(35),
                                    IN p_seller4 VARCHAR(50),
                                    IN p_artline4 VARCHAR(35),
                                    IN p_salesphone4 VARCHAR(35),
                                    IN p_seller5 VARCHAR(50),
                                    IN p_artline5 VARCHAR(35),
                                    IN p_salesphone5 VARCHAR(35),
                                    IN p_pyg_balance DECIMAL(13,2),
                                    IN p_usd_balance DECIMAL(13,2),
                                    IN p_active TINYINT UNSIGNED)
BEGIN
    DECLARE v_name VARCHAR(50);
    DECLARE v_addr1 VARCHAR(60);
    DECLARE v_addr2 VARCHAR(60);
    DECLARE v_city VARCHAR(25);
    DECLARE v_phone VARCHAR(40);
    DECLARE v_fax VARCHAR(25);
    DECLARE v_email VARCHAR(60);
    DECLARE v_tin VARCHAR(15);
    DECLARE v_days_term SMALLINT UNSIGNED;
    DECLARE v_owner VARCHAR(50);
    DECLARE v_ownerphone VARCHAR(25);
    DECLARE v_gralmanag VARCHAR(40);
    DECLARE v_gmphone VARCHAR(25);
    DECLARE v_salesmanag VARCHAR(40);
    DECLARE v_smphone VARCHAR(25);
    DECLARE v_mkgmanag VARCHAR(40);
    DECLARE v_mmphone VARCHAR(25);
    DECLARE v_techserv VARCHAR(40);
    DECLARE v_tsaddr1 VARCHAR(60);
    DECLARE v_tsaddr2 VARCHAR(60);
    DECLARE v_tsphone VARCHAR(25);
    DECLARE v_tscontact VARCHAR(60);
    DECLARE v_seller1 VARCHAR(40);
    DECLARE v_artline1 VARCHAR(25);
    DECLARE v_salesphone1 VARCHAR(25);
    DECLARE v_seller2 VARCHAR(40);
    DECLARE v_artline2 VARCHAR(25);
    DECLARE v_salesphone2 VARCHAR(25);
    DECLARE v_seller3 VARCHAR(40);
    DECLARE v_artline3 VARCHAR(25);
    DECLARE v_salesphone3 VARCHAR(25);
    DECLARE v_seller4 VARCHAR(40);
    DECLARE v_artline4 VARCHAR(25);
    DECLARE v_salesphone4 VARCHAR(25);
    DECLARE v_seller5 VARCHAR(40);
    DECLARE v_artline5 VARCHAR(25);
    DECLARE v_salesphone5 VARCHAR(25);
    DECLARE v_active TINYINT UNSIGNED;

    CALL sp_user_has_privilege(p_user_id, p_company_id, 'supplier', 'write');

    -- begin { validate: id }
    IF p_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No puede ser nulo.│';
    END IF;

    IF p_id <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser mayor que cero.│';
    END IF;

    IF p_id > 16777215 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: Debe ser menor a 16777215.│';
    END IF;

    IF NOT (SELECT fn_supplier_id_exists(p_company_id, p_id)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Código: No existe.│';
    END IF;
    -- end { validate: id }

    -- begin { validate: name }
    IF p_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede ser nulo.│';
    END IF;

    IF p_name = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_name) > 50 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: La longitud debe ser como máximo de 50 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM suppliers WHERE company_id = p_company_id AND id <> p_id AND UPPER(name) LIKE UPPER(p_name)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Nombre: Ya existe.│';
    END IF;
    -- end { validate: name }

    -- begin { validate: p1 }
    IF p_p1 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: No puede ser nulo.│';
    END IF;

    IF p_p1 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p1 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 1: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p1 }

    -- begin { validate: p2 }
    IF p_p2 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: No puede ser nulo.│';
    END IF;

    IF p_p2 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p2 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 2: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p2 }

    -- begin { validate: p3 }
    IF p_p3 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: No puede ser nulo.│';
    END IF;

    IF p_p3 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p3 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 3: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p3 }

    -- begin { validate: p4 }
    IF p_p4 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: No puede ser nulo.│';
    END IF;

    IF p_p4 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p4 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 4: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p4 }

    -- begin { validate: p5 }
    IF p_p5 IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: No puede ser nulo.│';
    END IF;

    IF p_p5 < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: Debe ser mayor o igual a cero.│';
    END IF;

    IF p_p5 > 999.99 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│% 5: Debe ser menor a 1 mil.│';
    END IF;
    -- end { validate: p5 }

    -- begin { validate: active }
    IF p_active IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: No puede ser nulo.│';
    END IF;

    IF p_active NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Vigente: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: active }

    SELECT
        name,
        COALESCE(addr1, '') addr1,
        COALESCE(addr2, '') addr2,
        COALESCE(city, '') city,
        COALESCE(phone, '') phone,
        COALESCE(fax, '') fax,
        COALESCE(email, '') email,
        COALESCE(tin, '') tin,
        COALESCE(days_term, '') days_term,
        COALESCE(owner, '') owner,
        COALESCE(ownerphone, '') ownerphone,
        COALESCE(gralmanag, '') gralmanag,
        COALESCE(gmphone, '') gmphone,
        COALESCE(salesmanag, '') salesmanag,
        COALESCE(smphone, '') smphone,
        COALESCE(mkgmanag, '') mkgmanag,
        COALESCE(mmphone, '') mmphone,
        COALESCE(techserv, '') techserv,
        COALESCE(tsaddr1, '') tsaddr1,
        COALESCE(tsaddr2, '') tsaddr2,
        COALESCE(tsphone, '') tsphone,
        COALESCE(tscontact, '') tscontact,
        COALESCE(seller1, '') seller1,
        COALESCE(artline1, '') artline1,
        COALESCE(salesphone1, '') salesphone1,
        COALESCE(seller2, '') seller2,
        COALESCE(artline2, '') artline2,
        COALESCE(salesphone2, '') salesphone2,
        COALESCE(seller3, '') seller3,
        COALESCE(artline3, '') artline3,
        COALESCE(salesphone3, '') salesphone3,
        COALESCE(seller4, '') seller4,
        COALESCE(artline4, '') artline4,
        COALESCE(salesphone4, '') salesphone4,
        COALESCE(seller5, '') seller5,
        COALESCE(artline5, '') artline5,
        COALESCE(salesphone5, '') salesphone5,
        active
    FROM
        suppliers
    WHERE
        company_id = p_company_id AND
        id = p_id
    INTO
        v_name,
        v_addr1,
        v_addr2,
        v_city,
        v_phone,
        v_fax,
        v_email,
        v_tin,
        v_days_term,
        v_owner,
        v_ownerphone,
        v_gralmanag,
        v_gmphone,
        v_salesmanag,
        v_smphone,
        v_mkgmanag,
        v_mmphone,
        v_techserv,
        v_tsaddr1,
        v_tsaddr2,
        v_tsphone,
        v_tscontact,
        v_seller1,
        v_artline1,
        v_salesphone1,
        v_seller2,
        v_artline2,
        v_salesphone2,
        v_seller3,
        v_artline3,
        v_salesphone3,
        v_seller4,
        v_artline4,
        v_salesphone4,
        v_seller5,
        v_artline5,
        v_salesphone5,
        v_active;

    IF v_name <> p_name OR
       v_name <> p_name OR
       v_addr1 <> p_addr1 OR
       v_addr2 <> p_addr2 OR
       v_city <> p_city OR
       v_phone <> p_phone OR
       v_fax <> p_fax OR
       v_email <> p_email OR
       v_tin <> p_tin OR
       v_days_term <> p_days_term OR
       v_owner <> p_owner OR
       v_ownerphone <> p_ownerphone OR
       v_gralmanag <> p_gralmanag OR
       v_gmphone <> p_gmphone OR
       v_salesmanag <> p_salesmanag OR
       v_smphone <> p_smphone OR
       v_mkgmanag <> p_mkgmanag OR
       v_mmphone <> p_mmphone OR
       v_techserv <> p_techserv OR
       v_tsaddr1 <> p_tsaddr1 OR
       v_tsaddr2 <> p_tsaddr2 OR
       v_tsphone <> p_tsphone OR
       v_tscontact <> p_tscontact OR
       v_seller1 <> p_seller1 OR
       v_artline1 <> p_artline1 OR
       v_salesphone1 <> p_salesphone1 OR
       v_seller2 <> p_seller2 OR
       v_artline2 <> p_artline2 OR
       v_salesphone2 <> p_salesphone2 OR
       v_seller3 <> p_seller3 OR
       v_artline3 <> p_artline3 OR
       v_salesphone3 <> p_salesphone3 OR
       v_seller4 <> p_seller4 OR
       v_artline4 <> p_artline4 OR
       v_salesphone4 <> p_salesphone4 OR
       v_seller5 <> p_seller5 OR
       v_artline5 <> p_artline5 OR
       v_salesphone5 <> p_salesphone5 OR
       v_active <> p_active THEN

        -- begin { nullify nulifiable columns }
        IF p_p1 = 0 THEN
            SET p_p1 = NULL;
        END IF;

        IF p_p2 = 0 THEN
            SET p_p2 = NULL;
        END IF;

        IF p_p3 = 0 THEN
            SET p_p3 = NULL;
        END IF;

        IF p_p4 = 0 THEN
            SET p_p4 = NULL;
        END IF;

        IF p_p5 = 0 THEN
            SET p_p5 = NULL;
        END IF;
        -- end { nullify nulifiable columns }

        UPDATE
            suppliers
        SET
            name = p_name,
            p1 = p_p1,
            p2 = p_p2,
            p3 = p_p3,
            p4 = p_p4,
            p5 = p_p5,
            active = p_active,
            updated_at = CURRENT_TIMESTAMP
        WHERE
            company_id = p_company_id AND
            id = p_id;
    END IF;
END $$

DELIMITER ;*/

--
-- END: SUPPLIERS
--









