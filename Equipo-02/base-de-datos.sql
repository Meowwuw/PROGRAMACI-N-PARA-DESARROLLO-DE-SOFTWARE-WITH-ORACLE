-- =====================================================================
-- BASE DE DATOS UNICA · SISTEMA DE VETERINARIA + AUTENTICACION
-- Equipo N°: 2
-- Contiene 8 tablas: apoderado, mascota, veterinario, consulta,
-- tratamiento, rol, usuario, registro_login
--

-- =====================================================================

DROP SCHEMA IF EXISTS a_veterinaria CASCADE;
CREATE SCHEMA IF NOT EXISTS a_veterinaria;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

--EJECUTAR EN LA BASE DE DATOS SI NO REGISTRA CONSULTAS
ALTER TABLE a_veterinaria.consulta ADD COLUMN id_mascota INT REFERENCES a_veterinaria.mascota(id_mascota);
-- ---------------------------------------------------------------------
-- CREACION DE TABLAS · SISTEMA DE VETERINARIA
-- ---------------------------------------------------------------------

CREATE TABLE a_veterinaria.apoderado (
    id_apoderado SERIAL PRIMARY KEY,
    telefono     VARCHAR(11) NOT NULL,
    nombre       VARCHAR(100) NOT NULL
);

CREATE TABLE a_veterinaria.mascota (
    id_mascota   SERIAL PRIMARY KEY,
    nombre       VARCHAR(50) NOT NULL,
    raza         VARCHAR(50) NOT NULL,
    peso         NUMERIC(5,2) NOT NULL,
    genero       VARCHAR(40) NOT NULL,
    id_apoderado INT NOT NULL REFERENCES a_veterinaria.apoderado(id_apoderado)
);

CREATE TABLE a_veterinaria.veterinario (
    id_veterinario SERIAL PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    especialidad   VARCHAR(50) NOT NULL,
    telefono       VARCHAR(11) NOT NULL
);

CREATE TABLE a_veterinaria.consulta (
    id_consulta    SERIAL PRIMARY KEY,
    fecha_con      TIMESTAMP NOT NULL DEFAULT NOW(),
    id_apoderado   INT NOT NULL REFERENCES a_veterinaria.apoderado(id_apoderado),
    id_veterinario INT NOT NULL REFERENCES a_veterinaria.veterinario(id_veterinario)
);

CREATE TABLE a_veterinaria.tratamiento (
    id_tratamiento   SERIAL PRIMARY KEY,
    fecha_ini        DATE NOT NULL DEFAULT CURRENT_DATE,
    tipo_tratamiento VARCHAR(100) NOT NULL,
    fecha_fin        DATE,
    id_consulta      INT NOT NULL REFERENCES a_veterinaria.consulta(id_consulta)
);

-- ---------------------------------------------------------------------
-- CREACION DE TABLAS · MODULO DE AUTENTICACION (LOGIN Y REGISTRO)
-- ---------------------------------------------------------------------

CREATE TABLE a_veterinaria.rol (
    id_rol     SERIAL PRIMARY KEY,
    nombre_rol VARCHAR(30) NOT NULL UNIQUE
);

-- Credenciales: el formulario de registro hace INSERT aqui
-- y el formulario de login hace SELECT aqui.
-- Un usuario puede estar vinculado a un apoderado o a un veterinario.
CREATE TABLE a_veterinaria.usuario (
    id_usuario        SERIAL PRIMARY KEY,
    username          VARCHAR(50)  NOT NULL UNIQUE,
    email             VARCHAR(100) NOT NULL UNIQUE,
    password_hash     VARCHAR(255) NOT NULL,
    id_rol            INT NOT NULL DEFAULT 4 REFERENCES a_veterinaria.rol(id_rol), -- 4 = apoderado
    id_apoderado      INT UNIQUE REFERENCES a_veterinaria.apoderado(id_apoderado),
    id_veterinario    INT UNIQUE REFERENCES a_veterinaria.veterinario(id_veterinario),
    estado            BOOLEAN   NOT NULL DEFAULT TRUE,
    intentos_fallidos INT       NOT NULL DEFAULT 0,
    fecha_registro    TIMESTAMP NOT NULL DEFAULT NOW(),
    ultimo_login      TIMESTAMP,
    CONSTRAINT ck_usuario_vinculo
        CHECK (id_apoderado IS NULL OR id_veterinario IS NULL)
);

