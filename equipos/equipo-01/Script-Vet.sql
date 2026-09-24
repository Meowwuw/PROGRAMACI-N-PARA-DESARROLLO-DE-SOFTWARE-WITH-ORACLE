-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

-- DROP SEQUENCE consultas_id_consulta_seq;

CREATE SEQUENCE consultas_id_consulta_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE detalle_consulta_servicio_id_detalle_seq;

CREATE SEQUENCE detalle_consulta_servicio_id_detalle_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE duenos_id_dueno_seq;

CREATE SEQUENCE duenos_id_dueno_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE especies_id_especie_seq;

CREATE SEQUENCE especies_id_especie_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE mascotas_id_mascota_seq;

CREATE SEQUENCE mascotas_id_mascota_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE razas_id_raza_seq;

CREATE SEQUENCE razas_id_raza_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE servicios_id_servicio_seq;

CREATE SEQUENCE servicios_id_servicio_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE veterinarios_id_veterinario_seq;

CREATE SEQUENCE veterinarios_id_veterinario_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.duenos definition

-- Drop table

-- DROP TABLE duenos;

CREATE TABLE duenos (
	id_dueno serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	telefono varchar(20) NULL,
	direccion text NULL,
	CONSTRAINT duenos_id_dueno_not_null NOT NULL id_dueno,
	CONSTRAINT duenos_nombre_not_null NOT NULL nombre,
	CONSTRAINT duenos_pkey PRIMARY KEY (id_dueno)
);


-- public.especies definition

-- Drop table

-- DROP TABLE especies;

CREATE TABLE especies (
	id_especie serial4 NOT NULL,
	nombre_especie varchar(30) NOT NULL,
	CONSTRAINT especies_id_especie_not_null NOT NULL id_especie,
	CONSTRAINT especies_nombre_especie_key UNIQUE (nombre_especie),
	CONSTRAINT especies_nombre_especie_not_null NOT NULL nombre_especie,
	CONSTRAINT especies_pkey PRIMARY KEY (id_especie)
);


-- public.servicios definition

-- Drop table

-- DROP TABLE servicios;

CREATE TABLE servicios (
	id_servicio serial4 NOT NULL,
	nombre_servicio varchar(100) NOT NULL,
	precio numeric(10, 2) NOT NULL,
	CONSTRAINT servicios_id_servicio_not_null NOT NULL id_servicio,
	CONSTRAINT servicios_nombre_servicio_not_null NOT NULL nombre_servicio,
	CONSTRAINT servicios_pkey PRIMARY KEY (id_servicio),
	CONSTRAINT servicios_precio_not_null NOT NULL precio
);


-- public.veterinarios definition

-- Drop table

-- DROP TABLE veterinarios;

CREATE TABLE veterinarios (
	id_veterinario serial4 NOT NULL,
	nombre varchar(100) NOT NULL,
	especialidad varchar(100) NULL,
	telefono varchar(20) NULL,
	CONSTRAINT veterinarios_id_veterinario_not_null NOT NULL id_veterinario,
	CONSTRAINT veterinarios_nombre_not_null NOT NULL nombre,
	CONSTRAINT veterinarios_pkey PRIMARY KEY (id_veterinario)
);


-- public.razas definition

-- Drop table

-- DROP TABLE razas;

CREATE TABLE razas (
	id_raza serial4 NOT NULL,
	id_especie int4 NOT NULL,
	nombre_raza varchar(50) NOT NULL,
	CONSTRAINT razas_id_especie_not_null NOT NULL id_especie,
	CONSTRAINT razas_id_raza_not_null NOT NULL id_raza,
	CONSTRAINT razas_nombre_raza_not_null NOT NULL nombre_raza,
	CONSTRAINT razas_pkey PRIMARY KEY (id_raza),
	CONSTRAINT razas_id_especie_fkey FOREIGN KEY (id_especie) REFERENCES especies(id_especie)
);


-- public.mascotas definition

-- Drop table

-- DROP TABLE mascotas;

CREATE TABLE mascotas (
	id_mascota serial4 NOT NULL,
	id_dueno int4 NOT NULL,
	nombre varchar(50) NOT NULL,
	id_raza int4 NOT NULL,
	fecha_nacimiento date NULL,
	CONSTRAINT mascotas_id_dueno_not_null NOT NULL id_dueno,
	CONSTRAINT mascotas_id_mascota_not_null NOT NULL id_mascota,
	CONSTRAINT mascotas_id_raza_not_null NOT NULL id_raza,
	CONSTRAINT mascotas_nombre_not_null NOT NULL nombre,
	CONSTRAINT mascotas_pkey PRIMARY KEY (id_mascota),
	CONSTRAINT mascotas_id_dueno_fkey FOREIGN KEY (id_dueno) REFERENCES duenos(id_dueno),
	CONSTRAINT mascotas_id_raza_fkey FOREIGN KEY (id_raza) REFERENCES razas(id_raza)
);


-- public.consultas definition

-- Drop table

-- DROP TABLE consultas;

CREATE TABLE consultas (
	id_consulta serial4 NOT NULL,
	id_mascota int4 NOT NULL,
	id_veterinario int4 NOT NULL,
	fecha_hora timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	diagnostico text NULL,
	costo_base numeric(10, 2) DEFAULT 0.00 NOT NULL,
	CONSTRAINT consultas_costo_base_not_null NOT NULL costo_base,
	CONSTRAINT consultas_id_consulta_not_null NOT NULL id_consulta,
	CONSTRAINT consultas_id_mascota_not_null NOT NULL id_mascota,
	CONSTRAINT consultas_id_veterinario_not_null NOT NULL id_veterinario,
	CONSTRAINT consultas_pkey PRIMARY KEY (id_consulta),
	CONSTRAINT consultas_id_mascota_fkey FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota),
	CONSTRAINT consultas_id_veterinario_fkey FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_veterinario)
);


-- public.detalle_consulta_servicio definition

-- Drop table

-- DROP TABLE detalle_consulta_servicio;

CREATE TABLE detalle_consulta_servicio (
	id_detalle serial4 NOT NULL,
	id_consulta int4 NOT NULL,
	id_servicio int4 NOT NULL,
	observaciones text NULL,
	CONSTRAINT detalle_consulta_servicio_id_consulta_not_null NOT NULL id_consulta,
	CONSTRAINT detalle_consulta_servicio_id_detalle_not_null NOT NULL id_detalle,
	CONSTRAINT detalle_consulta_servicio_id_servicio_not_null NOT NULL id_servicio,
	CONSTRAINT detalle_consulta_servicio_pkey PRIMARY KEY (id_detalle),
	CONSTRAINT detalle_consulta_servicio_id_consulta_fkey FOREIGN KEY (id_consulta) REFERENCES consultas(id_consulta),
	CONSTRAINT detalle_consulta_servicio_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);
select * from usuarios;


-- Creamos la secuencia para los usuarios
CREATE TABLE usuarios (
	id_usuario serial4 NOT NULL,
	email varchar(100) NOT NULL,    -- Cambio a email para coincidir con tu frontend
	password varchar(255) NOT NULL,
	rol varchar(20) NOT NULL,
	id_veterinario int4 NULL,
	
	CONSTRAINT usuarios_email_key UNIQUE (email),
	CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario),
	CONSTRAINT usuarios_id_veterinario_fkey FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_veterinario)
);

select * from usuarios;

select * from veterinarios;



drop table usuarios;