-- SISTEMA DE FACTURACIÓN - POLLERÍA "LOS ÁNGELES"
-- 1. LIMPIEZA DE TABLAS
DROP TABLE Detalle CASCADE CONSTRAINTS;
DROP TABLE Producto CASCADE CONSTRAINTS;
DROP TABLE Categoria CASCADE CONSTRAINTS;
DROP TABLE Comprobante CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;

-- 2. ESTRUCTURA DE TABLAS (DDL)

CREATE TABLE Cliente (
    idC NUMBER PRIMARY KEY,
    tipoDocumC VARCHAR2(20) NOT NULL,
    nroDocumC VARCHAR2(15) NOT NULL UNIQUE,
    nombresC VARCHAR2(50) NOT NULL,
    paternoC VARCHAR2(50) NOT NULL,
    maternoC VARCHAR2(50),
    celularC VARCHAR2(15)
);

CREATE TABLE Comprobante (
    idComp NUMBER PRIMARY KEY,
    fechaHoraComp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalComp NUMBER(10,2) NOT NULL,
    idC NUMBER NOT NULL,
    CONSTRAINT fk_fac_cliente FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

CREATE TABLE Categoria (
    idCat NUMBER PRIMARY KEY,
    nombreCat VARCHAR2(50) NOT NULL,
    descripcionCat VARCHAR2(100)
);

CREATE TABLE Producto (
    idP NUMBER PRIMARY KEY,
    nombreP VARCHAR2(100) NOT NULL,
    descripcionP VARCHAR2(200),
    precioRefrencialP NUMBER(10,2) NOT NULL,
    idCat NUMBER NOT NULL,
    CONSTRAINT fk_fac_prod_cat FOREIGN KEY (idCat) REFERENCES Categoria(idCat)
);

CREATE TABLE Detalle (
    idDet NUMBER PRIMARY KEY,
    cantidadDet NUMBER NOT NULL,
    precioRealUnitarioDet NUMBER(10,2) NOT NULL,
    subtotalDet NUMBER(10,2) NOT NULL,
    idComp NUMBER NOT NULL,
    idP NUMBER NOT NULL,
    CONSTRAINT fk_fac_det_comp FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
    CONSTRAINT fk_fac_det_prod FOREIGN KEY (idP) REFERENCES Producto(idP)
);

-- 3. INSERCIÓN DE DATOS DE PRUEBA (5 REGISTROS POR TABLA)

-- Clientes
INSERT INTO Cliente VALUES (1, 'DNI', '70001101', 'Juan Alberto', 'Quispe', 'Soto', '988000111');
INSERT INTO Cliente VALUES (2, 'DNI', '45556602', 'Yefry', 'Ciaran', 'Vargas', '955000222');
INSERT INTO Cliente VALUES (3, 'DNI', '10203003', 'Maria Elena', 'Flores', 'Ramos', '944000333');
INSERT INTO Cliente VALUES (4, 'DNI', '80901004', 'Ricardo', 'Lapa', 'Huanaco', '977000444');
INSERT INTO Cliente VALUES (5, 'DNI', '30405005', 'Ana Lucia', 'Guzman', 'Paola', '966000555');

-- Categorías
INSERT INTO Categoria VALUES (1, 'Brasa', 'Pollos a la brasa tradicionales');
INSERT INTO Categoria VALUES (2, 'Bebidas', 'Gaseosas y chichas');
INSERT INTO Categoria VALUES (3, 'Entradas', 'Anticuchos y ensaladas');
INSERT INTO Categoria VALUES (4, 'Parrillas', 'Cortes de carne selectos');
INSERT INTO Categoria VALUES (5, 'Combos', 'Paquetes familiares económicos');

-- Productos
INSERT INTO Producto VALUES (10, 'Pollo Entero', 'Con papas y ensalada', 68.00, 1);
INSERT INTO Producto VALUES (11, '1/2 Pollo', 'Con papas y ensalada', 38.00, 1);
INSERT INTO Producto VALUES (12, 'Inca Kola 1.5L', 'Botella descartable', 10.50, 2);
INSERT INTO Producto VALUES (13, 'Chicha Morada Jarra', 'Receta especial Ángeles', 15.00, 2);
INSERT INTO Producto VALUES (14, 'Combo Familiar', 'Pollo + papas + gaseosa', 85.00, 5);

-- Comprobantes
INSERT INTO Comprobante VALUES (501, CURRENT_TIMESTAMP, 68.00, 1);
INSERT INTO Comprobante VALUES (502, CURRENT_TIMESTAMP, 38.00, 2);
INSERT INTO Comprobante VALUES (503, CURRENT_TIMESTAMP, 85.00, 3);
INSERT INTO Comprobante VALUES (504, CURRENT_TIMESTAMP, 10.50, 4);
INSERT INTO Comprobante VALUES (505, CURRENT_TIMESTAMP, 15.00, 5);

-- Detalles
INSERT INTO Detalle VALUES (1001, 1, 68.00, 68.00, 501, 10);
INSERT INTO Detalle VALUES (1002, 1, 38.00, 38.00, 502, 11);
INSERT INTO Detalle VALUES (1003, 1, 85.00, 85.00, 503, 14);
INSERT INTO Detalle VALUES (1004, 1, 10.50, 10.50, 504, 12);
INSERT INTO Detalle VALUES (1005, 1, 15.00, 15.00, 505, 13);

COMMIT;

-- 4. CONSULTAS PARA VER EN TABLAS
SELECT * FROM Cliente;
SELECT * FROM Comprobante;
SELECT * FROM Producto;
