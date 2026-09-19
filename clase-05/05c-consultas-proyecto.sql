-- =====================================================================
-- CLASE 05 · CONSULTAS DEL PROYECTO
-- Entrega EN EQUIPO  ·  equipos/equipo-NN/consultas-proyecto.sql
-- ---------------------------------------------------------------------
-- Equipo N°: ____     Proyecto: ______________________________
-- Integrantes: _______________________________________________
--
-- Se trabaja sobre la base Neon del equipo, no sobre TecnoMichiStore.
-- =====================================================================

SET search_path TO su_esquema;   -- cambia esto por el de su proyecto
SELECT current_schema();


-- =====================================================================
-- PARTE 1 · CARGAR LOS DATOS
-- ---------------------------------------------------------------------
-- Minimo para que las consultas de abajo tengan sentido:
--
--   [ ] 20 filas en la tabla principal de movimientos
--       (reserva, consulta, venta, prestamo... segun su proyecto)
--   [ ] fechas repartidas en varios meses, no todas del mismo dia
--   [ ] precios o montos variados, no todos iguales
--   [ ] algunos campos opcionales en NULL, a proposito
--       (si todo esta lleno, la consulta 6 no devuelve nada)
--   [ ] nombres y correos que parezcan reales
--   [ ] al menos dos dominios de correo distintos
--
-- Reparto sugerido: cada integrante carga una tabla.
-- =====================================================================

-- Sus INSERT:



-- Verificacion: cuantas filas quedaron en cada tabla
-- SELECT COUNT(*) FROM su_tabla_principal;


-- =====================================================================
-- PARTE 2 · LAS DIEZ CONSULTAS
-- ---------------------------------------------------------------------
-- Una de cada tipo. Escriban primero la PREGUNTA en castellano,
-- como comentario, y debajo la consulta que la responde.
--
-- No vale repetir tipo. Si dos consultas usan BETWEEN sobre fechas,
-- una de las dos esta mal planteada.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1 · RANGO DE FECHAS        (BETWEEN)
-- Pregunta:
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- 2 · RANGO DE MONTOS        (BETWEEN)
-- Pregunta:
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- 3 · LISTA DE ESTADOS O CATEGORIAS        (IN)
-- Pregunta:
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- 4 · LO QUE QUEDA FUERA        (NOT IN  o  <>)
-- Pregunta:
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- 5 · BUSQUEDA POR TEXTO        (ILIKE)
-- Pregunta:
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- 6 · UN DATO QUE FALTA        (IS NULL)
-- Pregunta:
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- 7 · UN DATO QUE SI ESTA        (IS NOT NULL)
-- Pregunta:
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- 8 · DOS CONDICIONES A LA VEZ        (AND)
-- Pregunta:
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- 9 · UNA ALTERNATIVA        (OR, con parentesis si mezclan con AND)
-- Pregunta:
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
-- 10 · TRES TABLAS UNIDAS CON UN FILTRO        (JOIN + WHERE)
-- Pregunta:
-- ---------------------------------------------------------------------



-- =====================================================================
-- ANTES DE SUBIR
-- ---------------------------------------------------------------------
-- [ ] Los datos cargados, minimo 20 filas en la tabla principal
-- [ ] Las 10 consultas, cada una con su pregunta escrita arriba
-- [ ] Ninguna consulta devuelve cero filas por falta de datos
-- [ ] El archivo ejecuta completo, de arriba a abajo, sin un solo error
--
-- Sube el Integrador, a:  equipos/equipo-NN/consultas-proyecto.sql
-- =====================================================================
