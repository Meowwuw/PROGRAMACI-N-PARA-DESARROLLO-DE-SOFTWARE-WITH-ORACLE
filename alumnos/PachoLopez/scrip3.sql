
---------------------------------------------------------------
-- EJERCICIO 1. Las funciones de agregado --
---------------------------------------------------------------
-- Ojo:  COUNT(*) cuenta todas las filas. COUNT(columna) ignora los NULL.
-- Esa diferencia va a importar cuando lleguemos al LEFT JOIN.


select count(*) from cliente;
select * from cliente;

-- Una sola fila con el resumen completo del catalogo
SELECT COUNT(*)     AS total_productos,
       AVG(precio)  AS precio_promedio,
       MAX(precio)  AS mas_caro,
       MIN(precio)  AS mas_barato,
       SUM(stock)   AS unidades_en_stock
FROM producto;

SELECT ROUND(AVG(precio), 2) AS precio_promedio FROM producto;
 
-- El promedio sale con muchos decimales. Se redondea:
SELECT ROUND(AVG(precio), 2) AS precio_promedio FROM producto;

-->>> TE TOCA A TI (1) <<<--

-- a) Cuantos clientes hay registrados?
--count()

select count(*) AS total_clientes from cliente;
from cliente;

-- b) Cual es el total de unidades vendidas en edtalle_pedido?
--Sum()

select sum(cantidad) AS total_vendidas from detalle_pedido;
from detalle_pedido;

-- c) Cuanto suma el pedido mas caro?
--     (pista: cantidad * pecio_unit, agrupado por pedido)

select id_pedido,
       sum(cantidad * precio_unit) as total_pedido
from detalle_pedido
group by id_pedido
order by total_pedido desc
limit 2;

select * from detalle_pedido;
select * from cliente limit 3;

---------------------------------------------------------------
-- EJERCICIO 2. group by --
---------------------------------------------------------------
-- La regla de oro --
-- Todo lo que pongas en el SELECT y no sea una función de agregado tiene que estar también en el GROUP BY. 
-- Si no, PostgreSQL te lo rechaza con un error muy claro. Cuando dudes, léelo: te dice exactamente qué columna falta.


SELECT categoria,
       COUNT(*)               AS cantidad,
       ROUND(AVG(precio), 2)  AS precio_promedio
FROM producto
GROUP BY categoria
ORDER BY cantidad DESC;

select * from producto;

-- Cuantos clientes tengo por ciudad?
SELECT ciudad, COUNT(*) AS clientes
FROM cliente
GROUP BY ciudad
ORDER BY clientes DESC;
 
-- Cuanto vendi de cada producto? (agrupando con JOIN)

SELECT pr.nombre,
       SUM(d.cantidad) AS unidades,
       SUM(d.cantidad * d.precio_unit) AS total
FROM detalle_pedido d
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY pr.nombre
ORDER BY total DESC;

-->>> Te toca a ti (2) <<<--
--¿Cuántos pedidos tiene cada cliente? Muestra apellido y cantidad, del que más pide al que menos.
-- JOIN

select c.apellido,
       SUM(p.id_pedido) AS cantidad_pedido
from cliente c
left join pedido p on c.id_cliente = p.id_cliente
group by c.id_cliente, c.apellido
order by cantidad_pedido desc;

select c.apellido,
       SUM(p.id_pedido) AS cantidad_pedido
from cliente c
join pedido p on c.id_cliente = p.id_cliente
group by c.id_cliente, c.apellido
order by cantidad_pedido desc;

select * from cliente;
select * from detalle_pedido;
select * from pedido;

---------------------------------------------------------------
-- EJERCICIO 3. WHERE VS HAVING --
-- WHERE filtra FILAS, antes de agrupar.
-- HAVING filtra GRUPOS, despues de agrupar.
---------------------------------------------------------------
--No puede usar funciones de agregado: cuando WHERE actúa, los grupos todavía no existen.
--Es el único lugar donde puedes escribir COUNT(*) > 1 como condición.

-- Ciudades donde tengo mas de un cliente,
-- considerando solo clientes con correo registrado

select ciudad, count(*) as clientes
from cliente
where correo is not null      -- filtra filas
group by ciudad
having count(*) > 1;          -- filtra grupos

select * from cliente;

-->>> Te toca a ti (3) <<<--
-- Preguntas reales del dueño de la tienda. Cada una se responde con una sola consulta.

-- a) ¿Qué categorías tienen más de un producto en catálogo?

select categoria
       count(*) AS total_producto
from producto
group by categoria
having count(*) > 1;

select * from producto;

-- b) ¿Qué clientes han hecho 2 o más pedidos?

select c.nombre, c.apellido, c.id_cliente,
       count(*) AS total_pedido
from cliente c
join pedido p on c.id_cliente = p.id_cliente
group by c.nombre, c.apellido, id_cliente
having count(*) >=2;