-- Historial de accesos: cada intento de login (exitoso o fallido)
CREATE TABLE a_veterinaria.registro_login (
    id_registro        SERIAL PRIMARY KEY,
    id_usuario         INT REFERENCES a_veterinaria.usuario(id_usuario) ON DELETE SET NULL,
    username_intentado VARCHAR(50) NOT NULL,
    fecha_hora         TIMESTAMP   NOT NULL DEFAULT NOW(),
    exito              BOOLEAN     NOT NULL,
    ip_origen          VARCHAR(45),
    dispositivo        VARCHAR(255)
);

CREATE INDEX idx_registro_login_usuario ON a_veterinaria.registro_login(id_usuario);
CREATE INDEX idx_registro_login_fecha   ON a_veterinaria.registro_login(fecha_hora);

-- =====================================================================
-- PARTE 1 · CARGAR LOS DATOS AMPLIADOS
-- =====================================================================

-- APODERADOS (8 Registros)
INSERT INTO a_veterinaria.apoderado (telefono, nombre) VALUES
    ('987654321', 'Jander Hidalgo'),
    ('912345678', 'Angel Pinedo'),
    ('913770863', 'Jonas Gonzales'),
    ('998877665', 'Gabriel Amasifuen'),
    ('955443322', 'Carlos Mendoza'),
    ('944332211', 'Lucia Ramirez'),
    ('933221100', 'Sofia Torres'),
    ('922110099', 'Mateo Paredes'); -- Apoderado sin consultas para probar LEFT JOIN

-- MASCOTAS (12 Registros)
INSERT INTO a_veterinaria.mascota (nombre, raza, peso, genero, id_apoderado) VALUES
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
INSERT INTO a_veterinaria.veterinario (nombre, especialidad, telefono) VALUES
    ('Dra. Ana Torres', 'Cirugia', '911111111'),
    ('Dr. Pedro Salas', 'Dermatologia', '922222222'),
    ('Dr. Luis Cordero', 'General', '933333333'),
    ('Dra. Elena Ramos', 'Cardiologia', '944444444'),
    ('Dr. Mario Vega', 'Cirugia', '955555555'); -- Veterinario sin consultas asignadas

-- CONSULTAS (28 Registros)
INSERT INTO a_veterinaria.consulta (fecha_con, id_apoderado, id_veterinario) VALUES
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
INSERT INTO a_veterinaria.tratamiento (fecha_ini, tipo_tratamiento, fecha_fin, id_consulta) VALUES
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

-- ROLES (4 Registros)
INSERT INTO a_veterinaria.rol (nombre_rol) VALUES
    ('admin'),
    ('veterinario'),
    ('recepcionista'),
    ('apoderado');

-- USUARIOS DE PRUEBA (3 Registros, contrasenas cifradas con bcrypt)
--   admin      -> Admin123!
--   dra.torres -> Vet123!      (veterinario 1: Dra. Ana Torres)
--   jhidalgo   -> Cliente123!  (apoderado 1: Jander Hidalgo)
INSERT INTO a_veterinaria.usuario (username, email, password_hash, id_rol, id_apoderado, id_veterinario) VALUES
    ('admin',      'admin@veterinaria.pe',
        crypt('Admin123!',   gen_salt('bf')), 1, NULL, NULL),
    ('dra.torres', 'ana.torres@veterinaria.pe',
        crypt('Vet123!',     gen_salt('bf')), 2, NULL, 1),
    ('jhidalgo',   'jander.hidalgo@correo.com',
        crypt('Cliente123!', gen_salt('bf')), 4, 1,    NULL);

-- HISTORIAL DE LOGIN (3 Registros)
INSERT INTO a_veterinaria.registro_login (id_usuario, username_intentado, exito, ip_origen, dispositivo) VALUES
    (1, 'admin',    TRUE,  '127.0.0.1',    'Chrome / Windows'),
    (3, 'jhidalgo', FALSE, '190.10.20.30', 'Safari / iPhone'),
    (3, 'jhidalgo', TRUE,  '190.10.20.30', 'Safari / iPhone');

-- =====================================================================
-- VERIFICACION DE TOTALES
-- =====================================================================

