import React from "react";

export const CanchasCard = ({ nombre, tipo, precioHora, imagen, onSelect }) => {
  return (
    <div className="bg-white rounded-3xl border border-slate-100 overflow-hidden shadow-sm hover:shadow-md transition-all flex flex-col">
      <div className="h-48 bg-slate-200 relative overflow-hidden">
        <img
          src={imagen || "https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=600&auto=format&fit=crop&q=60"}
          alt={nombre}
          className="w-full h-full object-cover"
        />
        <span className="absolute top-4 right-4 bg-white/90 backdrop-blur-md px-3 py-1 rounded-full text-xs font-semibold text-slate-800">
          {tipo || "Sintético"}
        </span>
      </div>

      <div className="p-6 flex-1 flex flex-col justify-between">
        <div>
          <h3 className="text-xl font-bold text-slate-900 mb-1">{nombre}</h3>
          <p className="text-slate-500 text-sm">Disponible para reservas del día</p>
        </div>

        <div className="mt-6 flex items-center justify-between pt-4 border-t border-slate-50">
          <div>
            <span className="text-xs text-slate-400 block">Precio por hora</span>
            <span className="text-xl font-bold text-emerald-600">S/ {precioHora}</span>
          </div>
          <button
            onClick={onSelect}
            className="bg-slate-900 hover:bg-slate-800 text-white font-medium text-sm px-4 py-2.5 rounded-xl transition-colors"
          >
            Seleccionar
          </button>
        </div>
      </div>
    </div>
  );
};