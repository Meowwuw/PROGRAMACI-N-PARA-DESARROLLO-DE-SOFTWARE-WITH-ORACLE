# Decisiones de Diseño

Se separaron los datos del cliente en una tabla independiente llamada `cliente`, logrando que la tabla `reserva` solo almacene el `id_cliente` como clave foránea. Si estos datos se hubieran quedado en una sola tabla, se habría provocado una anomalía de actualización ante cualquier cambio de teléfono o correo. Con esta separación se cumple plenamente con la Tercera Forma Normal (**3FN**).

Para garantizar la **Segunda Forma Normal (2FN)**, los atributos que no son clave dentro de la tabla intermedia dependen completamente de la clave compuesta de la reserva, evitando dependencias parciales o datos repetidos.

Por otro lado, se optó por **no fusionar** las tablas `cancha`, `horario` y `reserva` en una tabla gigante, manteniendo la tabla intermedia `detalle_reserva`. Aunque se consideró agrupar todo para evitar consultas con `JOIN`, eso habría creado grupos repetitivos y violado la Primera Forma Normal (**1FN**), ya que una reserva puede involucrar múltiples turnos o canchas.
