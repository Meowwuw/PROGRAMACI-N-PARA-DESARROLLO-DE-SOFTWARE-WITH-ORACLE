CREATE SCHEMA IF NOT EXISTS a_veterinaria;

SET search_path TO a_veterinaria;


SELECT current_schema();


-- ---------------------------------------------------------------------
-- EJERCICIO 1 · CREAR LAS TABLAS
-- Primero las tablas independientes, despues las que tienen FK.
-- Orden: mascota -> apoderado -> veterinario -> consulta -> tratamiento
-- ---------------------------------------------------------------------

CREATE TABLE mascota (
    id_mascota  SERIAL       PRIMARY KEY,
    raza        VARCHAR(50)  NOT NULL,
    peso        VARCHAR(60)  NOT NULL,
    genero      VARCHAR(40)  NOT null
);

CREATE TABLE apoderado (
    id_apoderado SERIAL       PRIMARY KEY,
    telefono     VARCHAR(11)  NOT NULL,
    id_mascota   INT          NOT NULL REFERENCES mascota(id_mascota),
    nombre       VARCHAR(100) NOT NULL
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



INSERT INTO mascota (raza, peso, genero) VALUES
  ('Labrador',         '28kg', 'Macho' ),
  ('Siames',           '4kg',  'Hembra' ),
  ('Pastor Aleman',    '14kg', 'Hembra'),
  ('Bulldog Frances',  '12kg', 'Macho');

INSERT INTO apoderado (telefono, id_mascota, nombre) VALUES
  ('987654321', 1, 'Jander Hidalgo'),
  ('912345678', 2, 'Angel Pinedo'),
  ('913770863', 3, 'Jonas Gonzales'),
  ('998877665', 4, 'Gabriel Amasifuen');

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
















-- ---------------------------------------------------------------------
-- SI NECESITAS EMPEZAR DE CERO
-- Borra en orden inverso al que creaste (primero las tablas con FK).
-- ---------------------------------------------------------------------
 --DROP TABLE IF EXISTS tratamiento;
 --DROP TABLE IF EXISTS consulta;
 --DROP TABLE IF EXISTS veterinario;
 --DROP TABLE IF EXISTS apoderado;
 --DROP TABLE IF EXISTS mascota;
