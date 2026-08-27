-- ============================================================
-- TABLA CLIENTE
-- ============================================================

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    telefono VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT null,
    dni VARCHAR(8) not null
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
    hora TIME NOT NULL,
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

    CONSTRAINT reserva_unica
    UNIQUE (id_cancha, fecha, id_horario),

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON DELETE CASCADE,

    FOREIGN KEY (id_cancha)
        REFERENCES cancha(id_cancha)
        ON DELETE CASCADE,

    FOREIGN KEY (id_horario)
        REFERENCES horario(id_horario)
        ON DELETE CASCADE
);


-- ============================================================
-- TABLA PAGO
-- ============================================================

CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL UNIQUE,
    total DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_reserva)
        REFERENCES reserva(id_reserva)
        ON DELETE CASCADE
);


-- ============================================================
-- INSERTS CLIENTE
-- ============================================================

INSERT INTO cliente (telefono, nombre, apellido,dni)
VALUES
('987654321', 'Juan', 'Perez','12345678'),
('986123456', 'Maria', 'Lopez','87654321'),
('985456789', 'Carlos', 'Gomez','12457836'),
('984789123', 'Ana', 'Torres','98653214'),
('983456789', 'Pedro', 'Ramirez','89541263');


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
--

La reserva solo puede tener un horario. ============================================================

INSERT INTO reserva (
    id_cliente,
    id_cancha,
    id_horario,
    fecha
)
VALUES
(1, 1, 1, '2026-08-28'),
(2, 2, 2, '2026-08-28'),
(3, 3, 3, '2026-08-28'),
(4, 4, 4, '2026-08-29'),
(5, 5, 5, '2026-08-29'),
(1, 2, 6, '2026-08-30');


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
    r.id_reserva,
    SUM(h.precio) AS total
FROM reserva r
INNER JOIN horario h
    ON r.id_horario = h.id_horario
GROUP BY r.id_reserva;


-- ============================================================
-- CONSULTA GENERAL DE RESERVAS
-- ============================================================

SELECT
    r.id_reserva AS id_reserva,
    c.nombre || ' ' || c.apellido AS cliente,
    ca.numero_cancha AS numero_cancha,
    r.fecha,
    h.hora,
    h.precio AS precio_por_hora,
    SUM(h.precio) AS total
FROM reserva r
INNER JOIN cliente c
    ON r.id_cliente = c.id_cliente
INNER JOIN cancha ca
    ON r.id_cancha = ca.id_cancha
INNER JOIN horario h
    ON r.id_horario = h.id_horario
GROUP BY
    r.id_reserva,
    c.nombre,
    c.apellido,
    ca.numero_cancha,
    r.fecha,
    h.hora,
    h.precio
ORDER BY r.id_reserva;


-- ============================================================
-- VER PAGOS DE RESERVAS
-- ============================================================

SELECT
    p.id_pago AS id_pago,
    p.id_reserva,
    p.total
FROM pago p
ORDER BY p.id_pago;

-- ============================================================
-- VER PAGOS DE CUANTAS HORAS SE VENDIO EN UNA CANCHA
-- ============================================================

SELECT
    ca.id_cancha,
    ca.numero_cancha,
    SUM(p.total) AS total_ganado
FROM cancha ca
INNER JOIN reserva r
    ON ca.id_cancha = r.id_cancha
INNER JOIN horario h
    ON r.id_horario = h.id_horario
INNER JOIN pago p
    ON r.id_reserva = p.id_reserva
INNER JOIN cliente c
    ON r.id_cliente = c.id_cliente
GROUP BY
    ca.id_cancha,
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
    ON ca.id_cancha = r.id_cancha
INNER JOIN horario h
    ON r.id_horario = h.id_horario
INNER JOIN pago p
    ON r.id_reserva = p.id_reserva
INNER JOIN cliente c
    ON r.id_cliente = c.id_cliente;
