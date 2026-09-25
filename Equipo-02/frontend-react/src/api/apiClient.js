export const BASE_URL = 'http://localhost:8080/api';

/**
 * Wrapper de fetch que:
 * - Manda/recibe JSON automaticamente
 * - Lanza un Error con el mensaje real que manda el backend cuando algo falla
 *   (en vez de mostrar siempre "Credenciales incorrectas" o "Error generico")
 */
export async function apiFetch(path, options = {}) {
    const response = await fetch(`${BASE_URL}${path}`, {
        headers: { 'Content-Type': 'application/json' },
        ...options,
    });

    // 204 No Content (por ejemplo un DELETE exitoso) no trae body
    if (response.status === 204) {
        return null;
    }

    let data = null;
    try {
        data = await response.json();
    } catch {
        // La respuesta no era JSON (por ejemplo un 500 con HTML de Whitelabel)
        data = null;
    }

    if (!response.ok) {
        const mensaje = data?.error || `Error HTTP ${response.status}`;
        const error = new Error(mensaje);
        error.status = response.status;
        throw error;
    }

    return data;
}
