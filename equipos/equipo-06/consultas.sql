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


-- CLASE 7 - EJERCICIO 2
-- 1.
-- Necesidad: Mostrar la relación de todas las reservas confirmadas o pendientes junto con el nombre, DNI y correo del cliente que las realizó.
-- Tablas involucradas: reserva y cliente
-- Tipo de JOIN: INNER JOIN.
-- Justificación: Se requiere para identificar al responsable de cada movimiento registrado en el sistema, vinculando los datos personales del cliente con su respectiva orden de reserva.
SELECT r.id_reserva, r.fecha_reserva, r.estado, c.nombre AS cliente, c.dni, c.correo
FROM reserva r
INNER JOIN cliente c ON r.id_cliente = c.id_cliente;

-- 2.
-- Necesidad: Consultar los detalles de las reservas activas, mostrando qué cancha fue alquilada, el tipo de grass, el horario asignado y el subtotal a pagar.
-- Tablas involucradas: detalle_reserva, cancha y horario.
-- Tipo de JOIN: INNER JOIN múltiple.
-- ustificación: La tabla intermedia detalle_reserva conecta tres entidades;
--es indispensable cruzarla con cancha y horario para transformar los IDs en información comprensible (nombre de cancha y bloque horario) para el reporte de la administración.
SELECT dr.id_detalle, dr.id_reserva, c.nombre AS cancha, c.tipo_grass, 
       CONCAT(h.hora_inicio, ' - ', h.hora_fin) AS horario, dr.subtotal
FROM detalle_reserva dr
INNER JOIN cancha c ON dr.id_cancha = c.id_cancha
INNER JOIN horario h ON dr.id_horario = h.id_horario;

-- 3.
-- Necesidad: Obtener un reporte financiero que relacione cada pago registrado con el cliente correspondiente, mostrando el monto total, el método de pago utilizado y la fecha de la transacción.
-- Tablas involucradas: pago, reserva y cliente.
-- Tipo de JOIN: INNER JOIN múltiple.
-- Justificación: La tabla pago solo se conecta directamente con reserva, por lo que se requiere un segundo INNER JOIN hacia cliente para saber qué usuario efectuó el pago.
SELECT p.id_pago, c.nombre AS cliente, p.monto_total, p.metodo_pago, p.fecha_pago
FROM pago p
INNER JOIN reserva r ON p.id_reserva = r.id_reserva
INNER JOIN cliente c ON r.id_cliente = c.id_cliente;
