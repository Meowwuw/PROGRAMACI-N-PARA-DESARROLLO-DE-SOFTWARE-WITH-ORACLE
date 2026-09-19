-- =====================================================================
-- CLASE 06 · FUNCIONES DE TEXTO Y JERARQUÍAS
-- Taller práctico · PostgreSQL + DBeaver
-- ---------------------------------------------------------------------
-- PARTE 1: continúa trabajando sobre TecnoMichiStore.
-- Antes de empezar, debes tener ejecutado 05a-base-michistore.sql.
--
-- PARTE 2: crearás una jerarquía nueva PERSONA → CLIENTE / EMPLEADO.
-- No borres el Reto 01 cuando empieces el Reto 02.
-- =====================================================================

SET search_path TO michistore;

SELECT current_schema();


-- =====================================================================
-- MAPA RÁPIDO · FUNCIONES DE TEXTO
-- ---------------------------------------------------------------------
-- LOWER(texto)                  convierte a minúsculas
-- UPPER(texto)                  convierte a mayúsculas
-- INITCAP(texto)                primera letra de cada palabra en mayúscula
-- TRIM(texto)                   quita espacios al inicio y al final
-- LENGTH(texto)                 cuenta caracteres
-- texto1 || texto2              concatena textos
-- SUBSTRING(texto FROM x FOR n) extrae una parte del texto
-- POSITION(texto IN cadena)     busca la posición de un texto
-- REPLACE(texto, viejo, nuevo)  reemplaza una parte del texto
-- =====================================================================


-- =====================================================================
-- GRUPO A · NORMALIZAR Y PRESENTAR TEXTO          (ejercicios 1 al 6)
-- =====================================================================

-- A1. Muestra nombre y apellido de todos los clientes en MAYÚSCULAS.
--     Usa dos columnas calculadas: nombre_mayuscula y apellido_mayuscula.
select * from cliente;
select upper (nombre) as nombre_mayusculas,
		upper (apellido) as nombre_mayusculas
from cliente;

-- A2. Muestra el correo original y el mismo correo en minúsculas.
--     Trabaja solo con clientes que sí tienen correo.
select correo,
		lower(correo) as correo_minuscula
from cliente
where correo is not null;

-- A3. Muestra nombre y apellido como una sola columna llamada
--     cliente_formateado. Debe verse como nombre propio.
--     Pista: combina INITCAP con ||.
select nombre, apellido
		initcap(nombre || '' ||apellido) as nombre_conectado
from cliente;

-- A4. Ejecuta primero esta consulta y observa los espacios:
--
SELECT '   PostgreSQL en DBeaver   ' AS texto;
select trim (' PostgreSQL en DBeaver  ') as texto_limpio;

-- A5. Muestra el nombre de cada producto y cuántos caracteres tiene.
--     Llama a la segunda columna longitud_nombre.
--     Ordena del nombre más largo al más corto.
select * from producto;
select nombre,
	length(nombre) as total_caracteres
	from producto;

-- A6. Construye una columna llamada ficha_producto con este formato:
--
--     Laptop Ryzen 5 | Computo
--
--     Usa nombre, categoria y el operador ||.
--     Trabaja solo con productos que sí tienen categoría.

SELECT 
    nombre || ' | ' || categoria AS ficha_producto
FROM 
    producto
WHERE 
    categoria IS NOT NULL;

-- =====================================================================
-- GRUPO B · EXTRAER, BUSCAR Y REEMPLAZAR            (ejercicios 7 al 12)
-- =====================================================================

-- B7. Muestra los primeros 6 caracteres del nombre de cada producto.
--     Columnas: nombre, inicio_nombre.
--     Usa SUBSTRING.
SELECT 
    nombre, 
    SUBSTRING(nombre FROM 1 FOR 6) AS inicio_nombre
FROM 
    producto;

-- B8. De cada correo registrado, muestra:
--     nombre del cliente, correo y la posición donde aparece @.
--     Llama a la columna posicion_arroba.
SELECT 
    nombre, 
    correo, 
    POSITION('@' IN correo) AS posicion_arroba
