CREATE TABLE contacto_cliente (
  id_contacto_cliente INT(11) PRIMARY KEY AUTO_INCREMENT,
  codigo_cliente INT(11),
  nombre_contacto_cliente VARCHAR(30),
  apellido_contacto_cliente VARCHAR(30)
);

CREATE TABLE telefono_cliente (
  id_telefono_cliente INT(11) PRIMARY KEY AUTO_INCREMENT,
  codigo_cliente INT(11),
  telefono_fijo_cliente VARCHAR(15),
  telefono_personal_cliente VARCHAR(15),
  fax VARCHAR(15)
);
    
CREATE TABLE direccion_cliente (
  id_direccion_cliente INT(11) PRIMARY KEY AUTO_INCREMENT,
  codigo_cliente INT(11),
  linea_direccion1_cliente VARCHAR(50),
  linea_direccion2_cliente VARCHAR(50),
  codigo_postal_cliente VARCHAR(10)
);
    
CREATE TABLE ciudad_cliente (
    id_ciudad_cliente INT PRIMARY KEY,
    codigo_cliente INT,
    nombre_ciudad_cliente VARCHAR(255),
    id_region_cliente INT
);

CREATE TABLE region_cliente (
    id_region_cliente INT PRIMARY KEY,
    nombre_region_cliente VARCHAR(255),
    id_pais_cliente INT
);


CREATE TABLE pais_cliente (
  id_pais_cliente INT(11),
  codigo_cliente INT(11),
  nombre_pais_cliente VARCHAR(50)
);

CREATE TABLE info_cliente (
  id_info_cliente INT(11) PRIMARY KEY AUTO_INCREMENT,
  codigo_cliente INT(11),
  nombre_cliente VARCHAR(50),
  nombre2_cliente VARCHAR(50),
  apellido1_cliente VARCHAR(50),
  apellido2_cliente VARCHAR(50)
);
    
CREATE TABLE cliente (
  codigo_cliente INT(11) PRIMARY KEY AUTO_INCREMENT,
  id_contacto_cliente INT(11),
  id_telefono_cliente INT(11),
  id_direccion_cliente INT(11),
  id_ciudad_cliente INT(11),
  id_info_cliente INT(11),
  limite_credito DECIMAL(15,2),
  codigo_empleado_repventas INT(11)
);

CREATE TABLE pago (
  codigo_pago INT(11) PRIMARY KEY AUTO_INCREMENT,
  codigo_pedido INT(11),
  codigo_cliente INT(11),
  codigo_empleado INT(11),
  forma_pago VARCHAR(40),
  codigo_transaccion VARCHAR(50),
  fecha_pago DATE,
  total_pago DECIMAL(15,2)
);
CREATE TABLE empleado(
  codigo_empleado INT(11) PRIMARY KEY AUTO_INCREMENT,
  id_contacto_empleado INT(11),
  extension VARCHAR(10),
  codigo_oficina INT(11),
  codigo_jefe INT(11),
  puesto VARCHAR(50)
);

CREATE TABLE pedido(
  codigo_pedido INT(11) PRIMARY KEY AUTO_INCREMENT,
  codigo_producto INT(11),
  fecha_pedido DATE,
  fecha_esperada DATE,
  fecha_entrega DATE,
  estado_pedido ENUM ('en proceso','finalizado','no permitido') DEFAULT 'en proceso',
  comentarios_pedido TEXT,
  codigo_cliente INT(11)
  );
CREATE TABLE detalle_pedido(
  codigo_pedido INT(11),
  codigo_producto INT(11),
  cantidad INT(11),
  precio_unidad DECIMAL(15,2),
  numero_linea SMALLINT(6)
  );
CREATE TABLE producto(
  codigo_producto INT(11)  PRIMARY KEY AUTO_INCREMENT,
  nombre_producto VARCHAR(70),
  id_gama_producto INT(11),
  id_dimensiones_producto INT(11),
  id_proveedor INT(11),
  descripcion TEXT,
  cantidad_stock SMALLINT(6),
  precio_venta DECIMAL (15,2),
  precio_proveedor DECIMAL (15,2)
  );
CREATE TABLE dimensiones_producto(
  id_dimensiones_producto INT(11) PRIMARY KEY,
  ancho DECIMAL (8,2),
  alto DECIMAL (8,2),
  profundo DECIMAL (8,2)
  );
CREATE TABLE gama_producto(
  id_gama_producto INT(11) PRIMARY KEY,
  codigo_producto INT(11),
  descripcion_gama_producto TEXT,
  descripcion_gama_producto_html TEXT,
  imagen VARCHAR(256)
  );
CREATE TABLE proveedor_producto(
  id_proveedor INT(11) PRIMARY KEY,
  codigo_producto INT(11)
  );

