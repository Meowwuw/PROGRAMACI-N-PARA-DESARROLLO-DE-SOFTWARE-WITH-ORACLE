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
select nombre, precio from producto where precio > 500 ;

-- A2. Productos que no tienen stock.
select nombre, stock from producto where stock = 0;

-- A3. Pedidos que NO estan cancelados.
--     Usa <>, no uses = tres veces.
select * from pedido;
select * from detalle_pedido;
select id_pedido ,estado from pedido where estado <> 'CANCELADO';

-- A4. Productos con precio entre 100 y 800, ordenados del mas barato
--     al mas caro.
select * from producto;
select nombre, precio from producto pedido WHERE precio >= 100 AND precio <= 800
ORDER BY precio ASC;

-- A5. Pedidos hechos durante agosto de 2026.
select * from pedido;
select * from pedido where fecha between '2026-08-01' and '2026-08-31';

-- A6. Productos por reponer: los que tienen entre 1 y 10 unidades.
select * from producto;
select nombre, stock from producto where stock >1 and stock < 10;


-- =====================================================================
-- GRUPO B · IN Y LIKE                  (ejercicios 7 al 12)
-- =====================================================================

-- B7. Clientes de Huanuco, Lima o Pucallpa.
--     Escribela primero con OR y despues con IN. Compara cual se lee mejor.
select * from cliente;
select nombre, apellido , ciudad from cliente where ciudad = 'Lima' or ciudad = 'Huanuco' or ciudad = 'Pucallpa';
select nombre , ciudad from cliente where ciudad in ('Huanuco' , 'Pucallpa');

-- B8. Pedidos que estan PENDIENTE o ENTREGADO.
SELECT * 
FROM pedido 
WHERE estado IN ('PENDIENTE', 'ENTREGADO');

-- B9. Productos que NO son de Computo ni de Monitores.
--     Ojo con el resultado: revisa si aparece la Alfombrilla Michi XL.
--     Si no aparece, piensa por que y anotalo aqui.
--     RESPUESTA:
SELECT * 
FROM producto 
WHERE categoria NOT IN ('Computo', 'Monitores');

-- B10. Clientes cuyo correo es de Gmail.
select * from cliente;
select nombre, correo from cliente where correo like '%@gmail.com';

-- B11. Clientes cuyo apellido empieza con Q, sin importar mayusculas.
select * from cliente where apellido ilike 'Q%';

-- B12. Productos cuyo nombre contiene "Michi", en cualquier posicion.
select * from producto where nombre like '%Michi%';

-- =====================================================================
-- GRUPO C · NULL Y COMBINACIONES       (ejercicios 13 al 18)
-- =====================================================================

-- C13. Clientes que no tienen correo registrado.
select * from cliente; 
select * from cliente where telefono is not null;

-- C14. Clientes que si tienen telefono.
select * from cliente where telefono is not null;

-- C15. Ejecuta esto:
--        SELECT * FROM cliente WHERE correo = NULL;
--      Devuelve cero filas aunque SI hay clientes sin correo.
--      Escribe aqui por que:
--      RESPUESTA:
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
SELECT id_pedido, 
       p.fecha, 
       c.apellido, 
       c.ciudad
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente 
WHERE p.fecha BETWEEN '2026-08-01' AND '2026-08-31';
-- D20. Detalle del pedido 20: nombre del producto, cantidad,
--      precio cobrado y subtotal (cantidad * precio_unit).
SELECT prod.nombre AS producto,
       dp.cantidad,
       dp.precio_unit AS precio_cobrando
FROM detalle_pedido dp 
JOIN producto prod ON dp.id_producto = prod.id_producto
WHERE dp.id_pedido = 20;

select * from detalle_pedido;
select * from pedido;
select * from producto;

-- D21. Pedidos de clientes de Lima que no esten cancelados.
select p.id_pedido,
		c.nombre,
		c.apellido,
		c.ciudad,
		p.estado
from pedido p
join cliente c on p.id_cliente = c.id_cliente 
where c.ciudad = 'Lima'
	and p.estado <> 'CANCELADO';

-- D22. Ventas donde el precio cobrado fue DISTINTO del precio actual
--      del producto. Muestra producto, precio_unit y precio.
--      Esto es el precio historico del que hablamos: no es un error.
select 
	p.nombre as producto,
	dp.precio_unit as precio_cobrado,
	p.precio as precio_actual
from detalle_pedido dp
join producto p on dp.id_producto = p.id_producto
where dp.precio_unit <> p.precio;
-- D23. Clientes que nunca han hecho un pedido.
--      Pista: LEFT JOIN y IS NULL.
select 
	c.id_cliente,
	c.nombre,
	c.apellido,
	c.ciudad
from cliente c
left join pedido p on c.id_cliente = p.id_cliente
where  p.id_pedido is null;

-- D24. Productos que nunca se han vendido.
-- D24. Productos que nunca se han vendido.
SELECT 
    p.id_producto,
    p.nombre,
    p.categoria,
    p.precio
FROM producto p
LEFT JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
WHERE dp.id_producto IS NULL;

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
