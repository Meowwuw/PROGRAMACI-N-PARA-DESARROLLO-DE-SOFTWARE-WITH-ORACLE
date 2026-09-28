-- =========================================================
-- 1. REGISTROS DE APOYO (Requeridos para las claves foráneas)
-- =========================================================


CREATE TABLE duenos (
    id_dueno SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT
);

CREATE TABLE mascotas (
    id_mascota SERIAL PRIMARY KEY,
    id_dueno INT NOT NULL REFERENCES duenos(id_dueno),
    nombre VARCHAR(50) NOT NULL,
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
    id_mascota INT NOT NULL REFERENCES mascotas(id_mascota),
    id_veterinario INT NOT NULL REFERENCES veterinarios(id_veterinario),
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
    id_consulta INT NOT NULL REFERENCES consultas(id_consulta),
    id_servicio INT NOT NULL REFERENCES servicios(id_servicio),
    observaciones TEXT
);
-- Insertar Dueños
select * from duenos;

select current_schema();
INSERT INTO duenos (nombre, telefono, direccion) VALUES
('Carlos Mendoza', '912345678', 'Av. Primavera 123, Lima'),
('María Fernández', '923456789', 'Calle Los Olivos 456, Arequipa'),
('Jorge Ramírez', '934567890', 'Jr. Las Flores 789, Cusco'),
('Ana Gutiérrez', '945678901', 'Av. Sunampe 321, Ica'),
('Lucía Torres', '956789012', 'Calle Real 654, Huancayo'),
('Diego Salazar', '967890123', 'Av. Balta 987, Chiclayo'),
('Elena Benítez', '978901234', 'Calle Comercio 159, Piura'),
('Roberto Gómez', '989012345', 'Av. Grau 753, Trujillo');

-- Insertar Mascotas
INSERT INTO mascotas (id_dueno, nombre, raza, fecha_nacimiento) VALUES
(1, 'Firulais', 'Golden Retriever', '2020-03-15'),
(1, 'Michi', 'Siamés', '2021-06-20'),
(2, 'Max', 'Pastor Alemán', '2019-11-05'),
(2, 'Luna', 'Pug', '2022-01-10'),
(3, 'Rocky', 'Bulldog Francés', '2021-04-12'),
(4, 'Pelusa', 'Persa', '2020-08-30'),
(5, 'Thor', 'Rottweiler', '2018-05-18'),
(5, 'Nala', 'Mestizo', '2023-02-14'),
(6, 'Coco', 'Poodle', '2021-09-01'),
(7, 'Simba', 'Maine Coon', '2022-07-22'),
(8, 'Toby', 'Beagle', '2020-12-03'),
(8, 'Mia', 'Angora', '2022-03-28');

-- Insertar Veterinarios
INSERT INTO veterinarios (nombre, especialidad, telefono) VALUES
('Dra. Sofía Martínez', 'Medicina General', '911111111'),
('Dr. Alejandro Silva', 'Cirugía y Traumatología', '922222222'),
('Dra. Valentina Ríos', 'Dermatología', '933333333'),
('Dr. Gabriel Paredes', 'Odontología y Oftalmología', '944444444');

-- Insertar Servicios
INSERT INTO servicios (nombre_servicio, precio) VALUES
('Vacunación Quíntuple', 65.00),
('Desparasitación Interna/Externa', 35.00),
('Profilaxis Dental', 120.00),
('Cirugía de Esterilización', 250.00),
('Examen de Sangre Completo', 80.00),
('Ecografía Abdominal', 110.00),
('Corte de Uñas y Limpieza de Oídos', 25.00);

-- =========================================================
-- 2. TABLA CORAZÓN: 20 INSERTS PARA "CONSULTAS"
-- =========================================================

