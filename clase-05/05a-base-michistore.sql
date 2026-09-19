-- =====================================================================
-- CLASE 05 · TALLER DE CONSULTAS
-- PASO 0 · BASE DE PRACTICA COMPARTIDA
-- ---------------------------------------------------------------------
-- Ejecuta este archivo COMPLETO con Alt + X, una sola vez, al empezar.
-- Crea TecnoMichiStore con datos suficientes.
-- Todos vamos a tener exactamente los mismos datos: si tu resultado no
-- coincide con el del proyector, la consulta esta mal.
-- =====================================================================

CREATE SCHEMA IF NOT EXISTS michistore;
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
