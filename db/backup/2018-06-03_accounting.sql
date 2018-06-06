-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-06-2018 a las 17:20:03
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `accounting`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_brand_get_all` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM brands WHERE company_id = p_company_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_brand_get_all_active` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM brands WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_brand_get_by_id` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM brands WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_brand_get_by_name` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_name` VARCHAR(50))  BEGIN
    SELECT * FROM brands WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_brand_insert` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_brand_update` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_category_get_all` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM categories WHERE company_id = p_company_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_category_get_all_active` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM categories WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_category_get_by_id` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM categories WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_category_get_by_name` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_name` VARCHAR(50))  BEGIN
    SELECT * FROM categories WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_category_insert` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_category_update` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_company_get_by_id` (IN `p_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM companies WHERE id = p_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_company_get_by_name` (IN `p_name` VARCHAR(50))  BEGIN
    SELECT * FROM companies WHERE name LIKE p_name ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_company_get_by_tin` (IN `p_tin` VARCHAR(15))  BEGIN
    SELECT * FROM companies WHERE tin LIKE p_tin ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_country_get_all` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_country_get_all_active` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_country_get_by_id` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_country_get_by_name` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_name` VARCHAR(50))  BEGIN
    SELECT * FROM countries WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_country_insert` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_area_code` VARCHAR(15), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: No puede ser nulo.│';
    END IF;

    IF p_area_code = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_area_code) > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: La longitud debe ser como máximo de 5 caracteres.│';
    END IF;

    IF (SELECT fn_country_area_code_exists(p_company_id, p_area_code)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: Ya existe.│';
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_country_update` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_area_code` VARCHAR(15), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: No puede ser nulo.│';
    END IF;

    IF p_area_code = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: No puede quedar en blanco.│';
    END IF;

    IF LENGTH(p_area_code) > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: La longitud debe ser como máximo de 5 caracteres.│';
    END IF;

    IF EXISTS(SELECT * FROM countries WHERE company_id = p_company_id AND id <> p_id AND UPPER(area_code) LIKE UPPER(p_area_code)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Símbolo: Ya existe.│';
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_family_get_all` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_family_get_all_active` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_family_get_by_id` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_id` MEDIUMINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_family_get_by_name` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_name` VARCHAR(50))  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_family_insert` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_p1` DECIMAL(7,2) UNSIGNED, IN `p_p2` DECIMAL(7,2) UNSIGNED, IN `p_p3` DECIMAL(7,2) UNSIGNED, IN `p_p4` DECIMAL(7,2) UNSIGNED, IN `p_p5` DECIMAL(7,2) UNSIGNED, IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_family_update` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_p1` DECIMAL(7,2) UNSIGNED, IN `p_p2` DECIMAL(7,2) UNSIGNED, IN `p_p3` DECIMAL(7,2) UNSIGNED, IN `p_p4` DECIMAL(7,2) UNSIGNED, IN `p_p5` DECIMAL(7,2) UNSIGNED, IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_measurement_unit_get_all` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_measurement_unit_get_all_active` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_measurement_unit_get_by_id` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_measurement_unit_get_by_name` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_name` VARCHAR(50))  BEGIN
    SELECT * FROM measurement_units WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_measurement_unit_insert` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_symbol` VARCHAR(15), IN `p_divisible` TINYINT UNSIGNED, IN `p_active` TINYINT UNSIGNED)  BEGIN
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

    -- begin { validate: divisible }
    IF p_divisible IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Divisible: No puede ser nulo.│';
    END IF;

    IF p_divisible NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Divisible: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: divisible }

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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_measurement_unit_update` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_symbol` VARCHAR(15), IN `p_divisible` TINYINT UNSIGNED, IN `p_active` TINYINT UNSIGNED)  BEGIN
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

    -- begin { validate: divisible }
    IF p_divisible IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Divisible: No puede ser nulo.│';
    END IF;

    IF p_divisible NOT IN (0, 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Divisible: Debe ser 0 ó 1.│';
    END IF;
    -- end { validate: divisible }

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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_subcategory_get_all` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM subcategories WHERE company_id = p_company_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_subcategory_get_all_active` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM subcategories WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_subcategory_get_by_id` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM subcategories WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_subcategory_get_by_name` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_name` VARCHAR(50))  BEGIN
    SELECT * FROM subcategories WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_subcategory_insert` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_subcategory_update` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_supplier_get_all` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_supplier_get_all_active` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_supplier_get_by_id` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_id` MEDIUMINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_supplier_get_by_name` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_name` VARCHAR(50))  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_get_all` ()  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_get_by_username` (IN `p_username` VARCHAR(25))  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_has_privilege` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_repository` VARCHAR(60), IN `p_privilege` VARCHAR(30))  BEGIN
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

    IF NOT (SELECT fn_user_can_insert(p_company_id, p_user_id, p_repository)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '│Usuario: No tiene permiso para agregar registros.│';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_insert` (IN `p_id` MEDIUMINT UNSIGNED, IN `p_name` VARCHAR(25), IN `p_username` VARCHAR(25), IN `p_password` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_admin` TINYINT UNSIGNED, IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_wo_brand_get_all` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM wo_brands WHERE company_id = p_company_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_wo_brand_get_all_active` (IN `p_company_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM wo_brands WHERE company_id = p_company_id AND active = 1 ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_wo_brand_get_by_id` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_id` MEDIUMINT UNSIGNED)  BEGIN
    SELECT * FROM wo_brands WHERE company_id = p_company_id AND id = p_id ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_wo_brand_get_by_name` (IN `p_company_id` MEDIUMINT UNSIGNED, IN `p_name` VARCHAR(50))  BEGIN
    SELECT * FROM wo_brands WHERE company_id = p_company_id AND name LIKE p_name ORDER BY name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_wo_brand_insert` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_wo_brand_update` (IN `p_user_id` INTEGER UNSIGNED, IN `p_company_id` INTEGER UNSIGNED, IN `p_id` INTEGER UNSIGNED, IN `p_name` VARCHAR(60), IN `p_active` TINYINT UNSIGNED)  BEGIN
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
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_brand_id_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_brand_is_active` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_brand_name_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_name` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_brand_new_id` (`p_company_id` MEDIUMINT UNSIGNED) RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM brands WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_category_id_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_category_is_active` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_category_name_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_name` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_category_new_id` (`p_company_id` MEDIUMINT UNSIGNED) RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM categories WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_company_id_exists` (`p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_company_is_active` (`p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_company_name_exists` (`p_name` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_company_new_id` () RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM companies WHERE id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_company_tin_exists` (`p_tin` VARCHAR(15)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_country_area_code_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_area_code` VARCHAR(5)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_country_id_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_country_is_active` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_country_name_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_name` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_country_new_id` (`p_company_id` MEDIUMINT UNSIGNED) RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM countries WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_country_reccount` (`p_company_id` MEDIUMINT UNSIGNED) RETURNS SMALLINT(5) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_family_id_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_family_is_active` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_family_name_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_name` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_family_new_id` (`p_company_id` MEDIUMINT UNSIGNED) RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM families WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_measurement_unit_id_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_measurement_unit_is_active` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_measurement_unit_name_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_name` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_measurement_unit_new_id` (`p_company_id` MEDIUMINT UNSIGNED) RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM measurement_units WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_measurement_unit_symbol_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_symbol` VARCHAR(5)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_subcategory_id_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_subcategory_is_active` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_subcategory_name_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_name` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_subcategory_new_id` (`p_company_id` MEDIUMINT UNSIGNED) RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM subcategories WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_supplier_id_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_supplier_is_active` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_supplier_name_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_name` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_supplier_new_id` (`p_company_id` MEDIUMINT UNSIGNED) RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM suppliers WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_can_insert` (`p_company_id` MEDIUMINT UNSIGNED, `p_user_id` MEDIUMINT UNSIGNED, `p_program` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_can_update` (`p_company_id` MEDIUMINT UNSIGNED, `p_user_id` MEDIUMINT UNSIGNED, `p_program` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_email_exists` (`p_email` VARCHAR(255)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_has_access` (`p_company_id` MEDIUMINT UNSIGNED, `p_user_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_id_exists` (`p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_is_active` (`p_user_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_name_exists` (`p_name` VARCHAR(25)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_new_id` () RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM users WHERE id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_reccount` () RETURNS SMALLINT(5) UNSIGNED BEGIN
    DECLARE v_row SMALLINT UNSIGNED DEFAULT 0;

    SELECT
        COUNT(*) AS total
    FROM
        users
    INTO
        v_row;

    RETURN v_row;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_user_username_exists` (`p_username` VARCHAR(15)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_wo_brand_id_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_wo_brand_is_active` (`p_company_id` MEDIUMINT UNSIGNED, `p_id` MEDIUMINT UNSIGNED) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_wo_brand_name_exists` (`p_company_id` MEDIUMINT UNSIGNED, `p_name` VARCHAR(50)) RETURNS TINYINT(3) UNSIGNED BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_wo_brand_new_id` (`p_company_id` MEDIUMINT UNSIGNED) RETURNS MEDIUMINT(8) UNSIGNED BEGIN
    DECLARE v_new_id MEDIUMINT UNSIGNED DEFAULT 1;

    loop_label: LOOP
        IF NOT EXISTS(SELECT * FROM wo_brands WHERE company_id = p_company_id AND id = v_new_id) THEN
            LEAVE loop_label;
        ELSE
            SET v_new_id = v_new_id + 1;
        END IF;
    END LOOP;

    RETURN v_new_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `brands`
--

CREATE TABLE `brands` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `companies`
--

CREATE TABLE `companies` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `tin` varchar(15) NOT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `companies`
--

INSERT INTO `companies` (`id`, `name`, `tin`, `active`, `created_at`, `updated_at`) VALUES
(1, 'A & A IMPORTACIONES S.R.L.', '80004234-4', 1, '2018-05-30 21:08:49', NULL),
(2, 'ALL PARTS S.R.L.', '80051608-7', 1, '2018-05-30 21:08:49', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `company_users`
--

CREATE TABLE `company_users` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `user_id` mediumint(8) UNSIGNED NOT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `countries`
--

CREATE TABLE `countries` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `area_code` varchar(5) NOT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `countries`
--

INSERT INTO `countries` (`company_id`, `id`, `name`, `area_code`, `active`, `created_at`, `updated_at`) VALUES
(1, 1, 'PARAGUAY', '595', 1, '2018-06-02 23:52:18', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `families`
--

CREATE TABLE `families` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `p1` decimal(6,2) UNSIGNED DEFAULT NULL,
  `p2` decimal(6,2) UNSIGNED DEFAULT NULL,
  `p3` decimal(6,2) UNSIGNED DEFAULT NULL,
  `p4` decimal(6,2) UNSIGNED DEFAULT NULL,
  `p5` decimal(6,2) UNSIGNED DEFAULT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `measurement_units`
--

CREATE TABLE `measurement_units` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `symbol` varchar(5) NOT NULL,
  `divisible` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategories`
--

CREATE TABLE `subcategories` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suppliers`
--

CREATE TABLE `suppliers` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `addr1` varchar(60) DEFAULT NULL,
  `addr2` varchar(60) DEFAULT NULL,
  `city` varchar(25) DEFAULT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `tin` varchar(15) DEFAULT NULL,
  `days_term` smallint(5) UNSIGNED DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `ownerphone` varchar(25) DEFAULT NULL,
  `gralmanag` varchar(40) DEFAULT NULL,
  `gmphone` varchar(25) DEFAULT NULL,
  `salesmanag` varchar(40) DEFAULT NULL,
  `smphone` varchar(25) DEFAULT NULL,
  `mkgmanag` varchar(40) DEFAULT NULL,
  `mmphone` varchar(25) DEFAULT NULL,
  `techserv` varchar(40) DEFAULT NULL,
  `tsaddr1` varchar(60) DEFAULT NULL,
  `tsaddr2` varchar(60) DEFAULT NULL,
  `tsphone` varchar(25) DEFAULT NULL,
  `tscontact` varchar(60) DEFAULT NULL,
  `seller1` varchar(40) DEFAULT NULL,
  `artline1` varchar(25) DEFAULT NULL,
  `salesphone1` varchar(25) DEFAULT NULL,
  `seller2` varchar(40) DEFAULT NULL,
  `artline2` varchar(25) DEFAULT NULL,
  `salesphone2` varchar(25) DEFAULT NULL,
  `seller3` varchar(40) DEFAULT NULL,
  `artline3` varchar(25) DEFAULT NULL,
  `salesphone3` varchar(25) DEFAULT NULL,
  `seller4` varchar(40) DEFAULT NULL,
  `artline4` varchar(25) DEFAULT NULL,
  `salesphone4` varchar(25) DEFAULT NULL,
  `seller5` varchar(40) DEFAULT NULL,
  `artline5` varchar(25) DEFAULT NULL,
  `salesphone5` varchar(25) DEFAULT NULL,
  `pyg_balance` decimal(12,2) DEFAULT NULL,
  `usd_balance` decimal(12,2) DEFAULT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(25) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `admin` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `company_id` mediumint(8) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `email`, `admin`, `active`, `company_id`, `created_at`, `updated_at`) VALUES
(1, 'Administrador', 'manager', '$2y$10$RlfUaYhQ0Dp7DQqNkYa1p.MOTUJH94iIh0YKPo172WcpxUCXD1GKu', 'turtlesoftpy@gmail.com', 0, 1, 2, '2018-05-30 21:08:00', NULL),
(2, 'José Acuña', 'jaqnya', '$2y$10$ERLwLWq9EZ1sWLch7Y1M/erE1DEE07sLWC59OTBaeB5VCUbokOsDq', 'jaqnya@gmail.com', 0, 1, 1, '2018-05-30 21:08:16', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_privileges`
--

CREATE TABLE `user_privileges` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `user_id` mediumint(8) UNSIGNED NOT NULL,
  `program` varchar(50) NOT NULL,
  `access` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `append` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `modify` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `remove` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wo_brands`
--

CREATE TABLE `wo_brands` (
  `company_id` mediumint(8) UNSIGNED NOT NULL,
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`company_id`,`id`),
  ADD UNIQUE KEY `uk_brands_name` (`company_id`,`name`);

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`company_id`,`id`),
  ADD UNIQUE KEY `uk_categories_name` (`company_id`,`name`);

--
-- Indices de la tabla `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_companies_name` (`name`),
  ADD UNIQUE KEY `uk_companies_tin` (`tin`);

--
-- Indices de la tabla `company_users`
--
ALTER TABLE `company_users`
  ADD PRIMARY KEY (`company_id`,`user_id`),
  ADD KEY `fk_company_users_user_id` (`user_id`);

--
-- Indices de la tabla `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`company_id`,`id`),
  ADD UNIQUE KEY `uk_countries_name` (`company_id`,`name`),
  ADD UNIQUE KEY `uk_countries_area_code` (`company_id`,`area_code`);

--
-- Indices de la tabla `families`
--
ALTER TABLE `families`
  ADD PRIMARY KEY (`company_id`,`id`),
  ADD UNIQUE KEY `uk_families_name` (`company_id`,`name`);

--
-- Indices de la tabla `measurement_units`
--
ALTER TABLE `measurement_units`
  ADD PRIMARY KEY (`company_id`,`id`),
  ADD UNIQUE KEY `uk_measurement_units_name` (`company_id`,`name`),
  ADD UNIQUE KEY `uk_measurement_units_symbol` (`company_id`,`symbol`);

--
-- Indices de la tabla `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`company_id`,`id`),
  ADD UNIQUE KEY `uk_subcategories_name` (`company_id`,`name`);

--
-- Indices de la tabla `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`company_id`,`id`),
  ADD UNIQUE KEY `uk_suppliers_name` (`company_id`,`name`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_users_name` (`name`),
  ADD UNIQUE KEY `uk_users_username` (`username`),
  ADD UNIQUE KEY `uk_users_email` (`email`),
  ADD KEY `fk_users_company_id` (`company_id`);

--
-- Indices de la tabla `user_privileges`
--
ALTER TABLE `user_privileges`
  ADD PRIMARY KEY (`company_id`,`user_id`,`program`),
  ADD KEY `fk_user_privileges_user_id` (`user_id`);

--
-- Indices de la tabla `wo_brands`
--
ALTER TABLE `wo_brands`
  ADD PRIMARY KEY (`company_id`,`id`),
  ADD UNIQUE KEY `uk_wo_brands_name` (`company_id`,`name`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `brands`
--
ALTER TABLE `brands`
  ADD CONSTRAINT `fk_brands_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Filtros para la tabla `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_categories_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Filtros para la tabla `company_users`
--
ALTER TABLE `company_users`
  ADD CONSTRAINT `fk_company_users_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `fk_company_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `countries`
--
ALTER TABLE `countries`
  ADD CONSTRAINT `fk_countries_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Filtros para la tabla `families`
--
ALTER TABLE `families`
  ADD CONSTRAINT `fk_families_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Filtros para la tabla `measurement_units`
--
ALTER TABLE `measurement_units`
  ADD CONSTRAINT `fk_measurement_units_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Filtros para la tabla `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `fk_subcategories_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Filtros para la tabla `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `fk_suppliers_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Filtros para la tabla `user_privileges`
--
ALTER TABLE `user_privileges`
  ADD CONSTRAINT `fk_user_privileges_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `fk_user_privileges_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `wo_brands`
--
ALTER TABLE `wo_brands`
  ADD CONSTRAINT `fk_wo_brands_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