FROM 
    cliente;

-- B9. Reemplaza la palabra "Michi" por "MichiStore" en los nombres
--     de productos que contienen "Michi".
--     Muestra nombre original y nombre_modificado.
--     Ojo: solo estamos modificando el RESULTADO, no la tabla.
SELECT 
    nombre, 
    REPLACE(nombre, 'Michi', 'MichiStore') AS nombre_modificado
FROM 
    producto
WHERE 
    nombre LIKE '%Michi%';

-- B10. Muestra nombre, correo y solamente el dominio del correo.
--      Ejemplo conceptual: usuario@dominio.com → dominio.com
--      Pista: POSITION te ayuda a encontrar @ y SUBSTRING a cortar.
SELECT 
    nombre, 
    correo, 
    SUBSTRING(correo FROM POSITION('@' IN correo) + 1) AS dominio
FROM 

    cliente;

-- B11. Muestra los productos de la categoría Accesorios con este formato:
--
--      PRODUCTO: Mouse Michi inalambrico
--
--      Llama a la columna etiqueta.
--      Usa concatenación; no escribas el nombre del producto manualmente.
SELECT 
    'PRODUCTO: ' || nombre AS etiqueta
FROM 
    producto
WHERE 
    categoria = 'Accesorios';

-- B12. Busca clientes cuyo correo sea Gmail sin depender de cómo estén
--      escritas las mayúsculas/minúsculas del correo.
--      Esta vez NO uses ILIKE.
--      Pista: normaliza primero el correo con una función de texto.

SELECT *
FROM cliente
WHERE LOWER(correo) LIKE '%gmail.com';


-- =====================================================================
-- GRUPO C · COMBINAR FUNCIONES DE TEXTO              (ejercicios 13 al 16)
-- =====================================================================

-- C13. Genera una columna codigo_cliente con este formato:
--
--      ANA-Q
--
--      Debe usar las primeras 3 letras del nombre + '-' + la primera
--      letra del apellido, todo en mayúsculas.
--      No escribas ningún código manualmente.


-- C14. Muestra los productos cuyo nombre tenga MÁS de 18 caracteres.
--      Columnas: nombre y cantidad_caracteres.


-- C15. Muestra el nombre completo del cliente y su ciudad en una sola
--      columna con este formato:
--
--      Ana Quispe - Huanuco
--
--      El nombre completo debe quedar con formato de nombre propio.


-- C16. Escribe una consulta que permita detectar correos que podrían
--      tener espacios al inicio o al final.
--      Muestra correo_original y correo_limpio.
--
--      Después responde:
--      ¿TRIM modifica el dato guardado en la tabla?
--      RESPUESTA:


-- =====================================================================
-- RETO 01 · LIMPIEZA DE DATOS
-- ---------------------------------------------------------------------
-- Resuelve todo con UNA consulta SELECT.
-- No actualices ni borres datos.
-- =====================================================================

-- R1. Genera un pequeño reporte de clientes con estas columnas:
--
--     id_cliente
--     nombre_completo   → nombre + apellido con formato uniforme
--     correo_limpio     → correo en minúsculas y sin espacios extremos
--     codigo            → primeras 2 letras del nombre + id_cliente
--                         todo en mayúsculas
--
--     Trabaja solo con clientes que tengan correo.
--
--     Pista: aquí tendrás que combinar varias funciones vistas hoy.


-- =====================================================================
-- RETO 02 · IMPLEMENTA UNA JERARQUÍA
-- ---------------------------------------------------------------------
-- Ahora dejamos TecnoMichiStore por un momento.
-- Vamos a implementar este modelo:
--
--                         PERSONA
--                nombre · apellido · correo
--                         /      \
--                        /        \
--                  CLIENTE      EMPLEADO
--                ciudad/puntos  cargo/sueldo
--
-- IDEA CLAVE:
-- Los datos comunes viven en PERSONA.
-- CLIENTE y EMPLEADO guardan solamente sus datos propios.
-- El id_persona del subtipo será PK y también FK hacia PERSONA.
-- =====================================================================


