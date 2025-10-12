-- Script para crear las tablas del ejemplo de Proveedores y Partes


-- Crear tabla S (Suppliers/Proveedores)
CREATE TABLE S (
    S_NUMERO VARCHAR2(3) PRIMARY KEY,
    SNAME VARCHAR2(20) NOT NULL,
    STATUS NUMBER(2),
    CITY VARCHAR2(15)
);

-- Crear tabla P (Parts/Partes)
CREATE TABLE P (
    P_NUMERO VARCHAR2(3) PRIMARY KEY,
    PNAME VARCHAR2(20) NOT NULL,
    COLOR VARCHAR2(10),
    WEIGHT NUMBER(3),
    CITY VARCHAR2(15)
);

-- Crear tabla J (Projects/Proyectos)
CREATE TABLE J (
    J_NUMERO VARCHAR2(3) PRIMARY KEY,
    JNAME VARCHAR2(20) NOT NULL,
    CITY VARCHAR2(15)
);

-- Crear tabla SP (Supplier-Part/Proveedor-Parte)
CREATE TABLE SP (
    S_NUMERO VARCHAR2(3),
    P_NUMERO VARCHAR2(3),
    QTY NUMBER(4),
    PRIMARY KEY (S_NUMERO, P_NUMERO),
    FOREIGN KEY (S_NUMERO) REFERENCES S(S_NUMERO),
    FOREIGN KEY (P_NUMERO) REFERENCES P(P_NUMERO)
);

-- Crear tabla SPJ (Supplier-Part-Project/Proveedor-Parte-Proyecto)
CREATE TABLE SPJ (
    S_NUMERO VARCHAR2(3),
    P_NUMERO VARCHAR2(3),
    J_NUMERO VARCHAR2(3),
    QTY NUMBER(4),
    PRIMARY KEY (S_NUMERO, P_NUMERO, J_NUMERO),
    FOREIGN KEY (S_NUMERO) REFERENCES S(S_NUMERO),
    FOREIGN KEY (P_NUMERO) REFERENCES P(P_NUMERO),
    FOREIGN KEY (J_NUMERO) REFERENCES J(J_NUMERO)
);

-- Insertar datos en tabla S (Suppliers/Proveedores)
INSERT INTO S VALUES ('S1', 'Smith', 20, 'London');
INSERT INTO S VALUES ('S2', 'Jones', 10, 'Paris');
INSERT INTO S VALUES ('S3', 'Blake', 30, 'Paris');
INSERT INTO S VALUES ('S4', 'Clark', 20, 'London');
INSERT INTO S VALUES ('S5', 'Adams', 30, 'Athens');

-- Insertar datos en tabla P (Parts/Partes)
INSERT INTO P VALUES ('P1', 'Nut', 'Red', 12, 'London');
INSERT INTO P VALUES ('P2', 'Bolt', 'Green', 17, 'Paris');
INSERT INTO P VALUES ('P3', 'Screw', 'Blue', 17, 'Rome');
INSERT INTO P VALUES ('P4', 'Screw', 'Red', 14, 'London');
INSERT INTO P VALUES ('P5', 'Cam', 'Blue', 12, 'Paris');
INSERT INTO P VALUES ('P6', 'Cog', 'Red', 19, 'London');

-- Insertar datos en tabla J (Projects/Proyectos)
INSERT INTO J VALUES ('J1', 'Sorter', 'Paris');
INSERT INTO J VALUES ('J2', 'Display', 'Rome');
INSERT INTO J VALUES ('J3', 'OCR', 'Athens');
INSERT INTO J VALUES ('J4', 'Console', 'Athens');
INSERT INTO J VALUES ('J5', 'RAID', 'London');
INSERT INTO J VALUES ('J6', 'EDS', 'Oslo');
INSERT INTO J VALUES ('J7', 'Tape', 'London');

-- Insertar datos en tabla SP (Supplier-Part/Proveedor-Parte)
INSERT INTO SP VALUES ('S1', 'P1', 300);
INSERT INTO SP VALUES ('S1', 'P2', 200);
INSERT INTO SP VALUES ('S1', 'P3', 400);
INSERT INTO SP VALUES ('S1', 'P4', 200);
INSERT INTO SP VALUES ('S1', 'P5', 100);
INSERT INTO SP VALUES ('S1', 'P6', 100);
INSERT INTO SP VALUES ('S2', 'P1', 300);
INSERT INTO SP VALUES ('S2', 'P2', 400);
INSERT INTO SP VALUES ('S3', 'P2', 200);
INSERT INTO SP VALUES ('S4', 'P2', 200);
INSERT INTO SP VALUES ('S4', 'P4', 300);
INSERT INTO SP VALUES ('S4', 'P5', 400);

