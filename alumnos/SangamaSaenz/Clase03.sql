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

-- >>> TE TOCA A TI (1):
-- a) Cuantos clientes hay registrados?
select count(id_cliente) as total_clientes from cliente;
-- b) Cual es el total de unidades vendidas en detalle_pedido?
select sum(cantidad) as Total_unidades_vendidas from detalle_pedido;
-- c) Cuanto suma el pedido mas caro?
select id_pedido, sum(cantidad * precio_unit) as total_pedido from detalle_pedido group by id_pedido order by total_pedido desc limit 1;
--    (pista: cantidad * precio_unit, agrupado por pedido)


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
       COUNT(p.id_pedido) AS cantidad_pedidos
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.apellido
ORDER BY cantidad_pedidos DESC;

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

SELECT categoria,
       COUNT(*) AS total_productos
FROM producto
GROUP BY categoria
HAVING COUNT(*) > 1;

-- b) Que clientes han hecho 2 o mas pedidos?

SELECT c.apellido,
       COUNT(p.id_pedido) AS total_pedidos
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.apellido
HAVING COUNT(p.id_pedido) >= 2;

-- c) Que productos han vendido mas de 1 unidad en total?

SELECT pr.nombre,
       SUM(d.cantidad) AS total_unidades
FROM detalle_pedido d
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
HAVING SUM(d.cantidad) > 1;

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

SELECT c.apellido,
       c.ciudad,
       COUNT(*) AS pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.apellido, c.ciudad
ORDER BY pedidos DESC;

/*
EXPLICACIÓN (a):
- COUNT(*) cuenta filas totales. En un LEFT JOIN, si un cliente no tiene pedidos,
  igual existe 1 fila con valores NULL, por lo que COUNT(*) devuelve 1.
- COUNT(p.id_pedido) evalúa una columna específica e ignora los valores NULL, 
  por lo que devuelve 0 (el valor correcto para clientes sin compras).
*/

-- b) Lista los productos que nunca se han vendido.

SELECT pr.nombre, pr.precio
FROM producto pr
LEFT JOIN detalle_pedido d ON pr.id_producto = d.id_producto
WHERE d.id_detalle IS NULL;

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

SELECT pr.nombre,
       SUM(d.cantidad)                 AS unidades_vendidas,
       SUM(d.cantidad * d.precio_unit) AS total_facturado
FROM producto pr
JOIN detalle_pedido d ON pr.id_producto = d.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY unidades_vendidas DESC
LIMIT 3;



SELECT c.apellido, SUM(d.cantidad * d.precio_unit) AS total
FROM cliente c
JOIN pedido p USING (id_cliente)
JOIN detalle_pedido d USING (id_pedido)
GROUP BY c.id_cliente
HAVING SUM(d.cantidad * d.precio_unit) > (
    SELECT SUM(cantidad * precio_unit) / COUNT(DISTINCT p2.id_cliente)
    FROM pedido p2 
    JOIN detalle_pedido d2 USING (id_pedido)
)
ORDER BY total DESC;



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
