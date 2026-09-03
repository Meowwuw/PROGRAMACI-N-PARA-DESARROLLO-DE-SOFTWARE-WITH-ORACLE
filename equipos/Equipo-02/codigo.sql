-- =====================================================================
-- BASE DE DATOS · SISTEMA DE VETERINARIA (DATOS AMPLIADOS)
-- Equipo N°: 2
-- =====================================================================

CREATE SCHEMA IF NOT EXISTS a_veterinaria;

SET search_path TO a_veterinaria;

SELECT current_schema();

-- ---------------------------------------------------------------------
-- CREACION DE TABLAS
-- ---------------------------------------------------------------------

CREATE TABLE apoderado (
    id_apoderado SERIAL PRIMARY KEY,
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
-- PARTE 1 · CARGAR LOS DATOS AMPLIADOS
-- =====================================================================

-- APODERADOS (8 Registros)
INSERT INTO apoderado (telefono, nombre) VALUES
    ('987654321', 'Jander Hidalgo'),
    ('912345678', 'Angel Pinedo'),
    ('913770863', 'Jonas Gonzales'),
    ('998877665', 'Gabriel Amasifuen'),
    ('955443322', 'Carlos Mendoza'),
    ('944332211', 'Lucia Ramirez'),
    ('933221100', 'Sofia Torres'),
    ('922110099', 'Mateo Paredes'); -- Apoderado sin consultas para probar LEFT JOIN

-- MASCOTAS (12 Registros)
INSERT INTO mascota (nombre, raza, peso, genero, id_apoderado) VALUES
    ('Rocky', 'Labrador', 28.0, 'Macho', 1),
    ('Luna', 'Siames', 4.2, 'Hembra', 1),
    ('Maya', 'Pastor Aleman', 14.0, 'Hembra', 2),
    ('Toby', 'Bulldog Frances', 12.5, 'Macho', 3),
    ('Thor', 'Golden Retriever', 32.0, 'Macho', 4),
    ('Bella', 'Poodle', 6.5, 'Hembra', 5),
    ('Simba', 'Persa', 5.0, 'Macho', 6),
    ('Nala', 'Mestizo', 9.8, 'Hembra', 6),
    ('Max', 'Rottweiler', 40.2, 'Macho', 7),
    ('Coco', 'Beagle', 11.3, 'Macho', 7),
    ('Kira', 'Siberian Husky', 22.0, 'Hembra', 8),
    ('Pelusa', 'Angora', 3.8, 'Hembra', 8);

-- VETERINARIOS (5 Registros)
INSERT INTO veterinario (nombre, especialidad, telefono) VALUES
    ('Dra. Ana Torres', 'Cirugia', '911111111'),
    ('Dr. Pedro Salas', 'Dermatologia', '922222222'),
    ('Dr. Luis Cordero', 'General', '933333333'),
    ('Dra. Elena Ramos', 'Cardiologia', '944444444'),
    ('Dr. Mario Vega', 'Cirugia', '955555555'); -- Veterinario sin consultas asignadas

-- CONSULTAS (28 Registros)
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
    ('2026-08-10 11:00', 1, 2),
    ('2026-08-12 08:30', 5, 3),
    ('2026-08-15 16:00', 6, 4),
    ('2026-08-18 10:00', 7, 3),
    ('2026-08-20 11:30', 5, 4),
    ('2026-08-22 14:00', 6, 3),
    ('2026-08-25 09:15', 7, 1);

-- TRATAMIENTOS (28 Registros)
INSERT INTO tratamiento (fecha_ini, tipo_tratamiento, fecha_fin, id_consulta) VALUES
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
    ('2026-08-10', 'Desparasitacion', '2026-08-10', 22),
    ('2026-08-12', 'Control general', '2026-08-12', 23),
    ('2026-08-15', 'Evaluacion cardiaca', NULL, 24),
    ('2026-08-18', 'Desparasitacion', '2026-08-18', 25),
    ('2026-08-20', 'Tratamiento cardiaco', NULL, 26),
    ('2026-08-22', 'Vacunacion', '2026-08-22', 27),
    ('2026-08-25', 'Cirugia menor', '2026-08-28', 28);

-- =====================================================================
-- VERIFICACION DE TOTALES
-- =====================================================================

SELECT COUNT(*) AS total_apoderados FROM apoderado;
SELECT COUNT(*) AS total_mascotas FROM mascota;
SELECT COUNT(*) AS total_veterinarios FROM veterinario;
SELECT COUNT(*) AS total_consultas FROM consulta;
SELECT COUNT(*) AS total_tratamientos FROM tratamiento;

-- =====================================================================
-- ACTIVIDAD APLICADA SENATI (3 CONSULTAS CON JOIN)
-- =====================================================================

-- CONSULTA 01: Muestra los apoderados sin registros de consulta (Ej. Mateo Paredes)
SELECT 
    a.id_apoderado,
    a.nombre AS apoderado,
    a.telefono
FROM apoderado a
LEFT JOIN consulta c 
    ON a.id_apoderado = c.id_apoderado
WHERE c.id_consulta IS NULL
ORDER BY a.nombre;

-- CONSULTA 02: Relación de tratamientos con el apoderado y veterinario responsable
SELECT 
    t.id_tratamiento,
    t.fecha_ini,
    t.tipo_tratamiento,
    a.nombre AS apoderado,
    v.nombre AS veterinario,
    v.especialidad
FROM tratamiento t
INNER JOIN consulta c 
    ON t.id_consulta = c.id_consulta
INNER JOIN apoderado a 
    ON c.id_apoderado = a.id_apoderado
INNER JOIN veterinario v 
    ON c.id_veterinario = v.id_veterinario
ORDER BY t.fecha_ini DESC;

-- CONSULTA 03: Conteo de consultas atendidas por cada veterinario (Incluye Dr. Mario Vega con 0)
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
