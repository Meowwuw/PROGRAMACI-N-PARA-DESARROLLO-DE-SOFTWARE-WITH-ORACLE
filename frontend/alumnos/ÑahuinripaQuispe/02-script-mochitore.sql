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
 --JOIN
select c.apellido,
	count(p.id_pedido) as cantidad_pedido
from cliente c
left join pedido p on c.id_cliente = p.id_cliente 
group by c.id_cliente, c.apellido 
order by cantidad_pedido desc;

select c.apellido,
	count(p.id_pedido) as cantidad_pedido
from cliente c
join pedido p on c.id_cliente = p.id_cliente 
group by c.id_cliente, c.apellido 
order by cantidad_pedido desc;

-- ---------------------------------------------------------------------
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

 --
select * from producto;

select categoria, count(*) as total_producto
from producto 
group by categoria
having count(*) > 1;

-- b) Que clientes han hecho 2 o mas pedidos?

select c.apellido, count(*) as total_pedidos
from cliente c
join pedido p on c.id_cliente = p.id_cliente 
group by c.apellido
having count(*) >= 2;

-- c) Que productos han vendido mas de 1 unidad en total?
-- Pista: si la condicion contiene COUNT, SUM o AVG va en el HAVING.

SELECT pr.id_producto, pr.nombre AS producto, SUM(d.cantidad) AS total_unidades
FROM producto pr
JOIN detalle_pedido d ON pr.id_producto = d.id_producto
GROUP BY pr.id_producto, pr.nombre
HAVING SUM(d.cantidad) > 1;

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

-- >>> TE TOCA A TI (4):
-- a) Cambia COUNT(p.id_pedido) por COUNT(*), ejecuta y explica
--    por que cambia el resultado.

SELECT c.apellido,
       c.ciudad,
       COUNT(*) AS pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.apellido, c.ciudad
ORDER BY pedidos DESC;

 --Respuesta al ejercicio 01:
 --Si el resultado cambia porque el COUNT(*) cuenta todas las filas
 --sin importar que no tenga un valor NULL, en cambio el COUNT(id_pedido),
 --ignora todos los valores NULL y solo cuenta las filas que tiene la columna
 --especifica que tenga valor.

-- b) Lista los productos que nunca se han vendido.

select pr.id_producto, pr.nombre as producto
from producto pr
left join detalle_pedido d on pr.id_producto = d.id_producto 
where d.id_producto is null;


-- ---------------------------------------------------------------------
-- EJERCICIO 5 · SUBCONSULTAS
-- Se resuelve primero la de adentro; su resultado alimenta la de afuera.
-- ---------------------------------------------------------------------
-- Productos que cuestan mas que el promedio del catalogo
SELECT nombre, precio
FROM producto
WHERE precio > (SELECT AVG(precio) FROM producto);

-- Clientes que si han comprado, usando IN
SELECT nombre, apellido
FROM cliente
WHERE id_cliente IN (SELECT id_cliente FROM pedido);


-- ---------------------------------------------------------------------
-- RETO INTEGRADOR · esto es lo que se entrega
-- ---------------------------------------------------------------------
-- 1) El top 3 de productos mas vendidos, con unidades y total facturado.
-- 2) Los clientes que han gastado mas que el promedio de gasto
--    de todos los clientes.
-- 3) Las categorias que aun no han vendido ni una sola unidad.

-- Escribe tus respuestas aqui:

---1)

select pr.id_producto,
	pr.nombre as producto,
	sum(d.cantidad) as total_unidades,
	sum(d.cantidad * d.precio_unit) as total_facturado
from producto pr
join detalle_pedido d on pr.id_producto = d.id_producto 
group by pr.id_producto, pr.nombre
order by total_unidades desc
limit 3;

---2)

select c.id_cliente,
	c.apellido,
	sum(d.cantidad * d.precio_unit) as gasto_cliente
from cliente c
join pedido p on c.id_cliente = p.id_cliente
join detalle_pedido d on p.id_pedido = d.id_pedido 
group by c.id_cliente, c.apellido 
having sum(d.cantidad * d.precio_unit) > (
	-- Subconsulta: el promedio de dinero gastado por el cliente
		select avg(total_por_cliente)
		from(
			select sum(d2.cantidad * d2.precio_unit) as total_por_cliente
			from pedido p2
			join detalle_pedido d2 on p2.id_pedido = d2.id_pedido 
			group by p2.id_cliente 
		) as sub_promedios
);

---3)

select pr.categoria
from producto pr
left join detalle_pedido d on pr.id_producto = d.id_producto 
group by pr.categoria
having sum(d.cantidad) is null or sum(d.cantidad) = 0;
-- ---------------------------------------------------------------------
-- ANEXO · el sorteo de equipos (lo ejecuta la instructora)
-- ---------------------------------------------------------------------
-- SELECT schema_name AS aprendiz,
--        NTILE(5) OVER (ORDER BY random()) AS equipo
-- FROM information_schema.schemata
-- WHERE schema_name LIKE 'a\_%'
-- ORDER BY equipo, aprendiz;
