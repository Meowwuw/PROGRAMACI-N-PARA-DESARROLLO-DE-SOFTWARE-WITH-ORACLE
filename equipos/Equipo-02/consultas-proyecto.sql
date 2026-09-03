
-- =====================================================================
-- BASE DE DATOS · SISTEMA DE VETERINARIA
-- =====================================================================
-- Equipo N°: 2
-- =====================================================================




CREATE SCHEMA IF NOT EXISTS a_veterinaria;

SET search_path TO a_veterinaria;

SELECT current_schema();




CREATE TABLE apoderado (
    id_apoderado SERIAL PRIMARY KEY,
    dni          VARCHAR(8)  NOT NULL UNIQUE,
    telefono     VARCHAR(11) NOT NULL,
    nombre       VARCHAR(100) NOT NULL
);




CREATE TABLE mascota (
    id_mascota   SERIAL PRIMARY KEY,
    nombre       VARCHAR(50) NOT NULL,
    raza         VARCHAR(50) NOT NULL,
    peso         NUMERIC(5,2) NOT NULL,
    genero       VARCHAR(40) NOT NULL,
    id_apoderado INT NOT NULL REFERENCES apoderado(id_apoderado)
);


-

CREATE TABLE veterinario (
    id_veterinario SERIAL PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    especialidad   VARCHAR(50) NOT NULL,
    telefono       VARCHAR(11) NOT NULL
);




CREATE TABLE consulta (
    id_consulta    SERIAL PRIMARY KEY,
    fecha_con      TIMESTAMP NOT NULL DEFAULT NOW(),
    id_apoderado   INT NOT NULL REFERENCES apoderado(id_apoderado),
    id_mascota     INT NOT NULL REFERENCES mascota(id_mascota),
    id_veterinario INT NOT NULL REFERENCES veterinario(id_veterinario)
);




CREATE TABLE tratamiento (
    id_tratamiento   SERIAL PRIMARY KEY,
    fecha_ini        DATE NOT NULL DEFAULT CURRENT_DATE,
    tipo_tratamiento VARCHAR(100) NOT NULL,
    fecha_fin        DATE,
    id_consulta      INT NOT NULL REFERENCES consulta(id_consulta)
);


-- =====================================================================
-- PARTE 2 · CARGAR LOS DATOS
-- =====================================================================


-- ---------------------------------------------------------------------
-- APODERADOS
-- ---------------------------------------------------------------------

INSERT INTO apoderado (dni, telefono, nombre) VALUES
    ('12345678', '987654321', 'Jander Hidalgo'),
    ('23456789', '912345678', 'Angel Pinedo'),
    ('34567890', '913770863', 'Jonas Gonzales'),
    ('61265675', '942098811', 'Magenta Paredes'),
    ('81469712', '917567921', 'Juanito Ponce'),
    ('89157201', '976541354', 'Luis Gonzales'),
    ('94102843', '965451518', 'Lucas Valverde'),
    ('72144035', '951054695', 'Martina Saavedra'),
    ('94626501', '936521401', 'Samanta Rojas'),
    ('45678901', '998877665', 'Gabriel Amasifuen');


-- ---------------------------------------------------------------------
-- MASCOTAS
-- ---------------------------------------------------------------------

INSERT INTO mascota (nombre, raza, peso, genero, id_apoderado) VALUES
    ('Rocky', 'Labrador', 28, 'Macho', 1),
    ('Luna', 'Siames', 4.2, 'Hembra', 1),
    ('Maya', 'Pastor Aleman', 14, 'Hembra', 2),
    ('Toby', 'Bulldog Frances', 12.5, 'Macho', 3),
    ('Max', 'Golden Retriever', 30, 'Macho', 4),
    ('Nala', 'Persa', 4.8, 'Hembra', 5),
    ('Bruno', 'Rottweiler', 35, 'Macho', 6),
    ('Coco', 'Chihuahua', 3.2, 'Hembra', 7),
    ('Simba', 'Maine Coon', 7.5, 'Macho', 8),
    ('Bella', 'Poodle', 8.5, 'Hembra', 9),
    ('Zeus', 'Husky Siberiano', 25, 'Macho', 10),
    ('Milo', 'Beagle', 11, 'Macho', 2),
    ('Kira', 'Shih Tzu', 6.5, 'Hembra', 3),
    ('Thor', 'Boxer', 27, 'Macho', 4),
    ('Canela', 'Cocker Spaniel', 10, 'Hembra', 5),
    ('Doki', 'Schnauzer', 9, 'Macho', 6),
    ('Mia', 'Angora', 4.1, 'Hembra', 7);


