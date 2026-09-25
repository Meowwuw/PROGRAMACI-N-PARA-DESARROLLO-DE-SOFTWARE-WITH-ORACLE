import React from "react";
import { Link, useLocation } from "react-router-dom";

export const Navbar = () => {
  const location = useLocation();

  const isActive = (path) => location.pathname === path;

  return (
    <header className="bg-white border-b border-slate-100 sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-6 h-20 flex items-center justify-between">
        {/* Logo */}
        <Link to="/" className="flex items-center gap-3">
          <div className="w-10 h-10 bg-blue-600 text-white font-black text-xl rounded-xl flex items-center justify-center shadow-md shadow-blue-500/20">
            V
          </div>
          <span className="text-xl font-extrabold text-slate-900 tracking-tight">
            CanchaVóley
          </span>
        </Link>

        {/* Navegación Desktop */}
        <nav className="hidden md:flex items-center gap-8 text-sm font-medium text-slate-600">
          <Link
            to="/"
            className={`transition-colors hover:text-blue-600 ${
              isActive("/") ? "text-slate-900 font-semibold" : ""
            }`}
          >
            Inicio
          </Link>
          <Link
            to="/canchas"
            className={`transition-colors hover:text-blue-600 ${
              isActive("/canchas") ? "text-slate-900 font-semibold" : ""
            }`}
          >
            Canchas
          </Link>
          <Link
            to="/horarios"
            className={`transition-colors hover:text-blue-600 ${
              isActive("/horarios") ? "text-slate-900 font-semibold" : ""
            }`}
          >
            Horarios
          </Link>
          <Link
            to="/contacto"
            className={`transition-colors hover:text-blue-600 ${
              isActive("/contacto") ? "text-slate-900 font-semibold" : ""
            }`}
          >
            Contacto
          </Link>
        </nav>

        {/* Botón Acción */}
        <Link
          to="/reserva"
          className="bg-blue-600 hover:bg-blue-700 text-white font-bold text-sm px-6 py-2.5 rounded-xl shadow-md shadow-blue-600/20 transition-all hover:shadow-lg"
        >
          Reservar
        </Link>
      </div>
    </header>
  );
};