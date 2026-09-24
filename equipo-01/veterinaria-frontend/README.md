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

## Siguientes pasos sugeridos

- Agregar las demás secciones (Dueños, Mascotas, Consultas, etc.) como
  páginas nuevas en `src/pages/`, cada una registrada en `src/App.jsx`.
- Si el login llega a funcionar, guardar el token/usuario en contexto o
  `localStorage` y usar `useNavigate()` para redirigir tras iniciar sesión.
- Proteger las rutas internas (que solo se pueda entrar a Dueños/Mascotas/etc.
  si hay sesión iniciada).