CREATE TABLE transaccion (
  codigo_transaccion INT(11),
  codigo_cliente INT(11),
  fecha_transaccion DATE,
  cantidad_transaccion DECIMAL(15,2)
);

CREATE TABLE contacto_empleado(
  id_contacto_empleado INT(11) PRIMARY KEY,
  codigo_empleado INT(11),
  apellido2_empleado VARCHAR(50),
  apellido1_empleado VARCHAR(50),
  nombre_empleado VARCHAR(50),
  email_empleado VARCHAR(100)
);
CREATE TABLE jefe(
  codigo_jefe INT(11) PRIMARY KEY,
  codigo_empleado INT(11),
  nombre_jefe VARCHAR(50),
  apellido1_jefe VARCHAR(50),
  apellido2_jefe VARCHAR(50),
  email_jefe VARCHAR(100),
  puesto_jefe VARCHAR(50)
);
CREATE TABLE oficina(
  codigo_oficina INT(11) PRIMARY KEY,
  id_ciudad_oficina INT(11),
  id_contacto_oficina INT(11),
  id_direccion_oficina INT(11)
  );
CREATE TABLE contacto_oficina(
  id_contacto_oficina INT(11) PRIMARY KEY,
  codigo_oficina INT(11),
  codigo_postal_oficina VARCHAR(10),
  telefono_oficina VARCHAR(20)
  );
CREATE TABLE direccion_oficina(
  id_direccion_oficina INT(11) PRIMARY KEY, 
  codigo_oficina INT(11),
  linea_direccion1_oficina VARCHAR(50),
  linea_direccion2_oficina VARCHAR(50)
  );
CREATE TABLE ciudad_oficina(
  id_ciudad_oficina INT(11) PRIMARY KEY,
  codigo_oficina INT (11),
  nombre_ciudad_oficina VARCHAR(50),
  id_region_oficina INT(11)
  );
CREATE TABLE pais_oficina(
  id_pais_oficina INT(11) PRIMARY KEY ,
  nombre_pais_oficina VARCHAR(50)
  );
CREATE TABLE region_oficina(
  id_region_oficina INT(11) PRIMARY KEY,
  nombre_region_oficina VARCHAR(50),
  id_pais_oficina INT(11)
  );


ALTER TABLE cliente
ADD CONSTRAINT fk_contacto_cliente
FOREIGN KEY (id_contacto_cliente) REFERENCES contacto_cliente(id_contacto_cliente),
ADD CONSTRAINT fk_telefono_cliente
FOREIGN KEY (id_telefono_cliente) REFERENCES telefono_cliente(id_telefono_cliente),
ADD CONSTRAINT fk_direccion_cliente
FOREIGN KEY (id_direccion_cliente) REFERENCES direccion_cliente(id_direccion_cliente),
ADD CONSTRAINT fk_ciudad_cliente
FOREIGN KEY (id_ciudad_cliente) REFERENCES ciudad_cliente(id_ciudad_cliente),
ADD CONSTRAINT fk_info_cliente
FOREIGN KEY (id_info_cliente) REFERENCES info_cliente(id_info_cliente),
ADD CONSTRAINT fk_empleado_repventas
FOREIGN KEY (codigo_empleado_repventas) REFERENCES empleado(codigo_empleado);

ALTER TABLE pago
ADD CONSTRAINT fk_pago_pedido
FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo_pedido),
ADD CONSTRAINT fk_pago_cliente
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente),
ADD CONSTRAINT fk_pago_empleado
FOREIGN KEY (codigo_empleado) REFERENCES empleado(codigo_empleado);

ALTER TABLE empleado
ADD CONSTRAINT fk_contacto_empleado
FOREIGN KEY (id_contacto_empleado) REFERENCES contacto_empleado(id_contacto_empleado),
ADD CONSTRAINT fk_oficina_empleado
FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina),
ADD CONSTRAINT fk_jefe_empleado
FOREIGN KEY (codigo_jefe) REFERENCES jefe(codigo_jefe);

ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente),
ADD CONSTRAINT fk_pedido_producto
FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto);

ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_pedido
FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo_pedido),
ADD CONSTRAINT fk_detalle_pedido_producto
FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto);

ALTER TABLE producto
ADD CONSTRAINT fk_gama_producto
FOREIGN KEY (id_gama_producto) REFERENCES gama_producto(id_gama_producto),
ADD CONSTRAINT fk_dimensiones_producto
FOREIGN KEY (id_dimensiones_producto) REFERENCES dimensiones_producto(id_dimensiones_producto),
ADD CONSTRAINT fk_proveedor_producto
FOREIGN KEY (id_proveedor) REFERENCES proveedor_producto(id_proveedor);

