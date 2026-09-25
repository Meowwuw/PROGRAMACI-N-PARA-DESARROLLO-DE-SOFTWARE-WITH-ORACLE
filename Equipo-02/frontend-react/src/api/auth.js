import { apiFetch } from './apiClient';

// Devuelve un AuthResponse: { idUsuario, username, email, rol }
export function login(username, password) {
    return apiFetch('/auth/login', {
        method: 'POST',
        body: JSON.stringify({ username, password }),
    });
}

// id_rol 4 = apoderado por defecto (ver rol.sql). Coincide con AuthController.
export function register(username, email, password, id_rol = 4) {
    return apiFetch('/auth/register', {
        method: 'POST',
        body: JSON.stringify({ username, email, password, id_rol }),
    });
}
