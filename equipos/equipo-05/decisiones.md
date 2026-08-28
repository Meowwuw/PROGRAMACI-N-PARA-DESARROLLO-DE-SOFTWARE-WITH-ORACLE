Informe del Sistema de Reservas de Vóley Playa  

Esquema: voley_playa  

Fecha del informe: 28 de agosto de 2026  



1. Descripción general del sistema

Sistema de gestión de reservas para canchas de vóley playa.  

Horario de operación:** 16:00 a 21:00 (5 franjas de 1 hora).  

Precio fijo:** S/ 20.00 por hora.  

Estados de reserva:** RESERVADO, CANCELADO, FINALIZADO.  

Estados de pago:** PENDIENTE, PAGADO, DEVUELTO.  

Métodos de pago:** EFECTIVO, YAPE, PLIN, TARJETA.  



Características principales de integridad:

Unicidad de correo de cliente.

Restricción de precio fijo a S/ 20.00.

Restricción de horarios válidos (16:00–21:00).

Restricción de unicidad** que impide doble reserva de la misma cancha + fecha + horario.

Relación 1:1 entre reserva y pago.



2. Estructura de la base de datos



| Tabla   | Descripción             | Clave primaria | Relaciones principales         |

|-----------|--------------------------------------|----------------|-----------------------------------------|

| cliente  | Datos de los clientes        | id_cliente   | —                    |

| cancha  | Canchas disponibles         | id_cancha   | —                    |

| horario  | Franjas horarias           | id_horario   | —                    |

| reserva  | Reservas realizadas         | id_reserva   | FK → cliente, cancha, horario      |

| pago   | Pagos asociados a reservas      | id_pago    | FK → reserva (única)          |



3. Datos cargados (muestra)



Clientes (5)  

Ana Quispe, Luis Ramirez, Rosa Tello, Carlos Torres, Maria Flores.



Canchas (2)  

Cancha 1 – VOLEY PLAYA – S/ 20.00  

Cancha 2 – VOLEY PLAYA – S/ 20.00  



Horarios (5)  

16:00-17:00 · 17:00-18:00 · 18:00-19:00 · 19:00-20:00 · 20:00-21:00  



Reservas del día 2026-08-28 (5)  



| ID Reserva | Cliente     | Cancha  | Horario    | Estado   |

|------------|------------------|----------|---------------|------------|

| 1     | Ana Quispe    | Cancha 1 | 16:00-17:00  | RESERVADO |

| 2     | Luis Ramirez   | Cancha 2 | 16:00-17:00  | RESERVADO |

| 3     | Rosa Tello    | Cancha 1 | 17:00-18:00  | RESERVADO |

| 4     | Carlos Torres  | Cancha 2 | 18:00-19:00  | RESERVADO |

| 5     | Maria Flores   | Cancha 1 | 19:00-20:00  | RESERVADO |



Pagos  



| ID Reserva | Monto | Método  | Estado   |

|------------|--------|-----------|------------|

| 1     | 20.00 | YAPE   | PAGADO   |

| 2     | 20.00 | EFECTIVO | PAGADO   |

| 3     | 20.00 | PLIN   | PAGADO   |

| 4     | 20.00 | YAPE   | PAGADO   |

| 5     | 20.00 | EFECTIVO | PENDIENTE |



4. Resultados de las consultas principales



Consulta general (Cliente + Cancha + Horario + Reserva + Pago)  

Se obtiene el detalle completo de las 5 reservas del 28/08/2026 con sus respectivos datos de pago.



Horarios disponibles – Cancha 1 (28/08/2026)  

18:00-19:00  

20:00-21:00  



Todas las canchas disponibles (28/08/2026)  



| Cancha  | Horario    |

|----------|---------------|

| Cancha 1 | 18:00-19:00  |

| Cancha 2 | 17:00-18:00  |

| Cancha 1 | 20:00-21:00  |

| Cancha 2 | 19:00-20:00  |

| Cancha 2 | 20:00-21:00  |



Total recaudado (solo pagos PAGADO)  

S/ 80.00



Cantidad de reservas por cliente  

Todos los clientes tienen 1 reserva (ordenados por cantidad descendente, empate total).



5. Análisis y observaciones



Ocupación del día 28/08/2026: 5 reservas de un total posible de 10 (2 canchas × 5 horarios) → **50 % de ocupación.

Cancha más demandada**: Cancha 1 (3 reservas).

Horario más demandado**: 16:00-17:00 (ambas canchas ocupadas).

Situación de cobros**: 4 pagos confirmados (S/ 80) y 1 pendiente (reserva de Maria Flores).

La restricción UNIQUE (id_cancha, fecha, id_horario) funciona correctamente y evita sobre-reservas.

El sistema está listo para consultas de disponibilidad en tiempo real y reportes de recaudación.



6. Recomendaciones

Implementar un trigger o procedimiento que actualice automáticamente el estado de la reserva a FINALIZADO al terminar el horario.

Agregar una columna fecha_pago y fecha_creacion para mejor auditoría.

Crear una vista materializada o consulta frecuente para “disponibilidad del día” para mejorar el rendimiento.

Considerar permitir cancelaciones con reembolso automático (cambiar estado a CANCELADO + DEVUELTO).



Resumen ejecutivo  

El sistema se encuentra correctamente modelado, con datos de prueba consistentes y consultas funcionales. En el día de referencia se recaudaron S/ 80.00 de un potencial de S/ 100.00, con buena distribución de reservas y control de disponibilidad operativo.

Escribir mensaje

