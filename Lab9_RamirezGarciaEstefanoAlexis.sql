/*
Nombre: Estefano Alexis Ramirez Garcia
Codigo:23200294

*/
SET SERVEROUTPUT ON;

-- ===========================
-- 2) Secuencias
-- ===========================
CREATE SEQUENCE sq_region START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE sq_country START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE sq_loc START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE sq_dept START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE sq_job START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE sq_emp START WITH 100 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE sq_hist START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE sq_hor START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE sq_cap START WITH 1 INCREMENT BY 1 NOCACHE;


-- ===========================
-- 3) Tablas base (Regions, Countries, Locations, Departments, Jobs, Employees, Job_History)
-- ===========================
CREATE TABLE Regions (
  region_id NUMBER PRIMARY KEY,
  region_name VARCHAR2(50) NOT NULL
);

CREATE TABLE Countries (
  country_id VARCHAR2(2) PRIMARY KEY,
  country_name VARCHAR2(50) NOT NULL,
  region_id NUMBER,
  CONSTRAINT fk_country_region FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

CREATE TABLE Locations (
  location_id NUMBER PRIMARY KEY,
  street_address VARCHAR2(100),
  postal_code VARCHAR2(20),
  city VARCHAR2(50) NOT NULL,
  state_province VARCHAR2(50),
  country_id VARCHAR2(2),
  CONSTRAINT fk_loc_country FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

CREATE TABLE Departments (
  department_id NUMBER PRIMARY KEY,
  department_name VARCHAR2(100) NOT NULL,
  location_id NUMBER,
  CONSTRAINT fk_dept_loc FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

CREATE TABLE Jobs (
  job_id VARCHAR2(10) PRIMARY KEY,
  job_title VARCHAR2(100) NOT NULL,
  min_salary NUMBER(12,2),
  max_salary NUMBER(12,2)
);

CREATE TABLE Employees (
  employee_id NUMBER PRIMARY KEY,
  first_name VARCHAR2(50),
  last_name VARCHAR2(50) NOT NULL,
  email VARCHAR2(100),
  phone_number VARCHAR2(20),
  hire_date DATE NOT NULL,
  job_id VARCHAR2(10) NOT NULL,
  salary NUMBER(12,2),
  manager_id NUMBER,
  department_id NUMBER,
  CONSTRAINT fk_emp_job FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
  CONSTRAINT fk_emp_mgr FOREIGN KEY (manager_id) REFERENCES Employees(employee_id),
  CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Job_History (
  hist_id NUMBER PRIMARY KEY,
  employee_id NUMBER NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  job_id VARCHAR2(10),
  department_id NUMBER,
  CONSTRAINT fk_hist_emp FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
  CONSTRAINT fk_hist_job FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
  CONSTRAINT fk_hist_dept FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- ===========================
-- 4) Tablas adicionales: Horario, Empleado_Horario, Asistencia_Empleado, Capacitacion, EmpleadoCapacitacion
-- ===========================
CREATE TABLE Horario (
  horario_id NUMBER PRIMARY KEY,
  dia_semana VARCHAR2(20) NOT NULL, 
  turno VARCHAR2(20) NOT NULL,
  hora_inicio DATE NOT NULL,
  hora_fin DATE NOT NULL
);

CREATE TABLE Empleado_Horario (
  empleado_horario_id NUMBER PRIMARY KEY,
  dia_semana VARCHAR2(20) NOT NULL,
  turno VARCHAR2(20) NOT NULL,
  employee_id NUMBER,
  CONSTRAINT fk_emp_hora_emp FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Asistencia_Empleado (
  asistencia_id NUMBER PRIMARY KEY,
  employee_id NUMBER NOT NULL,
  dia_semana VARCHAR2(20) NOT NULL,
  fecha_real DATE NOT NULL,
  hora_inicio_real DATE,
  hora_fin_real DATE,
  marcado_asistencia CHAR(1) DEFAULT 'S', -- S=registrado, N=inasistencia marcada por trigger
  CONSTRAINT fk_asist_emp FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Capacitacion (
  capacitacion_id NUMBER PRIMARY KEY,
  nombre VARCHAR2(100) NOT NULL,
  horas NUMBER(5,2) NOT NULL,
  descripcion VARCHAR2(4000)
);

CREATE TABLE EmpleadoCapacitacion (
  emp_cap_id NUMBER PRIMARY KEY,
  employee_id NUMBER NOT NULL,
  capacitacion_id NUMBER NOT NULL,
  CONSTRAINT fk_empcap_emp FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
  CONSTRAINT fk_empcap_cap FOREIGN KEY (capacitacion_id) REFERENCES Capacitacion(capacitacion_id)
);

-- ===========================
-- 5) Inserts de ejemplo para tablas base (10 registros mínimos donde aplica)
-- ===========================
-- Regions
INSERT INTO Regions(region_id, region_name) VALUES (sq_region.NEXTVAL,'América');
INSERT INTO Regions(region_id, region_name) VALUES (sq_region.NEXTVAL,'Europa');
INSERT INTO Regions(region_id, region_name) VALUES (sq_region.NEXTVAL,'Asia');

-- Countries (usar codes ISO-like)
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('PE','Peru',1);
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('US','United States',1);
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('ES','Spain',2);
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('CN','China',3);
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('BR','Brazil',1);
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('AR','Argentina',1);
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('MX','Mexico',1);
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('CO','Colombia',1);
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('CL','Chile',1);
INSERT INTO Countries(country_id,country_name,region_id) VALUES ('DE','Germany',2);

-- Locations (10)
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'Av. Example 123','15001','Lima','Lima','PE');
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'Wall St 1','10005','New York','NY','US');
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'C/Mayor 2','28013','Madrid','Madrid','ES');
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'Nanjing Rd 10','200001','Shanghai','Shanghai','CN');
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'Rua A 45','01000','Sao Paulo','SP','BR');
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'Av. 9 de Julio 100','C1002','Buenos Aires','CABA','AR');
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'Insurgentes 500','01000','Mexico City','CDMX','MX');
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'Bogota St','110111','Bogotá','Cundinamarca','CO');
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'Santiago Av','8320000','Santiago','RM','CL');
INSERT INTO Locations(location_id,street_address,postal_code,city,state_province,country_id) VALUES (sq_loc.NEXTVAL,'Berlin Strasse','10115','Berlin','Berlin','DE');

