-- =====================================================================
-- ODA PERFUMERÍA · CONFIGURACIÓN E ESTRUCTURA COMPLETA
-- =====================================================================

CREATE SCHEMA IF NOT EXISTS a_PERFUMERIA;
SET search_path TO a_PERFUMERIA;

SELECT current_schema();

-- Limpieza preventiva de tablas en orden jerárquico inverso
DROP TABLE IF EXISTS pedido_envio CASCADE;
DROP TABLE IF EXISTS recepcion_carga CASCADE;
DROP TABLE IF EXISTS detalle_venta CASCADE;
DROP TABLE IF EXISTS venta CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS perfume CASCADE;
DROP TABLE IF EXISTS marca CASCADE;

-- 1. TABLA MARCA
CREATE TABLE marca (
    id_marca SERIAL PRIMARY KEY,
    nombre_marca VARCHAR(50) NOT NULL UNIQUE,
    pais_origen VARCHAR(50),
    sitio_web VARCHAR(150),
    email_contacto VARCHAR(100),
    estado BOOLEAN DEFAULT TRUE
);

-- 2. TABLA PERFUME
CREATE TABLE perfume (
    id_perfume SERIAL PRIMARY KEY,
    id_marca INT REFERENCES marca(id_marca),
    nombre VARCHAR(100) NOT NULL,
    genero VARCHAR(20),
    concentracion VARCHAR(30), 
    mililitros INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

-- 3. TABLA CLIENTE
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    dni_ruc VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT
);

-- 4. TABLA VENTA
CREATE TABLE venta (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES cliente(id_cliente),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR(30) DEFAULT 'efectivo', 
    tipo_comprobante VARCHAR(20) DEFAULT 'boleta', 
    monto_total DECIMAL(10, 2) DEFAULT 0.00,
    estado_venta VARCHAR(20) DEFAULT 'completada'
);

-- 5. TABLA DETALLE_VENTA
CREATE TABLE detalle_venta (
    id_detalle SERIAL PRIMARY KEY,
    id_venta INT REFERENCES venta(id_venta) ON DELETE CASCADE,
    id_perfume INT REFERENCES perfume(id_perfume),
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL,
    descuento DECIMAL(10, 2) DEFAULT 0.00,
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (cantidad * precio_unitario - descuento) STORED
);

-- 6. TABLA RECEPCION_CARGA
CREATE TABLE recepcion_carga (
  id_recepcion SERIAL PRIMARY KEY,
  id_perfume INT NOT NULL REFERENCES perfume(id_perfume),
  numero_lote VARCHAR(30) NOT NULL,
  cantidad_recibida INT NOT NULL,
  fecha_recepcion DATE NOT NULL
);

-- 7. TABLA PEDIDO_ENVIO
CREATE TABLE pedido_envio (
  id_pedido SERIAL PRIMARY KEY,
  id_venta INT NOT NULL REFERENCES venta(id_venta),
  fecha_pedido DATE NOT NULL,
  fecha_entrega DATE,
  estado_envio VARCHAR(20) NOT NULL
);

-- =====================================================================
-- INSERCIÓN DE DATOS DE PRUEBA
-- =====================================================================

-- 1. MARCAS (20 Registros)
INSERT INTO marca (nombre_marca, pais_origen, sitio_web, email_contacto) VALUES
  ('Dior',                 'Francia',          'https://oda.com/marcas/dior',                 'contacto@dior.com'),
  ('Chanel',               'Francia',          'https://oda.com/marcas/chanel',               'info@chanel.com'),
  ('Calvin Klein',         'EEUU',             'https://oda.com/marcas/calvin-klein',         'support@ck.com'),
  ('Versace',              'Italia',           'https://oda.com/marcas/versace',              'sales@versace.com'),
  ('Natura',               'Brasil',           'https://oda.com/marcas/natura',               'servicio@natura.com'),
  ('Carolina Herrera',     'Estados Unidos',   'https://oda.com/marcas/carolina-herrera',     'contact@carolinaherrera.com'),
  ('Paco Rabanne',         'Francia',          'https://oda.com/marcas/paco-rabanne',         'contact@pacorabanne.com'),
  ('Giorgio Armani',       'Italia',           'https://oda.com/marcas/giorgio-armani',       'info@armanibeauty.com'),
  ('Yves Saint Laurent',   'Francia',          'https://oda.com/marcas/ysl',                  'support@yslbeauty.com'),
  ('Gucci',                'Italia',           'https://oda.com/marcas/gucci',                'clientservice@gucci.com'),
  ('Tom Ford',             'Estados Unidos',   'https://oda.com/marcas/tom-ford',             'support@tomfordbeauty.com'),
  ('Givenchy',             'Francia',          'https://oda.com/marcas/givenchy',             'contact@givenchybeauty.com'),
  ('Dolce & Gabbana',      'Italia',           'https://oda.com/marcas/dolce-gabbana',        'info@dolcegabbanabeauty.com'),
  ('Hugo Boss',            'Alemania',         'https://oda.com/marcas/hugo-boss',            'service@hugoboss.com'),
  ('Lancome',              'Francia',          'https://oda.com/marcas/lancome',              'atencion@lancome.com'),
  ('Bvlgari',              'Italia',           'https://oda.com/marcas/bvlgari',              'support@bvlgari.com'),
  ('Burberry',             'Reino Unido',      'https://oda.com/marcas/burberry',             'customerservice@burberry.com'),
  ('Creed',                'Reino Unido',      'https://oda.com/marcas/creed',                'info@creedfragrances.com'),
  ('Jo Malone',            'Reino Unido',      'https://oda.com/marcas/jo-malone',            'service@jomalone.com'),
  ('Jean Paul Gaultier',   'Francia',          'https://oda.com/marcas/jean-paul-gaultier',   'fragrances@jeanpaulgaultier.com');

