CREATE TABLE cliente (
codigo_cliente int NOT NULL,
id_telefono_cliente int DEFAULT NULL,
id_direccion_cliente int DEFAULT NULL,
id_ciudad_cliente int DEFAULT NULL,
id_info_cliente int DEFAULT NULL,
limite_credito decimal(15,2) DEFAULT NULL,
codigo_empleado int DEFAULT NULL,
codigo_transaccion int DEFAULT NULL,
PRIMARY KEY (codigo_cliente)
);

CREATE TABLE ciudad_cliente (
    id_ciudad_cliente int NOT NULL,
    codigo_cliente int DEFAULT NULL,
    nombre_ciudad_cliente varchar(50) DEFAULT NULL,
    id_region_cliente int DEFAULT NULL,
    PRIMARY KEY (id_ciudad_cliente)
);

CREATE TABLE pais_cliente (
    id_pais_cliente int NOT NULL,
    nombre_pais_cliente varchar(50) DEFAULT NULL,
    PRIMARY KEY (id_pais_cliente)
);

CREATE TABLE region_cliente (
    id_region_cliente int NOT NULL,
    nombre_region_cliente varchar(50) DEFAULT NULL,
    id_pais_cliente int DEFAULT NULL,
    PRIMARY KEY (id_region_cliente)
);

CREATE TABLE dimensiones_producto (
    id_dimensiones_producto int NOT NULL,
    ancho decimal(8,2) DEFAULT NULL,
    alto decimal(8,2) DEFAULT NULL,
    profundo decimal(8,2) DEFAULT NULL,
    PRIMARY KEY (id_dimensiones_producto)
);

CREATE TABLE pais_oficina (
    id_pais_oficina int NOT NULL,
    nombre_pais_oficina varchar(50) DEFAULT NULL,
    PRIMARY KEY (id_pais_oficina)
);

CREATE TABLE region_oficina (
    id_region_oficina int NOT NULL,
    nombre_region_oficina varchar(50) DEFAULT NULL,
    id_pais_oficina int DEFAULT NULL,
    PRIMARY KEY (id_region_oficina)
);

CREATE TABLE ciudad_oficina (
    id_ciudad_oficina int NOT NULL,
    codigo_oficina int DEFAULT NULL,
    nombre_ciudad_oficina varchar(50) DEFAULT NULL,
    id_region_oficina int DEFAULT NULL,
    PRIMARY KEY (id_ciudad_oficina)
);

CREATE TABLE contacto_empleado (
    id_contacto_empleado int NOT NULL,
    codigo_empleado int DEFAULT NULL,
    apellido2_empleado varchar(50) DEFAULT NULL,
    apellido1_empleado varchar(50) DEFAULT NULL,
    nombre_empleado varchar(50) DEFAULT NULL,
    email_empleado varchar(100) DEFAULT NULL,
    PRIMARY KEY (id_contacto_empleado)
);

CREATE TABLE contacto_oficina (
    id_contacto_oficina int NOT NULL,
    codigo_oficina int DEFAULT NULL,
    codigo_postal_oficina varchar(10) DEFAULT NULL,
    telefono_oficina varchar(20) DEFAULT NULL,
    PRIMARY KEY (id_contacto_oficina)
);

CREATE TABLE detalle_pedido (
    id_detalle_pedido int NOT NULL,
    codigo_pedido int DEFAULT NULL,
    codigo_producto int DEFAULT NULL,
    cantidad int DEFAULT NULL,
    precio_unidad decimal(15,2) DEFAULT NULL,
    numero_linea smallint DEFAULT NULL,
    PRIMARY KEY (id_detalle_pedido)
);

CREATE TABLE direccion_cliente (
    id_direccion_cliente int NOT NULL,
    codigo_cliente int DEFAULT NULL,
    linea_direccion1_cliente varchar(50) DEFAULT NULL,
    linea_direccion2_cliente varchar(50) DEFAULT NULL,
    codigo_postal_cliente varchar(10) DEFAULT NULL,
    PRIMARY KEY (id_direccion_cliente)
);

