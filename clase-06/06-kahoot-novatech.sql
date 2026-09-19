-- =====================================================================
-- KAHOOT · CLASE 06
-- BASE NUEVA: NovaTech
-- ---------------------------------------------------------------------
-- Ejecuta este archivo COMPLETO una sola vez antes de iniciar el Kahoot.
-- Todos los equipos deben trabajar con exactamente los mismos datos.
--
-- IMPORTANTE:
--   1. No modifiques, insertes ni borres datos durante el Kahoot.
--   2. Responde cada pregunta ejecutando una consulta en DBeaver.
--   3. Recién después marca la alternativa en Kahoot.
-- =====================================================================

CREATE SCHEMA IF NOT EXISTS kahoot06;
SET search_path TO kahoot06;

DROP TABLE IF EXISTS detalle_pedido;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS persona;

-- =====================================================================
-- JERARQUÍA
-- PERSONA = supertipo
-- CLIENTE y EMPLEADO = subtipos
-- =====================================================================

CREATE TABLE persona (
    id_persona SERIAL PRIMARY KEY,
    nombre      VARCHAR(40) NOT NULL,
    apellido    VARCHAR(40) NOT NULL,
    correo      VARCHAR(90),
    telefono    VARCHAR(15),
    ciudad      VARCHAR(30) NOT NULL
);

CREATE TABLE cliente (
    id_persona INT PRIMARY KEY REFERENCES persona(id_persona),
    nivel      VARCHAR(15) NOT NULL,
    puntos     INT NOT NULL DEFAULT 0
);

CREATE TABLE empleado (
    id_persona INT PRIMARY KEY REFERENCES persona(id_persona),
    cargo      VARCHAR(40) NOT NULL,
    sueldo     NUMERIC(10,2) NOT NULL
);

-- =====================================================================
-- PRODUCTOS Y PEDIDOS
-- =====================================================================

CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    nombre      VARCHAR(70) NOT NULL,
    categoria   VARCHAR(30) NOT NULL,
    precio      NUMERIC(10,2) NOT NULL,
    stock       INT NOT NULL
);

CREATE TABLE pedido (
    id_pedido  SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES cliente(id_persona),
    fecha      DATE NOT NULL,
    estado     VARCHAR(20) NOT NULL
);

CREATE TABLE detalle_pedido (
    id_detalle  SERIAL PRIMARY KEY,
    id_pedido   INT NOT NULL REFERENCES pedido(id_pedido),
    id_producto INT NOT NULL REFERENCES producto(id_producto),
    cantidad    INT NOT NULL,
    precio_unit NUMERIC(10,2) NOT NULL
);

-- =====================================================================
-- PERSONAS
-- Algunos correos tienen mayúsculas y algunos son NULL a propósito.
-- =====================================================================

INSERT INTO persona (nombre, apellido, correo, telefono, ciudad) VALUES
('Lucia',  'Ramos',   'lucia.ramos@gmail.com',       '981111111', 'Lima'),
('MATEO',  'Silva',   'MATEO.SILVA@OUTLOOK.COM',     '982222222', 'Pucallpa'),
('Carla',  'Vega',    NULL,                            '983333333', 'Huanuco'),
('Diego',  'Torres',  'diego.t@empresa.pe',           '984444444', 'Lima'),
('Ana',    'Mendoza', 'ana_mendoza@gmail.com',         '985555555', 'Pucallpa'),
('Bruno',  'Quispe',  'bruno.q@yahoo.com',             NULL,       'Huanuco'),
('SOFIA',  'Leon',    'sofia.leon@GMAIL.COM',         '987777777', 'Lima'),
('Renzo',  'Paz',     'renzo.paz@empresa.pe',         '988888888', 'Pucallpa'),
('Elena',  'Ruiz',    NULL,                            '989999999', 'Huanuco'),
('Tomas',  'Salas',   'tomas.salas@hotmail.com',      '980000000', 'Lima');

