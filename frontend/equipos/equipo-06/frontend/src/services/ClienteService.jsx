const API_URL = "http://localhost:8081/api/clientes";

export const obtenerCliente = async () => {
  const response = await fetch(API_URL);
  if (!response.ok) {
    console.error("Status de la respuesta:", response.status);
    throw new Error('Error al obtener los clientes');
  }
  return await response.json();
};