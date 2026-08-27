
-------------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- EJERCICIO 1 · FUNCIONES DE AGREGADO
-- Muchas filas entran, un solo valor sale.
-- ---------------------------------------------------------------------
SELECT COUNT(*)     AS total_productos,
       AVG(precio)  AS precio_promedio,
       MAX(precio)  AS mas_caro,
       MIN(precio)  AS mas_barato,
       SUM(stock)   AS unidades_en_stock
FROM producto;

-- El promedio sale con muchos decimales. Se redondea:
SELECT ROUND(AVG(precio), 2) AS precio_promedio FROM producto;

-- >>> TE TOCA A TI (1):
-- a) Cuantos clientes hay registrados?
select COUNT(*) as cantidad_clientes from cliente

-- b) Cual es el total de unidades vendidas en detalle_pedido?
select sum(cantidad) as cantidad from detalle_pedido

-- c) Cuanto suma el pedido mas caro?
--    (pista: cantidad * precio_unit, agrupado por pedido)

select id_pedido,
		sum(cantidad * precio_unit) as total_precio
from detalle_pedido
group by id_pedido
order by total_precio desc

-- ---------------------------------------------------------------------
-- EJERCICIO 2 · GROUP BY
-- Regla de oro: todo lo que va en el SELECT y no es funcion de
-- agregado, tiene que estar tambien en el GROUP BY.
-- ---------------------------------------------------------------------
SELECT categoria,
       COUNT(*)               AS cantidad,
       ROUND(AVG(precio), 2)  AS precio_promedio
FROM producto
GROUP BY categoria
ORDER BY cantidad DESC;

-- Cuantos clientes tengo por ciudad?
SELECT ciudad, COUNT(*) AS clientes
FROM cliente
GROUP BY ciudad
ORDER BY clientes DESC;

-- Cuanto vendi de cada producto? (GROUP BY combinado con JOIN)
SELECT pr.nombre,
       SUM(d.cantidad)                 AS unidades,
       SUM(d.cantidad * d.precio_unit) AS total
FROM detalle_pedido d
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY pr.nombre
ORDER BY total DESC;

-- >>> TE TOCA A TI (2):
-- Cuantos pedidos tiene cada cliente? Muestra apellido y cantidad,
-- del que mas pide al que menos.

SELECT c.apellido,
	   COUNT(p.id_cliente) as pedido
FROM detalle_pedido d
join pedido p on d.id_pedido = p.id_pedido
JOIN cliente c ON p.id_cliente = c.id_cliente
GROUP BY c.apellido
order by pedido desc;


-- EJERCICIO 3 · WHERE vs HAVING
-- WHERE filtra FILAS, antes de agrupar.
-- HAVING filtra GRUPOS, despues de agrupar.
-- ---------------------------------------------------------------------
SELECT ciudad, COUNT(*) AS clientes
FROM cliente
WHERE correo IS NOT NULL      -- filtra filas
GROUP BY ciudad
HAVING COUNT(*) > 1;          -- filtra grupos

-- >>> TE TOCA A TI (3):
-- a) Que categorias tienen mas de un producto en catalogo?
select categoria,
	   count(*) as total_producot
from producto
GROUP by categoria
having count(*) > 1;


-- b) Que clientes han hecho 2 o mas pedidos?
select c.nombre,
		count(c.id_cliente) as total_pedidos
from pedido p
join cliente c on c.id_cliente = p.id_cliente
group by c.nombre
having count(*) > 1;

select nombre,
		count(p.id_cliente) as total_pedidos
from cliente c
join pedido p on p.id_cliente = c.id_cliente
group by c.nombre
having count(*) > 1;


-- c) Que productos han vendido mas de 1 unidad en total?
-- Pista: si la condicion contiene COUNT, SUM o AVG va en el HAVING.

select p.nombre,
		cantidad as total_pedidos_vendidos
from detalle_pedido d
join producto p on d.id_producto = p.id_producto
group by p.nombre, cantidad
having sum(cantidad) > 1;

-- ---------------------------------------------------------------------
-- EJERCICIO 4 · LEFT JOIN · buscar lo que NO esta
-- ---------------------------------------------------------------------
-- Clientes que NUNCA han comprado
SELECT c.apellido, c.ciudad
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

-- Todos los clientes con su numero de pedidos.
-- Los que nunca compraron salen con 0.
SELECT c.apellido,
       c.ciudad,
       COUNT(p.id_pedido) AS pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.apellido, c.ciudad
ORDER BY pedidos DESC;

SELECT c.apellido,
       c.ciudad,
       COUNT(*) AS pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.apellido, c.ciudad
ORDER BY pedidos DESC;


-- >>> TE TOCA A TI (4):
-- a) Cambia COUNT(p.id_pedido) por COUNT(*), ejecuta y explica
--    por que cambia el resultado.
	
-- La razón del porque cambia los resultados es porque en la primera sentencia COUNT(p.id_pedido) esta contando los id_pedidos, y en la segunda sentencia cuenta todos los clientes. 


-- b) Lista los productos que nunca se han vendido.

SELECT p.nombre,
       COUNT(d.cantidad) AS pedidos
FROM producto p
LEFT JOIN detalle_pedido d ON p.id_producto = d.id_producto
GROUP BY p.nombre
having count(d.cantidad) = 0;


SELECT * FROM cliente;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;
SELECT * FROM producto;


