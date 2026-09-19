-- =====================================================================
-- CLASE 05 · TALLER DE CONSULTAS
-- 24 ejercicios sobre TecnoMichiStore + 3 sobre su proyecto
-- ---------------------------------------------------------------------
-- Antes de empezar, ejecuta 05a-base-michistore.sql
-- Todos trabajamos sobre los MISMOS datos: si tu resultado no coincide
-- con el del compañero, alguno de los dos tiene la consulta mal.
-- =====================================================================

SET search_path TO michistore;
SELECT current_schema();


-- =====================================================================
-- LOS OPERADORES DEL WHERE
-- ---------------------------------------------------------------------
--   =   <>            igual, distinto
--   <   >   <=  >=    comparar
--   BETWEEN a AND b   dentro de un rango, extremos incluidos
--   IN (a, b, c)      pertenece a una lista
--   LIKE / ILIKE      busca por patron   (% = varios, _ = uno)
--   IS NULL           el dato no existe
--   AND  OR  NOT      combinar condiciones
--
-- ILIKE ignora mayusculas. Existe en PostgreSQL, no en Oracle.
-- =====================================================================


-- =====================================================================
-- GRUPO A · COMPARACION Y RANGO        (ejercicios 1 al 6)
-- =====================================================================

-- A1. Productos que cuestan mas de 500 soles.
select * from producto;

select nombre, precio from producto where precio > 500;


-- A2. Productos que no tienen stock.
select nombre, stock from producto where stock = 0;


-- A3. Pedidos que NO estan cancelados.
--     Usa <>, no uses = tres veces.
select * from pedido;

select id_pedido, estado from pedido where estado <> 'CANCELADO';


-- A4. Productos con precio entre 100 y 800, ordenados del mas barato
--     al mas caro.

select nombre, precio from producto where precio between 100 and 800
order by precio asc;

select nombre, precio from producto where precio >= 100 and precio <= 800
order by precio asc;

-- A5. Pedidos hechos durante agosto de 2026.

select id_pedido, fecha from pedido where fecha between '2026-08-01' and '2026-08-31';


-- A6. Productos por reponer: los que tienen entre 1 y 10 unidades.
select * from producto;

select nombre, stock from producto where stock <= 0 and stock < 10;


-- =====================================================================
-- GRUPO B · IN Y LIKE                  (ejercicios 7 al 12)
-- =====================================================================

-- B7. Clientes de Huanuco, Lima o Pucallpa.
--     Escribela primero con OR y despues con IN. Compara cual se lee mejor.

select * from cliente;

select nombre, ciudad from cliente where ciudad = 'Pucallpa' or ciudad > 'Huanuco'; 

select nombre, ciudad from cliente where ciudad in ('Huanuco', 'Lima');


-- B8. Pedidos que estan PENDIENTE o ENTREGADO.

select id_pedido, estado from pedido where estado in ('PENDIENTE');


-- B9. Productos que NO son de Computo ni de Monitores.
--     Ojo con el resultado: revisa si aparece la Alfombrilla Michi XL.
--     Si no aparece, piensa por que y anotalo aqui.
--     RESPUESTA:
--	   No sale computo porque es la primera opcion que inserte, ahora lo que es 
--	   el monitor sigue saliendo porque no hay una and entre medio y haci no funciona 
--     del not in, solo permite que un producto no aparezca.

select * from producto;

select id_producto, nombre from producto where nombre not in ('Computo', 'Monitor');


-- B10. Clientes cuyo correo es de Gmail.

select nombre, correo from cliente where correo like '%gmail.com%';
select nombre, correo from cliente where correo like '%gmail.com';


-- B11. Clientes cuyo apellido empieza con Q, sin importar mayusculas.
select * from cliente;
select nombre, apellido from cliente where apellido like 'Q%';


-- B12. Productos cuyo nombre contiene "Michi", en cualquier posicion.
select nombre from producto where nombre like '%Michi%';


