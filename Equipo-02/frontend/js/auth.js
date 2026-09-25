const API_URL = 'http://localhost:8080/api/auth';

const loginWrapper = document.getElementById('login-form-wrapper');
const registerWrapper = document.getElementById('register-form-wrapper');

document.getElementById('show-register')?.addEventListener('click', (e) => {
    e.preventDefault();
    loginWrapper.classList.remove('active');
    registerWrapper.classList.add('active');
});

document.getElementById('show-login')?.addEventListener('click', (e) => {
    e.preventDefault();
    registerWrapper.classList.remove('active');
    loginWrapper.classList.add('active');
});

// Intenta leer el JSON de error que manda el backend (AuthController devuelve {"error": "..."})
async function leerError(response) {
    try {
        const data = await response.json();
        return data.error || JSON.stringify(data);
    } catch {
        return `HTTP ${response.status}`;
    }
}

// LOGIN
document.getElementById('login-form')?.addEventListener('submit', async (e) => {
    e.preventDefault();
    const username = document.getElementById('login-username').value;
    const password = document.getElementById('login-password').value;
    const errorAlert = document.getElementById('login-error');

    try {
        const response = await fetch(`${API_URL}/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, password })
        });
        if (response.ok) {
            window.location.href = 'home.html';
        } else {
            const msg = await leerError(response);
            console.error('LOGIN falló:', response.status, msg);
            errorAlert.textContent = `Error (${response.status}): ${msg}`;
            errorAlert.style.display = 'block';
        }
    } catch (error) {
        console.error('LOGIN error de red:', error);
        errorAlert.textContent = 'Error conectando al backend (¿Está encendido IntelliJ?)';
        errorAlert.style.display = 'block';
    }
});

// REGISTRO
document.getElementById('register-form')?.addEventListener('submit', async (e) => {
    e.preventDefault();
    const username = document.getElementById('reg-username').value;
    const email = document.getElementById('reg-email').value;
    const password = document.getElementById('reg-password').value;
    const errorAlert = document.getElementById('register-error');
    const successAlert = document.getElementById('register-success');

    try {
        const response = await fetch(`${API_URL}/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, email, password, id_rol: 4 }) // 4 = apoderado en tu tabla rol
        });
        if (response.ok) {
            successAlert.textContent = 'Cuenta creada en Base de Datos. Ya puedes iniciar sesión.';
            successAlert.style.display = 'block';
            errorAlert.style.display = 'none';
            e.target.reset();
        } else {
            const msg = await leerError(response);
            console.error('REGISTRO falló:', response.status, msg);
            errorAlert.textContent = `Error (${response.status}): ${msg}`;
            errorAlert.style.display = 'block';
        }
    } catch (error) {
        console.error('REGISTRO error de red:', error);
        errorAlert.textContent = 'Error conectando al servidor backend.';
        errorAlert.style.display = 'block';
    }
});