SELECT COUNT(*) AS total_apoderados FROM a_veterinaria.apoderado;
SELECT COUNT(*) AS total_mascotas FROM a_veterinaria.mascota;
SELECT COUNT(*) AS total_veterinarios FROM a_veterinaria.veterinario;
SELECT COUNT(*) AS total_consultas FROM a_veterinaria.consulta;
SELECT COUNT(*) AS total_tratamientos FROM a_veterinaria.tratamiento;
SELECT COUNT(*) AS total_roles FROM a_veterinaria.rol;
SELECT COUNT(*) AS total_usuarios FROM a_veterinaria.usuario;
SELECT COUNT(*) AS total_registro_login FROM a_veterinaria.registro_login;

-- =====================================================================
-- ACTIVIDAD APLICADA SENATI (3 CONSULTAS CON JOIN)
-- =====================================================================

-- CONSULTA 01: Muestra los apoderados sin registros de consulta (Ej. Mateo Paredes)
SELECT
    a.id_apoderado,
    a.nombre AS apoderado,
    a.telefono
FROM a_veterinaria.apoderado a
LEFT JOIN a_veterinaria.consulta c
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
FROM a_veterinaria.tratamiento t
INNER JOIN a_veterinaria.consulta c
    ON t.id_consulta = c.id_consulta
INNER JOIN a_veterinaria.apoderado a
    ON c.id_apoderado = a.id_apoderado
INNER JOIN a_veterinaria.veterinario v
    ON c.id_veterinario = v.id_veterinario
ORDER BY t.fecha_ini DESC;

-- CONSULTA 03: Conteo de consultas atendidas por cada veterinario (Incluye Dr. Mario Vega con 0)
SELECT
    v.id_veterinario,
    v.nombre AS veterinario,
    v.especialidad,
    COUNT(c.id_consulta) AS total_consultas_atendidas
FROM a_veterinaria.veterinario v
LEFT JOIN a_veterinaria.consulta c
    ON v.id_veterinario = c.id_veterinario
GROUP BY
    v.id_veterinario,
    v.nombre,
    v.especialidad
ORDER BY total_consultas_atendidas DESC;

-- =====================================================================
-- MODULO DE AUTENTICACION · VERIFICACION
-- =====================================================================

-- Usuarios con su rol y a quien estan vinculados
SELECT u.id_usuario, u.username, u.email, r.nombre_rol,
       a.nombre AS apoderado, v.nombre AS veterinario
FROM a_veterinaria.usuario u
INNER JOIN a_veterinaria.rol r ON u.id_rol = r.id_rol
LEFT JOIN a_veterinaria.apoderado a   ON u.id_apoderado   = a.id_apoderado
LEFT JOIN a_veterinaria.veterinario v ON u.id_veterinario = v.id_veterinario
ORDER BY u.id_usuario;

-- Probar que el login funciona (debe devolver 1 fila)
SELECT id_usuario, username
FROM a_veterinaria.usuario
WHERE username = 'admin'
  AND password_hash = crypt('Admin123!', password_hash);

-- =====================================================================
-- CONSULTAS QUE USARA EL BACKEND
-- ($1, $2, $3 son parametros: nunca concatenar texto del usuario)
-- =====================================================================

-- REGISTRO (sign-up): crear un usuario nuevo
-- Recomendado: hashear en el backend con bcrypt y guardar solo el hash.
-- Alternativa desde SQL:
-- INSERT INTO a_veterinaria.usuario (username, email, password_hash, id_rol)
-- VALUES ($1, $2, crypt($3, gen_salt('bf')), 4)
-- RETURNING id_usuario, username, email;

-- LOGIN (opcion A, SQL valida la contrasena):
-- SELECT u.id_usuario, u.username, r.nombre_rol
-- FROM a_veterinaria.usuario u
-- INNER JOIN a_veterinaria.rol r ON u.id_rol = r.id_rol
-- WHERE u.username = $1
--   AND u.estado = TRUE
--   AND u.password_hash = crypt($2, u.password_hash);

-- LOGIN (opcion B, el backend compara con bcrypt.compare):
-- SELECT id_usuario, password_hash, id_rol, estado
-- FROM a_veterinaria.usuario
-- WHERE username = $1;

-- Despues de un login exitoso:
-- UPDATE a_veterinaria.usuario SET ultimo_login = NOW(), intentos_fallidos = 0
-- WHERE id_usuario = $1;
-- INSERT INTO a_veterinaria.registro_login (id_usuario, username_intentado, exito, ip_origen, dispositivo)
-- VALUES ($1, $2, TRUE, $3, $4);

