import { fetchAPI } from "./api";

export const CanchaService = {
  obtenerTodas: () => fetchAPI("/canchas"),
  obtenerPorId: (id) => fetchAPI(`/canchas/${id}`),
};