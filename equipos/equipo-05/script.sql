--- SISTEMA DE VOLEY PLAYA

create schema if not exist000royecto_5;
select current_schema();

--- CREACION DE LAS TABLAS

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



------------------------------ INSERTAR DATOS DE PRUEBA ---------------------------------------

INSERT INTO cliente (nombre, apellido, dni, telefono, email)
VALUES
('Juan', 'Perez', '74125896', '987654321', 'juan.perez@gmail.com'),
('Bwnjamin ', 'Quispe ', '72845631', '986123456', 'benjamin.lopez@gmail.com'),
('Carlos', 'Gomez', '75632148', '985741236', 'carlos.gomez@gmail.com'),
('Ana', 'Torres', '71234568', '984632175', 'ana.torres@gmail.com'),
('Luis', 'Ramirez', '76543218', '983214567', 'luis.ramirez@gmail.com');

select * from cliente;



INSERT INTO cancha (numero, nombre, tipo_superficie, estado)
VALUES
(1, 'Cancha Principal', 'Arena', 'Disponible'),
(2, 'Cancha Norte', 'Arena', 'Disponible'),
(3, 'Cancha Sur', 'Arena', 'Disponible'),
(4, 'Cancha VIP', 'Arena', 'Mantenimiento');


select * from cancha;

INSERT INTO horario (hora_inicio, hora_fin, precio)
VALUES
('08:00:00', '09:00:00', 30.00),
('09:00:00', '10:00:00', 30.00),
('10:00:00', '11:00:00', 35.00),
('16:00:00', '17:00:00', 40.00),
('17:00:00', '18:00:00', 40.00),
('18:00:00', '19:00:00', 45.00),
('19:00:00', '20:00:00', 45.00),
('20:00:00', '21:00:00', 50.00);

select * from horario;


INSERT INTO reserva 
(id_cliente, id_cancha, id_horario, fecha_reserva, estado, total)
VALUES
(1, 1, 1, '2026-08-28', 'Confirmada', 30.00),
(2, 2, 2, '2026-08-28', 'Confirmada', 30.00),
(3, 1, 3, '2026-08-29', 'Pendiente', 35.00),
(4, 3, 6, '2026-08-29', 'Confirmada', 45.00),
(5, 2, 8, '2026-08-30', 'Pendiente', 50.00);

select * from reserva;


INSERT INTO pago 
(id_reserva, monto, metodo_pago, estado)
VALUES
(1, 30.00, 'Yape', 'Pagado'),
(2, 30.00, 'Plin', 'Pagado'),
(3, 35.00, 'Efectivo', 'Pendiente'),
(4, 45.00, 'Tarjeta', 'Pagado'),
(5, 50.00, 'Transferencia', 'Pendiente');


select * from pago;

