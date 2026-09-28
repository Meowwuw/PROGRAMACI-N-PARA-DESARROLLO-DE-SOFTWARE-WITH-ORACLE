-- =====================================================================
-- CLASE 02  ·  TecnoMichiStore
-- Programacion para Desarrollo de Software con Oracle - Modulo 01
-- Motor de practica: PostgreSQL (Neon)  ·  Cliente: DBeaver
-- Instructora: Magenta Paredes Ponce
-- =====================================================================
-- COMO USAR ESTE ARCHIVO:
-- Ejecuta bloque por bloque con Ctrl + Enter. NO uses Alt + X (ejecuta
-- todo de golpe y si un bloque falla se te complica encontrar donde).
-- =====================================================================


-- ---------------------------------------------------------------------
-- PASO 0 · TU ESPACIO DE TRABAJO
-- Cambia "a_quispe" por a_ + TU apellido, en minusculas y sin tildes.
-- ---------------------------------------------------------------------

-- Se ejecuta UNA SOLA VEZ en tu vida:
CREATE SCHEMA IF NOT EXISTS a_quispe;

-- Se ejecuta CADA VEZ que abres DBeaver:
SET search_path TO a_quispe;

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
-- No escribimos los id: SERIAL los genera solo.
-- ---------------------------------------------------------------------
-- No escribimos los id: SERIAL los genera solo.
-- ---------------------------------------------------------------------

INSERT INTO cliente (nombre, apellido, correo, ciudad) VALUES
  ('Ana',  'Quispe',  'ana@correo.com',  'Huanuco'),
  ('Luis', 'Ramirez', 'luis@correo.com', 'Lima'),
  ('Rosa', 'Tello',   'rosa@correo.com', 'Huanuco');

INSERT INTO producto (nombre, categoria, precio, stock) VALUES
  ('Laptop Ryzen 5',       'Computo',    2499.00,  8),
  ('Mouse Michi inalambrico',    'Accesorios',   59.90, 40),
  ('Monitor 24 pulgadas',  'Monitores',   749.50, 12);

INSERT INTO pedido (id_cliente, estado) VALUES
  (1, 'ENTREGADO'),
  (2, 'PENDIENTE'),
  (1, 'PENDIENTE');

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
  (1, 1, 1, 2499.00),
  (1, 2, 2,   59.90),
  (2, 3, 1,  749.50),
  (3, 2, 1,   59.90);

SELECT * FROM cliente;
SELECT * FROM pedido;

-- >>> TE TOCA A TI (1):
-- Agrega 2 clientes mas (uno de tu ciudad), 2 productos mas,
-- y registra 3 pedidos nuevos con sus detalles, de clientes distintos.


-- ---------------------------------------------------------------------
-- EJERCICIO 3 · CONSULTAR
-- Orden obligatorio: SELECT ... FROM ... WHERE ... ORDER BY
-- ---------------------------------------------------------------------
