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
SELECT 
    UPPER(nombre) AS nombre_mayuscula,
    UPPER(apellido) AS apellido_mayuscula
FROM cliente;

-- A2. Muestra el correo original y el mismo correo en minúsculas.
--     Trabaja solo con clientes que sí tienen correo.
SELECT 
    correo AS correo_original,
    LOWER(correo) AS correo_minuscula
FROM cliente
WHERE correo IS NOT NULL;

-- A3. Muestra nombre y apellido como una sola columna llamada
--     cliente_formateado. Debe verse como nombre propio.
--     Pista: combina INITCAP con ||.
SELECT nombre, apellido,
    INITCAP(nombre || ' ' || apellido) AS cliente_formateado
FROM cliente;

-- A4. Ejecuta primero esta consulta y observa los espacios:
  SELECT '   PostgreSQL en DBeaver   ' AS texto;

--     Luego escribe otra consulta que elimine los espacios del inicio
--     y del final. Llama a la columna texto_limpio.
SELECT 
    TRIM('   PostgreSQL en DBeaver   ') AS texto_limpio;

-- A5. Muestra el nombre de cada producto y cuántos caracteres tiene.
--     Llama a la segunda columna longitud_nombre.
--     Ordena del nombre más largo al más corto.
SELECT 
    nombre,
    LENGTH(nombre) AS longitud_nombre
FROM producto
ORDER BY longitud_nombre DESC;

-- A6. Construye una columna llamada ficha_producto con este formato:
--
--     Laptop Ryzen 5 | Computo
--
--     Usa nombre, categoria y el operador ||.
--     Trabaja solo con productos que sí tienen categoría.
SELECT 
    nombre || ' | ' || categoria AS ficha_producto
FROM producto
WHERE categoria IS NOT NULL;

-- =====================================================================
-- GRUPO B · EXTRAER, BUSCAR Y REEMPLAZAR            (ejercicios 7 al 12)
-- =====================================================================

-- B7. Muestra los primeros 6 caracteres del nombre de cada producto.
--     Columnas: nombre, inicio_nombre.
--     Usa SUBSTRING.
SELECT nombre,
    SUBSTRING(nombre FROM 1 FOR 6) AS inicio_nombre
FROM producto;

-- B8. De cada correo registrado, muestra:
--     nombre del cliente, correo y la posición donde aparece @.
--     Llama a la columna posicion_arroba.
SELECT 
    nombre,
    correo,
    POSITION('@' IN correo) AS posicion_arroba
FROM cliente
WHERE correo IS NOT NULL;

-- B9. Reemplaza la palabra "Michi" por "MichiStore" en los nombres
--     de productos que contienen "Michi".
--     Muestra nombre original y nombre_modificado.
--     Ojo: solo estamos modificando el RESULTADO, no la tabla.
SELECT 
    nombre,
    REPLACE(nombre, 'Michi', 'MichiStore') AS nombre_modificado
FROM producto
WHERE nombre LIKE '%Michi%';

-- B10. Muestra nombre, correo y solamente el dominio del correo.
--      Ejemplo conceptual: usuario@dominio.com → dominio.com
--      Pista: POSITION te ayuda a encontrar @ y SUBSTRING a cortar.
select nombre, substring(correo from position('@' in correo)) as dominio from cliente where correo is not null;

-- B11. Muestra los productos de la categoría Accesorios con este formato:
--
--      PRODUCTO: Mouse Michi inalambrico
--
--      Llama a la columna etiqueta.
--      Usa concatenación; no escribas el nombre del producto manualmente.
select * from producto;

select initcap('PRODUCTO: ' ||' '|| nombre) as etiqueta from producto where categoria = 'Accesorios';
-- B12. Busca clientes cuyo correo sea Gmail sin depender de cómo estén
--      escritas las mayúsculas/minúsculas del correo.
--      Esta vez NO uses ILIKE.
--      Pista: normaliza primero el correo con una función de texto.
select nombre, lower(correo) as correo_minuscula from cliente where correo like '%gmail.com';

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

select * from cliente;

select UPPER(substring(nombre from 1 for 3) || '-' || upper(substring(apellido from 1 for 1))) as codigo_cliente from cliente;

-- C14. Muestra los productos cuyo nombre tenga MÁS de 18 caracteres.
--      Columnas: nombre y cantidad_caracteres.

select * from producto;

select nombre, length(nombre) as cantidad from producto where length(nombre) > 18;

SELECT 
    nombre,
    LENGTH(nombre) AS cantidad_caracteres
FROM producto
WHERE LENGTH(nombre) > 18;

-- C15. Muestra el nombre completo del cliente y su ciudad en una sola
--      columna con este formato:
--
--      Ana Quispe - Huanuco
--
--      El nombre completo debe quedar con formato de nombre propio.
SELECT 
    INITCAP(nombre) || ' ' || INITCAP(apellido) || ' - ' || INITCAP(ciudad) AS cliente_ciudad
FROM cliente;

