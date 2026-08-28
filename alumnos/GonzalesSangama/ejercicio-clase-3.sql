--CLASE 3 EJERCICIO EN CLASE
-- El promedio sale con muchos decimales. Se redondea:
SELECT ROUND(AVG(precio), 2) AS precio_promedio FROM producto;

--1)  ¿Cuántos clientes hay registrados?
	select count(*) as total_cliente from cliente ;

--2)  ¿Cuál es el total de unidades vendidas en detalle_pedido?      
	select sum(cantidad) as unidades_vendidas from detalle_pedido ;

select id_pedido,
	sum(cantidad * precio_unit) as total_pedido
	from detalle_pedido
	group by id_pedido
	order by total_pedido desc
	limit 2;

--3)  ¿Cuánto suma el pedido más caro?
	SELECT MAX(precio)  AS mas_caro,
       	   SUM(precio)   AS suma_del_pedido_mas_caro
	FROM producto;

select * from detalle_pedido

-- Ejercicio
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
 
-- Cuanto vendi de cada producto? (agrupando con JOIN)
SELECT pr.nombre,
       SUM(d.cantidad) AS unidades,
       SUM(d.cantidad * d.precio_unit) AS total
FROM detalle_pedido d
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY pr.nombre
ORDER BY total DESC;

--¿Cuántos pedidos tiene cada cliente? Muestra apellido y cantidad, del que más pide al que menos.
	select 
	c.apellido,
	count(p.id_pedido) as cantidad_pedidos
	from cliente c
	join pedido p on c.id_cliente = p.id_cliente
	group by c.id_cliente, c.apellido 
	order by cantidad_pedidos desc;

-- Ciudades donde tengo mas de un cliente,
-- considerando solo clientes con correo registrado
SELECT ciudad, COUNT(*) AS clientes
FROM cliente
WHERE correo IS NOT NULL      -- filtra filas
GROUP BY ciudad
HAVING COUNT(*) > 1;          -- filtra grupos

--¿Qué categorías tienen más de un producto en catálogo?
SELECT categoria, COUNT(*) AS cantidad_productos
FROM producto
WHERE nombre IS NOT NULL
GROUP BY categoria
HAVING COUNT(*) > 1;

--¿Qué clientes han hecho 2 o más pedidos?
SELECT 
    c.apellido,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.apellido
HAVING COUNT(p.id_pedido) >= 2
ORDER BY cantidad_pedidos;

--¿Qué productos han vendido más de 1 unidad en total?
SELECT 
    p.nombre,
    SUM(dp.cantidad) AS total_vendido
FROM producto p
JOIN detalle_pedido dp 
    ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
HAVING SUM(dp.cantidad) >1
ORDER BY total_vendido DESC;


-- Clientes que NUNCA han comprado
SELECT c.apellido, c.ciudad
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;


-- Todos los clientes, con su numero de pedidos.
-- Los que nunca compraron salen con 0.
SELECT c.apellido,
       c.ciudad,
       COUNT(p.id_p
       edido) AS pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.apellido, c.ciudad
ORDER BY pedidos DESC;

--¿Por qué aquí se usa COUNT(p.id_pedido) y no COUNT(*)? Cámbialo, ejecuta y explica la diferencia. Después: lista los productos que nunca se han vendido.
SELECT c.apellido,
       c.ciudad,
       COUNT(*) AS pedidos
FROM cliente c
LEFT JOIN pedido p 
    ON c.id_cliente = p.id_cliente
GROUP BY c.apellido, c.ciudad
ORDER BY pedidos DESC;

-- En el primer ejercicio usamos  COUNT(p.id_pedido) para contar los pedidos 
-- En el segundo ejercicio usamos COUNT(*) para contar clientes