-- Insertar datos en tabla SPJ (Supplier-Part-Project/Proveedor-Parte-Proyecto)
INSERT INTO SPJ VALUES ('S1', 'P1', 'J1', 200);
INSERT INTO SPJ VALUES ('S1', 'P1', 'J4', 700);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J1', 400);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J2', 200);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J3', 200);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J4', 500);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J5', 600);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J6', 400);
INSERT INTO SPJ VALUES ('S2', 'P3', 'J7', 800);
INSERT INTO SPJ VALUES ('S2', 'P5', 'J2', 100);
INSERT INTO SPJ VALUES ('S3', 'P3', 'J1', 200);
INSERT INTO SPJ VALUES ('S3', 'P4', 'J2', 500);
INSERT INTO SPJ VALUES ('S4', 'P6', 'J3', 300);
INSERT INTO SPJ VALUES ('S4', 'P6', 'J7', 300);
INSERT INTO SPJ VALUES ('S5', 'P2', 'J2', 200);
INSERT INTO SPJ VALUES ('S5', 'P2', 'J4', 100);
INSERT INTO SPJ VALUES ('S5', 'P5', 'J5', 500);
INSERT INTO SPJ VALUES ('S5', 'P5', 'J7', 100);
INSERT INTO SPJ VALUES ('S5', 'P6', 'J2', 200);
INSERT INTO SPJ VALUES ('S5', 'P1', 'J4', 100);
INSERT INTO SPJ VALUES ('S5', 'P3', 'J4', 200);
INSERT INTO SPJ VALUES ('S5', 'P4', 'J4', 800);
INSERT INTO SPJ VALUES ('S5', 'P5', 'J4', 400);
INSERT INTO SPJ VALUES ('S5', 'P6', 'J4', 500);

-- Confirmar los cambios
COMMIT;

-- Consultas para verificar los datos insertados
SELECT 'Tabla S - Proveedores:' AS TABLA FROM DUAL;
SELECT * FROM S ORDER BY S_NUMERO;

SELECT 'Tabla P - Partes:' AS TABLA FROM DUAL;
SELECT * FROM P ORDER BY P_NUMERO;

SELECT 'Tabla J - Proyectos:' AS TABLA FROM DUAL;
SELECT * FROM J ORDER BY J_NUMERO;

SELECT 'Tabla SP - Envios Proveedor-Parte:' AS TABLA FROM DUAL;
SELECT * FROM SP ORDER BY S_NUMERO, P_NUMERO;

SELECT 'Tabla SPJ - Envios a Proyectos:' AS TABLA FROM DUAL;
SELECT * FROM SPJ ORDER BY S_NUMERO, P_NUMERO, J_NUMERO;

--------------------------------------------
/*
P# PNAME COLOR WEIGHT CITY
P1 Nut Red 12 London
P2 Bolt Green 17 Paris
P3 Screw Blue 17 Rome
P4 Screw Red 14 London
P5 Cam Blue 12 Paris
P6 Cog Red 19 London*/
SET SERVEROUTPUT ON;
--4.1.1 Obtenga el color y ciudad para las partes que no son de París, con un peso mayor de diez.
create or replace procedure noparisnodiez
is 
    cursor partes is
        select p.color, p.city
        from P p
        where p.city != 'Paris' and p.weight>10;
begin
    for rec in partes loop
        dbms_output.put_line('Color: '||rec.color||' Ciudad: '||rec.city);
    end loop;
end noparisnodiez;

exec noparisnodiez;


--4.1.2 Para todas las partes, obtenga el número de parte y el peso de dichas partes en gramos. 453.592
create or replace procedure numypeso 
is 
    cursor partes is
        select p.p_numero, p.weight
        from P p;
begin
    for rec in partes loop
        dbms_output.put_line('Numero de parte: '||rec.p_numero||' Peso en gramos: '||rec.weight*453.592);
    end loop;
end numypeso;

exec numypeso;

--4.1.3 Obtenga el detalle completo de todos los proveedores.


create or replace procedure detallespro
is 
    cursor pro is
        select s.s_numero, s.sname, s.status, s.city
        from S s;
begin
    for rec in pro loop
        dbms_output.put_line('Numero: '||rec.s_numero||' Nombre: '||rec.sname||' Estado: '||rec.status||' Ciudad: '||rec.city);
    end loop;
end detallespro;

exec detallespro;

--4.1.4 Obtenga todas las combinaciones de proveedores y partes para aquellos proveedores y partes co-localizados.

create or replace procedure combicolocalizado
is
    cursor sp is
        select s.sname,s.s_numero ,p.pname
        from S s
        join p p on s.city=p.city;
