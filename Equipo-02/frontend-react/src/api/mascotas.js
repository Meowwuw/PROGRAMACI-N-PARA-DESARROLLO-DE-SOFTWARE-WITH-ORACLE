import { apiFetch } from './apiClient';

export function listarMascotas() {
    return apiFetch('/mascotas');
}

// idApoderado debe ser el id numerico del apoderado seleccionado.
// El backend espera el objeto anidado { apoderado: { id: ... } }, no un campo suelto.
export function crearMascota({ nombre, raza, peso, genero, idApoderado }) {
    return apiFetch('/mascotas', {
        method: 'POST',
        body: JSON.stringify({
            nombre,
            raza,
            peso,
            genero,
            apoderado: { id: idApoderado },
        }),
    });
}

export function eliminarMascota(id) {
    return apiFetch(`/mascotas/${id}`, { method: 'DELETE' });
}
