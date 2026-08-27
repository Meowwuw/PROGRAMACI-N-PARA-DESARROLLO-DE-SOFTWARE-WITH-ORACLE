-- ============================================================
-- TABLA CLIENTE
-- ============================================================

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    telefono VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT null,
    dni INT not null
);


-- ============================================================
-- TABLA CANCHA
-- ============================================================

CREATE TABLE cancha (
    id SERIAL PRIMARY KEY,
    numero_cancha INT NOT NULL UNIQUE
);


-- ============================================================
-- TABLA HORARIO
-- ============================================================

CREATE TABLE horario (
    id SERIAL PRIMARY KEY,
    hora TIME NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);


-- ============================================================
-- TABLA RESERVA
-- ============================================================

CREATE TABLE reserva (
    id SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_cancha INT NOT NULL,
    id_horario INT NOT NULL,
    horas_alquilado INT NOT NULL,
    fecha DATE NOT NULL,

    CONSTRAINT reserva_unica
    UNIQUE (id_cancha, fecha, id_horario),

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id)
        ON DELETE CASCADE,

    FOREIGN KEY (id_cancha)
        REFERENCES cancha(id)
        ON DELETE CASCADE,

    FOREIGN KEY (id_horario)
        REFERENCES horario(id)
        ON DELETE CASCADE
);


-- ============================================================
-- TABLA PAGO
-- ============================================================

CREATE TABLE pago (
    id SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL UNIQUE,
    total DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_reserva)
        REFERENCES reserva(id)
        ON DELETE CASCADE
);


-- ============================================================
-- INSERTS CLIENTE
-- ============================================================

INSERT INTO cliente (telefono, nombre, apellido)
VALUES
('987654321', 'Juan', 'Perez'),
('986123456', 'Maria', 'Lopez'),
('985456789', 'Carlos', 'Gomez'),
('984789123', 'Ana', 'Torres'),
('983456789', 'Pedro', 'Ramirez');


-- ============================================================
-- INSERTS CANCHA
-- ============================================================

INSERT INTO cancha (numero_cancha)
VALUES
(1),
(2),
(3),
(4),
(5);


-- ============================================================
-- INSERTS HORARIO
-- ============================================================
-- El precio depende del horario.
--
-- 08:00 = S/ 20
-- 10:00 = S/ 25
-- 12:00 = S/ 30
-- 14:00 = S/ 35
-- 16:00 = S/ 40
-- 18:00 = S/ 50
--
-- El precio es POR HORA.


INSERT INTO horario (hora, precio)
VALUES
('08:00:00', 20.00),
('10:00:00', 25.00),
('12:00:00', 30.00),
('14:00:00', 35.00),
('16:00:00', 40.00),
('18:00:00', 50.00);


-- ============================================================
-- INSERTS RESERVA
-- ============================================================

INSERT INTO reserva (
    id_cliente,
    id_cancha,
    id_horario,
    horas_alquilado,
    fecha
)
VALUES
(1, 1, 1, 2, '2026-08-28'),
(2, 2, 2, 1, '2026-08-28'),
(3, 3, 3, 2, '2026-08-28'),
(4, 4, 4, 1, '2026-08-29'),
(5, 5, 5, 2, '2026-08-29'),
(1, 2, 6, 1, '2026-08-30');


-- ============================================================
-- INSERTS PAGO
-- ============================================================
-- El TOTAL se calcula mediante SUM.
--
-- total = SUM(horas_alquilado * precio)
--
-- Ejemplo:
-- Reserva 1 = 2 horas * S/20 = S/40
-- Reserva 2 = 1 hora  * S/25 = S/25
-- Reserva 3 = 2 horas * S/30 = S/60


INSERT INTO pago (id_reserva, total)
SELECT
    r.id,
    SUM(r.horas_alquilado * h.precio) AS total
FROM reserva r
INNER JOIN horario h
    ON r.id_horario = h.id
GROUP BY r.id;


-- ============================================================
-- CONSULTA GENERAL DE RESERVAS
-- ============================================================

SELECT
    r.id AS id_reserva,
    c.nombre || ' ' || c.apellido AS cliente,
    ca.numero_cancha AS numero_cancha,
    r.fecha,
    h.hora,
    r.horas_alquilado,
    h.precio AS precio_por_hora,
    SUM(r.horas_alquilado * h.precio) AS total
FROM reserva r
INNER JOIN cliente c
    ON r.id_cliente = c.id
INNER JOIN cancha ca
    ON r.id_cancha = ca.id
INNER JOIN horario h
    ON r.id_horario = h.id
GROUP BY
    r.id,
    c.nombre,
    c.apellido,
    ca.numero_cancha,
    r.fecha,
    h.hora,
    r.horas_alquilado,
    h.precio
ORDER BY r.id;


-- ============================================================
-- VER PAGOS DE RESERVAS
-- ============================================================

SELECT
    p.id AS id_pago,
    p.id_reserva,
    p.total
FROM pago p
ORDER BY p.id;

-- ============================================================
-- VER PAGOS DE CUANTAS HORAS SE VENDIO EN UNA CANCHA
-- ============================================================

SELECT
    ca.id,
    ca.numero_cancha,
    SUM(p.total) AS total_ganado
FROM cancha ca
INNER JOIN reserva r
    ON ca.id = r.id_cancha
INNER JOIN horario h
    ON r.id_horario = h.id
INNER JOIN pago p
    ON r.id = p.id_reserva
INNER JOIN cliente c
    ON r.id_cliente = c.id
GROUP BY
    ca.id,
    ca.numero_cancha
ORDER BY
    ca.numero_cancha;

-- ============================================================
-- VER PAGOS TOTALES
-- ============================================================

SELECT
    SUM(p.total) AS total_pagos
FROM cancha ca
INNER JOIN reserva r
    ON ca.id = r.id_cancha
INNER JOIN horario h
    ON r.id_horario = h.id
INNER JOIN pago p
    ON r.id = p.id_reserva
INNER JOIN cliente c
    ON r.id_cliente = c.id;