select * from pedido;
select * from cliente, detalle_pedido

-- c) ¿Qué productos han vendido más de 1 unidad en total?

select c.apellido,
       count(*) pr.id_producto, pr.nombre
from cliente c
join pedido p on c.id_cliente = p.id_cliente
group by c.apellido, pr.id_producto
having count(*) > 2;

select * from pedido;
select * from producto;

-- d) Pista para las tres:  si la condición contiene COUNT, SUM o AVG, va en el HAVING. Si no, va en el WHERE.

-- ------------------------------------------------------------
-- EJERCICIO 4. LEFT JOIN · buscar lo que NO esta
---------------------------------------------------------------

-- Clientes que NUNCA han comprado

select c.apellido, c.ciudad
from cliente c
left join pedido p ON c.id_cliente = p.id_cliente
where p.id_pedido is null;

-- Todos los clientes, con su numero de pedidos.
-- Los que nunca compraron salen con 0.

select c.apellido,
       c.ciudad,
       count(p.id_pedido) as pedidos
from cliente c
left join pedido p ON c.id_cliente = p.id_cliente
group by c.apellido, c.ciudad
order by pedidos DESC;

-- Subconsultas: una consulta dentro de otra --

--Una subconsulta es una consulta dentro de otra. Se resuelve primero la de adentro, y su resultado alimenta a la de afuera.
-- Productos que cuestan mas que el promedio del catalogo

select nombre, precio
from producto
where precio > (select avg(precio) from producto);
 
-- clientes que si han comprado, usando in
select nombre, apellido
from cliente
where id_cliente in (select id_cliente from pedido);

-- ¿Por qué no basta con WHERE precio > AVG(precio)?

-- Porque una función de agregado no puede vivir en el WHERE.
-- La subconsulta calcula el promedio aparte y devuelve un número.

-->>> Te toca a ti (4) <<<--

-- a) Cambia count(p.id_pedido) por count(*)
select c.apellido,
       c.ciudad,
       count(*) as pedidos
from cliente c
left join pedido p ON c.id_cliente = p.id_cliente
group by c.apellido, c.ciudad
order by pedidos desc;
-- b) Lista los productos que nunca se han vendido.
SELECT pr.id_producto, pr.nombre, pr.precio
from producto pr
left join detalle_pedido d on pr.id_producto = d.id_producto
where d.id_detalle is null;

-- ---------------------------------------------------------------------
-- EJERCICIO 5 · Subconsultas
-- Se resuelve primero la de adentro; su resultado alimenta la de afuera.
-- ---------------------------------------------------------------------
-- Productos que cuestan mas que el promedio del catalogo

select nombre, precio
from producto
where precio > (SELECT AVG(precio) FROM producto);

-- clientes que si han comprado, usando IN
select nombre, apellido
from cliente
where id_cliente IN (SELECT id_cliente FROM pedido);

-- ---------------------------------------------------------------------
-- RETO INTEGRADOR · esto es lo que se entrega
-- ---------------------------------------------------------------------

-- 1) El top 3 de productos mas vendidos, con unidades y total facturado.
SELECT  pr.nombre AS producto,
        sum(d.cantidad) AS total_unidades,
        sum(d.cantidad * d.precio_unit) AS total_facturado
from detalle_pedido d
join producto pr ON d.id_producto = pr.id_producto
group by pr.id_producto, pr.nombre
order by total_unidades desc
limit 3;

-- 2) Los clientes que han gastado mas que el promedio de gasto
--    de todos los clientes.
select c.id_cliente,
       c.nombre,
       c.apellido,
       sum(d.cantidad * d.precio_unit) AS total_gastado
from cliente c
join pedido p on c.id_cliente = p.id_cliente
join detalle_pedido d on p.id_pedido = d.id_pedido
group by c.id_cliente, c.nombre, c.apellido
having sum(d.cantidad * d.precio_unit) > (
    select avg(total_cliente)
    from (
        select sum(d2.cantidad * d2.precio_unit) AS total_cliente
        from pedido p2
        join detalle_pedido d2 ON p2.id_pedido = d2.id_pedido
        group by p2.id_cliente
    ) subconsulta
);

-- 3) Las categorias que aun no han vendido ni una sola unidad.
select distinct pr.categoria
from producto pr
where pr.categoria not in (
    select distinct pr2.categoria
    from detalle_pedido d
    join producto pr2 ON d.id_producto = pr2.id_producto
    where pr2.categoria is not null
);

-- ---------------------------------------------------------------------
-- ANEXO · el sorteo de equipos (lo ejecuta la instructora)
-- ---------------------------------------------------------------------
-- SELECT schema_name AS aprendiz,
--        NTILE(5) OVER (ORDER BY random()) AS equipo
-- FROM information_schema.schemata
-- WHERE schema_name LIKE 'a\_%'
-- ORDER BY equipo, aprendiz;
