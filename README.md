# 🐾 Veterinaria-Patitas

Sistema web para la gestión integral de una clínica veterinaria: registro de clientes y mascotas, historial clínico y control de citas.

---

## 👥 Integrantes

| N.º | Nombre completo |
|----|-----------------|
| 1 | Alex Jonas Gonzales Sangama |
| 2 | Harim Jander Saavedra Hidalgo |
| 3 | Angel Martin Pinedo Saavedra |
| 4 | Angel Gabriel Amasifuen Ruíz |

---

## 📌 Descripción del problema y la solución

### Problema
Muchas veterinarias pequeñas y medianas llevan el control de sus clientes, mascotas y citas en cuadernos o en hojas de cálculo. Esto provoca pérdida de información, citas duplicadas o olvidadas, y dificulta consultar el historial clínico de cada mascota.

### Solución
**Veterinaria-Patitas** es una aplicación web que centraliza esta información en un solo lugar:

- Registro y consulta de clientes (dueños) y sus mascotas.
- Gestión de citas y atenciones veterinarias.
- Consulta rápida del historial de cada mascota.
- Acceso desde cualquier dispositivo con internet.

La aplicación se divide en un **frontend** (interfaz de usuario) y un **backend** (API REST) conectado a una base de datos PostgreSQL en la nube.

---

## 🛠️ Tecnologías

| Capa | Tecnología | Uso |
|------|-----------|-----|
| Frontend | **React** | Interfaz de usuario |
| Backend | **Spring Boot** (Java) | API REST y lógica de negocio |
| Base de datos | **PostgreSQL** | Almacenamiento de datos |
| Base de datos (nube) | **Neon** | Hosting de PostgreSQL |
| Despliegue backend | **Railway** | Hosting de la API |
| Despliegue frontend | **Vercel** | Hosting de la aplicación web |
| Diseño | **Figma** | Prototipo de la interfaz |

---

## 🔗 Enlaces

| Recurso | URL |
|---------|-----|
| 🌐 Frontend (público) | `PEGAR_AQUI_URL_DE_VERCEL` |
| ⚙️ Backend (público) | `PEGAR_AQUI_URL_DE_RAILWAY` |
| 🎨 Figma (público) | `PEGAR_AQUI_URL_DE_FIGMA` |
| 💻 Repositorio | https://github.com/Meowwuw/PROGRAMACI-N-PARA-DESARROLLO-DE-SOFTWARE-WITH-ORACLE |

---

## 📁 Estructura del proyecto

```
PROGRAMACI-N-PARA-DESARROLLO-DE-SOFTWARE-WITH-ORACLE/
├── backend/     # API REST con Spring Boot
├── frontend/    # Aplicación web con React
└── README.md
```

> Si los nombres de las carpetas son distintos en el repositorio, ajusta los comandos de abajo.

---

## ✅ Requisitos previos

Instala lo siguiente antes de comenzar:

| Herramienta | Versión recomendada | Verificar con |
|-------------|--------------------|---------------|
| Git | Cualquiera reciente | `git --version` |
| Java JDK | 17 o superior | `java -version` |
| Maven | 3.8 o superior (o usar `mvnw` incluido) | `mvn -version` |
| Node.js | 18 o superior | `node -v` |
| npm | 9 o superior | `npm -v` |
| PostgreSQL | 14 o superior (solo si usarás base local) | `psql --version` |

---

## 🚀 Ejecución en local

### 1. Clonar el repositorio

```bash
git clone https://github.com/Meowwuw/PROGRAMACI-N-PARA-DESARROLLO-DE-SOFTWARE-WITH-ORACLE.git
cd PROGRAMACI-N-PARA-DESARROLLO-DE-SOFTWARE-WITH-ORACLE
```

### 2. Configurar la base de datos

Tienes dos opciones:

**Opción A: Base de datos local (PostgreSQL)**

```sql
CREATE DATABASE veterinaria_patitas;
```

