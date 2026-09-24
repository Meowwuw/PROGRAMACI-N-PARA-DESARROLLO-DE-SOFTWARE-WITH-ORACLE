const API_BASE = 'http://localhost:8080/api';

document.addEventListener('DOMContentLoaded', () => {
    const formCuenta = document.getElementById('form-agregar-cuenta');
    const mensajeDiv = document.getElementById('mensaje-respuesta');
    const rolSelect = document.getElementById('rol');
    const veterinarioGroup = document.getElementById('veterinarioGroup');
    const veterinarioSelect = document.getElementById('veterinario');

    // Mostrar el selector de veterinario solo cuando el rol es "veterinario"
    rolSelect.addEventListener('change', () => {
        if (rolSelect.value === 'veterinario') {
            veterinarioGroup.style.display = 'block';
            veterinarioSelect.required = true;
            cargarVeterinarios();
        } else {
            veterinarioGroup.style.display = 'none';
            veterinarioSelect.required = false;
            veterinarioSelect.value = '';
        }
    });

    // Trae la lista de veterinarios desde el backend para el <select>
    async function cargarVeterinarios() {
        if (veterinarioSelect.dataset.cargado === 'true') return; // evita recargar cada vez

        try {
            const response = await fetch(`${API_BASE}/veterinarios`);
            if (!response.ok) throw new Error('No se pudo obtener la lista de veterinarios');

            const veterinarios = await response.json();
            veterinarios.forEach(vet => {
                const option = document.createElement('option');
                option.value = vet.idVeterinario;
                option.textContent = vet.nombre;
                veterinarioSelect.appendChild(option);
            });
            veterinarioSelect.dataset.cargado = 'true';
        } catch (error) {
            console.error('Error cargando veterinarios:', error);
            mostrarMensaje('No se pudo cargar la lista de veterinarios. Verifica que el backend esté encendido.', 'error');
        }
    }

    formCuenta.addEventListener('submit', async (e) => {
        e.preventDefault();

        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const rol = rolSelect.value;
        const idVeterinario = veterinarioSelect.value;

        if (password !== confirmPassword) {
            mostrarMensaje('Las contraseñas no coinciden.', 'error');
            return;
        }

        if (rol === 'veterinario' && !idVeterinario) {
            mostrarMensaje('Selecciona el veterinario asociado a esta cuenta.', 'error');
            return;
        }

        // Estructura exacta que espera tu modelo Usuario.java (email, password, rol, veterinario)
        const nuevoUsuario = {
            email: email,
            password: password,
            rol: rol,
            veterinario: rol === 'veterinario'
                ? { idVeterinario: Number(idVeterinario) }
                : null
        };

        try {
            const response = await fetch(`${API_BASE}/usuarios`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(nuevoUsuario)
            });

            if (response.ok) {
                mostrarMensaje('¡Cuenta creada exitosamente! Ya puedes iniciar sesión.', 'success');
                formCuenta.reset();
                veterinarioGroup.style.display = 'none';
            } else if (response.status === 409) {
                mostrarMensaje('Ese correo ya está registrado.', 'error');
            } else {
                mostrarMensaje('Error al crear la cuenta. Verifica los datos.', 'error');
            }
        } catch (error) {
            console.error('Error en la petición:', error);
            mostrarMensaje('Error de conexión con el servidor (backend apagado o CORS).', 'error');
        }
    });

    function mostrarMensaje(texto, tipo) {
        mensajeDiv.textContent = texto;
        mensajeDiv.className = `form-message ${tipo === 'success' ? 'form-message-success' : 'form-message-error'}`;
    }
});
