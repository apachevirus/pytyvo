/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *
 *                                  DATABASE                                  *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
DROP DATABASE accounting;

CREATE DATABASE IF NOT EXISTS accounting
    DEFAULT CHARACTER SET utf8
    DEFAULT COLLATE utf8_general_ci;

USE accounting;

/* -------------------------------------------------------------------------- */
CREATE TABLE companies (
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    tin VARCHAR(15) NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE companies
    ADD CONSTRAINT pk_companies_id
        PRIMARY KEY (id),
    ADD CONSTRAINT uk_companies_name
        UNIQUE KEY (name),
    ADD CONSTRAINT uk_companies_tin
        UNIQUE KEY (tin),
    ADD CONSTRAINT chk_companies_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_companies_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_companies_tin
        CHECK (tin <> ''),
    ADD CONSTRAINT chk_companies_active
        CHECK (active IN (0, 1));

/*ALTER TABLE companies
    MODIFY COLUMN id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT;*/

/* -------------------------------------------------------------------------- */
CREATE TABLE users (
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(25) NOT NULL,
    username VARCHAR(25) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    admin TINYINT UNSIGNED NOT NULL DEFAULT 0,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    company_id MEDIUMINT UNSIGNED NULL DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE users
    ADD CONSTRAINT pk_users_id
        PRIMARY KEY (id),
    ADD CONSTRAINT fk_users_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_users_name
        UNIQUE KEY (name),
    ADD CONSTRAINT uk_users_username
        UNIQUE KEY (username),
    ADD CONSTRAINT uk_users_email
        UNIQUE KEY (email),
    ADD CONSTRAINT chk_users_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_users_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_users_username
        CHECK (username <> ''),
    ADD CONSTRAINT chk_users_password
        CHECK (password <> ''),
    ADD CONSTRAINT chk_users_email
        CHECK (email <> ''),
    ADD CONSTRAINT chk_users_admin
        CHECK (admin IN (0, 1)),
    ADD CONSTRAINT chk_users_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE company_users (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    user_id MEDIUMINT UNSIGNED NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE company_users
    ADD CONSTRAINT pk_company_users_id
        PRIMARY KEY (company_id, user_id),
    ADD CONSTRAINT fk_company_users_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT fk_company_users_user_id
        FOREIGN KEY (user_id) REFERENCES users (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT;

/* -------------------------------------------------------------------------- */
CREATE TABLE user_privileges (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    user_id MEDIUMINT UNSIGNED NOT NULL,
    program VARCHAR(50) NOT NULL,
    access TINYINT UNSIGNED NOT NULL DEFAULT 0,
    append TINYINT UNSIGNED NOT NULL DEFAULT 0,
    modify TINYINT UNSIGNED NOT NULL DEFAULT 0,
    remove TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE user_privileges
    ADD CONSTRAINT pk_user_privileges_id
        PRIMARY KEY (company_id, user_id, program),
    ADD CONSTRAINT fk_user_privileges_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT fk_user_privileges_user_id
        FOREIGN KEY (user_id) REFERENCES users (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT;

/* -------------------------------------------------------------------------- */
CREATE TABLE families (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    p1 DECIMAL(6,2) UNSIGNED NULL DEFAULT NULL,
    p2 DECIMAL(6,2) UNSIGNED NULL DEFAULT NULL,
    p3 DECIMAL(6,2) UNSIGNED NULL DEFAULT NULL,
    p4 DECIMAL(6,2) UNSIGNED NULL DEFAULT NULL,
    p5 DECIMAL(6,2) UNSIGNED NULL DEFAULT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE families
    ADD CONSTRAINT pk_families_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_families_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_families_name
        UNIQUE KEY (company_id, name),
    ADD CONSTRAINT chk_families_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_families_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_families_p1
        CHECK (p1 IS NULL OR p1 > 0),
    ADD CONSTRAINT chk_families_p2
        CHECK (p2 IS NULL OR p2 > 0),
    ADD CONSTRAINT chk_families_p3
        CHECK (p3 IS NULL OR p3 > 0),
    ADD CONSTRAINT chk_families_p4
        CHECK (p4 IS NULL OR p4 > 0),
    ADD CONSTRAINT chk_families_p5
        CHECK (p5 IS NULL OR p5 > 0),
    ADD CONSTRAINT chk_families_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE categories (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE categories
    ADD CONSTRAINT pk_categories_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_categories_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_categories_name
        UNIQUE KEY (company_id, name),
    ADD CONSTRAINT chk_categories_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_categories_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_categories_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE subcategories (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE subcategories
    ADD CONSTRAINT pk_subcategories_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_subcategories_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_subcategories_name
        UNIQUE KEY (company_id, name),
    ADD CONSTRAINT chk_subcategories_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_subcategories_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_subcategories_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE brands (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE brands
    ADD CONSTRAINT pk_brands_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_brands_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_brands_name
        UNIQUE KEY (company_id, name),
    ADD CONSTRAINT chk_brands_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_brands_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_brands_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE measurement_units (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    symbol VARCHAR(5) NOT NULL,
    divisible TINYINT UNSIGNED NOT NULL DEFAULT 0,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE measurement_units
    ADD CONSTRAINT pk_measurement_units_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_measurement_units_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_measurement_units_name
        UNIQUE KEY (company_id, name),
    ADD CONSTRAINT uk_measurement_units_symbol
        UNIQUE KEY (company_id, symbol),
    ADD CONSTRAINT chk_measurement_units_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_measurement_units_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_measurement_units_symbol
        CHECK (symbol <> ''),
    ADD CONSTRAINT chk_measurement_units_divisible
        CHECK (divisible IN (0, 1)),
    ADD CONSTRAINT chk_measurement_units_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE countries (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    area_code VARCHAR(5) NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE countries
    ADD CONSTRAINT pk_countries_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_countries_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_countries_name
        UNIQUE KEY (company_id, name),
    ADD CONSTRAINT uk_countries_area_code
        UNIQUE KEY (company_id, area_code),
    ADD CONSTRAINT chk_countries_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_countries_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_countries_area_code
        CHECK (area_code <> ''),
    ADD CONSTRAINT chk_countries_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE machines (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE machines
    ADD CONSTRAINT pk_machines_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_machines_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_machines_name
        UNIQUE KEY (company_id, name),
    ADD CONSTRAINT chk_machines_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_machines_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_machines_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE wo_brands (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE wo_brands
    ADD CONSTRAINT pk_wo_brands_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_wo_brands_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_wo_brands_name
        UNIQUE KEY (company_id, name),
    ADD CONSTRAINT chk_wo_brands_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_wo_brands_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_wo_brands_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE models (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    machine_id MEDIUMINT UNSIGNED NOT NULL,
    brand_id MEDIUMINT UNSIGNED NOT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
) ENGINE=InnoDB;

ALTER TABLE models
    ADD CONSTRAINT pk_models_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_models_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT fk_models_machine_id
        FOREIGN KEY (company_id, machine_id) REFERENCES machines (company_id, id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT fk_models_brand_id
        FOREIGN KEY (company_id, brand_id) REFERENCES wo_brands (company_id, id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_models_name
        UNIQUE KEY (company_id, name, machine_id, brand_id),
    ADD CONSTRAINT chk_models_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_models_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_models_active
        CHECK (active IN (0, 1));

/* -------------------------------------------------------------------------- */
CREATE TABLE suppliers (
    company_id MEDIUMINT UNSIGNED NOT NULL,
    id MEDIUMINT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL,
    addr1 VARCHAR(60) NULL DEFAULT NULL,
    addr2 VARCHAR(60) NULL DEFAULT NULL,
    city VARCHAR(25) NULL DEFAULT NULL,
    phone VARCHAR(40) NULL DEFAULT NULL,
    fax VARCHAR(25) NULL DEFAULT NULL,
    email VARCHAR(60) NULL DEFAULT NULL,
    tin VARCHAR(15) NULL DEFAULT NULL,
    days_term SMALLINT UNSIGNED NULL DEFAULT NULL,
    owner VARCHAR(50) NULL DEFAULT NULL,
    ownerphone VARCHAR(25) NULL DEFAULT NULL,
    gralmanag VARCHAR(40) NULL DEFAULT NULL,
    gmphone VARCHAR(25) NULL DEFAULT NULL,
    salesmanag VARCHAR(40) NULL DEFAULT NULL,
    smphone VARCHAR(25) NULL DEFAULT NULL,
    mkgmanag VARCHAR(40) NULL DEFAULT NULL,
    mmphone VARCHAR(25) NULL DEFAULT NULL,
    techserv VARCHAR(40) NULL DEFAULT NULL,
    tsaddr1 VARCHAR(60) NULL DEFAULT NULL,
    tsaddr2 VARCHAR(60) NULL DEFAULT NULL,
    tsphone VARCHAR(25) NULL DEFAULT NULL,
    tscontact VARCHAR(60) NULL DEFAULT NULL,
    seller1 VARCHAR(40) NULL DEFAULT NULL,
    artline1 VARCHAR(25) NULL DEFAULT NULL,
    salesphone1 VARCHAR(25) NULL DEFAULT NULL,
    seller2 VARCHAR(40) NULL DEFAULT NULL,
    artline2 VARCHAR(25) NULL DEFAULT NULL,
    salesphone2 VARCHAR(25) NULL DEFAULT NULL,
    seller3 VARCHAR(40) NULL DEFAULT NULL,
    artline3 VARCHAR(25) NULL DEFAULT NULL,
    salesphone3 VARCHAR(25) NULL DEFAULT NULL,
    seller4 VARCHAR(40) NULL DEFAULT NULL,
    artline4 VARCHAR(25) NULL DEFAULT NULL,
    salesphone4 VARCHAR(25) NULL DEFAULT NULL,
    seller5 VARCHAR(40) NULL DEFAULT NULL,
    artline5 VARCHAR(25) NULL DEFAULT NULL,
    salesphone5 VARCHAR(25) NULL DEFAULT NULL,
    pyg_balance DECIMAL(12,2) NULL DEFAULT NULL,
    usd_balance DECIMAL(12,2) NULL DEFAULT NULL,
    active TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL DEFAULT NULL
);

ALTER TABLE suppliers
    ADD CONSTRAINT pk_suppliers_id
        PRIMARY KEY (company_id, id),
    ADD CONSTRAINT fk_suppliers_company_id
        FOREIGN KEY (company_id) REFERENCES companies (id)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT,
    ADD CONSTRAINT uk_suppliers_name
        UNIQUE KEY (company_id, name),
    ADD CONSTRAINT chk_suppliers_id
        CHECK (id > 0),
    ADD CONSTRAINT chk_suppliers_name
        CHECK (name <> ''),
    ADD CONSTRAINT chk_suppliers_addr1
        CHECK (addr1 IS NULL OR addr1 <> ''),
    ADD CONSTRAINT chk_suppliers_addr2
        CHECK (addr2 IS NULL OR addr2 <> ''),
    ADD CONSTRAINT chk_suppliers_city
        CHECK (city IS NULL OR city <> ''),
    ADD CONSTRAINT chk_suppliers_phone
        CHECK (phone IS NULL OR phone <> ''),
    ADD CONSTRAINT chk_suppliers_fax
        CHECK (fax IS NULL OR fax <> ''),
    ADD CONSTRAINT chk_suppliers_email
        CHECK (email IS NULL OR email <> ''),
    ADD CONSTRAINT chk_suppliers_tin
        CHECK (tin IS NULL OR tin <> ''),
    ADD CONSTRAINT chk_suppliers_days_term
        CHECK (days_term IS NULL OR days_term > 0),
    ADD CONSTRAINT chk_suppliers_owner
        CHECK (owner IS NULL OR owner <> ''),
    ADD CONSTRAINT chk_suppliers_ownerphone
        CHECK (ownerphone IS NULL OR ownerphone <> ''),
    ADD CONSTRAINT chk_suppliers_gralmanag
        CHECK (gralmanag IS NULL OR gralmanag <> ''),
    ADD CONSTRAINT chk_suppliers_gmphone
        CHECK (gmphone IS NULL OR gmphone <> ''),
    ADD CONSTRAINT chk_suppliers_salesmanag
        CHECK (salesmanag IS NULL OR salesmanag <> ''),
    ADD CONSTRAINT chk_suppliers_smphone
        CHECK (smphone IS NULL OR smphone <> ''),
    ADD CONSTRAINT chk_suppliers_mkgmanag
        CHECK (mkgmanag IS NULL OR mkgmanag <> ''),
    ADD CONSTRAINT chk_suppliers_mmphone
        CHECK (mmphone IS NULL OR mmphone <> ''),
    ADD CONSTRAINT chk_suppliers_techserv
        CHECK (techserv IS NULL OR techserv <> ''),
    ADD CONSTRAINT chk_suppliers_tsaddr1
        CHECK (tsaddr1 IS NULL OR tsaddr1 <> ''),
    ADD CONSTRAINT chk_suppliers_tsaddr2
        CHECK (tsaddr2 IS NULL OR tsaddr2 <> ''),
    ADD CONSTRAINT chk_suppliers_tsphone
        CHECK (tsphone IS NULL OR tsphone <> ''),
    ADD CONSTRAINT chk_suppliers_tscontact1
        CHECK (tscontact IS NULL OR tscontact <> ''),
    ADD CONSTRAINT chk_suppliers_seller1
        CHECK (seller1 IS NULL OR seller1 <> ''),
    ADD CONSTRAINT chk_suppliers_artline1
        CHECK (artline1 IS NULL OR artline1 <> ''),
    ADD CONSTRAINT chk_suppliers_salesphone1
        CHECK (salesphone1 IS NULL OR salesphone1 <> ''),
    ADD CONSTRAINT chk_suppliers_seller2
        CHECK (seller2 IS NULL OR seller2 <> ''),
    ADD CONSTRAINT chk_suppliers_artline2
        CHECK (artline2 IS NULL OR artline2 <> ''),
    ADD CONSTRAINT chk_suppliers_salesphone2
        CHECK (salesphone2 IS NULL OR salesphone2 <> ''),
    ADD CONSTRAINT chk_suppliers_seller3
        CHECK (seller3 IS NULL OR seller3 <> ''),
    ADD CONSTRAINT chk_suppliers_artline3
        CHECK (artline3 IS NULL OR artline3 <> ''),
    ADD CONSTRAINT chk_suppliers_salesphone3
        CHECK (salesphone3 IS NULL OR salesphone3 <> ''),
    ADD CONSTRAINT chk_suppliers_seller4
        CHECK (seller4 IS NULL OR seller4 <> ''),
    ADD CONSTRAINT chk_suppliers_artline4
        CHECK (artline4 IS NULL OR artline4 <> ''),
    ADD CONSTRAINT chk_suppliers_salesphone4
        CHECK (salesphone4 IS NULL OR salesphone4 <> ''),
    ADD CONSTRAINT chk_suppliers_seller5
        CHECK (seller5 IS NULL OR seller5 <> ''),
    ADD CONSTRAINT chk_suppliers_artline5
        CHECK (artline5 IS NULL OR artline5 <> ''),
    ADD CONSTRAINT chk_suppliers_salesphone5
        CHECK (salesphone5 IS NULL OR salesphone5 <> ''),
    ADD CONSTRAINT chk_suppliers_pyg_balance
        CHECK (pyg_balance IS NULL OR pyg_balance <> 0),
    ADD CONSTRAINT chk_suppliers_usd_balance
        CHECK (usd_balance IS NULL OR usd_balance <> 0),
    ADD CONSTRAINT chk_suppliers_active
        CHECK (active IN (0, 1));