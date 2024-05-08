# PROYECTO BD PARTE 1

![image](https://github.com/SaraLuciaLozanoRueda/ProyectoBD/assets/151969212/6399b3f5-000f-4410-974e-0d694b894e5e)

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
   |              3 | Fuenlabrada           |
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

     ```mysql
      CREATE VIEW estados_pedidos AS 
      SELECT DISTINCT p.estado_pedido
      FROM  pedido AS p;
         
      SELECT estado_pedido
      FROM estados_pedidos;
     
     +---------------+
     | estado_pedido |
     +---------------+
     | finalizado    |
     | en proceso    |
     | no permitido  |
     +---------------+
     ```

     

     8. Devuelve un listado con el código de cliente de aquellos clientes que
          realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
            aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
            • Utilizando la función YEAR de MySQL.

          ```mysql
          DELIMITER $$
          CREATE PROCEDURE pago_2008()
          BEGIN 
            SELECT p.codigo_cliente,in_c.nombre_cliente
            FROM pago AS p
            INNER JOIN info_cliente AS in_c ON p.codigo_cliente = in_c.codigo_cliente
            WHERE YEAR(p.fecha_pago) = '2008';
          END$$
          DELIMITER ;
          CALL pago_2008();
          
          +----------------+----------------+
          | codigo_cliente | nombre_cliente |
          +----------------+----------------+
          |              1 | Juan           |
          |              6 | Pablo          |
          |             10 | Rosa           |
          +----------------+----------------+
          ```

            • Utilizando la función DATE_FORMAT de MySQL.

          ```mysql
          DELIMITER $$
          CREATE PROCEDURE pago_2008()
          BEGIN 
            SELECT p.codigo_cliente,in_c.nombre_cliente
            FROM pago AS p
            INNER JOIN info_cliente AS in_c ON p.codigo_cliente = in_c.codigo_cliente
            WHERE DATE_FORMAT(p.fecha_pago, '%Y')= '2008';
          END$$
          DELIMITER ;
          CALL pago_2008();
          ```

          

            • Sin utilizar ninguna de las funciones anteriores.

          ```mysql
          DELIMITER $$
          CREATE PROCEDURE pago_2008()
          BEGIN 
            SELECT p.codigo_cliente,in_c.nombre_cliente
            FROM pago AS p
            INNER JOIN info_cliente AS in_c ON p.codigo_cliente = in_c.codigo_cliente
            WHERE p.fecha_pago LIKE '2008-%';
          END$$
          DELIMITER ;
          CALL pago_2008();
          ```

          

9. Devuelve un listado con el código de pedido, código de cliente, fecha
   esperada y fecha de entrega de los pedidos que no han sido entregados a
     tiempo.

```mysql
SELECT pe.codigo_pedido,pe.codigo_cliente,pe.fecha_esperada ,pe.fecha_entrega
FROM pedido AS pe
WHERE NOT pe.fecha_esperada = pe.fecha_entrega;


+---------------+----------------+----------------+---------------+
| codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
+---------------+----------------+----------------+---------------+
|             1 |              1 | 2024-04-10     | 2024-04-11    |
|             2 |              2 | 2024-04-11     | 2024-04-12    |
|             3 |              3 | 2024-04-12     | 2024-04-13    |
+---------------+----------------+----------------+---------------+
```



10. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
    menos dos días antes de la fecha esperada.

**• Utilizando la función ADDDATE de MySQL.**

```mysql
SELECT pe.codigo_pedido,pe.codigo_cliente,pe.fecha_esperada ,pe.fecha_entrega
FROM pedido AS pe
WHERE pe.fecha_entrega <= ADDDATE(pe.fecha_esperada, -2);

+---------------+----------------+----------------+---------------+
| codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
+---------------+----------------+----------------+---------------+
|             4 |              4 | 2009-04-13     | 2009-04-11    |
|             8 |              8 | 2021-04-17     | 2021-04-13    |
+---------------+----------------+----------------+---------------+
```

**• Utilizando la función DATEDIFF de MySQL.**

```mysql
CREATE VIEW dias_antes_pedido AS
SELECT pe.codigo_pedido,pe.codigo_cliente,pe.fecha_esperada ,pe.fecha_entrega
FROM pedido AS pe
WHERE DATEDIFF(pe.fecha_esperada, pe.fecha_entrega) >= 2;

SELECT codigo_pedido,codigo_cliente,fecha_esperada,fecha_entrega
FROM dias_antes_pedido;
```

**• ¿Sería posible resolver esta consulta utilizando el operador de suma + o**
**resta -?**

```mysql
DELIMITER $$
CREATE PROCEDURE 2_dias_antes()
BEGIN 
  SELECT pe.codigo_pedido,pe.codigo_cliente,pe.fecha_esperada ,pe.fecha_entrega
  FROM pedido AS pe
  WHERE pe.fecha_entrega BETWEEN pe.fecha_esperada - INTERVAL 2 DAY AND pe.fecha_esperada;
END$$
DELIMITER ;

CALL 2_dias_antes();

+---------------+----------------+----------------+---------------+
| codigo_pedido | codigo_cliente | fecha_esperada | fecha_entrega |
+---------------+----------------+----------------+---------------+
|             4 |              4 | 2009-04-13     | 2009-04-11    |
+---------------+----------------+----------------+---------------+
```



11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

```mysql
SELECT pe.codigo_pedido,pe.codigo_cliente,pe.comentarios_pedido
FROM pedido AS pe
WHERE YEAR (pe.fecha_esperada) = '2009' AND pe.estado_pedido = 'no permitido' ;

+---------------+----------------+--------------------------------------+
| codigo_pedido | codigo_cliente | comentarios_pedido                   |
+---------------+----------------+--------------------------------------+
|             5 |              5 | Cliente no autorizado                |
|             9 |              9 | Productos pendientes de fabricación  |
+---------------+----------------+--------------------------------------+
```



12. Devuelve un listado de todos los pedidos que han sido entregados en el
    mes de enero de cualquier año.

    ```mysql
    CREATE VIEW enero AS
    SELECT pe.codigo_pedido,pe.fecha_entrega,pe.comentarios_pedido
    FROM pedido AS pe
    WHERE MONTH(pe.fecha_entrega) = '01' ;
    
    SELECT codigo_pedido,fecha_entrega,comentarios_pedido
    FROM enero;
     
     +---------------+---------------+--------------------+
    | codigo_pedido | fecha_entrega | comentarios_pedido |
    +---------------+---------------+--------------------+
    |             7 | 2022-01-16    | Pedido urgente     |
    |            10 | 2024-01-19    | NULL               |
    +---------------+---------------+--------------------+
    ```

    

13. Devuelve un listado con todos los pagos que se realizaron en el
    año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

    ```mysql
    DELIMITER $$
    CREATE PROCEDURE Paypal_2008()
    BEGIN
        SELECT p.fecha_pago,p.forma_pago,p.total_pago
        FROM pago AS p
        WHERE YEAR(p.fecha_pago) = '2008' AND p.forma_pago =  'Paypal'
        ORDER BY p.total_pago DESC;
    END$$
    DELIMITER ;
    
    CALL Paypal_2008();
    
    +------------+------------+------------+
    | fecha_pago | forma_pago | total_pago |
    +------------+------------+------------+
    | 2008-04-24 | PayPal     |     240.00 |
    | 2008-04-19 | PayPal     |     220.00 |
    +------------+------------+------------+
    ```

    

14. Devuelve un listado con todas las formas de pago que aparecen en la
    tabla pago. Tenga en cuenta que no deben aparecer formas de pago
    repetidas.

    ```mysql
    SELECT DISTINCT p.forma_pago
    FROM pago AS p;
    
    +------------------------+
    | forma_pago             |
    +------------------------+
    | Tarjeta de crédito     |
    | Transferencia bancaria |
    | PayPal                 |
    | Cheque                 |
    | Efectivo               |
    | Tarjeta de débito      |
    +------------------------+
    ```

    

15. Devuelve un listado con todos los productos que pertenecen a la
    gama Ornamentales y que tienen más de 100 unidades en stock. El listado
    deberá estar ordenado por su precio de venta, mostrando en primer lugar
    los de mayor precio.

    ```mysql
    SELECT pr.codigo_producto,pr.nombre_producto,pr.descripcion
    FROM gama_producto AS g_pr
    INNER JOIN producto AS pr ON pr.id_gama_producto = g_pr.id_gama_producto
    WHERE g_pr.descripcion_gama_producto= 'Ornamentales' AND pr.cantidad_stock > 100;
    
    +-----------------+------------------------------------+--------------------------------------+
    | codigo_producto | nombre_producto                    | descripcion                          |
    +-----------------+------------------------------------+--------------------------------------+
    |               1 | Mi vaquita                         | Forro lavadora                       |
    |               7 | La guerra de troya                 | Jarron de flores                     |
    |               9 | Golden Filigree Christmas Ornament | Adorno navideño de filigrana dorada  |
    +-----------------+------------------------------------+--------------------------------------+
    ```

    

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
    cuyo representante de ventas tenga el código de empleado 11 o 30.

    ```mysql
    CREATE VIEW madrid AS 
    SELECT  c.codigo_empleado_repventas,c_c.nombre_ciudad_cliente
    FROM cliente AS c
    INNER JOIN ciudad_cliente AS c_c ON c_c.codigo_cliente = c.codigo_cliente
    WHERE c_c.nombre_ciudad_cliente = 'Madrid';
    
    SELECT codigo_empleado_repventas,nombre_ciudad_cliente
    FROM madrid;
    
    +---------------------------+-----------------------+
    | codigo_empleado_repventas | nombre_ciudad_cliente |
    +---------------------------+-----------------------+
    |                        30 | Madrid                |
    |                        11 | Madrid                |
    +---------------------------+-----------------------+
    ```







### Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.



1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
    representante de ventas.

  ```sql
  DELIMITER $$
  CREATE PROCEDURE cliente_rep_ventas()
  BEGIN 
    SELECT  inf_c.nombre_cliente,con_e.nombre_empleado,con_e.apellido1_empleado,con_e.apellido2_empleado
    FROM info_cliente AS inf_c
    INNER JOIN cliente AS c ON c.codigo_cliente = inf_c.codigo_cliente
    INNER JOIN contacto_empleado AS con_e ON c.codigo_empleado_repventas = con_e.codigo_empleado;
  END$$
  DELIMITER ; 
  
  CALL cliente_rep_ventas();
  
  +----------------+-----------------+--------------------+--------------------+
  | nombre_cliente | nombre_empleado | apellido1_empleado | apellido2_empleado |
  +----------------+-----------------+--------------------+--------------------+
  | Carla          | Ana Sofía       | Pérez              | Díaz               |
  | Luis           | Ana Sofía       | Pérez              | Díaz               |
  | Rosa           | Luis Fernando   | Gómez              | Vázquez            |
  | María          | Luis Fernando   | Gómez              | Vázquez            |
  | Sara           | Carla Lucía     | Santos             | Ruiz               |
  | Pedro          | Carla Lucía     | Santos             | Ruiz               |
  +----------------+-----------------+--------------------+--------------------+
  ```

  

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
    nombre de sus representantes de ventas.

  ```sql
  SELECT p.codigo_empleado,in_c.nombre_cliente
  FROM pago AS p
  INNER JOIN cliente AS c ON c.codigo_cliente = p.codigo_cliente
  INNER JOIN info_cliente AS in_c ON in_c.codigo_cliente = c.codigo_cliente
  WHERE p.codigo_empleado IS NOT  NULL;
  
  +-----------------+----------------+
  | codigo_empleado | nombre_cliente |
  +-----------------+----------------+
  |              30 | Luis           |
  |               4 | Carla          |
  |              11 | Jorge          |
  +-----------------+----------------+
  ```

  

3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
    el nombre de sus representantes de ventas.

  ```sql
  SELECT p.codigo_empleado,in_c.nombre_cliente
  FROM pago AS p
  
  INNER JOIN info_cliente AS in_c ON in_c.codigo_cliente = p.codigo_cliente
  WHERE p.codigo_empleado IS NULL;
  
  +-----------------+----------------+
  | codigo_empleado | nombre_cliente |
  +-----------------+----------------+
  |            NULL | Juan           |
  |            NULL | María          |
  |            NULL | Pedro          |
  |            NULL | Ana            |
  |            NULL | Sara           |
  |            NULL | Rosa           |
  +-----------------+----------------+
  ```

  

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
    representantes junto con la ciudad de la oficina a la que pertenece el
    representante.

  ```sql
  DELIMITER $$
  CREATE PROCEDURE cliente_rep_ciudad()
  BEGIN
    SELECT p.codigo_empleado,in_c.nombre_cliente,c_o.nombre_ciudad_oficina
    FROM pago AS p
    INNER JOIN cliente AS c ON c.codigo_cliente = p.codigo_cliente
    INNER JOIN info_cliente AS in_c ON in_c.codigo_cliente = c.codigo_cliente
    INNER JOIN empleado AS e ON e.codigo_empleado = p.codigo_empleado
    INNER JOIN ciudad_oficina AS c_o ON e.codigo_oficina = c_o.codigo_oficina
    WHERE p.codigo_empleado IS NOT NULL;
  END$$
  DELIMITER ; 
  
  CALL cliente_rep_ciudad();
  
  +-----------------+----------------+-----------------------+
  | codigo_empleado | nombre_cliente | nombre_ciudad_oficina |
  +-----------------+----------------+-----------------------+
  |               4 | Carla          | New york              |
  |              11 | Jorge          | Sevilla               |
  |              30 | Luis           | Sevilla               |
  +-----------------+----------------+-----------------------+
  ```

  

5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
    de sus representantes junto con la ciudad de la oficina a la que pertenece el
    representante.

  ```mysql
  SELECT p.codigo_empleado,in_c.nombre_cliente
  FROM info_cliente AS in_c
  INNER JOIN pago AS p ON in_c.codigo_cliente = p.codigo_cliente
  WHERE in_c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);
  ```

  

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

   ```sql
   SELECT dir_o.linea_direccion1_oficina,dir_o.linea_direccion2_oficina
   FROM direccion_oficina AS dir_o
   INNER JOIN ciudad_oficina AS ciu_o ON dir_o.codigo_oficina = ciu_o.codigo_oficina
   WHERE ciu_o.nombre_ciudad_oficina = 'Fuenlabrada';
   
   +--------------------------+--------------------------+
   | linea_direccion1_oficina | linea_direccion2_oficina |
   +--------------------------+--------------------------+
   | Av. Revolución 789       | Col. Moderna             |
   +--------------------------+--------------------------+
   ```

   

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
     con la ciudad de la oficina a la que pertenece el representante.

     ```mysql
     +----------------+-----------------+-----------------------+
     | nombre_cliente | nombre_empleado | nombre_ciudad_oficina |
     +----------------+-----------------+-----------------------+
     | Luis           | Ana Sofía       | New york              |
     | Carla          | Ana Sofía       | New york              |
     +----------------+-----------------+-----------------------+
     
     SELECT inf_c.nombre_cliente, con_e.nombre_empleado, ciu_o.nombre_ciudad_oficina
     FROM info_cliente AS inf_c
     INNER JOIN cliente AS c ON inf_c.codigo_cliente = c.codigo_cliente
     INNER JOIN contacto_empleado AS con_e ON c.codigo_empleado_repventas = con_e.codigo_empleado
     INNER JOIN empleado AS e ON c.codigo_empleado_repventas = e.codigo_empleado
     INNER JOIN ciudad_oficina AS ciu_o ON ciu_o.codigo_oficina = e.codigo_oficina;
     ```

  

8. Devuelve un listado con el nombre de los empleados junto con el nombre
    de sus jefes.
    
    ```mysql
       SELECT con_e.nombre_empleado,j.nombre_jefe,j.apellido1_jefe
       FROM empleado AS e
       INNER JOIN contacto_empleado AS con_e ON con_e.codigo_empleado = e.codigo_empleado
       INNER JOIN jefe AS j ON j.codigo_jefe = e.codigo_jefe;
      
         +-----------------+-------------+----------------+
         | nombre_empleado | nombre_jefe | apellido1_jefe |
         +-----------------+-------------+----------------+
         | María Elena     | Gerardo     | Hernández      |
         | Pedro Luis      | Gerardo     | Hernández      |
         | Ana Sofía       | Roberto     | Fernández      |
         | Sara Alejandra  | Roberto     | Fernández      |
         | Pablo Javier    | Eduardo     | López          |
         | Luis Fernando   | Alberto     | Soria          |
         | Jorge Emilio    | Alberto     | Soria          |
         | Rosa María      | María       | González       |
         +-----------------+-------------+----------------+
    ```
    
    

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

10. Devuelve el nombre de los clientes a los que no se les ha entregado a
    tiempo un pedido.

    ```sql
    SELECT inf_c.nombre_cliente,p.fecha_esperada,p.fecha_entrega
    FROM info_cliente AS inf_c
    INNER JOIN pedido AS p ON p.codigo_cliente = inf_c.codigo_cliente
    WHERE NOT p.fecha_esperada = fecha_entrega;
    
    +----------------+----------------+---------------+
    | nombre_cliente | fecha_esperada | fecha_entrega |
    +----------------+----------------+---------------+
    | Juan           | 2024-04-10     | 2024-04-11    |
    | María          | 2024-04-11     | 2024-04-12    |
    | Pedro          | 2024-04-12     | 2024-04-13    |
    | Ana            | 2009-04-13     | 2009-04-11    |
    | Carla          | 2021-04-17     | 2021-04-13    |
    +----------------+----------------+---------------+
    ```
    
    
    
11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
    
    ```sql
    SELECT inf_c.nombre_cliente, gama.descripcion_gama_producto
    FROM cliente AS c
    INNER JOIN info_cliente AS inf_c ON c.codigo_cliente = inf_c.codigo_cliente
    INNER JOIN pedido AS p ON c.codigo_cliente = p.codigo_cliente
    INNER JOIN detalle_pedido AS dp ON p.codigo_pedido = dp.codigo_pedido
    INNER JOIN producto AS prod ON dp.codigo_producto = prod.codigo_producto
    INNER JOIN gama_producto AS gama ON prod.id_gama_producto = gama.id_gama_producto;
    
    +----------------+---------------------------+
    | nombre_cliente | descripcion_gama_producto |
    +----------------+---------------------------+
    | Juan           | Higiene y bienestar       |
    | Juan           | Ornamentales              |
    | María          | Higiene y bienestar       |
    | María          | Ornamentales              |
    | Pedro          | Teconologia               |
    | Ana            | Ornamentales              |
    | Sara           | Ornamentales              |
    | Pablo          | Teconologia               |
    | Luis           | Ornamentales              |
    | Carla          | Higiene y bienestar       |
    +----------------+---------------------------+
    ```
    
    

### Consultas multitabla (Composición externa)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
LEFT JOIN y NATURAL RIGHT JOIN.

1. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

  ```mysql
  SELECT c.codigo_cliente
  FROM cliente AS c
  INNER JOIN pago AS p ON c.codigo_cliente = p.codigo_cliente
  WHERE p.codigo_cliente IS NULL;
  ```

  

2. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pedido.

  ```mysql
  SELECT c.codigo_cliente
  FROM cliente AS c
  INNER JOIN pedido AS p ON c.codigo_cliente = p.codigo_cliente
  WHERE p.codigo_cliente IS NULL;
  ```

  

3. Devuelve un listado que muestre los clientes que no han realizado ningún
    pago y los que no han realizado ningún pedido.

  ```mysql
  SELECT c.codigo_cliente
  FROM cliente AS c
  INNER JOIN pedido AS pe ON c.codigo_cliente = pe.codigo_cliente
  INNER JOIN pago AS p ON c.codigo_cliente = p.codigo_cliente
  WHERE p.codigo_cliente IS NULL;
  ```

  

4. Devuelve un listado que muestre solamente los empleados que no tienen
    una oficina asociada.

  ```mysql
  SELECT e.codigo_empleado,con_e.nombre_empleado
  FROM empleado AS e 
  INNER JOIN contacto_empleado AS con_e ON e.codigo_empleado = con_e.codigo_empleado
  WHERE e.codigo_oficina IS NULL;
  
  +-----------------+-----------------+
  | codigo_empleado | nombre_empleado |
  +-----------------+-----------------+
  |               6 | Pablo Javier    |
  |               9 | Jorge Emilio    |
  +-----------------+-----------------+
  ```

  

5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

  ```mysql
  SELECT e.codigo_empleado,c.codigo_cliente
  FROM empleado AS e
  LEFT JOIN cliente AS c ON c.codigo_empleado_repventas = e.codigo_empleado
  WHERE c.codigo_empleado_repventas IS NULL;
  
  +-----------------+----------------+
  | codigo_empleado | codigo_cliente |
  +-----------------+----------------+
  |               1 |           NULL |
  |               2 |           NULL |
  |               3 |           NULL |
  |               5 |           NULL |
  |               6 |           NULL |
  |               9 |           NULL |
  |              10 |           NULL |
  +-----------------+----------------+
  ```

  

6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

  ```mysql
  SELECT e.codigo_empleado,c.codigo_cliente, con_o.codigo_postal_oficina, con_o.telefono_oficina, dir_o.linea_direccion1_oficina, dir_o.linea_direccion2_oficina
  FROM empleado AS e
  LEFT JOIN cliente AS c ON c.codigo_empleado_repventas = e.codigo_empleado
  INNER JOIN oficina AS o ON e.codigo_oficina = o.codigo_oficina
  LEFT JOIN contacto_oficina AS con_o ON o.codigo_oficina = con_o.codigo_oficina
  LEFT JOIN direccion_oficina AS dir_o ON o.codigo_oficina = dir_o.codigo_oficina
  WHERE c.codigo_empleado_repventas IS NULL;
  
  +-----------------+----------------+-----------------------+------------------+--------------------------+--------------------------+
  | codigo_empleado | codigo_cliente | codigo_postal_oficina | telefono_oficina | linea_direccion1_oficina | linea_direccion2_oficina |
  +-----------------+----------------+-----------------------+------------------+--------------------------+--------------------------+
  |               1 |           NULL | 12345                 | 555-123-456      | Av. Insurgentes Sur 123  | Col. Juárez              |
  |               2 |           NULL | 12345                 | 555-123-456      | Av. Insurgentes Sur 123  | Col. Juárez              |
  |               3 |           NULL | 54321                 | 555-987-654      | Av. Constitución 456     | Col. Centro              |
  |               5 |           NULL | 67890                 | 555-321-987      | Av. Revolución 789       | Col. Moderna             |
  |              10 |           NULL | 80246                 | 555-789-123      | Av. Reforma 987          | Col. Centro              |
  +-----------------+----------------+-----------------------+------------------+--------------------------+--------------------------+
  ```

  

7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

  ```mysql
  SELECT e.codigo_empleado,c.codigo_cliente,e.codigo_oficina
  FROM empleado AS e
  LEFT JOIN cliente AS c ON c.codigo_empleado_repventas = e.codigo_empleado
  INNER JOIN contacto_empleado AS con_e ON e.codigo_empleado = con_e.codigo_empleado
  WHERE e.codigo_oficina IS NULL AND c.codigo_empleado_repventas IS NULL;
  
  +-----------------+----------------+----------------+
  | codigo_empleado | codigo_cliente | codigo_oficina |
  +-----------------+----------------+----------------+
  |               6 |           NULL |           NULL |
  |               9 |           NULL |           NULL |
  +-----------------+----------------+----------------+
  ```

  

8. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

  ```mysql
  SELECT p.codigo_producto
  FROM producto AS p
  LEFT JOIN pedido AS pe ON p.codigo_producto = pe.codigo_producto
  WHERE pe.codigo_producto IS NULL;
  
  +-----------------+
  | codigo_producto |
  +-----------------+
  |               2 |
  +-----------------+
  ```

  

9. Devuelve un listado de los productos que nunca han aparecido en un
    pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.

  ```mysql
  SELECT p.nombre_producto,descripcion_gama_producto,imagen
  FROM producto AS p
  LEFT JOIN pedido AS pe ON p.codigo_producto = pe.codigo_producto
  INNER JOIN gama_producto AS g_pr ON p.codigo_producto = g_pr.codigo_producto
  WHERE pe.codigo_producto IS NULL;
  
  +---------------------+---------------------------+-------------+
  | nombre_producto     | descripcion_gama_producto | imagen      |
  +---------------------+---------------------------+-------------+
  | EcoFresh Toothpaste | Higiene y bienestar       | imagen2.jpg |
  +---------------------+---------------------------+-------------+
  ```

  

10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
    
    ```mysql
    SELECT o.codigo_oficina
    FROM oficina AS o
    LEFT JOIN empleado AS e ON o.codigo_oficina = e.codigo_oficina
    LEFT JOIN cliente AS c ON e.codigo_empleado = c.codigo_empleado
    LEFT JOIN pedido AS pe ON c.codigo_cliente = pe.codigo_cliente
    LEFT JOIN producto AS p ON pe.codigo_producto = p.codigo_producto
    LEFT JOIN gama_producto AS g ON p.id_gama_producto = g.id_gama_producto
    WHERE e.puesto = 'Representante de ventas'
    AND g.descripcion_gama_producto = 'Frutales'
    AND e.codigo_empleado IS NULL;
    ```
    
    
    
11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
    
    ```mysql
       SELECT DISTINCT c.codigo_cliente
      FROM cliente AS c
      INNER JOIN pedido AS p ON c.codigo_cliente = p.codigo_cliente
      WHERE c.codigo_cliente NOT IN ( SELECT DISTINCT codigo_cliente FROM pago);
    
      +----------------+
      | codigo_cliente |
      +----------------+
      |              3 |
      |              6 |
      +----------------+
    ```
    
    
    
12. Devuelve un listado con los datos de los empleados que no tienen clientes
    asociados y el nombre de su jefe asociado.

    ```mysql
    SELECT e.codigo_empleado,c.codigo_cliente,j.nombre_jefe
    FROM empleado AS e
    LEFT JOIN cliente AS c ON c.codigo_empleado_repventas = e.codigo_empleado
    INNER JOIN jefe AS j ON e.codigo_jefe = j.codigo_jefe
    WHERE c.codigo_empleado_repventas IS NULL;
    
    +-----------------+----------------+-------------+
    | codigo_empleado | codigo_cliente | nombre_jefe |
    +-----------------+----------------+-------------+
    |               2 |           NULL | Gerardo     |
    |               3 |           NULL | Gerardo     |
    |               5 |           NULL | Roberto     |
    |               6 |           NULL | Eduardo     |
    |               9 |           NULL | Alejandro   |
    |              10 |           NULL | María       |
    +-----------------+----------------+-------------+
    ```
    
    

### Consultas resumen

1. ¿Cuántos empleados hay en la compañía?

   ```mysql
   DELIMITER $$
   CREATE PROCEDURE TOTAL_EMPLEADOS()
   BEGIN 
     SELECT COUNT(e.codigo_empleado) AS TOTAL_EMPLEADOS
     FROM empleado AS e;
   END$$
   DELIMITER ;
   CALL TOTAL_EMPLEADOS();
   
   +-----------------+
   | TOTAL_EMPLEADOS |
   +-----------------+
   |              10 |
   +-----------------+
   ```

   

2. ¿Cuántos clientes tiene cada país?

   ```mysql
   SELECT p_c.nombre_pais_cliente, COUNT(DISTINCT c.codigo_cliente) AS conteo
   FROM cliente AS c
   INNER JOIN ciudad_cliente AS c_c ON c.id_ciudad_cliente = c_c.id_ciudad_cliente
   INNER JOIN region_cliente AS r_c ON c_c.id_region_cliente = r_c.id_region_cliente
   INNER JOIN pais_cliente AS p_c ON r_c.id_pais_cliente = p_c.id_pais_cliente
   GROUP BY p_c.nombre_pais_cliente;
   
   +---------------------+--------+
   | nombre_pais_cliente | conteo |
   +---------------------+--------+
   | Alemania            |      1 |
   | Canadá              |      1 |
   | China               |      1 |
   | España              |      2 |
   | Estados Unidos      |      1 |
   | Francia             |      1 |
   | Italia              |      1 |
   | México              |      1 |
   +---------------------+--------+
   ```

   

3. ¿Cuál fue el pago medio en 2009?

   ```mysql
   SELECT AVG(p.total_pago) AS media
   FROM pago AS p
   WHERE YEAR(p.fecha_pago) = '2009';

   +------------+
   | media      |
   +------------+
   | 190.000000 |
   +------------+
   ```

   

4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
    descendente por el número de pedidos.

  ```mysql
   DELIMITER $$
   CREATE PROCEDURE estados_cantidad()
   BEGIN
     SELECT p.estado_pedido, COUNT(p.estado_pedido) AS cantidad
     FROM pedido AS p
     GROUP BY p.estado_pedido
     ORDER BY cantidad DESC;
   END$$
   DELIMITER ;
   CALL estados_cantidad();
   
   +---------------+----------+
   | estado_pedido | cantidad |
   +---------------+----------+
   | en proceso    |        6 |
   | finalizado    |        2 |
   | no permitido  |        2 |
   +---------------+----------+
   
  ```

  

5. Calcula el precio de venta del producto más caro y más barato en una
    misma consulta.

  ```mysql
   CREATE VIEW mas_menos AS
   SELECT MIN(p.precio_venta)AS MAS_BARATO,MAX(p.precio_venta) AS MAS_CARO
   FROM producto AS p;
   
   SELECT MAS_BARATO,MAS_CARO
   FROM mas_menos;
   
   +------------+----------+
   | MAS_BARATO | MAS_CARO |
   +------------+----------+
   |      10.00 |    50.00 |
   +------------+----------+
  ```

  

6. Calcula el número de clientes que tiene la empresa.

   ```mysql
      SELECT COUNT(c.codigo_cliente) AS cantidad_Clientes
      FROM cliente AS c;
      
      +-------------------+
      | cantidad_Clientes |
      +-------------------+
      |                10 |
      +-------------------+
   ```

   

7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

   ```mysql
      DELIMITER $$
      CREATE PROCEDURE domicilio_Madrid()
      BEGIN 
        SELECT COUNT(c.codigo_cliente) AS cantidad_Clientes
        FROM cliente AS c
        INNER JOIN ciudad_cliente AS ciu_c ON ciu_c.codigo_cliente = c.codigo_cliente
        WHERE ciu_c.nombre_ciudad_cliente = 'Madrid'
        GROUP BY ciu_c.nombre_ciudad_cliente;
      END$$
      DELIMITER ;
      
      CALL domicilio_Madrid();
      
      +-------------------+
      | cantidad_Clientes |
      +-------------------+
      |                 2 |
      +-------------------+
   
   ```

   

8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
    por M?

  ```mysql
     SELECT ciu_c.nombre_ciudad_cliente,COUNT(c.codigo_cliente) AS cantidad_Clientes
     FROM cliente AS c
     INNER JOIN ciudad_cliente AS ciu_c ON ciu_c.codigo_cliente = c.codigo_cliente
     WHERE ciu_c.nombre_ciudad_cliente LIKE 'M%'
     GROUP BY ciu_c.nombre_ciudad_cliente;
      
      +-----------------------+-------------------+
      | nombre_ciudad_cliente | cantidad_Clientes |
      +-----------------------+-------------------+
      | Madrid                |                 2 |
      +-----------------------+-------------------+
  ```

  

9. Devuelve el nombre de los representantes de ventas y el número de clientes
    al que atiende cada uno.

  ```mysql
   SELECT con_e.nombre_empleado AS REP_VENTAS,COUNT(c.codigo_cliente) AS CLIENTES
   FROM contacto_empleado AS con_e
   INNER JOIN cliente AS c ON c.codigo_empleado_repventas = con_e.codigo_empleado
   GROUP BY REP_VENTAS;
   
   +---------------+----------+
   | REP_VENTAS    | CLIENTES |
   +---------------+----------+
   | Luis Fernando |        2 |
   | Pablo Javier  |        2 |
   | Ana Sofía     |        1 |
   +---------------+----------+
  
  ```

  

10. Calcula el número de clientes que no tiene asignado representante de
    ventas.

    ```mysql
       SELECT COUNT(c.codigo_cliente) AS NO_TIENEN
      FROM cliente AS c
      WHERE c.codigo_empleado_repventas IS NULL;
      
      +-----------+
      | NO_TIENEN |
      +-----------+
      |         5 |
      +-----------+
    
    ```

    

11. Calcula la fecha del primer y último pago realizado por cada uno de los
    clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

    ```mysql
      SELECT c.codigo_cliente,in_c.nombre_cliente,in_c.nombre2_cliente,in_c.apellido1_cliente,in_c.apellido2_cliente,MIN(p.fecha_pago) AS primer_pago,MAX(p.fecha_pago) AS ultimo_pago
      from pago AS p
      INNER JOIN cliente AS c ON p.codigo_cliente = c.codigo_cliente
      INNER JOIN info_cliente AS in_c ON c.codigo_cliente = in_c.codigo_cliente
      GROUP BY c.codigo_cliente,in_c.nombre_cliente,in_c.nombre2_cliente,in_c.apellido1_cliente,in_c.apellido2_cliente;
      
      +----------------+----------------+-----------------+-------------------+-------------------+-------------+-------------+
      | codigo_cliente | nombre_cliente | nombre2_cliente | apellido1_cliente | apellido2_cliente | primer_pago | ultimo_pago |
      +----------------+----------------+-----------------+-------------------+-------------------+-------------+-------------+
      |              1 | Juan           | Carlos          | Gómez             | Hernández         | 2008-04-15  | 2024-04-17  |
      |              2 | María          | Elena           | Martínez          | Sánchez           | 2009-04-16  | 2009-04-16  |
      |              4 | Ana            | Sofía           | Díaz              | Pérez             | 2009-04-18  | 2009-04-18  |
      |              5 | Sara           | Alejandra       | Torres            | García            | 2008-04-19  | 2008-04-19  |
      |              7 | Luis           | Fernando        | Vázquez           | Gómez             | 2024-04-21  | 2024-04-21  |
      |              8 | Carla          | Lucía           | Ruiz              | Santos            | 2024-04-22  | 2024-04-22  |
      |              9 | Jorge          | Emilio          | Hernández         | Gutiérrez         | 2022-05-03  | 2022-05-03  |
      |             10 | Rosa           | María           | Gómez             | Martínez          | 2008-04-20  | 2008-04-24  |
      +----------------+----------------+-----------------+-------------------+-------------------+-------------+-------------+
       
    ```

    

12. Calcula el número de productos diferentes que hay en cada uno de los
    pedidos.

    ```mysql
       SELECT codigo_pedido, COUNT(DISTINCT codigo_producto) AS productos_diferentes
      FROM pedido
      GROUP BY codigo_pedido;
      
      +---------------+----------------------+
      | codigo_pedido | productos_diferentes |
      +---------------+----------------------+
      |             1 |                    1 |
      |             2 |                    1 |
      |             3 |                    1 |
      |             4 |                    1 |
      |             5 |                    1 |
      |             6 |                    1 |
      |             7 |                    1 |
      |             8 |                    1 |
      |             9 |                    1 |
      |            10 |                    1 |
      +---------------+----------------------+
    
    ```

    

13. Calcula la suma de la cantidad total de todos los productos que aparecen en
    cada uno de los pedidos.

    ```mysql
      SELECT codigo_pedido, COUNT(DISTINCT codigo_producto) AS productos_diferentes
      FROM pedido
      GROUP BY codigo_pedido;
       +---------------+----------------------+
      | codigo_pedido | productos_diferentes |
      +---------------+----------------------+
      |             1 |                    1 |
      |             2 |                    1 |
      |             3 |                    1 |
      |             4 |                    1 |
      |             5 |                    1 |
      |             6 |                    1 |
      |             7 |                    1 |
      |             8 |                    1 |
      |             9 |                    1 |
      |            10 |                    1 |
      +---------------+----------------------+
    
    ```

    

14. Devuelve un listado de los 20 productos más vendidos y el número total de
    unidades que se han vendido de cada uno. El listado deberá estar ordenado
    por el número total de unidades vendidas.

    ```mysql
       SELECT p.nombre_producto,SUM(d_p.cantidad) AS UNIDADES_VENDIDAS
      FROM producto AS p
      INNER JOIN detalle_pedido AS d_p ON p.codigo_producto = d_p.codigo_producto
      GROUP BY p.nombre_producto
      ORDER BY UNIDADES_VENDIDAS DESC
       LIMIT 20;
      
      +------------------------------------+-------------------+
      | nombre_producto                    | UNIDADES_VENDIDAS |
      +------------------------------------+-------------------+
      | Mi vaquita                         |                 5 |
      | Golden Filigree Christmas Ornament |                 5 |
      | SwiftCharge Power Bank             |                 4 |
      | EcoFresh Toothpaste                |                 3 |
      | La guerra de troya                 |                 3 |
      | Rustic Wooden Snowflake Deco       |                 2 |
      | TechGrip Phone Moun                |                 2 |
      | GlowBloom Facial Serum             |                 1 |
      | Charming Garden Wind Chime         |                 1 |
      | MindfulMeditation App              |                 1 |
      +------------------------------------+-------------------+
    
    ```

    

15. La facturación que ha tenido la empresa en toda la historia, indicando la
    base imponible, el IVA y el total facturado. La base imponible se calcula
    sumando el coste del producto por el número de unidades vendidas de la
    tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
    suma de los dos campos anteriores.

    ```mysql
       DELIMITER $$
      CREATE PROCEDURE facturacion()
      BEGIN
        SELECT SUM(p.precio_proveedor * d_p.cantidad) AS BASE_IMPONIBLE , 0.21 * SUM(p.precio_proveedor * d_p.cantidad) AS IVA, SUM(p.precio_proveedor * d_p.cantidad) +(0.21 * SUM(p.precio_proveedor *                d_p.cantidad)) AS TOTAL 
          FROM producto AS p 
          INNER JOIN detalle_pedido AS d_p ON p.codigo_producto = d_p.codigo_producto;
      END$$
      DELIMITER ;
      CALL facturacion();
      
      +----------------+---------+----------+
      | BASE_IMPONIBLE | IVA     | TOTAL    |
      +----------------+---------+----------+
      |         411.00 | 86.3100 | 497.3100 |
      +----------------+---------+----------+
    ```

    

16. La misma información que en la pregunta anterior, pero agrupada por
    código de producto.

    ```mysql
       SELECT d_p.codigo_producto,SUM(p.precio_proveedor * d_p.cantidad) AS BASE_IMPONIBLE , 0.21 * SUM(p.precio_proveedor * d_p.cantidad) AS IVA, SUM(p.precio_proveedor * d_p.cantidad) +(0.21 *                    SUM(p.precio_proveedor * d_p.cantidad)) AS TOTAL 
      FROM producto AS p 
      INNER JOIN detalle_pedido AS d_p ON p.codigo_producto = d_p.codigo_producto
      GROUP BY d_p.codigo_producto;
      
      +-----------------+----------------+---------+---------+
      | codigo_producto | BASE_IMPONIBLE | IVA     | TOTAL   |
      +-----------------+----------------+---------+---------+
      |               1 |          50.00 | 10.5000 | 60.5000 |
      |               2 |          60.00 | 12.6000 | 72.6000 |
      |               3 |          30.00 |  6.3000 | 36.3000 |
      |               4 |          25.00 |  5.2500 | 30.2500 |
      |               5 |          32.00 |  6.7200 | 38.7200 |
      |               6 |          35.00 |  7.3500 | 42.3500 |
      |               7 |          54.00 | 11.3400 | 65.3400 |
      |               8 |          20.00 |  4.2000 | 24.2000 |
      |               9 |          75.00 | 15.7500 | 90.7500 |
      |              10 |          30.00 |  6.3000 | 36.3000 |
      +-----------------+----------------+---------+---------+
    ```

    

17. La misma información que en la pregunta anterior, pero agrupada por
    código de producto filtrada por los códigos que empiecen por OR.

    ```mysql
          SELECT d_p.codigo_producto,SUM(p.precio_proveedor * d_p.cantidad) AS BASE_IMPONIBLE , 0.21 * SUM(p.precio_proveedor * d_p.cantidad) AS IVA, SUM(p.precio_proveedor * d_p.cantidad) +(0.21 * SUM(p.precio_proveedor * d_p.cantidad)) AS TOTAL 
         FROM producto AS p 
         INNER JOIN detalle_pedido AS d_p ON p.codigo_producto = d_p.codigo_producto
         INNER JOIN gama_producto AS g_pr ON p.codigo_producto = g_pr.codigo_producto
         WHERE g_pr.descripcion_gama_producto LIKE 'Or%'
         GROUP BY d_p.codigo_producto;
         
         +-----------------+----------------+---------+---------+
         | codigo_producto | BASE_IMPONIBLE | IVA     | TOTAL   |
         +-----------------+----------------+---------+---------+
         |               1 |          50.00 | 10.5000 | 60.5000 |
         +-----------------+----------------+---------+---------+
    ```

    

18. Lista las ventas totales de los productos que hayan facturado más de 3000
    euros. Se mostrará el nombre, unidades vendidas, total facturado y total
    facturado con impuestos (21% IVA).

    ```mysql
       SELECT p.nombre_producto,SUM(d_p.cantidad) AS UNIDADES_VENDIDAS,SUM(p.precio_venta * d_p.cantidad) AS FACTURADO , 0.21 * SUM(p.precio_proveedor * d_p.cantidad) AS CON_IVA 
      FROM producto AS p 
      INNER JOIN detalle_pedido AS d_p ON p.codigo_producto = d_p.codigo_producto
      GROUP BY d_p.codigo_producto
      HAVING SUM(p.precio_venta * d_p.cantidad) > 30;
      
      +------------------------------------+-------------------+-----------+---------+
      | nombre_producto                    | UNIDADES_VENDIDAS | FACTURADO | CON_IVA |
      +------------------------------------+-------------------+-----------+---------+
      | Mi vaquita                         |                 5 |     75.00 | 10.5000 |
      | EcoFresh Toothpaste                |                 3 |     90.00 | 12.6000 |
      | Rustic Wooden Snowflake Deco       |                 2 |     40.00 |  6.3000 |
      | GlowBloom Facial Serum             |                 1 |     40.00 |  5.2500 |
      | SwiftCharge Power Bank             |                 4 |     40.00 |  6.7200 |
      | Charming Garden Wind Chime         |                 1 |     50.00 |  7.3500 |
      | La guerra de troya                 |                 3 |     75.00 | 11.3400 |
      | Golden Filigree Christmas Ornament |                 5 |     93.75 | 15.7500 |
      | MindfulMeditation App              |                 1 |     40.00 |  6.3000 |
      +------------------------------------+-------------------+-----------+---------+
    ```

    

19. Muestre la suma total de todos los pagos que se realizaron para cada uno
    de los años que aparecen en la tabla pagos.

    ```mysql
       SELECT YEAR(p.fecha_pago) AS AÑO,SUM(p.total_pago) AS TOTAL
      FROM pago AS p
      GROUP BY YEAR(p.fecha_pago);
      
      +------+--------+
      | AÑO  | TOTAL  |
      +------+--------+
      | 2008 | 740.00 |
      | 2009 | 380.00 |
      | 2024 | 500.00 |
      | 2022 | 300.00 |
      +------+--------+
    ```

    



### Subconsultas

###### Con operadores básicos de comparación

1. Devuelve el nombre del cliente con mayor límite de crédito.

   ```mysql
      SELECT in_c.nombre_cliente,c.limite_credito
      FROM cliente AS c
      INNER JOIN info_cliente AS in_c ON c.codigo_cliente = in_c.codigo_cliente
      ORDER BY c.limite_credito DESC
      LIMIT 1;
      
      +----------------+----------------+
      | nombre_cliente | limite_credito |
      +----------------+----------------+
      | Rosa           |        3500.00 |
      +----------------+----------------+
   ```

   

2. Devuelve el nombre del producto que tenga el precio de venta más caro.

   ```mysql
      SELECT nombre_producto,precio_venta
      FROM producto
      ORDER BY precio_venta DESC
      LIMIT 1;
      
      +----------------------------+--------------+
      | nombre_producto            | precio_venta |
      +----------------------------+--------------+
      | Charming Garden Wind Chime |        50.00 |
      +----------------------------+--------------+
   ```

   

3. Devuelve el nombre del producto del que se han vendido más unidades.
    (Tenga en cuenta que tendrá que calcular cuál es el número total de
    unidades que se han vendido de cada producto a partir de los datos de la
    tabla detalle_pedido)

  ```mysql
      SELECT p.nombre_producto
      FROM producto AS p
      INNER JOIN detalle_pedido AS dp ON p.codigo_producto = dp.codigo_producto
      ORDER BY dp.cantidad DESC
      LIMIT 1;
      
      +-----------------+
      | nombre_producto |
      +-----------------+
      | Mi vaquita      |
      +-----------------+
  ```

  

4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
    realizado. (Sin utilizar INNER JOIN).

  ```mysql
     SELECT c.codigo_cliente,c.limite_credito
      FROM cliente AS c
      WHERE c.limite_credito > (
          SELECT COALESCE(SUM(total_pago), 0)FROM pago AS p WHERE p.codigo_cliente = c.codigo_cliente)
      ORDER BY c.limite_credito DESC
      LIMIT 1;
      
      +----------------+----------------+
      | codigo_cliente | limite_credito |
      +----------------+----------------+
      |             10 |        3500.00 |
      +----------------+----------------+
  ```

  

5. Devuelve el producto que más unidades tiene en stock.

   ```mysql
      SELECT p.codigo_producto,p.cantidad_stock
      FROM producto AS p
      ORDER BY p.cantidad_stock DESC
      LIMIT 1;
      
      +-----------------+----------------+
      | codigo_producto | cantidad_stock |
      +-----------------+----------------+
      |               1 |            160 |
      +-----------------+----------------+
   ```

   

6. Devuelve el producto que menos unidades tiene en stock.

   ```mysql
      SELECT p.codigo_producto,p.cantidad_stock
      FROM producto AS p
      ORDER BY p.cantidad_stock ASC
      LIMIT 1;

       +-----------------+----------------+
      | codigo_producto | cantidad_stock |
      +-----------------+----------------+
      |               5 |             20 |
      +-----------------+----------------+
   ```

   

7. Devuelve el nombre, los apellidos y el email de los empleados que están a
    cargo de Alberto Soria.

  ```mysql
     SELECT con_e.nombre_empleado,con_e.apellido1_empleado,con_e.apellido2_empleado,con_e.email_empleado
      FROM empleado AS e
      INNER JOIN contacto_empleado AS con_e ON con_e.codigo_empleado = e.codigo_empleado
      INNER JOIN jefe AS j ON j.codigo_jefe = e.codigo_jefe
      WHERE j.nombre_jefe LIKE '%Alberto%' AND j.apellido1_jefe LIKE '%Soria%';
      
      +-----------------+--------------------+--------------------+-------------------+
      | nombre_empleado | apellido1_empleado | apellido2_empleado | email_empleado    |
      +-----------------+--------------------+--------------------+-------------------+
      | Luis Fernando   | Gómez              | Vázquez            | luis@example.com  |
      | Jorge Emilio    | Gutiérrez          | Hernández          | jorge@example.com |
      +-----------------+--------------------+--------------------+-------------------+
  ```

  ###### Subconsultas con ALL y ANY  

8. Devuelve el nombre del cliente con mayor límite de crédito.

   ```mysql
      SELECT in_c.nombre_cliente, c.limite_credito
      FROM cliente AS c
      INNER JOIN info_cliente AS in_c ON c.codigo_cliente = in_c.codigo_cliente
      WHERE c.limite_credito >= ALL (SELECT limite_credito FROM cliente)
      LIMIT 1;

      +----------------+----------------+
      | nombre_cliente | limite_credito |
      +----------------+----------------+
      | Rosa           |        3500.00 |
      +----------------+----------------+
   ```

   

9. Devuelve el nombre del producto que tenga el precio de venta más caro.

   ```mysql
      SELECT nombre_producto,precio_venta
      FROM producto
      WHERE precio_venta >= ALL (SELECT precio_venta FROM producto)
      LIMIT 1;
      
      +----------------------------+--------------+
      | nombre_producto            | precio_venta |
      +----------------------------+--------------+
      | Charming Garden Wind Chime |        50.00 |
      +----------------------------+--------------+
   ```

   

10. Devuelve el producto que menos unidades tiene en stock.

    ```mysql
       SELECT p.codigo_producto,p.cantidad_stock
      FROM producto AS p
      WHERE p.cantidad_stock <= ALL (SELECT cantidad_stock FROM producto)
      LIMIT 1;
      
      +-----------------+----------------+
      | codigo_producto | cantidad_stock |
      +-----------------+----------------+
      |               5 |             20 |
      +-----------------+----------------+
    ```


    ###### Subconsultas con IN y NOT IN    

11. Devuelve el nombre, apellido1 y cargo de los empleados que no
    representen a ningún cliente.

    ```mysql
       SELECT codigo_empleado,(SELECT nombre_empleado FROM contacto_empleado WHERE empleado.codigo_empleado = contacto_empleado.codigo_empleado) AS nombre,(SELECT apellido1_empleado FROM contacto_empleado                WHERE empleado.codigo_empleado = contacto_empleado.codigo_empleado) AS apellido,empleado.puesto
      FROM empleado
      WHERE codigo_empleado NOT IN (
          SELECT DISTINCT codigo_empleado_repventas
          FROM cliente
          WHERE codigo_empleado_repventas IS NOT NULL
      );
      
      +-----------------+----------------+------------+---------------+
      | codigo_empleado | nombre         | apellido   | puesto        |
      +-----------------+----------------+------------+---------------+
      |               1 | Juan           | Hernández  | Gerente       |
      |               2 | María Elena    | Sánchez    | Analista      |
      |               3 | Pedro Luis     | González   | Asistente     |
      |               5 | Sara Alejandra | García     | Asistente     |
      |               6 | NULL           | NULL       | Administrador |
      |               9 | Jorge Emilio   | Gutiérrez  | Desarrollador |
      |              10 | Rosa María     | Martínez   | Asistente     |
      +-----------------+----------------+------------+---------------+
    ```

    

12. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

    ```mysql
       SELECT DISTINCT c.codigo_cliente
      FROM cliente AS c
      INNER JOIN pedido AS p ON c.codigo_cliente = p.codigo_cliente
      WHERE c.codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente FROM pago);
      
      +----------------+
      | codigo_cliente |
      +----------------+
      |              3 |
      |              6 |
      +----------------+
    ```

    

13. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

    ```mysql
       SELECT DISTINCT c.codigo_cliente
      FROM cliente AS c
      INNER JOIN pedido AS p ON c.codigo_cliente = p.codigo_cliente
      WHERE c.codigo_cliente IN (SELECT DISTINCT codigo_cliente FROM pago);
      
      +----------------+
      | codigo_cliente |
      +----------------+
      |              1 |
      |              2 |
      |              4 |
      |              5 |
      |              7 |
      |              8 |
      |              9 |
      |             10 |
      +----------------+
    ```

    

14. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

    ```mysql
       SELECT p.codigo_producto
      FROM producto AS p
      WHERE codigo_producto NOT IN (SELECT pe.codigo_producto FROM pedido AS pe);
      
      +-----------------+
      | codigo_producto |
      +-----------------+
      |               2 |
      |               6 |
      |               8 |
      +-----------------+
    ```

    

15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
    empleados que no sean representante de ventas de ningún cliente.

    ```mysql
       SELECT e.puesto,(SELECT nombre_empleado FROM contacto_empleado AS c_e WHERE e.codigo_empleado = c_e.codigo_empleado) AS nombre,(SELECT apellido1_empleado FROM contacto_empleado AS c_e WHERE                         e.codigo_empleado = c_e.codigo_empleado) AS apellido,(SELECT telefono_oficina FROM contacto_oficina AS c_of WHERE e.codigo_oficina = c_of.codigo_oficina) AS telefono_oficina
      FROM empleado AS e
      WHERE e.codigo_empleado NOT IN (SELECT DISTINCT codigo_empleado_repventas FROM cliente WHERE codigo_empleado_repventas IS NOT NULL);
       
      +---------------+----------------+------------+------------------+
      | puesto        | nombre         | apellido   | telefono_oficina |
      +---------------+----------------+------------+------------------+
      | Gerente       | Juan           | Hernández  | 555-123-456      |
      | Analista      | María Elena    | Sánchez    | 555-123-456      |
      | Asistente     | Pedro Luis     | González   | 555-987-654      |
      | Asistente     | Sara Alejandra | García     | 555-321-987      |
      | Administrador | NULL           | NULL       | NULL             |
      | Desarrollador | Jorge Emilio   | Gutiérrez  | NULL             |
      | Asistente     | Rosa María     | Martínez   | 555-789-123      |
      +---------------+----------------+------------+------------------+
    ```

    

16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

    ```mysql
    
    ```

    

17. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

    ```mysql
       SELECT DISTINCT c.codigo_cliente
       FROM cliente AS c
       INNER JOIN pedido AS p ON c.codigo_cliente = p.codigo_cliente
       WHERE c.codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente FROM pago);
         
         +----------------+
         | codigo_cliente |
         +----------------+
         |              3 |
         |              6 |
         +----------------+
    ```

    

###### Subconsultas con EXISTS y NOT EXISTS

18. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

    ```mysql
       SELECT DISTINCT codigo_cliente
      FROM cliente AS c
      WHERE NOT EXISTS (SELECT 1 FROM pago AS p WHERE p.codigo_cliente = c.codigo_cliente);
      
      +----------------+
      | codigo_cliente |
      +----------------+
      |              3 |
      |              6 |
      +----------------+
    ```

    

19. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

    ```mysql
       SELECT DISTINCT codigo_cliente
      FROM cliente AS c
      WHERE  EXISTS (SELECT 1 FROM pago AS p WHERE p.codigo_cliente = c.codigo_cliente);
      
      +----------------+
      | codigo_cliente |
      +----------------+
      |              1 |
      |              2 |
      |              4 |
      |              5 |
      |             10 |
      |              7 |
      |              8 |
      |              9 |
      +----------------+
    ```

    

20. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

    ```mysql
       SELECT DISTINCT codigo_producto
      FROM producto AS p
      WHERE  NOT EXISTS (SELECT 1 FROM pedido AS pe WHERE p.codigo_producto = pe.codigo_producto);
      
      +-----------------+
      | codigo_producto |
      +-----------------+
      |               2 |
      |               6 |
      |               8 |
      +-----------------+
    ```

    

21. Devuelve un listado de los productos que han aparecido en un pedido
    alguna vez.

    ```mysql
          SELECT DISTINCT codigo_producto
         FROM producto AS p
         WHERE  EXISTS (SELECT 1 FROM pedido AS pe WHERE p.codigo_producto = pe.codigo_producto);
         
         +-----------------+
         | codigo_producto |
         +-----------------+
         |               1 |
         |               3 |
         |               4 |
         |               5 |
         |               7 |
         |               9 |
         |              10 |
         +-----------------+
    ```

    ###### Subconsultas correlacionadas

    

    ### Consultas variadas

    1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
       pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
       han realizado ningún pedido.

    ```mysql
       SELECT in_c.nombre_cliente,COUNT(pe.codigo_pedido) AS cantidad_pedidos
      FROM info_cliente AS in_c
      INNER JOIN pedido AS pe ON in_c.codigo_cliente = pe.codigo_cliente
      GROUP BY in_c.nombre_cliente;
      
      +----------------+------------------+
      | nombre_cliente | cantidad_pedidos |
      +----------------+------------------+
      | Juan           |                2 |
      | María          |                2 |
      | Pedro          |                1 |
      | Ana            |                1 |
      | Sara           |                1 |
      | Carla          |                1 |
      | Rosa           |                1 |
      +----------------+------------------+
    ```

    

    2. Devuelve un listado con los nombres de los clientes y el total pagado por
       cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
       realizado ningún pago.

       ```mysql
          SELECT in_c.nombre_cliente,in_c.codigo_cliente,SUM(p.total_pago) AS total_pagado
            FROM info_cliente AS in_c 
            INNER JOIN pago AS p ON in_c.codigo_cliente = p.codigo_cliente
            GROUP BY  in_c.nombre_cliente,in_c.codigo_cliente;
            
            +----------------+----------------+--------------+
            | nombre_cliente | codigo_cliente | total_pagado |
            +----------------+----------------+--------------+
            | Juan           |              1 |       250.00 |
            | María          |              2 |       200.00 |
            | Ana            |              4 |       180.00 |
            | Sara           |              5 |       220.00 |
            | Rosa           |             10 |       370.00 |
            | Luis           |              7 |       190.00 |
            | Carla          |              8 |       210.00 |
            +----------------+----------------+--------------+
       ```

       

    3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
       ordenados alfabéticamente de menor a mayor.

       ```mysql
          SELECT in_c.codigo_cliente,in_c.nombre_cliente
         FROM info_cliente AS in_c
         INNER JOIN pedido AS p ON in_c.codigo_cliente = p.codigo_cliente
         WHERE YEAR(fecha_pedido) = '2008'
         ORDER BY in_c.nombre_cliente ASC;
         
         +----------------+----------------+
         | codigo_cliente | nombre_cliente |
         +----------------+----------------+
         |              1 | Juan           |
         |              6 | Pablo          |
         +----------------+----------------+
       ```

       

    4. Devuelve el nombre del cliente, el nombre y primer apellido de su
       representante de ventas y el número de teléfono de la oficina del
       representante de ventas, de aquellos clientes que no hayan realizado ningún
       pago.

    ```mysql
       SELECT in_c.nombre_cliente,c_e.nombre_empleado,c_e.apellido1_empleado,con_o.telefono_oficina
      FROM info_cliente AS in_c
      INNER JOIN cliente AS c ON c.codigo_cliente = in_c.codigo_cliente
      INNER JOIN empleado AS e ON c.codigo_empleado_repventas = e.codigo_empleado
      INNER JOIN contacto_empleado AS c_e ON e.codigo_empleado = c_e.codigo_empleado 
      INNER JOIN contacto_oficina AS con_o ON e.codigo_oficina = con_o.codigo_oficina;
      
      +----------------+-----------------+--------------------+------------------+
      | nombre_cliente | nombre_empleado | apellido1_empleado | telefono_oficina |
      +----------------+-----------------+--------------------+------------------+
      | Carla          | Ana Sofía       | Pérez              | 555-987-654      |
      | Juan           | Luis Fernando   | Gómez              | 555-456-789      |
      | Jorge          | Luis Fernando   | Gómez              | 555-456-789      |
      | Ana            | Pablo Javier    | López              | 555-456-789      |
      | Pablo          | Pablo Javier    | López              | 555-456-789      |
      +----------------+-----------------+--------------------+------------------+
    ```

    

    5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
       nombre y primer apellido de su representante de ventas y la ciudad donde
       está su oficina.

       ```mysql
           SELECT in_c.nombre_cliente,c_e.nombre_empleado,c_e.apellido1_empleado,ciu_o.nombre_ciudad_oficina
            FROM info_cliente AS in_c
            INNER JOIN cliente AS c ON c.codigo_cliente = in_c.codigo_cliente
            INNER JOIN empleado AS e ON c.codigo_empleado_repventas = e.codigo_empleado
            INNER JOIN contacto_empleado AS c_e ON e.codigo_empleado = c_e.codigo_empleado 
            INNER JOIN ciudad_oficina AS ciu_o ON e.codigo_oficina = ciu_o.codigo_oficina;
            
            +----------------+-----------------+--------------------+-----------------------+
            | nombre_cliente | nombre_empleado | apellido1_empleado | nombre_ciudad_oficina |
            +----------------+-----------------+--------------------+-----------------------+
            | Carla          | Ana Sofía       | Pérez              | New york              |
            | Juan           | Luis Fernando   | Gómez              | Sevilla               |
            | Jorge          | Luis Fernando   | Gómez              | Sevilla               |
            | Ana            | Pablo Javier    | López              | Sevilla               |
            | Pablo          | Pablo Javier    | López              | Sevilla               |
            +----------------+-----------------+--------------------+-----------------------+
       ```

       

    6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
       empleados que no sean representante de ventas de ningún cliente.

    ```mysql
    SELECT ce.nombre_empleado,c.codigo_empleado_repventas,ce.apellido1_empleado,e.puesto,co.telefono_oficina
    FROM contacto_empleado AS ce
    INNER JOIN empleado AS e ON ce.codigo_empleado = e.codigo_empleado
    LEFT JOIN cliente AS c ON e.codigo_empleado = c.codigo_empleado_repventas
    INNER JOIN contacto_oficina AS co ON e.codigo_oficina = co.codigo_oficina
    WHERE c.codigo_empleado_repventas IS NULL;
    
    +-----------------+---------------------------+--------------------+-----------+------------------+
    | nombre_empleado | codigo_empleado_repventas | apellido1_empleado | puesto    | telefono_oficina |
    +-----------------+---------------------------+--------------------+-----------+------------------+
    | María Elena     |                      NULL | Sánchez            | Analista  | 555-123-456      |
    | Juan            |                      NULL | Hernández          | Gerente   | 555-123-456      |
    | Pedro Luis      |                      NULL | González           | Asistente | 555-987-654      |
    | Sara Alejandra  |                      NULL | García             | Asistente | 555-321-987      |
    | Rosa María      |                      NULL | Martínez           | Asistente | 555-789-123      |
    +-----------------+---------------------------+--------------------+-----------+------------------+
    ```
    
    
    
    7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
       número de empleados que tiene.
    
       ```mysql
          SELECT ciu_o.nombre_ciudad_oficina,count(DISTINCT e.codigo_empleado) AS empleados,e.codigo_oficina
         FROM ciudad_oficina AS ciu_o
         INNER JOIN empleado AS e ON ciu_o.codigo_oficina = e.codigo_oficina
         GROUP BY ciu_o.nombre_ciudad_oficina,e.codigo_oficina;
         
         +-----------------------+-----------+----------------+
         | nombre_ciudad_oficina | empleados | codigo_oficina |
         +-----------------------+-----------+----------------+
         | Ciudad de México      |         2 |              1 |
         | Colonia               |         1 |              5 |
         | Fuenlabrada           |         1 |              3 |
         | New york              |         2 |              2 |
         | Sevilla               |         2 |              4 |
         +-----------------------+-----------+----------------+
       ```
    
       