-- ---------------------------------------------------------------------
-- VETERINARIOS
-- ---------------------------------------------------------------------

INSERT INTO veterinario (nombre, especialidad, telefono) VALUES
    ('Dra. Ana Torres', 'Cirugia', '913770863'),
    ('Dr. Pedro Salas', 'Dermatologia', '942098811'),
    ('Dra. Maria Lopez', 'Medicina Interna', '987654321'),
    ('Dr. Carlos Ramirez', 'Cardiologia', '912345678'),
    ('Dra. Sofia Mendoza', 'Oftalmologia', '913456789'),
    ('Dr. Luis Vargas', 'Traumatologia', '914567890'),
    ('Dra. Elena Castro', 'Pediatria Veterinaria', '915678901'),
    ('Dr. Jorge Rojas', 'Odontologia', '916789012'),
    ('Dra. Patricia Silva', 'Neurologia', '917890123'),
    ('Dr. Miguel Flores', 'Oncologia', '918901234'),
    ('Dra. Laura Perez', 'Nutricion Animal', '919012345'),
    ('Dr. Diego Fernandez', 'Emergencias', '920123456');


-- ---------------------------------------------------------------------
-- CONSULTAS
-- ---------------------------------------------------------------------

INSERT INTO consulta
    (fecha_con, id_apoderado, id_mascota, id_veterinario)
VALUES
    ('2026-01-10 09:00', 1, 1, 1),
    ('2026-01-18 15:30', 2, 3, 2),
    ('2026-02-05 11:00', 1, 2, 2),
    ('2026-02-15 10:30', 3, 4, 1),
    ('2026-02-28 16:00', 4, 1, 2),
    ('2026-03-05 09:30', 1, 1, 1),
    ('2026-03-17 14:00', 2, 3, 2),
    ('2026-03-25 11:30', 3, 4, 1),
    ('2026-04-02 10:00', 4, 1, 2),
    ('2026-04-15 15:00', 1, 2, 1),
    ('2026-04-28 09:00', 2, 3, 2),
    ('2026-05-06 13:30', 3, 4, 1),
    ('2026-05-18 10:30', 4, 1, 2),
    ('2026-05-29 16:30', 1, 1, 1),
    ('2026-06-03 09:00', 2, 3, 2),
    ('2026-06-15 11:00', 3, 4, 1),
    ('2026-06-27 14:30', 4, 1, 2),
    ('2026-07-05 10:00', 1, 1, 1),
    ('2026-07-18 15:30', 2, 3, 2),
    ('2026-08-01 09:00', 3, 4, 1),
    ('2026-08-05 15:30', 4, 1, 2),
    ('2026-08-10 11:00', 1, 2, 2);


-- ---------------------------------------------------------------------
-- TRATAMIENTOS
-- ---------------------------------------------------------------------

INSERT INTO tratamiento
    (fecha_ini, tipo_tratamiento, fecha_fin, id_consulta)
VALUES
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
-- PARTE 3 · VERIFICACION
-- =====================================================================

SELECT * FROM apoderado;

SELECT * FROM mascota;

SELECT * FROM veterinario;

SELECT * FROM consulta;

SELECT * FROM tratamiento;


-- =====================================================================
-- CONSULTAS DEL PROYECTO
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1 · RANGO DE FECHAS (BETWEEN)
-- ¿Qué consultas veterinarias se realizaron entre abril y junio
-- del año 2026?
-- ---------------------------------------------------------------------

