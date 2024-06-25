-- Crear la base de datos
CREATE DATABASE waybuss_db;
GO

-- Seleccionar la base de datos
USE waybuss_db;
GO

-- Tabla Cliente

CREATE TABLE Cliente (
    Id_Cliente INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Numero_Documento NVARCHAR(12) NOT NULL UNIQUE,
    Nombre NVARCHAR(120) NOT NULL,
    Apellido_P NVARCHAR(80) NOT NULL,
    Apellido_M NVARCHAR(80) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Sexo NVARCHAR(1) NULL,
    Numero_Movil INT NULL,
    Correo NVARCHAR(50) NOT NULL UNIQUE
)

-- Tabla Vendedor

CREATE TABLE Vendedor (
    Id_Vendedor INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Dni INT NOT NULL UNIQUE,
    Nombre NVARCHAR(120) NOT NULL,
    Apellido_Paterno NVARCHAR(80) NOT NULL,
    Apellido_Materno NVARCHAR(80) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Numero_Movil INT NOT NULL,
    Correo NVARCHAR(200) NULL,
    Id_Supervisor INT,
    CONSTRAINT fk_vendedor_supervisor FOREIGN KEY (Id_Supervisor) REFERENCES Vendedor(Id_Vendedor)
)

-- Tabla Ruta

CREATE TABLE Ruta (
    Id_Ruta INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Origen NVARCHAR(120) NOT NULL,
    Destino NVARCHAR(120) NOT NULL,
    Horas_Viaje INT NOT NULL,
    Paradas INT NOT NULL
)

-- Tabla Tipo_Comprobante

CREATE TABLE Tipo_Comprobante (
    Id_Comprobante INT IDENTITY(1,1)  PRIMARY KEY NOT NULL,
    Nombre NVARCHAR(100) NOT NULL
)

-- Tabla Categoria_Buss

CREATE TABLE Categoria_Buss (
    Id_Categoria_Buss INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Nombre NVARCHAR(120) NOT NULL UNIQUE,
    Descripcion NVARCHAR(MAX) NOT NULL
)

-- Tabla Bus

CREATE TABLE Bus (
    Placa_Buss NVARCHAR(6) PRIMARY KEY NOT NULL,
    Nombres_Piloto NVARCHAR(200) NOT NULL,
    Apellidos_Piloto NVARCHAR(200) NOT NULL,
    Nombres_Copiloto NVARCHAR(200) NOT NULL,
    Apellidos_Copiloto NVARCHAR(200) NOT NULL,
    Cap_Asientos INT NOT NULL,
    Id_Categoria_Bus INT NOT NULL,
    CONSTRAINT fk_bus_categoria_buss FOREIGN KEY (Id_Categoria_Bus) REFERENCES Categoria_Buss(Id_Categoria_Buss)
)

-- Tabla Venta

CREATE TABLE Venta (
    Id_Venta INT IDENTITY(1,1)PRIMARY KEY NOT NULL,
    Id_Vendedor INT NOT NULL,
    Fecha DATE NOT NULL,
    Monto FLOAT NOT NULL,
    Numero_Asiento INT NOT NULL,
    Placa_Buss NVARCHAR(6) NOT NULL,
    Id_Cliente INT NOT NULL,
    Id_Ruta INT NOT NULL,
    Id_Comprobante INT NOT NULL,
    CONSTRAINT fk_venta_vendedor FOREIGN KEY (Id_Vendedor) REFERENCES Vendedor(Id_Vendedor),
    CONSTRAINT fk_venta_bus FOREIGN KEY (Placa_Buss) REFERENCES Bus(Placa_Buss),
    CONSTRAINT fk_venta_cliente FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente),
    CONSTRAINT fk_venta_ruta FOREIGN KEY (Id_Ruta) REFERENCES Ruta(Id_Ruta),
    CONSTRAINT fk_venta_comprobante FOREIGN KEY (Id_Comprobante) REFERENCES Tipo_Comprobante(Id_Comprobante)
)

-- Tabla Detalle_Venta

CREATE TABLE Detalle_Venta (
    Id_Venta INT NOT NULL PRIMARY KEY,  
    Precio FLOAT NOT NULL,
    Razon_Social NVARCHAR(150)NULL,
    RUC INT NULL,
    Tipo_Pago NVARCHAR(80) NOT NULL,
    CONSTRAINT fk_detalle_venta FOREIGN KEY (Id_Venta) REFERENCES Venta(Id_Venta) ON DELETE CASCADE
);
 

---------------------------------------------------------------------------------------------------------------------------------

-- Inserción Cliente

