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
SELECT UPPER(nombre) AS nombre_mayuscula, 
       UPPER(apellido) AS apellido_mayuscula
FROM clientes;

-- A2. Muestra el correo original y el mismo correo en minúsculas.
--     Trabaja solo con clientes que sí tienen correo.
SELECT correo, 
       LOWER(correo) AS correo_minuscula
FROM clientes
WHERE correo IS NOT NULL;

-- A3. Muestra nombre y apellido como una sola columna llamada
--     cliente_formateado. Debe verse como nombre propio.
--     Pista: combina INITCAP con ||.
SELECT INITCAP(nombre) || ' ' || INITCAP(apellido) AS cliente_formateado
FROM clientes;

-- A4. Ejecuta primero esta consulta y observa los espacios:
--
--     SELECT '   PostgreSQL en DBeaver   ' AS texto;
--
--     Luego escribe otra consulta que elimine los espacios del inicio
--     y del final. Llama a la columna texto_limpio.
-- Consulta de prueba inicial:
SELECT '  PostgreSQL en DBeaver  ' AS texto;

-- Consulta con la limpia de espacios:
SELECT TRIM('  PostgreSQL en DBeaver  ') AS texto_limpio;

-- A5. Muestra el nombre de cada producto y cuántos caracteres tiene.
--     Llama a la segunda columna longitud_nombre.
--     Ordena del nombre más largo al más corto.
SELECT nombre, 
       LENGTH(nombre) AS longitud_nombre
FROM productos
ORDER BY longitud_nombre DESC;

-- A6. Construye una columna llamada ficha_producto con este formato:
--
--     Laptop Ryzen 5 | Computo
--
--     Usa nombre, categoria y el operador ||.
--     Trabaja solo con productos que sí tienen categoría.
SELECT nombre || ' | ' || categoria AS ficha_producto
FROM productos
WHERE categoria IS NOT NULL;

-- =====================================================================
-- GRUPO B · EXTRAER, BUSCAR Y REEMPLAZAR            (ejercicios 7 al 12)
-- =====================================================================

-- B7. Muestra los primeros 6 caracteres del nombre de cada producto.
--     Columnas: nombre, inicio_nombre.
--     Usa SUBSTRING.
SELECT nombre, 
       SUBSTRING(nombre FROM 1 FOR 6) AS inicio_nombre
FROM productos;

-- B8. De cada correo registrado, muestra:
--     nombre del cliente, correo y la posición donde aparece @.
--     Llama a la columna posicion_arroba.
SELECT nombre, 
       correo, 
       POSITION('@' IN correo) AS posicion_arroba
FROM clientes
WHERE correo IS NOT NULL;

-- B9. Reemplaza la palabra "Michi" por "MichiStore" en los nombres
--     de productos que contienen "Michi".
--     Muestra nombre original y nombre_modificado.
--     Ojo: solo estamos modificando el RESULTADO, no la tabla.
SELECT nombre AS nombre_original, 
       REPLACE(nombre, 'Michi', 'MichiStore') AS nombre_modificado
FROM productos
WHERE nombre ILIKE '%Michi%';

-- B10. Muestra nombre, correo y solamente el dominio del correo.
--      Ejemplo conceptual: usuario@dominio.com → dominio.com
--      Pista: POSITION te ayuda a encontrar @ y SUBSTRING a cortar.
SELECT nombre, 
       correo, 
       SUBSTRING(correo FROM POSITION('@' IN correo) + 1) AS dominio
FROM clientes
WHERE correo IS NOT NULL;

-- B11. Muestra los productos de la categoría Accesorios con este formato:
--
--      PRODUCTO: Mouse Michi inalambrico
--
--      Llama a la columna etiqueta.
--      Usa concatenación; no escribas el nombre del producto manualmente.
SELECT 'PRODUCTO: ' || nombre AS etiqueta
FROM productos
WHERE categoria ILIKE 'Accesorios';

