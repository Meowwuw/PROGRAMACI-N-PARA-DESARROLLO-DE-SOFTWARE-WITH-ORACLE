import React from "react";

export const SlotCard = ({ hora, precio, estado = "disponible", onClick }) => {
  const styles = {
    disponible: "border-2 border-emerald-500 bg-emerald-50 text-emerald-950 hover:bg-emerald-100 cursor-pointer",
    ocupado: "bg-slate-100 text-slate-400 border border-transparent cursor-not-allowed",
    seleccionado: "bg-blue-600 text-white border-2 border-blue-600 shadow-md cursor-pointer",
  };

  return (
    <button
      disabled={estado === "ocupado"}
      onClick={onClick}
      className={`rounded-2xl p-3 text-center transition-all flex flex-col items-center justify-center w-full ${styles[estado]}`}
    >
      <span className="font-bold text-sm leading-tight">{hora}</span>
      <span
        className={`text-xs mt-0.5 ${
          estado === "seleccionado"
            ? "text-blue-100"
            : estado === "ocupado"
            ? "text-slate-400"
            : "text-emerald-700"
        }`}
      >
        {estado === "ocupado" ? "No disponible" : `S/ ${precio}`}
      </span>
    </button>
  );
};