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

-- GRUPO A
-- A1. productos que cuestan mas de 500 soles
select * from  producto;
select nombre, precio from producto where precio > 500;

-- A2. Productos que no tienen stock.
select nombre, stock from producto where stock = 0;

-- A3. Pedidos que NO estan cancelados
-- 		Usa <>, no uses = tres veces
select * from pedido;
select estado from pedido where estado <> CANCELADO ;

-- A4. Productos con precio entre 100 y 800, ordenados (ASC)(DESC)
-- del mas barato al mas caro
select * from producto;
select nombre, precio from producto where precio between 100 and 800 order by precio ASC;
select nombre, precio from producto where precio >= 100 and <= 800 order by precio ASC;

-- A5. Pedidos hechos durante agosto de 2026
select * from pedido where fecha between '2026-08-01' and '2026-08-31'

-- A6. Productos por reponer: los que tienen entre 1 y 10 unidades.
select nombre, stock from producto where stock between 1 and 10;



-- GRUPO B
-- B7. Clientes de Huanuco, Lima o Pucallpa.
--     Escribela primero con OR y despues con IN. Compara cual se lee mejor.
select * from cliente;
select nombre, apellido, ciudad  from cliente where ciudad = 'Pucallpa' or ciudad = 'Huanuco' or ciudad = 'Lima';

select nombre, ciudad from cliente where ciudad in ('Huanuco', 'Pucallpa', 'Lima');

-- B8. Pedidos PENDIENTE o ENTREGADO.
select * from pedido where estado in ('PENDIENTE', 'ENTREGADO');

-- B9. Productos que NO son de Computo ni de Monitores.
--     Ojo con el resultado: revisa si aparece la Alfombrilla Michi XL.
--     Si no aparece, piensa por que y anotalo aqui.
--     RESPUESTA:
-- 	   - No aparece la Alfombrilla Michi XL porque su categoría es NULL
select * from producto where categoria not in ('Computo', 'Monitores');

-- B10. Clientes con correo de Gamil
select * from cliente;
select nombre, correo from cliente where correo like '%@gmail.com';

-- B11. Clientes cuyo apellido empieza con Q, sin importar mayúsculas.
select * from cliente where apellido ilike 'Q%';

-- B12. Productos cuyo nombre contiene 'Michi'
select * from producto where nombre like '%Michi%';


-- GRUPO C
-- C13. Clientes que no tienen correo registrado.
select * from cliente;
select * from cliente where correo is null;

-- C14. Clientes que si tienen teléfono
select * from cliente where telefono is not null;

-- C15. Ejecuta esto:
--        SELECT * FROM cliente WHERE correo = NULL;
--      Devuelve cero filas aunque SI hay clientes sin correo.
--      Escribe aqui por que:
--      RESPUESTA:
-- 		- No devuelve filas porque NULL no se compara usando =
select * from cliente where correo = null;

-- C16. Accesorios que cuesten menos de 150 soles
select nombre, categoria, precio from producto where categoria = 'Accesorios' and precio < 150;

-- C17. Productos sin stock O que cuesten mas de 2000
select nombre, precio, stock from producto where stock = 0 or precio > 2000;

-- C18. Clientes de Huánuco que tengan correo registrado.
select nombre, apellido, ciudad, correo from cliente where ciudad = 'Huanuco' and correo is not null;

-- GRUPO D
-- D19. Pedidos de agosto con apellido y ciudad del cliente
select p.id_pedido,
		p.fecha,
		c.apellido,
		c.ciudad
from pedido p
join cliente c on p.id_cliente = c.id_cliente
where p.fecha between '2026-08-01' and '2026-08-31';

-- D20. Detalle del pedido 20 con producto, cantidad y subtotal
select prod.nombre as producto,
		dp.cantidad,
		dp.precio_unit as precio_cobrado,
		(dp.cantidad * dp.precio_unit) as subtotal
from detalle_pedido dp
join producto prod on dp.id_producto = prod.id_producto 
where dp.id_pedido = 20;

select * from detalle_pedido;
select * from pedido;
select * from producto;

-- D21. Pedidos de clientes de Lima que no estén cancelados.
select p.estado,
		c.ciudad,
		c.nombre
from pedido p
join cliente c on p.id_cliente = c.id_cliente
where c.ciudad = 'Lima' and p.estado <> 'CANCELADO';

-- D22. Ventas donde el precio cobrado fue distinto al precio actual.
select dp.id_pedido,
       prod.nombre as producto,
       dp.precio_unit as precio_cobrado,
       prod.precio as precio_actual
from detalle_pedido dp
join producto prod
     on dp.id_producto = prod.id_producto
where dp.precio_unit <> prod.precio;

-- D23. Clientes que nunca han hecho un pedido
select c.id_cliente,
       c.nombre,
       c.apellido,
       c.ciudad
from cliente c
left join pedido p
       on c.id_cliente = p.id_cliente
where p.id_pedido is null;

-- D24. Productos que nunca se han vendido
select prod.id_producto,
       prod.nombre,
       prod.categoria,
       prod.precio,
       prod.stock
from producto prod
left join detalle_pedido dp
       on prod.id_producto = dp.id_producto
where dp.id_producto is null;

-- =====================================================================
-- ANTES DE SUBIR
-- ---------------------------------------------------------------------
-- [X] Los 24 ejercicios resueltos, cada uno debajo de su enunciado
-- [X] Las respuestas escritas de B9 y C15
-- [X] El archivo ejecuta completo, de arriba a abajo, sin errores
