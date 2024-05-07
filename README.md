# PROYECTO BD PARTE 1

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
  
  INNER JOIN info_cliente AS in_c ON in_c.codigo_cliente = c.codigo_cliente
  WHERE p.codigo_empleado IS NULL;
  
  +-----------------+----------------+
  | codigo_empleado | nombre_cliente |
  +-----------------+----------------+
  |            NULL | Juan           |
  |            NULL | María          |
  |            NULL | Pedro          |
  |            NULL | Ana            |
  |            NULL | Sara           |
  |            NULL | Pablo          |
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

  ```sql
  
  ```

  

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

   ```sql
   
   ```

   

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
  con la ciudad de la oficina a la que pertenece el representante.

  ```sql
  
  ```

  

8. Devuelve un listado con el nombre de los empleados junto con el nombre
  de sus jefes.

  ```sql
  
  ```

  

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
  de su jefe y el nombre del jefe de sus jefe.

  ```sql
  
  ```

  

10. Devuelve el nombre de los clientes a los que no se les ha entregado a
    tiempo un pedido.

    ```sql
    
    ```

    

11. Devuelve un listado de las diferentes gamas de producto que ha comprado
    cada cliente.

    ```sql
    
    ```

    

### Consultas multitabla (Composición externa)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
LEFT JOIN y NATURAL RIGHT JOIN.

1. Devuelve un listado que muestre solamente los clientes que no han
  realizado ningún pago.

  ```mysql
  
  ```

  

2. Devuelve un listado que muestre solamente los clientes que no han
  realizado ningún pedido.

  ```mysql
  
  ```

  

3. Devuelve un listado que muestre los clientes que no han realizado ningún
  pago y los que no han realizado ningún pedido.

  ```mysql
  
  ```

  

4. Devuelve un listado que muestre solamente los empleados que no tienen
  una oficina asociada.

  ```mysql
  
  ```

  

5. Devuelve un listado que muestre solamente los empleados que no tienen un
  cliente asociado.

  ```mysql
  
  ```

  

6. Devuelve un listado que muestre solamente los empleados que no tienen un
  cliente asociado junto con los datos de la oficina donde trabajan.

  ```mysql
  
  ```

  

7. Devuelve un listado que muestre los empleados que no tienen una oficina
  asociada y los que no tienen un cliente asociado.

  ```mysql
  
  ```

  

8. Devuelve un listado de los productos que nunca han aparecido en un
  pedido.

  ```mysql
  
  ```

  

9. Devuelve un listado de los productos que nunca han aparecido en un
  pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
  producto.

  ```mysql
  
  ```

  

10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

    ```mysql
    
    ```

    

11. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

    ```mysql
    
    ```

    

12. Devuelve un listado con los datos de los empleados que no tienen clientes
    asociados y el nombre de su jefe asociado.

    ```mysql
    
    ```

    

### Consultas resumen

1. ¿Cuántos empleados hay en la compañía?

   ```mysql
   
   ```

   

2. ¿Cuántos clientes tiene cada país?

   ```mysql
   
   ```

   

3. ¿Cuál fue el pago medio en 2009?

   ```mysql
   
   ```

   

4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
  descendente por el número de pedidos.

  ```mysql
  
  ```

  

5. Calcula el precio de venta del producto más caro y más barato en una
  misma consulta.

  ```mysql
  
  ```

  

6. Calcula el número de clientes que tiene la empresa.

   ```mysql
   
   ```

   

7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

   ```mysql
   
   ```

   

8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
  por M?

  ```mysql
  
  ```

  

9. Devuelve el nombre de los representantes de ventas y el número de clientes
  al que atiende cada uno.

  ```mysql
  
  ```

  

10. Calcula el número de clientes que no tiene asignado representante de
    ventas.

    ```mysql
    
    ```

    

11. Calcula la fecha del primer y último pago realizado por cada uno de los
    clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

    ```mysql
    
    ```

    

12. Calcula el número de productos diferentes que hay en cada uno de los
    pedidos.

    ```mysql
    
    ```

    

13. Calcula la suma de la cantidad total de todos los productos que aparecen en
    cada uno de los pedidos.

    ```mysql
    
    ```

    

