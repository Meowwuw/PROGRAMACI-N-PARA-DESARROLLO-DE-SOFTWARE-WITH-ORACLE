import React from "react";
import { Link } from "react-router-dom";
import { Navbar } from "../componets/Navbar";
import { Footer } from "../componets/Footer";

export const ConfirmacionPage = () => {
  return (
    <div className="min-h-screen flex flex-col bg-slate-50">
      <Navbar />

      <main className="flex-1 max-w-xl mx-auto px-6 py-16 text-center flex flex-col items-center justify-center">
        <div className="w-16 h-16 bg-emerald-100 text-emerald-600 rounded-full flex items-center justify-center text-3xl font-bold mb-6">
          ✓
        </div>
        <h1 className="text-3xl font-extrabold text-slate-900 mb-2">¡Reserva Confirmada!</h1>
        <p className="text-slate-600 mb-8">
          Hemos recibido tu reserva exitosamente. Te esperamos en la cancha seleccionada.
        </p>

        <Link
          to="/"
          className="bg-slate-900 text-white font-semibold px-6 py-3 rounded-xl hover:bg-slate-800 transition-colors"
        >
          Volver al Inicio
        </Link>
      </main>

      <Footer />
    </div>
  );
};