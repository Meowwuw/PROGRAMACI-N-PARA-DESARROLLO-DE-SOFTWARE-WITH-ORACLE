### Actividad por equipos: recorrido de los datos

Equipo 2 — se definieron **3 necesidades reales**, una por integrante, cada una con su propio recorrido Endpoint → Controller → Service → Repository → PostgreSQL.

---

## Necesidad 1 — Harim Jander Saavedra Hidalgo

### 1. Necesidad
Antes de atender a un cliente, el veterinario necesita revisar **el historial de tratamientos que ha recibido ese apoderado** (fechas, tipo de tratamiento y quién lo atendió), para no repetir procedimientos ni indicar algo incompatible con lo ya realizado.

### 2. Endpoint
```
GET /api/apoderados/{id}/tratamientos
```
`{id}` = `id_apoderado`. Respuesta: `200 OK` con arreglo JSON, o `404` si el apoderado no existe.

### 3. Modelo
DTO (combina 3 tablas, no es una entidad directa):
```java
public class HistorialTratamientoDTO {
    private Long idTratamiento;
    private String tipoTratamiento;
    private LocalDate fechaIni;
    private LocalDate fechaFin;
    private LocalDateTime fechaConsulta;
    private String veterinario;
    private String especialidad;
    // constructor, getters y setters
}
```

### 4. Flujo
1. **Endpoint**: `GET /api/apoderados/5/tratamientos`.
2. **Controller** (`ApoderadoController`): recibe `id` por `@PathVariable`, lo pasa al service, devuelve JSON.
3. **Service** (`TratamientoService`): pide los datos al repository y ordena por fecha descendente.
4. **Repository** (`TratamientoRepository`): ejecuta el SQL contra PostgreSQL y mapea cada fila al DTO.
5. **PostgreSQL**: resuelve el `JOIN` sobre `a_veterinaria` y regresa las filas; el resultado sube en cadena Repository → Service → Controller → JSON al cliente.

### 5. SQL necesario
```sql
SET search_path TO a_veterinaria;

SELECT
    t.id_tratamiento, t.tipo_tratamiento, t.fecha_ini, t.fecha_fin,
    c.fecha_con, v.nombre AS veterinario, v.especialidad
FROM tratamiento t
INNER JOIN consulta c ON t.id_consulta = c.id_consulta
INNER JOIN veterinario v ON c.id_veterinario = v.id_veterinario
WHERE c.id_apoderado = ?
ORDER BY c.fecha_con DESC;
```
(Basado en la "CONSULTA 02" ya validada en `codigo.sql`, agregando el filtro por apoderado.)

### 6. Datos de conexión requeridos (sin credenciales reales)
Ver sección compartida al final del documento.

---

## Necesidad 2 — Alex Jonas Gonzales Sangama

### 1. Necesidad
El administrador necesita saber **cuántas consultas ha atendido cada veterinario**, incluyendo a los que tienen cero, para repartir la carga de trabajo de forma equitativa entre el personal médico.

### 2. Endpoint
```
GET /api/veterinarios/consultas-atendidas
```
Respuesta: `200 OK` con un arreglo JSON, uno por veterinario, ordenado de mayor a menor.

### 3. Modelo
DTO:
```java
public class ConteoConsultasDTO {
    private Long idVeterinario;
    private String nombre;
    private String especialidad;
    private Long totalConsultasAtendidas;
    // constructor, getters y setters
}
```

### 4. Flujo
1. **Endpoint**: `GET /api/veterinarios/consultas-atendidas`.
2. **Controller** (`VeterinarioController`, nuevo): expone el endpoint y delega al service.
3. **Service** (`VeterinarioService`): pide el conteo al repository, sin lógica adicional de negocio (es un reporte directo).
4. **Repository** (`VeterinarioRepository`): ejecuta el `LEFT JOIN` con `COUNT()` y `GROUP BY` contra PostgreSQL, mapea cada fila al DTO.
5. **PostgreSQL**: agrupa las consultas por veterinario (incluyendo los que no tienen ninguna, gracias al `LEFT JOIN`) y regresa el conteo; sube en cadena hasta el Controller como JSON.

