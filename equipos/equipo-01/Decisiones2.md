# Decisiones2

Equipo: Lozada Escobar Genesis Ximena / Angulo Nolorbe Edgar
---

## Integrante 1 — Genesis Ximena Lozada Escobar

### 1. Necesidad
Cuando un dueño llama a la clínica, la recepcionista necesita **ubicarlo por su número de teléfono** en vez de buscarlo por nombre (que puede repetirse o escribirse mal).

### 2. Endpoint
```
GET /api/duenos/telefono/{telefono}
```
Ejemplo: `GET /api/duenos/telefono/912345678`

### 3. Modelo
Se reutiliza el modelo `Dueno` que ya existe en el proyecto (`id_dueno`, `nombre`, `telefono`, `direccion`), sin campos nuevos.
package com.Vet.backend.model;

public class Dueno {
    private Long idDueno;
    private String nombre;
    private String telefono;
    private String direccion;
    
    public Dueno(){
    }
    public Dueno(Long idDueno, String nombre, String telefono, String direccion){
        this.idDueno = idDueno;
        this.nombre = nombre;
        this.telefono = telefono;
        this.direccion = direccion;
    }
    public Long getIdDueno(){
        return idDueno;
    }
    public String getNombre(){
        return nombre;
    }
    public String getTelefono(){
        return telefono;
    }
    public String getDireccion(){
        return direccion;
    }
}

### 4. Flujo
1. **Endpoint**: la recepcionista busca `GET /api/duenos/telefono/912345678`.
2. **Controller** (`DuenoController`): recibe el `telefono` como `@PathVariable` y llama a `duenoServices.buscarPorTelefono(telefono)`.
3. **Service** (`DuenoServices`): no necesita lógica extra aquí, solo delega al Repository.
4. **Repository** (`DuenoRepository`, aún no creado): ejecuta la consulta contra PostgreSQL y regresa el dueño encontrado.
5. **PostgreSQL**: busca en la tabla `duenos` la fila donde `telefono` coincida.
6. El resultado sube de vuelta: Repository → Service → Controller → respuesta JSON.

### 5. SQL necesario
```sql
SELECT * FROM duenos
WHERE telefono = ?;
```
- **Tabla involucrada**: `duenos` (una sola, no requiere JOIN).
- **Justificación**: es la misma consulta que ya está documentada en `consultas-proyecto.sql` (punto 1.2), solo que aquí se expone como endpoint parametrizado en vez de un valor fijo.

### 6. Datos de conexión requeridos
- **Driver**: `org.postgresql.Driver`
- **Host**: `<host-de-neon>` (placeholder)
- **Puerto**: `5432`
- **Base de datos**: `<nombre-de-la-bd>` (placeholder)
- **Usuario / Contraseña**: `<placeholder>` (sin credenciales reales)
- **SSL**: `sslmode=require` (obligatorio en Neon)

---

## Integrante 2 — Edgar Angulo Nolorbe

### 1. Necesidad
Cuando llega una mascota con un problema específico, la recepción necesita **saber qué veterinarios atienden esa especialidad** para asignar la cita con el médico correcto.

### 2. Endpoint
```
GET /api/veterinarios/especialidad/{especialidad}
```
Ejemplo: `GET /api/veterinarios/especialidad/Dermatología`

### 3. Modelo
Se reutiliza el modelo `Veterinario` que ya existe en el proyecto (`id_veterinario`, `nombre`, `especialidad`, `telefono`), sin campos nuevos.

package com.Vet.backend.model;

public class Veterinario {
    private Long idVeterinario;
    private String nombre;
    private String especialidad;
    private String telefono;

    public Veterinario(){
    }
    public Veterinario(Long idVeterinario, String nombre, String especialidad, String telefono){
        this.idVeterinario = idVeterinario;
        this.nombre = nombre;
        this.especialidad = especialidad;
        this.telefono = telefono;
    }
    public Long getIdVeterinario(){
        return idVeterinario;
    }
    public String getNombre(){
        return nombre;
    }
    public String getEspecialidad(){
        return especialidad;
    }
    public String getTelefono(){
        return telefono;
    }
}

### 4. Flujo
1. **Endpoint**: la recepción busca `GET /api/veterinarios/especialidad/Dermatología`.
2. **Controller** (`VeterinarioController`): recibe `especialidad` como `@PathVariable` y llama a `veterinarioServices.buscarPorEspecialidad(especialidad)`.
3. **Service** (`VeterinarioServices`): delega directamente al Repository, sin lógica adicional.
4. **Repository** (`VeterinarioRepository`, aún no creado): ejecuta la consulta contra PostgreSQL y regresa la lista de veterinarios.
5. **PostgreSQL**: filtra la tabla `veterinarios` por el valor exacto de `especialidad`.
6. El resultado sube de vuelta: Repository → Service → Controller → respuesta JSON con la lista.

### 5. SQL necesario
```sql
SELECT * FROM veterinarios
WHERE especialidad = ?;
```
- **Tabla involucrada**: `veterinarios` (una sola, no requiere JOIN).
- **Justificación**: reutiliza la misma lógica que la consulta 3.2 de `consultas-proyecto.sql` ("Buscar veterinarios con especialidad en 'Dermatología'"), pero parametrizada para que sirva con cualquier especialidad.

### 6. Datos de conexión requeridos
- **Driver**: `org.postgresql.Driver`
- **Host**: `<host-de-neon>` (placeholder)
- **Puerto**: `5432`
- **Base de datos**: `<nombre-de-la-bd>` (placeholder)
- **Usuario / Contraseña**: `<placeholder>` (sin credenciales reales)
- **SSL**: `sslmode=require` (obligatorio en Neon)