-- 2. PERFUMES (20 Registros)
INSERT INTO perfume (id_marca, nombre, genero, concentracion, mililitros, precio, stock) VALUES
  (1, 'Fahrenheit', 'Masculino', 'Eau de Toilette', 100, 480.00, 12),
  (1, 'Miss Dior', 'Femenino', 'Eau de Parfum', 100, 590.00, 18),
  (1, 'Joy', 'Femenino', 'Eau de Parfum', 90, 530.00, 5),
  (2, 'Coco Mademoiselle', 'Femenino', 'Eau de Parfum', 100, 690.00, 14),
  (2, 'Allure Homme Sport', 'Masculino', 'Eau de Toilette', 100, 520.00, 9),
  (2, 'No 5', 'Femenino', 'Parfum', 50, 750.00, 4),
  (3, 'Euphoria', 'Femenino', 'Eau de Parfum', 100, 310.00, 22),
  (3, 'Eternity', 'Masculino', 'Eau de Toilette', 100, 280.00, 15),
  (3, 'Obsession', 'Unisex', 'Eau de Parfum', 120, 260.00, 0),
  (4, 'Dylan Blue', 'Masculino', 'Eau de Toilette', 100, 420.00, 11),
  (4, 'Bright Crystal', 'Femenino', 'Eau de Toilette', 90, 390.00, 16),
  (5, 'Black Orchid', 'Unisex', 'Eau de Parfum', 100, 720.00, 6),
  (5, 'Oud Wood', 'Unisex', 'Parfum', 50, 950.00, 3),
  (6, 'Acqua Di Gio', 'Masculino', 'Eau de Toilette', 100, 460.00, 20),
  (6, 'Si', 'Femenino', 'Eau de Parfum', 100, 540.00, 13),
  (7, 'Y', 'Masculino', 'Eau de Parfum', 100, 510.00, 8),
  (7, 'Black Opium', 'Femenino', 'Eau de Parfum', 90, 560.00, 10),
  (8, 'Good Girl', 'Femenino', 'Eau de Parfum', 80, 530.00, 25),
  (8, 'Bad Boy', 'Masculino', 'Eau de Toilette', 100, 490.00, 17),
  (9, 'One Million', 'Masculino', 'Eau de Toilette', 100, 440.00, 30);

