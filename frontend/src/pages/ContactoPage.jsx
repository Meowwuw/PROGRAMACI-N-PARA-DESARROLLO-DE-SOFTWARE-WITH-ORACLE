import React from "react";
import { Navbar } from "../componets/Navbar";
import { Footer } from "../componets/Footer";
import { InputGroup } from "../componets/InputGroup";

export const ContactoPage = () => {
  return (
    <div className="min-h-screen flex flex-col bg-slate-50">
      <Navbar />

      <main className="flex-1 max-w-2xl mx-auto px-6 py-12 w-full">
        <h1 className="text-3xl font-bold text-slate-900 mb-2">Contáctanos</h1>
        <p className="text-slate-500 mb-8">¿Tienes alguna duda o inconveniente? Escríbenos.</p>

        <form className="bg-white p-8 rounded-3xl border border-slate-100 shadow-sm space-y-4">
          <InputGroup label="Nombre completo" placeholder="Ej. Juan Pérez" />
          <InputGroup label="Correo electrónico" type="email" placeholder="correo@ejemplo.com" />
          <div className="flex flex-col gap-1.5">
            <label className="text-sm font-medium text-slate-700">Mensaje</label>
            <textarea
              rows="4"
              placeholder="Escribe tu mensaje..."
              className="border border-slate-200 bg-slate-50 rounded-xl p-3 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-blue-500"
            ></textarea>
          </div>
          <button
            type="submit"
            className="w-full bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-3.5 rounded-xl transition-all"
          >
            Enviar mensaje
          </button>
        </form>
      </main>

      <Footer />
    </div>
  );
};