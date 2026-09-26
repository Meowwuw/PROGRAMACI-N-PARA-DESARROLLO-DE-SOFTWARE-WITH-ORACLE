# Ximedgar - Frontend (React + Vite)

Migración a React de tu frontend original (HTML/CSS/JS plano). Mismo diseño,
mismos colores, misma lógica de fetch al backend — solo cambia cómo está
organizado el código.

## Cómo correrlo

```bash
npm install
npm run dev
```

Abre `http://localhost:5173`.

## Qué se migró y cómo

- `Html/index.html` → `src/pages/Login.jsx`
- `Html/agregar_cuenta.html` → `src/pages/AgregarCuenta.jsx`
- `Css/styles.css` → `src/index.css` (copiado tal cual, sin tocar nada)
- `JavaScript/agregar_cuenta.js` → la misma lógica ahora vive dentro de
  `AgregarCuenta.jsx`, usando `useState` en vez de `document.getElementById`
- El SVG de la huella (que se repetía en ambos HTML) ahora es un componente
  compartido: `src/components/BrandPanel.jsx` y `src/components/HeaderBrand.jsx`
- La navegación entre "Iniciar sesión" y "Crear cuenta" ya no es
  `<a href="agregar_cuenta.html">`, es `react-router-dom`
  (`/` = login, `/agregar-cuenta` = registro)

## ⚠️ Importante: el login no tenía lógica todavía

Tu proyecto original tenía `index.html` apuntando a `../JavaScript/app.js`,
pero ese archivo **no venía incluido en el zip** — o sea, el botón "Ingresar"
en tu versión HTML no hacía nada todavía.

Para que el proyecto migrado sí funcionara de punta a punta, le agregué una
lógica de submit en `Login.jsx` que llama a `POST /api/auth/login` con
`{ email, password }`. **Esto es una suposición mía**, no algo que existiera
en tu backend. Verifica:

- Si tu `UsuarioController` ya tiene un endpoint de login, ajusta la URL en
  `Login.jsx` (constante `API_BASE` + la ruta del fetch) para que coincida.
- Si todavía no existe ese endpoint, es el siguiente paso lógico en el
  backend antes de que el login funcione de verdad.

## Cómo funciona la sesión ahora

- Al loguearse correctamente, `Login.jsx` guarda en `localStorage` lo que
  sea que el backend devuelva (`src/lib/session.js`), junto con el email.
- Todas las rutas internas (Inicio, Dueños, etc.) están envueltas en
  `RequireAuth` (`src/components/RequireAuth.jsx`): si no hay sesión
  guardada, redirige automáticamente a `/login`. Por eso la app ahora
  "empieza" en el login de verdad.
- "Cerrar sesión" en el sidebar borra esa sesión y regresa a `/login`.
- El saludo del Dashboard usa `sesion.nombre` si el backend lo devuelve, o
  el email como respaldo. **Pásame tu `UsuarioController.java` y
  `LoginRequestDTO.java` reales** para dejar esto exacto (qué campos
  devuelve el login: nombre, rol, idVeterinario, etc.) en vez de adivinar.

## Cómo funciona el login ahora (contrato confirmado)

Con tu `UsuarioController.java` real:
- `POST /api/usuarios/login` con body `{ email, password }`.
- Si las credenciales son correctas, responde `200` con el objeto `Usuario`
  completo: `{ idUsuario, email, password, rol, veterinario }` (`veterinario`
  viene `null` si el usuario es admin).
- Si son incorrectas, responde `401`.

El frontend guarda esa respuesta en `localStorage` **sin el campo
`password`** (no hace falta tenerlo en el navegador). El saludo del
Dashboard usa `veterinario.nombre` cuando existe; si es un admin, usa el
email porque la tabla `usuarios` no guarda un "nombre" propio para ese rol.

⚠️ Nota sobre el backend (no es algo que yo pueda arreglar desde el
frontend): `UsuarioService.autenticar()` compara la contraseña con
`.equals()` en texto plano, y el login devuelve el `Usuario` completo
incluyendo `password` en la respuesta JSON. Para un ejercicio de clase
puede no importar, pero si en algún momento quieres que esto sea seguro de
verdad, lo ideal es hashear con BCrypt al crear la cuenta y no devolver el
campo `password` en la respuesta del login.

## Por qué ya no queda espacio gris fuera del login

El `body` tenía centrado + fondo gris pensado solo para la tarjeta de Login.
Eso se movió a una clase `.auth-shell` que solo envuelve `Login.jsx` y
`AgregarCuenta.jsx`. El resto de la app (`.app-shell`, dentro del `Layout`)
ahora sí ocupa toda la pantalla sin ese margen.


## Siguientes pasos sugeridos

- Agregar Consultas, Servicios, Veterinarios, Catálogos y Reportes como
  páginas nuevas en `src/pages/`, cada una registrada en `src/App.jsx`
  dentro del `<Route>` protegido por `RequireAuth`.
- Consultas necesita mascota + veterinario como selects, igual que Mascotas
  necesitó dueño + raza — mismo patrón, solo cambia qué endpoints usa.
- Si el login llega a hashear contraseñas (BCrypt) en el backend, no hace
  falta tocar nada del frontend: el fetch sigue mandando `{email, password}`
  igual.
- Proteger por rol (que un Veterinario no vea todo lo que ve un
  Administrador) — por ahora `RequireAuth` solo verifica que haya sesión,
  no distingue el `rol`.

## Proyecto completo: 10 páginas

- **Login** (`/login`) y **Crear cuenta** (`/agregar-cuenta`): conectadas al
  backend real.
- **Inicio** (`/`): dashboard con datos reales.
- **Dueños** (`/duenos`): listado + alta.
- **Mascotas** (`/mascotas`): listado + alta (selects de Dueño y Raza).
- **Consultas** (`/consultas`): listado + alta + detalle con servicios
  aplicados (`DetalleConsultaModal`, conecta `detalle_consulta_servicio`).
- **Servicios** (`/servicios`) y **Veterinarios** (`/veterinarios`):
  listado + alta simple.
- **Catálogos** (`/catalogos`): pestañas Razas / Especies, cada una con su
  propio listado y alta. Si intentas crear una raza sin haber creado antes
  ninguna especie, el select sale vacío y te avisa.
- **Reportes** (`/reportes`): "Consultas por veterinario" e "Ingresos por
  servicio" como barras horizontales reales (CSS, no una librería de
  gráficos), calculadas en el frontend a partir de `/api/consultas` y
  `/api/detalle-consulta-servicio`.
- **Perfil** (`/perfil`): muestra los datos de la sesión guardada
  (email, rol, y si es veterinario, su nombre/especialidad/teléfono).
  Editar el perfil todavía no está conectado a ningún endpoint — es
  solo lectura por ahora.

El modal reutilizable vive en `src/components/Modal.jsx`.

## Notas sobre Consultas

- El `<input type="datetime-local">` no manda segundos; se le agregan
  `:00` antes de enviarlo (`aLocalDateTime()` en `Consultas.jsx`) para que
  calce con el `LocalDateTime` que espera `Consulta.java`. Si dejas la
  fecha vacía, el backend usa su `DEFAULT CURRENT_TIMESTAMP`.
- El costo total que se ve en el detalle (`costoBase` + suma de servicios)
  es un cálculo hecho en el frontend, no algo que el backend devuelva
  calculado — si mañana quieres ese total en un reporte, hay que calcularlo
  de nuevo ahí o exponerlo desde el backend.
