

-- 1. Configuración inicial del esquema
CREATE SCHEMA IF NOT EXISTS reservacion_cancha;
SET search_path TO reservacion_cancha;
SELECT current_schema();

-- 2. Tabla CLIENTE
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni_ruc VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100)
);

-- 3. Tabla CANCHA
CREATE TABLE cancha (
    id_cancha SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo_grama VARCHAR(50) NOT NULL, -- Ej: Sintético, Losa, Césped
    precio_por_hora DECIMAL(10, 2) NOT NULL,
    estado VARCHAR(20) DEFAULT 'Disponible' -- Disponible, Mantenimiento
);

-- 4. Tabla HORARIO
CREATE TABLE horario (
    id_horario SERIAL PRIMARY KEY,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);

-- 5. Tabla RESERVA (Relación N:M entre Cliente, Cancha y Horario)
CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_cancha INT NOT NULL,
    id_horario INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    estado_reserva VARCHAR(20) DEFAULT 'Confirmada', -- Pendiente, Confirmada, Cancelada
    
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_cancha) REFERENCES cancha(id_cancha) ON DELETE CASCADE,
    FOREIGN KEY (id_horario) REFERENCES horario(id_horario) ON DELETE CASCADE
);

-- 6. Tabla PAGO
CREATE TABLE pago (
    id_pago SERIAL PRIMARY KEY,
    id_reserva INT UNIQUE NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL, -- Yape, Plin, Transferencia, Efectivo
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva) ON DELETE CASCADE
);

-- 7. Tabla COMPROBANTE DE PAGO
CREATE TABLE comprobante_pago (
    id_comprobante SERIAL PRIMARY KEY,
    id_pago INT UNIQUE NOT NULL,
    tipo_comprobante VARCHAR(20) NOT NULL, -- Boleta, Factura
    numero_serie VARCHAR(20) NOT NULL,
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_pago) REFERENCES pago(id_pago) ON DELETE CASCADE
);






SET search_path TO create reservacion_cancha;

-- 1. Insertar CLIENTES
INSERT INTO cliente (nombre, apellido, dni_ruc, telefono, email) VALUES
('Juan', 'Pérez', '72839401', '987654321', 'juan.perez@email.com'),
('María', 'Gómez', '10483920191', '912345678', 'maria.gomez@empresa.pe'),
('Carlos', 'López', '71920384', '955443322', 'carlos.lopez@email.com');

-- 2. Insertar CANCHAS
INSERT INTO cancha (nombre, tipo_grama, precio_por_hora, estado) VALUES
('Cancha 1 - La Bombonera', 'Sintético', 60.00, 'Disponible'),
('Cancha 2 - Maracaná', 'Sintético', 70.00, 'Disponible'),
('Cancha 3 - Losa Central', 'Losa', 40.00, 'Disponible');

-- 3. Insertar HORARIOS
INSERT INTO horario (hora_inicio, hora_fin) VALUES
('18:00:00', '19:00:00'),
('19:00:00', '20:00:00'),
('20:00:00', '21:00:00'),
('21:00:00', '22:00:00');

-- 4. Insertar RESERVAS
-- (id_cliente, id_cancha, id_horario, fecha_reserva, estado_reserva)
INSERT INTO reserva (id_cliente, id_cancha, id_horario, fecha_reserva, estado_reserva) VALUES
(1, 1, 1, '2026-09-01', 'Confirmada'),
(2, 2, 2, '2026-09-01', 'Confirmada'),
(3, 1, 3, '2026-09-02', 'Confirmada');

-- 5. Insertar PAGOS
-- (id_reserva, monto, metodo_pago)
INSERT INTO pago (id_reserva, monto, metodo_pago) VALUES
(1, 60.00, 'Yape'),
(2, 70.00, 'Transferencia'),
(3, 60.00, 'Efectivo');

-- 6. Insertar COMPROBANTES DE PAGO
-- (id_pago, tipo_comprobante, numero_serie)
INSERT INTO comprobante_pago (id_pago, tipo_comprobante, numero_serie) VALUES
(1, 'Boleta', 'B001-000001'),
(2, 'Factura', 'F001-000001'),
(3, 'Boleta', 'B001-000002');


SELECT * FROM cliente;
SELECT * FROM cancha;
SELECT * FROM reserva;
SELECT * FROM pago;
SELECT * FROM comprobante_pago;