-- Departments (10)
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'Recursos Humanos',1);
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'Ventas',2);
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'Desarrollo',3);
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'Soporte',4);
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'Marketing',5);
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'Finanzas',6);
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'Operaciones',7);
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'Legal',8);
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'Calidad',9);
INSERT INTO Departments(department_id,department_name,location_id) VALUES (sq_dept.NEXTVAL,'I+D',10);

-- Jobs (10)
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('JR_DEV','Junior Developer',1000,3000);
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('SR_DEV','Senior Developer',3000,8000);
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('ANAL','Analyst',1200,4000);
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('HR','HR Specialist',900,3500);
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('MGR','Manager',4000,10000);
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('SALE','Sales Rep',800,5000);
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('SUPP','Support',700,2500);
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('QA','QA Engineer',1000,4500);
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('CTO','CTO',8000,20000);
INSERT INTO Jobs(job_id,job_title,min_salary,max_salary) VALUES ('Trainee','Trainee',500,1200);

-- Employees (10)
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'Carlos','Gonzales','carlos.g@ej.com','(01)111111',TO_DATE('2018-03-12','YYYY-MM-DD'),'SR_DEV',6000,NULL,3);
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'Ana','Lopez','ana.l@ej.com','(01)222222',TO_DATE('2019-06-05','YYYY-MM-DD'),'JR_DEV',2000,100,3);
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'Luis','Martinez','luis.m@ej.com','(01)333333',TO_DATE('2017-11-20','YYYY-MM-DD'),'MGR',9000,NULL,2);
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'María','Fernandez','maria.f@ej.com','(01)444444',TO_DATE('2020-01-10','YYYY-MM-DD'),'HR',3000,100,1);
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'Jorge','Perez','jorge.p@ej.com','(01)555555',TO_DATE('2016-09-01','YYYY-MM-DD'),'SALE',3500,102,2);
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'Sofia','Ruiz','sofia.r@ej.com','(01)666666',TO_DATE('2021-05-15','YYYY-MM-DD'),'SUPP',1500,101,4);
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'Pedro','Vega','pedro.v@ej.com','(01)777777',TO_DATE('2015-04-04','YYYY-MM-DD'),'ANAL',3200,103,6);
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'Lucia','Mora','lucia.m@ej.com','(01)888888',TO_DATE('2014-07-22','YYYY-MM-DD'),'QA',2800,103,9);
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'Diego','Lopez','diego.l@ej.com','(01)999999',TO_DATE('2022-02-01','YYYY-MM-DD'),'Trainee',900,102,3);
INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
VALUES (sq_emp.NEXTVAL,'Valeria','Sanchez','valeria.s@ej.com','(01)101010',TO_DATE('2013-12-12','YYYY-MM-DD'),'CTO',15000,NULL,10);

