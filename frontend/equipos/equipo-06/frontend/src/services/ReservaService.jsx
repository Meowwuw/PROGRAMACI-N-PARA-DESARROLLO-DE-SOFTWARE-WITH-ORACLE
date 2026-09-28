const API_URL = "http://localhost:8081/api/reservas";

// Obtener todas las reservas
export const obtenerReservas = async () => {
  const response = await fetch(API_URL);
  if (!response.ok) {
    console.error("Status de la respuesta:", response.status);
    throw new Error("Error al obtener las reservas");
  }
  return await response.json();
};

// Obtener una reserva por ID
export const obtenerReservaPorId = async (id) => {
  const response = await fetch(`${API_URL}/${id}`);
  if (!response.ok) {
    console.error("Status de la respuesta:", response.status);
    throw new Error(`Error al obtener la reserva con ID ${id}`);
  }
  return await response.json();
};

// Crear una nueva reserva
export const crearReserva = async (reservaData) => {
  const response = await fetch(API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(reservaData),
  });
  if (!response.ok) {
    console.error("Status de la respuesta:", response.status);
    throw new Error("Error al crear la reserva");
  }
  return await response.json();
};

// Actualizar una reserva existente
export const actualizarReserva = async (id, reservaData) => {
  const response = await fetch(`${API_URL}/${id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(reservaData),
  });
  if (!response.ok) {
    console.error("Status de la respuesta:", response.status);
    throw new Error(`Error al actualizar la reserva con ID ${id}`);
  }
  return await response.json();
};

// Eliminar una reserva
export const eliminarReserva = async (id) => {
  const response = await fetch(`${API_URL}/${id}`, {
    method: "DELETE",
  });
  if (!response.ok) {
    console.error("Status de la respuesta:", response.status);
    throw new Error(`Error al eliminar la reserva con ID ${id}`);
  }
  return true;
};