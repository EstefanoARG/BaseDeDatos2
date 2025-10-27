
-- Nombre:Estefano Alexis Ramirez Garcia

-- ============================
-- 1. CREACIÓN DE TABLAS Y SUS CONSTRAINTS
-- ============================

CREATE TABLE regions (
    region_id NUMBER CONSTRAINT region_id_nn NOT NULL,
    region_name VARCHAR2(25)
);
CREATE UNIQUE INDEX reg_id_pk ON regions (region_id);
ALTER TABLE regions ADD (CONSTRAINT reg_id_pk PRIMARY KEY (region_id));

CREATE TABLE countries (
    country_id CHAR(2) CONSTRAINT country_id_nn NOT NULL,
    country_name VARCHAR2(40),
    region_id NUMBER,
    CONSTRAINT country_c_id_pk PRIMARY KEY (country_id)
);
ALTER TABLE countries ADD (CONSTRAINT countr_reg_fk FOREIGN KEY (region_id) REFERENCES regions(region_id));

CREATE TABLE locations (
    location_id NUMBER(4),
    street_address VARCHAR2(40),
    postal_code VARCHAR2(12),
    city VARCHAR2(30) CONSTRAINT loc_city_nn NOT NULL,
    state_province VARCHAR2(25),
    country_id CHAR(2)
);
CREATE UNIQUE INDEX loc_id_pk ON locations (location_id);
ALTER TABLE locations ADD (
    CONSTRAINT loc_id_pk PRIMARY KEY (location_id),
    CONSTRAINT loc_c_id_fk FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE departments (
    department_id NUMBER(4),
    department_name VARCHAR2(30) CONSTRAINT dept_name_nn NOT NULL,
    manager_id NUMBER(6),
    location_id NUMBER(4)
);
CREATE UNIQUE INDEX dept_id_pk ON departments (department_id);
ALTER TABLE departments ADD (
    CONSTRAINT dept_id_pk PRIMARY KEY (department_id),
    CONSTRAINT dept_loc_fk FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE jobs (
    job_id VARCHAR2(10),
    job_title VARCHAR2(35) CONSTRAINT job_title_nn NOT NULL,
    min_salary NUMBER(6),
    max_salary NUMBER(6)
);
CREATE UNIQUE INDEX job_id_pk ON jobs (job_id);
ALTER TABLE jobs ADD (CONSTRAINT job_id_pk PRIMARY KEY(job_id));

CREATE TABLE employees (
    employee_id NUMBER(6),
    first_name VARCHAR2(20),
    last_name VARCHAR2(25) CONSTRAINT emp_last_name_nn NOT NULL,
    email VARCHAR2(25) CONSTRAINT emp_email_nn NOT NULL,
    phone_number VARCHAR2(20),
    hire_date DATE CONSTRAINT emp_hire_date_nn NOT NULL,
    job_id VARCHAR2(10) CONSTRAINT emp_job_nn NOT NULL,
    salary NUMBER(8,2),
    commission_pct NUMBER(2,2),
    manager_id NUMBER(6),
    department_id NUMBER(4),
    CONSTRAINT emp_salary_min CHECK (salary > 0),
    CONSTRAINT emp_email_uk UNIQUE (email)
);
CREATE UNIQUE INDEX emp_emp_id_pk ON employees (employee_id);
ALTER TABLE employees ADD (
    CONSTRAINT emp_emp_id_pk PRIMARY KEY(employee_id),
    CONSTRAINT emp_dept_fk FOREIGN KEY(department_id) REFERENCES departments,
    CONSTRAINT emp_job_fk FOREIGN KEY(job_id) REFERENCES jobs(job_id),
    CONSTRAINT emp_manager_fk FOREIGN KEY(manager_id) REFERENCES employees
);
ALTER TABLE departments ADD (CONSTRAINT dept_mgr_fk FOREIGN KEY(manager_id) REFERENCES employees(employee_id));

CREATE TABLE job_history (
    employee_id NUMBER(6) CONSTRAINT jhist_employee_nn NOT NULL,
    start_date DATE CONSTRAINT jhist_start_date_nn NOT NULL,
    end_date DATE CONSTRAINT jhist_end_date_nn NOT NULL,
    job_id VARCHAR2(10) CONSTRAINT jhist_job_nn NOT NULL,
    department_id NUMBER(4),
    CONSTRAINT jhist_date_interval CHECK (end_date > start_date)
);
CREATE UNIQUE INDEX jhist_emp_id_st_date_pk ON job_history (employee_id, start_date);
ALTER TABLE job_history ADD (
    CONSTRAINT jhist_emp_id_st_date_pk PRIMARY KEY (employee_id, start_date),
    CONSTRAINT jhist_job_fk FOREIGN KEY (job_id) REFERENCES jobs,
    CONSTRAINT jhist_emp_fk FOREIGN KEY (employee_id) REFERENCES employees,
    CONSTRAINT jhist_dept_fk FOREIGN KEY (department_id) REFERENCES departments
);

-- ============================
-- 2. INSERCIÓN DE DATOS DE EJEMPLO PARA CADA TABLA
-- ============================
-- Regiones 
INSERT INTO regions VALUES (1, 'Europa');
INSERT INTO regions VALUES (2, 'Americas');
INSERT INTO regions VALUES (3, 'Asia');
INSERT INTO regions VALUES (4, 'Middle East & Africa');
-- Countries
INSERT INTO countries VALUES ('PE', 'Peru', 2);
INSERT INTO countries VALUES ('US', 'USA', 2);
INSERT INTO countries VALUES ('JP', 'Japan', 3);
INSERT INTO countries VALUES ('DE', 'Germany', 1);
INSERT INTO countries VALUES ('BR', 'Brazil', 2);
-- Locations
INSERT INTO locations VALUES (1000, 'Av Lima 100', 'LIM01', 'Lima', 'Lima', 'PE');
INSERT INTO locations VALUES (2000, 'Av America 200', 'AMI01', 'New York', 'NY', 'US');
INSERT INTO locations VALUES (3000, 'Sakura 300', 'TOK01', 'Tokyo', 'Tokyo', 'JP');
INSERT INTO locations VALUES (4000, 'Berlin Str 400', 'BER01', 'Berlin', 'Berlin', 'DE');
INSERT INTO locations VALUES (5000, 'Av Brasil 500', 'BRA01', 'Sao Paulo', 'SP', 'BR');
-- Departments
INSERT INTO departments VALUES (50, 'Shipping', null, 1000);
INSERT INTO departments VALUES (60, 'IT', null, 2000);
INSERT INTO departments VALUES (80, 'Sales', null, 3000);
INSERT INTO departments VALUES (90, 'Executive', null, 4000);
INSERT INTO departments VALUES (100, 'Finance', null, 5000);
-- Jobs
INSERT INTO jobs VALUES ('IT_PROG', 'Programador', 4000, 10000);
INSERT INTO jobs VALUES ('AD_PRES', 'Presidente', 10000, 20000);
INSERT INTO jobs VALUES ('SA_MAN', 'Sales Manager', 8000, 18000);
INSERT INTO jobs VALUES ('FI_MGR', 'Finance Manager', 7000, 15000);
INSERT INTO jobs VALUES ('SH_CLERK', 'Shipping Clerk', 2000, 4000);
-- Employees (al menos 6)
INSERT INTO employees VALUES (101, 'Ana', 'Perez', 'aperez', '9999991', SYSDATE, 'IT_PROG', 5000, null, null, 60);
INSERT INTO employees VALUES (102, 'Luis', 'Torres', 'ltorres', '9999992', SYSDATE, 'SH_CLERK', 2300, null, null, 50);
INSERT INTO employees VALUES (103, 'Maria', 'Gomez', 'mgomez', '9999993', SYSDATE, 'FI_MGR', 10000, null, null, 100);
INSERT INTO employees VALUES (104, 'Carlos', 'Vega', 'cvega', '9999994', SYSDATE, 'AD_PRES', 15000, null, null, 90);
INSERT INTO employees VALUES (105, 'Elena', 'Cruz', 'ecruz', '9999995', SYSDATE, 'SA_MAN', 9000, null, null, 80);
INSERT INTO employees VALUES (106, 'Raul', 'Rojas', 'rrojas', '9999996', SYSDATE, 'SH_CLERK', 2500, null, null, 50);
-- Job History
INSERT INTO job_history VALUES (101, SYSDATE-100, SYSDATE-50, 'SH_CLERK', 50);
INSERT INTO job_history VALUES (102, SYSDATE-180, SYSDATE-60, 'SH_CLERK', 50);
INSERT INTO job_history VALUES (103, SYSDATE-200, SYSDATE-80, 'FI_MGR', 100);
INSERT INTO job_history VALUES (104, SYSDATE-300, SYSDATE-90, 'AD_PRES', 90);
INSERT INTO job_history VALUES (105, SYSDATE-150, SYSDATE-120, 'SA_MAN', 80);
INSERT INTO job_history VALUES (106, SYSDATE-50, SYSDATE-10, 'SH_CLERK', 50);
COMMIT;

-- ============================
-- 3. EJERCICIOS DE BLOQUES ANÓNIMOS PL/SQL 
-- ============================

-- EJERCICIO 1: TRANSACCIONES CON SAVEPOINT Y ROLLBACK
DECLARE
BEGIN
    UPDATE employees SET salary = salary*1.10 WHERE department_id = 90;
    SAVEPOINT punto1;
    UPDATE employees SET salary = salary*1.05 WHERE department_id = 60;
    ROLLBACK TO punto1;
    COMMIT;
END;
/
--a. ¿Qué departamento mantuvo los cambios?
--b. ¿Qué efecto tuvo el ROLLBACK parcial?
--c. ¿Qué ocurriría si se ejecutara ROLLBACK sin especificar SAVEPOINT?
-- RESPUESTAS:
-- a. El departamento 90 mantiene los cambios (10% más salario)
-- b. El ROLLBACK parcial deshace solo el cambio del 5% al depto 60
-- c. Si se ejecuta ROLLBACK sin SAVEPOINT, se revierte todo lo hecho en la transacción

-- EJERCICIO 2: BLOQUEOS ENTRE SESIONES
-- Sesión 1:
UPDATE employees SET salary = salary + 500 WHERE employee_id = 103;
-- Sin ejecutar COMMIT
-- Sesión 2:
UPDATE employees SET salary = salary + 500 WHERE employee_id = 103;
-- Espera y queda bloqueada
-- Desde sesión 1 ejecutar:
ROLLBACK;
-- Ahora sesión 2 sigue
--Preguntas:
--a. ¿Por qué la segunda sesión quedó bloqueada?
--b. ¿Qué comando libera los bloqueos?
--c. ¿Qué vistas del diccionario permiten verificar sesiones bloqueadas?
-- RESPUESTAS:
-- a. La segunda sesión queda bloqueada pues la fila está bloqueada por la primera sesión
-- b. El comando ROLLBACK o COMMIT libera el bloqueo
-- c. Vistas que permiten revisar: v$locked_object, dba_blockers, dba_waiters

-- EJERCICIO 3: TRANSFERENCIA DE EMPLEADO CON SEGURIDAD TRANSACCIONAL
DECLARE
    v_existe NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_existe FROM departments WHERE department_id = 110;
    IF v_existe = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Departamento no existe');
        ROLLBACK;
    ELSE
        UPDATE employees SET department_id = 110 WHERE employee_id = 104;
        INSERT INTO job_history VALUES (104, SYSDATE-10, SYSDATE, 'AD_PRES', 90);
        COMMIT;
    END IF;
END;
/

--Preguntas:
--a. ¿Por qué se debe garantizar la atomicidad entre las dos operaciones?
--b. ¿Qué pasaría si se produce un error antes del COMMIT?
--c. ¿Cómo se asegura la integridad entre EMPLOYEES y JOB_HISTORY?
-- RESPUESTAS:
-- a. Hay que garantizar atomicidad para que la transferencia y el historial de trabajo se reflejen o se cancelen juntos
-- b. Un error antes del COMMIT revierte todo
-- c. Se asegura integridad referencial por claves foráneas

-- EJERCICIO 4: SAVEPOINT Y REVERSIÓN PARCIAL
BEGIN
    -- Aumentar salario 8% a empleados del departamento 100
    UPDATE employees
    SET salary = salary * 1.08
    WHERE department_id = 100;
    SAVEPOINT A;

    -- Aumentar salario 5% a empleados del departamento 80
    UPDATE employees
    SET salary = salary * 1.05
    WHERE department_id = 80;
    SAVEPOINT B;

    -- Eliminar empleados del departamento 50
    DELETE FROM job_history
    WHERE employee_id IN (
        SELECT employee_id FROM employees WHERE department_id = 50
    );
    
    DELETE FROM employees
    WHERE department_id = 50;

    -- Reversión parcial hasta SAVEPOINT B
    ROLLBACK TO B;

    -- Confirmar transacción
    COMMIT;
END;
/
--Preguntas:
--a. ¿Qué cambios quedan persistentes?
--b. ¿Qué sucede con las filas eliminadas?
--c. ¿Cómo puedes verificar los cambios antes y después del COMMIT?
-- RESPUESTAS:
-- a. Persisten solo los cambios hasta el SAVEPOINT B (salario dept 100 y 80 actualizados)
-- b. Las filas eliminadas con DELETE luego del SAVEPOINT B NO son eliminadas porque se hace ROLLBACK TO B
-- c. Antes del COMMIT puedes hacer consultas dentro de la misma sesión; después del COMMIT el cambio es global
