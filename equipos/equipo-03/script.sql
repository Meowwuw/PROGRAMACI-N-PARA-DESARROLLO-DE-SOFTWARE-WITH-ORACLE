-- ============================================================
-- CREACIÓN DE ESQUEMA
-- ============================================================
CREATE SCHEMA IF NOT EXISTS renta_cancha;
SET search_path TO renta_cancha, public;

-- ============================================================
-- ELIMINACIÓN PREVIA DE TABLAS (LIMPIEZA)
-- ============================================================
DROP TABLE IF EXISTS pago CASCADE;
DROP TABLE IF EXISTS reserva CASCADE;
DROP TABLE IF EXISTS horario CASCADE;
DROP TABLE IF EXISTS cancha CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;

-- ============================================================
-- TABLA CLIENTE
-- ============================================================
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    telefono VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(8) NOT NULL UNIQUE
);

-- ============================================================
-- TABLA CANCHA
-- ============================================================
CREATE TABLE cancha (
    id_cancha SERIAL PRIMARY KEY,
    numero_cancha INT NOT NULL UNIQUE
);

-- ============================================================
-- TABLA HORARIO
-- ============================================================
CREATE TABLE horario (
    id_horario SERIAL PRIMARY KEY,
    hora TIME NOT NULL UNIQUE,
    precio DECIMAL(10,2) NOT NULL
);

-- ============================================================
-- TABLA RESERVA
-- ============================================================
CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_cancha INT NOT NULL,
    id_horario INT NOT NULL,
    fecha DATE NOT NULL,
    -- CORREGIDO: La restricción única debe ser por FECHA, CANCHA y HORARIO
    -- para permitir que distintas canchas se alquilen en un mismo horario.
    CONSTRAINT reserva_unica UNIQUE (fecha, id_cancha, id_horario),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_cancha) REFERENCES cancha(id_cancha) ON DELETE CASCADE,
    FOREIGN KEY (id_horario) REFERENCES horario(id_horario) ON DELETE CASCADE
);

-- ============================================================
-- TABLA PAGO
-- ============================================================
CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL UNIQUE,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva) ON DELETE CASCADE
);

-- ============================================================
-- INSERTS CLIENTE
-- ============================================================
INSERT INTO cliente (telefono, nombre, apellido, dni) VALUES
('987654321', 'Juan', 'Perez', '12345678'),
('986123456', 'Maria', 'Lopez', '87654321'),
('985456789', 'Carlos', 'Gomez', '12457836'),
('984789123', 'Ana', 'Torres', '98653214'),
('983456789', 'Pedro', 'Ramirez', '89541263');

-- ============================================================
-- INSERTS CANCHA
-- ============================================================
INSERT INTO cancha (numero_cancha) VALUES
(1), (2), (3), (4), (5);

-- ============================================================
-- INSERTS HORARIO
-- ============================================================
INSERT INTO horario (hora, precio) VALUES
('08:00:00', 20.00),
('09:00:00', 20.00),
('10:00:00', 25.00),
('11:00:00', 25.00),
('12:00:00', 30.00),
('13:00:00', 30.00),
('14:00:00', 35.00),
('15:00:00', 35.00),
('16:00:00', 40.00),
('17:00:00', 40.00),
('18:00:00', 50.00);

-- ============================================================
-- INSERTS RESERVA
-- ============================================================
INSERT INTO reserva (id_cliente, id_cancha, id_horario, fecha) VALUES
(1, 1, 1, '2026-08-28'),
(2, 2, 2, '2026-08-28'),
(3, 3, 3, '2026-08-28'),
(4, 4, 4, '2026-08-29'),
(5, 5, 5, '2026-08-29'),
(1, 2, 6, '2026-08-30'),
(1, 1, 1, '2026-09-28'),
(2, 2, 2, '2026-09-28'),
(3, 3, 3, '2026-09-28'),
(4, 4, 4, '2026-09-29'),
(5, 5, 5, '2026-09-29'),
(1, 2, 6, '2026-09-30'),
(1, 1, 1, '2026-10-28'),
(2, 2, 2, '2026-10-28'),
(3, 3, 3, '2026-10-28'),
(4, 4, 4, '2026-10-29'),
(5, 5, 5, '2026-10-29'),
(1, 2, 6, '2026-10-30');

-- ============================================================
-- INSERTS PAGO
-- ============================================================
INSERT INTO pago (id_reserva, total)
SELECT
    r.id_reserva,
    h.precio AS total
FROM reserva r
INNER JOIN horario h ON r.id_horario = h.id_horario
LEFT JOIN pago p ON r.id_reserva = p.id_reserva
WHERE p.id_reserva IS NULL;

-- ============================================================
-- CONSULTA GENERAL DE RESERVAS
-- ============================================================
SELECT
    r.id_reserva,
    c.nombre || ' ' || c.apellido AS cliente,
    ca.numero_cancha,
    r.fecha,
    h.hora,
    h.precio AS precio_por_hora,
    p.total
FROM reserva r
INNER JOIN cliente c ON r.id_cliente = c.id_cliente
INNER JOIN cancha ca ON r.id_cancha = ca.id_cancha
INNER JOIN horario h ON r.id_horario = h.id_horario
LEFT JOIN pago p ON r.id_reserva = p.id_reserva
ORDER BY r.id_reserva;

-- ============================================================
-- VER RECAUDACIÓN TOTAL POR CANCHA
-- ============================================================
SELECT
    ca.id_cancha,
    ca.numero_cancha,
    COALESCE(SUM(p.total), 0.00) AS total_ganado
FROM cancha ca
LEFT JOIN reserva r ON ca.id_cancha = r.id_cancha
LEFT JOIN pago p ON r.id_reserva = p.id_reserva
GROUP BY ca.id_cancha, ca.numero_cancha
ORDER BY ca.numero_cancha;
