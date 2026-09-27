import { fetchAPI } from "./api";

export const CanchaService = {
  obtenerTodas: () => fetchAPI("/canchas"),
  obtenerPorId: (id) => fetchAPI(`/canchas/${id}`),
  crear: (canchaData) =>
    fetchAPI("/canchas", {
      method: "POST",
      body: JSON.stringify(canchaData),
    }),
  actualizar: (id, canchaData) =>
    fetchAPI(`/canchas/${id}`, {
      method: "PUT",
      body: JSON.stringify(canchaData),
    }),
  eliminar: (id) => fetchAPI(`/canchas/${id}`, { method: "DELETE" }),
};