-- 3. CLIENTES (20 Registros)
INSERT INTO cliente (nombre, apellido, dni_ruc, telefono, email, direccion) VALUES
  ('Carlos', 'Mendoza', '75678901', '965678901', 'carlos.m@gmail.com', 'Pucallpa'),
  ('Maria', 'Flores', '76789012', '966789012', 'maria.f@hotmail.com', 'Lima'),
  ('Lucia', 'Ramos', '77890123', '967890123', 'lucia.r@gmail.com', 'Arequipa'),
  ('Jorge', 'Salas', '78901234', '968901234', 'jorge.s@outlook.com', 'Pucallpa'),
  ('Sofia', 'Vargas', '79012345', '969012345', 'sofia.v@gmail.com', 'Cusco'),
  ('Diego', 'Cordova', '70123456', '960123456', 'diego.c@yahoo.com', 'Trujillo'),
  ('Elena', 'Gomez', '71112233', '961112233', 'elena.g@gmail.com', 'Lima'),
  ('Renzo', 'Paredes', '72223344', '962223344', 'renzo.p@hotmail.com', 'Pucallpa'),
  ('Valeria', 'Rios', '73334455', '963334455', 'valeria.r@gmail.com', 'Huancayo'),
  ('Gabriel', 'Castillo', '74445566', '964445566', 'gabriel.c@gmail.com', 'Iquitos'),
  ('Camila', 'Torres', '75556677', '965556677', 'camila.t@outlook.com', 'Lima'),
  ('Mateo', 'Suarez', '76667788', '966667788', 'mateo.s@gmail.com', 'Tacna'),
  ('Paula', 'Navarro', '77778899', '967778899', 'paula.n@gmail.com', 'Pucallpa'),
  ('Luis', 'Espinoza', '78889900', '968889900', 'luis.e@hotmail.com', 'Piura'),
  ('Fernanda', 'Morales', '79990011', '969990011', 'fernanda.m@gmail.com', 'Lima'),
  ('Hugo', 'Benitez', '70001122', '960001122', 'hugo.b@gmail.com', 'Chiclayo'),
  ('Natalia', 'Soto', '71122334', '961223344', 'natalia.s@outlook.com', 'Pucallpa'),
  ('Kevin', 'Pacheco', '72233445', '962334455', 'kevin.p@gmail.com', 'Arequipa'),
  ('Daniela', 'Rojas', '73344556', '963445566', 'daniela.r@gmail.com', 'Lima'),
  ('Santi', 'Arias', '74455667', '964556677', 'santi.a@hotmail.com', 'Pucallpa');

-- 4. VENTAS (20 Registros: IDs del 1 al 20)
INSERT INTO venta (id_cliente, metodo_pago, tipo_comprobante, monto_total) VALUES
  (1,  'yape',     'boleta',   480.00),
  (2,  'tarjeta',  'factura',  690.00),
  (3,  'efectivo', 'boleta',   520.00),
  (4,  'plin',     'boleta',   310.00),
  (5,  'tarjeta',  'factura',  720.00),
  (6,  'yape',     'boleta',   460.00),
  (7,  'efectivo', 'boleta',   530.00),
  (8,  'tarjeta',  'factura',  440.00),
  (9,  'yape',     'boleta',   590.00),
  (10, 'plin',     'boleta',   390.00),
  (11, 'tarjeta',  'factura',  950.00),
  (12, 'efectivo', 'boleta',   540.00),
  (13, 'yape',     'boleta',   510.00),
  (14, 'tarjeta',  'boleta',   560.00),
  (15, 'plin',     'boleta',   490.00),
  (16, 'yape',     'factura',  750.00),
  (17, 'efectivo', 'boleta',   280.00),
  (18, 'tarjeta',  'boleta',   420.00),
  (19, 'yape',     'boleta',   530.00),
  (20, 'plin',     'factura',  960.00);

-- 5. DETALLE_VENTA (20 Registros: Vinculados a ventas 1-20 y perfumes 1-20)
INSERT INTO detalle_venta (id_venta, id_perfume, cantidad, precio_unitario, descuento) VALUES
  (1,  1,  1, 480.00, 0.00),
  (2,  4,  1, 690.00, 0.00),
  (3,  5,  1, 520.00, 0.00),
  (4,  7,  1, 310.00, 0.00),
  (5,  12, 1, 720.00, 0.00),
  (6,  14, 1, 460.00, 0.00),
  (7,  18, 1, 530.00, 0.00),
  (8,  20, 1, 440.00, 0.00),
  (9,  2,  1, 590.00, 0.00),
  (10, 11, 1, 390.00, 0.00),
  (11, 13, 1, 950.00, 0.00),
  (12, 15, 1, 540.00, 0.00),
  (13, 16, 1, 510.00, 0.00),
  (14, 17, 1, 560.00, 0.00),
  (15, 19, 1, 490.00, 0.00),
  (16, 6,  1, 750.00, 0.00),
  (17, 8,  1, 280.00, 0.00),
  (18, 10, 1, 420.00, 0.00),
  (19, 3,  1, 530.00, 0.00),
  (20, 1,  2, 480.00, 0.00);

