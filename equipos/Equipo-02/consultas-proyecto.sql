CREATE SCHEMA IF NOT EXISTS a_veterinaria;

SET search_path TO a_veterinaria;


SELECT current_schema();



CREATE TABLE apoderado (
    id_apoderado SERIAL       PRIMARY KEY,
    telefono     VARCHAR(11)  NOT NULL,
    nombre       VARCHAR(100) NOT NULL
);

CREATE TABLE mascota (
    id_mascota   SERIAL        PRIMARY KEY,
    nombre       VARCHAR(50)   NOT NULL,
    raza         VARCHAR(50)   NOT NULL,
    peso         NUMERIC(5,2)  NOT NULL,
    genero       VARCHAR(40)   NOT NULL,
    id_apoderado INT           NOT NULL REFERENCES apoderado(id_apoderado)
);

CREATE TABLE veterinario (
    id_veterinario SERIAL       PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    especialidad   VARCHAR(50)  NOT NULL,
    telefono       VARCHAR(11)  NOT NULL
);

CREATE TABLE consulta (
    id_consulta    SERIAL    PRIMARY KEY,
    fecha_con      TIMESTAMP NOT NULL DEFAULT NOW(),
    id_apoderado   INT       NOT NULL REFERENCES apoderado(id_apoderado),
    id_veterinario INT       NOT NULL REFERENCES veterinario(id_veterinario)
);

CREATE TABLE tratamiento (
    id_tratamiento    SERIAL       PRIMARY KEY,
    fecha_ini         DATE         NOT NULL DEFAULT CURRENT_DATE,
    tipo_tratamiento  VARCHAR(100) NOT NULL,
    fecha_fin         DATE,
    id_consulta       INT          NOT NULL REFERENCES consulta(id_consulta)
);



INSERT INTO apoderado (telefono, nombre) VALUES
  ('987654321', 'Jander Hidalgo'),
  ('912345678', 'Angel Pinedo'),
  ('913770863', 'Jonas Gonzales'),
  ('998877665', 'Gabriel Amasifuen');

INSERT INTO mascota (nombre, raza, peso, genero, id_apoderado) VALUES
  ('Rocky',  'Labrador',        28,   'Macho',  1),
  ('Luna',   'Siames',          4.2,  'Hembra', 1),  -- Jander tiene 2 mascotas
  ('Maya',   'Pastor Aleman',   14,   'Hembra', 2),
  ('Toby',   'Bulldog Frances', 12.5, 'Macho',  3);

INSERT INTO veterinario (nombre, especialidad, telefono) VALUES
  ('Dra. Ana Torres',   'Cirugia',      '911111111'),
  ('Dr. Pedro Salas',   'Dermatologia', '922222222');

INSERT INTO consulta (fecha_con, id_apoderado, id_veterinario) VALUES
  ('2026-08-01 09:00', 1, 1),
  ('2026-08-05 15:30', 2, 2),
  ('2026-08-10 11:00', 1, 2);

INSERT INTO tratamiento (fecha_ini, tipo_tratamiento, fecha_fin, id_consulta) VALUES
  ('2026-08-01', 'Vacunacion',      '2026-08-01', 1),
  ('2026-08-05', 'Control de piel', NULL,          2),
  ('2026-08-10', 'Desparasitacion', '2026-08-10', 3);

SELECT * FROM mascota;
SELECT * FROM consulta;

-- Comprobacion rapida: cuantas mascotas tiene cada apoderado
SELECT a.nombre, COUNT(m.id_mascota) AS total_mascotas
FROM apoderado a
LEFT JOIN mascota m ON m.id_apoderado = a.id_apoderado
GROUP BY a.nombre
ORDER BY total_mascotas DESC;


-- ---------------------------------------------------------------------
-- SI NECESITAS EMPEZAR DE CERO
-- Borra en orden inverso al que creaste (primero las tablas con FK).
-- ---------------------------------------------------------------------
 --DROP TABLE IF EXISTS tratamiento;
 --DROP TABLE IF EXISTS consulta;
 --DROP TABLE IF EXISTS veterinario;
 --DROP TABLE IF EXISTS mascota;
 --DROP TABLE IF EXISTS apoderado;

