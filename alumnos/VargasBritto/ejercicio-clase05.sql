-- GRUPO A · COMPARACION Y RANGO        (ejercicios 1 al 6)
-- =====================================================================

-- A1. Productos que cuestan mas de 500 soles.
select * from producto;
select nombre, precio from producto where precio > 500 ;

-- A2. Productos que no tienen stock.
select nombre, stock from producto where stock = 0;

-- A3. Pedidos que NO estan cancelados.
--     Usa <>, no uses = tres veces.
select * from pedido;
select estado from pedido where estado <> 'ÇANCELADO';


-- A4. Productos con precio entre 100 y 800, ordenados del mas barato
--     al mas caro.
select * from producto;
select nombre, precio from producto where precio between 100 and 800 order by precio asc;

-- A5. Pedidos hechos durante agosto de 2026.
select * from pedido 
where fecha between '2026-08-01' and '2026-08-31';


-- A6. Productos por reponer: los que tienen entre 1 y 10 unidades.
select nombre, stock from producto 
where stock >= 1 and stock <= 10;

-- =====================================================================
-- GRUPO B · IN Y LIKE                  (ejercicios 7 al 12)
-- =====================================================================

-- B7. Clientes de Huanuco, Lima o Pucallpa.
--     Escribela primero con OR y despues con IN. Compara cual se lee mejor.
select nombre, ciudad from cliente 
where ciudad = 'Huanuco' or ciudad = 'Lima' or ciudad = 'Pucallpa';
select nombre,ciudad from cliente 
where ciudad in ('Huanuco', 'Lima', 'Pucallpa');

-- B8. Pedidos que estan PENDIENTE o ENTREGADO.
select * from pedido 
where estado in ('PENDIENTE', 'ENTREGADO');

select * from pedido 
where estado = 'PENDIENTE' or estado = 'ENTREGADO';

-- B9. Productos que NO son de Computo ni de Monitores.
--     Ojo con el resultado: revisa si aparece la Alfombrilla Michi XL.
--     Si no aparece, piensa por que y anotalo aqui.
--     RESPUESTA:Por que no tiene un dato Ausente y cuando se lo llama no aparece porque no hay dato que mostrar
select * from producto 
where categoria in ('Accesorios', 'Oficina','Componentes');


-- B10. Clientes cuyo correo es de Gmail.
select nombre, correo from cliente where correo like '%@gmail.com%';

-- B11. Clientes cuyo apellido empieza con Q, sin importar mayusculas.
select nombre, apellido from cliente where apellido ilike 'Q%';

-- B12. Productos cuyo nombre contiene "Michi", en cualquier posicion.
select * from producto 
where nombre ilike '%Michi%';

-- =====================================================================
-- GRUPO C · NULL Y COMBINACIONES       (ejercicios 13 al 18)
-- =====================================================================

-- C13. Clientes que no tienen correo registrado.
select nombre, correo from cliente where correo is null;

-- C14. Clientes que si tienen telefono.
select * from cliente 
where telefono is not null;

-- C15. Ejecuta esto:
--        SELECT * FROM cliente WHERE correo = NULL;
--      Devuelve cero filas aunque SI hay clientes sin correo.
--      Escribe aqui por que:
--      RESPUESTA:
--		Porque NULL no es un valor que se pueda comparar con el signo =
--		Para buscar nulos, siempre se debe usar IS NULL en lugar de = NULL.


-- C16. Accesorios que cuesten menos de 150 soles.
select * from producto 
where categoria = 'Accesorio' and precio < 150;

-- C17. Productos sin stock O que cuesten mas de 2000 soles.
select * from producto 
where stock <> 0 and precio > 2000;

-- C18. Clientes de Huanuco que tengan correo registrado.
select * from cliente 
where ciudad = 'Huanuco' and correo is not null;

-- =====================================================================
-- GRUPO D · OPERADORES CON JOIN        (ejercicios 19 al 24)
-- =====================================================================

-- D19. Pedidos de agosto con el apellido del cliente y su ciudad.
select 	p.id_pedido ,
		c.apellido,
		c.ciudad 
from pedido p
join cliente c on p.id_cliente = c.id_cliente
where p.fecha between '2026-08-01' and '2026-08-31';

-- D20. Detalle del pedido 20: nombre del producto, cantidad,
--      precio cobrado y subtotal (cantidad * precio_unit).
select prod.nombre as producto,
		dp.cantidad,
		dp.precio_unit as precio_cobrado,
		(dp.cantidad * dp.precio_unit) as subtotal
from detalle_pedido dp 
join producto prod on dp.id_producto = prod.id_producto
where dp.id_pedido = 20;

select * from detalle_pedido;
select * from pedido;
select * from producto;
-- D21. Pedidos de clientes de Lima que no esten cancelados.
select  c.nombre,
		c.ciudad,
		p.estado
from pedido p 
join cliente c on p.id_cliente = c.id_cliente 
where c.ciudad = 'Lima' and p.estado <> 'CANCELADO';

-- D22. Ventas donde el precio cobrado fue DISTINTO del precio actual
--      del producto. Muestra producto, precio_unit y precio.
--      Esto es el precio historico del que hablamos: no es un error.
select pr.nombre as producto, dp.precio_unit, pr.precio 
from detalle_pedido dp
join producto pr on dp.id_producto = pr.id_producto
where dp.precio_unit <> pr.precio;

-- D23. Clientes que nunca han hecho un pedido.
--      Pista: LEFT JOIN y IS NULL.
select c.* 
from cliente c
left join pedido p on c.id_cliente = p.id_cliente
where p.id_pedido is null;

-- D24. Productos que nunca se han vendido.
select pr.* 
from producto pr
left join detalle_pedido dp on pr.id_producto = dp.id_producto
where dp.id_producto is null;
