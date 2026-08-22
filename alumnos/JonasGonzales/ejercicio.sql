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

 --CLASE 3 EJERCICIO EN CLASE
-- El promedio sale con muchos decimales. Se redondea:
SELECT ROUND(AVG(precio), 2) AS precio_promedio FROM producto;

--1)  ¿Cuántos clientes hay registrados?
	select count(*) as total_cliente from cliente ;

--2)  ¿Cuál es el total de unidades vendidas en detalle_pedido?      
	select sum(cantidad) as unidades_vendidas from detalle_pedido ;

select id_pedido,
	sum(cantidad * precio_unit) as total_pedido
	from detalle_pedido
	group by id_pedido
	order by total_pedido desc
	limit 2;

--3)  ¿Cuánto suma el pedido más caro?
	SELECT MAX(precio)  AS mas_caro,
       	   SUM(precio)   AS suma_del_pedido_mas_caro
	FROM producto;

select * from detalle_pedido

-- Ejercicio
SELECT categoria,
       COUNT(*)               AS cantidad,
       ROUND(AVG(precio), 2)  AS precio_promedio
FROM producto
GROUP BY categoria
ORDER BY cantidad DESC;

-- Cuantos clientes tengo por ciudad?
SELECT ciudad, COUNT(*) AS clientes
FROM cliente
GROUP BY ciudad
ORDER BY clientes DESC;
 
-- Cuanto vendi de cada producto? (agrupando con JOIN)
SELECT pr.nombre,
       SUM(d.cantidad) AS unidades,
       SUM(d.cantidad * d.precio_unit) AS total
FROM detalle_pedido d
JOIN producto pr ON d.id_producto = pr.id_producto
GROUP BY pr.nombre
ORDER BY total DESC;

--¿Cuántos pedidos tiene cada cliente? Muestra apellido y cantidad, del que más pide al que menos.
	select 
	c.apellido,
	count(p.id_pedido) as cantidad_pedidos
	from cliente c
	join pedido p on c.id_cliente = p.id_cliente
	group by c.id_cliente, c.apellido 
	order by cantidad_pedidos desc;

-- Ciudades donde tengo mas de un cliente,
-- considerando solo clientes con correo registrado
SELECT ciudad, COUNT(*) AS clientes
FROM cliente
WHERE correo IS NOT NULL      -- filtra filas
GROUP BY ciudad
HAVING COUNT(*) > 1;          -- filtra grupos

--¿Qué categorías tienen más de un producto en catálogo?
SELECT categoria, COUNT(*) AS cantidad_productos
FROM producto
WHERE nombre IS NOT NULL
GROUP BY categoria
HAVING COUNT(*) > 1;

--¿Qué clientes han hecho 2 o más pedidos?
SELECT 
    c.apellido,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.apellido
HAVING COUNT(p.id_pedido) >= 2
ORDER BY cantidad_pedidos;

--¿Qué productos han vendido más de 1 unidad en total?
SELECT 
    p.nombre,
    SUM(dp.cantidad) AS total_vendido
FROM producto p
JOIN detalle_pedido dp 
    ON p.id_producto = dp.id_producto
GROUP BY p.id_producto, p.nombre
HAVING SUM(dp.cantidad) >1
ORDER BY total_vendido DESC;


-- Clientes que NUNCA han comprado
SELECT c.apellido, c.ciudad
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;


-- Todos los clientes, con su numero de pedidos.
-- Los que nunca compraron salen con 0.
SELECT c.apellido,
       c.ciudad,
       COUNT(p.id_p
       edido) AS pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.apellido, c.ciudad
ORDER BY pedidos DESC;

--¿Por qué aquí se usa COUNT(p.id_pedido) y no COUNT(*)? Cámbialo, ejecuta y explica la diferencia. Después: lista los productos que nunca se han vendido.
SELECT c.apellido,
       c.ciudad,
       COUNT(*) AS pedidos
FROM cliente c
LEFT JOIN pedido p 
    ON c.id_cliente = p.id_cliente
GROUP BY c.apellido, c.ciudad
ORDER BY pedidos DESC;

-- En el primer ejercicio usamos  COUNT(p.id_pedido) para contar los pedidos 
-- En el segundo ejercicio usamos COUNT(*) para contar clientes


	-- ---------------------------------------------------------------------
	-- SI NECESITAS EMPEZAR DE CERO
	-- Borra en orden inverso al que creaste (primero las tablas con FK).
	-- ---------------------------------------------------------------------
	 --DROP TABLE IF EXISTS detalle_pedido;
	 --DROP TABLE IF EXISTS pedido;
	 --DROP TABLE IF EXISTS producto;
	 --DROP TABLE IF EXISTS cliente;
	.sql