14. Devuelve un listado de los 20 productos más vendidos y el número total de
    unidades que se han vendido de cada uno. El listado deberá estar ordenado
    por el número total de unidades vendidas.

    ```mysql
    
    ```

    

15. La facturación que ha tenido la empresa en toda la historia, indicando la
    base imponible, el IVA y el total facturado. La base imponible se calcula
    sumando el coste del producto por el número de unidades vendidas de la
    tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
    suma de los dos campos anteriores.

    ```mysql
    
    ```

    

16. La misma información que en la pregunta anterior, pero agrupada por
    código de producto.

    ```mysql
    
    ```

    

17. La misma información que en la pregunta anterior, pero agrupada por
    código de producto filtrada por los códigos que empiecen por OR.

    ```mysql
    
    ```

    

18. Lista las ventas totales de los productos que hayan facturado más de 3000
    euros. Se mostrará el nombre, unidades vendidas, total facturado y total
    facturado con impuestos (21% IVA).

    ```mysql
    
    ```

    

19. Muestre la suma total de todos los pagos que se realizaron para cada uno
    de los años que aparecen en la tabla pagos.

    ```mysql
    
    ```

    



### Subconsultas

###### Con operadores básicos de comparación

1. Devuelve el nombre del cliente con mayor límite de crédito.

   ```mysql
   
   ```

   

2. Devuelve el nombre del producto que tenga el precio de venta más caro.

   ```mysql
   
   ```

   

3. Devuelve el nombre del producto del que se han vendido más unidades.
  (Tenga en cuenta que tendrá que calcular cuál es el número total de
  unidades que se han vendido de cada producto a partir de los datos de la
  tabla detalle_pedido)

  ```mysql
  
  ```

  

4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
  realizado. (Sin utilizar INNER JOIN).

  ```mysql
  
  ```

  

5. Devuelve el producto que más unidades tiene en stock.

   ```mysql
   
   ```

   

6. Devuelve el producto que menos unidades tiene en stock.

   ```mysql
   
   ```

   

7. Devuelve el nombre, los apellidos y el email de los empleados que están a
  cargo de Alberto Soria.

  

  ###### Subconsultas con ALL y ANY

  ```mysql
  
  ```

  

8. Devuelve el nombre del cliente con mayor límite de crédito.

   ```mysql
   
   ```

   

9. Devuelve el nombre del producto que tenga el precio de venta más caro.

   ```mysql
   
   ```

   

10. Devuelve el producto que menos unidades tiene en stock.

    

    ###### Subconsultas con IN y NOT IN

    ```mysql
    
    ```

    

11. Devuelve el nombre, apellido1 y cargo de los empleados que no
    representen a ningún cliente.

    ```mysql
    
    ```

    

12. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

    ```mysql
    
    ```

    

13. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

    ```mysql
    
    ```

    

14. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

    ```mysql
    
    ```

    

15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
    empleados que no sean representante de ventas de ningún cliente.

    ```mysql
    
    ```

    

16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

    ```mysql
    
    ```

    

17. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

    ```mysql
    
    ```

    

###### Subconsultas con EXISTS y NOT EXISTS

18. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

    ```mysql
    
    ```

    

19. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

    ```mysql
    
    ```

    

20. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

    ```mysql
    
    ```

    

21. Devuelve un listado de los productos que han aparecido en un pedido
    alguna vez.

    ```mysql
    
    ```

    ###### Subconsultas correlacionadas

    

    ### Consultas variadas

    1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
       pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
       han realizado ningún pedido.

    ```mysql
    
    ```

    

    2. Devuelve un listado con los nombres de los clientes y el total pagado por
       cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
       realizado ningún pago.

       ```mysql
       
       ```

       

    3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
       ordenados alfabéticamente de menor a mayor.

       ```mysql
       
       ```

       

    4. Devuelve el nombre del cliente, el nombre y primer apellido de su
       representante de ventas y el número de teléfono de la oficina del
       representante de ventas, de aquellos clientes que no hayan realizado ningún
       pago.

    ```mysql
    
    ```

    

    5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
       nombre y primer apellido de su representante de ventas y la ciudad donde
       está su oficina.

       ```mysql
       
       ```

       

    6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
       empleados que no sean representante de ventas de ningún cliente.

    ```mysql
    
    ```

    

    7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
       número de empleados que tiene.

       ```mysql
       
       ```

       