-- Job_History (ejemplos: cambios de puesto)
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,101,TO_DATE('2018-03-12','YYYY-MM-DD'),TO_DATE('2019-08-01','YYYY-MM-DD'),'JR_DEV',3);
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,101,TO_DATE('2019-08-02','YYYY-MM-DD'),TO_DATE('2021-01-01','YYYY-MM-DD'),'SR_DEV',3);
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,102,TO_DATE('2019-06-05','YYYY-MM-DD'),TO_DATE('2020-02-01','YYYY-MM-DD'),'Trainee',3);
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,102,TO_DATE('2020-02-02','YYYY-MM-DD'),TO_DATE('2022-12-31','YYYY-MM-DD'),'JR_DEV',3);
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,103,TO_DATE('2015-04-04','YYYY-MM-DD'),TO_DATE('2018-10-10','YYYY-MM-DD'),'ANAL',6);
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,103,TO_DATE('2018-10-11','YYYY-MM-DD'),TO_DATE('2020-05-31','YYYY-MM-DD'),'MGR',2);
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,104,TO_DATE('2020-01-10','YYYY-MM-DD'),TO_DATE('2021-12-31','YYYY-MM-DD'),'HR',1);
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,105,TO_DATE('2016-09-01','YYYY-MM-DD'),TO_DATE('2017-09-01','YYYY-MM-DD'),'SALE',2);
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,105,TO_DATE('2017-09-02','YYYY-MM-DD'),TO_DATE('2020-01-01','YYYY-MM-DD'),'SALE',2);
INSERT INTO Job_History(hist_id,employee_id,start_date,end_date,job_id,department_id)
VALUES (sq_hist.NEXTVAL,106,TO_DATE('2021-05-15','YYYY-MM-DD'),TO_DATE('2022-03-01','YYYY-MM-DD'),'SUPP',4);

COMMIT;

-- ===========================
-- 6) Inserts para Horario, Empleado_Horario, Asistencia_Empleado (10 cada uno mínimo)
-- ===========================
-- Para campos hora_inicio/hora_fin usaremos una fecha base '01-01-2000' con la hora correspondiente
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Lunes','Mañana',TO_DATE('2000-01-01 08:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Lunes','Tarde',TO_DATE('2000-01-01 13:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 17:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Martes','Mañana',TO_DATE('2000-01-01 08:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Martes','Tarde',TO_DATE('2000-01-01 13:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 17:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Miercoles','Mañana',TO_DATE('2000-01-01 08:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Miercoles','Tarde',TO_DATE('2000-01-01 13:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 17:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Jueves','Mañana',TO_DATE('2000-01-01 08:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Jueves','Tarde',TO_DATE('2000-01-01 13:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 17:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Viernes','Mañana',TO_DATE('2000-01-01 08:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 12:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Horario(horario_id,dia_semana,turno,hora_inicio,hora_fin)
VALUES (sq_hor.NEXTVAL,'Viernes','Tarde',TO_DATE('2000-01-01 13:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2000-01-01 17:00:00','YYYY-MM-DD HH24:MI:SS'));

-- Empleado_Horario (asignamos a varios empleados)
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Lunes','Mañana',101);
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Martes','Mañana',102);
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Miercoles','Mañana',103);
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Jueves','Tarde',104);
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Viernes','Mañana',105);
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Lunes','Tarde',106);
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Martes','Tarde',107);
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Miercoles','Tarde',108);
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Jueves','Mañana',109);
INSERT INTO Empleado_Horario(empleado_horario_id,dia_semana,turno,employee_id) VALUES (sq_hor.NEXTVAL,'Viernes','Tarde',100);