-- ---------------------------------------------------------------------
-- PASO 1 · CREA LAS TRES TABLAS
-- ---------------------------------------------------------------------
-- Crea:
--
-- persona
--   id_persona    SERIAL PRIMARY KEY
--   nombre        VARCHAR(50) NOT NULL
--   apellido      VARCHAR(50) NOT NULL
--   correo        VARCHAR(80)
--   telefono      VARCHAR(15)
--
-- cliente_subtipo
--   id_persona    INT PRIMARY KEY + FK hacia persona(id_persona)
--   ciudad        VARCHAR(40) NOT NULL
--   puntos        INT NOT NULL DEFAULT 0
--
-- empleado
--   id_persona    INT PRIMARY KEY + FK hacia persona(id_persona)
--   cargo         VARCHAR(50) NOT NULL
--   sueldo        NUMERIC(10,2) NOT NULL
--   fecha_ingreso DATE NOT NULL
--
-- Escribe tus CREATE TABLE debajo.

CREATE TABLE persona (
    id_persona    SERIAL PRIMARY KEY,
    nombre        VARCHAR(50) NOT NULL,
    apellido      VARCHAR(50) NOT NULL,
    correo        VARCHAR(80),
    telefono      VARCHAR(15)
);

CREATE TABLE cliente_subtipo (
    id_persona    INT PRIMARY KEY,
    ciudad        VARCHAR(40) NOT NULL,
    puntos        INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_cliente_persona 
        FOREIGN KEY (id_persona) 
        REFERENCES persona(id_persona) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE empleado (
    id_persona    INT PRIMARY KEY,
    cargo         VARCHAR(50) NOT NULL,
    sueldo        NUMERIC(10,2) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    CONSTRAINT fk_empleado_persona 
        FOREIGN KEY (id_persona) 
        REFERENCES persona(id_persona) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


-- ---------------------------------------------------------------------
-- PASO 2 · INSERTA 5 PERSONAS
-- ---------------------------------------------------------------------
-- Inserta 5 personas SOLO en la tabla persona.
-- Usa datos inventados por ti.
INSERT INTO persona (nombre, apellido, correo, telefono) VALUES
	('Juan', 'Pérez', 'juan.perez@email.com', '912345678'),
	('María', 'Gómez', 'maria.gomez@email.com', '923456789'),
	('Carlos', 'Ruiz', 'carlos.ruiz@email.com', '934567890'),
	('Ana', 'Torres', 'ana.torres@email.com', '945678901'),
	('Luis', 'Ramírez', 'luis.ramirez@email.com', '956789012');
-- Después consulta la tabla para identificar los id_persona que
-- PostgreSQL generó automáticamente.
--
-- IMPORTANTE: todavía NO insertes clientes ni empleados.


-- Consulta aquí los IDs generados:
select * from persona;

-- ---------------------------------------------------------------------
-- PASO 3 · ASIGNA LOS SUBTIPOS
-- ---------------------------------------------------------------------
-- De tus 5 personas:
--   · convierte 3 en CLIENTES
--   · convierte 2 en EMPLEADOS
--
-- Para hacerlo NO vuelvas a escribir nombre, apellido o correo.
-- Inserta en cada subtipo el id_persona que ya existe en PERSONA y
-- solamente los atributos propios del subtipo.
INSERT INTO cliente_subtipo (id_persona, ciudad, puntos) VALUES
(1, 'Madrid', 150),
(2, 'Barcelona', 300),
(3, 'Valencia', 50);

INSERT INTO empleado (id_persona, cargo, sueldo, fecha_ingreso) VALUES
(4, 'Gerente de Ventas', 2500.00, '2023-01-15'),
(5, 'Desarrollador Backend', 3200.50, '2024-06-01');

-- CHECKPOINT
-- Ejecuta estas tres consultas. Debes obtener:
--   persona          → 5 filas
--   cliente_subtipo  → 3 filas
--   empleado         → 2 filas

SELECT COUNT(*) AS personas FROM persona;
SELECT COUNT(*) AS clientes FROM cliente_subtipo;
SELECT COUNT(*) AS empleados FROM empleado;


-- ---------------------------------------------------------------------
-- PASO 4 · PRUEBA UNA ESPECIALIZACIÓN SOLAPADA
-- ---------------------------------------------------------------------
-- Elige UNA de las 5 personas y haz que pertenezca también al otro
-- subtipo.
--
-- Ejemplo de la idea, NO de los datos:
-- si una persona ya es CLIENTE, también puedes insertar su mismo
-- id_persona en EMPLEADO.
--
-- Al terminar tendrás una persona que es CLIENTE Y EMPLEADO.

INSERT INTO empleado (id_persona, cargo, sueldo, fecha_ingreso) VALUES
(1, 'Soporte Técnico', 1800.00, '2025-03-01');

select * from empleado;
select * from cliente_subtipo;
-- ---------------------------------------------------------------------
-- PASO 5 · CONSULTA LA JERARQUÍA
-- ---------------------------------------------------------------------
-- J1. Muestra los clientes con sus datos completos.
--     Debes unir PERSONA + CLIENTE_SUBTIPO usando id_persona.
--     Muestra: id_persona, nombre completo, ciudad y puntos.
SELECT 
    p.id_persona, 
    p.nombre || ' ' || p.apellido AS nombre_completo, 
    p.correo, 
    p.telefono, 
    c.ciudad, 
    c.puntos
FROM persona p
JOIN cliente_subtipo c ON p.id_persona = c.id_persona;

-- J2. Muestra los empleados con sus datos completos.
--     Debes unir PERSONA + EMPLEADO usando id_persona.
--     Muestra: id_persona, nombre completo, cargo y sueldo.
SELECT 
    p.id_persona, 
    p.nombre || ' ' || p.apellido AS nombre_completo, 
    p.correo, 
    p.telefono, 
    e.cargo, 
    e.sueldo, 
    e.fecha_ingreso
FROM persona p
JOIN empleado e ON p.id_persona = e.id_persona;

-- J3. La persona que hiciste CLIENTE Y EMPLEADO en el paso 4 debe
--     aparecer en las dos consultas anteriores.
--
--     Escribe aquí su id_persona:
--     ID:01


-- ---------------------------------------------------------------------
-- PASO 6 · EXPLICA LO QUE OCURRIÓ
-- ---------------------------------------------------------------------
-- Responde con tus palabras:
--
-- ¿Por qué una misma persona pudo aparecer como CLIENTE y EMPLEADO
-- sin repetir su nombre, apellido, correo y teléfono?
--
-- RESPUESTA:
-- Pudo aparecer como cliente y empleado al mismo tiempo porque los datos generales (nombre, apellido, correo y teléfono)
-- están centralizados en la tabla principal "persona". Las tablas "cliente_subtipo" y "empleado" 
-- solo almacenan las características específicas de su rol usando el mismo "id_persona" como llave foránea,
-- lo que permite vincular una misma persona a ambos roles sin duplicar información personal.

-- ¿La jerarquía que acabamos de construir es EXCLUSIVA o SOLAPADA?
-- ¿Cómo lo comprobaste?
--
-- RESPUESTA:
-- Es una jerarquía SOLAPADA. Lo comprobamos en el paso 4 al insertar el mismo "id_persona"
-- en ambas tablas de subtipos (cliente y empleado) y verificar mediante las consultas del paso 5 que una sola persona aparece registrada
-- y activa en los dos roles simultáneamente.

-- =====================================================================
-- ANTES DE SUBIR
-- ---------------------------------------------------------------------
-- [x] A1-A6 resueltos
-- [x] B7-B12 resueltos
-- [x] C13-C16 resueltos
-- [x] Reto 01 resuelto
-- [x] Reto 02 completo: tablas, datos, subtipos y consultas
-- [x] Respuestas escritas de C16 y Reto 02
-- [x] El archivo ejecuta de arriba a abajo sin errores
--
-- ENTREGA INDIVIDUAL:
--   alumnos/apellidos/06-funciones-de-texto.sql
--
-- =====================================================================