CREATE TABLE direccion_oficina (
    id_direccion_oficina int NOT NULL,
    codigo_oficina int DEFAULT NULL,
    linea_direccion1_oficina varchar(50) DEFAULT NULL,
    linea_direccion2_oficina varchar(50) DEFAULT NULL,
    PRIMARY KEY (id_direccion_oficina)
);

CREATE TABLE empleado (
    codigo_empleado int NOT NULL,
    id_contacto_empleado int DEFAULT NULL,
    extension varchar(10) DEFAULT NULL,
    codigo_oficina int DEFAULT NULL,
    codigo_jefe int DEFAULT NULL,
    puesto varchar(50) DEFAULT NULL,
    PRIMARY KEY (codigo_empleado)
);

CREATE TABLE gama_producto (
    id_gama_producto int NOT NULL,
    codigo_producto int DEFAULT NULL,
    descripcion_gama_producto text,
    descripcion_gama_producto_html text,
    imagen varchar(256) DEFAULT NULL,
    PRIMARY KEY (id_gama_producto)
);

CREATE TABLE info_cliente (
    id_info_cliente int NOT NULL,
    codigo_cliente int DEFAULT NULL,
    nombre_cliente varchar(50) DEFAULT NULL,
    nombre2_cliente varchar(50) DEFAULT NULL,
    apellido1_cliente varchar(50) DEFAULT NULL,
    apellido2_cliente varchar(50) DEFAULT NULL,
    PRIMARY KEY (id_info_cliente)
);

CREATE TABLE jefe (
    codigo_jefe int NOT NULL,
    codigo_empleado int DEFAULT NULL,
    nombre_jefe varchar(50) DEFAULT NULL,
    apellido1_jefe varchar(50) DEFAULT NULL,
    apellido2_jefe varchar(50) DEFAULT NULL,
    email_jefe varchar(100) DEFAULT NULL,
    puesto_jefe varchar(50) DEFAULT NULL,
    PRIMARY KEY (codigo_jefe)
);

CREATE TABLE oficina (
    codigo_oficina int NOT NULL,
    id_ciudad_oficina int DEFAULT NULL,
    id_contacto_oficina int DEFAULT NULL,
    id_direccion_oficina int DEFAULT NULL,
    PRIMARY KEY (codigo_oficina)
);

CREATE TABLE pago (
    codigo_pago int NOT NULL AUTO_INCREMENT,
    codigo_pedido int DEFAULT NULL,
    codigo_cliente int DEFAULT NULL,
    codigo_empleado int DEFAULT NULL,
    forma_pago varchar(40) DEFAULT NULL,
    codigo_transaccion int DEFAULT NULL,
    fecha_pago date DEFAULT NULL,
    total_pago decimal(15,2) DEFAULT NULL,
    PRIMARY KEY (codigo_pago)
);

CREATE TABLE pedido (
    codigo_pedido int NOT NULL,
    codigo_producto int DEFAULT NULL,
    fecha_pedido date DEFAULT NULL,
    fecha_esperada date DEFAULT NULL,
    fecha_entrega date DEFAULT NULL,
    estado_pedido enum('en proceso','finalizado','no permitido') DEFAULT 'en proceso',
    comentarios_pedido text,
    codigo_cliente int DEFAULT NULL,
    PRIMARY KEY (codigo_pedido)
);



CREATE TABLE producto (
    codigo_producto int NOT NULL,
    nombre_producto varchar(70) DEFAULT NULL,
    id_gama_producto int DEFAULT NULL,
    id_dimensiones_producto int DEFAULT NULL,
    id_proveedor int DEFAULT NULL,
    descripcion text,
    cantidad_stock smallint DEFAULT NULL,
    precio_venta decimal(15,2) DEFAULT NULL,
    precio_proveedor decimal(15,2) DEFAULT NULL,
    PRIMARY KEY (codigo_producto)
);

CREATE TABLE proveedor_producto (
    id_proveedor int NOT NULL,
    codigo_producto int DEFAULT NULL,
    PRIMARY KEY (id_proveedor)
);