### 5. SQL necesario
```sql
SET search_path TO a_veterinaria;

SELECT
    v.id_veterinario, v.nombre AS veterinario, v.especialidad,
    COUNT(c.id_consulta) AS total_consultas_atendidas
FROM veterinario v
LEFT JOIN consulta c ON v.id_veterinario = c.id_veterinario
GROUP BY v.id_veterinario, v.nombre, v.especialidad
ORDER BY total_consultas_atendidas DESC;
```
(Es la "CONSULTA 03" ya validada en `codigo.sql`, tal cual — no necesita parámetro.)

### 6. Datos de conexión requeridos (sin credenciales reales)
Ver sección compartida al final del documento.

---

## Necesidad 3 — Angel Martin Pinedo Saavedra

### 1. Necesidad
El equipo de marketing/seguimiento necesita identificar **qué apoderados están registrados pero nunca han traído a su mascota a consulta**, para contactarlos con una campaña de recordatorio.

### 2. Endpoint
```
GET /api/apoderados/sin-consultas
```
Respuesta: `200 OK` con un arreglo JSON de apoderados sin ninguna consulta registrada.

### 3. Modelo
Puede reutilizar el modelo `Apoderado` existente (`id`, `nombre`, `telefono`), sin necesidad de un DTO nuevo, ya que no combina campos de otras tablas.

### 4. Flujo
1. **Endpoint**: `GET /api/apoderados/sin-consultas`.
2. **Controller** (`ApoderadoController`): agrega este método junto al `listar()` ya existente, delega al service.
3. **Service** (`ApoderadoService`): pide la lista filtrada al repository (sin transformar datos, es un filtro directo).
4. **Repository** (`ApoderadoRepository`): ejecuta el `LEFT JOIN ... WHERE ... IS NULL` contra PostgreSQL y mapea las filas a `Apoderado`.
5. **PostgreSQL**: cruza `apoderado` con `consulta` y descarta los que sí tienen coincidencia; el resultado sube Repository → Service → Controller → JSON al cliente.

### 5. SQL necesario
```sql
SET search_path TO a_veterinaria;

SELECT a.id_apoderado, a.nombre AS apoderado, a.telefono
FROM apoderado a
LEFT JOIN consulta c ON a.id_apoderado = c.id_apoderado
WHERE c.id_consulta IS NULL
ORDER BY a.nombre;
```
(Es la "CONSULTA 01" ya validada en `codigo.sql`, tal cual.)

### 6. Datos de conexión requeridos (sin credenciales reales)
Ver sección compartida al final del documento.

---

## Datos de conexión (compartidos por las 3 necesidades, sin credenciales reales)

En `application.properties` del backend (Spring Boot):

```properties
spring.datasource.url=jdbc:postgresql://<HOST>:5432/<NOMBRE_BD>
spring.datasource.username=<USUARIO>
spring.datasource.password=<CONTRASEÑA>
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.properties.hibernate.default_schema=a_veterinaria
spring.jpa.hibernate.ddl-auto=none
```

- **HOST**: dirección del servidor PostgreSQL (localhost si es local, o la IP/host del servidor del equipo).
- **Puerto**: `5432` (puerto por defecto de PostgreSQL).
- **NOMBRE_BD**: nombre de la base de datos donde se creó el schema `a_veterinaria`.
- **Schema**: `a_veterinaria` (ya definido con `CREATE SCHEMA` en `codigo.sql`).
- **Usuario/contraseña**: los del rol de PostgreSQL con permisos sobre esa base — nunca se escriben en el archivo que se sube al repo (van en variables de entorno o `application-local.properties` ignorado por git).

---

*Nota de equipo:* los modelos `Mascota.java`, `Consulta.java` y `Tratamiento.java` que ya están en el repo (con campos como `especie`, `edad`, `motivo`, `diagnostico`, `costo`) **no coinciden** con las columnas reales de `codigo.sql` (`raza`, `peso`, `genero`, `fecha_con`, `tipo_tratamiento`, etc.). Antes de implementar estos repositorios de verdad, hay que alinear esos modelos a las columnas del script.