INSERT INTO consultas (id_mascota, id_veterinario, fecha_hora, diagnostico, costo_base) VALUES
(1, 1, '2026-08-01 09:30:00', 'Chequeo general anual. Paciente en excelente estado de salud.', 50.00),
(2, 3, '2026-08-02 10:15:00', 'Dermatitis alérgica por pulgas. Se receta champú medicado y pipeta.', 60.00),
(3, 2, '2026-08-03 11:00:00', 'Cojera en pata trasera derecha. Posible distensión muscular suave.', 70.00),
(4, 1, '2026-08-04 16:20:00', 'Cuadro de gastroenteritis leve por ingesta de alimento no habitual.', 55.00),
(5, 4, '2026-08-05 14:00:00', 'Acumulación severa de sarro e inflamación de encías (Gingivitis).', 65.00),
(6, 1, '2026-08-06 08:45:00', 'Infección respiratoria leve. Estornudos frecuentes sin fiebre.', 50.00),
(7, 2, '2026-08-07 17:30:00', 'Evaluación prequirúrgica para esterilización programada.', 80.00),
(8, 1, '2026-08-08 12:10:00', 'Control de peso y vacunación de refuerzo de cachorro.', 45.00),
(9, 3, '2026-08-09 15:40:00', 'Otitis externa en oído izquierdo. Se realiza limpieza y se indican gotas.', 60.00),
(10, 1, '2026-08-10 11:30:00', 'Decaimiento y falta de apetito. Se sugiere ecografía de control.', 55.00),
(11, 4, '2026-08-11 10:00:00', 'Conjuntivitis bacteriana en ojo derecho. Se recetan colirios.', 50.00),
(12, 1, '2026-08-12 18:00:00', 'Desparasitación de rutina y revisión general.', 40.00),
(1, 3, '2026-08-14 09:00:00', 'Revisión por presencia de garrapatas en zona del cuello.', 50.00),
(3, 2, '2026-08-15 13:15:00', 'Seguimiento de evolución de cojera. Presenta notable mejora.', 45.00),
(5, 2, '2026-08-17 10:30:00', 'Procedimiento de extracción dental menor.', 90.00),
(7, 2, '2026-08-18 08:00:00', 'Ingreso para cirugía de esterilización sin complicaciones.', 100.00),
(2, 1, '2026-08-20 16:50:00', 'Control de dermatitis. Piel recuperada favorablemente.', 40.00),
(8, 3, '2026-08-22 11:15:00', 'Reacción alérgica alimentaria. Se indica cambio de dieta a prescripción.', 60.00),
(10, 4, '2026-08-24 15:00:00', 'Limpieza y revisión de piezas dentales en felino adulto.', 65.00),
(4, 1, '2026-08-26 12:45:00', 'Evaluación por sobrepeso. Se diseña plan nutricional personalizado.', 50.00);

-- =========================================================
-- 3. OPCIONAL: DETALLES DE SERVICIOS PARA ALGUNAS CONSULTAS
-- =========================================================

INSERT INTO detalle_consulta_servicio (id_consulta, id_servicio, observaciones) VALUES
(1, 1, 'Se aplicó vacuna quíntuple anual'),
(1, 2, 'Desparasitación interna preventiva'),
(2, 2, 'Pipeta antipulgas aplicada en consultorio'),
(5, 3, 'Limpieza profiláctica bajo sedación leve'),
(7, 5, 'Perfil sanguíneo completo prequirúrgico'),
(10, 6, 'Ecografía abdominal de exploración'),
(16, 4, 'Cirugía realizada con éxito'),
(19, 3, 'Profilaxis dental felina');


-- =========================================================
-- 1. CONSULTAS PARA LA TABLA "duenos" (10 consultas)
-- =========================================================

-- 1.1. Obtener todos los dueños ordenados alfabéticamente por su nombre
SELECT * FROM duenos 
ORDER BY nombre ASC;

-- 1.2. Buscar un dueño específico utilizando su número de teléfono
SELECT * FROM duenos 
WHERE telefono = '912345678';

-- 1.3. Buscar dueños cuya dirección se encuentre en una avenida (usando LIKE)
SELECT * FROM duenos 
WHERE direccion LIKE 'Av.%';

-- 1.4. Buscar dueños cuyo nombre comience con la letra 'C'
SELECT * FROM duenos 
WHERE nombre LIKE 'C%';

-- 1.5. Listar dueños cuyo nombre contenga la palabra 'Gómez' o 'Gutiérrez'
SELECT * FROM duenos 
WHERE nombre LIKE '%Gómez%' OR nombre LIKE '%Gutiérrez%';

-- 1.6. Obtener los dueños cuyo ID esté dentro de un rango específico (de 2 a 5)
SELECT * FROM duenos 
WHERE id_dueno BETWEEN 2 AND 5;

-- 1.7. Buscar dueños que residan en Lima, Cusco o Piura (usando IN y LIKE)
SELECT * FROM duenos 
WHERE direccion LIKE '%Lima%' OR direccion LIKE '%Cusco%' OR direccion LIKE '%Piura%';

-- 1.8. Seleccionar los dueños con identificadores específicos (1, 3, 5, 7) usando IN
SELECT * FROM duenos 
WHERE id_dueno IN (1, 3, 5, 7);

-- 1.9. Contar el total de dueños registrados en la base de datos
SELECT COUNT(*) AS total_duenos 
FROM duenos;

-- 1.10. Listar los dueños junto con los nombres de sus mascotas (JOIN básico)
SELECT d.nombre AS nombre_dueno, m.nombre AS nombre_mascota
FROM duenos d
JOIN mascotas m ON d.id_dueno = m.id_dueno;


