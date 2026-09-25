import { fetchAPI } from "./api";

export const PagoService = {
  procesar: (pagoData) =>
    fetchAPI("/pagos", {
      method: "POST",
      body: JSON.stringify(pagoData),
    }),
};