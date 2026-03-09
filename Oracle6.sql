-- SISTEMA DE ASISTENCIA - CLÍNICA MAC SALUD 
-- 1. LIMPIEZA DE TABLAS
DROP TABLE Asistencia CASCADE CONSTRAINTS;
DROP TABLE Calendario CASCADE CONSTRAINTS;
DROP TABLE Ambiente CASCADE CONSTRAINTS;
DROP TABLE Enfermero CASCADE CONSTRAINTS;

-- 2. CREACIÓN DE ESTRUCTURA (DDL)

CREATE TABLE Enfermero (
    idE NUMBER PRIMARY KEY,
    tipoDocumE VARCHAR2(20) NOT NULL,
    nroDocumE VARCHAR2(15) NOT NULL UNIQUE,
    nombresE VARCHAR2(50) NOT NULL,
    paternoE VARCHAR2(50) NOT NULL,
    maternoE VARCHAR2(50) NOT NULL,
    fechaNacimientoE DATE,
    generoE VARCHAR2(10) -- 'Masculino' o 'Femenino'
);

CREATE TABLE Calendario (
    idC NUMBER PRIMARY KEY,
    inicioC DATE NOT NULL,
    finC DATE NOT NULL,
    nombreC VARCHAR2(50) NOT NULL -- Ejemplo: 'Turno Marzo 2026'
);

CREATE TABLE Ambiente (
    idAmb NUMBER PRIMARY KEY,
    nroAmb VARCHAR2(10) NOT NULL, -- Ejemplo: 'Piso 2-201'
    ubicacionAmb VARCHAR2(100) NOT NULL -- Ejemplo: 'Emergencias', 'UCI'
);

CREATE TABLE Asistencia (
    idA NUMBER PRIMARY KEY,
    fechaA DATE DEFAULT SYSDATE,
    diaA VARCHAR2(20),
    asistioA CHAR(1),       -- 'S' o 'N'
    tardoA CHAR(1),         -- 'S' o 'N'
    horaEntradaA TIMESTAMP,
    horaSalidaA TIMESTAMP,
    justificacionA VARCHAR2(200),
    esDescansoA CHAR(1),    -- 'S' o 'N'
    idE NUMBER NOT NULL,
    idC NUMBER NOT NULL,
    idAmb NUMBER NOT NULL,
    CONSTRAINT fk_asist_enfermero FOREIGN KEY (idE) REFERENCES Enfermero(idE),
    CONSTRAINT fk_asist_calendario FOREIGN KEY (idC) REFERENCES Calendario(idC),
    CONSTRAINT fk_asist_ambiente FOREIGN KEY (idAmb) REFERENCES Ambiente(idAmb)
);

-- 3. INSERCIÓN DE DATOS DE PRUEBA (5 REGISTROS POR TABLA)

-- Enfermeros
INSERT INTO Enfermero VALUES (1, 'DNI', '40506071', 'Maria', 'Elena', 'Paucar', TO_DATE('15/05/1990','DD/MM/YYYY'), 'Femenino');
INSERT INTO Enfermero VALUES (2, 'DNI', '45556672', 'Yefry', 'Ciaran', 'Vargas', TO_DATE('20/10/1995','DD/MM/YYYY'), 'Masculino');
INSERT INTO Enfermero VALUES (3, 'DNI', '10203043', 'Ana', 'Lucia', 'Guzman', TO_DATE('12/02/1988','DD/MM/YYYY'), 'Femenino');
INSERT INTO Enfermero VALUES (4, 'DNI', '70809044', 'Juan Carlos', 'Quispe', 'Soto', TO_DATE('05/08/1992','DD/MM/YYYY'), 'Masculino');
INSERT INTO Enfermero VALUES (5, 'DNI', '30405045', 'Sandra', 'Mendoza', 'Paola', TO_DATE('30/12/1994','DD/MM/YYYY'), 'Femenino');

-- Calendarios
INSERT INTO Calendario VALUES (101, TO_DATE('01/03/2026','DD/MM/YYYY'), TO_DATE('31/03/2026','DD/MM/YYYY'), 'Marzo 2026');
INSERT INTO Calendario VALUES (102, TO_DATE('01/04/2026','DD/MM/YYYY'), TO_DATE('30/04/2026','DD/MM/YYYY'), 'Abril 2026');

-- Ambientes
INSERT INTO Ambiente VALUES (1, '101', 'Triaje');
INSERT INTO Ambiente VALUES (2, '202', 'Hospitalización');
INSERT INTO Ambiente VALUES (3, '301', 'UCI');
INSERT INTO Ambiente VALUES (4, '105', 'Emergencias');
INSERT INTO Ambiente VALUES (5, '210', 'Consultorios Externos');

-- Asistencias
INSERT INTO Asistencia VALUES (5001, TO_DATE('08/03/2026','DD/MM/YYYY'), 'Domingo', 'S', 'N', TO_TIMESTAMP('08/03/2026 07:00:00','DD/MM/YYYY HH24:MI:SS'), NULL, NULL, 'N', 1, 101, 1);
INSERT INTO Asistencia VALUES (5002, TO_DATE('08/03/2026','DD/MM/YYYY'), 'Domingo', 'S', 'S', TO_TIMESTAMP('08/03/2026 07:25:00','DD/MM/YYYY HH24:MI:SS'), NULL, 'Trafico', 'N', 2, 101, 2);
INSERT INTO Asistencia VALUES (5003, TO_DATE('08/03/2026','DD/MM/YYYY'), 'Domingo', 'N', 'N', NULL, NULL, NULL, 'S', 3, 101, 3);
INSERT INTO Asistencia VALUES (5004, TO_DATE('09/03/2026','DD/MM/YYYY'), 'Lunes', 'S', 'N', TO_TIMESTAMP('09/03/2026 06:55:00','DD/MM/YYYY HH24:MI:SS'), NULL, NULL, 'N', 4, 101, 4);
INSERT INTO Asistencia VALUES (5005, TO_DATE('09/03/2026','DD/MM/YYYY'), 'Lunes', 'N', 'N', NULL, NULL, 'Salud', 'N', 5, 101, 5);

COMMIT;

-- 4. CONSULTAS PARA TABLAS
SELECT * FROM Enfermero;
SELECT * FROM Asistencia;
SELECT * FROM Ambiente;
