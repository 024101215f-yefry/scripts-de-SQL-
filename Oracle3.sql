-- ==========================================================
-- SISTEMA DE ASISTENCIA PERSONAL - INPE (UAC)
-- ==========================================================

-- 1. LIMPIEZA DE TABLAS
DROP TABLE Asistencia CASCADE CONSTRAINTS;
DROP TABLE Turno CASCADE CONSTRAINTS;
DROP TABLE Año CASCADE CONSTRAINTS;
DROP TABLE Empleado CASCADE CONSTRAINTS;

-- 2. CREACIÓN DE TABLAS (DDL)

CREATE TABLE Año (
    idAño NUMBER PRIMARY KEY,
    inicioAño DATE NOT NULL,
    finAño DATE NOT NULL
);

CREATE TABLE Turno (
    idT NUMBER PRIMARY KEY,
    nombreT VARCHAR2(50) NOT NULL,
    inicioT VARCHAR2(10), -- Formato '08:00'
    finT VARCHAR2(10),    -- Formato '16:00'
    idAño NUMBER NOT NULL,
    CONSTRAINT fk_turno_año FOREIGN KEY (idAño) REFERENCES Año(idAño)
);

CREATE TABLE Empleado (
    idE NUMBER PRIMARY KEY,
    tipoDocumE VARCHAR2(20) NOT NULL,
    nroDocumE VARCHAR2(15) NOT NULL UNIQUE,
    nombresE VARCHAR2(50) NOT NULL,
    paternoE VARCHAR2(50) NOT NULL,
    maternoE VARCHAR2(50) NOT NULL,
    celularE VARCHAR2(15),
    -- AUTO-RELACIÓN: Relaciona un empleado con su Supervisor
    idSupervisor NUMBER,
    CONSTRAINT fk_empleado_supervisor FOREIGN KEY (idSupervisor) REFERENCES Empleado(idE)
);

CREATE TABLE Asistencia (
    idA NUMBER PRIMARY KEY,
    fechaA DATE DEFAULT SYSDATE,
    diaA VARCHAR2(20),
    esFeriadoA CHAR(1), -- 'S' o 'N'
    asistioA CHAR(1),   -- 'S' o 'N'
    tardoA CHAR(1),     -- 'S' o 'N'
    horaEntradaA TIMESTAMP,
    horaSalidaA TIMESTAMP,
    idT NUMBER NOT NULL,
    idE NUMBER NOT NULL,
    CONSTRAINT fk_asist_turno FOREIGN KEY (idT) REFERENCES Turno(idT),
    CONSTRAINT fk_asist_empleado FOREIGN KEY (idE) REFERENCES Empleado(idE)
);

-- 3. INSERCIÓN DE DATOS DE PRUEBA (DML)

-- Datos de Año
INSERT INTO Año VALUES (2026, TO_DATE('01/01/2026','DD/MM/YYYY'), TO_DATE('31/12/2026','DD/MM/YYYY'));

-- Datos de Turno
INSERT INTO Turno VALUES (1, 'Mañana', '07:00', '15:00', 2026);
INSERT INTO Turno VALUES (2, 'Tarde', '15:00', '23:00', 2026);
INSERT INTO Turno VALUES (3, 'Noche', '23:00', '07:00', 2026);
INSERT INTO Turno VALUES (4, 'Administrativo', '08:00', '16:00', 2026);
INSERT INTO Turno VALUES (5, 'Especial', '10:00', '18:00', 2026);

-- Datos de Empleado (Con jerarquía de Supervisor)
-- El ID 1 es el Supervisor General (NULL porque no tiene jefe arriba)
INSERT INTO Empleado VALUES (1, 'DNI', '10203041', 'Juan Carlos', 'Quispe', 'Soto', '988111001', NULL);
-- Empleados supervisados por el ID 1
INSERT INTO Empleado VALUES (2, 'DNI', '45556672', 'Yefry', 'Ciaran', 'Vargas', '955443002', 1);
INSERT INTO Empleado VALUES (3, 'DNI', '70809013', 'Maria Elena', 'Flores', 'Ramos', '944111003', 1);
INSERT INTO Empleado VALUES (4, 'DNI', '30405064', 'Ricardo', 'Lapa', 'Huanaco', '977222004', 1);
INSERT INTO Empleado VALUES (5, 'DNI', '90102035', 'Ana Lucia', 'Guzman', 'Paola', '966333005', 1);

-- Datos de Asistencia
INSERT INTO Asistencia (idA, fechaA, diaA, esFeriadoA, asistioA, tardoA, horaEntradaA, idT, idE) 
VALUES (1001, TO_DATE('08/03/2026','DD/MM/YYYY'), 'Domingo', 'N', 'S', 'N', CURRENT_TIMESTAMP, 1, 2);
INSERT INTO Asistencia (idA, fechaA, diaA, esFeriadoA, asistioA, tardoA, horaEntradaA, idT, idE) 
VALUES (1002, TO_DATE('08/03/2026','DD/MM/YYYY'), 'Domingo', 'N', 'S', 'S', CURRENT_TIMESTAMP, 2, 3);
INSERT INTO Asistencia (idA, fechaA, diaA, esFeriadoA, asistioA, tardoA, horaEntradaA, idT, idE) 
VALUES (1003, TO_DATE('08/03/2026','DD/MM/YYYY'), 'Domingo', 'N', 'S', 'N', CURRENT_TIMESTAMP, 3, 4);
INSERT INTO Asistencia (idA, fechaA, diaA, esFeriadoA, asistioA, tardoA, horaEntradaA, idT, idE) 
VALUES (1004, TO_DATE('09/03/2026','DD/MM/YYYY'), 'Lunes', 'N', 'S', 'N', CURRENT_TIMESTAMP, 1, 5);
INSERT INTO Asistencia (idA, fechaA, diaA, esFeriadoA, asistioA, tardoA, horaEntradaA, idT, idE) 
VALUES (1005, TO_DATE('09/03/2026','DD/MM/YYYY'), 'Lunes', 'N', 'N', 'N', NULL, 1, 2);

COMMIT;

-- 4. CONSULTAS PARA TABLAS (Ejecutar con Ctrl + Enter)
SELECT * FROM Empleado;
SELECT * FROM Asistencia;
