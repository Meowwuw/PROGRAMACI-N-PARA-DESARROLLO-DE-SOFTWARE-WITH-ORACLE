document.addEventListener('DOMContentLoaded', () => {
    const formCuenta = document.getElementById('form-agregar-cuenta');
    const mensajeDiv = document.getElementById('mensaje-respuesta');

    formCuenta.addEventListener('submit', async (e) => {
        e.preventDefault(); // Evita que la página se recargue

        // Capturar los valores del formulario
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        // Estructurar el objeto JSON que espera tu backend
        // IMPORTANTE: Los nombres de estas variables deben coincidir con los atributos de tu modelo Usuario.java
        const nuevoUsuario = {
            username: username,
            password: password
        };

        try {
            // Reemplaza "/api/usuarios" con la ruta exacta definida en tu UsuarioController
            const response = await fetch('http://localhost:8080/api/usuarios', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(nuevoUsuario)
            });

            if (response.ok) {
                mensajeDiv.innerHTML = '<p style="color: green;">¡Cuenta creada exitosamente!</p>';
                formCuenta.reset(); // Limpiar el formulario
            } else {
                mensajeDiv.innerHTML = '<p style="color: red;">Error al crear la cuenta. Verifica los datos.</p>';
            }
        } catch (error) {
            console.error('Error en la petición:', error);
            mensajeDiv.innerHTML = '<p style="color: red;">Error de conexión con el servidor (Backend apagado o CORS).</p>';
        }
    });
});