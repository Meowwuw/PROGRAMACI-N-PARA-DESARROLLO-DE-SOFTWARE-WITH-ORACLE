-- =====================================================================
-- CLASE 05 · TALLER DE CONSULTAS
-- PASO 0 · BASE DE PRACTICA COMPARTIDA
-- ---------------------------------------------------------------------
-- Ejecuta este archivo COMPLETO con Alt + X, una sola vez, al empezar.
-- Crea TecnoMichiStore con datos suficientes.
-- Todos vamos a tener exactamente los mismos datos: si tu resultado no
-- coincide con el del proyector, la consulta esta mal.
-- =====================================================================

create SCHEMA IF NOT EXISTS michistore;
SET search_path TO michistore;

DROP TABLE IF EXISTS detalle_pedido;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS cliente;

CREATE TABLE cliente (
    id_cliente SERIAL      PRIMARY KEY,
    nombre     VARCHAR(50) NOT NULL,
    apellido   VARCHAR(50) NOT NULL,
    correo     VARCHAR(80),
    telefono   VARCHAR(15),
    ciudad     VARCHAR(40) NOT NULL
);

CREATE TABLE producto (
    id_producto SERIAL        PRIMARY KEY,
    nombre      VARCHAR(80)   NOT NULL,
    categoria   VARCHAR(40),
    precio      NUMERIC(10,2) NOT NULL,
    stock       INT           NOT NULL DEFAULT 0
);

CREATE TABLE pedido (
    id_pedido  SERIAL PRIMARY KEY,
    id_cliente INT    NOT NULL REFERENCES cliente(id_cliente),
    fecha      DATE   NOT NULL,
    estado     VARCHAR(20) NOT NULL
);

CREATE TABLE detalle_pedido (
    id_detalle  SERIAL PRIMARY KEY,
    id_pedido   INT    NOT NULL REFERENCES pedido(id_pedido),
    id_producto INT    NOT NULL REFERENCES producto(id_producto),
    cantidad    INT    NOT NULL,
    precio_unit NUMERIC(10,2) NOT NULL
);
 id_detalle  SERIAL PRIMARY KEY,
    id_pedido   INT    NOT NULL REFERENCES pedido(id_pedido),
    id_producto INT    NOT NULL REFERENCES producto(id_producto),
    cantidad    INT    NOT NULL,
    precio_unit NUMERIC(10,2) NOT NULL
);

-- ---------------------------------------------------------------------
-- CLIENTES  (10)   Ojo: algunos sin correo o sin telefono, a proposito
-- ---------------------------------------------------------------------
INSERT INTO cliente (nombre, apellido, correo, telefono, ciudad) VALUES
('Ana',     'Quispe',   'ana.quispe@gmail.com',    '961234567', 'Huanuco'),
('Luis',    'Ramirez',  'luis.ramirez@hotmail.com','962345678', 'Lima'),
('Rosa',    'Tello',     NULL,                     '963456789', 'Huanuco'),
('Carlos',  'Gonzales', 'carlos.g@gmail.com',       NULL,       'Pucallpa'),
('Ani',     'Garcia',   'ani.garcia@outlook.com',  '965678901', 'Lima'),
('Edgar',   'Angulo',   'edgar.angulo@gmail.com',  '966789012', 'Pucallpa'),
('Genesis', 'Lozada',    NULL,                      NULL,       'Huanuco'),
('Jhoau',   'Zegarra',  'jhoau.z@gmail.com',       '968901234', 'Lima'),
('Fredi',   'Trejo',    'fredi.trejo@hotmail.com', '969012345', 'Pucallpa'),
('Susan',   'Quispe',   'susan.q@GMAIL.COM',       '970123456', 'Huanuco');


-- ---------------------------------------------------------------------
-- PRODUCTOS  (12)   Uno sin categoria, dos sin stock
-- ---------------------------------------------------------------------
INSERT INTO producto (nombre, categoria, precio, stock) VALUES
('Laptop Ryzen 5',           'Computo',     2499.00,  8),
('Mouse Michi inalambrico',  'Accesorios',    59.90, 40),
('Monitor 24 pulgadas',      'Monitores',    749.50, 12),
('Teclado mecanico Michi',   'Accesorios',   189.00,  0),
('Laptop Core i7',           'Computo',     3200.00,  3),
('Audifonos gamer',          'Accesorios',   129.90, 25),
('Monitor 27 curvo',         'Monitores',   1150.00,  5),
('Impresora multifuncional', 'Oficina',      680.00,  0),
('Disco SSD 1TB',            'Componentes',  320.00, 18),
('Memoria RAM 16GB',         'Componentes',  265.00,  9),
('Webcam HD',                'Accesorios',    95.00, 30),
('Alfombrilla Michi XL',      NULL,           45.00, 22);


