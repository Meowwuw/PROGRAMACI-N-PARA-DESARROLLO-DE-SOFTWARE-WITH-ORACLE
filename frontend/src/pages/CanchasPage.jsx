import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { Navbar } from "../componets/Navbar";
import { Footer } from "../componets/Footer";
import { CanchasCard } from "../componets/CanchasCard";
import { CanchaService } from "../services/CanchaService";

export const CanchasPage = () => {
  const [canchas, setCanchas] = useState([]);
  const [cargando, setCargando] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    CanchaService.obtenerTodas()
      .then((data) => setCanchas(data))
      .catch((err) => console.error("Error al cargar canchas:", err))
      .finally(() => setCargando(false));
  }, []);

  return (
    <div className="min-h-screen flex flex-col bg-slate-50">
      <Navbar />

      <main className="flex-1 max-w-7xl mx-auto px-6 py-10 w-full">
        <h1 className="text-3xl font-bold text-slate-900 mb-2">Nuestras Canchas</h1>
        <p className="text-slate-500 mb-8">Selecciona la cancha que deseas alquilar.</p>

        {cargando ? (
          <p className="text-slate-500 text-center py-10">Cargando canchas...</p>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {canchas.map((cancha) => (
              <CanchasCard
                key={cancha.id || cancha.idCancha}
                nombre={cancha.nombre}
                tipo={cancha.tipo}
                precioHora={cancha.precioHora || cancha.precio}
                imagen={cancha.imagenUrl}
                onSelect={() => navigate("/reserva")}
              />
            ))}
          </div>
        )}
      </main>

      <Footer />
    </div>
  );
};