-- =====================================================================
-- CLASE 02  ·  TecnoMichiStore
-- Programacion para Desarrollo de Software con Oracle - Modulo 01
-- Motor de practica: PostgreSQL (Neon)  ·  Cliente: DBeaver
-- Instructora: Magenta Paredes Ponce
-- =====================================================================
-- COMO USAR ESTE ARCHIVO:
-- Ejecuta bloque por bloque con Ctrl + Enter. NO uses Alt + X (ejecuta
-- todo de golpe y si un bloque falla se te complica encontrar donde).
-- =====================================================================


-- ---------------------------------------------------------------------
-- PASO 0 · TU ESPACIO DE TRABAJO
-- Cambia "a_quispe" por a_ + TU apellido, en minusculas y sin tildes.
-- ---------------------------------------------------------------------

-- Se ejecuta UNA SOLA VEZ en tu vida:
CREATE SCHEMA IF NOT EXISTS a_abarca;

-- Se ejecuta CADA VEZ que abres DBeaver:
SET search_path TO a_abarca;

-- Verifica donde estas parado antes de seguir:
SELECT current_schema();


-- ---------------------------------------------------------------------
-- EJERCICIO 1 · CREAR LAS TABLAS
-- Primero las tablas independientes, despues las que tienen FK.
-- ---------------------------------------------------------------------

CREATE TABLE cliente (
    id_cliente  SERIAL      PRIMARY KEY,
    nombre      VARCHAR(50) NOT NULL,
    apellido    VARCHAR(50) NOT NULL,
    correo      VARCHAR(80) UNIQUE,
    ciudad      VARCHAR(40)
);

CREATE TABLE producto (
    id_producto SERIAL        PRIMARY KEY,
    nombre      VARCHAR(80)   NOT NULL,
    categoria   VARCHAR(40),
    precio      NUMERIC(10,2) NOT NULL,
    stock       INT DEFAULT 0
);

CREATE TABLE pedido (
    id_pedido  SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES cliente(id_cliente),
    fecha      DATE DEFAULT CURRENT_DATE,
    estado     VARCHAR(20) DEFAULT 'PENDIENTE'
);

CREATE TABLE detalle_pedido (
    id_detalle   SERIAL PRIMARY KEY,
    id_pedido    INT NOT NULL REFERENCES pedido(id_pedido),
    id_producto  INT NOT NULL REFERENCES producto(id_producto),
    cantidad     INT NOT NULL,
    precio_unit  NUMERIC(10,2) NOT NULL
);


-- ---------------------------------------------------------------------
-- EJERCICIO 2 · INSERTAR DATOS DE PRUEBA
-- Los textos van entre comillas SIMPLES. Los numeros van sin comillas.
-- No escribimos los id: SERIAL los genera solo.
-- ---------------------------------------------------------------------

INSERT INTO cliente (nombre, apellido, correo, ciudad) VALUES
  ('Ana',  'Quispe',  'ana@correo.com',  'Huanuco'),
  ('Luis', 'Ramirez', 'luis@correo.com', 'Lima'),
  ('Rosa', 'Tello',   'rosa@correo.com', 'Huanuco');

INSERT INTO producto (nombre, categoria, precio, stock) VALUES
  ('Laptop Ryzen 5',       'Computo',    2499.00,  8),
  ('Mouse Michi inalambrico',    'Accesorios',   59.90, 40),
  ('Monitor 24 pulgadas',  'Monitores',   749.50, 12);

INSERT INTO pedido (id_cliente, estado) VALUES
  (1, 'ENTREGADO'),
  (2, 'PENDIENTE'),
  (1, 'PENDIENTE');

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
  (1, 1, 1, 2499.00),
  (1, 2, 2,   59.90),
  (2, 3, 1,  749.50),
  (3, 2, 1,   59.90);

SELECT * FROM cliente;
SELECT * FROM pedido;

-- >>> TE TOCA A TI (1):
-- Agrega 2 clientes mas (uno de tu ciudad), 2 productos mas,
-- y registra 3 pedidos nuevos con sus detalles, de clientes distintos.


-- ---------------------------------------------------------------------
-- EJERCICIO 3 · CONSULTAR
-- Orden obligatorio: SELECT ... FROM ... WHERE ... ORDER BY
-- ---------------------------------------------------------------------

-- Todos los productos, del mas caro al mas barato
SELECT nombre, categoria, precio
FROM producto
ORDER BY precio DESC;

-- Solo los clientes de Huanuco
SELECT nombre, apellido, correo
FROM cliente
WHERE ciudad = 'Huanuco';

-- Productos de computo con poco stock
SELECT nombre, stock
FROM producto
WHERE categoria = 'Computo' AND stock < 10;

-- >>> TE TOCA A TI (2):
-- a) Muestra los productos que cuestan mas de 500 soles.
-- b) Muestra los clientes ordenados por apellido de la A a la Z.


-- ---------------------------------------------------------------------
-- EJERCICIO 4 · JOIN ENTRE CUATRO TABLAS
-- Empezamos desde la tabla que tiene las claves foraneas y saltamos
-- desde ahi hacia las demas.
-- ---------------------------------------------------------------------