CREATE TABLE telefono_cliente (
  id_telefono_cliente int NOT NULL,
  codigo_cliente int DEFAULT NULL,
  telefono_fijo_cliente varchar(15) DEFAULT NULL,
  telefono_personal_cliente varchar(15) DEFAULT NULL,
  fax varchar(15) DEFAULT NULL,
  PRIMARY KEY (id_telefono_cliente)
);

CREATE TABLE transaccion(
  codigo_transaccion int NOT NULL,
  codigo_cliente int DEFAULT NULL,
  fecha_transaccion date DEFAULT NULL,
  cantidad_transaccion decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (codigo_transaccion)
);

INSERCIONES

INSERT INTO
    pais_cliente (id_pais_cliente,nombre_pais_cliente)
VALUES (493, 'México'),
    (249, 'Estados Unidos'),
    (149, 'Canadá'),
    (245, 'España'),
    (276, 'Alemania'),
    (275, 'Francia'),
    (386, 'Italia'),
    (245, 'España'),
    (156, 'China'),
    (076, 'Brasil');



INSERT INTO telefono_cliente (id_telefono_cliente, codigo_cliente, telefono_fijo_cliente, telefono_personal_cliente, fax)
VALUES 
    (1, 1, '123456789', '987654321', '123123123'),
    (2, 2, '987654321', '888777666', NULL),
    (3, 3, '555555555', NULL, NULL),
    (4, 4, '111111111', '222222222', '333333333'),
    (5, 5, '333333333', NULL, '444444444'),
    (6, 6, '666666666', '777777777', '888888888'),
    (7, 7, '777777777', '888888888', NULL),
    (8, 8, '999999999', NULL, '111222333'),
    (9, 9, '000000000', NULL, '555666777'),
    (10, 10, '444444444', NULL, NULL);

INSERT INTO transaccion (codigo_transaccion, codigo_cliente, fecha_transaccion, cantidad_transaccion)
VALUES 
    (1, 1, '2024-05-10', 1500.50),
    (2, 2, '2024-05-09', 800.00),
    (3, 3, '2024-05-08', 1250.75),
    (4, 4, '2024-05-07', 975.25),
    (5, 5, '2024-05-06', 2000.00),
    (6, 6, '2024-05-05', 350.00),
    (7, 7, '2024-05-04', 620.30),
    (8, 8, '2024-05-03', 1050.80),
    (9, 9, '2024-05-02', 450.75),
    (10, 10, '2024-05-01', 975.25);

INSERT INTO direccion_cliente (id_direccion_cliente, codigo_cliente, linea_direccion1_cliente, linea_direccion2_cliente, codigo_postal_cliente)
VALUES 
    (1, 1, 'Calle Principal 123', 'Col. Centro', '12345'),
    (2, 2, 'Avenida Independencia 456', NULL, '54321'),
    (3, 3, 'Boulevard Revolución 789', 'Col. Moderna', '67890'),
    (4, 4, 'Calle Juárez 101', 'Col. Norte', '13579'),
    (5, 5, 'Avenida Reforma 987', NULL, '97531'),
    (6, 6, 'Paseo de la Reforma 246', NULL, '36912'),
    (7, 7, 'Calle Morelos 753', 'Col. Sur', '24680'),
    (8, 8, 'Avenida Insurgentes 852', NULL, '80246'),
    (9, 9, 'Boulevard Miguel de Cervantes 159', 'Col. Este', '95135'),
    (10, 10, 'Calle Zaragoza 357', NULL, '35791');

