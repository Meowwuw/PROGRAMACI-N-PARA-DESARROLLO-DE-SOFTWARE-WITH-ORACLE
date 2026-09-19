PROBLEMÁTICA

En los últimos años, la perfumería ODA ha incrementado la variedad de marcas y perfumes disponibles, así como la cantidad de clientes y ventas realizadas. Debido a este crecimiento, llevar el control de los productos, clientes, ventas, inventario, recepción de mercadería y envíos de manera manual se ha vuelto complicado.

Esto ha generado tres problemas principales:

1- Falta de control del inventario:
La perfumería trabaja con diferentes marcas, perfumes, concentraciones y presentaciones. Al no contar con un control adecuado del stock, pueden existir productos con cantidades muy bajas o incluso agotados, dificultando el proceso de reabastecimiento.

2- Dificultad para controlar las ventas y los clientes:
Una venta puede incluir uno o varios perfumes, diferentes cantidades y descuentos. Si esta información no se encuentra centralizada, es difícil conocer qué compró cada cliente, cuánto pagó, qué método de pago utilizó y cuáles son los productos más vendidos.

3- Problemas en el control de recepción y entrega de productos:
La perfumería recibe productos organizados por lotes y también realiza pedidos que posteriormente deben ser entregados a los clientes. Si estos procesos se registran manualmente, puede ser difícil conocer qué productos fueron recibidos, en qué cantidad, cuándo llegaron y qué pedidos todavía están pendientes de entrega.

Por esta razón, se implementa una base de datos que permite centralizar la información de las marcas, perfumes, clientes, ventas, detalles de venta, recepción de mercadería y pedidos de envío.
=========================================================================================================================================================================================================================================
Aquí la explicación del por qué de cada tabla creada en el script
1. Tabla marca (Marcas de los perfumes)

Guarda la información de las diferentes marcas de perfumes que comercializa la perfumería.

id_marca SERIAL PRIMARY KEY: Es el identificador único de cada marca. SERIAL genera automáticamente un número entero autoincremental (1, 2, 3...) cada vez que se registra una nueva marca. PRIMARY KEY garantiza que cada marca tenga un ID único.

nombre_marca VARCHAR(50) NOT NULL UNIQUE: Guarda el nombre de la marca, por ejemplo, Dior, Chanel, Versace, Gucci, etc. VARCHAR(50) permite almacenar hasta 50 caracteres. NOT NULL indica que este dato es obligatorio y UNIQUE evita que una misma marca sea registrada dos veces.

pais_origen VARCHAR(50): Almacena el país de origen de la marca. Es opcional porque puede existir información que todavía no haya sido registrada.

sitio_web VARCHAR(150): Guarda la dirección del sitio web correspondiente a la marca. Se utiliza VARCHAR(150) porque una dirección web puede tener una cantidad considerable de caracteres.

email_contacto VARCHAR(100): Almacena el correo electrónico de contacto de la marca o proveedor. Puede utilizarse para comunicarse con la empresa cuando sea necesario realizar consultas o solicitar productos.

estado BOOLEAN DEFAULT TRUE: Indica si la marca se encuentra activa dentro del catálogo. BOOLEAN permite manejar dos valores: TRUE o FALSE. DEFAULT TRUE significa que una marca nueva se registra inicialmente como activa.

Esto permite, por ejemplo, desactivar una marca sin necesidad de eliminarla de la base de datos y perder la información relacionada con sus perfumes.
===============================================================================================================================================================================================================================
2. Tabla perfume (Productos de la perfumería)

Registra todos los perfumes disponibles en la perfumería y almacena sus características principales.

id_perfume SERIAL PRIMARY KEY: Es el identificador único de cada perfume. SERIAL genera automáticamente un número para cada nuevo producto registrado.

id_marca INT REFERENCES marca(id_marca): Es una Clave Foránea (FK) que conecta cada perfume con la marca a la que pertenece.

Por ejemplo, el perfume "Fahrenheit" está relacionado con la marca "Dior". De esta manera, no es necesario escribir todos los datos de la marca nuevamente en cada perfume.

nombre VARCHAR(100) NOT NULL: Guarda el nombre del perfume. NOT NULL garantiza que ningún perfume pueda registrarse sin nombre.

genero VARCHAR(20): Indica el público o género al que está dirigido el perfume. Puede almacenar valores como Masculino, Femenino o Unisex.

concentracion VARCHAR(30): Indica el tipo de concentración del perfume, por ejemplo, Eau de Toilette, Eau de Parfum o Parfum.

mililitros INT NOT NULL: Almacena la capacidad del frasco en mililitros. Por ejemplo, 50 ml, 90 ml o 100 ml. NOT NULL obliga a registrar este dato porque es una característica importante del producto.

precio DECIMAL(10, 2) NOT NULL: Guarda el precio de venta del perfume. DECIMAL(10, 2) es apropiado para valores monetarios porque permite almacenar hasta 10 dígitos en total, incluyendo 2 decimales, evitando problemas de redondeo propios de los números flotantes.

