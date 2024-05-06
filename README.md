# PROYECTO BD

### Consultas sobre una tabla

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

   ```mysql
   CREATE VIEW oficinas AS 
   SELECT o.codigo_oficina, c_o.nombre_ciudad_oficina
   FROM oficina AS o
   INNER JOIN ciudad_oficina AS c_o ON o.id_ciudad_oficina = c_o.id_ciudad_oficina;
   
   SELECT codigo_oficina, nombre_ciudad_oficina
   FROM oficinas;
   
   +----------------+-----------------------+
   | codigo_oficina | nombre_ciudad_oficina |
   +----------------+-----------------------+
   |              1 | Ciudad de México      |
   |              2 | New york              |
   |              3 | Toronto               |
   |              4 | Sevilla               |
   |              5 | Colonia               |
   |              6 | Lyon                  |
   |              7 | Pisa                  |
   |              8 | Kioto                 |
   |              9 | Pekin                 |
   |             10 | Recife                |
   +----------------+-----------------------+
   ```

   

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

   ```mysql
   DELIMITER $$
   CREATE PROCEDURE oficinas_españa()
   BEGIN
     SELECT c_o.nombre_ciudad_oficina, con_o.telefono_oficina
     FROM ciudad_oficina AS c_o
     INNER JOIN contacto_oficina AS con_o ON con_o.codigo_oficina = c_o.codigo_oficina 
     INNER JOIN region_oficina AS r_o ON r_o.id_region_oficina = c_o.id_region_oficina
     INNER JOIN pais_oficina AS p_o ON p_o.id_pais_oficina = r_o.id_pais_oficina
     WHERE p_o.nombre_pais_oficina = 'España';
   END$$
   DELIMITER ;
   CALL oficinas_españa();
   
   +-----------------------+------------------+
   | nombre_ciudad_oficina | telefono_oficina |
   +-----------------------+------------------+
   | Sevilla               | 555-456-789      |
   +-----------------------+------------------+
   ```

   

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
  jefe tiene un código de jefe igual a 7.

  ```mysql
  SELECT con_e.nombre_empleado,con_e.apellido1_empleado,con_e.apellido2_empleado, con_e.email_empleado
  FROM contacto_empleado AS con_e
  INNER JOIN jefe AS j ON con_e.codigo_empleado = j.codigo_empleado
  WHERE j.codigo_jefe = 7;
  
  +-----------------+--------------------+--------------------+------------------+
  | nombre_empleado | apellido1_empleado | apellido2_empleado | email_empleado   |
  +-----------------+--------------------+--------------------+------------------+
  | Luis Fernando   | Gómez              | Vázquez            | luis@example.com |
  +-----------------+--------------------+--------------------+------------------+
  ```

  

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
  empresa.

  ```mysql
  CREATE VIEW jefe_empresa AS
  SELECT j.puesto_jefe,j.nombre_jefe,j.apellido1_jefe,j.apellido2_jefe,j.email_jefe
  FROM jefe AS j
  WHERE j.puesto_jefe = 'CEO';
  
  SELECT puesto_jefe,nombre_jefe,apellido1_jefe,apellido2_jefe,email_jefe
  FROM jefe_empresa;
  
  +-------------+-------------+----------------+----------------+---------------------+
  | puesto_jefe | nombre_jefe | apellido1_jefe | apellido2_jefe | email_jefe          |
  +-------------+-------------+----------------+----------------+---------------------+
  | CEO         | Gerardo     | Hernández      | Gómez          | gerardo@example.com |
  +-------------+-------------+----------------+----------------+---------------------+
  ```

  

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
  empleados que no sean representantes de ventas.

  ```mysql
  DELIMITER $$
  CREATE PROCEDURE no_representantes()
  BEGIN
    SELECT con_e.nombre_empleado,con_e.apellido1_empleado,con_e.apellido2_empleado,e.puesto
    FROM empleado AS e
    INNER JOIN contacto_empleado AS con_e ON e.codigo_empleado = con_e.codigo_empleado
    WHERE NOT e.puesto = 'Representante de ventas';
  END$$
  DELIMITER ;
  
  CALL no_representantes();
  
  +-----------------+--------------------+--------------------+---------------+
  | nombre_empleado | apellido1_empleado | apellido2_empleado | puesto        |
  +-----------------+--------------------+--------------------+---------------+
  | Juan            | Hernández          | Gómez              | Gerente       |
  | María Elena     | Sánchez            | Martínez           | Analista      |
  | Pedro Luis      | González           | Ramírez            | Asistente     |
  | Sara Alejandra  | García             | Torres             | Asistente     |
  | Pablo Javier    | López              | Fernández          | Administrador |
  | Jorge Emilio    | Gutiérrez          | Hernández          | Desarrollador |
  | Rosa María      | Martínez           | Gómez              | Asistente     |
  +-----------------+--------------------+--------------------+---------------+
  ```

  

6. Devuelve un listado con el nombre de los todos los clientes españoles.

   ```mysql
   SELECT DISTINCT in_o.nombre_cliente,c_c.nombre_ciudad_cliente, p_c.nombre_pais_cliente
   FROM ciudad_cliente AS c_c
   INNER JOIN region_cliente AS r_c ON c_c.id_region_cliente = r_c.id_region_cliente
   INNER JOIN pais_cliente AS p_c ON r_c.id_pais_cliente = p_c.id_pais_cliente
   INNER JOIN info_cliente AS in_o ON c_c.codigo_cliente = in_o.codigo_cliente 
   WHERE p_c.nombre_pais_cliente = 'España';
   
   +----------------+-----------------------+---------------------+
   | nombre_cliente | nombre_ciudad_cliente | nombre_pais_cliente |
   +----------------+-----------------------+---------------------+
   | Ana            | Jaén                  | España              |
   | Carla          | Lugo                  | España              |
   +----------------+-----------------------+---------------------+
   ```

   

7. Devuelve un listado con los distintos estados por los que puede pasar un
  pedido.

  

8. Devuelve un listado con el código de cliente de aquellos clientes que
  realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
  aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
  • Utilizando la función YEAR de MySQL.
  • Utilizando la función DATE_FORMAT de MySQL.
  • Sin utilizar ninguna de las funciones anteriores.

9. Devuelve un listado con el código de pedido, código de cliente, fecha
  esperada y fecha de entrega de los pedidos que no han sido entregados a
  tiempo.

10. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
    menos dos días antes de la fecha esperada.
    • Utilizando la función ADDDATE de MySQL.
    • Utilizando la función DATEDIFF de MySQL.
    • ¿Sería posible resolver esta consulta utilizando el operador de suma + o
    resta -?

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

12. Devuelve un listado de todos los pedidos que han sido entregados en el
    mes de enero de cualquier año.

13. Devuelve un listado con todos los pagos que se realizaron en el
    año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

14. Devuelve un listado con todas las formas de pago que aparecen en la
    tabla pago. Tenga en cuenta que no deben aparecer formas de pago
    repetidas.

15. Devuelve un listado con todos los productos que pertenecen a la
    gama Ornamentales y que tienen más de 100 unidades en stock. El listado
    deberá estar ordenado por su precio de venta, mostrando en primer lugar
    los de mayor precio.

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
    cuyo representante de ventas tenga el código de empleado 11 o 30.