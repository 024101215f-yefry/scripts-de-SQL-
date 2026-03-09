-- SISTEMA DE ASISTENCIA - GIMNASIO "TITANIUM" 
-- 1. LIMPIEZA DE TABLAS
DROP TABLE Asistencia CASCADE CONSTRAINTS;
DROP TABLE GrupoDisciplina CASCADE CONSTRAINTS;
DROP TABLE Disciplina CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;

-- 2. CREACIÓN DE ESTRUCTURA (DDL)

CREATE TABLE Cliente (
    idC NUMBER PRIMARY KEY,
    tipoDocumC VARCHAR2(20) NOT NULL,
    nroDocumC VARCHAR2(15) NOT NULL UNIQUE,
    nombresC VARCHAR2(50) NOT NULL,
    paternoC VARCHAR2(50) NOT NULL,
    maternoC VARCHAR2(50),
    generoC VARCHAR2(15),
    fechaNacimC DATE,
    enfermedadesC VARCHAR2(200),
    celularC VARCHAR2(15)
);

CREATE TABLE Disciplina (
    idD NUMBER PRIMARY KEY,
    nombreD VARCHAR2(50) NOT NULL,
    descripcionD VARCHAR2(200)
);

CREATE TABLE GrupoDisciplina (
    idG NUMBER PRIMARY KEY,
    nombreG VARCHAR2(50) NOT NULL, -- Ejemplo: 'Grupo Mañana A'
    fechaInicioG DATE NOT NULL,
    fechaFinG DATE,
    idD NUMBER NOT NULL,
    CONSTRAINT fk_grupo_disci FOREIGN KEY (idD) REFERENCES Disciplina(idD)
);

CREATE TABLE Asistencia (
    idA NUMBER PRIMARY KEY,
    fechaA DATE DEFAULT SYSDATE,
    diaA VARCHAR2(20),
    esferiadoA CHAR(1), -- 'S' o 'N'
    asistioA CHAR(1),   -- 'S' o 'N'
    horaEntradaA TIMESTAMP,
    idC NUMBER NOT NULL,
    idG NUMBER NOT NULL,
    CONSTRAINT fk_asist_cli FOREIGN KEY (idC) REFERENCES Cliente(idC),
    CONSTRAINT fk_asist_grupo FOREIGN KEY (idG) REFERENCES GrupoDisciplina(idG)
);

-- 3. INSERCIÓN DE DATOS DE PRUEBA (5 REGISTROS POR TABLA)

-- Disciplinas
INSERT INTO Disciplina VALUES (1, 'Crossfit', 'Entrenamiento de alta intensidad');
INSERT INTO Disciplina VALUES (2, 'Boxeo', 'Técnicas de combate y cardio');
INSERT INTO Disciplina VALUES (3, 'Yoga', 'Flexibilidad y meditación');
INSERT INTO Disciplina VALUES (4, 'Zumba', 'Baile deportivo');
INSERT INTO Disciplina VALUES (5, 'Spinning', 'Ciclismo indoor');

-- Grupos
INSERT INTO GrupoDisciplina VALUES (10, 'Madrugadores', TO_DATE('01/03/2026','DD/MM/YYYY'), NULL, 1);
INSERT INTO GrupoDisciplina VALUES (11, 'Box Nocturno', TO_DATE('01/03/2026','DD/MM/YYYY'), NULL, 2);
INSERT INTO GrupoDisciplina VALUES (12, 'Yoga Relax', TO_DATE('01/03/2026','DD/MM/YYYY'), NULL, 3);

-- Clientes
INSERT INTO Cliente VALUES (1, 'DNI', '40001101', 'Yefry', 'Ciaran', 'Vargas', 'Masculino', TO_DATE('15/05/1995','DD/MM/YYYY'), 'Ninguna', '955000111');
INSERT INTO Cliente VALUES (2, 'DNI', '10203002', 'Maria', 'Flores', 'Ramos', 'Femenino', TO_DATE('20/08/1992','DD/MM/YYYY'), 'Asma controlada', '988000222');
INSERT INTO Cliente VALUES (3, 'DNI', '70809003', 'Juan Carlos', 'Quispe', 'Soto', 'Masculino', TO_DATE('10/12/1988','DD/MM/YYYY'), 'Ninguna', '944000333');

-- Asistencias
INSERT INTO Asistencia VALUES (501, SYSDATE, 'Lunes', 'N', 'S', CURRENT_TIMESTAMP, 1, 10);
INSERT INTO Asistencia VALUES (502, SYSDATE, 'Lunes', 'N', 'S', CURRENT_TIMESTAMP, 2, 12);
INSERT INTO Asistencia VALUES (503, SYSDATE, 'Lunes', 'N', 'N', NULL, 3, 11);

COMMIT;

-- 4. VER RESULTADOS
SELECT * FROM Cliente;
SELECT * FROM Asistencia;