INSERT INTO Cliente (Numero_Documento, Nombre, Apellido_P, Apellido_M, Fecha_Nacimiento, Sexo, Numero_Movil, Correo) 
VALUES 
    ('ABC123456789', 'Juan', 'Pérez', 'García', '1985-07-15', 'M', 912345678, 'juan.perez@gmail.com'),
    ('XYZ234567890', 'María', 'López', 'Martínez', '1990-08-22', 'F', 923456789, 'maria.lopez@hotmail.com'),
    ('CDE345678901', 'Carlos', 'Sánchez', 'Hernández', '1987-01-10', NULL, 934567890, 'carlos.sanchez@yahoo.com'),
    ('456789012345', 'Ana', 'González', 'Ruiz', '1995-02-14', 'F', 945678901, 'ana.gonzalez@gmail.com'),
    ('567890123456', 'Luis', 'Rodríguez', 'Fernández', '1982-03-05', 'M', 956789012, 'luis.rodriguez@hotmail.com'),
    ('678901234567', 'Elena', 'Martín', 'Gómez', '1993-11-29', NULL, 967890123, 'elena.martin@yahoo.com'),
    ('789012345678', 'Miguel', 'Torres', 'Vega', '1980-06-18', 'M', 978901234, 'miguel.torres@gmail.com'),
    ('890123456789', 'Laura', 'Romero', 'García', '1998-09-12', 'F', 989012345, 'laura.romero@hotmail.com'),
    ('901234567890', 'Pedro', 'Vázquez', 'Mendoza', '1983-04-09', NULL, 990123456, 'pedro.vazquez@yahoo.com'),
    ('ABC012345678', 'Sofía', 'Reyes', 'López', '1991-07-25', 'F', 901234567, 'sofia.reyes@gmail.com'),
    ('DEF112345678', 'Fernando', 'Navarro', 'Morales', '1989-05-17', 'M', 912345679, 'fernando.navarro@hotmail.com'),
    ('223456789012', 'Clara', 'Aguilar', 'Ortega', '1994-10-08', NULL, 923456780, 'clara.aguilar@yahoo.com'),
    ('334567890123', 'Daniel', 'Méndez', 'Jiménez', '1986-11-22', 'M', 934567801, 'daniel.mendez@gmail.com'),
    ('445678901234', 'Paula', 'Ortiz', 'Cruz', '1992-01-30', 'F', 945678912, 'paula.ortiz@hotmail.com'),
    ('556789012345', 'Jorge', 'Silva', 'Ramos', '1984-12-20', 'M', 956789123, 'jorge.silva@yahoo.com'),
    ('667890123456', 'Lucía', 'Rojas', 'Santos', '1996-08-05', 'F', 967890234, 'lucia.rojas@gmail.com'),
    ('778901234567', 'Roberto', 'Herrera', 'Flores', '1988-03-25', 'M', 978901345, 'roberto.herrera@hotmail.com'),
    ('889012345678', 'Marta', 'Castro', 'Ramírez', '1999-06-02', 'F', 989012456, 'marta.castro@yahoo.com'),
    ('990123456789', 'Francisco', 'Gutiérrez', 'Díaz', '1981-09-27', 'M', 990123567, 'francisco.gutierrez@gmail.com'),
    ('101234567890', 'Andrea', 'Ruiz', 'Ortiz', '1997-05-13', 'F', 912345678, 'andrea.ruiz@hotmail.com'),
    ('211234567890', 'Manuel', 'Cano', 'Hidalgo', '1986-02-21', 'M', 923456789, 'manuel.cano@yahoo.com'),
    ('322345678901', 'Rocío', 'Núñez', 'Gallego', '1990-12-04', 'F', 934567890, 'rocio.nunez@gmail.com'),
    ('433456789012', 'Santiago', 'Moreno', 'Marín', '1984-06-14', 'M', 945678901, 'santiago.moreno@hotmail.com'),
    ('544567890123', 'Alicia', 'Ramos', 'Garrido', '1993-03-18', 'F', 956789012, 'alicia.ramos@yahoo.com'),
    ('655678901234', 'Alberto', 'Pena', 'Pascual', '1989-07-11', 'M', 967890123, 'alberto.pena@gmail.com'),
    ('766789012345', 'Patricia', 'Soto', 'Medina', '1995-04-03', NULL, 978901234, 'patricia.soto@hotmail.com'),
    ('877890123456', 'Diego', 'García', 'López', '1983-11-23', 'M', 989012345, 'diego.garcia@yahoo.com'),
    ('988901234567', 'Silvia', 'Ortega', 'Molina', '1991-08-16', 'F', 990123456, 'silvia.ortega@gmail.com'),
    ('099012345678', 'Juan', 'Martínez', 'Suárez', '1987-05-07', 'M', 912345678, 'juan.martinez@hotmail.com'),
    ('110123456789', 'Elena', 'Gómez', 'Hernández', '1996-01-19', 'F', 923456789, 'elena.gomez@yahoo.com');