-- =====================================================================
-- GRUPO C · NULL Y COMBINACIONES       (ejercicios 13 al 18)
-- =====================================================================

-- C13. Clientes que no tienen correo registrado.

select * from cliente where correo is null;


-- C14. Clientes que si tienen telefono.
select * from cliente where correo is not null;


-- C15. Ejecuta esto:
--        SELECT * FROM cliente WHERE correo = NULL;
--      Devuelve cero filas aunque SI hay clientes sin correo.
--      Escribe aqui por que:
--      RESPUESTA:
--		Porque NULL no es igual ni distinto a nada, por eso para que salga las columnas que no tiene 
--		dato le ayuda un operador, el igual o confirma un dato, '= NULL' da como respuesta
-- 		a lo desconocido.
 
select * from cliente where correo = null;

-- C16. Accesorios que cuesten menos de 150 soles.
select * from producto where precio < '150';


-- C17. Productos sin stock O que cuesten mas de 2000 soles.
select * from producto where stock = 0;


-- C18. Clientes de Huanuco que tengan correo registrado.
select * from cliente;

select * from cliente 
where ciudad = 'Huanuco' and correo is not null;


-- =====================================================================
-- GRUPO D · OPERADORES CON JOIN        (ejercicios 19 al 24)
-- =====================================================================

-- D19. Pedidos de agosto con el apellido del cliente y su ciudad.

select p.id_pedido,
		p.fecha,
		c.apellido,
		c.ciudad 
from pedido p
join cliente c on p.id_pedido = c.id_cliente 
where p.fecha between '2026-08-01' and '2026-08-31';

-- D20. Detalle del pedido 20: nombre del producto, cantidad,
--      precio cobrado y subtotal (cantidad * precio_unit).

select prod.nombre as producto,
		dp.cantidad,
		dp.precio_unit as precio_cobrado,
		(dp.cantidad * dp.precio_unit) as subtotal
		from detalle_pedido dp
		join producto prod on dp.id_producto = prod.id_producto 
		where dp.id_pedido = 20;
	
-- D21. Pedidos de clientes de Lima que no esten cancelados.

select p.estado,
	c.ciudad
	from pedido p
	join cliente c on p.id_cliente = c.id_cliente 
	where c.ciudad = 'Lima' and  p.estado <> 'CANCELADO';

-- D22. Ventas donde el precio cobrado fue DISTINTO del precio actual
--      del producto. Muestra producto, precio_unit y precio.
--      Esto es el precio historico del que hablamos: no es un error.


SELECT 
    p.nombre,
    dp.precio_unit AS precio_cobrado_historico,
    p.precio AS precio_actual_producto
FROM detalle_pedido dp
JOIN producto p ON dp.id_producto = p.id_producto
WHERE dp.precio_unit <> p.precio;


-- D23. Clientes que nunca han hecho un pedido.
--      Pista: LEFT JOIN y IS NULL.
select * from pedido;
select p id_pedido,
	c nombre
from cliente c
left join pedido p
on c.id_cliente = p.id_cliente 
where p.id_pedido is null;
	
-- D24. Productos que nunca se han vendido. 
 select * from producto;

SELECT p.*
FROM producto p
LEFT JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
WHERE dp.id_producto IS NULL;


-- =====================================================================
-- ANTES DE SUBIR
-- ---------------------------------------------------------------------
-- [x] Los 24 ejercicios resueltos, cada uno debajo de su enunciado
-- [x] Las respuestas escritas de B9 y C15
-- [x] El archivo ejecuta completo, de arriba a abajo, sin errores
--
-- ENTREGA INDIVIDUAL. Cada uno sube el suyo a:
--    alumnos/apellidos/ejercicios-clase05.sql
--
-- El trabajo sobre el proyecto va en OTRO archivo, en equipo:
--    equipos/equipo-NN/consultas-proyecto.sql
-- =====================================================================