stock INT NOT NULL DEFAULT 0: Indica cuántas unidades disponibles existen actualmente de cada perfume. DEFAULT 0 significa que, si no se especifica una cantidad, el producto comienza con stock cero.

Este campo es fundamental para solucionar el problema de falta de control del inventario.
========================================================================================================================================================================================================================================
3. Tabla cliente (Personas que realizan las compras)

Guarda los datos personales y de contacto de los clientes de la perfumería.

id_cliente SERIAL PRIMARY KEY: Es el identificador único de cada cliente. SERIAL genera automáticamente un número entero para cada nuevo cliente.

nombre VARCHAR(100) NOT NULL: Guarda el nombre del cliente. NOT NULL garantiza que este dato siempre sea registrado.

apellido VARCHAR(100): Almacena el apellido del cliente. Es opcional porque el sistema permite registrar el nombre aunque todavía no se haya proporcionado el apellido.

dni_ruc VARCHAR(20) UNIQUE: Guarda el DNI o RUC del cliente. Se utiliza VARCHAR porque estos documentos se manejan como texto y pueden tener diferentes formatos. UNIQUE evita que dos clientes tengan registrado el mismo DNI o RUC.

telefono VARCHAR(20): Guarda el número de teléfono del cliente. Se utiliza VARCHAR en lugar de INT porque un número telefónico puede contener el signo +, guiones, espacios o ceros al inicio.

email VARCHAR(100): Almacena el correo electrónico del cliente. Es útil para mantener sus datos de contacto y facilitar futuras comunicaciones.

direccion TEXT: Permite registrar la dirección completa del cliente. Se utiliza TEXT porque no establece un límite fijo de caracteres y permite almacenar direcciones de diferentes tamaños.
==============================================================================================================================================================================================================================
4. Tabla venta (Registro de las ventas)

Esta es una de las tablas centrales del sistema. Registra cada venta realizada en la perfumería y la relaciona con el cliente que realizó la compra.

id_venta SERIAL PRIMARY KEY: Es el identificador único de cada venta. Cada vez que se registra una nueva venta, se genera automáticamente un nuevo número de venta.

id_cliente INT REFERENCES cliente(id_cliente): Es una Clave Foránea que relaciona la venta con el cliente que realizó la compra.

Esto permite conocer qué cliente realizó cada venta y posteriormente consultar su historial de compras.

fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP: Guarda la fecha y hora en que se realizó la venta. DEFAULT CURRENT_TIMESTAMP obtiene automáticamente la fecha y hora actual del sistema cuando se registra una nueva venta.

metodo_pago VARCHAR(30) DEFAULT 'efectivo': Indica cómo pagó el cliente. Puede almacenar métodos como efectivo, tarjeta, yape o plin.

DEFAULT 'efectivo' significa que si no se especifica un método de pago, el sistema utilizará efectivo como valor predeterminado.

tipo_comprobante VARCHAR(20) DEFAULT 'boleta': Indica el tipo de comprobante generado por la venta, por ejemplo, boleta o factura.

El valor predeterminado es boleta.

monto_total DECIMAL(10, 2) DEFAULT 0.00: Guarda el monto total de la venta. Se utiliza DECIMAL(10, 2) porque se trata de un valor monetario y se necesita precisión en los decimales.

estado_venta VARCHAR(20) DEFAULT 'completada': Indica el estado actual de la venta. Por ejemplo, puede utilizarse completada, pendiente, cancelada, etc.

DEFAULT 'completada' significa que una venta nueva se registra inicialmente como completada.

Esta tabla permite solucionar el problema de tener las ventas desorganizadas, ya que centraliza la información principal de cada operación.
================================================================================================================================================================================================================================
5. Tabla detalle_venta (Productos incluidos en cada venta)

Esta tabla registra los perfumes específicos que forman parte de cada venta.

Una venta puede contener varios perfumes y un mismo perfume puede venderse en muchas ventas diferentes. Por esta razón, existe una relación de Muchos a Muchos (N:M) entre venta y perfume.

Para resolver esta relación se utiliza la tabla intermedia detalle_venta.

id_detalle SERIAL PRIMARY KEY: Es el identificador único de cada detalle de venta.

id_venta INT REFERENCES venta(id_venta) ON DELETE CASCADE: Indica a qué venta pertenece el detalle.

ON DELETE CASCADE significa que si una venta es eliminada, automáticamente se eliminarán los detalles asociados a esa venta. Esto evita que queden registros de productos pertenecientes a una venta que ya no existe.

id_perfume INT REFERENCES perfume(id_perfume): Indica qué perfume fue vendido.

Por ejemplo, permite registrar que en la venta número 1 se vendió el perfume "Fahrenheit".

cantidad INT NOT NULL CHECK (cantidad > 0): Indica cuántas unidades del perfume se vendieron.

NOT NULL obliga a registrar una cantidad y CHECK (cantidad > 0) garantiza que no se puedan registrar cantidades iguales o menores que cero.

precio_unitario DECIMAL(10, 2) NOT NULL: Guarda el precio del perfume en el momento de realizar la venta.