-- =========================================================
-- 2. CONSULTAS PARA LA TABLA "mascotas" (10 consultas)
-- =========================================================

-- 2.1. Listar todas las mascotas nacidas a partir del año 2021
SELECT * FROM mascotas 
WHERE fecha_nacimiento >= '2021-01-01';

-- 2.2. Obtener las mascotas que nacieron entre 2020 y 2022 (usando BETWEEN)
SELECT * FROM mascotas 
WHERE fecha_nacimiento BETWEEN '2020-01-01' AND '2022-12-31';

-- 2.3. Buscar mascotas que sean de raza 'Golden Retriever' o 'Pug'
SELECT * FROM mascotas 
WHERE raza IN ('Golden Retriever', 'Pug');

-- 2.4. Buscar mascotas cuyo nombre termine con la letra 'a'
SELECT * FROM mascotas 
WHERE nombre LIKE '%a';

-- 2.5. Obtener mascotas cuyo nombre tenga exactamente 4 letras
SELECT * FROM mascotas 
WHERE nombre LIKE '____';

-- 2.6. Buscar mascotas que no pertenezcan a las razas 'Mestizo' ni 'Persa'
SELECT * FROM mascotas 
WHERE raza NOT IN ('Mestizo', 'Persa');

-- 2.7. Contar cuántas mascotas pertenecen a cada raza
SELECT raza, COUNT(*) AS cantidad 
FROM mascotas 
GROUP BY raza;

-- 2.8. Obtener la mascota más joven (fecha de nacimiento más reciente)
SELECT * FROM mascotas 
ORDER BY fecha_nacimiento DESC 
LIMIT 1;

-- 2.9. Mostrar las mascotas junto con los datos de contacto de su dueño (JOIN)
SELECT m.nombre AS mascota, m.raza, d.nombre AS dueno, d.telefono
FROM mascotas m
JOIN duenos d ON m.id_dueno = d.id_dueno;

-- 2.10. Mostrar las mascotas de un dueño en particular por su nombre (JOIN + WHERE)
SELECT m.* 
FROM mascotas m
JOIN duenos d ON m.id_dueno = d.id_dueno
WHERE d.nombre = 'Carlos Mendoza';


-- =========================================================
-- 3. CONSULTAS PARA LA TABLA "veterinarios" (10 consultas)
-- =========================================================

-- 3.1. Obtener todos los veterinarios y sus especialidades
SELECT nombre, especialidad 
FROM veterinarios;

-- 3.2. Buscar veterinarios con especialidad en 'Dermatología'
SELECT * FROM veterinarios 
WHERE especialidad = 'Dermatología';

-- 3.3. Buscar veterinarios cuya especialidad incluya la palabra 'Cirugía'
SELECT * FROM veterinarios 
WHERE especialidad LIKE '%Cirugía%';

-- 3.4. Buscar veterinarias cuyo nombre empiece por la abreviatura 'Dra.'
SELECT * FROM veterinarios 
WHERE nombre LIKE 'Dra.%';

-- 3.5. Listar veterinarios cuyas especialidades sean 'Medicina General' o 'Dermatología'
SELECT * FROM veterinarios 
WHERE especialidad IN ('Medicina General', 'Dermatología');

-- 3.6. Obtener los veterinarios cuyos IDs no sean el 1 ni el 2
SELECT * FROM veterinarios 
WHERE id_veterinario NOT IN (1, 2);

-- 3.7. Seleccionar veterinarios con número de teléfono registrado
SELECT * FROM veterinarios 
WHERE telefono IS NOT NULL;

-- 3.8. Listar los veterinarios ordenados por especialidad
SELECT * FROM veterinarios 
ORDER BY especialidad ASC;

-- 3.9. Contar cuántas consultas ha realizado cada veterinario (JOIN)
SELECT v.nombre, COUNT(c.id_consulta) AS total_consultas
FROM veterinarios v
LEFT JOIN consultas c ON v.id_veterinario = c.id_veterinario
GROUP BY v.id_veterinario, v.nombre;

-- 3.10. Mostrar qué veterinarios han atendido a la mascota 'Firulais' (JOIN)
SELECT DISTINCT v.nombre AS veterinario, v.especialidad
FROM veterinarios v
JOIN consultas c ON v.id_veterinario = c.id_veterinario
JOIN mascotas m ON c.id_mascota = m.id_mascota
WHERE m.nombre = 'Firulais';


-- =========================================================
-- 4. CONSULTAS PARA LA TABLA "servicios" (10 consultas)
-- =========================================================

-- 4.1. Listar los servicios con un precio menor o igual a 50.00
SELECT * FROM servicios 
WHERE precio <= 50.00;

