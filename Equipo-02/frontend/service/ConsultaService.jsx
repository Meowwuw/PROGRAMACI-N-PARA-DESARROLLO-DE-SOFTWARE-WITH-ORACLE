const API_URL = "http://localhost:8080/api/consulta";

export function obtenerConsulta() {
    return fetch(API_URL)
        .then((response) => {
            if (!response.ok) {
                throw new Error("Error al obtener consultas");
            }

            return response.json();
        });
}