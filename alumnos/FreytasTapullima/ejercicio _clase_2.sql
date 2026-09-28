
SET search_path TO a_freytas;

SELECT current_schema();


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

-----------------------------------------------------

INSERT INTO cliente (nombre, apellido, correo, ciudad) VALUES
  ('Ana',  'Quispe',  'ana@correo.com',  'Huanuco'),
  ('Luis', 'Ramirez', 'luis@correo.com', 'Lima'),
  ('Rosa', 'Tello',   'rosa@correo.com', 'Huanuco');

INSERT INTO cliente (nombre, apellido, correo, ciudad) VALUES
  ('Lisa',  'Lisa',  'lisa@correo.com',  'Loreto'),
  ('Enrique', 'Pasco', 'enri@correo.com', 'Tacna');

INSERT INTO producto (nombre, categoria, precio, stock) VALUES
  ('Laptop Ryzen 5',       'Computo',    2499.00,  8),
  ('Mouse Michi inalambrico',    'Accesorios',   59.90, 40),
  ('Monitor 24 pulgadas',  'Monitores',   749.50, 12);

INSERT INTO producto (nombre, categoria, precio, stock) VALUES
  ('Laptop core i5',       'Computo',    3500.00,  4),
  ('Mouse Dog inalambrico',    'Accesorios',   80, 20),
  ('Monitor 50 pulgadas',  'Monitores',   1000, 5);

INSERT INTO pedido (id_cliente, estado) VALUES
  (1, 'ENTREGADO'),
  (2, 'PENDIENTE'),
  (1, 'PENDIENTE');

INSERT INTO pedido (id_cliente, estado) VALUES
  (6, 'ENTREGADO'),
  (7, 'ENTREGADO');

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
  (1, 1, 1, 2499.00),
  (1, 2, 2,   59.90),
  (2, 3, 1,  749.50),
  (3, 2, 1,   59.90);


INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
  (6, 5, 1, 80.00),
  (7, 6, 2, 1000.00);

--------------------------------------------------------

SELECT nombre, precio
FROM producto
WHERE precio > 500;

SELECT nombre
FROM cliente
ORDER BY nombre ASC;

---------------------------------------------------------------------


-- >>> TE TOCA A TI (3):
-- Modifica la consulta para que muestre solo los pedidos de los clientes
-- de tu ciudad, y agrega el correo del cliente al resultado.

SELECT  c.correo,
		c.ciudad,
		p.fecha,
		p.estado,
		pr.nombre 
FROM detalle_pedido d
JOIN pedido   p  ON d.id_pedido   = p.id_pedido
JOIN cliente  c  ON p.id_cliente  = c.id_cliente
JOIN producto pr ON d.id_producto = pr.id_producto
where ciudad= 'Huanuco';


-------------------------------------------------------------------------




SELECT * FROM cliente;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;
SELECT * FROM producto;
