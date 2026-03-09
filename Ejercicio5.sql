-- SISTEMA DE GESTIÓN DE ELECTRODOMÉSTICOS (UAC)
-- 1. LIMPIEZA DE SEGURIDAD
DROP TABLE detalleDeIngresoSalida CASCADE CONSTRAINTS;
DROP TABLE Electrodomestico CASCADE CONSTRAINTS;
DROP TABLE Comprobante CASCADE CONSTRAINTS;
DROP TABLE OrdenDeCompra CASCADE CONSTRAINTS;
DROP TABLE Proveedor CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;

-- 2. ESTRUCTURA DE TABLAS (DDL)

CREATE TABLE Proveedor (
    idP NUMBER PRIMARY KEY,
    razonSocialP VARCHAR2(100) NOT NULL,
    direccionP VARCHAR2(150)
);

CREATE TABLE OrdenDeCompra (
    idOrden NUMBER PRIMARY KEY,
    fechaHoraOrden TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalOrden NUMBER(12,2) NOT NULL,
    idP NUMBER NOT NULL,
    CONSTRAINT fk_orden_prov FOREIGN KEY (idP) REFERENCES Proveedor(idP)
);

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
    tipoComp VARCHAR2(20) NOT NULL, -- Boleta o Factura
    fechaHoraComp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalComp NUMBER(12,2) NOT NULL,
    idC NUMBER NOT NULL,x
    CONSTRAINT fk_comp_cliente FOREIGN KEY (idC) REFERENCES Cliente(idC)
);

CREATE TABLE Electrodomestico (
    idE NUMBER PRIMARY KEY,
    nombreE VARCHAR2(100) NOT NULL,
    marcaE VARCHAR2(50),
    modeloE VARCHAR2(50),
    precioVentaE NUMBER(10,2) NOT NULL,
    precioCompraE NUMBER(10,2) NOT NULL
);

CREATE TABLE detalleDeIngresoSalida (
    idDet NUMBER PRIMARY KEY,
    tipoDet VARCHAR2(20) NOT NULL, -- 'INGRESO' (Compra) o 'SALIDA' (Venta)
    subtotalDet NUMBER(12,2) NOT NULL,
    cantidadDet NUMBER NOT NULL,
    idOrden NUMBER, -- Opcional: solo si es Ingreso
    idComp NUMBER,  -- Opcional: solo si es Salida
    idE NUMBER NOT NULL,
    CONSTRAINT fk_det_orden FOREIGN KEY (idOrden) REFERENCES OrdenDeCompra(idOrden),
    CONSTRAINT fk_det_comp FOREIGN KEY (idComp) REFERENCES Comprobante(idComp),
    CONSTRAINT fk_det_electro FOREIGN KEY (idE) REFERENCES Electrodomestico(idE)
);

-- 3. INSERCIÓN DE DATOS DE PRUEBA (5 REGISTROS)

INSERT INTO Proveedor VALUES (1, 'Samsung Perú SAC', 'Av. Encalada 123, Lima');
INSERT INTO Proveedor VALUES (2, 'LG Electronics', 'Av. República de Panamá 456');

INSERT INTO Cliente VALUES (1, 'DNI', '45556677', 'Yefry', 'Ciaran', 'Vargas', '955111222');
INSERT INTO Cliente VALUES (2, 'DNI', '10203040', 'Juan Carlos', 'Quispe', 'Mamani', '988333444');

INSERT INTO Electrodomestico VALUES (101, 'Refrigeradora Top Mount', 'Samsung', 'RT29', 1899.00, 1200.00);
INSERT INTO Electrodomestico VALUES (102, 'Lavadora Carga Frontal', 'LG', 'VIVACE', 2199.00, 1500.00);
INSERT INTO Electrodomestico VALUES (103, 'Smart TV 55"', 'Sony', 'Bravia', 2599.00, 1800.00);

-- Una compra al proveedor
INSERT INTO OrdenDeCompra VALUES (5001, CURRENT_TIMESTAMP, 12000.00, 1);
INSERT INTO detalleDeIngresoSalida VALUES (1, 'INGRESO', 12000.00, 10, 5001, NULL, 101);

-- Una venta al cliente
INSERT INTO Comprobante VALUES (9001, 'Boleta', CURRENT_TIMESTAMP, 1899.00, 1);
INSERT INTO detalleDeIngresoSalida VALUES (2, 'SALIDA', 1899.00, 1, NULL, 9001, 101);

COMMIT;

-- 4. VER RESULTADOS
SELECT * FROM Electrodomestico;
SELECT * FROM detalleDeIngresoSalida;
