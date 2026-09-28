import React, { useState, useEffect } from "react";
import CanchaCard from "../components/CanchaCard.jsx";
import { obtenerCanchas } from "../services/CanchaService.jsx";
import "../styles/cancha.css";

function CanchaPage() {
  const [canchas, setCanchas] = useState([]);
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    obtenerCanchas()
      .then((data) => {
        setCanchas(data);
        setCargando(false);
      })
      .catch((err) => {
        console.error("Error al obtener las canchas:", err);
        setError("No se pudo conectar con el servidor o cargar los datos.");
        setCargando(false);
      });
  }, []);

  // Manejadores para las acciones de los botones
  const handleEditar = (cancha) => {
    console.log("Editar cancha:", cancha);
    // Aquí puedes abrir un modal o navegar a la vista de edición
  };

  const handleEliminar = (id) => {
    console.log("Eliminar cancha con ID:", id);
    // Aquí realizarás la petición DELETE al backend y actualizarás el estado
  };

  return (
    <div className="container">
      <h1>Alquiler de Canchas</h1>
      <h2>Gestión de Canchas</h2>

      {/* Indicador de carga */}
      {cargando && <p className="mensaje-info">Cargando canchas...</p>}

      {/* Mensaje de error o servidor desconectado */}
      {error && <p className="mensaje-error">{error}</p>}

      {/* Estado cuando no hay canchas en la BD */}
      {!cargando && !error && canchas.length === 0 && (
        <p className="mensaje-info">No hay canchas registradas en la base de datos.</p>
      )}

      {/* Renderizado de la lista de canchas */}
      {!cargando && !error && canchas.length > 0 && (
        <div className="canchas-grid">
          {canchas.map((cancha) => (
            <CanchaCard
              key={cancha.id}
              cancha={cancha}
              onEditar={handleEditar}
              onEliminar={handleEliminar}
            />
          ))}
        </div>
      )}
    </div>
  );
}

export default CanchaPage;