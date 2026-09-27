import { fetchAPI } from "./api";

export const HorarioService = {
  obtenerTodos: () => fetchAPI("/horarios"),
  crear: (horarioData) =>
    fetchAPI("/horarios", {
      method: "POST",
      body: JSON.stringify(horarioData),
    }),
  actualizar: (id, horarioData) =>
    fetchAPI(`/horarios/${id}`, {
      method: "PUT",
      body: JSON.stringify(horarioData),
    }),
  eliminar: (id) => fetchAPI(`/horarios/${id}`, { method: "DELETE" }),
};
