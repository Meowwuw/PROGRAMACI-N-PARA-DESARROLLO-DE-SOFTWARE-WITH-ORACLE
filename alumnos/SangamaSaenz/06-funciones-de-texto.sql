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
select nombre, apellido,
		upper(nombre) as nombre_mayuscula,
		upper(apellido) as apellido_mayuscula
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
select nombre, apellido,
		initcap(nombre || ' ' ||apellido) as nombre_concatenado
from cliente;

-- A4. Ejecuta primero esta consulta y observa los espacios:
--
--     SELECT '   PostgreSQL en DBeaver   ' AS texto;
--
--     Luego escribe otra consulta que elimine los espacios del inicio
--     y del final. Llama a la columna texto_limpio.
select '   PostgreSQL en DBeaver   ' as texto;
select trim(' PostgreSQL en DBeaver ') as texto_limpio;

-- A5. Muestra el nombre de cada producto y cuántos caracteres tiene.
--     Llama a la segunda columna longitud_nombre.
--     Ordena del nombre más largo al más corto.
select nombre, 
       length(nombre) as longitud_nombre
from producto
order by longitud_nombre desc;

-- A6. Construye una columna llamada ficha_producto con este formato:
--
--     Laptop Ryzen 5 | Computo
--
--     Usa nombre, categoria y el operador ||.
--     Trabaja solo con productos que sí tienen categoría.
select nombre || ' | ' || categoria as ficha_producto
from producto
where categoria is not null;

-- =====================================================================
-- GRUPO B · EXTRAER, BUSCAR Y REEMPLAZAR            (ejercicios 7 al 12)
-- =====================================================================

-- B7. Muestra los primeros 6 caracteres del nombre de cada producto.
--     Columnas: nombre, inicio_nombre.
--     Usa SUBSTRING.
select nombre,
		substring(nombre from 1 for 6) as inicio_nombre
from producto;

-- B8. De cada correo registrado, muestra:
--     nombre del cliente, correo y la posición donde aparece @.
--     Llama a la columna posicion_arroba.
select nombre, correo,
		position('@' in correo) as posicion_arroba
from cliente
where correo is not null;

-- B9. Reemplaza la palabra "Michi" por "MichiStore" en los nombres
--     de productos que contienen "Michi".
--     Muestra nombre original y nombre_modificado.
--     Ojo: solo estamos modificando el RESULTADO, no la tabla.
select nombre, 
       replace(nombre, 'Michi', 'MichiStore') as nombre_modificado
from producto
where nombre like '%Michi%';

-- B10. Muestra nombre, correo y solamente el dominio del correo.
--      Ejemplo conceptual: usuario@dominio.com → dominio.com
--      Pista: POSITION te ayuda a encontrar @ y SUBSTRING a cortar.
select nombre, correo,
       substring(correo from position('@' in correo) + 1) as dominio
from cliente
where correo is not null;

-- B11. Muestra los productos de la categoría Accesorios con este formato:
--
--      PRODUCTO: Mouse Michi inalambrico
--
--      Llama a la columna etiqueta.
--      Usa concatenación; no escribas el nombre del producto manualmente.
select 'PRODUCTO: ' || nombre as etiqueta
from producto
where categoria = 'Accesorios';

-- B12. Busca clientes cuyo correo sea Gmail sin depender de cómo estén
--      escritas las mayúsculas/minúsculas del correo.
--      Esta vez NO uses ILIKE.
--      Pista: normaliza primero el correo con una función de texto.
select nombre, correo from cliente
where lower(correo) like '%@gmail.com%';

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
select nombre, apellido,
       upper(substring(nombre from 1 for 3) || '-' || substring(apellido from 1 for 1)) as codigo_cliente
from cliente;

-- C14. Muestra los productos cuyo nombre tenga MÁS de 18 caracteres.
--      Columnas: nombre y cantidad_caracteres.
select nombre, 
       length(nombre) as cantidad_caracteres
from producto
where length(nombre) > 18;

-- C15. Muestra el nombre completo del cliente y su ciudad en una sola
--      columna con este formato:
--
--      Ana Quispe - Huanuco
--
--      El nombre completo debe quedar con formato de nombre propio.
select initcap(nombre || ' ' || apellido) || ' - ' || initcap(ciudad) as cliente_info
from cliente;

