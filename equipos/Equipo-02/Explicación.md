
### Problemática

En un centro veterinario con alta afluencia de clientes, administrar la información sin una estructura relacional adecuada genera severos problemas operativos:

* **Imposibilidad de registrar múltiples mascotas por cliente:** En un diseño deficiente donde la relación está invertida (o no existe), un apoderado no puede registrar a más de un paciente sin duplicar sus propios datos personales.
* **Falta de nombres y datos cuantitativos:** Registrar el peso como texto simple (e.g., `'28kg'`) impide realizar análisis numéricos, calcular dosis exactas de medicamentos o graficar el peso a lo largo del tiempo. Además, omitir el nombre de la mascota complica la atención al cliente.
* **Pérdida de trazabilidad médica:** No saber qué profesional atendió a qué mascota, bajo qué apoderado y qué tratamiento específico derivó de cada consulta genera desorganización e inconsistencia legal o médica.

---

### Solución

El script SQL presentado resuelve de forma óptima estas deficiencias mediante un **diseño relacional formal** basado en PostgreSQL:

* **Relación correcta 1 a N entre Apoderado y Mascota:** La tabla `mascota` ahora contiene la clave foránea `id_apoderado`. Esto permite que un solo dueño (como *Jander Hidalgo*) posea varias mascotas (*Rocky* y *Luna*) sin repetir información del apoderado.
* **Tipos de datos adecuados:** Se añade el campo `nombre` en `mascota` y se cambia la columna `peso` a `NUMERIC(5,2)`, permitiendo guardar valores exactos (e.g., `4.20`) listos para cálculos matemáticos.
* **Trazabilidad clínica integral:** La tabla `consulta` une al apoderado con el veterinario que lo atendió en una fecha/hora precisa (`TIMESTAMP`), mientras que `tratamiento` vincula el procedimiento directamente a la consulta correspondiente.

---

### Explicación del Código

El script sigue un flujo de ejecución estructurado para garantizar el control y la integridad de los datos:

1. **Creación del Esquema:** `CREATE SCHEMA IF NOT EXISTS a_veterinaria;` aisla el modelo de datos de otros proyectos en la base de datos.
2. **Definición de Tablas Principales:**
* `apoderado`: Almacena el contacto principal (nombre y teléfono).
* `mascota`: Depende directamente de `apoderado` a través de `id_apoderado`.
* `veterinario`: Registra al personal médico de forma independiente.


3. **Definición de Tablas Transaccionales:**
* `consulta`: Registra la atención conectando al apoderado y al veterinario mediante claves foráneas (`REFERENCES`).
* `tratamiento`: Registra los procedimientos asociados únicamente a una consulta específica mediante `id_consulta`.


4. **Validación y Consultas:** Inserta datos de prueba válidos y ejecuta un `LEFT JOIN` con `COUNT()` para verificar que la relación un apoderado $\rightarrow$ muchas mascotas funciona correctamente.

---

### Justificación en la Selección de Variables y Tipos de Datos

* `SERIAL`: Elegido para las claves primarias (`id_*`) porque genera autoincrementos automáticos de números enteros únicos, optimizando las búsquedas.
* `VARCHAR(n)`: Utilizado para texto de longitud variable (`nombre`, `raza`, `especialidad`, `telefono`). Garantiza espacio suficiente sin desperdiciar memoria en disco.
* `NUMERIC(5,2)`: Elegido para `peso` porque permite almacenar hasta 5 dígitos en total con 2 decimales (hasta 999.99 kg). Supera al uso de `VARCHAR` ya que habilita funciones de agregación como `AVG()`, `SUM()` o comparaciones numéricas (`peso > 15.0`).
* `TIMESTAMP` y `DATE`: Utilizados para `fecha_con` (requiere hora exacta) y `fecha_ini`/`fecha_fin` (solo requieren día/mes/año), optimizando el almacenamiento temporal.

---

### Cumplimiento de las Formas Normales (1FN, 2FN y 3FN)

El diseño cumple estrictamente con las **primeras tres formas normales (3FN)** de la teoría de bases de datos relacionales:

#### 1. Primera Forma Normal (1FN)

* **Atómicos:** Todos los valores en las celdas son indivisibles (un solo nombre, una sola raza, un solo teléfono por celda).
* **Sin grupos repetidos:** No existen columnas como `mascota1`, `mascota2`, sino que cada registro representa una única entidad.
* **Clave Primaria:** Todas las tablas poseen una clave primaria explícita (`PRIMARY KEY`).

#### 2. Segunda Forma Normal (2FN)

* **Cumple 1FN.**
* **Dependencia Funcional Total:** Todas las claves primarias son simples (de una sola columna, e.g., `id_mascota`). Por lo tanto, no existen dependencias parciales: todos los atributos que no son clave (`nombre`, `raza`, `peso`) dependen al 100% de la clave primaria de su respectiva tabla.

#### 3. Tercera Forma Normal (3FN)

* **Cumple 2FN.**
* **Sin Dependencias Transitivas:** Ningún atributo no-clave depende de otro atributo no-clave. Por ejemplo, los datos del apoderado (`nombre`, `telefono`) están en la tabla `apoderado` y no dentro de `mascota` ni `consulta`. Si cambia el teléfono de un dueño, se actualiza en un solo lugar.