ALTER TABLE contacto_oficina
ADD CONSTRAINT fk_contacto_oficina_oficina
FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina);

ALTER TABLE direccion_oficina
ADD CONSTRAINT fk_direccion_oficina_oficina
FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina);

ALTER TABLE ciudad_oficina
ADD CONSTRAINT fk_ciudad_oficina_oficina
FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina),
ADD CONSTRAINT fk_ciudad_oficina_region
FOREIGN KEY (id_region_oficina) REFERENCES region_oficina(id_region_oficina);

ALTER TABLE region_oficina
ADD CONSTRAINT fk_region_oficina_pais
FOREIGN KEY (id_pais_oficina) REFERENCES pais_oficina(id_pais_oficina);



INSERT INTO pais_cliente (id_pais_cliente, nombre_pais_cliente)
VALUES 
    (493, 'México'),
    (249, 'Estados Unidos'),
    (149, 'Canadá'),
    (245, 'España'),
    (276, 'Alemania'),
    (275, 'Francia'),
    (386, 'Italia'),
    (245, 'España'),
    (156, 'China'),
    (76, 'Brasil');



INSERT INTO region_cliente (id_region_cliente, nombre_region_cliente, id_pais_cliente)
VALUES 
    (08, 'Merida', 493),
    (660, 'Misuri', 249),
    (780, 'Edmonton', 149),
    (01, 'Andalucía', 245),
    (496, 'Suabia', 276),
    (16, 'Charente', 275),
    (7, 'Lombardia', 386),
    (12, 'Galicia', 245),
    (571, 'Hangzhou', 156),
    (10, 'Centro', 76);


INSERT INTO ciudad_cliente (id_ciudad_cliente, codigo_cliente, nombre_ciudad_cliente, id_region_cliente)
VALUES 
    (31, 1,'Yucatán',08),
    (653,2, 'Sedalia', 660),
    (15, 3, 'Downtown', 780),
    (23, 4, 'Madrid', 1),
    (821,5, 'Augsberg',496 ),
    (161,6, 'Cognac', 16),
    (332,7, 'Varese', 7),
    (27,8,'Lugo', 12),
    (310,9, 'Madrid', 571),
    (55,10,'Brasilia', 10);


INSERT INTO info_cliente (id_info_cliente, codigo_cliente, nombre_cliente, nombre2_cliente, apellido1_cliente, apellido2_cliente)
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


INSERT INTO contacto_cliente (id_contacto_cliente, codigo_cliente, nombre_contacto_cliente, apellido_contacto_cliente)
VALUES  
    (1, 1, 'Juan', 'Pérez'),
    (2, 2, 'María', 'López'),
    (3, 3, 'Pedro', 'González'),
    (4, 4, 'Ana', 'Martínez'),
    (5, 5, 'Luis', 'Rodríguez'),
    (6, 6, 'Laura', 'Hernández'),
    (7, 7, 'Carlos', 'Díaz'),
    (8, 8, 'Sofía', 'Sánchez'),
    (9, 9, 'Javier', 'Ramírez'),
    (10, 10, 'Elena', 'Gómez');


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


INSERT INTO direccion_cliente( id_direccion_cliente,codigo_cliente,
  linea_direccion1_cliente, linea_direccion2_cliente,codigo_postal_cliente)
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
(76,'Brasil');



INSERT INTO region_oficina (id_region_oficina, nombre_region_oficina, id_pais_oficina)
VALUES 
(80, 'Centro', 1),
(2,'Norte', 840),
(3, 'Sur', 124),
(4,'Este', 724),
(5, 'Oeste', 276),
(6, 'Noroeste', 250),
(7, 'Sureste', 7),
(8, 'Suroeste', 8),
(9, 'Noreste', 156),
(10,'Centro', 76);

INSERT INTO oficina (codigo_oficina, id_ciudad_oficina, id_contacto_oficina, id_direccion_oficina)
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

INSERT INTO ciudad_oficina (id_ciudad_oficina,codigo_oficina, nombre_ciudad_oficina, id_region_oficina)
VALUES 
(1,1, 'Ciudad de México', 80),
(2,2,'New york', 2),
(3,3, 'Fuenlabrada', 3),
(4,4, 'Sevilla', 4),
(5,5, 'Colonia', 5),
(6,6, 'Lyon', 6),
(7,7, 'Pisa', 7),
(8,8, 'Kioto', 8),
(9,9, 'Pekin', 9),
(10,10, 'Recife', 10);


INSERT INTO contacto_oficina (id_contacto_oficina, codigo_oficina, codigo_postal_oficina, telefono_oficina)
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



INSERT INTO direccion_oficina (id_direccion_oficina, codigo_oficina, linea_direccion1_oficina, linea_direccion2_oficina)
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