-- ---------------------------------------------------------------------
-- PEDIDOS  (20)   De junio a setiembre, tres estados distintos
-- ---------------------------------------------------------------------
INSERT INTO pedido (id_cliente, fecha, estado) VALUES
( 1, '2026-06-03', 'ENTREGADO'),
( 2, '2026-06-11', 'ENTREGADO'),
( 4, '2026-06-19', 'CANCELADO'),
( 1, '2026-06-27', 'ENTREGADO'),
( 5, '2026-07-02', 'ENTREGADO'),
( 3, '2026-07-08', 'PENDIENTE'),
( 6, '2026-07-15', 'ENTREGADO'),
( 2, '2026-07-21', 'CANCELADO'),
( 8, '2026-07-29', 'ENTREGADO'),
( 1, '2026-08-04', 'ENTREGADO'),
( 5, '2026-08-09', 'PENDIENTE'),
(10, '2026-08-14', 'ENTREGADO'),
( 4, '2026-08-18', 'ENTREGADO'),
( 6, '2026-08-23', 'CANCELADO'),
( 8, '2026-08-27', 'PENDIENTE'),
( 3, '2026-08-31', 'ENTREGADO'),
(10, '2026-09-02', 'PENDIENTE'),
( 2, '2026-09-06', 'ENTREGADO'),
( 5, '2026-09-11', 'PENDIENTE'),
( 1, '2026-09-15', 'ENTREGADO');



-- ---------------------------------------------------------------------
-- DETALLE  (34)   precio_unit a veces distinto del precio actual:
--                 son ventas viejas, con la tarifa de ese momento
-- ---------------------------------------------------------------------
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
( 1,  1, 1, 2350.00), ( 1,  2, 2,   55.00),
( 2,  3, 1,  720.00), ( 2, 11, 1,   95.00),
( 3,  5, 1, 3100.00),
( 4,  9, 2,  310.00), ( 4, 10, 1,  260.00),
( 5,  2, 3,   59.90), ( 5,  6, 1,  129.90),
( 6,  7, 1, 1150.00),
( 7,  1, 1, 2499.00), ( 7,  9, 1,  320.00),
( 8,  4, 2,  189.00),
( 9,  3, 2,  749.50), ( 9,  2, 1,   59.90),
(10,  6, 2,  129.90), (10, 11, 1,   95.00),
(11,  5, 1, 3200.00),
(12,  2, 4,   59.90), (12,  4, 1,  189.00),
(13,  9, 1,  320.00), (13, 10, 2,  265.00),
(14,  7, 1, 1150.00),
(15,  1, 1, 2499.00),
(16,  3, 1,  749.50), (16,  6, 1,  129.90),
(17, 11, 2,   95.00),
(18,  2, 5,   59.90), (18,  9, 1,  320.00),
(19, 10, 1,  265.00),
(20,  1, 1, 2499.00), (20,  3, 1,  749.50),
(20,  2, 2,   59.90), (20,  6, 1,  129.90);



-- ---------------------------------------------------------------------
-- COMPROBACION · si algun numero no coincide, vuelve a ejecutar el archivo
-- ---------------------------------------------------------------------
SELECT 'cliente'        AS tabla, COUNT(*) AS filas FROM cliente
UNION ALL SELECT 'producto',       COUNT(*) FROM producto
UNION ALL SELECT 'pedido',         COUNT(*) FROM pedido
UNION ALL SELECT 'detalle_pedido', COUNT(*) FROM detalle_pedido;

-- Debe dar:  cliente 10 · producto 12 · pedido 20 · detalle_pedido 34







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
select nombre, stock from producto where stock = 0;


-- A3. Pedidos que NO estan cancelados.
--     Usa <>, no uses = tres veces.
select * from pedido; 
select id_pedido, estado from pedido where estado <> 'CENCELADO';

-- A4. Productos con precio entre 100 y 800, ordenados del mas barato
--     al mas caro.
SELECT * FROM producto;
WHERE precio BETWEEN 100 AND 800
ORDER BY precio ASC;

-- A5. Pedidos hechos durante agosto de 2026.
SELECT *
FROM pedido
WHERE fecha >= '2026-08-01' AND fecha < '2026-09-01';

-- A6. Productos por reponer: los que tienen entre 1 y 10 unidades.
SELECT *
FROM producto
WHERE stock BETWEEN 1 AND 10;

-- =====================================================================
-- GRUPO B · IN Y LIKE                  (ejercicios 7 al 12)
-- =====================================================================

-- B7. Clientes de Huanuco, Lima o Pucallpa.
--     Escribela primero con OR y despues con IN. Compara cual se lee mejor.
select * from cliente 
where ciudad = 'Huanuco' OR ciudad = 'Lima' OR ciudad = 'Pucallpa';

