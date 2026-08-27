1. Uso de consultas SQL para la obtención y análisis de información

Se decidió utilizar consultas SQL para facilitar la obtención, organización y análisis de la información almacenada en la base de datos. Mediante consultas y funciones como JOIN, SUM y GROUP BY, es posible obtener datos relevantes como el total recaudado por los pagos, la cantidad de reservas realizadas por cada cancha, los clientes que realizaron reservas y los horarios más utilizados.

Esta decisión permite acceder a la información de manera rápida y ordenada, facilitando la generación de reportes y apoyando una mejor toma de decisiones en la gestión del alquiler de las canchas.

2. Mantener la integridad de los datos mediante claves primarias y foráneas

Se decidió establecer relaciones entre las tablas utilizando claves primarias y claves foráneas. Esto permite conectar correctamente la información entre las entidades cliente, cancha, horario, reserva y pago.

Por ejemplo, una reserva solo puede estar asociada a un cliente, una cancha y un horario que existan previamente en la base de datos. Asimismo, un pago debe estar relacionado con una reserva válida. Esta decisión evita registros incorrectos o inconsistentes, mantiene la integridad de la información y facilita la consulta de datos relacionados mediante sentencias JOIN.

3. Evitar la duplicidad de reservas

Se decidió implementar restricciones (CONSTRAINT) para evitar que una misma cancha sea reservada más de una vez en la misma fecha y horario. De esta manera, se reduce el riesgo de duplicidad o conflictos en las reservas.

Esta restricción garantiza una mejor organización del sistema y evita que dos clientes puedan alquilar la misma cancha en el mismo horario.

4. Separar la información en tablas relacionadas

Se decidió organizar la base de datos en tablas independientes para clientes, canchas, horarios, reservas y pagos. Esta estructura permite evitar la duplicación innecesaria de información y facilita el mantenimiento de los datos.

Por ejemplo, la información de un cliente se registra una sola vez en la tabla cliente y posteriormente puede relacionarse con varias reservas. De igual manera, cada cancha y horario se registran de forma independiente, permitiendo reutilizar esta información en diferentes operaciones.

Esta organización mejora la eficiencia, consistencia y escalabilidad de la base de datos.

Estas cuatro decisiones quedarían muy bien como parte de la sección “Toma de decisiones del diseño de la base de datos” en tu proyecto. Puedo también 
redactarte la justificación completa del diagrama entidad-relación con un estilo más académico para tu informe.