GO


-- Inserción Vendedor 

INSERT INTO Vendedor (Dni, Nombre, Apellido_Paterno, Apellido_Materno, Fecha_Nacimiento, Numero_Movil, Correo, Id_Supervisor)
VALUES 
    (12345678, 'Juan', 'López', 'García', '1987-05-15', 912345678, 'juan.lopez@gmail.com', NULL), -- Supervisor
    (23456789, 'María', 'Martínez', 'Pérez', '1990-08-22', 923456789, 'maria.martinez@gmail.com', NULL) -- Supervisor
GO

INSERT INTO Vendedor (Dni, Nombre, Apellido_Paterno, Apellido_Materno, Fecha_Nacimiento, Numero_Movil, Correo, Id_Supervisor)
VALUES(34567890, 'Carlos', 'Sánchez', 'Hernández', '1985-11-10', 934567890, 'carlos.sanchez@yahoo.com', 1),
    (45678901, 'Ana', 'González', 'Ruiz', '1993-02-14', 945678901, NULL, 2),
    (56789012, 'Luis', 'Rodríguez', 'Fernández', '1980-03-05', 956789012, 'luis.rodriguez@hotmail.com', 1),
    (67890123, 'Elena', 'Gómez', 'Gutiérrez', '1995-11-29', 967890123, 'elena.gomez@yahoo.com', 2),
    (78901234, 'Miguel', 'Torres', 'Vega', '1988-06-18', 978901234, NULL, 1),
    (89012345, 'Laura', 'Romero', 'García', '1992-09-12', 989012345, 'laura.romero@hotmail.com', 2),
    (90123456, 'Pedro', 'Vázquez', 'Mendoza', '1983-04-09', 990123456, 'pedro.vazquez@yahoo.com', 1),
    (22334459, 'Fernando', 'Navarro', 'Morales', '1988-05-17', 912345678, 'fernando.navarro@hotmail.com', 1),
    (33445566, 'Clara', 'Aguilar', 'Ortega', '1994-10-08', 923456789, NULL, 2),
    (44556673, 'Daniel', 'Méndez', 'Jiménez', '1987-11-22', 934567890, 'daniel.mendez@gmail.com', 1),
    (55667708, 'Paula', 'Ortiz', 'Cruz', '1991-01-30', 945678901, 'paula.ortiz@hotmail.com', 2),
    (66778899, 'Jorge', 'Silva', 'Ramos', '1986-12-20', 956789012, NULL, 1),
    (77889900, 'Lucía', 'Rojas', 'Santos', '1998-08-05', 967890123, 'lucia.rojas@gmail.com', 2),
    (88990011, 'Roberto', 'Herrera', 'Flores', '1985-03-25', 978901234, 'roberto.herrera@hotmail.com', 1),
    (99001022, 'Marta', 'Castro', 'Ramírez', '1997-06-02', 989012345, 'marta.castro@yahoo.com', 2),
    (00112239, 'Francisco', 'Gutiérrez', 'Díaz', '1981-09-27', 990123456, NULL, 1),
    (11223344, 'Andrea', 'Ruiz', 'Ortiz', '1995-05-13', 912345678, 'andrea.ruiz@hotmail.com', 2),
    (22334455, 'Manuel', 'Cano', 'Hidalgo', '1983-02-21', 923456789, 'manuel.cano@yahoo.com', 1),
    (33445596, 'Rocío', 'Núñez', 'Gallego', '1987-12-04', 934567890, 'rocio.nunez@gmail.com', 2),
    (44556677, 'Santiago', 'Moreno', 'Marín', '1993-06-14', 945678901, NULL, 1),
    (55667788, 'Alicia', 'Ramos', 'Garrido', '1989-03-18', 956789012, 'alicia.ramos@yahoo.com', 2),
    (66778890, 'Alberto', 'Pena', 'Pascual', '1996-07-11', 967890123, 'alberto.pena@gmail.com', 1),
    (77889600, 'Patricia', 'Soto', 'Medina', '1984-04-03', 978901234, NULL, 2),
    (88990013, 'Diego', 'García', 'López', '1991-11-23', 989012345, 'diego.garcia@yahoo.com', 1),
    (99001122, 'Silvia', 'Ortega', 'Molina', '1987-08-16', 990123456, 'silvia.ortega@gmail.com', 2),
    (00112233, 'Juan', 'Martínez', 'Suárez', '1996-05-07', 912345678, 'juan.martinez@hotmail.com', 1);
GO

-- Inserción Ruta