```sql
-- =====================================================================
-- CLASE 05 · CONSULTAS DEL PROYECTO
-- Equipo N°:2     Proyecto: Sistema de Veterinaria
-- Integrantes:
-- Harim Jander Saavedra Hidalgo 
-- angel martin pinedo saavedra 
-- Alex Jonas Gonzales Sangama
-- =====================================================================

CREATE SCHEMA IF NOT EXISTS a_veterinaria;

SET search_path TO a_veterinaria;

SELECT current_schema();


-- =====================================================================
-- PARTE 1 · CARGAR LOS DATOS
-- =====================================================================

-- ---------------------------------------------------------------------
-- APODERADOS
-- ---------------------------------------------------------------------

INSERT INTO apoderado (telefono, nombre) VALUES
  ('987654321', 'Jander Hidalgo'),
  ('912345678', 'Angel Pinedo'),
  ('913770863', 'Jonas Gonzales'),
  ('998877665', 'Gabriel Amasifuen');


-- ---------------------------------------------------------------------
-- MASCOTAS
-- ---------------------------------------------------------------------

INSERT INTO mascota (nombre, raza, peso, genero, id_apoderado) VALUES
  ('Rocky', 'Labrador', 28, 'Macho', 1),
  ('Luna', 'Siames', 4.2, 'Hembra', 1),
  ('Maya', 'Pastor Aleman', 14, 'Hembra', 2),
  ('Toby', 'Bulldog Frances', 12.5, 'Macho', 3);


-- ---------------------------------------------------------------------
-- VETERINARIOS
-- ---------------------------------------------------------------------

INSERT INTO veterinario (nombre, especialidad, telefono) VALUES
  ('Dra. Ana Torres', 'Cirugia', '911111111'),
  ('Dr. Pedro Salas', 'Dermatologia', '922222222');


-- ---------------------------------------------------------------------
-- CONSULTAS
-- ---------------------------------------------------------------------

INSERT INTO consulta (fecha_con, id_apoderado, id_veterinario) VALUES
  ('2026-01-10 09:00', 1, 1),
  ('2026-01-18 15:30', 2, 2),
  ('2026-02-05 11:00', 1, 2),
  ('2026-02-15 10:30', 3, 1),
  ('2026-02-28 16:00', 4, 2),
  ('2026-03-05 09:30', 1, 1),
  ('2026-03-17 14:00', 2, 2),
  ('2026-03-25 11:30', 3, 1),
  ('2026-04-02 10:00', 4, 2),
  ('2026-04-15 15:00', 1, 1),
  ('2026-04-28 09:00', 2, 2),
  ('2026-05-06 13:30', 3, 1),
  ('2026-05-18 10:30', 4, 2),
  ('2026-05-29 16:30', 1, 1),
  ('2026-06-03 09:00', 2, 2),
  ('2026-06-15 11:00', 3, 1),
  ('2026-06-27 14:30', 4, 2),
  ('2026-07-05 10:00', 1, 1),
  ('2026-07-18 15:30', 2, 2),
  ('2026-08-01 09:00', 3, 1),
  ('2026-08-05 15:30', 4, 2),
  ('2026-08-10 11:00', 1, 2);


-- ---------------------------------------------------------------------
-- TRATAMIENTOS
-- ---------------------------------------------------------------------

INSERT INTO tratamiento
(fecha_ini, tipo_tratamiento, fecha_fin, id_consulta) VALUES
  ('2026-01-10', 'Vacunacion', '2026-01-10', 1),
  ('2026-01-18', 'Control de piel', NULL, 2),
  ('2026-02-05', 'Desparasitacion', '2026-02-05', 3),
  ('2026-02-15', 'Cirugia menor', '2026-02-20', 4),
  ('2026-02-28', 'Vacunacion', '2026-02-28', 5),
  ('2026-03-05', 'Control general', NULL, 6),
  ('2026-03-17', 'Desparasitacion', '2026-03-17', 7),
  ('2026-03-25', 'Tratamiento dermatologico', NULL, 8),
  ('2026-04-02', 'Vacunacion', '2026-04-02', 9),
  ('2026-04-15', 'Cirugia menor', '2026-04-20', 10),
  ('2026-04-28', 'Control general', NULL, 11),
  ('2026-05-06', 'Desparasitacion', '2026-05-06', 12),
  ('2026-05-18', 'Vacunacion', '2026-05-18', 13),
  ('2026-05-29', 'Control de piel', NULL, 14),
  ('2026-06-03', 'Cirugia menor', '2026-06-10', 15),
  ('2026-06-15', 'Desparasitacion', '2026-06-15', 16),
  ('2026-06-27', 'Control general', NULL, 17),
  ('2026-07-05', 'Vacunacion', '2026-07-05', 18),
  ('2026-07-18', 'Tratamiento dermatologico', NULL, 19),
  ('2026-08-01', 'Vacunacion', '2026-08-01', 20),
  ('2026-08-05', 'Control de piel', NULL, 21),
  ('2026-08-10', 'Desparasitacion', '2026-08-10', 22);


-- =====================================================================
-- VERIFICACION DE DATOS
-- =====================================================================

SELECT COUNT(*) AS total_apoderados FROM apoderado;

SELECT COUNT(*) AS total_mascotas FROM mascota;

SELECT COUNT(*) AS total_veterinarios FROM veterinario;

SELECT COUNT(*) AS total_consultas FROM consulta;

SELECT COUNT(*) AS total_tratamientos FROM tratamiento;


-- =====================================================================
-- PARTE 2 · LAS DIEZ CONSULTAS
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1 · RANGO DE FECHAS (BETWEEN)
-- Pregunta: ¿Qué consultas veterinarias se realizaron entre abril y
-- junio del año 2026?
-- ---------------------------------------------------------------------

SELECT id_consulta, fecha_con, id_apoderado, id_veterinario
FROM consulta
WHERE fecha_con BETWEEN '2026-04-01' AND '2026-06-30 23:59:59'
ORDER BY fecha_con;


-- ---------------------------------------------------------------------
-- 2 · RANGO DE MONTOS (BETWEEN)
-- Pregunta: ¿Qué mascotas tienen un peso entre 10 y 30 kg?
-- ---------------------------------------------------------------------

SELECT nombre, raza, peso, genero
FROM mascota
WHERE peso BETWEEN 10 AND 30
ORDER BY peso;


-- ---------------------------------------------------------------------
-- 3 · LISTA DE ESTADOS O CATEGORIAS (IN)
-- Pregunta: ¿Qué tratamientos corresponden a vacunación,
-- desparasitación o control general?
-- ---------------------------------------------------------------------

SELECT id_tratamiento, tipo_tratamiento, fecha_ini, fecha_fin
FROM tratamiento
WHERE tipo_tratamiento IN
('Vacunacion', 'Desparasitacion', 'Control general')
ORDER BY fecha_ini;


-- ---------------------------------------------------------------------
-- 4 · LO QUE QUEDA FUERA (NOT IN)
-- Pregunta: ¿Qué tratamientos no corresponden a vacunación ni
-- desparasitación?
-- ---------------------------------------------------------------------

SELECT id_tratamiento, tipo_tratamiento, fecha_ini
FROM tratamiento
WHERE tipo_tratamiento NOT IN
('Vacunacion', 'Desparasitacion')
ORDER BY fecha_ini;


-- ---------------------------------------------------------------------
-- 5 · BUSQUEDA POR TEXTO (ILIKE)
-- Pregunta: ¿Qué apoderados tienen la letra "a" en su nombre?
-- ---------------------------------------------------------------------

SELECT id_apoderado, nombre, telefono
FROM apoderado
WHERE nombre ILIKE '%a%'
ORDER BY nombre;


-- ---------------------------------------------------------------------
-- 6 · UN DATO QUE FALTA (IS NULL)
-- Pregunta: ¿Qué tratamientos todavía no tienen fecha de finalización?
-- ---------------------------------------------------------------------

SELECT id_tratamiento, tipo_tratamiento, fecha_ini, fecha_fin
FROM tratamiento
WHERE fecha_fin IS NULL
ORDER BY fecha_ini;


-- ---------------------------------------------------------------------
-- 7 · UN DATO QUE SI ESTA (IS NOT NULL)
-- Pregunta: ¿Qué tratamientos ya tienen registrada una fecha de
-- finalización?
-- ---------------------------------------------------------------------

SELECT id_tratamiento, tipo_tratamiento, fecha_ini, fecha_fin
FROM tratamiento
WHERE fecha_fin IS NOT NULL
ORDER BY fecha_fin;


-- ---------------------------------------------------------------------
-- 8 · DOS CONDICIONES A LA VEZ (AND)
-- Pregunta: ¿Qué mascotas son hembras y pesan menos de 15 kg?
-- ---------------------------------------------------------------------

SELECT nombre, raza, peso, genero
FROM mascota
WHERE genero = 'Hembra'
AND peso < 15
ORDER BY nombre;


-- ---------------------------------------------------------------------
-- 9 · UNA ALTERNATIVA (OR)
-- Pregunta: ¿Qué veterinarios se especializan en cirugía o
-- dermatología?
-- ---------------------------------------------------------------------

SELECT id_veterinario, nombre, especialidad, telefono
FROM veterinario
WHERE especialidad = 'Cirugia'
OR especialidad = 'Dermatologia'
ORDER BY nombre;


-- ---------------------------------------------------------------------
-- 10 · TRES TABLAS UNIDAS CON UN FILTRO (JOIN + WHERE)
-- Pregunta: ¿Qué consultas fueron realizadas por cada apoderado y
-- qué veterinario las atendió?
-- ---------------------------------------------------------------------

SELECT
    c.id_consulta,
    c.fecha_con,
    a.nombre AS apoderado,
    v.nombre AS veterinario,
    v.especialidad
FROM consulta c
JOIN apoderado a
    ON c.id_apoderado = a.id_apoderado
JOIN veterinario v
    ON c.id_veterinario = v.id_veterinario
WHERE v.especialidad = 'Cirugia'
ORDER BY c.fecha_con;


-- =====================================================================
-- FIN DEL INTEGRADOR
-- =====================================================================

