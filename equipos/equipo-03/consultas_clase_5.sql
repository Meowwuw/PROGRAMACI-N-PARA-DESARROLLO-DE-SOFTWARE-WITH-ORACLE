-- =====================================================================
-- CLASE 05 · CONSULTAS DEL PROYECTO
-- Entrega EN EQUIPO  ·  equipos/equipo-NN/consultas-proyecto.sql
-- ---------------------------------------------------------------------
-- Equipo N°: ____     Proyecto: ______________________________
-- Integrantes: _______________________________________________
--
-- Se trabaja sobre la base Neon del equipo, no sobre TecnoMichiStore.
-- =====================================================================

SET search_path TO renta_cancha;   -- cambia esto por el de su proyecto
SELECT current_schema();

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    telefono VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    dni VARCHAR(8) not null,
    correo varchar(50)
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
    UNIQUE ( fecha, id_horario),

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

-- =====================================================================
-- PARTE 1 · CARGAR LOS DATOS
-- ---------------------------------------------------------------------
-- Minimo para que las consultas de abajo tengan sentido:
--
--   [ ] 20 filas en la tabla principal de movimientos
--       (reserva, consulta, venta, prestamo... segun su proyecto)
--   [ ] fechas repartidas en varios meses, no todas del mismo dia
--   [ ] precios o montos variados, no todos iguales
--   [ ] algunos campos opcionales en NULL, a proposito
--       (si todo esta lleno, la consulta 6 no devuelve nada)
--   [ ] nombres y correos que parezcan reales
--   [ ] al menos dos dominios de correo distintos
--
-- Reparto sugerido: cada integrante carga una tabla.
-- =====================================================================

-- Sus INSERT:
-- ============================================================
-- INSERTS CLIENTE
-- ============================================================

INSERT INTO cliente (telefono, nombre, apellido, dni, correo)
VALUES
('987654321', 'Juan', 'Perez', '71234567', 'juan.perez@gmail.com'),
('986123456', 'Carlos', 'Gomez', '72345678', 'carlos.gomez@hotmail.com'),
('985987654', 'Luis', 'Ramirez', '73456789', 'luis.ramirez@gmail.com'),
('984567123', 'Maria', 'Lopez', '74567890', 'maria.lopez@hotmail.com'),
('983456789', 'Ana', 'Torres', '75678901', 'ana.torres@gmail.com'),
('982345678', 'Jose', 'Flores', '76789012', NULL),
('981234567', 'Pedro', 'Rojas', '77890123', 'pedro.rojas@gmail.com'),
('980123456', 'Lucia', 'Castro', '78901234', 'lucia.castro@hotmail.com'),
('979876543', 'Miguel', 'Diaz', '79012345', 'miguel.diaz@gmail.com'),
('978765432', 'Rosa', 'Mendoza', '70123456', 'rosa.mendoza@hotmail.com'),
('977654321', 'Diego', 'Vargas', '71234568', NULL),
('976543210', 'Andrea', 'Silva', '72345679', 'andrea.silva@hotmail.com'),
('975432109', 'Marco', 'Chavez', '73456780', 'marco.chavez@gmail.com'),
('974321098', 'Paola', 'Herrera', '74567891', 'paola.herrera@hotmail.com'),
('973210987', 'Jorge', 'Quispe', '75678902', NULL),
('972109876', 'Sofia', 'Navarro', '76789013', 'sofia.navarro@hotmail.com'),
('971098765', 'Ricardo', 'Medina', '77890124', 'ricardo.medina@gmail.com'),
('970987654', 'Valeria', 'Salazar', '78901235', NULL),
('969876543', 'Fernando', 'Cruz', '79012346', 'fernando.cruz@gmail.com'),
('968765432', 'Camila', 'Morales', '70123457', 'camila.morales@hotmail.com');


-- ============================================================
-- INSERTS CANCHA
-- ============================================================

INSERT INTO cancha (numero_cancha) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);


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
('08:00', 30.00),
('09:00', 30.00),
('10:00', 30.00),
('11:00', 30.00),
('12:00', 30.00),
('13:00', 50.00),
('14:00', 50.00),
('15:00', 50.00),
('16:00', 50.00),
('17:00', 50.00),
('18:00', 60.00),
('19:00', 60.00),
('20:00', 60.00),
('21:00', 60.00),
('22:00', 60.00);


-- ============================================================
-- INSERTS RESERVA
--
--
--La reserva solo puede tener un horario. ============================================================

INSERT INTO reserva (
    id_cliente,
    id_cancha,
    id_horario,
    fecha
)VALUES
(1, 1, 1, '2026-07-02'),
(2, 2, 3, '2026-07-05'),
(3, 3, 5, '2026-07-10'),
(4, 4, 7, '2026-07-15'),
(5, 5, 9, '2026-07-20'),
(6, 6, 10, '2026-08-03'),
(7, 7, 11, '2026-08-08'),
(8, 8, 12, '2026-08-12'),
(9, 9, 13, '2026-08-18'),
(10, 10, 14, '2026-08-25'),
(11, 1, 15, '2026-09-02'),
(12, 2, 2, '2026-09-07'),
(13, 3, 4, '2026-09-12'),
(14, 4, 6, '2026-09-17'),
(15, 5, 8, '2026-09-23'),
(16, 6, 10, '2026-10-03'),
(17, 7, 11, '2026-10-09'),
(18, 8, 12, '2026-10-15'),
(19, 9, 13, '2026-10-21'),
(20, 10, 14, '2026-10-28');

-- ============================================================
-- INSERTS PAGO
-- ============================================================


