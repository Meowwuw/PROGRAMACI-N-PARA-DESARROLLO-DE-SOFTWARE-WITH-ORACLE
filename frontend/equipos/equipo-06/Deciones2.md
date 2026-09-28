# Decisiones2.md — Grupo 6

## 1. Necesidades

- **Reserva directa de cancha** — Un cliente registrado desea seleccionar una cancha sintética, elegir la fecha y el horario en el que quiere jugar, y registrar la reserva en el sistema.
- **Maximización de la ocupación** — Saber cuándo está ocupada y cuándo libre: se necesita un horario claro para que no jueguen dos grupos al mismo tiempo ni se quede vacía mucho tiempo sin generar ingresos.
- **Cancelación de una reserva** — Un cliente que ya tiene una cancha alquilada necesita cancelar su reserva programada debido a un inconveniente, liberando el horario para otros usuarios.
- **Registro de pago de alquiler** — El administrador de la cancha registra la confirmación del pago recibido de un cliente para cambiar el estado de la reserva de "Pendiente" a "Pagada".
- **Consulta de disponibilidad pública** — Un usuario visitante (no autenticado) desea ver el calendario y los horarios ocupados de una cancha antes de decidir registrarse o iniciar una reserva.

> Se desarrolla a continuación el flujo completo para la necesidad **"Reserva directa de cancha"**, por ser la operación central del sistema.

## 2. Endpoint

```java
@RestController
@RequestMapping("/api/v1/reservas")
public class ReservaController {

    private final ReservaService reservaService;

    public ReservaController(ReservaService reservaService) {
        this.reservaService = reservaService;
    }

    @PostMapping
    public ResponseEntity<ReservaResponse> crearReserva(@RequestBody @Valid ReservaRequest request) {
        ReservaResponse reserva = reservaService.crearReserva(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(reserva);
    }
}
```

Endpoints complementarios (para las otras necesidades del grupo):

```
GET    /api/v1/reservas/disponibilidad?canchaId={id}&fecha={fecha}    Consulta pública
PATCH  /api/v1/reservas/{id}/cancelar                                  Cancelación
PATCH  /api/v1/reservas/{id}/pago                                      Registro de pago
```

## 3. Modelo

**Entidad: `Reserva`**

| Campo         | Tipo        | Descripción                                        |
|---------------|-------------|------------------------------------------------------|
| id            | BIGSERIAL   | Identificador único (PK)                             |
| cancha_id     | INTEGER     | FK hacia tabla `canchas`                              |
| cliente_id    | INTEGER     | FK hacia tabla `usuarios` (cliente registrado)        |
| fecha         | DATE        | Fecha de la reserva                                   |
| hora_inicio   | TIME        | Hora de inicio del bloque reservado                   |
| hora_fin      | TIME        | Hora de fin del bloque reservado                      |
| estado        | VARCHAR(20) | PENDIENTE / PAGADA / CANCELADA                        |
| creado_en     | TIMESTAMP   | Fecha/hora de creación del registro                   |

**Entidad relacionada: `Cancha`**

| Campo   | Tipo        | Descripción                     |
|---------|-------------|-----------------------------------|
| id      | SERIAL      | Identificador único (PK)         |
| nombre  | VARCHAR(50) | Ej. "Cancha Sintética 1"          |
| tipo    | VARCHAR(30) | Ej. "Sintética", "Losa depostiva"    |
| activa  | BOOLEAN     | Si está disponible para reservar |

**DTO: `ReservaRequest`**

```java
public class ReservaRequest {
    private Integer canchaId;
    private Integer clienteId;
    private LocalDate fecha;
    private LocalTime horaInicio;
    private LocalTime horaFin;
    // getters y setters
}
```

## 4. Flujo

```
Cliente (app/web)
       POST /api/v1/reservas

Endpoint (@RestController)
       Recibe el JSON, valida formato con @Valid → ReservaRequest
     
Controller
       Delega la lógica de negocio al Service
     
Service
      1. Verifica que la cancha exista y esté activa
       2. Verifica disponibilidad (sin solapamiento de horario) → apoya la
          necesidad de "Maximización de la ocupación"
       3. Construye la entidad Reserva con estado inicial "PENDIENTE"
     
Repository
       Ejecuta el SELECT de disponibilidad y el INSERT de la nueva reserva
     
PostgreSQL
       Persiste el registro en la tabla "reservas"
     
Repository  Service  Controller  Endpoint
       Devuelve la reserva creada (con su id y estado) como JSON
     
Cliente recibe 201 Created con el detalle de la reserva
```

## 5. SQL necesario

**Creación de tablas:**

```sql
CREATE TABLE canchas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    activa BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE reservas (
    id BIGSERIAL PRIMARY KEY,
    cancha_id INTEGER NOT NULL REFERENCES canchas(id),
    cliente_id INTEGER NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    creado_en TIMESTAMP NOT NULL DEFAULT NOW()
);
```

**Verificar disponibilidad :**

```sql
SELECT id
FROM reservas
WHERE cancha_id = :cancha_id
  AND fecha = :fecha
  AND estado <> 'CANCELADA'
  AND (hora_inicio < :hora_fin AND hora_fin > :hora_inicio);
```

**Insertar nueva reserva:**

```sql
INSERT INTO reservas (cancha_id, cliente_id, fecha, hora_inicio, hora_fin, estado)
VALUES (:cancha_id, :cliente_id, :fecha, :hora_inicio, :hora_fin, 'PENDIENTE')
RETURNING id, estado, creado_en;
```

**Actualizar estado (cancelación / pago):**

```sql
UPDATE reservas SET estado = 'CANCELADA' WHERE id = :id;
UPDATE reservas SET estado = 'PAGADA'    WHERE id = :id;
```

## 6. Datos de conexión requeridos (sin credenciales reales)

```properties
DB_HOST=localhost
DB_PORT=5432
DB_NAME=alquiler_de_cancha
DB_USER=<usuario_de_aplicacion>
DB_PASSWORD=<password_gestionado_por_variable_de_entorno>
DB_DIALECT=postgresql
DB_POOL_MIN=2
DB_POOL_MAX=10
```
