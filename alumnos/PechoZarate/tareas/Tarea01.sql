
-- -----------------------------------------------------------------------------
-- Equipos: Avengers, Guardianes de la Galaxia, X-Men.
-- Héroes: Iron Man, Capitán América, Thor, Spider-Man.
-- Artefactos: Mjolnir, Escudo del Capitán América, Guantelete del Infinito.
-- Villanos: Thanos, Loki, Ultron.
-- Misiones: Batalla de Nueva York, Batalla de Wakanda, etc.
-- -----------------------------------------------------------------------------

CREATE TABLE equipos (
    id_equipo SERIAL PRIMARY KEY,
    nombre_equipo VARCHAR(100) NOT NULL,
    base_operaciones VARCHAR(100),
    fecha_fundacion DATE
);

CREATE TABLE heroes (
    id_heroe SERIAL PRIMARY KEY,
    nombre_heroe VARCHAR(100) NOT NULL,
    alias_secreto VARCHAR(100),
    puntos_poder INT NOT NULL CHECK (puntos_poder BETWEEN 0 AND 100),
    nivel_amenaza VARCHAR(20) CHECK (nivel_amenaza IN ('Bajo', 'Medio', 'Alto', 'Cosmico')),
    id_equipo INT REFERENCES equipos(id_equipo)
);

CREATE TABLE artefactos (
    id_artefacto SERIAL PRIMARY KEY,
    nombre_artefacto VARCHAR(100) NOT NULL,
    tipo_energia VARCHAR(50),
    nivel_poder INT CHECK (nivel_poder BETWEEN 0 AND 100),
    id_heroe INT REFERENCES heroes(id_heroe)
);

CREATE TABLE villanos (
    id_villano SERIAL PRIMARY KEY,
    nombre_villano VARCHAR(100) NOT NULL,
    nivel_peligro INT NOT NULL CHECK (nivel_peligro BETWEEN 0 AND 100),
    motivacion VARCHAR(150)
);

CREATE TABLE misiones (
    id_mision SERIAL PRIMARY KEY,
    nombre_mision VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100),
    fecha_mision DATE,
    id_villano INT REFERENCES villanos(id_villano)
);