INSERT INTO info_cliente (id_info_cliente,codigo_cliente,nombre_cliente,nombre2_cliente,apellido1_cliente,apellido2_cliente)
VALUES 
    (1, 1, 'Juan', 'Carlos', 'Gómez', 'Hernández'),
    (2, 2, 'María', 'Elena', 'Martínez', 'Sánchez'),
    (3, 3, 'Pedro', 'Luis', 'Ramírez', 'González'),
    (4, 4, 'Ana', 'Sofía', 'Díaz', 'Pérez'),
    (5, 5, 'Sara', 'Alejandra', 'Torres', 'García'),
    (6, 6, 'Pablo', 'Javier', 'Fernández', 'López'),
    (7, 7, 'Luis', 'Fernando', 'Vázquez', 'Gómez'),
    (8, 8, 'Carla', 'Lucía', 'Ruiz', 'Santos'),
    (9, 9, 'Jorge', 'Emilio', 'Hernández', 'Gutiérrez'),
    (10, 10, 'Rosa', 'María', 'Gómez', 'Martínez');

INSERT INTO empleado (codigo_empleado, id_contacto_empleado, extension, codigo_oficina, codigo_jefe, puesto)
VALUES 
    (1, 1, '123', 1, NULL, 'Gerente'),
    (2, 2, '456', 1, 1, 'Analista'),
    (3, 3, '789', 2, 1, 'Asistente'),
    (4, 4, '012', 2, 2, 'Representante de ventas'),
    (5, 5, '345', 3, 2, 'Asistente'),
    (6, 6, '678', 3, 3, 'Administrador'),
    (7, 7, '901', 4, 3, 'Representante de ventas'),
    (8, 8, '234', 4, 4, 'Representante de ventas'),
    (9, 9, '567', 5, 4, 'Desarrollador'),
    (10, 10, '890', 5, 5, 'Asistente');

INSERT INTO ciudad_cliente (id_ciudad_cliente, codigo_cliente, nombre_ciudad_cliente, id_region_cliente)
VALUES 
    (31, 1, 'Yucatán', 8),
    (653, 2, 'Sedalia', 660),
    (15, 3, 'Downtown', 780),
    (23, 4, 'Jaén', 1),
    (821, 5, 'Augsberg', 496),
    (161, 6, 'Cognac', 16),
    (332, 7, 'Varese', 7),
    (27, 8, 'Lugo', 12),
    (310, 9, 'Xihu District', 571),
    (55, 10, 'Brasilia', 10);
    
    
INSERT INTO cliente (codigo_cliente, id_telefono_cliente, id_direccion_cliente, id_ciudad_cliente, id_info_cliente, limite_credito, codigo_empleado)
VALUES 
    (1, 1, 1, 31, 1, 2000.00, 1),
    (2, 2, 2, 653, 2, 1500.00, 2),
    (3, 3, 3, 15, 3, 1900.00, 3),
    (4, 4, 4, 23, 4, 2500.00, 4),
    (5, 5, 5, 821, 5, 1800.00, 5),
    (6, 6, 6, 161, 6, 3200.00, 6),
    (7, 7, 7, 332, 7, 2700.00, 7),
    (8, 8, 8, 27, 8, 1900.00, 8),
    (9, 9, 9, 310, 9, 2800.00, 9),
    (10, 10, 55, 10, 10, 3500.00, 10);

INSERT INTO ciudad_oficina (id_ciudad_oficina, codigo_oficina, nombre_ciudad_oficina, id_region_oficina)
VALUES 
    (1, 1, 'Ciudad de México', 1),
    (2, 2, 'New york', 2),
    (3, 3, 'Toronto', 3),
    (4, 4, 'Sevilla', 4),
    (5, 5, 'Colonia', 5),
    (6, 6, 'Lyon', 6),
    (7, 7, 'Pisa', 7),
    (8, 8, 'Kioto', 8),
    (9, 9, 'Pekin', 9),
    (10, 10, 'Recife', 10);

