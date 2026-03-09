-- ==========================================================
-- SISTEMA DE REGISTRO DE ASISTENCIA - INPE (UAC)
-- ==========================================================

-- 1. LIMPIEZA DE TABLAS (Borrar en orden para evitar errores de FK)
DROP TABLE Asistencia CASCADE CONSTRAINTS;
DROP TABLE Turno CASCADE CONSTRAINTS;
DROP TABLE Año CASCADE CONSTRAINTS;
DROP TABLE Empleado CASCADE CONSTRAINTS;

-- 2. CREACIÓN DE ESTRUCTURA (DDL)

CREATE TABLE Año (
    idAño NUMBER PRIMARY KEY,
    inicioAño DATE NOT NULL,
    finAño DATE NOT NULL
);

CREATE TABLE Turno (
    idT NUMBER PRIMARY KEY,
    nombreT VARCHAR2(50) NOT NULL,
    inicioT VARCHAR2(10),
    finT VARCHAR2(10),
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
    -- AUTO-RELACIÓN (Símbolo de círculo en Barker si es NULL)
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

-- 3. INSERCIÓN DE DATOS (DML)

-- Datos de Año
INSERT INTO Año VALUES (2026, TO_DATE('01/01/2026','DD/MM/YYYY'), TO_DATE('31/12/2026','DD/MM/YYYY'));

-- Datos de Turno (5 registros)
INSERT INTO Turno VALUES (1, 'Mañana 1', '06:00', '14:00', 2026);
INSERT INTO Turno VALUES (2, 'Mañana 2', '08:00', '16:00', 2026);
INSERT INTO Turno VALUES (3, 'Tarde', '14:00', '22:00', 2026);
INSERT INTO Turno VALUES (4, 'Noche', '22:00', '06:00', 2026);
INSERT INTO Turno VALUES (5, 'Especial', '10:00', '18:00', 2026);

-- Datos de Empleado (5 registros con auto-relación)
INSERT INTO Empleado VALUES (1, 'DNI', '10203041', 'Juan Carlos', 'Quispe', 'Soto', '988111001', NULL);
INSERT INTO Empleado VALUES (2, 'DNI', '45556672', 'Yefry', 'Ciaran', 'Vargas', '955443002', 1);
INSERT INTO Empleado VALUES (3, 'DNI', '70809013', 'Maria Elena', 'Flores', 'Ramos', '944111003', 1);
INSERT INTO Empleado VALUES (4, 'DNI', '30405064', 'Ricardo', 'Lapa', 'Huanaco', '977222004', 1);
INSERT INTO Empleado VALUES (5, 'DNI', '90102035', 'Ana Lucia', 'Guzman', 'Paola', '966333005', 1);

-- Datos de Asistencia (5 registros)
INSERT INTO Asistencia VALUES (1001, TO_DATE('08/03/2026','DD/MM/YYYY'), 'Lunes', 'N', 'S', 'N', CURRENT_TIMESTAMP, NULL, 1, 2);
INSERT INTO Asistencia VALUES (1002, TO_DATE('08/03/2026','DD/MM/YYYY'), 'Lunes', 'N', 'S', 'S', CURRENT_TIMESTAMP, NULL, 2, 3);
INSERT INTO Asistencia VALUES (1003, TO_DATE('08/03/2026','DD/MM/YYYY'), 'Lunes', 'N', 'S', 'N', CURRENT_TIMESTAMP, NULL, 3, 4);
INSERT INTO Asistencia VALUES (1004, TO_DATE('09/03/2026','DD/MM/YYYY'), 'Martes', 'N', 'S', 'N', CURRENT_TIMESTAMP, NULL, 1, 5);
INSERT INTO Asistencia VALUES (1005, TO_DATE('09/03/2026','DD/MM/YYYY'), 'Martes', 'N', 'N', 'N', NULL, NULL, 1, 2);

-- Guardar cambios
COMMIT;

-- 4. CONSULTAS PARA VER EN TABLAS (Selecciona y presiona Ctrl + Enter)
SELECT * FROM Empleado;
SELECT * FROM Asistencia;
