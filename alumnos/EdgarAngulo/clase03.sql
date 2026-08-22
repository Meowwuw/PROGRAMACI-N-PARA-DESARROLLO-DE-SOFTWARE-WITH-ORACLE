-- =====================================================================
-- CLASE 03  ·  Agrupar y resumir
-- Programacion para Desarrollo de Software con Oracle - Modulo 01
-- Motor de practica: PostgreSQL (Neon)  ·  Cliente: DBeaver
-- =====================================================================
-- Ejecuta bloque por bloque con Ctrl + Enter.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PASO 0 · ARRANQUE. Confirma donde estas parado.
-- ---------------------------------------------------------------------
SELECT current_schema();

SELECT table_name FROM information_schema.tables
WHERE table_schema = current_schema();

SELECT COUNT(*) FROM cliente;

SET search_path TO a_angulo;
-- Si esto falla, revisa currentSchema en Driver properties
-- o ejecuta: SET search_path TO a_tuapellido;


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

select * from detalle_pedido;
-- >>> TE TOCA A TI (1):
-- a) Cuantos clientes hay registrados?
select count(*) as total_clientes from cliente;
-- b) Cual es el total de unidades vendidas en detalle_pedido?
select  sum(cantidad) as unidades_vendidas from detalle_pedido;

-- c) Cuanto suma el pedido mas caro?
--    (pista: cantidad * precio_unit, agrupado por pedido)
select cantidad * precio_unit as pedido_caro from detalle_pedido;

select id_pedido,
	sum(cantidad * precio_unit) as total_pedido from detalle_pedido
	group by id_pedido
	order by total_pedido desc
	limit 2;

select * from cliente limit 2;


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

select c.apellido,
	count(p.id_pedido) as cantidad_pedidos
from cliente c
join pedido p on c.id_cliente = p.id_cliente
group by c.apellido
order by cantidad_pedidos desc;
	
select * from cliente;
select * from pedido;
select * from detalle_pedido;

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
select categoria, count(*) as total_productos
	from producto
	group by categoria 
	having count(*) > 1;

select * from producto;
-- b) Que clientes han hecho 2 o mas pedidos?

select c.apellido,
	count(*) as total_pedidos
	from cliente c
	group by c.apellido
	having count(*) >= 2;

select * from cliente, detalle_pedido;
-- c) Que productos han vendido mas de 1 unidad en total?
select pr.nombre,
	sum(d.cantidad) as total_unidades
	from detalle_pedido d
	join producto pr on d.id_producto = pr.id_producto
	group by pr.id_producto, pr.nombre
	having sum(d.cantidad) >1;

-- Pista: si la condicion contiene COUNT, SUM o AVG va en el HAVING.


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

select c.apellido,
	c.ciudad,
	count(*) as pedidos
	from cliente c
	left join pedido p on c.id_cliente = p.id_cliente
	group by c.apellido, c.ciudad
	order by pedidos desc;
-- b) Lista los productos que nunca se han vendido.
select pr.nombre, pr.precio
from producto pr
left join detalle_pedido d on pr.id_producto = d.id_producto
where d.id_detalle is null;


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



-- ---------------------------------------------------------------------
-- ANEXO · el sorteo de equipos (lo ejecuta la instructora)
-- ---------------------------------------------------------------------
-- SELECT schema_name AS aprendiz,
--        NTILE(5) OVER (ORDER BY random()) AS equipo
-- FROM information_schema.schemata
-- WHERE schema_name LIKE 'a\_%'
-- ORDER BY equipo, aprendiz;