SELECT
    id_consulta,
    fecha_con,
    id_apoderado,
    id_mascota,
    id_veterinario
FROM consulta
WHERE fecha_con BETWEEN '2026-04-01'
                    AND '2026-06-30 23:59:59'
ORDER BY fecha_con;


-- ---------------------------------------------------------------------
-- 2 · RANGO DE PESO (BETWEEN)
-- ¿Qué mascotas tienen un peso entre 10 y 30 kg?
-- ---------------------------------------------------------------------

SELECT
    id_mascota,
    nombre,
    raza,
    peso,
    genero
FROM mascota
WHERE peso BETWEEN 10 AND 30
ORDER BY peso;


-- ---------------------------------------------------------------------
-- 3 · LISTA DE CATEGORIAS (IN)
-- ---------------------------------------------------------------------

SELECT
    id_tratamiento,
    tipo_tratamiento,
    fecha_ini,
    fecha_fin
FROM tratamiento
WHERE tipo_tratamiento IN
    ('Vacunacion', 'Desparasitacion', 'Control general')
ORDER BY fecha_ini;


-- ---------------------------------------------------------------------
-- 4 · LO QUE QUEDA FUERA (NOT IN)
-- ---------------------------------------------------------------------

SELECT
    id_tratamiento,
    tipo_tratamiento,
    fecha_ini
FROM tratamiento
WHERE tipo_tratamiento NOT IN
    ('Vacunacion', 'Desparasitacion')
ORDER BY fecha_ini;


-- ---------------------------------------------------------------------
-- 5 · BUSQUEDA POR TEXTO (ILIKE)
-- ¿Qué apoderados tienen la letra "a" en su nombre?
-- ---------------------------------------------------------------------

SELECT
    id_apoderado,
    dni,
    nombre,
    telefono
FROM apoderado
WHERE nombre ILIKE '%a%'
ORDER BY nombre;


-- ---------------------------------------------------------------------
-- 6 · UN DATO QUE FALTA (IS NULL)
-- ---------------------------------------------------------------------

SELECT
    id_tratamiento,
    tipo_tratamiento,
    fecha_ini,
    fecha_fin
FROM tratamiento
WHERE fecha_fin IS NULL
ORDER BY fecha_ini;


-- ---------------------------------------------------------------------
-- 7 · UN DATO QUE SI ESTA (IS NOT NULL)
-- ---------------------------------------------------------------------

SELECT
    id_tratamiento,
    tipo_tratamiento,
    fecha_ini,
    fecha_fin
FROM tratamiento
WHERE fecha_fin IS NOT NULL
ORDER BY fecha_fin;


-- ---------------------------------------------------------------------
-- 8 · DOS CONDICIONES A LA VEZ (AND)
-- ¿Qué mascotas son hembras y pesan menos de 15 kg?
-- ---------------------------------------------------------------------

SELECT
    id_mascota,
    nombre,
    raza,
    peso,
    genero
FROM mascota
WHERE genero = 'Hembra'
AND peso < 15
ORDER BY nombre;


-- ---------------------------------------------------------------------
-- 9 · UNA ALTERNATIVA (OR)
-- ¿Qué veterinarios se especializan en cirugía o dermatología?
-- ---------------------------------------------------------------------

SELECT
    id_veterinario,
    nombre,
    especialidad,
    telefono
FROM veterinario
WHERE especialidad = 'Cirugia'
   OR especialidad = 'Dermatologia'
ORDER BY nombre;


-- ---------------------------------------------------------------------
-- 10 · CONSULTA COMPLETA CON JOIN
-- ¿Qué consultas fueron realizadas por cada apoderado,
-- qué mascota atendieron y qué veterinario la atendió?
-- ---------------------------------------------------------------------

SELECT
    c.id_consulta,
    c.fecha_con,
    a.id_apoderado,
    a.dni,
    a.nombre AS apoderado,
    m.id_mascota,
    m.nombre AS mascota,
    m.raza,
    v.id_veterinario,
    v.nombre AS veterinario,
    v.especialidad
