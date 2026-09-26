import { apiFetch } from './apiClient';

export function listarVeterinarios() {
    return apiFetch('/veterinarios');
}

export function crearVeterinario({ nombre, especialidad, telefono }) {
    return apiFetch('/veterinarios', {
        method: 'POST',
        body: JSON.stringify({ nombre, especialidad, telefono }),
    });
}