-- 6. RECEPCION_CARGA (20 Registros)
INSERT INTO recepcion_carga (id_perfume, numero_lote, cantidad_recibida, fecha_recepcion) VALUES
  (1,  'LOT-2026-001', 50, '2026-06-01'),
  (2,  'LOT-2026-002', 30, '2026-06-03'),
  (3,  'LOT-2026-003', 20, '2026-06-05'),
  (4,  'LOT-2026-004', 40, '2026-06-10'),
  (5,  'LOT-2026-005', 15, '2026-06-12'),
  (6,  'LOT-2026-006', 35, '2026-06-15'),
  (7,  'LOT-2026-007', 25, '2026-06-18'),
  (8,  'LOT-2026-008', 30, '2026-06-20'),
  (9,  'LOT-2026-009', 10, '2026-06-22'),
  (10, 'LOT-2026-010', 45, '2026-06-25'),
  (11, 'LOT-2026-011', 20, '2026-07-01'),
  (12, 'LOT-2026-012', 15, '2026-07-03'),
  (13, 'LOT-2026-013', 10, '2026-07-05'),
  (14, 'LOT-2026-014', 50, '2026-07-08'),
  (15, 'LOT-2026-015', 30, '2026-07-10'),
  (16, 'LOT-2026-016', 25, '2026-07-12'),
  (17, 'LOT-2026-017', 20, '2026-07-15'),
  (18, 'LOT-2026-018', 40, '2026-07-18'),
  (19, 'LOT-2026-019', 30, '2026-07-20'),
  (20, 'LOT-2026-020', 50, '2026-07-22');

-- 7. PEDIDO_ENVIO (20 Registros: IDs de venta 1 al 20)
INSERT INTO pedido_envio (id_venta, fecha_pedido, fecha_entrega, estado_envio) VALUES
  (1,  '2026-08-01', '2026-08-03', 'ENTREGADO'),
  (2,  '2026-08-02', '2026-08-04', 'ENTREGADO'),
  (3,  '2026-08-03', '2026-08-05', 'ENTREGADO'),
  (4,  '2026-08-04', '2026-08-07', 'ENTREGADO'),
  (5,  '2026-08-05', '2026-08-08', 'ENTREGADO'),
  (6,  '2026-08-06', '2026-08-09', 'ENTREGADO'),
  (7,  '2026-08-07', '2026-08-10', 'ENTREGADO'),
  (8,  '2026-08-08', '2026-08-11', 'ENTREGADO'),
  (9,  '2026-08-10', '2026-08-13', 'ENTREGADO'),
  (10, '2026-08-12', '2026-08-15', 'ENTREGADO'),
  (11, '2026-08-14', '2026-08-16', 'ENTREGADO'),
  (12, '2026-08-15', '2026-08-18', 'ENTREGADO'),
  (13, '2026-08-17', '2026-08-20', 'ENTREGADO'),
  (14, '2026-08-19', '2026-08-22', 'ENTREGADO'),
  (15, '2026-08-21', '2026-08-24', 'ENTREGADO'),
  (16, '2026-08-23', '2026-08-25', 'ENTREGADO'),
  (17, '2026-08-25', '2026-08-28', 'ENTREGADO'),
  (18, '2026-08-26', NULL,         'EN TRANSITO'),
  (19, '2026-08-27', NULL,         'PENDIENTE'),
  (20, '2026-08-28', NULL,         'PENDIENTE');

-- =====================================================================
-- EJERCICIOS Y CONSULTAS
-- =====================================================================

-- Consulta 1: Perfumes con el nombre de su marca
SELECT p.nombre AS perfume, 
       m.nombre_marca, 
       p.precio, 
       p.stock
FROM perfume p
JOIN marca m ON p.id_marca = m.id_marca
ORDER BY p.precio DESC;

-- Consulta 2: Detalle completo de ventas por cliente
SELECT v.id_venta,
       c.nombre || ' ' || c.apellido AS cliente,
       pr.nombre AS perfume,
       d.cantidad,
       d.precio_unitario,
       d.subtotal,
       v.metodo_pago
FROM detalle_venta d
JOIN venta v   ON d.id_venta   = v.id_venta
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN perfume pr ON d.id_perfume = pr.id_perfume;

-- RETO a) ¿Cuántas ventas ha realizado cada cliente?
SELECT c.nombre, 
       c.apellido, 
       COUNT(v.id_venta) AS total_ventas
FROM cliente c
LEFT JOIN venta v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY total_ventas DESC;

-- RETO b) Perfumes que NUNCA se han vendido
SELECT p.nombre, p.precio
FROM perfume p
LEFT JOIN detalle_venta d ON p.id_perfume = d.id_perfume
WHERE d.id_detalle IS NULL;

-- RETO c) Marcas que tienen más de 1 perfume registrado
SELECT m.nombre_marca, 
       COUNT(p.id_perfume) AS total_perfumes
FROM marca m
JOIN perfume p ON m.id_marca = p.id_marca
GROUP BY m.id_marca, m.nombre_marca
HAVING COUNT(p.id_perfume) > 1;

-- RETO d) Perfumes que cuestan más que el promedio del catálogo
SELECT nombre, precio
FROM perfume
WHERE precio > (SELECT AVG(precio) FROM perfume);