**Opción B: Base de datos en la nube (Neon)**

1. Crea una cuenta en [neon.tech](https://neon.tech) y un nuevo proyecto.
2. Copia la cadena de conexión que Neon te proporciona (host, base de datos, usuario y contraseña).

### 3. Ejecutar el backend (Spring Boot)

```bash
cd backend
```

Configura las variables de entorno (o edita `src/main/resources/application.properties`):

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `DB_URL` | URL JDBC de PostgreSQL | `jdbc:postgresql://localhost:5432/veterinaria_patitas` |
| `DB_USERNAME` | Usuario de la base de datos | `postgres` |
| `DB_PASSWORD` | Contraseña de la base de datos | `tu_contraseña` |
| `PORT` | Puerto del servidor (opcional) | `8080` |

Ejemplo en Linux / macOS:

```bash
export DB_URL="jdbc:postgresql://localhost:5432/veterinaria_patitas"
export DB_USERNAME="postgres"
export DB_PASSWORD="tu_contraseña"
```

Ejemplo en Windows (PowerShell):

```powershell
$env:DB_URL="jdbc:postgresql://localhost:5432/veterinaria_patitas"
$env:DB_USERNAME="postgres"
$env:DB_PASSWORD="tu_contraseña"
```

> Si usas **Neon**, el `DB_URL` tiene la forma `jdbc:postgresql://<host>/<db>?sslmode=require`.

Inicia el servidor:

```bash
./mvnw spring-boot:run        # Linux / macOS
mvnw.cmd spring-boot:run      # Windows
# o, si tienes Maven instalado:
mvn spring-boot:run
```

El backend quedará disponible en: **http://localhost:8080**

### 4. Ejecutar el frontend (React)

En otra terminal:

```bash
cd frontend
npm install
```

Crea un archivo `.env` dentro de `frontend/` con la URL del backend:

```env
# Si tu proyecto usa Vite:
VITE_API_URL=http://localhost:8080

# Si tu proyecto usa Create React App:
REACT_APP_API_URL=http://localhost:8080
```

Inicia la aplicación:

```bash
npm run dev      # si usa Vite
# o
npm start        # si usa Create React App
```

El frontend quedará disponible en: **http://localhost:5173** (Vite) o **http://localhost:3000** (CRA).

---

## ☁️ Despliegue

| Servicio | Plataforma | Notas |
|----------|-----------|-------|
| Base de datos | **Neon** | Crear proyecto y copiar la cadena de conexión |
| Backend | **Railway** | Conectar el repositorio, definir `DB_URL`, `DB_USERNAME`, `DB_PASSWORD` en *Variables* |
| Frontend | **Vercel** | Importar el repositorio, seleccionar la carpeta `frontend` y definir la variable con la URL pública del backend |

---

## 🧪 Verificación rápida

Una vez que todo esté en ejecución:

1. Abre el frontend en el navegador.
2. Verifica que la aplicación cargue sin errores.
3. Registra un cliente o una mascota de prueba y confirma que se guarda y se muestra en la lista.

---

## 🩺 Solución de problemas

| Problema | Posible causa | Solución |
|----------|--------------|----------|
| `Connection refused` al iniciar el backend | PostgreSQL apagado o credenciales incorrectas | Verifica que la base esté activa y revisa `DB_URL`, `DB_USERNAME`, `DB_PASSWORD` |
| Error de SSL con Neon | Falta el parámetro SSL | Agrega `?sslmode=require` a la URL JDBC |
| `Port 8080 already in use` | Otro proceso usa el puerto | Cambia `PORT` o cierra el proceso que lo ocupa |
| El frontend no recibe datos | URL del backend incorrecta o CORS | Revisa la variable de entorno del frontend y la configuración CORS del backend |
| `Unsupported class file major version` | Versión de Java incorrecta | Usa JDK 17 o superior |

---

## 📄 Licencia

Proyecto académico desarrollado para el curso de Programación para Desarrollo de Software.