-- C16. Escribe una consulta que permita detectar correos que podrían
--      tener espacios al inicio o al final.
--      Muestra correo_original y correo_limpio.
--
--      Después responde:
--      ¿TRIM modifica el dato guardado en la tabla?
--      RESPUESTA: No, TRIM solo modifica la salida de los datos en la consulta (SELECT). 
--		No altera los registros guardados en el disco a menos que se ejecute una sentencia UPDATE.
select correo as correo_original,
       trim(correo) as correo_limpio
from cliente
where correo is not null 
  and length(correo) != length(trim(correo));

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

create table persona(
    id_persona serial primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    correo varchar(80),
    telefono varchar(15)
);

create table cliente_subtipo(
    id_persona 	int primary key,
    ciudad 		varchar(40) not null,
    puntos 		int not null default 0,
    
    foreign key(id_persona) references persona(id_persona)
);

create table empleado (
    id_persona int primary key,
    cargo varchar(50) not null,
    sueldo numeric(10,2) not null,
    fecha_ingreso date not null,
    
    foreign key(id_persona) references persona(id_persona)
);


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

insert into persona (nombre, apellido, correo, telefono) values
('Carlos', 'Mendoza', 'carlos.mendoza@email.com', '987654321'),
('Maria', 'Gomez', 'maria.gomez@email.com', '987654322'),
('Luis', 'Torres', 'luis.torres@email.com', '987654323'),
('Elena', 'Rojas', 'elena.rojas@email.com', '987654324'),
('Pedro', 'Vargas', 'pedro.vargas@email.com', '987654325');

-- Consulta aquí los IDs generados:
select * from persona;

-- ---------------------------------------------------------------------
-- PASO 3 · ASIGNA LOS SUBTIPOS
-- ---------------------------------------------------------------------
-- De tus 5 personas:
--   · convierte 3 en CLIENTES

insert into cliente_subtipo (id_persona, ciudad, puntos) values
(1, 'Lima', 150),
(2, 'Arequipa', 80),
(3, 'Cusco', 200);

--   · convierte 2 en EMPLEADOS

insert into empleado (id_persona, cargo, sueldo, fecha_ingreso) values
(4, 'Vendedor', 1500.00, '2023-01-15'),
(5, 'Administrador', 2500.00, '2022-05-10');

-- Para hacerlo NO vuelvas a escribir nombre, apellido o correo.
-- Inserta en cada subtipo el id_persona que ya existe en PERSONA y
-- solamente los atributos propios del subtipo.


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

insert into empleado (id_persona, cargo, sueldo, fecha_ingreso) values
(1, 'Soporte Tecnico', 1800.00, '2024-02-01');

-- ---------------------------------------------------------------------
-- PASO 5 · CONSULTA LA JERARQUÍA
-- ---------------------------------------------------------------------
-- J1. Muestra los clientes con sus datos completos.
--     Debes unir PERSONA + CLIENTE_SUBTIPO usando id_persona.
--     Muestra: id_persona, nombre completo, ciudad y puntos.

select p.id_persona,
       p.nombre || ' ' || p.apellido as nombre_completo,
       c.ciudad,
       c.puntos
from persona p
inner join cliente_subtipo c on p.id_persona = c.id_persona;

-- J2. Muestra los empleados con sus datos completos.
--     Debes unir PERSONA + EMPLEADO usando id_persona.
--     Muestra: id_persona, nombre completo, cargo y sueldo.

select p.id_persona,
       p.nombre || ' ' || p.apellido as nombre_completo,
       e.cargo,
       e.sueldo
from persona p
inner join empleado e on p.id_persona = e.id_persona;

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
-- RESPUESTA: Porque los datos generales están guardados en una sola tabla (PERSONA). 
-- Las otras tablas solo guardan sus datos propios y se conectan usando el id_persona (JOIN), 
-- sin repetir información.


-- ¿La jerarquía que acabamos de construir es EXCLUSIVA o SOLAPADA?
-- ¿Cómo lo comprobaste?
--
-- RESPUESTA:Es solapada. Lo comprobé insertando el mismo id_persona en la tabla de clientes y
-- en la de empleados al mismo tiempo sin que la base de datos diera error.


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