INSERT INTO Ruta (Origen, Destino, Horas_Viaje, Paradas)
VALUES 
    ('Lima', 'Cusco', 22, 2),
    ('Cusco', 'Lima', 22, 2),
    ('Arequipa', 'Trujillo', 10, 1),
    ('Trujillo', 'Arequipa', 10, 1),
    ('Piura', 'Iquitos', 4, 0),
    ('Iquitos', 'Piura', 4, 0),
    ('Chiclayo', 'Tacna', 13, 2),
    ('Tacna', 'Chiclayo', 13, 2),
    ('Puno', 'Huaraz', 15, 2),
    ('Huaraz', 'Puno', 15, 2),
    ('Ica', 'Ayacucho', 10, 1),
    ('Ayacucho', 'Ica', 10, 1),
    ('Tarapoto', 'Chimbote', 8, 1),
    ('Chimbote', 'Tarapoto', 8, 1),
    ('Huancayo', 'Juliaca', 10, 2),
    ('Juliaca', 'Huancayo', 10, 2),
    ('Tumbes', 'Puerto Maldonado', 6, 1),
    ('Puerto Maldonado', 'Tumbes', 6, 1),
    ('Moquegua', 'Cajamarca', 14, 2),
    ('Cajamarca', 'Moquegua', 14, 2),
    ('Huaraz', 'Iquitos', 18, 2),
    ('Iquitos', 'Huaraz', 18, 2),
    ('Chiclayo', 'Ica', 11, 1),
    ('Ica', 'Chiclayo', 11, 1);
GO


-- Inserción Tipo_Comprobante

INSERT INTO Tipo_Comprobante (Nombre)
VALUES
('Factura'),
('Boleta de Venta')
GO

-- Inserción Categoria_Buss

INSERT INTO Categoria_Buss (Nombre, Descripcion)
VALUES
('Económico', 'Autobuses con servicios básicos, asientos no reclinables, sin aire acondicionado.'),
('Semi-Cama', 'Autobuses con asientos semi-reclinables, aire acondicionado y servicios básicos.'),
('Cama', 'Autobuses con asientos reclinables, aire acondicionado, entretenimiento a bordo y refrigerios.'),
('VIP', 'Autobuses con asientos totalmente reclinables, aire acondicionado, servicio de catering y entretenimiento premium.'),
('Doble Piso', 'Autobuses de dos niveles, con asientos semi-reclinables y reclinables, aire acondicionado y servicios adicionales.'),
('Turístico', 'Autobuses destinados a tours turísticos, con asientos semi-reclinables, guía turístico y aire acondicionado.'),
('Minibús', 'Autobuses de menor capacidad, con servicios básicos y aire acondicionado.'),
('Ejecutivo', 'Autobuses con asientos reclinables, espacio adicional para las piernas, aire acondicionado y servicio de refrigerios.'),
('Premium', 'Autobuses con lujo extremo, asientos reclinables, aire acondicionado, servicios de catering gourmet y entretenimiento exclusivo.'),
('Express', 'Autobuses con menos paradas, servicios básicos, asientos semi-reclinables y aire acondicionado.');
GO

-- Inserción Bus

INSERT INTO Bus (Placa_Buss, Nombres_Piloto, Apellidos_Piloto, Nombres_Copiloto, Apellidos_Copiloto, Cap_Asientos, Id_Categoria_Bus)
VALUES
('ABC123', 'Carlos', 'García', 'Juan', 'Pérez', 45, 1),
('DEF456', 'Miguel', 'López', 'Pedro', 'Sánchez', 50, 2),
('GHI789', 'José', 'Martínez', 'Luis', 'Ramírez', 40, 3),
('JKL012', 'Ana', 'Torres', 'Marta', 'Hernández', 30, 4),
('MNO345', 'Elena', 'Vásquez', 'Lucía', 'Gómez', 55, 5),
('PQR678', 'Raúl', 'Díaz', 'Fernando', 'Rojas', 60, 6),
('STU901', 'Jorge', 'Castro', 'Emilio', 'Fernández', 35, 7),
('VWX234', 'Sofía', 'Cruz', 'Clara', 'Morales', 40, 8),
('YZA567', 'María', 'Gutiérrez', 'Laura', 'Ortega', 50, 9),
('BCD890', 'Andrés', 'Mendoza', 'Pablo', 'Ramos', 45, 10);
GO

-- Inserción Venta

