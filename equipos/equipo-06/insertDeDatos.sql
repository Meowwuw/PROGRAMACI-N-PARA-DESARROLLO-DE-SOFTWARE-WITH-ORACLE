-- 10 Clientes
INSERT INTO cliente (dni, nombre, telefono, correo) VALUES 
('72345678', 'Carlos Mendoza', '987654321', 'carlos.mendoza@correo.com'),
('45678912', 'Lucía Pérez', '912345678', 'lucia.perez@correo.com'),
('78912345', 'Jorge Ramírez', '955443322', 'jorge.ramirez@correo.com'),
('41234567', 'Ana Torres', '944332211', 'ana.torres@correo.com'),
('70123456', 'Miguel Ruiz', '933221100', 'miguel.ruiz@correo.com'),
('71234568', 'Sofía Castro', '922114455', 'sofia.castro@correo.com'),
('42345679', 'Pedro Gómez', '911223344', 'pedro.gomez@correo.com'),
('73456780', 'Valeria Rojas', '999887766', 'valeria.rojas@correo.com'),
('44567891', 'Diego Silva', '988776655', 'diego.silva@correo.com'),
('75678902', 'Camila Morales', '977665544', 'camila.morales@correo.com');

-- 10 Canchas
INSERT INTO cancha (nombre, tipo_grass, precio_hora) VALUES 
('Cancha 1 - El Gol', 'Sintético Premium', 80.00),
('Cancha 2 - La Bombonera', 'Sintético Estándar', 60.00),
('Cancha 3 - Maracaná', 'Natural', 100.00),
('Cancha 4 - Camp Nou', 'Sintético Premium', 90.00),
('Cancha 5 - San Siro', 'Sintético Estándar', 70.00),
('Cancha 6 - Wembley', 'Natural', 110.00),
('Cancha 7 - Allianz', 'Sintético Premium', 85.00),
('Cancha 8 - Monumental', 'Natural', 120.00),
('Cancha 9 - Azteca', 'Sintético Estándar', 65.00),
('Cancha 10 - Mestalla', 'Sintético Premium', 75.00);

-- 10 Horarios
INSERT INTO horario (hora_inicio, hora_fin) VALUES 
('13:00:00', '14:00:00'),
('14:00:00', '15:00:00'),
('15:00:00', '16:00:00'),
('16:00:00', '17:00:00'),
('17:00:00', '18:00:00'),
('18:00:00', '19:00:00'),
('19:00:00', '20:00:00'),
('20:00:00', '21:00:00'),
('21:00:00', '22:00:00'),
('22:00:00', '23:00:00');

-- 20 Reservas
INSERT INTO reserva (fecha_reserva, estado, id_cliente) VALUES 
('2026-09-01', 'Confirmado', 1),
('2026-09-01', 'Confirmado', 2),
('2026-09-02', 'Confirmado', 3),
('2026-09-02', 'Pendiente', 4),
('2026-09-03', 'Confirmado', 5),
('2026-09-03', 'Confirmado', 6),
('2026-09-04', 'Cancelado', 7),
('2026-09-04', 'Confirmado', 8),
('2026-09-05', 'Confirmado', 9),
('2026-09-05', 'Confirmado', 10),
('2026-09-06', 'Pendiente', 1),
('2026-09-06', 'Confirmado', 2),
('2026-09-07', 'Confirmado', 3),
('2026-09-07', 'Confirmado', 4),
('2026-09-08', 'Confirmado', 5),
('2026-09-08', 'Pendiente', 6),
('2026-09-09', 'Confirmado', 7),
('2026-09-09', 'Confirmado', 8),
('2026-09-10', 'Confirmado', 9),
('2026-09-10', 'Confirmado', 10);

-- 20 Detalles de Reserva
INSERT INTO detalle_reserva (id_reserva, id_cancha, id_horario, subtotal) VALUES 
(1, 1, 1, 80.00),
(2, 2, 2, 60.00),
(3, 3, 3, 100.00),
(4, 4, 4, 90.00),
(5, 5, 5, 70.00),
(6, 6, 6, 110.00),
(7, 7, 7, 85.00),
(8, 8, 8, 120.00),
(9, 9, 9, 65.00),
(10, 10, 10, 75.00),
(11, 1, 2, 80.00),
(12, 2, 3, 60.00),
(13, 3, 4, 100.00),
(14, 4, 5, 90.00),
(15, 5, 6, 70.00),
(16, 6, 7, 110.00),
(17, 7, 8, 85.00),
(18, 8, 9, 120.00),
(19, 9, 10, 65.00),
(20, 10, 1, 75.00);

-- 10 Pagos (Asociados a las primeras 10 reservas existentes)
INSERT INTO pago (id_reserva, monto_total, metodo_pago) VALUES 
(1, 80.00, 'Yape'),
(2, 60.00, 'Plin'),
(3, 100.00, 'Efectivo'),
(4, 90.00, 'Yape'),
(5, 70.00, 'Tarjeta'),
(6, 110.00, 'Plin'),
(7, 85.00, 'Efectivo'),
(8, 120.00, 'Yape'),
(9, 65.00, 'Tarjeta'),
(10, 75.00, 'Plin');
