CREATE TABLE duenos (
    id_dueno SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT
);

CREATE TABLE mascotas (
    id_mascota SERIAL PRIMARY KEY,
    id_dueno INT NOT NULL REFERENCES duenos(id_dueno) ON DELETE CASCADE,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raza VARCHAR(50),
    fecha_nacimiento DATE
);

CREATE TABLE veterinarios (
    id_veterinario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE consultas (
    id_consulta SERIAL PRIMARY KEY,
    id_mascota INT NOT NULL REFERENCES mascotas(id_mascota) ON DELETE RESTRICT,
    id_veterinario INT NOT NULL REFERENCES veterinarios(id_veterinario) ON DELETE RESTRICT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    diagnostico TEXT,
    costo_base DECIMAL(10, 2) NOT NULL DEFAULT 0.00
);

CREATE TABLE servicios (
    id_servicio SERIAL PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

CREATE TABLE detalle_consulta_servicio (
    id_detalle SERIAL PRIMARY KEY,
    id_consulta INT NOT NULL REFERENCES consultas(id_consulta) ON DELETE CASCADE,
    id_servicio INT NOT NULL REFERENCES servicios(id_servicio) ON DELETE RESTRICT,
    observaciones TEXT
);
