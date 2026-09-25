const API_URL = "http://localhost:8080/api/productos";

export function obtenerProductos(){
    return fetch(API_URL)
    .then((response) => {
        if(!response.ok){
            throw new Error ("Error al obtener producto");
        }
        return response.json();
    });
}


