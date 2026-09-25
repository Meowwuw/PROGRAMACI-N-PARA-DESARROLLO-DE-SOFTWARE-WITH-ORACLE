import { fetchAPI } from "./api";

export const HorarioService = {
  obtenerTodos: () => fetchAPI("/horarios"),
};