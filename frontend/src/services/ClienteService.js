import { fetchAPI } from "./api";

export const ClienteService = {
  registrar: (clienteData) =>
    fetchAPI("/clientes", {
      method: "POST",
      body: JSON.stringify(clienteData),
    }),
  buscarPorDni: (dni) => fetchAPI(`/clientes/dni/${dni}`),
};