INSERT INTO producto (codigo_producto,nombre_producto,id_gama_producto,id_dimensiones_producto,id_proveedor,descripcion,cantidad_stock,precio_venta,precio_proveedor)
VALUES 
    (1, 'Producto A', 1, 1, 1, 'Descripción del producto A', 100, 15.00, 10.00),
    (2, 'Producto B', 2, 2, 2, 'Descripción del producto B', 50, 30.00, 20.00),
    (3, 'Producto C', 1, 3, 3, 'Descripción del producto C', 75, 20.00, 15.00),
    (4, 'Producto D', 2, 1, 4, 'Descripción del producto D', 30, 40.00, 25.00),
    (5, 'Producto E', 3, 2, 5, 'Descripción del producto E', 20, 10.00, 8.00),
    (6, 'Producto F', 1, 3, 6, 'Descripción del producto F', 40, 50.00, 35.00),
    (7, 'Producto G', 2, 1, 7, 'Descripción del producto G', 60, 25.00, 18.00),
    (8, 'Producto H', 3, 2, 8, 'Descripción del producto H', 90, 12.50, 10.00),
    (9, 'Producto I', 1, 3, 9, 'Descripción del producto I', 55, 18.75, 15.00),
    (10, 'Producto J', 2, 1, 10, 'Descripción del producto J', 70, 40.00, 30.00);
    
INSERT INTO pedido (codigo_pedido,codigo_producto,fecha_pedido,fecha_esperada,fecha_entrega,estado_pedido,comentarios_pedido,codigo_cliente)
VALUES 
    (1, 1, '2024-04-01', '2024-04-10', '2024-04-11', 'finalizado', 'Entrega puntual', 1),
    (2, 2, '2024-04-02', '2024-04-11', '2024-04-12', 'finalizado', 'Productos en buen estado', 2),
    (3, 3, '2024-04-03', '2024-04-12', '2024-04-13', 'en proceso', 'Esperando confirmación de pago', 3),
    (4, 4, '2024-04-04', '2024-04-13', NULL, 'en proceso', NULL, 4),
    (5, 5, '2024-04-05', '2024-04-14', NULL, 'no permitido', 'Cliente no autorizado', 5),
    (6, 6, '2024-04-06', '2024-04-15', NULL, 'en proceso', 'Esperando confirmación de stock', 6),
    (7, 7, '2024-04-07', '2024-04-16', NULL, 'en proceso', 'Pedido urgente', 7),
    (8, 8, '2024-04-08', '2024-04-17', NULL, 'en proceso', 'Esperando confirmación de transporte', 8),
    (9, 9, '2024-04-09', '2024-04-18', NULL, 'no permitido', 'Productos pendientes de fabricación', 9),
    (10, 10, '2024-04-10', '2024-04-19', NULL, 'en proceso', NULL, 10);

INSERT INTO detalle_pedido (codigo_pedido,codigo_producto,cantidad,precio_unidad,numero_linea)
VALUES 
    (1, 1, 5, 10.50, 1),
    (1, 2, 3, 25.75, 2),
    (2, 3, 2, 15.00, 1),
    (2, 4, 1, 30.00, 2),
    (3, 5, 4, 8.99, 2),
    (4, 6, 1, 50.00, 1),
    (5, 7, 3, 20.00, 7),
    (6, 8, 2, 12.50, 1),
    (7, 9, 5, 18.75, 5),
    (8, 10, 1, 40.00, 14);

INSERT INTO pago (codigo_pago,codigo_cliente,forma_pago,codigo_transaccion,fecha_pago,total_pago)
VALUES 
    (1, 1, 'Tarjeta de crédito', 123, '2024-04-15', 150.00),
    (2, 2, 'Transferencia bancaria', 789, '2024-04-16', 200.00),
    (3, 3, 'Efectivo', 456, '2024-04-17', 100.00),
    (4, 4, 'Cheque', 789, '2024-04-18', 180.00),
    (5, 5, 'PayPal', 012, '2024-04-19', 220.00),
    (6, 6, 'Transferencia bancaria', 345, '2024-04-20', 130.00),
    (7, 7, 'Efectivo', 678, '2024-04-21', 190.00),
    (8, 8, 'Tarjeta de débito', 901, '2024-04-22', 210.00),
    (9, 9, 'Cheque', 234, '2024-04-23', 170.00),
    (10, 10, 'PayPal', 567, '2024-04-24', 240.00);

