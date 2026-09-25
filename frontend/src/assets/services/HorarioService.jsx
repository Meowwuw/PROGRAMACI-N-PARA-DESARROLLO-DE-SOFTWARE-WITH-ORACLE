const API_URL = "http://localhost:8080/api/horarios";

// Obtener todos los horarios
export async function obtenerHorarios() {
  const response = await fetch(API_URL);
  if (!response.ok) throw new Error("Error al obtener los horarios");
  return await response.json();
}

// Crear un nuevo horario
export async function crearHorario(horario) {
  const response = await fetch(API_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(horario),
  });
  if (!response.ok) throw new Error("Error al guardar el horario");
  return await response.json();
}

// Actualizar un horario existente
export async function actualizarHorario(id, horario) {
  const response = await fetch(`${API_URL}/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(horario),
  });
  if (!response.ok) throw new Error("Error al actualizar el horario");
  return await response.json();
}

// Eliminar un horario
export async function eliminarHorario(id) {
  const response = await fetch(`${API_URL}/${id}`, { method: "DELETE" });
  if (!response.ok) throw new Error("Error al eliminar el horario");
}