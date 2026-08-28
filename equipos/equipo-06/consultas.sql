-- 1.RANGO DE FECHAS:
--¿Cuáles fueron las reservas realizadas durante la primera semana de septiembre de 2026?
SELECT * FROM reserva 
WHERE fecha_reserva BETWEEN '2026-09-01' AND '2026-09-07';

-- 2. RANGO DE MONTOS:
--¿Qué pagos se encuentran dentro del rango de 70.00 a 100.00 soles?
SELECT * FROM pago 
WHERE monto_total BETWEEN 70.00 AND 100.00;

-- 3.LISTA DE ESTADOS:
--¿Cuáles son las reservas que se encuentran con estado 'Confirmado' o 'Pendiente'?
SELECT * FROM reserva 
WHERE estado IN ('Confirmado', 'Pendiente');

-- 4.LO QUE QUEDA FUERA:
-- ¿Cuáles son las reservas cuyos estados no son ni 'Confirmado' ni 'Pendiente'?
SELECT * FROM reserva 
WHERE estado NOT IN ('Confirmado', 'Pendiente');

-- 5.BUSQUEDA POR TEXTO:
-- ¿Qué clientes tienen la letra 'c' o 'C' en su nombre?
SELECT * FROM cliente 
WHERE nombre ILIKE '%c%';

-- 6.UN DATO QUE FALTA:
-- ¿Existe algún cliente registrado que no tenga correo electrónico asignado?
SELECT * FROM pago 
WHERE metodo_pago IS NOT NULL;

-- 7.UN DATO QUE SI ESTA:
-- ¿Cuáles son los registros de pago que sí cuentan con un método de pago especificado?
SELECT * FROM pago 
WHERE metodo_pago IS NOT NULL;

-- 8.DOS COINCIDENCIAS:
-- ¿Qué reservas están confirmadas y a la vez pertenecen al cliente con id_cliente = 1?
SELECT * FROM reserva 
WHERE estado = 'Confirmado' AND id_cliente = 1;

-- 9. ALTERNATIVA:
-- ¿Qué pagos se realizaron utilizando específicamente el método 'Yape' o 'Plin'?
SELECT * FROM pago 
WHERE (metodo_pago = 'Yape' OR metodo_pago = 'Plin');

-- 1O.TRES TABLAS UNIDAS:
-- ¿Qué clientes, fechas de reserva y métodos de pago corresponden a aquellas transacciones cuyo monto total sea mayor a 60.00 soles?
SELECT c.nombre AS cliente, r.fecha_reserva, p.monto_total, p.metodo_pago 
FROM cliente c
JOIN reserva r ON c.id_cliente = r.id_cliente
JOIN pago p ON r.id_reserva = p.id_reserva
WHERE p.monto_total > 60.00;
