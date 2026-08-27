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
