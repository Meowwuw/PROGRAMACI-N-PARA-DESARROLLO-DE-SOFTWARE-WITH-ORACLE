
CREATE TABLE planeta (
    id_planeta SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    region_galactica VARCHAR(50),
    clima_dominante VARCHAR(40)
);

CREATE TABLE faccion (
    id_faccion SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ideologia VARCHAR(40),
    nivel_influencia INTEGER
);

CREATE TABLE personaje (
    id_personaje SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    nivel_conexion_fuerza INTEGER,
    especie VARCHAR(30),
    id_planeta_origen INTEGER REFERENCES planeta(id_planeta),
    id_faccion INTEGER REFERENCES faccion(id_faccion)
);

CREATE TABLE nave (
    id_nave SERIAL PRIMARY KEY,
    modelo VARCHAR(50) NOT NULL,
    velocidad_hiperimpulsor DECIMAL(3,1)
);
-- Tabla intermedia para resolver la relación N:M
CREATE TABLE mision (
    id_mision SERIAL PRIMARY KEY,
    id_personaje INTEGER REFERENCES personaje(id_personaje),
    id_nave INTEGER REFERENCES nave(id_nave),
    rol_asignado VARCHAR(40),
    fecha_mision DATE
);