-- Asistencia_Empleado (10 registros de ejemplo: con fecha y horas reales)
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,101,'Lunes',TO_DATE('2023-09-04','YYYY-MM-DD'),TO_DATE('2023-09-04 08:05:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-04 17:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,102,'Martes',TO_DATE('2023-09-05','YYYY-MM-DD'),TO_DATE('2023-09-05 07:50:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-05 16:30:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,103,'Miercoles',TO_DATE('2023-09-06','YYYY-MM-DD'),TO_DATE('2023-09-06 08:10:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-06 17:05:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,104,'Jueves',TO_DATE('2023-09-07','YYYY-MM-DD'),TO_DATE('2023-09-07 13:05:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-07 18:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,105,'Viernes',TO_DATE('2023-09-08','YYYY-MM-DD'),TO_DATE('2023-09-08 08:35:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-08 16:30:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,106,'Lunes',TO_DATE('2023-09-11','YYYY-MM-DD'),TO_DATE('2023-09-11 13:02:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-11 17:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,107,'Martes',TO_DATE('2023-09-12','YYYY-MM-DD'),TO_DATE('2023-09-12 08:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-12 12:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,108,'Miercoles',TO_DATE('2023-09-13','YYYY-MM-DD'),TO_DATE('2023-09-13 08:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-13 12:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,109,'Jueves',TO_DATE('2023-09-14','YYYY-MM-DD'),TO_DATE('2023-09-14 08:30:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-14 16:30:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Asistencia_Empleado(asistencia_id,employee_id,dia_semana,fecha_real,hora_inicio_real,hora_fin_real)
VALUES (sq_hor.NEXTVAL,100,'Viernes',TO_DATE('2023-09-15','YYYY-MM-DD'),TO_DATE('2023-09-15 13:00:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-09-15 17:00:00','YYYY-MM-DD HH24:MI:SS'));

COMMIT;



-- ===========================
-- 7) Capacitacion y EmpleadoCapacitacion (10 registros cada una)
-- ===========================
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'SQL Básico',8,'Introducción a SQL');
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'PL/SQL Avanzado',16,'Programación PL/SQL');
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'Gestión de Proyectos',12,'Metodologías ágiles');
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'Seguridad Informática',10,'Buenas prácticas');
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'Atención al Cliente',6,'Habilidades blandas');
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'Testing Automatizado',14,'Selenium y frameworks');
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'DevOps Básico',10,'CI/CD y contenedores');
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'Big Data Intro',20,'Conceptos clave de Big Data');
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'UX/UI',8,'Principios de diseño');
INSERT INTO Capacitacion(capacitacion_id,nombre,horas,descripcion) VALUES (sq_cap.NEXTVAL,'Comunicación Efectiva',6,'Comunicación interna');


-- Asociaciones EmpleadoCapacitacion (10)
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,101,1);
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,101,2);
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,102,1);
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,103,3);
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,104,5);
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,105,6);
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,106,4);
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,107,7);
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,108,8);
INSERT INTO EmpleadoCapacitacion(emp_cap_id,employee_id,capacitacion_id) VALUES (sq_cap.NEXTVAL,109,9);

COMMIT;

-- ===========================
-- 8) PAQUETE: employees_pkg (spec y body)
-- Contendrá CRUD y las rutinas solicitadas (3.1.1 - 3.1.7, y funciones de capacitacion)
-- ===========================

CREATE OR REPLACE PACKAGE employees_pkg IS
  -- CRUD
  PROCEDURE emp_create(p_first_name VARCHAR2, p_last_name VARCHAR2, p_email VARCHAR2,
                       p_phone VARCHAR2, p_hire_date DATE, p_job_id VARCHAR2, p_salary NUMBER,
                       p_manager_id NUMBER, p_department_id NUMBER);
  PROCEDURE emp_update(p_employee_id NUMBER, p_first_name VARCHAR2, p_last_name VARCHAR2, p_email VARCHAR2,
                       p_phone VARCHAR2, p_job_id VARCHAR2, p_salary NUMBER, p_manager_id NUMBER, p_department_id NUMBER);
  PROCEDURE emp_delete(p_employee_id NUMBER);
  FUNCTION emp_get(p_employee_id NUMBER) RETURN SYS_REFCURSOR;

  -- 3.1.1 - Top 4 empleados que más han rotado de puesto (muestra count cambios)
  PROCEDURE top4_mas_rotado;

  -- 3.1.2 - Funcion: resumen promedio de contrataciones por mes. Retorna numero de meses listados
  FUNCTION promedio_contrataciones RETURN NUMBER;

  -- 3.1.3 - Procedimiento: gastos por region
  PROCEDURE gastos_por_region;

  -- 3.1.4 - Funcion: calcular tiempo de servicio (retorna total $ correspondiente al tiempo de servicio)
  FUNCTION tiempo_servicio RETURN NUMBER;

  -- 3.1.5 - Funcion: horas trabajadas por empleado en mes/año
  FUNCTION horas_trabajadas(p_employee_id NUMBER, p_mes NUMBER, p_anio NUMBER) RETURN NUMBER;

  -- 3.1.6 - Funcion: horas faltadas por empleado en mes/año
  FUNCTION horas_faltadas(p_employee_id NUMBER, p_mes NUMBER, p_anio NUMBER) RETURN NUMBER;

  -- 3.1.7 - Procedimiento: reporte sueldo por mes/año (usa funciones anteriores)
  PROCEDURE reporte_sueldo_por_mes(p_mes NUMBER, p_anio NUMBER);

  -- Capacitacion funciones
  FUNCTION horas_capacitaciones_por_empleado(p_employee_id NUMBER) RETURN NUMBER;
  PROCEDURE listar_capacitaciones_y_horas;
