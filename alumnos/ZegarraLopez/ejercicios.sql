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
CREATE SCHEMA IF NOT EXISTS a_lopez;

-- Se ejecuta CADA VEZ que abres DBeaver:
SET search_path TO a_lopez;

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
  ('Rosa', 'Tello',   'rosa@correo.com', 'Huanuco'),
  ('Martin','pinedo', 'pinedo@correo.com','Pucallpa'),
('benja','abarca', 'abarca@correo.com','puerto maldonado');

INSERT INTO producto (nombre, categoria, precio, stock) VALUES
  ('Laptop Ryzen 5',       'Computo',    2499.00,  8),
  ('Mouse Michi inalambrico',    'Accesorios',   59.90, 40),
  ('Monitor 24 pulgadas',  'Monitores',   749.50, 12),
  ('tv 30 pulgadas',  'tv',   1050.50, 12),
  ('moto honda',  'chacarera',   5555.50, 17);

INSERT INTO pedido (id_cliente, estado) VALUES
  (1, 'ENTREGADO'),
  (2, 'PENDIENTE'),
  (1, 'PENDIENTE'),
 (3, 'ENTREGADO'),
 (4, 'PENDIENTE');

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
  (1, 5, 1, 2499.00),
  (1, 6, 2,   59.90),
  (2, 7, 1,  749.50),
  (3, 8, 2,   1050.50),
  (4, 9, 2,   5555.50);


select * from cliente;
select * from producto;
SELECT * FROM pedido;

-- >>> TE TOCA A TI (1):
-- Agrega 2 clientes mas (uno de tu ciudad), 2 productos mas,
-- y registra 3 pedidos nuevos con sus detalles, de clientes distintos.
INSERT INTO cliente (id_cliente, nombre, apellido, correo, ciudad) VALUES
(6, 'carlos', 'quispe', 'carlos@correo.com', 'lima'),
(7, 'luis', 'torres', 'lucia@correo.com', 'arequipa');


-- ---------------------------------------------------------------------
-- EJERCICIO 3 · CONSULTAR
-- Orden obligatorio: SELECT ... FROM ... WHERE ... ORDER BY

-- ---------------------------------------------------------------------
INSERT INTO producto (id_producto, nombre, precio) VALUES
(6, 'teclado', 85.00),
(7, 'mouse', 45.00);

-- Todos los productos, del mas caro al mas barato
SELECT nombre, categoria, precio
FROM producto
ORDER BY precio DESC;

-

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

-- a)
SELECT nombre, precio
FROM producto
WHERE precio > 500;

-- b) 
SELECT nombre, apellido, correo
FROM cliente
ORDER BY apellido ASC;

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
SELECT c.apellido,
       c.correo,
       p.fecha,
       pr.nombre AS producto,
       d.cantidad,
       d.cantidad * d.precio_unit AS total
FROM detalle_pedido d
JOIN pedido p
    ON d.id_pedido = p.id_pedido
JOIN cliente c
    ON p.id_cliente = c.id_cliente
JOIN producto pr
    ON d.id_producto = pr.id_producto
WHERE c.ciudad = 'Huanuco'
ORDER BY p.fecha DESC;
