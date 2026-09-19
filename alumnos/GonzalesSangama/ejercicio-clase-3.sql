-- =====================================================================
-- CLASE 03 · AGRUPAR Y RESUMIR
-- =====================================================================

-- ---------------------------------------------------------------------
-- PASO 0 · ARRANQUE
-- ---------------------------------------------------------------------

SELECT current_schema();

SELECT table_name
FROM information_schema.tables
WHERE table_schema = current_schema();

SELECT COUNT(*)
FROM cliente;


-- ---------------------------------------------------------------------
-- EJERCICIO 1 · FUNCIONES DE AGREGADO
-- ---------------------------------------------------------------------

SELECT COUNT(*) AS total_productos,
       AVG(precio) AS precio_promedio,
       MAX(precio) AS mas_caro,
       MIN(precio) AS mas_barato,
       SUM(stock) AS unidades_en_stock
FROM producto;

-- Promedio redondeado
SELECT ROUND(AVG(precio), 2) AS precio_promedio
FROM producto;


-- 1) ¿Cuántos clientes hay registrados?

SELECT COUNT(*) AS total_clientes
FROM cliente;


-- 2) ¿Cuál es el total de unidades vendidas en detalle_pedido?

SELECT SUM(cantidad) AS unidades_vendidas
FROM detalle_pedido;


-- 3) ¿Cuánto suma el pedido más caro?

SELECT id_pedido,
       SUM(cantidad * precio_unit) AS total_pedido
FROM detalle_pedido
GROUP BY id_pedido
ORDER BY total_pedido DESC
LIMIT 1;


-- ---------------------------------------------------------------------
-- EJERCICIO 2 · GROUP BY
-- ---------------------------------------------------------------------

-- Productos por categoría

SELECT categoria,
       COUNT(*) AS cantidad,
       ROUND(AVG(precio), 2) AS precio_promedio
FROM producto
GROUP BY categoria
ORDER BY cantidad DESC;


-- ¿Cuántos clientes tengo por ciudad?

SELECT ciudad,
       COUNT(*) AS clientes
FROM cliente
GROUP BY ciudad
ORDER BY clientes DESC;


-- ¿Cuánto vendí de cada producto?

SELECT pr.nombre,
       SUM(d.cantidad) AS unidades,
       SUM(d.cantidad * d.precio_unit) AS total
FROM detalle_pedido d
JOIN producto pr
    ON d.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY total DESC;


-- ¿Cuántos pedidos tiene cada cliente?
-- Incluye también a los clientes que nunca compraron.

SELECT c.apellido,
       COUNT(p.id_pedido) AS cantidad_pedidos
FROM cliente c
LEFT JOIN pedido p
    ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.apellido
ORDER BY cantidad_pedidos DESC;


-- ---------------------------------------------------------------------
-- EJERCICIO 3 · WHERE VS HAVING
-- ---------------------------------------------------------------------

-- Ciudades con más de un cliente,
-- considerando solo clientes con correo registrado.

SELECT ciudad,
       COUNT(*) AS clientes
FROM cliente
WHERE correo IS NOT NULL
GROUP BY ciudad
HAVING COUNT(*) > 1;


-- a) ¿Qué categorías tienen más de un producto en catálogo?

SELECT categoria,
       COUNT(*) AS cantidad_productos
FROM producto
GROUP BY categoria
HAVING COUNT(*) > 1;


-- b) ¿Qué clientes han hecho 2 o más pedidos?

SELECT c.apellido,
       COUNT(p.id_pedido) AS cantidad_pedidos
FROM cliente c
JOIN pedido p
    ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.apellido
HAVING COUNT(p.id_pedido) >= 2
ORDER BY cantidad_pedidos DESC;


-- c) ¿Qué productos han vendido más de 1 unidad en total?

SELECT p.nombre,
       SUM(dp.cantidad) AS total_vendido
FROM producto p
JOIN detalle_pedido dp
    ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
HAVING SUM(dp.cantidad) > 1
ORDER BY total_vendido DESC;


-- ---------------------------------------------------------------------
-- EJERCICIO 4 · LEFT JOIN
-- ---------------------------------------------------------------------

-- Clientes que NUNCA han comprado

SELECT c.apellido,
       c.ciudad
FROM cliente c
LEFT JOIN pedido p
    ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;


-- Todos los clientes con su número de pedidos.
-- Los que nunca compraron salen con 0.

SELECT c.apellido,
       c.ciudad,
       COUNT(p.id_pedido) AS pedidos
FROM cliente c
LEFT JOIN pedido p
    ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.apellido, c.ciudad
ORDER BY pedidos DESC;


-- ¿Qué pasa si usamos COUNT(*)?

SELECT c.apellido,
       c.ciudad,
       COUNT(*) AS pedidos
FROM cliente c
LEFT JOIN pedido p
    ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.apellido, c.ciudad
ORDER BY pedidos DESC;


-- Explicación:
-- COUNT(p.id_pedido) cuenta solamente los pedidos existentes,
-- porque los valores NULL no son contados.
-- Por eso, los clientes que nunca compraron aparecen con 0.
--
-- COUNT(*) cuenta todas las filas generadas por el LEFT JOIN,
-- incluso la fila donde el pedido es NULL.
-- Por eso, los clientes que nunca compraron aparecen con 1.


-- Productos que nunca se han vendido

SELECT p.nombre
FROM producto p
LEFT JOIN detalle_pedido dp
    ON p.id_producto = dp.id_producto
WHERE dp.id_producto IS NULL;


-- ---------------------------------------------------------------------
-- EJERCICIO 5 · SUBCONSULTAS
-- ---------------------------------------------------------------------

-- Productos que cuestan más que el promedio del catálogo

SELECT nombre,
       precio
FROM producto
WHERE precio > (
    SELECT AVG(precio)
    FROM producto
);


-- Clientes que sí han comprado

SELECT nombre,
       apellido
FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente
    FROM pedido
);


-- ---------------------------------------------------------------------
-- RETO INTEGRADOR
-- ---------------------------------------------------------------------

-- 1) Top 3 de productos más vendidos,
-- con unidades y total facturado.

SELECT p.nombre,
       SUM(dp.cantidad) AS unidades,
       SUM(dp.cantidad * dp.precio_unit) AS total_facturado
FROM producto p
JOIN detalle_pedido dp
    ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY unidades DESC
LIMIT 3;


-- 2) Clientes que han gastado más que el promedio
-- de gasto de todos los clientes.

SELECT c.nombre,
       c.apellido,
       SUM(dp.cantidad * dp.precio_unit) AS gasto_total
FROM cliente c
JOIN pedido pe
    ON c.id_cliente = pe.id_cliente
JOIN detalle_pedido dp
    ON pe.id_pedido = dp.id_pedido
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING SUM(dp.cantidad * dp.precio_unit) > (
    SELECT AVG(gasto)
    FROM (
        SELECT pe.id_cliente,
               SUM(dp.cantidad * dp.precio_unit) AS gasto
        FROM pedido pe
        JOIN detalle_pedido dp
            ON pe.id_pedido = dp.id_pedido
        GROUP BY pe.id_cliente
    ) AS gastos_clientes
)
ORDER BY gasto_total DESC;


-- 3) Categorías que aún no han vendido ni una sola unidad.

SELECT p.categoria
FROM producto p
LEFT JOIN detalle_pedido dp
    ON p.id_producto = dp.id_producto
GROUP BY p.categoria
HAVING COALESCE(SUM(dp.cantidad), 0) = 0;


-- ---------------------------------------------------------------------
-- FIN DE LA CLASE 03
-- ---------------------------------------------------------------------