END employees_pkg;
/
-- BODY
CREATE OR REPLACE PACKAGE BODY employees_pkg IS

  -- CRUD implementations
  PROCEDURE emp_create(p_first_name VARCHAR2, p_last_name VARCHAR2, p_email VARCHAR2,
                       p_phone VARCHAR2, p_hire_date DATE, p_job_id VARCHAR2, p_salary NUMBER,
                       p_manager_id NUMBER, p_department_id NUMBER) IS
    v_newid NUMBER;
  BEGIN
    v_newid := sq_emp.NEXTVAL;
    INSERT INTO Employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)
    VALUES (v_newid,p_first_name,p_last_name,p_email,p_phone,p_hire_date,p_job_id,p_salary,p_manager_id,p_department_id);
    COMMIT;
  END emp_create;

  PROCEDURE emp_update(p_employee_id NUMBER, p_first_name VARCHAR2, p_last_name VARCHAR2, p_email VARCHAR2,
                       p_phone VARCHAR2, p_job_id VARCHAR2, p_salary NUMBER, p_manager_id NUMBER, p_department_id NUMBER) IS
  BEGIN
    UPDATE Employees
    SET first_name = p_first_name,
        last_name = p_last_name,
        email = p_email,
        phone_number = p_phone,
        job_id = p_job_id,
        salary = p_salary,
        manager_id = p_manager_id,
        department_id = p_department_id
    WHERE employee_id = p_employee_id;
    COMMIT;
  END emp_update;

  PROCEDURE emp_delete(p_employee_id NUMBER) IS
  BEGIN
    DELETE FROM Employees WHERE employee_id = p_employee_id;
    COMMIT;
  END emp_delete;

  FUNCTION emp_get(p_employee_id NUMBER) RETURN SYS_REFCURSOR IS
    rc SYS_REFCURSOR;
  BEGIN
    OPEN rc FOR SELECT * FROM Employees WHERE employee_id = p_employee_id;
    RETURN rc;
  END emp_get;

  -- 3.1.1 Top 4 empleados que más han rotado de puesto
  PROCEDURE top4_mas_rotado IS
  BEGIN
    FOR r IN (
      SELECT e.employee_id,
             e.last_name || ' ' || NVL(e.first_name,'') AS nombre,
             e.job_id AS puesto_actual,
             j.job_title,
             COUNT(h.hist_id) AS cambios_puesto
      FROM Employees e
      LEFT JOIN Job_History h ON e.employee_id = h.employee_id
      LEFT JOIN Jobs j ON e.job_id = j.job_id
      GROUP BY e.employee_id, e.last_name, e.first_name, e.job_id, j.job_title
      ORDER BY COUNT(h.hist_id) DESC
    ) LOOP
      DBMS_OUTPUT.PUT_LINE('ID:'||r.employee_id||' - '||r.nombre||' - job_id:'||r.puesto_actual||' ('||r.job_title||') - cambios:'||r.cambios_puesto);
    END LOOP;
  END top4_mas_rotado;

  -- 3.1.2 Funcion promedio contrataciones por mes (retorna numero de meses)
  FUNCTION promedio_contrataciones RETURN NUMBER IS
    TYPE rec IS RECORD (mes_name VARCHAR2(20), avg_count NUMBER);
    v_cursor SYS_REFCURSOR;
    v_mes VARCHAR2(20);
    v_avg NUMBER;
    v_total_meses NUMBER := 0;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Mes - Promedio de Contrataciones');
    FOR m IN (SELECT LEVEL mes_num FROM DUAL CONNECT BY LEVEL <= 12) LOOP
      -- calcular promedio del numero de contrataciones en ese mes a lo largo de los años disponibles
      SELECT TO_CHAR(hire_date,'MM') AS mm, COUNT(*) AS cnt
      INTO v_mes, v_avg
      FROM (
        SELECT hire_date FROM Employees
      )
      WHERE 1=0;
    END LOOP;
    -- consulta real: agrupamos por mes y contamos por año luego promedio por mes
    FOR r IN (
      SELECT TO_CHAR(hire_date,'MM') mes,
             TO_CHAR(hire_date,'Month') mes_nombre,
             ROUND(AVG(cnt_per_year),2) avg_por_mes
      FROM (
        SELECT EXTRACT(YEAR FROM hire_date) anio,
               TO_CHAR(hire_date,'MM') mes,
               COUNT(*) OVER (PARTITION BY EXTRACT(YEAR FROM hire_date), TO_CHAR(hire_date,'MM')) cnt_per_year,
               hire_date
        FROM Employees
      )
      GROUP BY TO_CHAR(hire_date,'MM'), TO_CHAR(hire_date,'Month')
      ORDER BY TO_CHAR(hire_date,'MM')
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(RTRIM(r.mes_nombre)||' - '||r.avg_por_mes);
      v_total_meses := v_total_meses + 1;
    END LOOP;
    RETURN v_total_meses;
  END promedio_contrataciones;

  -- 3.1.3 gastos por region (suma salarios, cantidad empleados, fecha ingreso mas antigua)
  PROCEDURE gastos_por_region IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Region | SumaSalarios | CantEmpleados | FechaIngresoMasAntiguo');
    FOR r IN (
      SELECT rg.region_name,
             SUM(e.salary) suma_salarios,
             COUNT(e.employee_id) cant_emps,
             MIN(e.hire_date) fecha_antigua
      FROM Regions rg
      LEFT JOIN Countries c ON c.region_id = rg.region_id
      LEFT JOIN Locations l ON l.country_id = c.country_id
      LEFT JOIN Departments d ON d.location_id = l.location_id
      LEFT JOIN Employees e ON e.department_id = d.department_id
      GROUP BY rg.region_name
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(r.region_name||' | '||NVL(TO_CHAR(r.suma_salarios),'0')||' | '||NVL(TO_CHAR(r.cant_emps),'0')||' | '||NVL(TO_CHAR(r.fecha_antigua,'YYYY-MM-DD'),'N/A'));
    END LOOP;
  END gastos_por_region;

  -- 3.1.4 tiempo de servicio: calculamos años de servicio por empleado y devolvemos suma de montos (sueldo proporcional)
  FUNCTION tiempo_servicio RETURN NUMBER IS
    v_total_monto NUMBER := 0;
    v_anos NUMBER;
  BEGIN
    FOR r IN (SELECT employee_id, hire_date, salary FROM Employees) LOOP
      v_anos := TRUNC(MONTHS_BETWEEN(SYSDATE, r.hire_date) / 12,0);
      -- por cada año corresponde 1 mes de sueldo (según enunciado)
      v_total_monto := v_total_monto + NVL(r.salary,0) * (v_anos / 12); -- monto proporcional por años (meses de vacaciones = años => valor = salary * años/12)
    END LOOP;
    RETURN v_total_monto;
  END tiempo_servicio;

  -- 3.1.5 horas_trabajadas: sumar diferencia hora_fin_real - hora_inicio_real en horas para ese mes y año
  FUNCTION horas_trabajadas(p_employee_id NUMBER, p_mes NUMBER, p_anio NUMBER) RETURN NUMBER IS
    v_total_hours NUMBER := 0;
  BEGIN
    FOR r IN (
      SELECT hora_inicio_real, hora_fin_real FROM Asistencia_Empleado
      WHERE employee_id = p_employee_id
        AND EXTRACT(MONTH FROM fecha_real) = p_mes
        AND EXTRACT(YEAR FROM fecha_real) = p_anio
        AND hora_inicio_real IS NOT NULL
        AND hora_fin_real IS NOT NULL
    ) LOOP
      v_total_hours := v_total_hours + (r.hora_fin_real - r.hora_inicio_real) * 24;
    END LOOP;
    RETURN v_total_hours;
  END horas_trabajadas;

  -- 3.1.6 horas_faltadas: asumimos jornada esperada por dia = horario asignado (si no hay, usamos 8)
  FUNCTION horas_faltadas(p_employee_id NUMBER, p_mes NUMBER, p_anio NUMBER) RETURN NUMBER IS
    v_dias_mes NUMBER;
    v_total_esperado NUMBER := 0;
    v_trabajadas NUMBER := 0;
    v_total_faltas NUMBER := 0;
    v_expected_per_day NUMBER := 8; -- si no se tiene horario, asumimos 8h
    BEGIN
      -- contar días laborados esperados: usamos registros de Empleado_Horario para el empleado y asumimos que cada registro representa un día a la semana
      -- Para simplificar: estimamos dias laborables en el mes = número de registros de Asistencia_Empleado con fechas en ese mes + los días sin registro
      -- Implementación simple: suma de horas esperadas = (número de días del mes hábiles: aproximamos 22 días) * 8
      v_trabajadas := horas_trabajadas(p_employee_id, p_mes, p_anio);
      v_total_esperado := 22 * v_expected_per_day;
      v_total_faltas := GREATEST(0, v_total_esperado - v_trabajadas);
      RETURN v_total_faltas;
  END horas_faltadas;

  -- 3.1.7 reporte_sueldo_por_mes: calculamos sueldo proporcional por horas trabajadas vs faltas
  PROCEDURE reporte_sueldo_por_mes(p_mes NUMBER, p_anio NUMBER) IS
    v_salary NUMBER;
    v_hours_worked NUMBER;
    v_hours_missing NUMBER;
    v_hour_value NUMBER;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Empleado | Apellido | Salario Calculado (por horas trabajadas)');
    FOR e IN (SELECT employee_id, first_name, last_name, salary FROM Employees) LOOP
      v_salary := NVL(e.salary,0);
      v_hours_worked := horas_trabajadas(e.employee_id,p_mes,p_anio);
      v_hours_missing := horas_faltadas(e.employee_id,p_mes,p_anio);
      -- definir valor/hora: salario mensual / 160 (asumiendo 40h sem *4)
      IF v_salary > 0 THEN
        v_hour_value := (v_salary) / 160;
      ELSE
        v_hour_value := 0;
      END IF;
      -- calculo: total a pagar = horas_trabajadas * valor_hora
      DBMS_OUTPUT.PUT_LINE(e.first_name ||' | '|| e.last_name ||' | '|| TO_CHAR(ROUND(v_hours_worked * v_hour_value,2)));
    END LOOP;
  END reporte_sueldo_por_mes;

  -- Capacitacion: horas totales por empleado
  FUNCTION horas_capacitaciones_por_empleado(p_employee_id NUMBER) RETURN NUMBER IS
    v_total NUMBER := 0;
  BEGIN
    FOR r IN (
      SELECT c.horas FROM Capacitacion c
      JOIN EmpleadoCapacitacion ec ON ec.capacitacion_id = c.capacitacion_id
      WHERE ec.employee_id = p_employee_id
    ) LOOP
      v_total := v_total + r.horas;
    END LOOP;
    RETURN v_total;
  END horas_capacitaciones_por_empleado;

  PROCEDURE listar_capacitaciones_y_horas IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Empleado | TotalHorasCapacitacion');
    FOR e IN (SELECT employee_id, first_name, last_name FROM Employees) LOOP
      DBMS_OUTPUT.PUT_LINE(e.first_name||' '||e.last_name||' | '||NVL(TO_CHAR(horas_capacitaciones_por_empleado(e.employee_id)),'0'));
    END LOOP;
  END listar_capacitaciones_y_horas;

END employees_pkg;
/
-- ===========================
-- 9) TRIGGERS solicitados
-- 3.2 Trigger: Verificar insercion de asistencia: fecha coincide con dia_semana, la hora_inicio_real corresponde con hora_inicio (según Horario) y hora_fin_real con hora_fin
-- Implementacion: antes de insertar, valida dia de la semana de fecha_real coincide con dia_semana; si existe un Horario para ese dia (y empleado tiene asignado un turno en Empleado_Horario), compara hora relativa +/- 1 hora (tolerancia)
-- ===========================
CREATE OR REPLACE TRIGGER trg_asist_valid
BEFORE INSERT OR UPDATE ON Asistencia_Empleado
FOR EACH ROW
DECLARE
  v_weekday VARCHAR2(20);
  v_expected_start DATE;
  v_expected_end DATE;
  v_count INTEGER;
  v_emp_turno VARCHAR2(20);
BEGIN
  -- validar que dia_semana coincide
  v_weekday := TO_CHAR(:NEW.fecha_real, 'Day', 'NLS_DATE_LANGUAGE=SPANISH');
  v_weekday := RTRIM(v_weekday);
  IF LOWER(v_weekday) <> LOWER(:NEW.dia_semana) THEN
    RAISE_APPLICATION_ERROR(-20001, 'La fecha_real no corresponde al dia_semana indicado. Fecha dia: '||v_weekday||' <> '||:NEW.dia_semana);
  END IF;

  -- buscar horario general para ese dia
  SELECT COUNT(*) INTO v_count FROM Horario h WHERE LOWER(h.dia_semana) = LOWER(:NEW.dia_semana);
  IF v_count = 0 THEN
    -- si no hay horario definido, permitimos la insercion
    NULL;
  ELSE
    -- revisar que hora_inicio_real y hora_fin_real existan y estén dentro de un rango razonable respecto a horario base
    SELECT h.hora_inicio, h.hora_fin INTO v_expected_start, v_expected_end
    FROM Horario h
    WHERE LOWER(h.dia_semana) = LOWER(:NEW.dia_semana) AND ROWNUM = 1;

    IF :NEW.hora_inicio_real IS NULL OR :NEW.hora_fin_real IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'Debe proporcionar hora_inicio_real y hora_fin_real.');
    END IF;

    -- convertimos horarios a solo tiempo comparando horas relativas (usamos la misma fecha)
    -- permitimos +/-1 hora de tolerancia
    IF ((:NEW.hora_inicio_real - v_expected_start) * 24) > 1 OR ((v_expected_start - :NEW.hora_inicio_real) * 24) > 1 THEN
      RAISE_APPLICATION_ERROR(-20003, 'Hora de inicio real fuera de tolerancia de 1 hora respecto a horario esperado.');
    END IF;

    IF ((:NEW.hora_fin_real - v_expected_end) * 24) > 1 OR ((v_expected_end - :NEW.hora_fin_real) * 24) > 1 THEN
      RAISE_APPLICATION_ERROR(-20004, 'Hora de fin real fuera de tolerancia de 1 hora respecto a horario esperado.');
    END IF;
  END IF;