-- C16. Escribe una consulta que permita detectar correos que podrían
--      tener espacios al inicio o al final.
--      Muestra correo_original y correo_limpio.
SELECT 
    correo AS correo_original,
    TRIM(correo) AS correo_limpio
FROM cliente
WHERE correo IS NOT NULL 
  AND correo <> TRIM(correo);

set search_path to michistore;

--      Después responde:
--      ¿TRIM modifica el dato guardado en la tabla?
--      RESPUESTA:
--       No, TRIM sólo modifica la forma en que se visualiza o presenta la información en el resultado de la consulta (SELECT)
--       Para modificar el dato almacenado en la tabla de forma permanente, se tendría que ejecutar un comando UPDATE.

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

drop table persona;
drop table cliente_subtipo;
drop table empleado;

create table persona(
	id_persona    SERIAL PRIMARY key,
	nombre        VARCHAR(50) NOT null,
	apellido      VARCHAR(50) NOT null,
	correo        VARCHAR(80),
   	telefono      VARCHAR(15));

create table cliente_subtipo(
   id_persona    INT PRIMARY key,
   foreign key (id_persona) references persona(id_persona),
   ciudad        VARCHAR(40) NOT null,
   puntos        INT NOT NULL DEFAULT 0);

create table empleado(
   	id_persona   INT primary key, 
   	foreign key (id_persona)references persona(id_persona),
	cargo         VARCHAR(50) NOT null,
	sueldo        NUMERIC(10,2) NOT null,
	fecha_ingreso DATE NOT null);
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
INSERT INTO persona (nombre, apellido, correo, telefono) VALUES
('Carlos', 'Mendoza', 'carlos.mendoza@email.com', '+51987654321'),
('Ana', 'Valdez', 'ana.valdez@email.com', '+51912345678'),
('Luis', 'Torres', 'luis.torres@email.com', '+51923456789'),
('María', 'Fernández', 'maria.fernandez@email.com', '+51934567890'),
('Jorge', 'Ramírez', 'jorge.ramirez@email.com', '+51945678901');
-- Consulta aquí los IDs generados:
select * from persona;

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

(1, 'Lima', 120),

(2, 'Arequipa', 45),

(3, 'Cusco', 300);



INSERT INTO empleado (id_persona, cargo, sueldo, fecha_ingreso) VALUES

(4, 'Analista de Sistemas', 3200.00, '2023-03-15'),

(5, 'Recursos Humanos', 2800.50, '2022-11-01');



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

INSERT INTO empleado (id_persona, cargo, sueldo, fecha_ingreso) VALUES
(1, 'Vendedor Freelance', 1500.00, '2024-01-10');

-- Al terminar tendrás una persona que es CLIENTE Y EMPLEADO.
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
JOIN cliente_subtipo c ON p.id_persona = c.id_persona
ORDER BY puntos desc;
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
--     ID: 1
-- ---------------------------------------------------------------------
-- PASO 6 · EXPLICA LO QUE OCURRIÓ
-- ---------------------------------------------------------------------
-- Responde con tus palabras:
--
-- ¿Por qué una misma persona pudo aparecer como CLIENTE y EMPLEADO
-- sin repetir su nombre, apellido, correo y teléfono?
--
-- RESPUESTA:
--El modelo implementa un patrón de herencia/especialización con tablas independientes 
--para cada subtipo. Ambos subtipos se relacionan con la entidad PERSONA mediante una clave 
--primaria que actúa simultáneamente como clave foránea (id_persona). Así, los datos generales
-- (nombre, apellido, correo, teléfono) se almacenan de forma única en la tabla base, mientras
-- que los subtipos solo registran sus atributos específicos: CLIENTE (ciudad, puntos) y EMPLEADO 
--(cargo, sueldo, fecha de ingreso). Dado que el esquema no impone una restricción de exclusividad, 
--una misma persona puede asumir ambos roles de manera simultánea sin duplicar su información básica;
--para ello, basta con insertar un registro en la tabla del subtipo correspondiente reutilizando la misma id_persona.
-- ¿La jerarquía que acabamos de construir es EXCLUSIVA o SOLAPADA?
-- ¿Cómo lo comprobaste?
--

-- RESPUESTA:
--La jerarquía es SOLAPADA (no exclusiva).
--¿Cómo se comprobó?
--Prueba de inserción: En el Paso 4 se insertó con éxito al id_persona = 1 como empleado, 
--aunque ya existía como cliente. La base de datos no dio ningún error.
--Consultas J1 y J2: En el Paso 5, el mismo id_persona = 1 apareció en ambas consultas.

-- En una jerarquía exclusiva, esto habría sido imposible.

--¿Por qué lo permite la base de datos?

--Sin discriminador: No hay un campo en PERSONA que obligue a elegir un solo tipo (como tipo_persona).

--Sin validaciones: No existen TRIGGERS ni reglas CHECK que impidan estar en ambas tablas a la vez.

--Control individual: La clave primaria (id_persona) de cada subtipo solo evita duplicados dentro de su propia tabla,
--no entre ellas.

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