-- Despues de un login fallido:
-- UPDATE a_veterinaria.usuario SET intentos_fallidos = intentos_fallidos + 1
-- WHERE username = $1;
-- INSERT INTO a_veterinaria.registro_login (id_usuario, username_intentado, exito, ip_origen, dispositivo)
-- VALUES ((SELECT id_usuario FROM a_veterinaria.usuario WHERE username = $1), $1, FALSE, $2, $3);

-- =====================================================================
-- PERMISOS POR ROL (QUIEN PUEDE VER QUE TABLA)
-- ---------------------------------------------------------------------
--   db_admin       -> TODAS las tablas (unico que ve rol, usuario
--                     y registro_login)
--   db_veterinario -> consulta, mascota, tratamiento
--   db_apoderado   -> veterinario, tratamiento, consulta, mascota
-- Solo lectura (SELECT) para veterinario y apoderado.
-- Los roles de PostgreSQL son globales del servidor, por eso se crean
-- con IF NOT EXISTS y el script se puede ejecutar mas de una vez.
-- =====================================================================

-- 1) Crear los roles (grupos sin login)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'db_admin') THEN
        CREATE ROLE db_admin NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'db_veterinario') THEN
        CREATE ROLE db_veterinario NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'db_apoderado') THEN
        CREATE ROLE db_apoderado NOLOGIN;
    END IF;
END
$$;

-- 2) Quitar cualquier permiso previo sobre el esquema
REVOKE ALL ON ALL TABLES    IN SCHEMA a_veterinaria FROM PUBLIC, db_admin, db_veterinario, db_apoderado;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA a_veterinaria FROM PUBLIC, db_admin, db_veterinario, db_apoderado;
REVOKE ALL ON SCHEMA a_veterinaria FROM PUBLIC;

-- 3) Permitir entrar al esquema (sin esto no ven ninguna tabla)
GRANT USAGE ON SCHEMA a_veterinaria TO db_admin, db_veterinario, db_apoderado;

-- 4) ADMIN: acceso total a todas las tablas
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA a_veterinaria TO db_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA a_veterinaria TO db_admin;

-- 5) VETERINARIO: solo consulta, mascota y tratamiento
GRANT SELECT ON a_veterinaria.consulta, a_veterinaria.mascota, a_veterinaria.tratamiento TO db_veterinario;

-- 6) APODERADO: veterinario, tratamiento, consulta y mascota
GRANT SELECT ON a_veterinaria.veterinario, a_veterinaria.tratamiento, a_veterinaria.consulta, a_veterinaria.mascota TO db_apoderado;

-- (Opcional) Los usuarios reales de conexion heredan los permisos del rol.
-- Descomente y cambie las contrasenas antes de usar:
-- CREATE ROLE usuario_admin LOGIN PASSWORD 'CAMBIAR_CLAVE' IN ROLE db_admin;
-- CREATE ROLE usuario_vet   LOGIN PASSWORD 'CAMBIAR_CLAVE' IN ROLE db_veterinario;
-- CREATE ROLE usuario_apod  LOGIN PASSWORD 'CAMBIAR_CLAVE' IN ROLE db_apoderado;

-- 7) Verificar los permisos otorgados
SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'a_veterinaria'
  AND grantee IN ('db_admin', 'db_veterinario', 'db_apoderado')
  AND (grantee <> 'db_admin' OR privilege_type = 'SELECT')
ORDER BY grantee, table_name;

-- 8) Pruebas manuales (ejecutar con el usuario propietario / superusuario)
-- SET ROLE db_veterinario;
-- SELECT * FROM a_veterinaria.mascota;    -- OK
-- SELECT * FROM a_veterinaria.usuario;    -- ERROR: permission denied
-- SELECT * FROM a_veterinaria.veterinario;-- ERROR: permission denied
-- RESET ROLE;
--
-- SET ROLE db_apoderado;
-- SELECT * FROM a_veterinaria.veterinario;-- OK
-- SELECT * FROM a_veterinaria.rol;        -- ERROR: permission denied
-- RESET ROLE;
--
-- SET ROLE db_admin;
-- SELECT * FROM a_veterinaria.usuario;    -- OK
-- RESET ROLE;
