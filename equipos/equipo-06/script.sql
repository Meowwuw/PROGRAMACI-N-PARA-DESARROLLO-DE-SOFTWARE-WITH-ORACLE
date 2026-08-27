
CREATE SCHEMA IF NOT EXISTS alquiler;
SET search_path TO alquiler;
SELECT current_schema();

-- ==========================================================
-- SISTEMA DE ALQUILER DE CANCHAS - SCRIPT SQL (3FN)
-- Creado para el proyecto del módulo
-- ==========================================================
-- 1. Tabla CLIENTE
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    dni VARCHAR(8) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL
);

-- 2. Tabla CANCHA
CREATE TABLE cancha (
    id_cancha SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo_grass VARCHAR(50) NOT NULL,
    precio_hora DECIMAL(8,2) NOT NULL
);

-- 3. Tabla HORARIO
CREATE TABLE horario (
    id_horario SERIAL PRIMARY KEY,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);

-- 4. Tabla RESERVA
CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    fecha_reserva DATE NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Confirmado',
    id_cliente INT NOT NULL,
    CONSTRAINT fk_reserva_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- 5. Tabla DETALLE_RESERVA (Tabla Intermedia N:M entre reserva, cancha y horario)
CREATE TABLE detalle_reserva (
    id_detalle SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL,
    id_cancha INT NOT NULL,
    id_horario INT NOT NULL,
    subtotal DECIMAL(8,2) NOT NULL,
    CONSTRAINT fk_detalle_reserva FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
    CONSTRAINT fk_detalle_cancha FOREIGN KEY (id_cancha) REFERENCES cancha(id_cancha),
    CONSTRAINT fk_detalle_horario FOREIGN KEY (id_horario) REFERENCES horario(id_horario)
);

-- 6. Tabla PAGO (Relación 1:1 o 1:N con Reserva)
CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL,
    monto_total DECIMAL(8,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR(30) NOT NULL,
    CONSTRAINT fk_pago_reserva FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)
);

-- ==========================================================
-- INSERCIÓN DE DATOS DE PRUEBA (Mínimo 3 registros por tabla)
-- ==========================================================

-- Clientes
INSERT INTO cliente (dni, nombre, telefono, correo) VALUES 
('72345678', 'Carlos Mendoza', '987654321', 'carlos.mendoza@correo.com'),
('45678912', 'Lucía Pérez', '912345678', 'lucia.perez@correo.com'),
('78912345', 'Jorge Ramírez', '955443322', 'jorge.ramirez@correo.com');

-- Canchas
INSERT INTO cancha (nombre, tipo_grass, precio_hora) VALUES 
('Cancha Sintética 1 - El Gol', 'Sintético Premium', 80.00),
('Cancha Sintética 2 - La Bombonera', 'Sintético Estándar', 60.00),
('Cancha de Grass Natural - Maracaná', 'Natural', 100.00);

-- Horarios
INSERT INTO horario (hora_inicio, hora_fin) VALUES 
('18:00:00', '19:00:00'),
('19:00:00', '20:00:00'),
('20:00:00', '21:00:00');

-- Reservas
INSERT INTO reserva (fecha_reserva, estado, id_cliente) VALUES 
('2026-09-01', 'Confirmado', 1),
('2026-09-02', 'Confirmado', 2),
('2026-09-03', 'Pendiente', 3);

-- Detalle Reserva (Relación N:M)
INSERT INTO detalle_reserva (id_reserva, id_cancha, id_horario, subtotal) VALUES 
(1, 1, 1, 80.00),
(2, 2, 2, 60.00),
(3, 3, 3, 100.00);

-- Pagos
INSERT INTO pago (id_reserva, monto_total, metodo_pago) VALUES 
(1, 80.00, 'Yape'),
(2, 60.00, 'Plin'),
(3, 100.00, 'Efectivo');
