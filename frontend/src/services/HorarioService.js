import { fetchAPI } from "./api";

export const HorarioService = {
  obtenerDisponibles: (canchaId, fecha) => 
    fetchAPI(`/horarios?canchaId=${canchaId}&fecha=${fecha}`),
};