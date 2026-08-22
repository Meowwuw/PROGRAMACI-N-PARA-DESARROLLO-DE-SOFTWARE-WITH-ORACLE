-- Se ejecuta UNA SOLA VEZ en tu vida:
create schema if not exists a_zarate;

-- Se ejecuta CADA VEZ que abres DBeaver:
SET search_path TO a_zarate;

-- Verifica donde estas parado antes de seguir:
SELECT current_schema();

-- ---------------------------------------------------------------------
-- EJERCICIO 1 · CREAR LAS TABLAS
-- Primero las tablas independientes, despues las que tienen FK.
-- ---------------------------------------------------------------------

CREATE TABLE cliente (
    id_cliente  SERIAL      PRIMARY KEY,
    nombre      VARCHAR(50) NOT NULL,
    apellido    VARCHAR(50) NOT NULL,
    correo      VARCHAR(80) UNIQUE, 	
    ciudad      VARCHAR(40)
);

CREATE TABLE producto (
    id_producto SERIAL        PRIMARY KEY,
    nombre      VARCHAR(80)   NOT NULL,
    categoria   VARCHAR(40),
    precio      NUMERIC(10,2) NOT NULL,
    stock       INT DEFAULT 0
);

CREATE TABLE pedido (
    id_pedido  SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES cliente(id_cliente),
    fecha      DATE DEFAULT CURRENT_DATE,
    estado     VARCHAR(20) DEFAULT 'PENDIENTE'
);

CREATE TABLE detalle_pedido (
    id_detalle   SERIAL PRIMARY KEY,
    id_pedido    INT NOT NULL REFERENCES pedido(id_pedido),
    id_producto  INT NOT NULL REFERENCES producto(id_producto),
    cantidad     INT NOT NULL,
    precio_unit  NUMERIC(10,2) NOT NULL
);


-- ---------------------------------------------------------------------
-- EJERCICIO 2 · INSERTAR DATOS DE PRUEBA
-- Los textos van entre comillas SIMPLES. Los numeros van sin comillas.
-- No escribimos los id: SERIAL los genera solo.
-- ---------------------------------------------------------------------

INSERT INTO cliente (nombre, apellido, correo, ciudad) VALUES
  ('Ana',  'Quispe',  'ana@correo.com',  'Huanuco'),
  ('Luis', 'Ramirez', 'luis@correo.com', 'Lima'),
  ('Rosa', 'Tello',   'rosa@correo.com', 'Huanuco'),
  ('Adolf', 'Hitler', 'adolf@correo.com', 'Deutschland'),
  ('Leoncio', 'Prado', 'coronel@correo.com', 'Junin');

INSERT INTO producto (nombre, categoria, precio, stock) VALUES
  ('Laptop Ryzen 5',       'Computo',    2499.00,  8),
  ('Mouse Michi inalambrico',    'Accesorios',   59.90, 40),
  ('Monitor 24 pulgadas',  'Monitores',   749.50, 12),
  ('RTX 5080 super', 'Computo', 8500.00, 9),
  ('Silla gamer', 'Silla', 699.00, 20);

INSERT INTO pedido (id_cliente, estado) VALUES
  (1, 'ENTREGADO'),
  (2, 'PENDIENTE'),
  (1, 'PENDIENTE'),
  (2, 'ENTREGADO'),
  (3, 'PENDIENTE');


INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
  (1, 1, 1, 2499.00),
  (1, 2, 2,   59.90),
  (2, 3, 1,  749.50),
  (2, 1, 3, 8499.00),
  (3, 2, 1,  699.00);

SELECT * FROM cliente;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;

select nombre, categoria, precio
from producto
order by precio asc;

select nombre, apellido, correo
from cliente
where ciudad = 'Huanuco';

select nombre, stock
from producto
where categoria = 'Computo' and stock < 10;

-- >>> TE TOCA A TI (2):
-- a) Muestra los productos que cuestan mas de 500 soles.
-- b) Muestra los clientes ordenados por apellido de la A a la Z.

select nombre, precio
from producto
where precio > 500;

select nombre, apellido
from cliente
order by apellido asc;

-- ---------------------------------------------------------------------
--
-- --------------------------      22/08      --------------------------
--
-- ---------------------------------------------------------------------
-- EJERCICIO 4 · JOIN ENTRE CUATRO TABLAS
-- Empezamos desde la tabla que tiene las claves foraneas y saltamos
-- desde ahi hacia las demas.
-- ---------------------------------------------------------------------

SELECT  c.apellido,
        p.fecha,
        pr.nombre        AS producto,
        d.cantidad,
        d.cantidad * d.precio_unit AS total