INSERT INTO Venta (Id_Vendedor, Fecha, Monto, Numero_Asiento, Placa_Buss, Id_Cliente, Id_Ruta, Id_Comprobante)
VALUES 
    -- Ventas para la ruta 1 (Lima - Cusco) en abril
    (3, '2023-04-05', 125.50, 15, 'ABC123', 2, 1, 1),
    (5, '2023-04-05', 125.50, 8, 'ABC123', 4, 1, 2),
    (3, '2023-04-05', 125.50, 20, 'ABC123', 6, 1, 1),
    (5, '2023-04-05', 125.50, 12, 'ABC123', 8, 1, 1),
    (3, '2023-04-05', 125.50, 10, 'ABC123', 10, 1, 2),
    (5, '2023-04-05', 125.50, 18, 'ABC123', 12, 1, 1),
    (3, '2023-04-05', 125.50, 14, 'ABC123', 14, 1, 2),
    (5, '2023-04-05', 125.50, 6, 'ABC123', 16, 1, 1),
    (3, '2023-04-05', 125.50, 22, 'ABC123', 18, 1, 2),
    (5, '2023-04-05', 125.50, 16, 'ABC123', 20, 1, 1),

	-- Ventas para la ruta 2 (Lima - Trujillo) en abril
    (4, '2023-04-08', 110.75, 10, 'GHI789', 3, 2, 1),
    (6, '2023-04-08', 110.75, 8, 'GHI789', 5, 2, 2),
    (4, '2023-04-08', 110.75, 12, 'GHI789', 7, 2, 1),
    (6, '2023-04-08', 110.75, 14, 'GHI789', 9, 2, 2),
    (4, '2023-04-08', 110.75, 16, 'GHI789', 11, 2, 1),
    (6, '2023-04-08', 110.75, 18, 'GHI789', 13, 2, 2),
    (4, '2023-04-08', 110.75, 20, 'GHI789', 15, 2, 1),
    (6, '2023-04-08', 110.75, 22, 'GHI789', 17, 2, 2),
    (4, '2023-04-08', 110.75, 24, 'GHI789', 19, 2, 1),
    (6, '2023-04-08', 110.75, 26, 'GHI789', 21, 2, 2),

    -- Ventas para la ruta 4 (Cusco - Lima) en abril
    (4, '2023-04-10', 140.20, 19, 'ABC123', 1, 4, 1),
    (6, '2023-04-10', 140.20, 11, 'ABC123', 2, 4, 2),
    (4, '2023-04-10', 140.20, 13, 'ABC123', 3, 4, 1),
    (6, '2023-04-10', 140.20, 9, 'ABC123', 5, 4, 2),
    (4, '2023-04-10', 140.20, 21, 'ABC123', 7, 4, 1),
    (6, '2023-04-10', 140.20, 17, 'ABC123', 6, 4, 2),
    (4, '2023-04-10', 140.20, 14, 'ABC123', 4, 4, 1),
    (6, '2023-04-10', 140.20, 7, 'ABC123', 9, 4, 2),
    (4, '2023-04-10', 140.20, 23, 'ABC123', 20, 4, 1),
    (6, '2023-04-10', 140.20, 5, 'ABC123', 26, 4, 2),

	-- Ventas para la ruta 5 (Arequipa - Cusco) en abril
    (3, '2023-04-12', 90.00, 5, 'MNO345', 2, 5, 1),
    (5, '2023-04-12', 90.00, 7, 'MNO345', 4, 5, 2),
    (3, '2023-04-12', 90.00, 9, 'MNO345', 6, 5, 1),
    (5, '2023-04-12', 90.00, 11, 'MNO345', 8, 5, 2),
    (3, '2023-04-12', 90.00, 13, 'MNO345', 10, 5, 1),
    (5, '2023-04-12', 90.00, 15, 'MNO345', 12, 5, 2),
    (3, '2023-04-12', 90.00, 17, 'MNO345', 14, 5, 1),
    (5, '2023-04-12', 90.00, 19, 'MNO345', 16, 5, 2),
    (3, '2023-04-12', 90.00, 21, 'MNO345', 18, 5, 1),
    (5, '2023-04-12', 90.00, 23, 'MNO345', 20, 5, 2),

    -- Ventas para la ruta 7 (Lima - Arequipa) en abril
    (3, '2023-04-15', 65.25, 12, 'JKL012', 2, 7, 1),
    (5, '2023-04-15', 65.25, 8, 'JKL012', 4, 7, 2),
    (3, '2023-04-15', 65.25, 16, 'JKL012', 10, 7, 1),
    (5, '2023-04-15', 65.25, 10, 'JKL012', 12, 7, 2),
    (3, '2023-04-15', 65.25, 18, 'JKL012', 22, 7, 1),
    (5, '2023-04-15', 65.25, 6, 'JKL012', 20, 7, 2),
    (3, '2023-04-15', 65.25, 24, 'JKL012', 10, 7, 1),
    (5, '2023-04-15', 65.25, 13, 'JKL012', 3, 7, 2),
    (3, '2023-04-15', 65.25, 19, 'JKL012', 8, 7, 1),
    (5, '2023-04-15', 65.25, 7, 'JKL012', 13, 7, 2),

	-- Ventas para la ruta 8 (Arequipa - Tacna) en abril
    (4, '2023-04-18', 75.60, 6, 'PQR678', 1, 8, 1),
    (6, '2023-04-18', 75.60, 8, 'PQR678', 3, 8, 2),
    (4, '2023-04-18', 75.60, 10, 'PQR678', 5, 8, 1),
    (6, '2023-04-18', 75.60, 12, 'PQR678', 7, 8, 2),
    (4, '2023-04-18', 75.60, 14, 'PQR678', 9, 8, 1),
    (6, '2023-04-18', 75.60, 16, 'PQR678', 11, 8, 2),
    (4, '2023-04-18', 75.60, 18, 'PQR678', 13, 8, 1),
    (6, '2023-04-18', 75.60, 20, 'PQR678', 15, 8, 2),
    (4, '2023-04-18', 75.60, 22, 'PQR678', 17, 8, 1),
    (6, '2023-04-18', 75.60, 24, 'PQR678', 19, 8, 2);

