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

**(pendiente)** Este endpoint no existe todavía en `ApoderadoController` — hoy solo expone `GET /api/apoderados` y `GET /api/apoderados/{id}` (este último devuelve un `Apoderado` de prueba hardcodeado, no consulta la BD).

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
Los nombres de campo corresponden 1:1 a las columnas reales de `tratamiento`, `consulta` y `veterinario` en `codigo.sql`.

### 4. Flujo
1. **Endpoint**: `GET /api/apoderados/5/tratamientos`.
2. **Controller** (`ApoderadoController`): recibe `id` por `@PathVariable`, lo pasa al service, devuelve JSON. *(agregar método nuevo; hoy no existe)*
3. **Service** (`TratamientoService`): pide los datos al repository y ordena por fecha descendente. *(hoy `TratamientoService.listar()` solo devuelve 3 tratamientos fijos sin relación con apoderados)*
4. **Repository** (`TratamientoRepository`): ejecuta el SQL contra PostgreSQL y mapea cada fila al DTO. **(no existe ninguna clase Repository en el proyecto — hay que crearla)**
5. **PostgreSQL**: resuelve el `JOIN` sobre `a_veterinaria` y regresa las filas; el resultado sube en cadena Repository → Service → Controller → JSON al cliente. **(no hay conexión a PostgreSQL configurada todavía, ver sección 6)**

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
Esta consulta ya está probada en `codigo.sql` (equivalente a "CONSULTA 02"), solo le falta el filtro `WHERE c.id_apoderado = ?` para parametrizarla por apoderado.

### 6. Datos de conexión requeridos (sin credenciales reales)
Ver sección compartida al final del documento.

---

## Necesidad 2 — angel gabriel amasifuen ruiz

> Nota: el equipo son 4 integrantes, no 3. `Integrantes.md` está desactualizado — lista a *Alex Jonas Gonzales Sangama*, pero Jonas fue reemplazado por Gabriel Amasifuen. Conviene actualizar `Integrantes.md` para reflejar la lista actual del equipo (y de paso explica por qué "Gabriel Amasifuen" también aparece como apoderado de prueba en `codigo.sql`).

### 1. Necesidad
El administrador necesita saber **cuántas consultas ha atendido cada veterinario**, incluyendo a los que tienen cero, para repartir la carga de trabajo de forma equitativa entre el personal médico.

### 2. Endpoint
```
GET /api/veterinarios/consultas-atendidas
```
Respuesta: `200 OK` con un arreglo JSON, uno por veterinario, ordenado de mayor a menor.

**(pendiente)** No existe ningún `VeterinarioController` ni `VeterinarioService` en el proyecto todavía — ni siquiera hay un modelo `Veterinario.java`. Hay que crear las tres piezas desde cero.

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
2. **Controller** (`VeterinarioController`, nuevo): expone el endpoint y delega al service. **(no existe, crear desde cero)**
3. **Service** (`VeterinarioService`): pide el conteo al repository, sin lógica adicional de negocio (es un reporte directo). **(no existe, crear desde cero)**
4. **Repository** (`VeterinarioRepository`): ejecuta el `LEFT JOIN` con `COUNT()` y `GROUP BY` contra PostgreSQL, mapea cada fila al DTO. **(no existe, crear desde cero)**
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
Esta consulta es exactamente la "CONSULTA 03" ya validada en `codigo.sql`, incluida la fila de prueba del Dr. Mario Vega con 0 consultas.

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

**(pendiente)** Endpoint nuevo; hoy `ApoderadoController` solo tiene `listar()` y `buscarPorId()`.

### 3. Modelo
El modelo `Apoderado` real (`Apoderado.java`) tiene los campos `id`, `nombre`, `telefono` **y `direccion`** — pero la tabla `apoderado` en `codigo.sql` **no tiene columna `direccion`** (solo `id_apoderado`, `telefono`, `nombre`). Para esta consulta se puede reutilizar el modelo sin problema porque no se necesita `direccion`, pero conviene decidir si ese campo se agrega a la tabla o se elimina del modelo Java, porque ahora mismo están desalineados (el endpoint de prueba actual incluso devuelve `"Dirección Prueba"` como dato fijo).

### 4. Flujo
1. **Endpoint**: `GET /api/apoderados/sin-consultas`.
2. **Controller** (`ApoderadoController`): agrega este método junto al `listar()` ya existente, delega al service.
3. **Service** (`ApoderadoService`): pide la lista filtrada al repository (sin transformar datos, es un filtro directo). *(hoy `ApoderadoService.listar()` devuelve 3 apoderados fijos, no consulta la BD)*
4. **Repository** (`ApoderadoRepository`): ejecuta el `LEFT JOIN ... WHERE ... IS NULL` contra PostgreSQL y mapea las filas a `Apoderado`. **(no existe ninguna clase Repository en el proyecto — hay que crearla)**
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
Esta consulta es exactamente la "CONSULTA 01" ya validada en `codigo.sql`, donde el apoderado de prueba "Mateo Paredes" queda sin consultas a propósito para verificar el `LEFT JOIN`.

### 6. Datos de conexión requeridos (sin credenciales reales)
Ver sección compartida al final del documento.

---

## Datos de conexión (compartidos por las 3 necesidades, sin credenciales reales)

**Estado actual:** `application.properties` hoy solo contiene:
```properties
spring.application.name=vet
```
No hay ninguna configuración de datasource. Además, `pom.xml` solo declara `spring-boot-starter-webmvc` — falta agregar el driver de PostgreSQL y Spring Data (JPA o JDBC) antes de que cualquier Repository pueda funcionar. Faltaría agregar algo como:

```xml
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <scope>runtime</scope>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
    <!-- o spring-boot-starter-jdbc si se prefiere JDBC plano -->
</dependency>
```

Y en `application.properties`, una vez agregadas esas dependencias:

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
- **Schema**: `a_veterinaria` (ya definido con `CREATE SCHEMA` en `codigo.sql`, ejecutado y con datos de prueba cargados: 8 apoderados, 12 mascotas, 5 veterinarios, 28 consultas, 28 tratamientos).
- **Usuario/contraseña**: los del rol de PostgreSQL con permisos sobre esa base — nunca se escriben en el archivo que se sube al repo (van en variables de entorno o `application-local.properties` ignorado por git).

---