FROM detalle_pedido d
JOIN pedido   p  ON d.id_pedido   = p.id_pedido
JOIN cliente  c  ON p.id_cliente  = c.id_cliente
JOIN producto pr ON d.id_producto = pr.id_producto
WHERE c.ciudad = 'Huanuco'
ORDER BY p.fecha DESC;

-- >>> TE TOCA A TI (1):
-- a) Cuantos cientes hay registrados?
-- count()
select count(*) from cliente;

-- b) Cual es el total de unidades vendidas en detalle_pedido?
-- sum()
select sum(cantidad) AS total_unidades_vendidas
from detalle_pedido;

-- c) Cuánto suma el pedido más caro?
select id_pedido,
		sum(cantidad * precio_unit) as total_pedido
from detalle_pedido
group by id_pedido
order by total_pedido desc
limit 1;

select * from detalle_pedido;

-- ----------------------------------------------------------------------------------
-- EJERCICIO 2 -GROUP BY
-- Regla de oro: todo lo que va en el SELECT y no es funcion de
-- agregado, tiene que estar tambien en el GROUP BY
-- ----------------------------------------------------------------------------------
SELECT categoria,
       COUNT(*)               AS cantidad,
       ROUND(AVG(precio), 2)  AS precio_promedio
FROM producto
GROUP BY categoria
ORDER BY cantidad DESC;

select * from producto;

-- Cuantos clientes tengo por ciudad?
select ciudad, count(*) as cliente
group by ciudad
order by cliente desc;

-- cuanto vendi de cada producto? (GROUP BY combinado con JOIN)
select pr.nombre,
		sum(d.cantidad)					as unidades,
		sum(d.cantidad * d.precio_unit) as total
from detalle_pedido d
join producto pr on d.id_producto = pr.id_producto
group by pr.nombre
order by total desc;

-- >>> TE TOCA A TI (2):
-- Cuantos pedidos tiene cada cliente? Muestra apellido y cantidad,
-- del que mas pide al que menos.
-- JOIN
select c.apellido,
		count(p.id_pedido) as cantidad_pedido
from cliente c
join pedido p on c.id_cliente = p.id_cliente
group by c.apellido
order by cantidad_pedido desc;

select * from cliente;

-- Cuanto vendi de cada producto? (agrupando con JOIN)
SELECT pr.nombre,
       SUM(d.cantidad) AS unidades,
       SUM(d.cantidad * d.precio_unit) AS total
FROM detalle_pedido d
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY pr.nombre
ORDER BY total DESC;


-- Ciudades donde tengo mas de un cliente,
-- considerando solo clientes con correo registrado
SELECT ciudad, COUNT(*) AS clientes
FROM cliente
WHERE correo IS NOT NULL      -- filtra filas
GROUP BY ciudad
HAVING COUNT(*) > 1;          -- filtra grupos

select * from cliente;
-- >>> TE TOCA A TI (3):
-- a) Qué categorias tiene mas de un producto en catalogo?
--
select categoria,
		count(*) as total_producto
from producto
group by categoria 
having count (*) > 1;

select * from producto;

-- b) Que clientes han hecho 2 o mas pedidos?
--
select c.apellido,
		count(*) as total_pedidos
from cliente c
group by c.apellido

select * from cliente, detalle_pedido

-- c) Que productos han vendido mas de 1 unidad en total?
Pista: si la condicion contiene COUNT, SUM o AVG va en el having
SELECT p.nombre,
       SUM(dp.cantidad) AS unidades_vendidas
FROM producto p
JOIN detalle_pedido dp
     ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
HAVING SUM(dp.cantidad) > 1;

-- ---------------------------------------------------------------
-- >>> TE TOCA A TI(4):
-- Todos los clientes, con su numero de pedidos.
-- Los que nunca compraron salen con 0.
SELECT c.apellido,
       c.ciudad,
       COUNT(p.id_pedido) AS pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.apellido, c.ciudad
ORDER BY pedidos DESC;


-- a) Cambia COUNT (p.id_pedido) por COUNT(*), ejecuta y explica
select c.apellido,
       c.ciudad,
       count(p.id_pedido) AS pedidos
from cliente c
left join pedido p on c.id_cliente = p.id_cliente
group by c.apellido, c.ciudad
order by pedidos desc;


-- Los resultados arrojaron lo mismo porque el count * cuenta
-- los registros de la tabla y el id_pedido es un pk serial que
-- siempre va amentar por cada inserccion de registro

-- b) Lista de productos que nunca se han vendido
select p.id_producto,
       p.nombre,
       p.categoria,
       p.precio,
       p.stock
from producto p
left join detalle_pedido dp
       on p.id_producto = dp.id_producto
where dp.id_producto is null;


-- -------------------------------------