Es importante almacenar este precio porque el precio actual del catálogo puede cambiar posteriormente, pero el historial de la venta debe conservar el precio que realmente pagó el cliente.

descuento DECIMAL(10, 2) DEFAULT 0.00: Guarda el descuento aplicado al producto.

DEFAULT 0.00 significa que si no se aplica ningún descuento, el sistema registra automáticamente cero.

subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (cantidad * precio_unitario - descuento) STORED: Calcula automáticamente el subtotal correspondiente al producto vendido.

La fórmula utilizada es:

Subtotal = Cantidad × Precio unitario − Descuento

Por ejemplo, si un cliente compra 2 perfumes de S/ 480 cada uno y tiene un descuento de S/ 50:

2 × 480 − 50 = S/ 910

La palabra GENERATED ALWAYS hace que PostgreSQL calcule automáticamente este valor, evitando tener que introducirlo manualmente.
========================================================================================================================================================================================================
6. Tabla recepcion_carga (Recepción de mercadería)

Registra la entrada de nuevos productos a la perfumería. Permite llevar un control de los productos recibidos, sus lotes, cantidades y fechas.

id_recepcion SERIAL PRIMARY KEY: Es el identificador único de cada recepción de mercadería. SERIAL genera automáticamente un número para cada registro.

id_perfume INT NOT NULL REFERENCES perfume(id_perfume): Es una Clave Foránea que indica qué perfume fue recibido.

De esta manera, la recepción queda relacionada directamente con el producto correspondiente.

numero_lote VARCHAR(30) NOT NULL: Guarda el número o código del lote recibido.

El lote permite identificar un grupo específico de productos que llegaron juntos desde el proveedor.

cantidad_recibida INT NOT NULL: Indica la cantidad de unidades recibidas en esa carga.

Por ejemplo, si llegaron 50 unidades de un perfume, este campo tendrá el valor 50.

fecha_recepcion DATE NOT NULL: Registra la fecha en la que se recibió la mercadería.

Se utiliza DATE porque solo necesitamos almacenar el año, mes y día.

Esta tabla ayuda a solucionar el problema del control de inventario porque permite conocer cuándo ingresaron productos y en qué cantidad.
==========================================================================================================================================================================================
7. Tabla pedido_envio (Pedidos y entregas a clientes)

Registra la información relacionada con el envío de las ventas que deben ser entregadas a los clientes.

id_pedido SERIAL PRIMARY KEY: Es el identificador único de cada pedido de envío. SERIAL genera automáticamente un número para cada pedido.

id_venta INT NOT NULL REFERENCES venta(id_venta): Es una Clave Foránea que relaciona el pedido de envío con la venta correspondiente.

Esto permite saber qué venta debe ser enviada al cliente.

fecha_pedido DATE NOT NULL: Guarda la fecha en la que se generó el pedido de envío.

fecha_entrega DATE: Registra la fecha en la que el pedido fue entregado al cliente.

Este campo puede quedar vacío (NULL) cuando el pedido todavía no ha sido entregado.

estado_envio VARCHAR(20) NOT NULL: Indica la situación actual del pedido.

En el proyecto se utilizan estados como:

ENTREGADO
EN TRANSITO
PENDIENTE

Esto permite al área de logística saber qué pedidos ya fueron entregados y cuáles todavía necesitan atención.

Relación general de las tablas

El funcionamiento de la base de datos de ODA Perfumería puede representarse de la siguiente manera:

MARCA → PERFUME

Una marca puede tener varios perfumes, mientras que cada perfume pertenece a una marca.

CLIENTE → VENTA

Un cliente puede realizar muchas ventas, mientras que cada venta está relacionada con un cliente.

VENTA → DETALLE_VENTA ← PERFUME

Una venta puede contener varios perfumes y un perfume puede aparecer en muchas ventas. Por eso detalle_venta funciona como tabla intermedia para resolver la relación Muchos a Muchos (N:M).

PERFUME → RECEPCION_CARGA

Un perfume puede aparecer en diferentes recepciones de mercadería, permitiendo controlar las entradas de productos y sus respectivos lotes.

VENTA → PEDIDO_ENVIO

Una venta puede estar relacionada con un pedido de envío, permitiendo controlar la entrega del producto al cliente.

Resumen de la utilidad de la base de datos

La base de datos desarrollada para ODA Perfumería permite centralizar y organizar toda la información relacionada con el negocio.

marca permite administrar las marcas comercializadas.
perfume permite controlar los productos, precios y stock.
cliente permite almacenar los datos de los compradores.
venta registra las operaciones realizadas.
detalle_venta registra los perfumes, cantidades, precios y descuentos de cada venta.
recepcion_carga controla la entrada de mercadería y los números de lote.
pedido_envio permite controlar los pedidos que deben ser entregados.

De esta manera, el sistema ayuda a resolver los principales problemas de la perfumería: controlar el inventario, organizar las ventas y clientes, y administrar correctamente la recepción y entrega de los productos.