FROM consulta c
JOIN apoderado a
    ON c.id_apoderado = a.id_apoderado
JOIN mascota m
    ON c.id_mascota = m.id_mascota
JOIN veterinario v
    ON c.id_veterinario = v.id_veterinario
ORDER BY c.fecha_con;


-- =====================================================================
-- COMPROBACION RAPIDA
-- ¿Cuántas mascotas tiene cada apoderado?
-- =====================================================================

SELECT
    a.id_apoderado,
    a.dni,
    a.nombre,
    COUNT(m.id_mascota) AS total_mascotas
FROM apoderado a
LEFT JOIN mascota m
    ON m.id_apoderado = a.id_apoderado
GROUP BY
    a.id_apoderado,
    a.dni,
    a.nombre
ORDER BY total_mascotas DESC;

--------------------------------------------------------------------------


-- =========================================================
-- CONSULTA 01
-- --Necesidad: Ver el historial completo de una mascota:
--   quién es su dueño, qué veterinario la atendió, cuándo,
--   y qué se diagnosticó. Útil para mostrarle al dueño el
--   historial médico de su mascota.
-- --Tablas involucradas: mascotas, duenos, consultas, veterinarios
-- --Tipo de JOIN: INNER JOIN
-- --Justificación: Usamos INNER JOIN porque solo nos interesan
--   mascotas que SÍ tienen consultas registradas. No tiene
--   sentido mostrar una mascota sin historial en este reporte.
-- --Consulta SQL:
SELECT
    m.nombre AS mascota,
    d.nombre AS dueno,
    v.nombre AS veterinario,
    c.fecha_hora,
    c.diagnostico
FROM mascotas m
INNER JOIN duenos d ON m.id_dueno = d.id_dueno
INNER JOIN consultas c ON c.id_mascota = m.id_mascota
INNER JOIN veterinarios v ON c.id_veterinario = v.id_veterinario
ORDER BY c.fecha_hora DESC;


-- =========================================================
-- CONSULTA 02
-- --Necesidad: Calcular cuánto se le debe cobrar a un dueño
--   por una consulta, sumando el costo base más todos los
--   servicios adicionales aplicados (vacunas, análisis, etc.).
-- --Tablas involucradas: consultas, detalle_consulta_servicio, servicios
-- --Tipo de JOIN: INNER JOIN
-- --Justificación: Usamos INNER JOIN porque el reporte solo
--   tiene sentido para consultas que realmente tuvieron
--   servicios aplicados; si no hay detalle, no hay nada que sumar.
-- --Consulta SQL:
SELECT
    c.id_consulta,
    c.costo_base,
    s.nombre_servicio,
    s.precio,
    (c.costo_base + SUM(s.precio) OVER (PARTITION BY c.id_consulta)) AS total_estimado
FROM consultas c
INNER JOIN detalle_consulta_servicio dcs ON dcs.id_consulta = c.id_consulta
INNER JOIN servicios s ON s.id_servicio = dcs.id_servicio
ORDER BY c.id_consulta;


-- =========================================================
-- CONSULTA 03
-- --Necesidad: Listar TODAS las mascotas registradas junto con
--   su especie y raza, incluyendo aquellas que aún no han tenido
--   ninguna consulta (para que la recepción sepa a quién le falta
--   agendar su primera cita).
-- --Tablas involucradas: mascotas, razas, especies, consultas
-- --Tipo de JOIN: INNER JOIN (para razas/especies) + LEFT JOIN (para consultas)
-- --Justificación: mascotas SIEMPRE debe tener raza y especie
--   (son obligatorias, NOT NULL), por eso ahí usamos INNER JOIN.
--   Pero usamos LEFT JOIN con consultas porque queremos ver
--   TODAS las mascotas, incluso las que todavía no tienen
--   ninguna consulta registrada (si usáramos INNER JOIN aquí,
--   esas mascotas desaparecerían del resultado).
-- --Consulta SQL:
SELECT
    m.nombre AS mascota,
    e.nombre_especie,
    r.nombre_raza,
    COUNT(c.id_consulta) AS total_consultas
