SET search_path TO a_hidalgo;
SELECT current_schema();

SELECT table_name FROM information_schema.tables
WHERE table_schema = current_schema();

SELECT COUNT(*) FROM cliente;
select * from cliente;

select avg(precio)
from producto;

-- Una sola fila con el resumen completo del catalogo
SELECT COUNT(*)     AS total_productos,
       AVG(precio)  AS precio_promedio,
       MAX(precio)  AS mas_caro,
       MIN(precio)  AS mas_barato,
       SUM(stock)   AS unidades_en_stock
FROM producto;
 
-- El promedio sale con muchos decimales. Se redondea:
SELECT ROUND(AVG(precio), 2) AS precio_promedio FROM producto;
--Te toca a ti
--1)  ¿Cuántos clientes hay registrados?    
select count(*)
from cliente;
--2)  ¿Cuál es el total de unidades vendidas en detalle_pedido?      
select sum(cantidad) as total_vedido
from detalle_pedido;
--3)  ¿Cuánto suma el pedido más caro?
select  id_pedido,
	sum(cantidad * precio_unit) as total_pedido
from detalle_pedido
group by id_pedido
order by total_pedido desc
limit 2;

- ---------------------------------------------------------------------
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
select c.apellido,
		count (p.id_pedido) as cantidad_pedidos
from cliente c
join pedido p on c.id_cliente = p.id_cliente 
group by c.apellido 
order by cantidad_pedidos desc;

-- del que mas pide al que menos.
select c.apellido,
		count (p.id_pedido) as cantidad_pedidos
from cliente c
join pedido p on c.id_cliente = p.id_cliente 
group by c.apellido 
order by cantidad_pedidos ASC;


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
select categoria, count(*) as cantidad
from  producto
where id_producto is not null 
group by categoria 
having count(*) > 1;
select * from producto;
-- b) Que clientes han hecho 2 o mas pedidos?
select c.apellido  , count(*) as can_pedidos
from cliente c
join pedido p on c.id_cliente = p.id_cliente
group by c.id_cliente, c.apellido 
having count(p.id_pedido ) >=2;
-- c) Que productos han vendido mas de 1 unidad en total?
-- Pista: si la condicion contiene COUNT, SUM o AVG va en el HAVING.
select pr.nombre,
		sum(d.cantidad) as toatal_pedidos
from detalle_pedido d
join producto pr on d.id_producto  = pr.id_producto
group by pr.id_producto, pr.nombre
having sum(d.cantidad ) > 1;


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
--COUNT(*) cuenta filas (por eso un LEFT JOIN da 1 aunque no haya compra),
-- mientras que COUNT(p.id_pedido) ignora los NULL y devuelve 0 correctamente.

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
SELECT pr.nombre,
       SUM(d.cantidad)                 AS unidades_vendidas,
       SUM(d.cantidad * d.precio_unit) AS total_facturado
FROM detalle_pedido d
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY unidades_vendidas DESC
LIMIT 3;
-- 2) Los clientes que han gastado mas que el promedio de gasto
--    de todos los clientes.
SELECT c.id_cliente,
       c.nombre,
       c.apellido,
       SUM(d.cantidad * d.precio_unit) AS total_gastado
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN detalle_pedido d ON p.id_pedido = d.id_pedido
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING SUM(d.cantidad * d.precio_unit) > (
    -- Subconsulta: calcula el promedio gastado por cliente entre todos los clientes que compraron
    SELECT AVG(total_cliente)
    FROM (
        SELECT SUM(d2.cantidad * d2.precio_unit) AS total_cliente
        FROM pedido p2
        JOIN detalle_pedido d2 ON p2.id_pedido = d2.id_pedido
        GROUP BY p2.id_cliente
    ) sub
);
-- 3) Las categorias que aun no han vendido ni una sola unidad.
SELECT pr.categoria
FROM producto pr
LEFT JOIN detalle_pedido d ON pr.id_producto = d.id_producto
GROUP BY pr.categoria
HAVING COUNT(d.id_detalle) = 0;



-- ---------------------------------------------------------------------
-- ANEXO · el sorteo de equipos (lo ejecuta la instructora)
-- ---------------------------------------------------------------------
-- SELECT schema_name AS aprendiz,
--        NTILE(5) OVER (ORDER BY random()) AS equipo
-- FROM information_schema.schemata
-- WHERE schema_name LIKE 'a\_%'
-- ORDER BY equipo, aprendiz;

