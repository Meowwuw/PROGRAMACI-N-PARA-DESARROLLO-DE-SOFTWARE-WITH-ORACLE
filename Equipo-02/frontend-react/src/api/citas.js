import { apiFetch } from './apiClient';

// El backend llama a esto "consulta", en la UI lo mostramos como "cita".

export function listarCitas() {
    return apiFetch('/consultas');
}

export function listarCitasPorVeterinario(idVeterinario) {
    return apiFetch(`/consultas/veterinario/${idVeterinario}`);
}

export function listarCitasPorMascota(idMascota) {
    return apiFetch(`/consultas/mascota/${idMascota}`);
}

// fecha debe venir en formato "YYYY-MM-DDTHH:mm" (lo que entrega un <input type="datetime-local">)
export function agendarCita({ fecha, idApoderado, idVeterinario, idMascota }) {
    const params = new URLSearchParams({
        fecha,
        idApoderado,
        idVeterinario,
        idMascota,
    });
    return apiFetch(`/consultas/rapida?${params.toString()}`, { method: 'POST' });
}

export function eliminarCita(id) {
    return apiFetch(`/consultas/${id}`, { method: 'DELETE' });
}