-- =====================================================================
-- SUBTIPOS
-- Sofía y Renzo son CLIENTES y EMPLEADOS al mismo tiempo.
-- =====================================================================

INSERT INTO cliente (id_persona, nivel, puntos) VALUES
(1,  'ORO',    620),
(2,  'PLATA',  280),
(3,  'BRONCE',  90),
(5,  'ORO',    740),
(6,  'PLATA',  330),
(7,  'ORO',    910),
(8,  'PLATA',  410),
(10, 'BRONCE', 120);

INSERT INTO empleado (id_persona, cargo, sueldo) VALUES
(4, 'Soporte',    2800.00),
(7, 'Analista',   3600.00),
(8, 'Vendedor',   3000.00),
(9, 'Supervisora',4200.00);

-- =====================================================================
-- PRODUCTOS
-- =====================================================================

INSERT INTO producto (nombre, categoria, precio, stock) VALUES
('Teclado Retro',          'Accesorios',  89.90, 10),
('Laptop Nova Pro',        'Computo',    2899.00,  4),
('Mouse Pixel',            'Accesorios',  49.90, 30),
('Monitor UltraWide',      'Monitores', 1299.00,  6),
('Webcam Mini HD',         'Accesorios', 119.00,  0),
('Soporte Ergo Max',       'Oficina',     149.50, 15),
('Audifonos Orbit',        'Accesorios',  179.00,  8),
('Hub USB-C 7 puertos',    'Accesorios',  159.00, 12),
('SSD Flash 1TB',          'Componentes',349.00,  5),
('Microfono Stream Pro',   'Accesorios',  259.00,  0);

-- =====================================================================
-- PEDIDOS
-- =====================================================================

INSERT INTO pedido (id_cliente, fecha, estado) VALUES
(1,  '2026-08-01', 'ENTREGADO'),
(2,  '2026-08-03', 'ENTREGADO'),
(5,  '2026-08-05', 'PENDIENTE'),
(7,  '2026-08-07', 'ENTREGADO'),
(8,  '2026-08-09', 'CANCELADO'),
(3,  '2026-08-12', 'ENTREGADO'),
(6,  '2026-08-14', 'PENDIENTE'),
(10, '2026-08-18', 'ENTREGADO'),
(1,  '2026-08-21', 'ENTREGADO'),
(7,  '2026-08-24', 'PENDIENTE'),
(5,  '2026-08-27', 'ENTREGADO'),
(8,  '2026-08-29', 'ENTREGADO');

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
(1,  1, 2,   89.90),
(1,  3, 1,   49.90),

(2,  2, 1, 2799.00),

(3,  7, 1,  179.00),
(3,  8, 1,  159.00),

(4,  4, 1, 1249.00),
(4,  9, 1,  349.00),

(5, 10, 1,  259.00),

(6,  6, 2,  149.50),

(7,  3, 2,   49.90),
(7,  1, 1,   89.90),

(8,  5, 1,  119.00),
(8,  8, 2,  159.00),

(9,  9, 1,  339.00),

(10, 2, 1, 2899.00),
(10, 3, 1,   49.90),

(11, 4, 1, 1299.00),
(11, 7, 1,  179.00),

(12, 8, 3,  159.00);

-- =====================================================================
-- COMPROBACIÓN
-- Si algún número no coincide, vuelve a ejecutar TODO el archivo.
-- =====================================================================

SELECT 'persona' AS tabla, COUNT(*) AS filas FROM persona
UNION ALL
SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL
SELECT 'empleado', COUNT(*) FROM empleado
UNION ALL
SELECT 'producto', COUNT(*) FROM producto
UNION ALL
SELECT 'pedido', COUNT(*) FROM pedido
UNION ALL
SELECT 'detalle_pedido', COUNT(*) FROM detalle_pedido;

-- Debe dar:
-- persona         10
-- cliente          8
-- empleado         4
-- producto        10
-- pedido          12
-- detalle_pedido  18
-- =====================================================================
