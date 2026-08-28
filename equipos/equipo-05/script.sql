-- =====================================================
-- SISTEMA DE RESERVAS DE VÓLEY PLAYA
-- =====================================================

CREATE SCHEMA IF NOT EXISTS voley_playa;

SET search_path TO voley_playa;
SELECT current_schema();

-- =====================================================
-- ELIMINAR TABLAS SI YA EXISTEN
-- =====================================================

DROP TABLE IF EXISTS pago;
DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS horario;
DROP TABLE IF EXISTS cancha;
DROP TABLE IF EXISTS cliente;

-- =====================================================
-- TABLAs 
-- =====================================================


CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100) UNIQUE
);



CREATE TABLE cancha (
    id_cancha SERIAL PRIMARY KEY,
    numero INT NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    tipo_superficie VARCHAR(50) DEFAULT 'Arena',
    estado VARCHAR(50) DEFAULT 'Disponible'
);



CREATE TABLE horario (
    id_horario SERIAL PRIMARY KEY,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);



CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES cliente(id_cliente),
    id_cancha INT NOT NULL REFERENCES cancha(id_cancha),
    id_horario INT NOT NULL REFERENCES horario(id_horario),
    fecha_reserva DATE NOT NULL,
    estado VARCHAR(50)DEFAULT 'Pendiente',
    total DECIMAL(10,2) NOT NULL
);



CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL REFERENCES reserva(id_reserva),
    fecha_pago DATE,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    estado VARCHAR(50) DEFAULT 'Pendiente'
);

-- =====================================================
-- INSERTAR DATOS DE PRUEBA
-- =====================================================

-- ============================================
-- 20 CLIENTES
-- ============================================

INSERT INTO cliente (nombre, apellido, dni, telefono, email) VALUES
('Juan', 'Perez', '70123456', '987654321', 'juan.perez@gmail.com'),
('Maria', 'Gomez', '70234567', '986543210', 'maria.gomez@gmail.com'),
('Carlos', 'Rodriguez', '70345678', '985432109', 'carlos.rodriguez@gmail.com'),
('Ana', 'Martinez', '70456789', '984321098', 'ana.martinez@gmail.com'),
('Luis', 'Fernandez', '70567890', '983210987', 'luis.fernandez@gmail.com'),
('Sofia', 'Torres', '70678901', '982109876', 'sofia.torres@gmail.com'),
('Diego', 'Ramirez', '70789012', '981098765', 'diego.ramirez@gmail.com'),
('Laura', 'Castillo', '70890123', '980987654', 'laura.castillo@gmail.com'),
('Pedro', 'Vargas', '70901234', '979876543', 'pedro.vargas@gmail.com'),
('Camila', 'Rojas', '71012345', '978765432', 'camila.rojas@gmail.com'),
('Jorge', 'Mendoza', '71123456', '977654321', 'jorge.mendoza@gmail.com'),
('Valeria', 'Cruz', '71234567', '976543210', 'valeria.cruz@gmail.com'),
('Miguel', 'Sanchez', '71345678', '975432109', 'miguel.sanchez@gmail.com'),
('Daniela', 'Flores', '71456789', '974321098', 'daniela.flores@gmail.com'),
('Andres', 'Gutierrez', '71567890', '973210987', 'andres.gutierrez@gmail.com'),
('Paola', 'Diaz', '71678901', '972109876', 'paola.diaz@gmail.com'),
('Ricardo', 'Morales', '71789012', '971098765', 'ricardo.morales@gmail.com'),
('Gabriela', 'Navarro', '71890123', '970987654', 'gabriela.navarro@gmail.com'),
('Fernando', 'Silva', '71901234', '969876543', 'fernando.silva@gmail.com'),
('Lucia', 'Herrera', '72012345', '968765432', 'lucia.herrera@gmail.com');


-- ============================================
-- 20 CANCHAS
-- ============================================

INSERT INTO cancha(numero, nombre, tipo_superficie, estado) VALUES
(1, 'Cancha Principal', 'Arena', 'Disponible'),
(2, 'Cancha Norte', 'Cemento', 'Disponible'),
(3, 'Cancha Sur', 'Grass Sintetico', 'Disponible'),
(4, 'Cancha Este', 'Arena', 'Disponible'),
(5, 'Cancha Oeste', 'Cemento', 'Mantenimiento'),
(6, 'Cancha Premium 1', 'Grass Sintetico', 'Disponible'),
(7, 'Cancha Premium 2', 'Arena', 'Disponible'),
(8, 'Cancha Central', 'Cemento', 'Disponible'),
(9, 'Cancha A', 'Arena', 'Disponible'),
(10, 'Cancha B', 'Grass Sintetico', 'Disponible'),
(11, 'Cancha C', 'Cemento', 'Disponible'),
(12, 'Cancha D', 'Arena', 'Mantenimiento'),
(13, 'Cancha E', 'Grass Sintetico', 'Disponible'),
(14, 'Cancha F', 'Arena', 'Disponible'),
(15, 'Cancha G', 'Cemento', 'Disponible'),
(16, 'Cancha H', 'Grass Sintetico', 'Disponible'),
(17, 'Cancha I', 'Arena', 'Disponible'),
(18, 'Cancha J', 'Cemento', 'Disponible'),
(19, 'Cancha K', 'Grass Sintetico', 'Mantenimiento'),
(20, 'Cancha L', 'Arena', 'Disponible');


