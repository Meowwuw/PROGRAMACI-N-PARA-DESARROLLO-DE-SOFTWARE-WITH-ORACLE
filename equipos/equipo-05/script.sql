-- =====================================================
-- SISTEMA DE RESERVAS DE VÓLEY PLAYA
-- =====================================================

CREATE SCHEMA IF NOT EXISTS voley_playa;

SET search_path TO voley_playa;

-- =====================================================
-- ELIMINAR TABLAS SI YA EXISTEN
-- =====================================================

DROP TABLE IF EXISTS pago;
DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS horario;
DROP TABLE IF EXISTS cancha;
DROP TABLE IF EXISTS cliente;

-- =====================================================
-- TABLA 1: CLIENTE
-- =====================================================

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(80) UNIQUE NOT NULL,
    telefono VARCHAR(15) NOT NULL,

    CONSTRAINT cliente_correo_check
    CHECK (correo LIKE '%@%')
);

-- =====================================================
-- INSERTAR CLIENTES
-- =====================================================

INSERT INTO cliente
(nombre, apellido, correo, telefono)
VALUES
('Ana', 'Quispe', 'ana@gmail.com', '987654321'),
('Luis', 'Ramirez', 'luis@gmail.com', '986543210'),
('Rosa', 'Tello', 'rosa@gmail.com', '985432109'),
('Carlos', 'Torres', 'carlos@gmail.com', '984321098'),
('Maria', 'Flores', 'maria@gmail.com', '983210987');

-- =====================================================
-- TABLA 2: CANCHA
-- =====================================================

CREATE TABLE cancha (
    id_cancha SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    tipo VARCHAR(30) NOT NULL DEFAULT 'VOLEY PLAYA',
    precio_hora NUMERIC(10,2) NOT NULL DEFAULT 20.00,

    CONSTRAINT precio_cancha_check
    CHECK (precio_hora = 20.00)
);

-- =====================================================
-- INSERTAR LAS 2 CANCHAS
-- =====================================================

INSERT INTO cancha
(nombre, tipo, precio_hora)
VALUES
('Cancha 1', 'VOLEY PLAYA', 20.00),
('Cancha 2', 'VOLEY PLAYA', 20.00);

-- =====================================================
-- TABLA 3: HORARIO
-- =====================================================

CREATE TABLE horario (
    id_horario SERIAL PRIMARY KEY,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,

    CONSTRAINT horario_valido
    CHECK (
        hora_inicio >= '16:00:00'
        AND hora_fin <= '21:00:00'
        AND hora_inicio < hora_fin
    )
);

-- =====================================================
-- INSERTAR HORARIOS
-- De 4 PM hasta 9 PM
-- =====================================================

INSERT INTO horario
(hora_inicio, hora_fin)
VALUES
('16:00', '17:00'),
('17:00', '18:00'),
('18:00', '19:00'),
('19:00', '20:00'),
('20:00', '21:00');

-- =====================================================
-- TABLA 4: RESERVA
-- =====================================================

CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,

    id_cliente INT NOT NULL,
    id_cancha INT NOT NULL,
    id_horario INT NOT NULL,

    fecha DATE NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'RESERVADO',

    CONSTRAINT fk_reserva_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente),

    CONSTRAINT fk_reserva_cancha
    FOREIGN KEY (id_cancha)
    REFERENCES cancha(id_cancha),

    CONSTRAINT fk_reserva_horario
    FOREIGN KEY (id_horario)
    REFERENCES horario(id_horario),

    CONSTRAINT estado_reserva_check
    CHECK (
        estado IN (
            'RESERVADO',
            'CANCELADO',
            'FINALIZADO'
        )
    ),

    -- EVITA QUE DOS PERSONAS RESERVEN
    -- LA MISMA CANCHA, FECHA Y HORARIO
    CONSTRAINT reserva_unica
    UNIQUE (
        id_cancha,
        fecha,
        id_horario
    )
);

-- =====================================================
-- INSERTAR RESERVAS
-- =====================================================

INSERT INTO reserva
(id_cliente, id_cancha, id_horario, fecha, estado)
VALUES
(1, 1, 1, '2026-08-28', 'RESERVADO'),
(2, 2, 1, '2026-08-28', 'RESERVADO'),
(3, 1, 2, '2026-08-28', 'RESERVADO'),
(4, 2, 3, '2026-08-28', 'RESERVADO'),
(5, 1, 4, '2026-08-28', 'RESERVADO');

-- =====================================================
-- TABLA 5: PAGO
-- =====================================================

CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL UNIQUE,
    monto NUMERIC(10,2) NOT NULL DEFAULT 20.00,
    metodo_pago VARCHAR(30) NOT NULL,
    estado_pago VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',

    CONSTRAINT fk_pago_reserva
    FOREIGN KEY (id_reserva)
    REFERENCES reserva(id_reserva),

    CONSTRAINT monto_pago_check
    CHECK (monto = 20.00),

    CONSTRAINT metodo_pago_check
    CHECK (
        metodo_pago IN (
            'EFECTIVO',
            'YAPE',
            'PLIN',
            'TARJETA'
        )
    ),

    CONSTRAINT estado_pago_check
    CHECK (
        estado_pago IN (
            'PENDIENTE',
            'PAGADO',
            'DEVUELTO'
        )
    )
);

-- =====================================================
-- INSERTAR PAGOS
-- =====================================================

INSERT INTO pago
(id_reserva, monto, metodo_pago, estado_pago)
VALUES
(1, 20.00, 'YAPE', 'PAGADO'),
(2, 20.00, 'EFECTIVO', 'PAGADO'),
(3, 20.00, 'PLIN', 'PAGADO'),
(4, 20.00, 'YAPE', 'PAGADO'),
(5, 20.00, 'EFECTIVO', 'PENDIENTE');

-- =====================================================
-- MOSTRAR CLIENTES
-- =====================================================

SELECT *
FROM cliente;

-- =====================================================
-- MOSTRAR CANCHAS
-- =====================================================

SELECT *
FROM cancha;

-- =====================================================
-- MOSTRAR HORARIOS
-- =====================================================

SELECT *
FROM horario;

-- =====================================================
-- MOSTRAR RESERVAS
-- =====================================================

SELECT *
FROM reserva;

-- =====================================================
-- MOSTRAR PAGOS
-- =====================================================

SELECT *
FROM pago;

-- =====================================================
-- CONSULTA GENERAL
-- CLIENTE + CANCHA + HORARIO + RESERVA + PAGO
-- =====================================================

SELECT
    r.id_reserva,
    c.nombre || ' ' || c.apellido AS cliente,
    ca.nombre AS cancha,
    r.fecha,
    h.hora_inicio,
    h.hora_fin,
    ca.precio_hora AS precio,
    r.estado AS estado_reserva,
    p.metodo_pago,
    p.estado_pago
FROM reserva r
JOIN cliente c
    ON r.id_cliente = c.id_cliente
JOIN cancha ca
    ON r.id_cancha = ca.id_cancha
JOIN horario h
    ON r.id_horario = h.id_horario
LEFT JOIN pago p
    ON r.id_reserva = p.id_reserva
ORDER BY r.fecha, h.hora_inicio;

-- =====================================================
-- VER HORARIOS DISPONIBLES
-- PARA UNA CANCHA Y FECHA
-- =====================================================

SELECT
    ca.nombre AS cancha,
    h.id_horario,
    h.hora_inicio,
    h.hora_fin
FROM cancha ca
CROSS JOIN horario h
WHERE ca.id_cancha = 1
AND NOT EXISTS (
    SELECT 1
    FROM reserva r
    WHERE r.id_cancha = ca.id_cancha
      AND r.id_horario = h.id_horario
      AND r.fecha = '2026-08-28'
      AND r.estado = 'RESERVADO'
)
ORDER BY h.hora_inicio;

-- =====================================================
-- VER TODAS LAS CANCHAS DISPONIBLES
-- EN UNA FECHA
-- =====================================================

SELECT
    ca.nombre AS cancha,
    h.hora_inicio,
    h.hora_fin
FROM cancha ca
CROSS JOIN horario h
WHERE NOT EXISTS (
    SELECT 1
    FROM reserva r
    WHERE r.id_cancha = ca.id_cancha
      AND r.id_horario = h.id_horario
      AND r.fecha = '2026-08-28'
      AND r.estado = 'RESERVADO'
)
ORDER BY h.hora_inicio, ca.nombre;

-- =====================================================
-- TOTAL RECAUDADO
-- =====================================================

SELECT
    SUM(monto) AS total_recaudado
FROM pago
WHERE estado_pago = 'PAGADO';

-- =====================================================
-- CANTIDAD DE RESERVAS POR CLIENTE
-- =====================================================

SELECT
    c.nombre,
    c.apellido,
    COUNT(r.id_reserva) AS cantidad_reservas
FROM cliente c
LEFT JOIN reserva r
    ON c.id_cliente = r.id_cliente
GROUP BY
    c.id_cliente,
    c.nombre,
    c.apellido
ORDER BY cantidad_reservas DESC;
