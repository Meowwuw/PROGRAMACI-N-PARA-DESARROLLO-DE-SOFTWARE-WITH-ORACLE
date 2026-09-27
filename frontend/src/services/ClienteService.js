import { fetchAPI } from "./api";

export const ClienteService = {
  registrar: (clienteData) =>
    fetchAPI("/clientes", {
      method: "POST",
      body: JSON.stringify(clienteData),
    }),
  buscarPorDni: (dni) => fetchAPI(`/clientes/dni/${dni}`),
  obtenerTodos: () => fetchAPI("/clientes"),
  actualizar: (id, clienteData) =>
    fetchAPI(`/clientes/${id}`, {
      method: "PUT",
      body: JSON.stringify(clienteData),
    }),
  eliminar: (id) => fetchAPI(`/clientes/${id}`, { method: "DELETE" }),
};