-- B12. Busca clientes cuyo correo sea Gmail sin depender de cómo estén
--      escritas las mayúsculas/minúsculas del correo.
--      Esta vez NO uses ILIKE.
--      Pista: normaliza primero el correo con una función de texto.
SELECT *
FROM clientes
WHERE LOWER(correo) LIKE '%@gmail.com';

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
SELECT UPPER(SUBSTRING(nombre FROM 1 FOR 3)) || '-' || UPPER(SUBSTRING(apellido FROM 1 FOR 1)) AS codigo_cliente
FROM clientes;

-- C14. Muestra los productos cuyo nombre tenga MÁS de 18 caracteres.
--      Columnas: nombre y cantidad_caracteres.
SELECT INITCAP(TRIM(nombre)) || ' ' || INITCAP(TRIM(apellido)) AS cliente_limpio
FROM clientes;

-- C15. Muestra el nombre completo del cliente y su ciudad en una sola
--      columna con este formato:
--
--      Ana Quispe - Huanuco
--
--      El nombre completo debe quedar con formato de nombre propio.
SELECT correo,
       SUBSTRING(correo FROM 1 FOR POSITION('@' IN correo) - 1) AS usuario_correo
FROM clientes
WHERE correo IS NOT NULL;

-- C16. Escribe una consulta que permita detectar correos que podrían
--      tener espacios al inicio o al final.
--      Muestra correo_original y correo_limpio.
--
--      Después responde:
--      ¿TRIM modifica el dato guardado en la tabla?
--      RESPUESTA:
SELECT UPPER(SUBSTRING(categoria FROM 1 FOR 3)) || '-' || UPPER(nombre) || ' (S/ ' || precio || ')' AS etiqueta_producto
FROM productos
WHERE categoria IS NOT NULL;

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
SELECT 
    id_cliente,
    INITCAP(TRIM(nombre)) || ' ' || INITCAP(TRIM(apellido)) AS nombre_completo,
    LOWER(TRIM(correo)) AS correo_limpio,
    UPPER(SUBSTRING(TRIM(nombre) FROM 1 FOR 2)) || id_cliente AS codigo
FROM clientes
WHERE correo IS NOT NULL;

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
CREATE TABLE persona (
    id_persona SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(80),
    telefono VARCHAR(15)
);

-- ---------------------------------------------------------------------
-- PASO 1 · CREA LAS TRES TABLAS
-- ---------------------------------------------------------------------
-- Crea:
--
create table persona (
  id_persona    SERIAL PRIMARY KEY
   nombre        VARCHAR(50) NOT NULL
   apellido      VARCHAR(50) NOT NULL
   correo        VARCHAR(80)
   telefono      VARCHAR(15)
   
   foreign key (id_persona) references persona(id_persona)
);
 create table cliente_subtipo (
   id_persona    INT PRIMARY KEY + FK hacia persona(id_persona)
   ciudad        VARCHAR(40) NOT NULL
   puntos        INT NOT NULL DEFAULT 
   
   foreign key(id_persona) references persona(id_persona)
);
create table empleado (
   id_persona    INT PRIMARY KEY + FK hacia persona(id_persona)
   cargo         VARCHAR(50) NOT NULL
   sueldo        NUMERIC(10,2) NOT NULL
   fecha_ingreso DATE NOT NULL

   foreign key (id_persona) references persona(id_persona)
);
-- Escribe tus CREATE TABLE debajo.


-- ---------------------------------------------------------------------
-- PASO 2 · INSERTA 5 PERSONAS
-- ---------------------------------------------------------------------
-- Inserta 5 personas SOLO en la tabla persona.
-- Usa datos inventados por ti.
--
-- Después consulta la tabla para identificar los id_persona que
-- PostgreSQL generó automáticamente.
--
-- IMPORTANTE: todavía NO insertes clientes ni empleados.


-- Consulta aquí los IDs generados:
INSERT INTO persona (nombre, apellido, correo, telefono) VALUES
('Carlos', 'Mendoza', 'carlos.mendoza@email.com', '987654321'),
('Ana', 'Torres', 'ana.torres@email.com', '912345678'),
('Luis', 'Ramirez', 'luis.ramirez@email.com', '955443322'),
('Maria', 'Flores', 'maria.flores@email.com', '966778899'),
('Jorge', 'Castro', 'jorge.castro@email.com', '944332211');


