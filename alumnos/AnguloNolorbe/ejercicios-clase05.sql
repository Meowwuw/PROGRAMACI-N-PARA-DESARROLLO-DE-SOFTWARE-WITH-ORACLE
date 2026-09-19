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

select nombre, precio from producto where precio > 500;

-- A2. Productos que no tienen stock.
select nombre, precio, stock from producto where stock = 0;

-- A3. Pedidos que NO estan cancelados.
--     Usa <>, no uses = tres veces.
select * from pedido;

select id_pedido, estado from pedido where estado <> 'CANCELADO';

-- A4. Productos con precio entre 100 y 800, ordenados del mas barato
--     al mas caro.
select * from producto;

select nombre, precio from producto where precio between 100 and 800 order by precio asc;

-- A5. Pedidos hechos durante agosto de 2026.
select * from pedido;
select fecha, estado from pedido where fecha between '2026-08-01' and '2026-08-31';
-- A6. Productos por reponer: los que tienen entre 1 y 10 unidades.
select * from producto;

select nombre, categoria, stock from producto where stock between 0 and 10;

-- =====================================================================
-- GRUPO B · IN Y LIKE                  (ejercicios 7 al 12)
-- =====================================================================

-- B7. Clientes de Huanuco, Lima o Pucallpa.
--     Escribela primero con OR y despues con IN. Compara cual se lee mejor.

select * from cliente;
select nombre, apellido, ciudad from cliente where ciudad = 'Lima' or ciudad = 'Huanuco' or ciudad = 'Pucallpa';

select nombre, apellido, ciudad from cliente where ciudad in ('Lima', 'Huanuco', 'Pucallpa');

-- B8. Pedidos que estan PENDIENTE o ENTREGADO.
select * from pedido;

select id_pedido, estado from pedido where estado <> 'CANCELADO';


-- B9. Productos que NO son de Computo ni de Monitores.
--     Ojo con el resultado: revisa si aparece la Alfombrilla Michi XL.
--     Si no aparece, piensa por que y anotalo aqui.

--     RESPUESTA: No aparece por que no tiene una categoria asignada por lo que no tiene "categoria"
--	   por el cual la funcion NOT IN pueda buscarla y por ello no la añade al filtro

select * from producto;

select * from producto where categoria not in ('Computo', 'Monitores');

-- B10. Clientes cuyo correo es de Gmail.
select * from cliente;
select * from cliente where correo like '%@gmail.com';


-- B11. Clientes cuyo apellido empieza con Q, sin importar mayusculas.
select * from cliente where apellido like 'Q%';

-- B12. Productos cuyo nombre contiene "Michi", en cualquier posicion.
select * from producto;

select * from producto where nombre like '%Michi%';

-- =====================================================================
-- GRUPO C · NULL Y COMBINACIONES       (ejercicios 13 al 18)
-- =====================================================================

-- C13. Clientes que no tienen correo registrado.

select * from cliente;

select * from cliente where correo = null;

select * from cliente where correo is null;
-- C14. Clientes que si tienen telefono.

select * from cliente where telefono is not null;

-- C15. Ejecuta esto:
--        SELECT * FROM cliente WHERE correo = NULL;
--      Devuelve cero filas aunque SI hay clientes sin correo.
--      Escribe aqui por que:
--      RESPUESTA: Por que null es por asi decirlo "desconocido" es decir, no puede comprara
-- 		y no tiene ni idea de que hacer para comparar por lo que simplemente no tiene nada que mostrar
select * from cliente where correo = null;

-- C16. Accesorios que cuesten menos de 150 soles.
select * from producto;

select nombre, categoria, precio from producto where categoria = 'Accesorios' and precio < 150;

-- C17. Productos sin stock O que cuesten mas de 2000 soles.
select * from producto;

select nombre, categoria, precio, stock from producto where stock > 0 and precio > 2000;

-- C18. Clientes de Huanuco que tengan correo registrado.
select * from cliente;

select nombre, apellido, correo, ciudad from cliente where ciudad = 'Huanuco' and correo is not null;

-- =====================================================================
-- GRUPO D · OPERADORES CON JOIN        (ejercicios 19 al 24)
-- =====================================================================

-- D19. Pedidos de agosto con el apellido del cliente y su ciudad.
select 
    p.id_pedido as pedido, 
    p.fecha as fecha, 
    c.apellido as apellido, 
    c.ciudad as ciudad
from pedido p
join cliente c on p.id_cliente = c.id_cliente
where p.fecha between '2026-08-01' and '2026-08-31';

-- D20. Detalle del pedido 20: nombre del producto, cantidad,
--      precio cobrado y subtotal (cantidad * precio_unit).
select 
    prod.nombre as producto,
    dp.cantidad,
    dp.precio_unit as precio_cobrado,
    (dp.cantidad * dp.precio_unit) as subtotal
from detalle_pedido dp
join producto prod on dp.id_producto = prod.id_producto
where dp.id_pedido = 20;

-- D21. Pedidos de clientes de Lima que no esten cancelados.
select 
    p.id_pedido, 
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
    prod.nombre as producto,
    dp.precio_unit as precio_historico,
    prod.precio as precio_actual
from detalle_pedido dp
join producto prod on dp.id_producto = prod.id_producto
where dp.precio_unit <> prod.precio;

-- D23. Clientes que nunca han hecho un pedido.
--      Pista: LEFT JOIN y IS NULL.
select 
    c.id_cliente, 
    c.nombre, 
    c.apellido
from cliente c
left join pedido p on c.id_cliente = p.id_cliente
where p.id_pedido is null;

-- D24. Productos que nunca se han vendido.
select 
    prod.id_producto, 
    prod.nombre
from producto prod
left join detalle_pedido dp on prod.id_producto = dp.id_producto
where dp.id_detalle is null;

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
-- =====================================================================