FROM mascotas m
INNER JOIN razas r ON m.id_raza = r.id_raza
INNER JOIN especies e ON r.id_especie = e.id_especie
LEFT JOIN consultas c ON c.id_mascota = m.id_mascota
GROUP BY m.id_mascota, m.nombre, e.nombre_especie, r.nombre_raza
ORDER BY total_consultas ASC;

-- =====================================================================
-- ACTIVIDAD APLICADA AL PROYECTO: CONSULTAS CON JOIN
-- =====================================================================

-- ---------------------------------------------------------------------
-- CONSULTA 01: Mascotas registradas sin atenciones o consultas
-- ---------------------------------------------------------------------
-- Necesidad: Identificar qué mascotas registradas en el sistema aún no han tenido ninguna consulta médica para realizar campañas de fidelización o seguimiento preventivo.
-- Tablas involucradas: mascota (A), consulta (B)
-- Tipo de JOIN: LEFT JOIN (filtrando con NULL en B)
-- Justificación: Nos permite traer la totalidad de mascotas (tabla izquierda) y cruzarla con sus consultas. Al filtrar donde el ID de la consulta sea NULL, aislamos únicamente a las mascotas que nunca han acudido a una cita.

SELECT 
    m.id_mascota,
    m.nombre AS nombre_mascota,
    m.raza,
    a.nombre AS nombre_apoderado,
    a.telefono
FROM mascota m
LEFT JOIN consulta c 
    ON m.id_mascota = c.id_mascota
JOIN apoderado a 
    ON m.id_apoderado = a.id_apoderado
WHERE c.id_consulta IS NULL
ORDER BY m.nombre;


-- ---------------------------------------------------------------------
-- CONSULTA 02: Historial clínico detallado de tratamientos por mascota
-- ---------------------------------------------------------------------
-- Necesidad: Consultar el historial médico completo de una mascota, relacionando el tratamiento recibido con la fecha de atención y el veterinario responsable.
-- Tablas involucradas: mascota, consulta, tratamiento, veterinario
-- Tipo de JOIN: INNER JOIN
-- Justificación: Permite relacionar estrictamente los registros que coinciden en la cadena de atención (mascota -> consulta -> tratamiento -> veterinario) para construir una vista clínica consolidada sin dejar datos huérfanos.

SELECT 
    m.nombre AS mascota,
    t.tipo_tratamiento,
    t.fecha_ini,
    t.fecha_fin,
    v.nombre AS veterinario,
    v.especialidad
FROM tratamiento t
INNER JOIN consulta c 
    ON t.id_consulta = c.id_consulta
INNER JOIN mascota m 
    ON c.id_mascota = m.id_mascota
INNER JOIN veterinario v 
    ON c.id_veterinario = v.id_veterinario
ORDER BY t.fecha_ini DESC;


-- ---------------------------------------------------------------------
-- CONSULTA 03: Reporte de productividad médica y demanda por especialidad
-- ---------------------------------------------------------------------
-- Necesidad: Evaluar la carga de trabajo de los veterinarios y el rendimiento del personal médico según las consultas registradas en la clínica.
-- Tablas involucradas: veterinario (A), consulta (B)
-- Tipo de JOIN: LEFT JOIN
-- Justificación: Se utiliza un LEFT JOIN para asegurar que figuren todos los veterinarios contratados en el reporte, incluso aquellos que aún no han atendido ninguna consulta (obteniendo un conteo de 0).

SELECT 
    v.id_veterinario,
    v.nombre AS veterinario,
    v.especialidad,
    COUNT(c.id_consulta) AS total_consultas_atendidas
FROM veterinario v
LEFT JOIN consulta c 
    ON v.id_veterinario = c.id_veterinario
GROUP BY 
    v.id_veterinario, 
    v.nombre, 
    v.especialidad
ORDER BY total_consultas_atendidas DESC;
-- =====================================================================

