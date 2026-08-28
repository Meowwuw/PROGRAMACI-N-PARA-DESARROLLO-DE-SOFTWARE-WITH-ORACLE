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
SELECT * 
FROM michistore.productos 
WHERE precio > 500;

-- A2. Productos que no tienen stock.
SELECT * 
FROM productos 
WHERE stock = 0;

-- A3. Pedidos que NO estan cancelados.
--     Usa <>, no uses = tres veces.
SELECT * 
FROM pedidos 
WHERE estado <> 'cancelado' 
  AND estado <> 'Cancelado' 
  AND estado <> 'CANCELADO';

-- A4. Productos con precio entre 100 y 800, ordenados del mas barato
--     al mas caro.
SELECT * 
FROM productos 
WHERE precio BETWEEN 100 AND 800
ORDER BY precio ASC;

-- A5. Pedidos hechos durante agosto de 2026.
SELECT * 
FROM pedidos 
WHERE fecha_pedido BETWEEN '2026-08-01' AND '2026-08-31';

-- A6. Productos por reponer: los que tienen entre 1 y 10 unidades.
SELECT * 
FROM productos 
WHERE stock BETWEEN 1 AND 10;

-- =====================================================================
-- GRUPO B · IN Y LIKE                  (ejercicios 7 al 12)
-- =====================================================================

-- B7. Clientes de Huanuco, Lima o Pucallpa.
--     Escribela primero con OR y despues con IN. Compara cual se lee mejor.
SELECT * 
FROM clientes 
WHERE ciudad = 'Huánuco' 
   OR ciudad = 'Lima' 
   OR ciudad = 'Pucallpa';

-- B8. Pedidos que estan PENDIENTE o ENTREGADO.
 SELECT * 
FROM pedidos 
WHERE estado IN ('PENDIENTE', 'ENTREGADO');


-- B9. Productos que NO son de Computo ni de Monitores.
--     Ojo con el resultado: revisa si aparece la Alfombrilla Michi XL.
--     Si no aparece, piensa por que y anotalo aqui.
--     RESPUESTA:
SELECT * 
FROM productos 
WHERE categoria NOT IN ('Cómputo', 'Monitores');

-- B10. Clientes cuyo correo es de Gmail.
SELECT * 
FROM clientes 
WHERE correo ILIKE '%@gmail.com';


-- B11. Clientes cuyo apellido empieza con Q, sin importar mayusculas.
SELECT * 
FROM clientes 
WHERE apellido ILIKE 'Q%';

-- B12. Productos cuyo nombre contiene "Michi", en cualquier posicion.
SELECT * 
FROM productos 
WHERE nombre ILIKE '%Michi%';

-- =====================================================================
-- GRUPO C · NULL Y COMBINACIONES       (ejercicios 13 al 18)
-- =====================================================================

-- C13. Clientes que no tienen correo registrado.
SELECT * 
FROM clientes 
WHERE correo IS NULL;

-- C14. Clientes que si tienen telefono.
SELECT * 
FROM clientes 
WHERE telefono IS NOT NULL;

-- C15. Ejecuta esto:
--        SELECT * FROM cliente WHERE correo = NULL;
--      Devuelve cero filas aunque SI hay clientes sin correo.
--      Escribe aqui por que:
--      RESPUESTA:
select * from cliente where correo = null;

-- C16. Accesorios que cuesten menos de 150 soles.
SELECT * 
FROM productos 
WHERE categoria ILIKE 'Accesorios' 
  AND precio < 150;

-- C17. Productos sin stock O que cuesten mas de 2000 soles.
SELECT * 
FROM productos 
WHERE stock = 0 
   OR precio > 2000;

-- C18. Clientes de Huanuco que tengan correo registrado.
SELECT * 
FROM clientes 
WHERE ciudad ILIKE 'Huánuco' 
  AND correo IS NOT NULL;

-- =====================================================================
-- GRUPO D · OPERADORES CON JOIN        (ejercicios 19 al 24)
-- =====================================================================

-- D19. Pedidos de agosto con el apellido del cliente y su ciudad.
select id_pedido,
       p.fecha ,
       c.apellido ,
       c.ciudad ,
from pedido p,
join cliente c on p.id_cliente = c.id_cliente 
where p.fecha between '2026-08-01' and '2026-08-31'

-- D20. Detalle del pedido 20: nombre del producto, cantidad,
--      precio cobrado y subtotal (cantidad * precio_unit).
SELECT pr.nombre, dp.cantidad, dp.precio_unitario, (dp.cantidad * dp.precio_unitario) AS subtotal
FROM detalle_pedidos dp
JOIN productos pr ON dp.producto_id = pr.id
WHERE dp.pedido_id = 20;

-- D21. Pedidos de clientes de Lima que no esten cancelados.
SELECT p.*
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
WHERE c.ciudad ILIKE 'Lima' 
  AND p.estado NOT ILIKE 'cancelado';

-- D22. Ventas donde el precio cobrado fue DISTINTO del precio actual
--      del producto. Muestra producto, precio_unit y precio.
--      Esto es el precio historico del que hablamos: no es un error.
SELECT pr.nombre, dp.precio_unitario, pr.precio
FROM detalle_pedidos dp
JOIN productos pr ON dp.producto_id = pr.id
WHERE dp.precio_unitario <> pr.precio;

-- D23. Clientes que nunca han hecho un pedido.
--      Pista: LEFT JOIN y IS NULL.
SELECT c.*
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

-- D24. Productos que nunca se han vendido.
SELECT pr.*
FROM productos pr
LEFT JOIN detalle_pedidos dp ON pr.id = dp.producto_id
WHERE dp.producto_id IS NULL;

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