-- ============================================
-- 20 HORARIOS
-- ============================================

INSERT INTO horario (hora_inicio, hora_fin, precio) VALUES
('08:00', '09:00', 30.00),
('09:00', '10:00', 30.00),
('10:00', '11:00', 35.00),
('11:00', '12:00', 35.00),
('12:00', '13:00', 40.00),
('13:00', '14:00', 40.00),
('14:00', '15:00', 40.00),
('15:00', '16:00', 45.00),
('16:00', '17:00', 45.00),
('17:00', '18:00', 50.00),
('18:00', '19:00', 50.00),
('19:00', '20:00', 55.00),
('20:00', '21:00', 55.00),
('21:00', '22:00', 60.00),
('22:00', '23:00', 60.00),
('23:00', '00:00', 50.00),
('06:00', '07:00', 25.00),
('07:00', '08:00', 25.00),
('23:00', '00:00', 55.00),
('00:00', '01:00', 50.00);


-- ============================================
-- 20 RESERVAS
-- ============================================

INSERT INTO reserva (id_cliente, id_cancha, id_horario, fecha_reserva, estado, total) VALUES
(1, 1, 1, '2026-09-01', 'Confirmada', 30.00),
(2, 2, 2, '2026-09-01', 'Confirmada', 30.00),
(3, 3, 3, '2026-09-02', 'Pendiente', 35.00),
(4, 4, 4, '2026-09-02', 'Confirmada', 35.00),
(5, 5, 5, '2026-09-03', 'Cancelada', 40.00),
(6, 6, 6, '2026-09-03', 'Confirmada', 40.00),
(7, 7, 7, '2026-09-04', 'Pendiente', 40.00),
(8, 8, 8, '2026-09-04', 'Confirmada', 45.00),
(9, 9, 9, '2026-09-05', 'Confirmada', 45.00),
(10, 10, 10, '2026-09-05', 'Pendiente', 50.00),
(11, 11, 11, '2026-09-06', 'Confirmada', 50.00),
(12, 12, 12, '2026-09-06', 'Cancelada', 55.00),
(13, 13, 13, '2026-09-07', 'Confirmada', 55.00),
(14, 14, 14, '2026-09-07', 'Pendiente', 60.00),
(15, 15, 15, '2026-09-08', 'Confirmada', 60.00),
(16, 16, 16, '2026-09-08', 'Confirmada', 50.00),
(17, 17, 17, '2026-09-09', 'Pendiente', 25.00),
(18, 18, 18, '2026-09-09', 'Confirmada', 25.00),
(19, 19, 19, '2026-09-10', 'Cancelada', 55.00),
(20, 20, 20, '2026-09-10', 'Confirmada', 50.00);


-- ============================================
-- 20 PAGOS
-- ============================================

INSERT INTO pago 
(id_reserva, fecha_pago, monto, metodo_pago, estado) VALUES
(1, '2026-08-28', 30.00, 'Yape', 'Pagado'),
(2, '2026-08-28', 30.00, 'Plin', 'Pagado'),
(3, NULL, 35.00, 'Efectivo', 'Pendiente'),
(4, '2026-08-28', 35.00, 'Tarjeta', 'Pagado'),
(5, NULL, 40.00, 'Efectivo', 'Cancelado'),
(6, '2026-08-28', 40.00, 'Yape', 'Pagado'),
(7, NULL, 40.00, 'Plin', 'Pendiente'),
(8, '2026-08-28', 45.00, 'Tarjeta', 'Pagado'),
(9, '2026-08-28', 45.00, 'Yape', 'Pagado'),
(10, NULL, 50.00, 'Efectivo', 'Pendiente'),
(11, '2026-08-28', 50.00, 'Plin', 'Pagado'),
(12, NULL, 55.00, 'Tarjeta', 'Cancelado'),
(13, '2026-08-28', 55.00, 'Yape', 'Pagado'),
(14, NULL, 60.00, 'Efectivo', 'Pendiente'),
(15, '2026-08-28', 60.00, 'Tarjeta', 'Pagado'),
(16, '2026-08-28', 50.00, 'Plin', 'Pagado'),
(17, NULL, 25.00, 'Efectivo', 'Pendiente'),
(18, '2026-08-28', 25.00, 'Yape', 'Pagado'),
(19, NULL, 55.00, 'Tarjeta', 'Cancelado'),
(20, '2026-08-28', 50.00, 'Plin', 'Pagado');


