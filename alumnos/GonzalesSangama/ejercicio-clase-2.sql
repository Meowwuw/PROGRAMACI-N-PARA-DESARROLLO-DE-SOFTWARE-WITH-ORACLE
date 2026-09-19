	create schema if not exists a_gonzales;
	set search_path to a_gonzales;
	SELECT current_schema();
	
	-- ---------------------------------------------------------------------
	-- EJERCICIO 1 · CREAR LAS TABLAS
	-- Primero las tablas independientes, despues las que tienen FK.
	-- ---------------------------------------------------------------------
	
	create table cliente (
		id_cliente	serial primary key,
		nombre		varchar(50) not null,
		apellido	varchar(50) not null,
		correo		varchar(80)	unique,
		ciudad		varchar(40) 
	);
	
	create table producto (
		id_producto	serial	primary key,
		nombre		varchar(80)	not null,
		categoria	varchar(40),
		precio		numeric(10,2) not null,
		stock		int default 0
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
	  ('Alex', 'Rosales', 'alex@correo.com', 'Ucayali'),
	  ('Jonas', 'Gonzales', 'jonas@correo.com', 'Ucayali');
	
	INSERT INTO producto (nombre, categoria, precio, stock) VALUES
	  ('Laptop Ryzen 5',       'Computo',    2499.00,  8),
	  ('Mouse Michi inalambrico',    'Accesorios',   59.90, 40),
	  ('Monitor 24 pulgadas',  'Monitores',   749.50, 12),
	  ('Laptop Lenovo LOQ', 	'Computo', 4799.00, 7),
	  ('PC gamer', 'Computo', 7899.00, 8);
	
	INSERT INTO pedido (id_cliente, estado) VALUES
	  (1, 'ENTREGADO'),
	  (2, 'PENDIENTE'),
	  (1, 'PENDIENTE'),
	  (2, 'ENTREGADO'),
	  (1, 'PENDIENTE'),
	  (4, 'ENTREGADO'),
	  (5, 'ENTREGADO');
	
	INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
	  (1, 1, 1, 2499.00),
	  (1, 2, 2,   59.90),
	  (2, 3, 1,  749.50),
	  (3, 2, 1,   59.90),
	  (5, 4, 3,   4799.00),
	  (4, 5, 1, 7899.00);
	
	SELECT * FROM cliente;
	SELECT * FROM pedido;
	
	select * from  producto;
	
	-- ---------------------------------------------------------------------
	-- EJERCICIO 3 · CONSULTAR
	-- Orden obligatorio: SELECT ... FROM ... WHERE ... ORDER BY
	-- ---------------------------------------------------------------------
	
	-- Todos los productos, del mas caro al mas barato
	SELECT nombre, categoria, precio
	FROM producto
	ORDER BY precio DESC;
	
	-- Solo los clientes de Huanuco
	SELECT nombre, apellido, correo
	FROM cliente
	WHERE ciudad = 'Ucayali';
	
	-- Productos de computo con poco stock
	SELECT nombre, stock
	FROM producto
	WHERE categoria = 'Computo' AND stock > 1;
	
	
	-- >>> TE TOCA A TI (2):
	-- a) Muestra los productos que cuestan mas de 500 soles.
	SELECT nombre, categoria, precio
	FROM producto
	WHERE precio > 500;
	
	
	-- b) Muestra los clientes ordenados por apellido de la A a la Z.
	SELECT nombre, apellido, correo
	FROM cliente
	ORDER BY apellido ASC;
	
	
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
	ORDER BY p.fecha DESC;
	
	-- >>> TE TOCA A TI (3):
	-- Modifica la consulta para que muestre solo los pedidos de los clientes
	-- de tu ciudad, y agrega el correo del cliente al resultado.
	SELECT c.apellido,
	       c.correo,
	       p.fecha,
	       pr.nombre AS producto,
	       d.cantidad,
	       d.cantidad * d.precio_unit AS total
	FROM detalle_pedido d
	JOIN pedido p ON d.id_pedido = p.id_pedido
	JOIN cliente c ON p.id_cliente = c.id_cliente
	JOIN producto pr ON d.id_producto = pr.id_producto
	WHERE c.ciudad = 'Ucayali'
	ORDER BY p.fecha desc;
	
	-- ---------------------------------------------------------------------
	-- RETO INDIVIDUAL
	-- Muestra, por cada cliente, cuantos pedidos ha realizado.
	-- Pista: COUNT y GROUP BY. No lo hemos visto todavia: buscalo y pruebalo.
	-- ---------------------------------------------------------------------
	
	-- Escribe tu respuesta aqui:
	SELECT c.apellido,
	       c.correo,
	       COUNT(p.id_pedido) AS cantidad_pedidos
	FROM cliente c
	LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
	GROUP BY c.id_cliente, c.apellido, c.correo
	ORDER BY cantidad_pedidos DESC;
	
	select count(*) from cliente;
	
	
	select avg(precio)
	from producto;
	
	
	-- Una sola fila con el resumen completo del catalogo
SELECT COUNT(*)     AS total_productos,
       AVG(precio)  AS precio_promedio,
       MAX(precio)  AS mas_caro,
       MIN(precio)  AS mas_barato,
       SUM(stock)   AS unidades_en_stock
FROM producto;

 


	-- ---------------------------------------------------------------------
	-- SI NECESITAS EMPEZAR DE CERO
	-- Borra en orden inverso al que creaste (primero las tablas con FK).
	-- ---------------------------------------------------------------------
	 --DROP TABLE IF EXISTS detalle_pedido;
	 --DROP TABLE IF EXISTS pedido;
	 --DROP TABLE IF EXISTS producto;
	 --DROP TABLE IF EXISTS cliente;
	.sql