-- Versión con IN
-- B8. Pedidos que estan PENDIENTE o ENTREGADO.
-- Versión con IN:
select * from cliente 
where ciudad IN ('Huanuco', 'Lima', 'Pucallpa');

-- B9. Productos que NO son de Computo ni de Monitores.
--     Ojo con el resultado: revisa si aparece la Alfombrilla Michi XL.
--     Si no aparece, piensa por que y anotalo aqui.

--     RESPUESTA:La Alfombrilla Michi XL probablemente no aparece en el resultado porque el
--     valor de su categoría en la base de datos es NULL


-- B10. Clientes cuyo correo es de Gmail.
SELECT * FROM cliente
WHERE correo LIKE '%@gmail.com';

-- B11. Clientes cuyo apellido empieza con Q, sin importar mayusculas.
SELECT * 
FROM cliente
WHERE apellido LIKE 'q%' OR apellido LIKE 'Q%';

-- B12. Productos cuyo nombre contiene "Michi", en cualquier posicion.
SELECT * 
FROM producto 
WHERE nombre LIKE '%Michi%';


-- =====================================================================
-- GRUPO C · NULL Y COMBINACIONES       (ejercicios 13 al 18)
-- =====================================================================

-- C13. Clientes que no tienen correo registrado.
select * from cliente;
select * from cliente where correo is null;

-- C14. Clientes que si tienen telefono.
select * from cliente where telefono is not null;

-- C15. Ejecuta esto:
--        SELECT * FROM cliente WHERE correo = NULL;
--      Devuelve cero filas aunque SI hay clientes sin correo.
--      Escribe aqui por que:

--      RESPUESTA:el valor NULL representa la ausencia de valor o un dato desconocido  
select * from cliente where correo = null;

-- C16. Accesorios que cuesten menos de 150 soles.
select * from producto where precio < 150;

-- C17. Productos sin stock O que cuesten mas de 2000 soles.
select * from producto where stock = 0 OR precio > 2000;

-- C18. Clientes de Huanuco que tengan correo registrado.
select * from cliente where ciudad = 'Huanuco' and correo is not null;


-- =====================================================================
-- GRUPO D · OPERADORES CON JOIN        (ejercicios 19 al 24)
-- =====================================================================

-- D19. Pedidos de agosto con el apellido del cliente y su ciudad.
select p.id_pedido,
		p.fecha,
		c.apellido,
		c.ciudad
from pedido p
join cliente c on p.id_cliente = c.id_cliente 
where p.fecha between '2026-08-01' and '2026-08-31'

-- D20. Detalle del pedido 20: nombre del producto, cantidad,
--      precio cobrado y subtotal (cantidad * precio_unit).
select prod.nombre as producto
		dp.cantidad
		dp.precio_unit as precio_cobrado,
		(dp. cantidad * dp.precio_unit) as subtotal
from detalle_pedido dp
join producto prod on dp.id_producto = prod. id_producto
where dp.id_pedido = 20;

select * from detalle_pedido;
select * from pedido;
select * from producto;

-- D21. Pedidos de clientes de Lima que no esten cancelados.
select c.nombre,
		c.ciudad
		p.estado 
from pedido p
join cliente c on p.id_cliente = c.id_cliente 
where c.ciudad = 'Lima' and p.estado <> 'CANCELADO'


-- D22. Ventas donde el precio cobrado fue DISTINTO del precio actual
--      del producto. Muestra producto, precio_unit y precio.
--      Esto es el precio historico del que hablamos: no es un error.
select pr.nombre as producto, 
       dp.precio_unit, 
       pr.precio 
from detalle_pedido dp
join producto pr on dp.id_producto = pr.id_producto
where dp.precio_unit <> pr.precio;

-- D23. Clientes que nunca han hecho un pedido.
--      Pista: LEFT JOIN y IS NULL.
select c.*
from cliente c
left join pedido p on c.id_cliente = p.id_cliente
where p.id_pedido is null;


-- D24. Productos que nunca se han vendido.
select pr.*
from producto pr
left join detalle_pedido dp on pr.id_producto = dp.id_producto
where dp.id_producto is null;


-- =====================================================================
-- ANTES DE SUBIR
-- ---------------------------------------------------------------------
-- [X] Los 24 ejercicios resueltos, cada uno debajo de su enunciado
-- [X] Las respuestas escritas de B9 y C15
-- [X] El archivo ejecuta completo, de arriba a abajo, sin errores
--
-- ENTREGA INDIVIDUAL. Cada uno sube el suyo a:
--    alumnos/apellidos/ejercicios-clase05.sql
--
-- El trabajo sobre el proyecto va en OTRO archivo, en equipo:
--    equipos/equipo-NN/consultas-proyecto.sql
-- =====================================================================



























