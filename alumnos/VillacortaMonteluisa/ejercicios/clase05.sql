-- =====================================================================
-- GRUPO A · COMPARACION Y RANGO        (ejercicios 1 al 6)
-- =====================================================================

-- A1. Productos que cuestan mas de 500 soles.
select * from producto;
select nombre, precio from producto where precio > 500 ;

-- A2. Productos que no tienen stock.
select * from producto where stock = 0;

-- A3. Pedidos que NO estan cancelados.
--     Usa <>, no uses = tres veces.
select * from pedido;
select * from detalle_pedido;
select id_pedido , estado  from pedido where estado <> 'CANCELADO';
-- A4. Productos con precio entre 100 y 800, ordenados del mas barato
--     al mas caro.
select * from producto;
select nombre, precio from producto where precio >= 100 and precio <=800
order by  precio asc;
-- A5. Pedidos hechos durante agosto de 2026.
select * from pedido;
select * from pedido where fecha  between  ´2026-08-01´ and ´2026-08-31´;
-- A6. Productos por reponer: los que tienen entre 1 y 10 unidades.
select * from producto;
select nombre, stock from producto where stock > 1 and stock < 10;
-- =====================================================================
-- GRUPO B · IN Y LIKE                  (ejercicios 7 al 12)
-- =====================================================================

-- B7. Clientes de Huanuco, Lima o Pucallpa.
--     Escribela primero con OR y despues con IN. Compara cual se lee mejor.
select * from cliente;
select nombre, apellido , ciudad from cliente where ciudad  = 'Lima' or ciudad = 'Huanuco' or ciudad = 'Pucallpa';
select nombre, ciudad   from cliente  where  ciudad  in ( 'Huanuco' , 'Pucallpa');
-- B8. Pedidos que estan PENDIENTE o ENTREGADO.
SELECT * 
FROM pedido 
WHERE estado IN ('PENDIENTE', 'ENTREGADO');

-- B9. Productos que NO son de Computo ni de Monitores.
--     Ojo con el resultado: revisa si aparece la Alfombrilla Michi XL.
--     Si no aparece, piensa por que y anotalo aqui.
--     RESPUESTA:
--No aparece la Alfombrilla Michi XL porque su columna categoria tiene un valor NULL--
-- Consulta básica con NOT IN:
SELECT * 
FROM producto 
WHERE categoria NOT IN ('Computo', 'Monitores');


-- B10. Clientes cuyo correo es de Gmail.
select * from cliente;
select nombre, correo from cliente where correo like '%gmail.com%';
-- B11. Clientes cuyo apellido empieza con Q, sin importar mayusculas.
select * from cliente where apellido ilike 'Q%';

-- B12. Productos cuyo nombre contiene "Michi", en cualquier posicion.
select * from producto where 

-- =====================================================================
-- GRUPO C · NULL Y COMBINACIONES       (ejercicios 13 al 18)
-- =====================================================================

-- C13. Clientes que no tienen correo registrado.
select * from cliente;
select * from cliente  where correo is null;
-- C14. Clientes que si tienen telefono.
select * from cliente where telefono is not null;

-- C15. Ejecuta esto:
--        SELECT * FROM cliente WHERE correo = NULL;
--      Devuelve cero filas aunque SI hay clientes sin correo.
--      Escribe aqui por que:
--      RESPUESTA:
--representa la ausencia de valor o un valor "desconocido". Por esta razón, cualquier comparación aritmética o de igualdad utilizando NULL--
select * from cliente where correo = null;

-- C16. Accesorios que cuesten menos de 150 soles.
SELECT * 
FROM producto 
WHERE categoria = 'Accesorios' 
  AND precio < 150;

-- C17. Productos sin stock O que cuesten mas de 2000 soles.
SELECT * 
FROM producto 
WHERE stock = 0 
   OR precio > 2000;

-- C18. Clientes de Huanuco que tengan correo registrado.
SELECT * 
FROM cliente 
WHERE ciudad = 'Huanuco' 
  AND correo IS NOT NULL;

-- =====================================================================
-- GRUPO D · OPERADORES CON JOIN        (ejercicios 19 al 24)
-- =====================================================================

-- D19. Pedidos de agosto con el apellido del cliente y su ciudad.
select id_pedido ,
		p fecha ,
		c apellido ,
		c ciudad 
from pedido p
join cliente c in p. id_cliente = c.id_cliente
where p.fecha between '2026-08-01' and '2026-08-31';

-- D20. Detalle del pedido 20: nombre del producto, cantidad,
--      precio cobrado y subtotal (cantidad * precio_unit).
select prod.nombre as producto
		dp.cantidad,
		dp.precio_unit as precio_cobrado,
		from detalle_pedido dp
		join producto prod on dp.id_producto = prod.id_producto 
		where dp.id_pedido = 20;

select * from detalle_pedido;
select * from pedido;
select * from producto;

-- D21. Pedidos de clientes de Lima que no esten cancelados.
SELECT p.id_pedido, 
       c.nombre, 
       c.apellido, 
       c.ciudad, 
       p.estado
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
WHERE c.ciudad = 'Lima' 
  AND p.estado <> 'CANCELADO';

-- D22. Ventas donde el precio cobrado fue DISTINTO del precio actual
--      del producto. Muestra producto, precio_unit y precio.
--      Esto es el precio historico del que hablamos: no es un error.
SELECT 
    p.nombre AS producto,
    dp.precio_unit AS precio_cobrado,
    p.precio AS precio_actual
FROM detalle_pedido dp
JOIN producto p ON dp.id_producto = p.id_producto
WHERE dp.precio_unit <> p.precio;

-- D23. Clientes que nunca han hecho un pedido.
--      Pista: LEFT JOIN y IS NULL.
SELECT 
    c.id_cliente, 
    c.nombre, 
    c.apellido, 
    c.ciudad
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

-- D24. Productos que nunca se han vendido.
SELECT 
    p.id_producto, 
    p.nombre, 
    p.categoria, 
    p.precio, 
    p.stock
FROM producto p
LEFT JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
WHERE dp.id_producto IS NULL;