INSERT INTO transaccion (codigo_transaccion,codigo_cliente,fecha_transaccion,cantidad_transaccion)
VALUES 
    (123, 1, '2024-04-15', 150.00),
    (789, 2, '2024-04-16', 200.00),
    (456, 3, '2024-04-17', 100.00),
    (789, 4, '2024-04-18', 180.00),
    (012, 5, '2024-04-19', 220.00),
    (345, 6, '2024-04-20', 130.00),
    (678, 7, '2024-04-21', 190.00),
    (901, 8, '2024-04-22', 210.00),
    (234, 9, '2024-04-23', 170.00),
    (567, 10, '2024-04-24', 240.00);

INSERT INTO contacto_empleado (id_contacto_empleado,codigo_empleado,apellido2_empleado,apellido1_empleado,nombre_empleado,email_empleado)
VALUES 
    (1, 1, 'Gómez', 'Hernández', 'Juan', 'juan@example.com'),
    (2, 2, 'Martínez', 'Sánchez', 'María Elena', 'maria@example.com'),
    (3, 3, 'Ramírez', 'González', 'Pedro Luis', 'pedro@example.com'),
    (4, 4, 'Díaz', 'Pérez', 'Ana Sofía', 'ana@example.com'),
    (5, 5, 'Torres', 'García', 'Sara Alejandra', 'sara@example.com'),
    (6, 6, 'Fernández', 'López', 'Pablo Javier', 'pablo@example.com'),
    (7, 7, 'Vázquez', 'Gómez', 'Luis Fernando', 'luis@example.com'),
    (8, 8, 'Ruiz', 'Santos', 'Carla Lucía', 'carla@example.com'),
    (9, 9, 'Hernández', 'Gutiérrez', 'Jorge Emilio', 'jorge@example.com'),
    (10, 10, 'Gómez', 'Martínez', 'Rosa María', 'rosa@example.com');
    
INSERT INTO jefe (codigo_jefe,codigo_empleado,nombre_jefe,apellido1_jefe,apellido2_jefe,email_jefe,puesto_jefe)
VALUES 
    (1, 1, 'Gerardo', 'Hernández', 'Gómez', 'gerardo@example.com', 'CEO'),
    (2, 2, 'Roberto', 'Fernández', 'Sánchez', 'roberto@example.com', 'Gerente de Área'),
    (3, 3, 'Eduardo', 'López', 'Martínez', 'eduardo@example.com', 'Gerente de Ventas'),
    (4, 4, 'Alejandro', 'Pérez', 'Gómez', 'alejandro@example.com', 'Gerente de Marketing'),
    (5, 5, 'María', 'González', 'López', 'maria@example.com', 'Gerente de Finanzas'),
    (6, 6, 'Laura', 'Martínez', 'Sánchez', 'laura@example.com', 'Gerente de Recursos Humanos'),
    (7, 7, 'Pedro', 'Gómez', 'García', 'pedro@example.com', 'Gerente de Producción'),
    (8, 8, 'Carlos', 'López', 'Pérez', 'carlos@example.com', 'Gerente de Logística'),
    (9, 9, 'Ana', 'Sánchez', 'Gómez', 'ana@example.com', 'Gerente de Calidad'),
    (10, 10, 'Sergio', 'García', 'Martínez', 'sergio@example.com', 'Gerente de Tecnología');

INSERT INTO oficina (codigo_oficina,id_ciudad_oficina,id_contacto_oficina,id_direccion_oficina)
VALUES 
    (1, 1, 1, 1),
    (2, 2, 2, 2),
    (3, 3, 3, 3),
    (4, 4, 4, 4),
    (5, 5, 5, 5),
    (6, 6, 6, 6),
    (7, 7, 7, 7),
    (8, 8, 8, 8),
    (9, 9, 9, 9),
    (10, 10, 10, 10);
  
INSERT INTO contacto_oficina (id_contacto_oficina,codigo_oficina,codigo_postal_oficina,telefono_oficina)
VALUES 
    (1, 1, '12345', '555-123-456'),
    (2, 2, '54321', '555-987-654'),
    (3, 3, '67890', '555-321-987'),
    (4, 4, '24680', '555-456-789'),
    (5, 5, '80246', '555-789-123'),
    (6, 6, '95135', '555-369-258'),
    (7, 7, '35791', '555-147-258'),
    (8, 8, '46803', '555-258-147'),
    (9, 9, '36925', '555-369-147'),
    (10, 10, '58201', '555-123-369');

