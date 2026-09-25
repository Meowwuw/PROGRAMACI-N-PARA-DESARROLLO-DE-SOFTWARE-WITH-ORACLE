import { apiFetch } from './apiClient';

export function listarApoderados() {
    return apiFetch('/apoderados');
}

export function crearApoderado({ nombre, telefono }) {
    return apiFetch('/apoderados', {
        method: 'POST',
        body: JSON.stringify({ nombre, telefono }),
    });
}

export function eliminarApoderado(id) {
    return apiFetch(`/apoderados/${id}`, { method: 'DELETE' });
}
