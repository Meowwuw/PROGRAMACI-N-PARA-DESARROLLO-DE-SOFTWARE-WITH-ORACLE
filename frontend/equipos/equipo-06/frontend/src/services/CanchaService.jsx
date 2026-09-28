
const API_URL = "http://localhost:8081/api/canchas";

export const obtenerCanchas = async () => {
  const response = await fetch(API_URL);
  if (!response.ok) {
    console.error("Status de la respuesta:", response.status);
    throw new Error('Error al obtener las canchas');
  }
  return await response.json();
};