END;
/

-- ===========================
-- 3.3 Trigger: Validar que sueldo asignado o actualizado esté dentro de min_salary y max_salary de Jobs
-- ===========================
CREATE OR REPLACE TRIGGER trg_salario_val
BEFORE INSERT OR UPDATE ON Employees
FOR EACH ROW
DECLARE
  v_min NUMBER;
  v_max NUMBER;
BEGIN
  SELECT min_salary, max_salary INTO v_min, v_max FROM Jobs WHERE job_id = :NEW.job_id;
  IF :NEW.salary IS NULL THEN
    RETURN;
  END IF;
  IF v_min IS NOT NULL AND v_max IS NOT NULL THEN
    IF :NEW.salary < v_min OR :NEW.salary > v_max THEN
      RAISE_APPLICATION_ERROR(-20010, 'Salario fuera del rango permitido para el puesto. Rango: '||v_min||' - '||v_max);
    END IF;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20011, 'Job_id no existe para validar rango salarial.');
END;
/

-- ===========================
-- 3.4 Trigger: Restringir acceso al registro del ingreso sea media hora antes o media hora despues de su hora exacta de ingreso y marcar inasistencia del empleado sin que el empleado se de cuenta.
-- Interpretación: Si la hora de registro es > 30 minutos tarde o >30 minutos temprano respecto al horario esperado, marcar marcado_asistencia='N' (inasistencia) pero permitir insert/update (se "marca" sin impedir)
-- ===========================
CREATE OR REPLACE TRIGGER trg_asist_inasist
BEFORE INSERT OR UPDATE ON Asistencia_Empleado
FOR EACH ROW
DECLARE
  v_expected_start DATE;
  v_tol_minutes NUMBER := 30;
  v_diff_minutes NUMBER;
BEGIN
  -- buscar horario esperado para dia y empleado (si existe Empleado_Horario para employee y dia)
  BEGIN
    SELECT h.hora_inicio INTO v_expected_start
    FROM Horario h
    WHERE LOWER(h.dia_semana) = LOWER(:NEW.dia_semana)
    AND ROWNUM = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    v_expected_start := NULL;
  END;

  IF v_expected_start IS NOT NULL AND :NEW.hora_inicio_real IS NOT NULL THEN
    v_diff_minutes := ABS((:NEW.hora_inicio_real - v_expected_start) * 24 * 60);
    IF v_diff_minutes > v_tol_minutes THEN
      :NEW.marcado_asistencia := 'N'; -- marca inasistencia
    ELSE
      :NEW.marcado_asistencia := 'S';
    END IF;
  ELSE
    :NEW.marcado_asistencia := NVL(:NEW.marcado_asistencia,'S');
  END IF;
END;
/