SELECT  c.apellido,
        p.fecha,
        pr.nombre        AS producto,
        d.cantidad,
        d.cantidad * d.precio_unit AS total
FROM detalle_pedido d
JOIN pedido   p  ON d.id_pedido   = p.id_pedido
JOIN cliente  c  ON p.id_cliente  = c.id_cliente
JOIN producto pr ON d.id_producto = pr.id_producto
ORDER BY p.fecha DESC;

-- >>> TE TOCA A TI (3):
-- Modifica la consulta para que muestre solo los pedidos de los clientes
-- de tu ciudad, y agrega el correo del cliente al resultado.


-- ---------------------------------------------------------------------
-- RETO INDIVIDUAL
-- Muestra, por cada cliente, cuantos pedidos ha realizado.
-- Pista: COUNT y GROUP BY. No lo hemos visto todavia: buscalo y pruebalo.
-- ---------------------------------------------------------------------

-- Escribe tu respuesta aqui:



-- ---------------------------------------------------------------------
-- SI NECESITAS EMPEZAR DE CERO
-- Borra en orden inverso al que creaste (primero las tablas con FK).
-- ---------------------------------------------------------------------
-- DROP TABLE IF EXISTS detalle_pedido;
-- DROP TABLE IF EXISTS pedido;
-- DROP TABLE IF EXISTS producto;
-- DROP TABLE IF EXISTS cliente;


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
SELECT COUNT(*) AS total_clientes 
FROM cliente;
-- b) Cual es el total de unidades vendidas en detalle_pedido?
SELECT SUM(cantidad) AS total_unidades_vendidas 
FROM detalle_pedido;
-- c) Cuanto suma el pedido mas caro?
SELECT id_pedido, SUM(cantidad * precio_unit) AS total_pedido
FROM detalle_pedido
GROUP BY id_pedido
ORDER BY total_pedido DESC
LIMIT 1;
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
SELECT  pr.nombre,
        SUM(d.cantidad) AS unidades_vendidas,
        SUM(d.cantidad * d.precio_unit) AS total_recaudado
FROM detalle_pedido d
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY total_recaudado DESC;

-- >>> TE TOCA A TI (2):
-- Cuantos pedidos tiene cada cliente? Muestra apellido y cantidad,
-- del que mas pide al que menos.
SELECT  c.apellido,
        COUNT(p.id_pedido) AS cantidad_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.apellido
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
SELECT categoria, COUNT(*) AS total_productos
FROM producto
GROUP BY categoria
HAVING COUNT(*) > 1;
-- b) Que clientes han hecho 2 o mas pedidos?
SELECT c.id_cliente, c.nombre, c.apellido, COUNT(p.id_pedido) AS total_pedidos
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING COUNT(p.id_pedido) >= 2;
-- c) Que productos han vendido mas de 1 unidad en total?
SELECT pr.id_producto, pr.nombre, SUM(d.cantidad) AS total_unidades_vendidas
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
-- b) Lista los productos que nunca se han vendido.
SELECT pr.id_producto, pr.nombre, pr.precio
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
SELECT  pr.nombre AS producto,
        SUM(d.cantidad) AS total_unidades,
        SUM(d.cantidad * d.precio_unit) AS total_facturado
FROM detalle_pedido d
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY total_unidades DESC
LIMIT 3;
-- 2) Los clientes que han gastado mas que el promedio de gasto
--    de todos los clientes.
SELECT c.id_cliente,
       c.nombre,
       c.apellido,
       SUM(d.cantidad * d.precio_unit) AS total_gastado
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN detalle_pedido d ON p.id_pedido = d.id_pedido
GROUP BY c.id_cliente, c.nombre, c.apellido
HAVING SUM(d.cantidad * d.precio_unit) > (
    SELECT AVG(total_cliente)
    FROM (
        SELECT SUM(d2.cantidad * d2.precio_unit) AS total_cliente
        FROM pedido p2
        JOIN detalle_pedido d2 ON p2.id_pedido = d2.id_pedido
        GROUP BY p2.id_cliente
    ) subconsulta
);
-- 3) Las categorias que aun no han vendido ni una sola unidad.
SELECT DISTINCT pr.categoria
FROM producto pr
WHERE pr.categoria NOT IN (
    SELECT DISTINCT pr2.categoria
    FROM detalle_pedido d
    JOIN producto pr2 ON d.id_producto = pr2.id_producto
    WHERE pr2.categoria IS NOT NULL
);
-- Escribe tus respuestas aqui:



-- ---------------------------------------------------------------------
-- ANEXO · el sorteo de equipos (lo ejecuta la instructora)
-- ---------------------------------------------------------------------
-- SELECT schema_name AS aprendiz,
--        NTILE(5) OVER (ORDER BY random()) AS equipo
-- FROM information_schema.schemata
-- WHERE schema_name LIKE 'a\_%'
-- ORDER BY equipo, aprendiz;