==================================================================================
CONSULTAS
==================================================================================

--- 1)clientes que tienen reservas y qué cancha han reservado

SELECT 
    c.nombre,
    c.apellido,
    r.fecha_reserva,
    ca.nombre AS cancha,
    r.estado
FROM cliente c
INNER JOIN reserva r 
    ON c.id_cliente = r.id_cliente
INNER JOIN cancha ca 
    ON r.id_cancha = ca.id_cancha;

--- 2)reservas que se encuentran confirmadas

SELECT 
    r.id_reserva,
    c.nombre || ' ' || c.apellido AS cliente,
    ca.nombre AS cancha,
    r.fecha_reserva,
    r.total
FROM reserva r
INNER JOIN cliente c 
    ON r.id_cliente = c.id_cliente
INNER JOIN cancha ca 
    ON r.id_cancha = ca.id_cancha
WHERE r.estado = 'Confirmada';

--- 3)canchas se encuentran disponibles actualmente

SELECT 
    id_cancha,
    numero,
    nombre,
    tipo_superficie,
    estado
FROM cancha
WHERE estado = 'Disponible';

--- 4)horario tiene asignado cada reserva

SELECT 
    r.id_reserva,
    c.nombre || ' ' || c.apellido AS cliente,
    ca.nombre AS cancha,
    h.hora_inicio,
    h.hora_fin,
    r.fecha_reserva
FROM reserva r
INNER JOIN cliente c 
    ON r.id_cliente = c.id_cliente
INNER JOIN cancha ca 
    ON r.id_cancha = ca.id_cancha
INNER JOIN horario h 
    ON r.id_horario = h.id_horario;

--- 5)pagos han sido realizados y mediante qué método de pago

SELECT 
    p.id_pago,
    c.nombre || ' ' || c.apellido AS cliente,
    p.fecha_pago,
    p.monto,
    p.metodo_pago,
    p.estado
FROM pago p
INNER JOIN reserva r 
    ON p.id_reserva = r.id_reserva
INNER JOIN cliente c 
    ON r.id_cliente = c.id_cliente
WHERE p.estado = 'Pagado';

--- 6)dinero se ha recaudado en total mediante los pagos realizados

SELECT 
    SUM(monto) AS total_recaudado
FROM pago
WHERE estado = 'Pagado';

--- 7)reservas existen según su estado

SELECT 
    estado,
    COUNT(*) AS cantidad_reservas
FROM reserva
GROUP BY estado
ORDER BY cantidad_reservas DESC;

--- 8)cliente ha realizado el mayor monto de pagos

SELECT 
    c.nombre || ' ' || c.apellido AS cliente,
    SUM(p.monto) AS total_pagado
FROM cliente c
INNER JOIN reserva r 
    ON c.id_cliente = r.id_cliente
INNER JOIN pago p 
    ON r.id_reserva = p.id_reserva
WHERE p.estado = 'Pagado'
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY total_pagado DESC
LIMIT 1;

--- 9)detalle completo de cada reserva, incluyendo cliente, cancha, horario, precio y pago

SELECT 
    r.id_reserva,
    c.nombre || ' ' || c.apellido AS cliente,
    c.dni,
    ca.nombre AS cancha,
    ca.tipo_superficie,
    r.fecha_reserva,
    h.hora_inicio,
    h.hora_fin,
    r.total,
    p.monto,
    p.metodo_pago,
    p.estado AS estado_pago
FROM reserva r
INNER JOIN cliente c 
    ON r.id_cliente = c.id_cliente
INNER JOIN cancha ca 
    ON r.id_cancha = ca.id_cancha
INNER JOIN horario h 
    ON r.id_horario = h.id_horario
LEFT JOIN pago p 
    ON r.id_reserva = p.id_reserva
ORDER BY r.fecha_reserva;

--- 10)reservas están programadas para el día 5 de septiembre de 2026

SELECT 
    r.id_reserva,
    c.nombre || ' ' || c.apellido AS cliente,
    ca.nombre AS cancha,
    h.hora_inicio,
    h.hora_fin,
    r.estado,
    r.total
FROM reserva r
INNER JOIN cliente c 
    ON r.id_cliente = c.id_cliente
INNER JOIN cancha ca 
    ON r.id_cancha = ca.id_cancha
INNER JOIN horario h 
    ON r.id_horario = h.id_horario
WHERE r.fecha_reserva = '2026-09-05';