begin
    for rec in sp loop
        dbms_output.put_line('Proveedor: '||rec.s_numero||'-'||rec.sname||' Partes: '||rec.pname);
    end loop;
end combicolocalizado;

exec combicolocalizado;

/*4.1.5 Obtenga todos los pares de nombres de ciudades de tal forma que el proveedor
localizado en la primera ciudad del par abastece una parte almacenada en la se-
gunda ciudad del par.*/

/*
S# SNAME STATUS CITY
S1 Smith 20 London
S2 Jones 10 Paris
S3 Blake 30 Paris
S4 Clark 20 London
S5 Adams 30 Athens

P# PNAME COLOR WEIGHT CITY
P1 Nut Red 12 London
P2 Bolt Green 17 Paris
P3 Screw Blue 17 Rome
P4 Screw Red 14 London
P5 Cam Blue 12 Paris
P6 Cog Red 19 London

S# P# QTY
S1 P1 300
S1 P2 200
S1 P3 400
S1 P4 200
S1 P5 100
S1 P6 100
S2 P1 300
S2 P2 400
S3 P2 200
S4 P2 200
S4 P4 300
S4 P5 400

*/

create or replace procedure parciudades
is
    cursor pares is
        select  s.city as provciudad, p.city
        from SP sp
        join S s on s.s_numero=sp.s_numero
        join P p on p.p_numero=sp.p_numero
        order by sp.s_numero, sp.p_numero;
begin
    for rec in pares loop
        dbms_output.put_line('Ciudad del proveedor: '||rec.provciudad||' Ciudad abastecida: '||rec.city);
    end loop;
end parciudades;

exec parciudades;

/*4.1.6 Obtenga todos los pares de número de proveedor tales que los dos proveedores
del par estén co-localizados.
S# SNAME STATUS CITY
S1 Smith 20 London
S2 Jones 10 Paris
S3 Blake 30 Paris
S4 Clark 20 London
S5 Adams 30 Athens*/

create or replace procedure provcolo 
is
    cursor pares is
        select s1.s_numero as num1, s2.s_numero as num2
        from S s1, S s2
        WHERE s1.city=s2.city AND s1.s_numero < s2.s_numero
        ORDER BY s1.s_numero, s2.s_numero;
begin
    for rec in pares loop
        dbms_output.put_line('Numeros de los proveedores co-localizados: '||rec.num1||'-'||rec.num2);
    end loop;
end provcolo;

exec provcolo;

--4.1.7 Obtenga el número total de proveedores.
create or replace function totalprov
return NUMBER
is 
    total number;
begin
    select count(s.s_numero)
    into total
    from S s;
    return total;
end totalprov;

SELECT totalprov FROM dual;

--4.1.8 Obtenga la cantidad mínima y la cantidad máxima para la parte P2.

CREATE OR REPLACE PROCEDURE maxmin_prov(
    prov IN sp.p_numero%TYPE,
    p_max OUT NUMBER,
    p_min OUT NUMBER
)
IS
BEGIN
    SELECT MAX(sp.qty), MIN(sp.qty)
    INTO p_max, p_min
    FROM SP sp
    WHERE sp.p_numero = prov;
END maxmin_prov;


DECLARE
    v_max NUMBER;
    v_min NUMBER;
BEGIN
    maxmin_prov('P2', v_max, v_min);  -- 'S1' es el valor para prov
    DBMS_OUTPUT.PUT_LINE('Máximo: ' || v_max || '  Mínimo: ' || v_min);
END;


--4.1.9 Para cada parte abastecida, obtenga el número de parte y el total despachado.

create or replace procedure numpar
is
    cursor pares is
        select sp.p_numero, sum(sp.qty)as total
        from sp sp
        group by sp.p_numero;
begin
    for rec in pares loop
        dbms_output.put_line(' Numero de parte: '||rec.p_numero||' Total despachado: '||rec.total);
    end loop;
end numpar;

exec numpar;

--4.1.10 Obtenga el número de parte para todas las partes abastecidas por más de un proveedor.
/*
S# P# QTY
S1 P1 300
S1 P2 200
S1 P3 400
S1 P4 200
S1 P5 100
S1 P6 100
S2 P1 300
S2 P2 400
S3 P2 200
S4 P2 200
S4 P4 300
S4 P5 400
*/
create or replace procedure masdeunp
is
    cursor pares is
        select sp.p_numero
        from sp sp
        group by sp.p_numero
        having count(sp.s_numero)>1;
begin
    for rec in pares loop
        dbms_output.put_line('Tiene mas de un proveedor: '||rec.p_numero);
    end loop;
end masdeunp;

exec masdeunp;


