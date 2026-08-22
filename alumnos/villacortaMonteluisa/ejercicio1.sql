-- Se ejecuta UNA SOLA VEZ en tu vida:
create schema if not exists a_villacorta;

-- Se ejecuta CADA VEZ que abres DBeaver:
SET search_path TO a_villacorta;

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
