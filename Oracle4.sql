-- ==========================================================
-- SISTEMA DE VENTAS - POLLERÍA "DON GALLINO" (UAC)
-- ==========================================================

-- 1. LIMPIEZA DE TABLAS (En orden inverso por las FK)
DROP TABLE Detalle CASCADE CONSTRAINTS;
DROP TABLE Producto CASCADE CONSTRAINTS;
DROP TABLE Categoría CASCADE CONSTRAINTS;
DROP TABLE Comprobante CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;

-- 2. CREACIÓN DE ESTRUCTURA (DDL)

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
    CONSTRAINT fk_comp_cliente FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

CREATE TABLE Categoría (
    idCat NUMBER PRIMARY KEY,
    nombreCat VARCHAR2(50) NOT NULL,
    descripcionCat VARCHAR2(100)
);

CREATE TABLE Producto (
    idP NUMBER PRIMARY KEY,
    nombreP VARCHAR2(100) NOT NULL,
    descripcionP VARCHAR2(200),
    precioReferencialP NUMBER(10,2) NOT NULL,
    idCat NUMBER NOT NULL,
    CONSTRAINT fk_prod_cat FOREIGN KEY (idCat) REFERENCES Categoría(idCat)
);

CREATE TABLE Detalle (
    idDet NUMBER PRIMARY KEY,
    cantidadDet NUMBER NOT NULL,
    precioRealUnitarioDet NUMBER(10,2) NOT NULL,
    subtotalDet NUMBER(10,2) NOT NULL,
    idComp NUMBER NOT NULL,
    idP NUMBER NOT NULL,
    CONSTRAINT fk_det_comp FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
    CONSTRAINT fk_det_prod FOREIGN KEY (idP) REFERENCES Producto(idP)
);

-- 3. INSERCIÓN DE DATOS DE PRUEBA (5 REGISTROS POR TABLA)

-- Clientes
INSERT INTO Cliente VALUES (1, 'DNI', '70001122', 'Yefry', 'Ciaran', 'Vargas', '955443322');
INSERT INTO Cliente VALUES (2, 'DNI', '10203040', 'Juan Carlos', 'Quispe', 'Soto', '988111222');
INSERT INTO Cliente VALUES (3, 'DNI', '44556677', 'Maria', 'Elena', 'Flores', '944111333');
INSERT INTO Cliente VALUES (4, 'DNI', '20304050', 'Ricardo', 'Lapa', 'Huanaco', '977222444');
INSERT INTO Cliente VALUES (5, 'DNI', '80901020', 'Ana Lucia', 'Guzman', 'Paola', '966333555');

-- Categorías
INSERT INTO Categoría VALUES (1, 'Pollos a la Brasa', 'Pollos tiernos al carbón');
INSERT INTO Categoría VALUES (2, 'Bebidas', 'Gaseosas y refrescos naturales');
INSERT INTO Categoría VALUES (3, 'Guarniciones', 'Papas fritas y ensaladas');
INSERT INTO Categoría VALUES (4, 'Postres', 'Dulces tradicionales');
INSERT INTO Categoría VALUES (5, 'Combos Familiares', 'Paquetes completos');

-- Productos
INSERT INTO Producto VALUES (10, '1/4 de Pollo', 'Pierna o Pecho + papas', 22.50, 1);
INSERT INTO Producto VALUES (11, 'Inca Kola 1.5L', 'Gaseosa familiar', 10.00, 2);
INSERT INTO Producto VALUES (12, 'Porción de Papas', 'Papas amarillas grandes', 12.00, 3);
INSERT INTO Producto VALUES (13, 'Chicha Morada 1L', 'Receta de la casa', 15.00, 2);
INSERT INTO Producto VALUES (14, 'Pollo Entero', 'Solo pollo a la brasa', 65.00, 1);

-- Comprobantes
INSERT INTO Comprobante VALUES (501, CURRENT_TIMESTAMP, 45.00, 1);
INSERT INTO Comprobante VALUES (502, CURRENT_TIMESTAMP, 22.50, 2);
INSERT INTO Comprobante VALUES (503, CURRENT_TIMESTAMP, 100.00, 3);
INSERT INTO Comprobante VALUES (504, CURRENT_TIMESTAMP, 65.00, 4);
INSERT INTO Comprobante VALUES (505, CURRENT_TIMESTAMP, 30.00, 5);

-- Detalles de Venta
INSERT INTO Detalle VALUES (1001, 2, 22.50, 45.00, 501, 10);
INSERT INTO Detalle VALUES (1002, 1, 22.50, 22.50, 502, 10);
INSERT INTO Detalle VALUES (1003, 1, 65.00, 65.00, 503, 14);
INSERT INTO Detalle VALUES (1004, 1, 65.00, 65.00, 504, 14);
INSERT INTO Detalle VALUES (1005, 2, 15.00, 30.00, 505, 13);

COMMIT;

-- 4. CONSULTAS PARA VER LOS RESULTADOS EN TABLAS
SELECT * FROM Cliente;
SELECT * FROM Producto;
SELECT * FROM Comprobante;
