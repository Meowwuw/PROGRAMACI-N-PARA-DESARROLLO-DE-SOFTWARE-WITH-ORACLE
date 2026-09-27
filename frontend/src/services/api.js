// Configurado para tu servidor web local en el puerto 6767
const BASE_URL = "http://localhost:6767/api";

export const fetchAPI = async (endpoint, options = {}) => {
  try {
    const response = await fetch(`${BASE_URL}${endpoint}`, {
      headers: {
        "Content-Type": "application/json",
        ...options.headers,
      },
      ...options,
    });

    if (!response.ok) {
      throw new Error(`Error ${response.status}: ${response.statusText}`);
    }

    // Las respuestas 204 (típicas de DELETE) no traen cuerpo: no intentes parsear JSON ahí.
    if (response.status === 204) {
      return null;
    }

    const texto = await response.text();
    return texto ? JSON.parse(texto) : null;
  } catch (error) {
    console.error("Error en la petición API:", error);
    throw error;
  }
};