INSERT INTO direccion_oficina (id_direccion_oficina,codigo_oficina,linea_direccion1_oficina,linea_direccion2_oficina)
VALUES 
    (1, 1, 'Av. Insurgentes Sur 123', 'Col. Juárez'),
    (2, 2, 'Av. Constitución 456', 'Col. Centro'),
    (3, 3, 'Av. Revolución 789', 'Col. Moderna'),
    (4, 4, 'Av. Juárez 101', 'Col. Norte'),
    (5, 5, 'Av. Reforma 987', 'Col. Centro'),
    (6, 6, 'Av. de la Independencia 246', 'Col. Centro'),
    (7, 7, 'Av. 20 de Noviembre 753', 'Col. Sur'),
    (8, 8, 'Av. Hidalgo 852', 'Col. Centro'),
    (9, 9, 'Av. Miguel Hidalgo y Costilla 159', 'Col. Este'),
    (10, 10, 'Av. Constituyentes 357', 'Col. Centro');

INSERT INTO pais_oficina (id_pais_oficina,nombre_pais_oficina)
VALUES 
    (1, 'México'),
    (840, 'Estados Unidos'),
    (124, 'Canadá'),
    (724, 'España'),
    (276, 'Alemania'),
    (250, 'Francia'),
    (7, 'Italia'),
    (8, 'Lyón'),
    (156, 'China'),
    (76, 'Brasil');

INSERT INTO region_oficina (id_region_oficina,nombre_region_oficina,id_pais_oficina)
VALUES 
    (1, 'Centro', 1),
    (2, 'Norte', 840),
    (3, 'Sur', 124),
    (4, 'Este', 724),
    (5, 'Oeste', 276),
    (6, 'Noroeste', 250),
    (7, 'Sureste', 7),
    (8, 'Suroeste', 8),
    (9, 'Noreste', 156),
    (10, 'Centro', 76);

INSERT INTO dimensiones_producto (id_dimensiones_producto,ancho,alto,profundo)
VALUES 
    (1, 10.0, 20.0, 5.0),
    (2, 15.0, 25.0, 7.5),
    (3, 12.5, 22.0, 6.0);

INSERT INTO gama_producto (id_gama_producto,codigo_producto,descripcion_gama_producto,descripcion_gama_producto_html,imagen)
VALUES 
    (1, 1, 'Gama 1', 'Descripción de la Gama 1', 'imagen1.jpg'),
    (2, 2, 'Gama 2', 'Descripción de la Gama 2', 'imagen2.jpg'),
    (3, 3, 'Gama 3', 'Descripción de la Gama 3', 'imagen3.jpg');

INSERT INTO proveedor_producto (id_proveedor, codigo_producto)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);
    
INSERT INTO region_cliente (id_region_cliente,nombre_region_cliente,id_pais_cliente)
VALUES (08, 'Merida', 493),
    (660, 'Misuri', 249),
    (780, 'Edmonton', 149),
    (01, 'Andalucía', 245),
    (496, 'Suabia', 276),
    (16, 'Charente', 275),
    (7, 'Lombardia', 386),
    (12, 'Galicia', 245),
    (571, 'Hangzhou', 156),
    (10, 'Centro', 076);


ALTER TABLE cliente
ADD CONSTRAINT fk_cliente_telefono FOREIGN KEY (id_telefono_cliente) REFERENCES telefono_cliente(id_telefono_cliente),
ADD CONSTRAINT fk_cliente_direccion FOREIGN KEY (id_direccion_cliente) REFERENCES direccion_cliente(id_direccion_cliente),
ADD CONSTRAINT fk_cliente_ciudad FOREIGN KEY (id_ciudad_cliente) REFERENCES ciudad_cliente(id_ciudad_cliente),
ADD CONSTRAINT fk_cliente_info FOREIGN KEY (id_info_cliente) REFERENCES info_cliente(id_info_cliente),
ADD CONSTRAINT fk_cliente_empleado FOREIGN KEY (codigo_empleado) REFERENCES empleado(codigo_empleado);

