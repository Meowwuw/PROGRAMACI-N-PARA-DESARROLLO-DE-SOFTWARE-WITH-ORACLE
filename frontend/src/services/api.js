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

    return await response.json();
  } catch (error) {
    console.error("Error en la petición API:", error);
    throw error;
  }
};