import React, { useState, useEffect } from "react";
import ClienteCard from "../components/ClienteCard.jsx";
import { obtenerCliente } from "../services/ClienteService.jsx";
import "../styles/cliente.css";

function ClientePage() {
  const [clientes, setClientes] = useState([]);
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    obtenerCliente()
      .then((data) => {
        setClientes(data);
        setCargando(false);
      })
      .catch((err) => {
        console.error("Error al obtener los clientes:", err);
        setError("No se pudo conectar con el servidor o cargar los datos.");
        setCargando(false);
      });
  }, []);

  // Manejadores para las acciones de los botones
  const handleEditar = (cliente) => {
    console.log("Editar cliente:", cliente);
    // Aquí puedes navegar a la vista de edición o abrir un modal
  };

  const handleEliminar = (id) => {
    console.log("Eliminar cliente con ID:", id);
    // Aquí realizarás la petición DELETE al backend y actualizarás el estado
  };

  return (
    <div className="container">
      <h1>Alquiler de Canchas</h1>
      <h2>Clientes</h2>

      {/* Indicador de carga */}
      {cargando && <p className="mensaje-info">Cargando clientes...</p>}

      {/* Mensaje de error o servidor desconectado */}
      {error && <p className="mensaje-error">{error}</p>}

      {/* Estado cuando no hay clientes en la BD */}
      {!cargando && !error && clientes.length === 0 && (
        <p className="mensaje-info">No hay clientes registrados en la base de datos.</p>
      )}

      {/* Renderizado de la lista de clientes */}
      {!cargando && !error && clientes.length > 0 && (
        <div className="clientes">
          {clientes.map((cliente) => (
            <ClienteCard
              key={cliente.id}
              cliente={cliente}
              onEditar={handleEditar}
              onEliminar={handleEliminar}
            />
          ))}
        </div>
      )}
    </div>
  );
}

export default ClientePage;