GO


-- Inserción Detalle_Venta

-- Ventas para la ruta 1 (Lima - Cusco) en abril

INSERT INTO Detalle_Venta (Id_Venta, Precio, Razon_Social, RUC, Tipo_Pago)
VALUES 
    (1, 125.50, 'WAYBUSS', 1234567890, 'Efectivo'),
    (2, 125.50, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (3, 125.50, 'WAYBUSS', 1234567890, 'Efectivo'),
    (4, 125.50, 'WAYBUSS', 1234567890, 'Efectivo'),
    (5, 125.50, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (6, 125.50, 'WAYBUSS', 1234567890, 'Efectivo'),
    (7, 125.50, 'WAYBUSS', 1234567890, 'Efectivo'),
    (8, 125.50, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (9, 125.50, 'WAYBUSS', 1234567890, 'Efectivo'),
    (10, 125.50, 'WAYBUSS', 1234567890, 'Tarjeta');
GO

-- Ventas para la ruta 2 (Lima - Trujillo) en abril
INSERT INTO Detalle_Venta (Id_Venta, Precio, Razon_Social, RUC, Tipo_Pago)
VALUES 
    (11, 110.75, 'WAYBUSS', 1234567890, 'Efectivo'),
    (12, 110.75, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (13, 110.75, 'WAYBUSS', 1234567890, 'Efectivo'),
    (14, 110.75, 'WAYBUSS', 1234567890, 'Efectivo'),
    (15, 110.75, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (16, 110.75, 'WAYBUSS', 1234567890, 'Efectivo'),
    (17, 110.75, 'WAYBUSS', 1234567890, 'Efectivo'),
    (18, 110.75, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (19, 110.75, 'WAYBUSS', 1234567890, 'Efectivo'),
    (20, 110.75, 'WAYBUSS', 1234567890, 'Tarjeta');
GO

-- Ventas para la ruta 4 (Cusco - Lima) en abril
INSERT INTO Detalle_Venta (Id_Venta, Precio, Razon_Social, RUC, Tipo_Pago)
VALUES 
    (21, 140.20, 'WAYBUSS', 1234567890, 'Efectivo'),
    (22, 140.20, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (23, 140.20, 'WAYBUSS', 1234567890, 'Efectivo'),
    (24, 140.20, 'WAYBUSS', 1234567890, 'Efectivo'),
    (25, 140.20, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (26, 140.20, 'WAYBUSS', 1234567890, 'Efectivo'),
    (27, 140.20, 'WAYBUSS', 1234567890, 'Efectivo'),
    (28, 140.20, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (29, 140.20, 'WAYBUSS', 1234567890, 'Efectivo'),
    (30, 140.20, 'WAYBUSS', 1234567890, 'Tarjeta');
GO

-- Ventas para la ruta 5 (Arequipa - Cusco) en abril
INSERT INTO Detalle_Venta (Id_Venta, Precio, Razon_Social, RUC, Tipo_Pago)
VALUES 
    (31, 90.00, 'WAYBUSS', 1234567890, 'Efectivo'),
    (32, 90.00, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (33, 90.00, 'WAYBUSS', 1234567890, 'Efectivo'),
    (34, 90.00, 'WAYBUSS', 1234567890, 'Efectivo'),
    (35, 90.00, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (36, 90.00, 'WAYBUSS', 1234567890, 'Efectivo'),
    (37, 90.00, 'WAYBUSS', 1234567890, 'Efectivo'),
    (38, 90.00, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (39, 90.00, 'WAYBUSS', 1234567890, 'Efectivo'),
    (40, 90.00, 'WAYBUSS', 1234567890, 'Tarjeta');
GO

-- Ventas para la ruta 7 (Lima - Arequipa) en abril
INSERT INTO Detalle_Venta (Id_Venta, Precio, Razon_Social, RUC, Tipo_Pago)
VALUES 
    (41, 65.25, 'WAYBUSS', 1234567890, 'Efectivo'),
    (42, 65.25, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (43, 65.25, 'WAYBUSS', 1234567890, 'Efectivo'),
    (44, 65.25, 'WAYBUSS', 1234567890, 'Efectivo'),
    (45, 65.25, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (46, 65.25, 'WAYBUSS', 1234567890, 'Efectivo'),
    (47, 65.25, 'WAYBUSS', 1234567890, 'Efectivo'),
    (48, 65.25, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (49, 65.25, 'WAYBUSS', 1234567890, 'Efectivo'),
    (50, 65.25, 'WAYBUSS', 1234567890, 'Tarjeta');
GO

-- Ventas para la ruta 8 (Arequipa - Tacna) en abril
INSERT INTO Detalle_Venta (Id_Venta, Precio, Razon_Social, RUC, Tipo_Pago)
VALUES 
    (51, 75.60, 'WAYBUSS', 1234567890, 'Efectivo'),
    (52, 75.60, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (53, 75.60, 'WAYBUSS', 1234567890, 'Efectivo'),
    (54, 75.60, 'WAYBUSS', 1234567890, 'Efectivo'),
    (55, 75.60, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (56, 75.60, 'WAYBUSS', 1234567890, 'Efectivo'),
    (57, 75.60, 'WAYBUSS', 1234567890, 'Efectivo'),
    (58, 75.60, 'WAYBUSS', 1234567890, 'Tarjeta'),
    (59, 75.60, 'WAYBUSS', 1234567890, 'Efectivo'),
    (60, 75.60, 'WAYBUSS', 1234567890, 'Tarjeta');
GO
------------------------------------------------------------------------------
--CONSULTAS

/*N° 1 Ventas totales por tipo de comprobante y mes
Esta consulta muestra la suma total de ventas agrupadas por tipo de comprobante y mes. Es útil para entender cómo varían las ventas a lo largo del año por cada tipo de documento emitido */

SELECT 
    MONTH(v.Fecha) AS Mes,
    YEAR(v.Fecha) AS Año,
    tc.Nombre AS Tipo_Comprobante,
    COUNT(*) AS Cantidad_Ventas,
    SUM(v.Monto) AS Total_Vendido
FROM Venta as v
INNER JOIN Tipo_Comprobante as tc 
ON v.Id_Comprobante = tc.Id_Comprobante
GROUP BY MONTH(v.Fecha), YEAR(v.Fecha), tc.Nombre
ORDER BY Año, Mes, Tipo_Comprobante;


/*N° 2 Rutas con mayor número de ventas
Esta consulta identifica las rutas con el mayor número de ventas registradas, ordenadas de mayor a menor. Es útil para determinar qué rutas son las más populares o más rentables */

SELECT 
    r.Origen,
    r.Destino,
    COUNT(*) AS Numero_Ventas,
    SUM(v.Monto) AS Total_Recaudado
FROM Venta v
INNER JOIN Ruta r ON v.Id_Ruta = r.Id_Ruta
GROUP BY r.Origen, r.Destino
ORDER BY Numero_Ventas DESC;


/*N° 3 Vendedores con mejor desempeño por cantidad de ventas
Esta consulta muestra los vendedores que han realizado más ventas en términos de cantidad de boletos vendidos y total recaudado. Es útil para identificar a los vendedores más productivos */

SELECT 
    ve.Nombre,
    ve.Apellido_Paterno,
    ve.Apellido_Materno,
    COUNT(*) AS Numero_Ventas,
    SUM(v.Monto) AS Total_Recaudado
FROM Venta v
INNER JOIN Vendedor as ve 
ON v.Id_Vendedor = ve.Id_Vendedor
GROUP BY ve.Nombre, ve.Apellido_Paterno, ve.Apellido_Materno
ORDER BY Total_Recaudado DESC;


/*N° 4 Clientes que más han gastado en boletos
Esta consulta muestra los 5 clientes que mas han gastado más dinero en viajar, ordenados de mayor a menor. Es útil para identificar a los clientes más valiosos o frecuentes */

SELECT top(5) 
    cl.Nombre,
    cl.Apellido_P,
    cl.Apellido_M,
    COUNT(*) AS Numero_Compras,
    SUM(v.Monto) AS Total_Gastado
FROM Venta v
INNER JOIN Cliente cl 
ON v.Id_Cliente = cl.Id_Cliente
GROUP BY cl.Nombre, cl.Apellido_P, cl.Apellido_M
ORDER BY Total_Gastado DESC;


SELECT 
    vdr.Id_Vendedor,
    CONCAT(vdr.Nombre, ' ', vdr.Apellido_Paterno, ' ', vdr.Apellido_Materno) AS Nombre_Vendedor,
    AVG(v.Monto) AS Promedio_Ventas
FROM Venta v
JOIN Vendedor vdr ON v.Id_Vendedor = vdr.Id_Vendedor
GROUP BY vdr.Id_Vendedor, vdr.Nombre, vdr.Apellido_Paterno, vdr.Apellido_Materno;



------------------------------------------------------------------------------
-- Funciones

/*N° 1 Función para obtener el promedio de edad de los clientes
Esta función calculará el promedio de edad de todos los clientes */
go
CREATE FUNCTION Obtener_Promedio_Edad_Clientes()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @promedioEdad DECIMAL(10, 2);
    
    SELECT @promedioEdad = AVG(DATEDIFF(YEAR, Fecha_Nacimiento, GETDATE()))
    FROM Cliente;
    
    RETURN ISNULL(@promedioEdad, 0);
END;

go
DECLARE @promedioEdad DECIMAL(10, 2);
SET @promedioEdad = dbo.Obtener_Promedio_Edad_Clientes();
SELECT @promedioEdad AS Promedio_Edad_Clientes;

-----------------------------------------------------------------------------------
/*N° 2 Función para obtener el monto total de ventas por vendedor
Esta función calculará el monto total de ventas realizado por cada vendedor */
go

CREATE FUNCTION Obtener_Monto_Total_Ventas_Por_Vendedor(@idVendedor INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @montoTotal DECIMAL(10, 2);
    
    SELECT @montoTotal = SUM(Monto)
    FROM Venta
    WHERE Id_Vendedor = @idVendedor;
    
    RETURN ISNULL(@montoTotal, 0);
END;

GO

DECLARE @resultado DECIMAL(10, 2);
SET @resultado = dbo.Obtener_Monto_Total_Ventas_Por_Vendedor(5);
SELECT @resultado AS Monto_Total_Ventas;
go
------------------------------------------------------------------------------
-- Procedimientos almacenados

/*N° 1 Procedimiento para obtener el total de ventas por cliente*/
go
CREATE PROCEDURE sp_Total_Ventas_Por_Cliente
AS
BEGIN
    SELECT 
        c.Nombre,
        SUM(v.Monto) AS TotalVentas
    FROM 
        Venta as v
    INNER JOIN 
        Cliente as c
	ON v.Id_Cliente = c.Id_Cliente
    GROUP BY 
        c.Nombre;
END;


EXEC sp_Total_Ventas_Por_Cliente;
go

/*N° 2 Procedimiento para generar un reporte de ventas mensuales */

CREATE PROCEDURE sp_Reporte_Ventas_Mensuales
    @Mes INT,
    @Anio INT
AS
BEGIN
    SELECT 
        MONTH(v.Fecha) AS Mes,
        YEAR(v.Fecha) AS Anio,
        SUM(v.Monto) AS TotalVentas
    FROM 
        Venta v
    WHERE 
        MONTH(v.Fecha) = @Mes
        AND YEAR(v.Fecha) = @Anio
    GROUP BY 
        MONTH(v.Fecha), YEAR(v.Fecha);
END;
go

EXEC sp_Reporte_Ventas_Mensuales @Mes = 4, @Anio = 2023;
go
------------------------------------------------------------------------------
-- Vistas

/*N° 1 Vista Cliente*/

CREATE VIEW Vista_Clientes AS
SELECT Numero_Documento, Nombre, Apellido_P, Apellido_M, Fecha_Nacimiento, Sexo, Numero_Movil, Correo
FROM Cliente
go

SELECT *
FROM Vista_Clientes;
go

/*N° 2 Vista Vendedores*/

CREATE VIEW Vista_Vendedores AS
SELECT Dni, Nombre, Apellido_Paterno, Apellido_Materno, Fecha_Nacimiento, Numero_Movil, Correo, Id_Supervisor
FROM Vendedor
go

SELECT *
FROM Vista_Vendedores;
go

/*N° 3 Vista Rutas*/
CREATE VIEW Vista_Rutas AS
SELECT Id_Ruta, Origen, Destino, Horas_Viaje, Paradas
FROM Ruta;
go

SELECT *
FROM Vista_Rutas;
go


/*N° 4 Vista Buses con su respectiva Categoría*/

CREATE VIEW Vista_Buses AS
SELECT Placa_Buss, Nombres_Piloto, Apellidos_Piloto, Nombres_Copiloto, Apellidos_Copiloto, Cap_Asientos, cb.Nombre AS Categoria
FROM Bus as b
JOIN Categoria_Buss as cb 
ON b.Id_Categoria_Bus = cb.Id_Categoria_Buss;
GO

SELECT *
FROM Vista_Buses;
go
