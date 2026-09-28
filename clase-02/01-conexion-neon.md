# Conectar DBeaver con Neon

Guía de referencia de la Clase 02. Si algún día pierdes la conexión, vuelve aquí.

## Antes de empezar

Necesitas los datos que te pasó la instructora. Vienen en una sola línea con esta forma:

```
postgresql://neondb_owner:MiClave123@ep-cool-lab-a1b2c3.us-east-2.aws.neon.tech/neondb?sslmode=require
```

De ahí salen los cinco datos que DBeaver te va a pedir por separado:

| Campo en DBeaver | De dónde sale |
|---|---|
| Host | lo que va después de la `@` y antes de la `/` |
| Port | `5432` (siempre) |
| Database | lo que va después de la `/`, normalmente `neondb` |
| Username | lo que va después de `//` y antes de los `:` |
| Password | lo que va entre `:` y `@` |

> **No pegues la cadena completa en ningún campo.** DBeaver usa el driver de Java, que no acepta usuario y contraseña dentro de la URL. Es el error más frecuente.

## Pasos

1. **Base de datos → Nueva conexión** (o el icono del enchufe con el signo `+`).
2. Elige **PostgreSQL** en la lista de motores. No Oracle, no SQLite.
3. Si es la primera vez, acepta **descargar el driver**. Necesita internet.
4. **Borra los valores por defecto**: DBeaver rellena Host con `localhost` y Database con `postgres`. Si no los borras, la conexión falla.
5. Llena los cinco campos de la tabla de arriba.
6. Pulsa **Test Connection**. Debe responder *Connected*. Si sale error, no sigas: revísalo aquí abajo.
7. **Finalizar**. Abre un editor SQL (`Ctrl + ]`) y ejecuta `SELECT version();` para confirmar.

## Errores frecuentes

| Mensaje | Qué pasó |
|---|---|
| `The connection attempt failed` / `UnknownHost` | El host está mal copiado, casi siempre por un espacio al inicio o al final. |
| `password authentication failed` | Usuario o contraseña incorrectos, o pegaste la cadena completa en el campo Password. |
| `database "postgres" does not exist` | Quedó el valor por defecto del paso 4. La base se llama `neondb`. |

## Atajos de DBeaver

| Atajo | Qué hace |
|---|---|
| `Ctrl + Enter` | ejecuta **solo** la instrucción donde está el cursor |
| `Alt + X` | ejecuta el script **completo**, de arriba a abajo |
| `Ctrl + ]` | abre un nuevo editor SQL |
| `F5` | refresca el navegador para ver lo que acabas de crear |

## Tu esquema de trabajo

Todo el salón entra con el mismo usuario a la misma base de datos. Para que las tablas de uno no pisen las del otro, cada quien trabaja dentro de su propio esquema.

```sql
-- una sola vez
CREATE SCHEMA IF NOT EXISTS a_tuapellido;

-- cada vez que abres DBeaver
SET search_path TO a_tuapellido;
```

Si algún día abres DBeaver y "desaparecieron" tus tablas, casi siempre es que olvidaste el `SET search_path`.
