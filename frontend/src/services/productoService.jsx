const API_URL = import.meta.env.VITE_API_URL;

export function obtenerProductos(){
    return fetch(`${API_URL}/productos`)
    .then((response) => {
        if(!response.ok){
            throw new Error ("Error al obtener producto");
        }
        return response.json();
    });
}


