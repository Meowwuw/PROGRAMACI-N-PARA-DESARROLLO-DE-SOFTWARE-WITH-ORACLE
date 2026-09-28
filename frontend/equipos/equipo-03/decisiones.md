Toma de decisiones del diseño de la base de datos
1. Uso de consultas SQL para la obtención y análisis de información
Se decidió utilizar consultas SQL para facilitar la obtención, organización y análisis de la información almacenada en las diferentes tablas de la base de datos. Para ello, se pueden emplear sentencias y funciones como JOIN, SUM, COUNT y GROUP BY, permitiendo relacionar y analizar los datos registrados.

Las principales tablas involucradas son cliente, cancha, horario, reserva y pago. Por ejemplo, mediante la relación entre las tablas reserva y pago se puede obtener el total recaudado por los alquileres. Asimismo, relacionando reserva con cancha se puede conocer la cantidad de reservas realizadas para cada cancha.

De igual manera, al relacionar las tablas reserva, cliente y horario, es posible identificar qué clientes realizaron reservas y cuáles son los horarios más utilizados.

Esta decisión permite acceder a la información de manera rápida, organizada y precisa, facilitando la generación de reportes y apoyando una mejor toma de decisiones en la gestión del alquiler de las canchas.

2. Mantener la integridad de los datos mediante claves primarias y foráneas
Se decidió establecer claves primarias (PK) y claves foráneas (FK) en las tablas para mantener la integridad y consistencia de la información.

La base de datos está compuesta por las siguientes tablas:

cliente: almacena la información de los clientes, como id, telefono, nombre y apellido.
cancha: contiene la información de las canchas disponibles, como id y numero_cancha.
horario: registra los horarios y precios disponibles mediante los campos id, hora y precio.
reserva: almacena las reservas realizadas y relaciona al cliente, la cancha y el horario mediante id_cliente, id_cancha e id_horario. También contiene información como horas_alquilado y fecha.
pago: registra los pagos asociados a una reserva mediante id_reserva, además del total pagado.
Por ejemplo, el campo id_cliente de la tabla reserva funciona como clave foránea que referencia al campo id de la tabla cliente. De la misma manera, id_cancha se relaciona con cancha, id_horario con horario y id_reserva de pago con la tabla reserva.

Esta estructura garantiza que una reserva solo pueda asociarse con un cliente, cancha y horario existentes, mientras que un pago debe estar relacionado con una reserva válida. De esta forma, se evitan registros inconsistentes y se facilita la utilización de consultas JOIN.

3. Evitar la duplicidad de reservas
Se decidió implementar restricciones (CONSTRAINT) en la tabla reserva para evitar que una misma cancha sea reservada más de una vez para la misma fecha y horario.

Para ello, se puede establecer una restricción de unicidad considerando los campos:

id_cancha + id_horario + fecha

De esta manera, el sistema impedirá que se registre una segunda reserva para la misma cancha, en el mismo horario y en la misma fecha.

Esta decisión es importante porque la tabla reserva es la encargada de relacionar las tablas cliente, cancha y horario. Al aplicar esta restricción, se evita que dos clientes puedan alquilar simultáneamente la misma cancha, reduciendo conflictos y mejorando la organización del sistema.

4. Separar la información en tablas relacionadas
Se decidió dividir la información en cinco tablas independientes: cliente, cancha, horario, reserva y pago, en lugar de almacenar todos los datos en una sola tabla.

La tabla cliente permite registrar una sola vez los datos personales de cada usuario, mientras que la tabla cancha mantiene la información de las canchas disponibles. Por otro lado, la tabla horario almacena los horarios y precios correspondientes.

La tabla reserva funciona como elemento central del sistema, ya que relaciona un cliente con una cancha y un horario determinado, además de registrar la fecha y las horas alquiladas.

Finalmente, la tabla pago permite almacenar los pagos correspondientes a cada reserva, manteniendo separada la información financiera de los datos propios de la reserva.

Esta distribución evita la duplicación innecesaria de información. Por ejemplo, los datos de un cliente no necesitan repetirse cada vez que realiza una reserva, ya que basta con almacenar su id_cliente en la tabla reserva.

En consecuencia, la separación de las tablas mejora la organización, consistencia, mantenimiento, eficiencia y escalabilidad de la base de datos.

Estructura general de las tablas
Tabla	Función principal	Relación
cliente	Almacena los datos de los clientes	Se relaciona con reserva
cancha	Registra las canchas disponibles	Se relaciona con reserva
horario	Almacena horarios y precios	Se relaciona con reserva
reserva	Registra el alquiler de una cancha	Relaciona cliente, cancha y horario
pago	Registra el pago de una reserva	Se relaciona con reserva

En conjunto, estas decisiones permiten que la base de datos tenga una estructura organizada y coherente, donde cada tabla cumple una función específica y las relaciones entre ellas permiten gestionar de manera eficiente el proceso de reserva y pago de las canchas.
