import { fetchAPI } from "./api";

export const PagoService = {
  procesar: (pagoData) =>
    fetchAPI("/pagos", {
      method: "POST",
      body: JSON.stringify(pagoData),
    }),
  obtenerTodos: () => fetchAPI("/pagos"),
  actualizar: (id, pagoData) =>
    fetchAPI(`/pagos/${id}`, {
      method: "PUT",
      body: JSON.stringify(pagoData),
    }),
  eliminar: (id) => fetchAPI(`/pagos/${id}`, { method: "DELETE" }),
};
