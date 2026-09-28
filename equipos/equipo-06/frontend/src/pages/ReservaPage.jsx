import React, { useState, useEffect } from "react";
import ReservaCard from "../components/ReservaCard.jsx";
import { obtenerReservas, eliminarReserva } from "../services/ReservaService.jsx";
import "../styles/reserva.css";

function ReservaPage() {
  const [reservas, setReservas] = useState([]);
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    obtenerReservas()
      .then((data) => {
        setReservas(data);
        setCargando(false);
      })
      .catch((err) => {
        console.error("Error al obtener las reservas:", err);
        setError("No se pudo conectar con el servidor o cargar los datos.");
        setCargando(false);
      });
  }, []);

  // Manejadores para las acciones de los botones
  const handleEditar = (reserva) => {
    console.log("Editar reserva:", reserva);
    // Navegar a la vista de edición o abrir modal
  };

  const handleEliminar = (id) => {
    console.log("Eliminar reserva con ID:", id);
    // Ejemplo de integración con el servicio DELETE:
    /*
    eliminarReserva(id)
      .then(() => {
        setReservas((prev) => prev.filter((r) => r.id !== id));
      })
      .catch((err) => console.error("Error al eliminar la reserva:", err));
    */
  };

  return (
    <div className="container">
      <h1>Alquiler de Canchas</h1>
      <h2>Reservas</h2>

      {/* Indicador de carga */}
      {cargando && <p className="mensaje-info">Cargando reservas...</p>}

      {/* Mensaje de error o servidor desconectado */}
      {error && <p className="mensaje-error">{error}</p>}

      {/* Estado cuando no hay reservas en la BD */}
      {!cargando && !error && reservas.length === 0 && (
        <p className="mensaje-info">No hay reservas registradas en la base de datos.</p>
      )}

      {/* Renderizado de la lista de reservas */}
      {!cargando && !error && reservas.length > 0 && (
        <div className="reservas">
          {reservas.map((reserva) => (
            <ReservaCard
              key={reserva.id || reserva.idReserva}
              reserva={reserva}
              onEditar={handleEditar}
              onEliminar={handleEliminar}
            />
          ))}
        </div>
      )}
    </div>
  );
}

export default ReservaPage;