SELECT * FROM persona;

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
-- Convertir 3 en CLIENTES (IDs 1, 2 y 3)
INSERT INTO cliente_subtipo (id_persona, ciudad, puntos) VALUES
(1, 'Lima', 150),
(2, 'Pucallpa', 200),
(3, 'Huánuco', 50);

-- Convertir 2 en EMPLEADOS (IDs 4 y 5)
INSERT INTO empleado (id_persona, cargo, sueldo) VALUES
(4, 'Vendedor', 1500.00),
(5, 'Administrador', 2800.00);

-- CHECKPOINT
-- Ejecuta estas tres consultas. Debes obtener:
--   persona          → 5 filas
--   cliente_subtipo  → 3 filas
--   empleado         → 2 filas
SELECT COUNT(*) AS personas FROM persona;
SELECT COUNT(*) AS clientes FROM cliente_subtipo;
SELECT COUNT(*) AS empleados FROM empleado;

-- Convertir a la persona con id_persona = 1 (que ya es CLIENTE) también en EMPLEADO
INSERT INTO empleado (id_persona, cargo, sueldo) VALUES
(1, 'Supervisora', 3200.00);
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

INSERT INTO empleado (id_persona, cargo, sueldo) 
VALUES (1, 'Gerente', 3500.00);

-- ---------------------------------------------------------------------
-- PASO 5 · CONSULTA LA JERARQUÍA
-- ---------------------------------------------------------------------
-- J1. Muestra los clientes con sus datos completos.
--     Debes unir PERSONA + CLIENTE_SUBTIPO usando id_persona.
--     Muestra: id_persona, nombre completo, ciudad y puntos.
SELECT 
    p.id_persona, 
    p.nombre || ' ' || p.apellido AS nombre_completo, 
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
    e.cargo, 
    e.sueldo
FROM persona p
JOIN empleado e ON p.id_persona = e.id_persona;

-- J3. La persona que hiciste CLIENTE Y EMPLEADO en el paso 4 debe
--     aparecer en las dos consultas anteriores.
--
--     Escribe aquí su id_persona:
--     ID:
 O el número de ID correspondiente a la persona a la que le asignaste ambos subtipos en el paso 4

-- ---------------------------------------------------------------------
-- PASO 6 · EXPLICA LO QUE OCURRIÓ
-- ---------------------------------------------------------------------
-- Responde con tus palabras:
--
-- ¿Por qué una misma persona pudo aparecer como CLIENTE y EMPLEADO
-- sin repetir su nombre, apellido, correo y teléfono?
--
-- RESPUESTA:
Se debe a que la información personal común está centralizada en la tabla padre persona. Las tablas subtipo (cliente_subtipo y empleado) solo almacenan los datos específicos de su rol y referencian a persona mediante su id_persona. Esto evita la redundancia de datos y permite asociar múltiples roles a un mismo registro base.

-- ¿La jerarquía que acabamos de construir es EXCLUSIVA o SOLAPADA?
-- ¿Cómo lo comprobaste?
--
-- RESPUESTA:
Es una jerarquía SOLAPADA. Lo comprobé al insertar exitosamente el mismo id_persona en ambas tablas subtipo (cliente_subtipo y empleado), permitiendo que un mismo registro exista simultáneamente en ambos roles sin restricciones de exclusividad en la base de datos.

-- =====================================================================
-- ANTES DE SUBIR
-- ---------------------------------------------------------------------
-- [ ] A1-A6 resueltos
-- [ ] B7-B12 resueltos
-- [ ] C13-C16 resueltos
-- [ ] Reto 01 resuelto
-- [ ] Reto 02 completo: tablas, datos, subtipos y consultas
-- [ ] Respuestas escritas de C16 y Reto 02
-- [ ] El archivo ejecuta de arriba a abajo sin errores
--
-- ENTREGA INDIVIDUAL:
--   alumnos/apellidos/06-funciones-de-texto.sql
--
-- =====================================================================