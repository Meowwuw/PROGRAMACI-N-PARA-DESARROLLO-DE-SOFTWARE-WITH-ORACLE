import React from "react";

export const ResumenCard = ({ fecha, cancha, horario, total }) => {
  return (
    <div className="bg-white rounded-3xl p-6 border border-slate-100 shadow-sm w-full sticky top-28">
      <h3 className="font-bold text-lg text-slate-900 mb-4 pb-3 border-b border-slate-100">
        Tu reserva
      </h3>
      <div className="space-y-4 text-sm">
        <div className="flex justify-between items-center">
          <span className="text-slate-500">Fecha</span>
          <span className="font-semibold text-slate-800">{fecha || "—"}</span>
        </div>
        <div className="flex justify-between items-center">
          <span className="text-slate-500">Cancha</span>
          <span className="font-semibold text-slate-800">{cancha || "—"}</span>
        </div>
        <div className="flex justify-between items-center">
          <span className="text-slate-500">Horario</span>
          <span className="font-semibold text-slate-800">{horario || "—"}</span>
        </div>
        
        <div className="pt-4 border-t border-slate-100">
          <div className="flex justify-between items-baseline">
            <span className="text-slate-500 font-medium">Total</span>
            <span className="text-2xl font-black text-blue-600">
              {total ? `S/ ${total}` : "S/ 0.00"}
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};