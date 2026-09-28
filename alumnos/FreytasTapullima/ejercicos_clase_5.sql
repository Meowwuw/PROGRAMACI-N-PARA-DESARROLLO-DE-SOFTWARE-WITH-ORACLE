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
select * from pedido where estado != 'CANCELADO';

-- A4. Productos con precio entre 100 y 800, ordenados del mas barato
--     al mas caro.

select * from producto
where precio > 100 and precio < 800
order by precio asc;

-- A5. Pedidos hechos durante agosto de 2026.

select * from pedido where fecha between '2026/08/01' and '2026/08/30';

-- A6. Productos por reponer: los que tienen entre 1 y 10 unidades.

select nombre, stock from producto where stock > 1 and stock < 10;

-- =====================================================================
-- GRUPO B · IN Y LIKE                  (ejercicios 7 al 12)
-- =====================================================================

-- B7. Clientes de Huanuco, Lima o Pucallpa.
--     Escribela primero con OR y despues con IN. Compara cual se lee mejor.

select * from cliente where ciudad = 'Huanuco' or ciudad = 'Lima' or ciudad = 'Pucallpa';

select * from cliente where ciudad in('Huanuco','Lima','Pucallpa');


-- B8. Pedidos que estan PENDIENTE o ENTREGADO.

select * from pedido where estado in('PENDIENTE','ENTREGADO');

-- B9. Productos que NO son de Computo ni de Monitores.
--     Ojo con el resultado: revisa si aparece la Alfombrilla Michi XL.
--     Si no aparece, piensa por que y anotalo aqui.
--     RESPUESTA:
select * from producto;
select * from producto where categoria not in('Computo','Monitores');
--Una de las razones del porque no aparece es porque en la categoria tiene el valor null.


-- B10. Clientes cuyo correo es de Gmail.

select * from cliente where correo like '%gmail%';

-- B11. Clientes cuyo apellido empieza con Q, sin importar mayusculas.

select * from cliente where apellido like 'Q%' or apellido Like 'q%';

-- B12. Productos cuyo nombre contiene "Michi", en cualquier posicion.
select * from cliente where apellido like '%michi' or apellido Like '%e';

-- =====================================================================
-- GRUPO C · NULL Y COMBINACIONES       (ejercicios 13 al 18)
-- =====================================================================

-- C13. Clientes que no tienen correo registrado.
select * from cliente 
where correo is null;

-- C14. Clientes que si tienen telefono.

select * from cliente 
where telefono is not null;

-- C15. Ejecuta esto:
--        SELECT * FROM cliente WHERE correo = NULL;
--      Devuelve cero filas aunque SI hay clientes sin correo.
--      Escribe aqui por que:
--      RESPUESTA:

select * from cliente where correo = null;

--La razon del porque no se puede visualizar los datos con esta sentencia es porque no se puede comparar con un valor null.


-- C16. Accesorios que cuesten menos de 150 soles.
select * from producto where categoria = 'Accesorios' and precio < 150;


-- C17. Productos sin stock O que cuesten mas de 2000 soles.

select * from producto where stock = 0 and precio > 2000;

-- C18. Clientes de Huanuco que tengan correo registrado.
select * from cliente where ciudad = 'Huanuco' and correo is not null;

-- =====================================================================
-- GRUPO D · OPERADORES CON JOIN        (ejercicios 19 al 24)
-- =====================================================================

-- D19. Pedidos de agosto con el apellido del cliente y su ciudad.

select 
	c.apellido,
	c.ciudad,
	fecha
from pedido p
join cliente c on c.id_cliente = p.id_cliente
where fecha between '2026/08/01' and '2026/08/30';


-- D20. Detalle del pedido 20: nombre del producto, cantidad,
--      precio cobrado y subtotal (cantidad * precio_unit).

select 
	p.id_pedido,
	pr.nombre,
	dp.cantidad,
	pr.precio,
	sum(dp.cantidad*dp.precio_unit) as subtotal
from detalle_pedido dp
join pedido p on p.id_pedido = dp.id_pedido
join producto pr on pr.id_producto = dp.id_producto
where p.id_pedido = 20
group by p.id_pedido,pr.nombre,dp.cantidad,pr.precio;

-- D21. Pedidos de clientes de Lima que no esten cancelados.

select
	id_pedido,
	c.apellido,
	c.ciudad,
	estado
from pedido p
join cliente c on c.id_cliente = p.id_cliente
where estado != 'CANCELADO' and c.ciudad = 'Lima';

-- D22. Ventas donde el precio cobrado fue DISTINTO del precio actual
--      del producto. Muestra producto, precio_unit y precio.
--      Esto es el precio historico del que hablamos: no es un error.

SELECT 
    pr.nombre AS producto,
    dp.precio_unit,
    pr.precio
FROM detalle_pedido dp
JOIN producto pr 
    ON pr.id_producto = dp.id_producto
WHERE dp.precio_unit != pr.precio;


-- D23. Clientes que nunca han hecho un pedido.
--      Pista: LEFT JOIN y IS NULL.

SELECT 
	c.nombre,
	c.apellido,
	c.correo,
	c.telefono,
	c.ciudad
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;


-- D24. Productos que nunca se han vendido.

SELECT p.nombre,
       COUNT(d.cantidad) AS pedidos
FROM producto p
LEFT JOIN detalle_pedido d ON p.id_producto = d.id_producto
GROUP BY p.nombre
having count(d.cantidad) = 0;


-- =====================================================================
-- ANTES DE SUBIR
-- ---------------------------------------------------------------------
-- [ ] Los 24 ejercicios resueltos, cada uno debajo de su enunciado
-- [ ] Las respuestas escritas de B9 y C15
-- [ ] El archivo ejecuta completo, de arriba a abajo, sin errores
--
-- ENTREGA INDIVIDUAL. Cada uno sube el suyo a:
--    alumnos/apellidos/ejercicios-clase05.sql
--
-- El trabajo sobre el proyecto va en OTRO archivo, en equipo:
--    equipos/equipo-NN/consultas-proyecto.sql
-- =====================================================================