ALTER TABLE ciudad_cliente
ADD CONSTRAINT fk_ciudad_cliente_region FOREIGN KEY (id_region_cliente) REFERENCES region_cliente(id_region_cliente);

ALTER TABLE region_cliente
ADD CONSTRAINT fk_region_cliente_pais FOREIGN KEY (id_pais_cliente) REFERENCES pais_cliente(id_pais_cliente);


ALTER TABLE region_oficina
ADD CONSTRAINT fk_region_oficina_pais FOREIGN KEY (id_pais_oficina) REFERENCES pais_oficina(id_pais_oficina);


ALTER TABLE ciudad_oficina
ADD CONSTRAINT fk_ciudad_oficina_region FOREIGN KEY (id_region_oficina) REFERENCES region_oficina(id_region_oficina);


ALTER TABLE contacto_empleado
ADD CONSTRAINT fk_contacto_empleado_empleado FOREIGN KEY (codigo_empleado) REFERENCES empleado(codigo_empleado);

ALTER TABLE contacto_oficina
ADD CONSTRAINT fk_contacto_oficina_oficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina);


ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo_pedido),
ADD CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto);

ALTER TABLE direccion_cliente
ADD CONSTRAINT fk_direccion_cliente_cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente);

ALTER TABLE direccion_oficina
ADD CONSTRAINT fk_direccion_oficina_oficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina);

ALTER TABLE empleado
ADD CONSTRAINT fk_empleado_contacto FOREIGN KEY (id_contacto_empleado) REFERENCES contacto_empleado(id_contacto_empleado),
ADD CONSTRAINT fk_empleado_oficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina),
ADD CONSTRAINT fk_empleado_jefe FOREIGN KEY (codigo_jefe) REFERENCES jefe(codigo_jefe);

ALTER TABLE gama_producto
ADD CONSTRAINT fk_gama_producto_producto FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto);


ALTER TABLE info_cliente
ADD CONSTRAINT fk_info_cliente_cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente);


ALTER TABLE jefe
ADD CONSTRAINT fk_jefe_empleado FOREIGN KEY (codigo_empleado) REFERENCES empleado(codigo_empleado);

ALTER TABLE oficina
ADD CONSTRAINT fk_oficina_ciudad FOREIGN KEY (id_ciudad_oficina) REFERENCES ciudad_oficina(id_ciudad_oficina),
ADD CONSTRAINT fk_oficina_contacto FOREIGN KEY (id_contacto_oficina) REFERENCES contacto_oficina(id_contacto_oficina),
ADD CONSTRAINT fk_oficina_direccion FOREIGN KEY (id_direccion_oficina) REFERENCES direccion_oficina(id_direccion_oficina);

ALTER TABLE pago
ADD CONSTRAINT fk_pago_pedido FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo_pedido),
ADD CONSTRAINT fk_pago_cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente),
ADD CONSTRAINT fk_pago_empleado FOREIGN KEY (codigo_empleado) REFERENCES empleado(codigo_empleado),
ADD CONSTRAINT fk_pago_transaccion FOREIGN KEY (codigo_transaccion) REFERENCES transaccion(codigo_transaccion);


ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente);


ALTER TABLE producto
ADD CONSTRAINT fk_producto_gama FOREIGN KEY (id_gama_producto) REFERENCES gama_producto(id_gama_producto),
ADD CONSTRAINT fk_producto_dimensiones FOREIGN KEY (id_dimensiones_producto) REFERENCES dimensiones_producto(id_dimensiones_producto),
ADD CONSTRAINT fk_producto_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedor_producto(id_proveedor);


ALTER TABLE telefono_cliente
ADD CONSTRAINT fk_telefono_cliente_cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente);

ALTER TABLE transaccion
ADD CONSTRAINT fk_transaccion_cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente);