INSERT INTO pago (id_reserva, total)
SELECT
    r.id_reserva,
    SUM(h.precio) AS total
FROM reserva r
INNER JOIN horario h
    ON r.id_horario = h.id_horario
LEFT JOIN pago p
    ON r.id_reserva = p.id_reserva
WHERE p.id_reserva IS NULL
GROUP BY r.id_reserva;



-- Verificacion: cuantas filas quedaron en cada tabla
-- SELECT COUNT(*) FROM su_tabla_principal;


-- =====================================================================
-- PARTE 2 · LAS DIEZ CONSULTAS
-- ---------------------------------------------------------------------
-- Una de cada tipo. Escriban primero la PREGUNTA en castellano,
-- como comentario, y debajo la consulta que la responde.
--
-- No vale repetir tipo. Si dos consultas usan BETWEEN sobre fechas,
-- una de las dos esta mal planteada.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1 · RANGO DE FECHAS        (BETWEEN)
-- Pregunta:¿Qué reservas se realizaron entre el 1 de julio y el
-- 31 de octubre del año 2026?
-- ---------------------------------------------------------------------
SELECT *
FROM reserva
WHERE fecha BETWEEN '2026-07-01' AND '2026-10-31';


-- ---------------------------------------------------------------------
-- 2 · RANGO DE MONTOS        (BETWEEN)
-- Pregunta:  ¿Qué pagos tienen un monto total entre 50 y 100 soles?
-- ---------------------------------------------------------------------

SELECT *
FROM pago
WHERE total BETWEEN 50.00 AND 100.00;

-- ---------------------------------------------------------------------
-- 3 · LISTA DE ESTADOS O CATEGORIAS        (IN)
-- Pregunta: ¿Qué clientes se llaman Juan, María o Carlos?
-- ---------------------------------------------------------------------
SELECT *
FROM cliente
WHERE nombre IN ('Juan', 'Maria', 'Carlos');


-- ---------------------------------------------------------------------
-- 4 · LO QUE QUEDA FUERA        (NOT IN  o  <>)
-- Pregunta: ¿Qué reservas no fueron realizadas en las canchas 1, 2
-- ni 3?
-- ---------------------------------------------------------------------

SELECT *
FROM reserva
WHERE id_cancha NOT IN (1, 2, 3);

-- ---------------------------------------------------------------------
-- 5 · BUSQUEDA POR TEXTO        (ILIKE)
-- Pregunta: ¿Qué clientes tienen la combinación de letras "an" en
-- su nombre, sin importar mayúsculas o minúsculas?
-- ---------------------------------------------------------------------

SELECT *
FROM cliente
WHERE nombre ILIKE '%an%';

-- ---------------------------------------------------------------------
-- 6 · UN DATO QUE FALTA        (IS NULL)
-- Pregunta: ¿Qué clientes no tienen un correo electrónico registrado?
-- ---------------------------------------------------------------------

SELECT *
FROM cliente
WHERE correo IS NULL;

-- ---------------------------------------------------------------------
-- 7 · UN DATO QUE SI ESTA        (IS NOT NULL)
-- Pregunta: ¿Qué reservas ya tienen un pago registrado?
-- ---------------------------------------------------------------------

SELECT reserva.*
FROM reserva
JOIN pago
ON reserva.id_reserva = pago.id_reserva
WHERE pago.id_pago IS NOT NULL;

-- ---------------------------------------------------------------------
-- 8 · DOS CONDICIONES A LA VEZ        (AND)
-- Pregunta: ¿Qué reservas corresponden a la cancha 1 y fueron
-- realizadas durante el mes de septiembre de 2026?
-- ---------------------------------------------------------------------

SELECT *
FROM reserva
WHERE id_cancha = 1
AND fecha BETWEEN '2026-09-01' AND '2026-09-30';

-- ---------------------------------------------------------------------
-- 9 · UNA ALTERNATIVA        (OR, con parentesis si mezclan con AND)
-- Pregunta:  ¿Qué reservas corresponden a la cancha 1 o a la cancha 2
-- y fueron realizadas durante el mes de septiembre de 2026?
-- ---------------------------------------------------------------------

SELECT *
FROM reserva
WHERE (id_cancha = 1 OR id_cancha = 2)
AND fecha BETWEEN '2026-09-01' AND '2026-09-30';

-- ---------------------------------------------------------------------
-- 10 · TRES TABLAS UNIDAS CON UN FILTRO        (JOIN + WHERE)
-- Pregunta: ¿Qué clientes realizaron reservas, en qué cancha y horario,
-- y en qué fecha, entre julio y octubre de 2026?
-- ---------------------------------------------------------------------

SELECT
    c.nombre,
    c.apellido,
    c.telefono,
    ca.numero_cancha,
    h.hora,
    h.precio,
    r.fecha
FROM reserva r
JOIN cliente c
    ON r.id_cliente = c.id_cliente
JOIN cancha ca
    ON r.id_cancha = ca.id_cancha
JOIN horario h
    ON r.id_horario = h.id_horario
WHERE r.fecha BETWEEN '2026-07-01' AND '2026-10-31';

-- =====================================================================
-- ANTES DE SUBIR
-- ---------------------------------------------------------------------
-- [ ] Los datos cargados, minimo 20 filas en la tabla principal
-- [ ] Las 10 consultas, cada una con su pregunta escrita arriba
-- [ ] Ninguna consulta devuelve cero filas por falta de datos
-- [ ] El archivo ejecuta completo, de arriba a abajo, sin un solo error
--
-- Sube el Integrador, a:  equipos/equipo-NN/consultas-proyecto.sql
-- =====================================================================