--------------------------------------------------------------
-- 4.1.11 Obtenga el nombre de proveedor para todos los proveedores que abastecen la parte P2.
--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prov_abastece_p2 IS
    CURSOR c_prov IS
        SELECT s.sname
        FROM S s
        JOIN SP sp ON s.s_numero = sp.s_numero
        WHERE sp.p_numero = 'P2';
BEGIN
    FOR rec IN c_prov LOOP
        dbms_output.put_line('Proveedor que abastece P2: ' || rec.sname);
    END LOOP;
END prov_abastece_p2;
/

EXEC prov_abastece_p2;

--------------------------------------------------------------
-- 4.1.12 Obtenga el nombre de proveedor de quienes abastecen por lo menos una parte.
--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prov_con_al_menos_una_parte IS
    CURSOR c_prov IS
        SELECT DISTINCT s.sname
        FROM S s
        JOIN SP sp ON s.s_numero = sp.s_numero;
BEGIN
    FOR rec IN c_prov LOOP
        dbms_output.put_line('Proveedor con al menos una parte: ' || rec.sname);
    END LOOP;
END prov_con_al_menos_una_parte;
/

EXEC prov_con_al_menos_una_parte;

--------------------------------------------------------------
-- 4.1.13 Obtenga el número de proveedor para los proveedores con estado menor
-- que el máximo valor de estado en la tabla S.
--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prov_estado_menor_max IS
    v_max_estado NUMBER;
    CURSOR c_prov IS
        SELECT s_numero
        FROM S
        WHERE status < v_max_estado;
BEGIN
    SELECT MAX(status) INTO v_max_estado FROM S;
    FOR rec IN c_prov LOOP
        dbms_output.put_line('Proveedor con estado menor al máximo: ' || rec.s_numero);
    END LOOP;
END prov_estado_menor_max;
/

EXEC prov_estado_menor_max;

--------------------------------------------------------------
-- 4.1.14 Obtenga el nombre de proveedor para los proveedores que abastecen la
-- parte P2 (aplicar EXISTS en su solución).
--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prov_existe_p2 IS
    CURSOR c_prov IS
        SELECT sname
        FROM S s
        WHERE EXISTS (
            SELECT 1
            FROM SP sp
            WHERE sp.s_numero = s.s_numero
            AND sp.p_numero = 'P2'
        );
BEGIN
    FOR rec IN c_prov LOOP
        dbms_output.put_line('Proveedor que abastece P2 (EXISTS): ' || rec.sname);
    END LOOP;
END prov_existe_p2;
/

EXEC prov_existe_p2;

--------------------------------------------------------------
-- 4.1.15 Obtenga el nombre de proveedor para los proveedores que no abastecen la parte P2.
--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prov_no_abastece_p2 IS
    CURSOR c_prov IS
        SELECT sname
        FROM S s
        WHERE NOT EXISTS (
            SELECT 1
            FROM SP sp
            WHERE sp.s_numero = s.s_numero
            AND sp.p_numero = 'P2'
        );
BEGIN
    FOR rec IN c_prov LOOP
        dbms_output.put_line('Proveedor que NO abastece P2: ' || rec.sname);
    END LOOP;
END prov_no_abastece_p2;
/

EXEC prov_no_abastece_p2;

--------------------------------------------------------------
-- 4.1.16 Obtenga el nombre de proveedor para los proveedores que abastecen todas las partes.
--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prov_abastece_todas IS
    CURSOR c_prov IS
        SELECT s.sname
        FROM S s
        WHERE NOT EXISTS (
            SELECT p.p_numero
            FROM P p
            WHERE NOT EXISTS (
                SELECT 1
                FROM SP sp
                WHERE sp.s_numero = s.s_numero
                AND sp.p_numero = p.p_numero
            )
        );
BEGIN
    FOR rec IN c_prov LOOP
        dbms_output.put_line('Proveedor que abastece TODAS las partes: ' || rec.sname);
    END LOOP;
END prov_abastece_todas;
/

EXEC prov_abastece_todas;

--------------------------------------------------------------
-- 4.1.17 Obtenga el número de parte para todas las partes que pesan más de 16 libras
-- ó son abastecidas por el proveedor S2, ó cumplen con ambos criterios.
--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE partes_mayor16_o_s2 IS
    CURSOR c_partes IS
        SELECT DISTINCT p.p_numero
        FROM P p
        LEFT JOIN SP sp ON p.p_numero = sp.p_numero
        WHERE p.weight > 16 OR sp.s_numero = 'S2';
BEGIN
    FOR rec IN c_partes LOOP
        dbms_output.put_line('Parte que cumple condición: ' || rec.p_numero);
    END LOOP;
END partes_mayor16_o_s2;
/

EXEC partes_mayor16_o_s2;