-- 4.2. Obtener servicios cuyo precio esté en el rango de 50.00 a 100.00
SELECT * FROM servicios 
WHERE precio BETWEEN 50.00 AND 100.00;

-- 4.3. Buscar servicios cuyos nombres contengan la palabra 'Dental' o 'Oídos'
SELECT * FROM servicios 
WHERE nombre_servicio LIKE '%Dental%' OR nombre_servicio LIKE '%Oídos%';

-- 4.4. Listar los servicios cuyo precio no sea exactamente 35.00
SELECT * FROM servicios 
WHERE precio <> 35.00;

-- 4.5. Buscar servicios específicos por su nombre usando IN
SELECT * FROM servicios 
WHERE nombre_servicio IN ('Vacunación Quíntuple', 'Ecografía Abdominal');

-- 4.6. Obtener el servicio más costoso de la clínica
SELECT * FROM servicios 
ORDER BY precio DESC 
LIMIT 1;

-- 4.7. Calcular el precio promedio de los servicios ofrecidos
SELECT AVG(precio) AS precio_promedio 
FROM servicios;

-- 4.8. Obtener la lista de servicios ordenados del más barato al más caro
SELECT * FROM servicios 
ORDER BY precio ASC;

-- 4.9. Contar cuántas veces se ha solicitado cada servicio en las consultas (JOIN)
SELECT s.nombre_servicio, COUNT(dcs.id_detalle) AS cantidad_usada
FROM servicios s
LEFT JOIN detalle_consulta_servicio dcs ON s.id_servicio = dcs.id_servicio
GROUP BY s.id_servicio, s.nombre_servicio;

-- 4.10. Obtener el monto total generado por un servicio específico (JOIN + SUM)
SELECT s.nombre_servicio, SUM(s.precio) AS total_recaudado
FROM servicios s
JOIN detalle_consulta_servicio dcs ON s.id_servicio = dcs.id_servicio
WHERE s.nombre_servicio = 'Profilaxis Dental'
GROUP BY s.nombre_servicio;


-- =========================================================
-- 5. CONSULTAS PARA LA TABLA CORAZÓN "consultas" (10 consultas)
-- =========================================================

-- 5.1. Listar las consultas con un costo base superior a 60.00
SELECT * FROM consultas 
WHERE costo_base > 60.00;

-- 5.2. Buscar consultas realizadas en un rango de fechas determinado
SELECT * FROM consultas 
WHERE fecha_hora BETWEEN '2026-08-01 00:00:00' AND '2026-08-10 23:59:59';

-- 5.3. Buscar consultas donde el diagnóstico mencione la palabra 'alérgica' o 'alergia'
SELECT * FROM consultas 
WHERE diagnostico LIKE '%alérgica%' OR diagnostico LIKE '%alergia%';

-- 5.4. Listar consultas con costo base entre 40.00 y 60.00
SELECT * FROM consultas 
WHERE costo_base BETWEEN 40.00 AND 60.00;

-- 5.5. Obtener consultas atendidias por los veterinarios con ID 1 o 3 (usando IN)
SELECT * FROM consultas 
WHERE id_veterinario IN (1, 3);

-- 5.6. Calcular el ingreso total por concepto de costo base de todas las consultas
SELECT SUM(costo_base) AS total_costo_base 
FROM consultas;

-- 5.7. Consultar las últimas 5 atenciones registradas
SELECT * FROM consultas 
ORDER BY fecha_hora DESC 
LIMIT 5;

-- 5.8. Mostrar la fecha, el nombre de la mascota y el diagnóstico de cada consulta (JOIN)
SELECT c.fecha_hora, m.nombre AS mascota, c.diagnostico
FROM consultas c
JOIN mascotas m ON c.id_mascota = m.id_mascota;

-- 5.9. Mostrar las consultas detallando el nombre del cliente, mascota y veterinario (JOIN múltiple)
SELECT c.id_consulta, c.fecha_hora, d.nombre AS dueno, m.nombre AS mascota, v.nombre AS veterinario
FROM consultas c
JOIN mascotas m ON c.id_mascota = m.id_mascota
JOIN duenos d ON m.id_dueno = d.id_dueno
JOIN veterinarios v ON c.id_veterinario = v.id_veterinario;

-- 5.10. Mostrar las consultas que incluyeron la aplicación de algún servicio adicional (JOIN)
SELECT c.id_consulta, m.nombre AS mascota, s.nombre_servicio, dcs.observaciones
FROM consultas c
JOIN mascotas m ON c.id_mascota = m.id_mascota
JOIN detalle_consulta_servicio dcs ON c.id_consulta = dcs.id_consulta
JOIN servicios s ON dcs.id_servicio = s.id_servicio;
