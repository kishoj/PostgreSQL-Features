-- Parent table
create table big_table (
	id bigserial NOT NULL PRIMARY KEY,
	-- Addtional fields
	yyyy varchar(4),
	mm varchar(2)
);

﻿-- Children tables
create table big_table_2016_01 (
	CHECK (yyyy = '2016' AND mm = '01'),
	CONSTRAINT big_table_2016_01_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_02 (
	CHECK (yyyy = '2016' AND mm = '02'),
	CONSTRAINT big_table_2016_02_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_03 (
	CHECK (yyyy = '2016' AND mm = '03'),
	CONSTRAINT big_table_2016_03_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_04 (
	CHECK (yyyy = '2016' AND mm = '04'),
	CONSTRAINT big_table_2016_04_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_05 (
	CHECK (yyyy = '2016' AND mm = '05'),
	CONSTRAINT big_table_2016_05_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_06 (
	CHECK (yyyy = '2016' AND mm = '06'), 
	CONSTRAINT big_table_2016_06_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_07 (
	CHECK (yyyy = '2016' AND mm = '07'),
	CONSTRAINT big_table_2016_07_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_08 (
	CHECK (yyyy = '2016' AND mm = '08'),
	CONSTRAINT big_table_2016_08_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_09 (
	CHECK (yyyy = '2016' AND mm = '09'),
	CONSTRAINT big_table_2016_09_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_10 (
	CHECK (yyyy = '2016' AND mm = '10'),
	CONSTRAINT big_table_2016_10_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_11 (
	CHECK (yyyy = '2016' AND mm = '11'),
	CONSTRAINT big_table_2016_11_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

create table big_table_2016_12 (
	CHECK (yyyy = '2016' AND mm = '12'),
	CONSTRAINT big_table_2016_12_pkey PRIMARY KEY (id)
) INHERITS (big_table) ;

-- Creating indexes on children tables
CREATE INDEX big_table_2016_01_idx ON big_table_2016_01(yyyy, mm);
CREATE INDEX big_table_2016_02_idx ON big_table_2016_02(yyyy, mm);
CREATE INDEX big_table_2016_03_idx ON big_table_2016_03(yyyy, mm);
CREATE INDEX big_table_2016_04_idx ON big_table_2016_04(yyyy, mm);
CREATE INDEX big_table_2016_05_idx ON big_table_2016_05(yyyy, mm);
CREATE INDEX big_table_2016_06_idx ON big_table_2016_06(yyyy, mm);
CREATE INDEX big_table_2016_07_idx ON big_table_2016_07(yyyy, mm);
CREATE INDEX big_table_2016_08_idx ON big_table_2016_08(yyyy, mm);
CREATE INDEX big_table_2016_09_idx ON big_table_2016_09(yyyy, mm);
CREATE INDEX big_table_2016_10_idx ON big_table_2016_10(yyyy, mm);
CREATE INDEX big_table_2016_11_idx ON big_table_2016_11(yyyy, mm);
CREATE INDEX big_table_2016_12_idx ON big_table_2016_12(yyyy, mm);

-- Creating trigger function
CREATE OR REPLACE FUNCTION big_table_insert_trigger()
RETURNS TRIGGER AS $$
DECLARE
    table_name VARCHAR(500);
BEGIN
    table_name := TG_RELNAME || '_' || NEW.yyyy || '_' || NEW.mm;
    EXECUTE 'INSERT INTO ' || table_name || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').*;';
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

-- Creating trigger
CREATE TRIGGER trigger_big_table_insert
    BEFORE INSERT ON big_table
    FOR EACH ROW EXECUTE PROCEDURE big_table_insert_trigger();

-- Inserting records into table
INSERT INTO big_table VALUES (1, '2016', '01');
INSERT INTO big_table VALUES (2, '2016', '02');
INSERT INTO big_table VALUES (3, '2016', '03');
INSERT INTO big_table VALUES (4, '2016', '04');
INSERT INTO big_table VALUES (5, '2016', '05');
INSERT INTO big_table VALUES (6, '2016', '06');
INSERT INTO big_table VALUES (7, '2016', '07');
INSERT INTO big_table VALUES (8, '2016', '08');
INSERT INTO big_table VALUES (9, '2016', '09');
INSERT INTO big_table VALUES (10, '2016', '10');
INSERT INTO big_table VALUES (11, '2016', '11');
INSERT INTO big_table VALUES (12, '2016', '12');

--Set constraint exclusion as follow in postgresql.conf:
--constraint_exclusion = on


