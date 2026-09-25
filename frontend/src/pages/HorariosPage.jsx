import React, { useState } from "react";
import { Navbar } from "../componets/Navbar";
import { Footer } from "../componets/Footer";
import { SlotCard } from "../componets/SlotCard";

export const HorariosPage = () => {
  const [fecha, setFecha] = useState("2026-09-28");

  const horariosEjemplo = [
    { hora: "08:00 AM", precio: 30, estado: "disponible" },
    { hora: "09:00 AM", precio: 30, estado: "ocupado" },
    { hora: "10:00 AM", precio: 30, estado: "disponible" },
    { hora: "04:00 PM", precio: 40, estado: "disponible" },
    { hora: "05:00 PM", precio: 40, estado: "ocupado" },
    { hora: "06:00 PM", precio: 50, estado: "disponible" },
  ];

  return (
    <div className="min-h-screen flex flex-col bg-slate-50">
      <Navbar />

      <main className="flex-1 max-w-5xl mx-auto px-6 py-10 w-full">
        <h1 className="text-3xl font-bold text-slate-900 mb-2">Disponibilidad de Horarios</h1>
        <p className="text-slate-500 mb-6">Consulta los horarios disponibles para reservar.</p>

        <div className="bg-white p-6 rounded-3xl border border-slate-100 mb-8 max-w-xs">
          <label className="text-sm font-medium text-slate-700 block mb-2">Seleccionar fecha</label>
          <input
            type="date"
            value={fecha}
            onChange={(e) => setFecha(e.target.value)}
            className="border border-slate-200 rounded-xl p-3 w-full text-slate-900 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
          {horariosEjemplo.map((item, index) => (
            <SlotCard
              key={index}
              hora={item.hora}
              precio={item.precio}
              estado={item.estado}
            />
          ))}
        </div>
      </main>

      <Footer />
    </div>
  );
};