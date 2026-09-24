# Backend Veterinaria - Spring Boot

Backend REST generado a partir del diagrama ER de tu base de datos en DBeaver/Neon
(servicios, mascotas, razas, especies, detalle_consulta_servicio, consultas, veterinarios, duenos).

## Estructura

```
src/main/java/com/Vet/backend/
 ├─ config/      -> CorsConfig (permite llamadas desde el frontend)
 ├─ model/       -> Entidades JPA (una por tabla)
 ├─ repository/  -> Interfaces JpaRepository
 ├─ service/     -> Lógica de negocio / acceso a los repositorios
 └─ controller/  -> Endpoints REST (@RestController)
```

## Antes de correrlo

1. Abre `src/main/resources/application.properties` y reemplaza:
   - `TU_HOST_NEON`
   - `TU_BASE_DE_DATOS`
   - `TU_USUARIO`
   - `TU_PASSWORD`

   Esos datos los sacas de Neon: Dashboard del proyecto > "Connection Details".

2. `spring.jpa.hibernate.ddl-auto=validate` está puesto a propósito, porque tu BD
   ya existe en Neon con las 8 tablas. Así Hibernate solo valida que las entidades
   coincidan con las tablas reales y NO intenta crear/alterar nada.
   - Si el nombre de tus columnas en Neon no coincide exactamente con lo que
     puse en las entidades (por ejemplo si usas camelCase en vez de snake_case),
     ajusta los `@Column(name = "...")`.

3. Importa el proyecto en IntelliJ como proyecto Maven (File > Open > selecciona
   la carpeta que contiene el `pom.xml`). IntelliJ descargará las dependencias
   automáticamente.

## Cómo correrlo

- Ejecuta la clase `BackendApplication.java` (botón ▶ en IntelliJ), o desde terminal:
  ```
  mvn spring-boot:run
  ```
- El backend queda escuchando en `http://localhost:8080`.

## Endpoints disponibles

Cada tabla tiene su CRUD (GET listar, GET por id, POST crear, PUT actualizar, DELETE eliminar):

- `/api/especies`
- `/api/razas`  (+ `/api/razas/especie/{idEspecie}`)
- `/api/duenos`
- `/api/veterinarios`
- `/api/servicios`
- `/api/mascotas`  (+ `/api/mascotas/dueno/{idDueno}`)
- `/api/consultas`  (+ `/api/consultas/mascota/{idMascota}`, `/api/consultas/veterinario/{idVeterinario}`)
- `/api/detalle-consulta-servicio`  (+ `/api/detalle-consulta-servicio/consulta/{idConsulta}`)

## Notas sobre las relaciones

Los `@ManyToOne` reflejan las relaciones del diagrama:
- `mascotas.id_dueno -> duenos`
- `mascotas.id_raza -> razas`
- `razas.id_especie -> especies`
- `consultas.id_mascota -> mascotas`
- `consultas.id_veterinario -> veterinarios`
- `detalle_consulta_servicio.id_consulta -> consultas`
- `detalle_consulta_servicio.id_servicio -> servicios`

No agregué las listas inversas (`@OneToMany`) a propósito, para evitar bucles
infinitos al serializar a JSON. Si necesitas, por ejemplo, traer las mascotas
de un dueño, usa el endpoint `/api/mascotas/dueno/{idDueno}` en vez de esperar
que venga anidado dentro del dueño.

## Cosas que quizá quieras ajustar tú

- Validaciones (`@NotNull`, `@Size`, etc.) — dejé el `spring-boot-starter-validation`
  en el pom por si quieres añadirlas en las entidades o en DTOs.
- DTOs separados de las entidades (por ahora los controllers devuelven las
  entidades directamente, que es lo más común en un ejercicio de clase).
- Manejo global de excepciones (`@ControllerAdvice`) si quieres respuestas de
  error más uniformes.
