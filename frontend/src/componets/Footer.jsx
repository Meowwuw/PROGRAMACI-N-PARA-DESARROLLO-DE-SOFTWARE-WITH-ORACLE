import React from "react";

export const Footer = () => {
  return (
    <footer className="bg-slate-900 text-white py-10 mt-auto">
      <div className="max-w-7xl mx-auto px-6 flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-slate-400">
        <div className="flex items-center gap-2">
          <span className="font-bold text-white text-base">CanchaVóley</span>
        </div>
        <p>© CanchaVóley · Reserva de canchas de vóley</p>
      </div>
    </footer>
  );
};