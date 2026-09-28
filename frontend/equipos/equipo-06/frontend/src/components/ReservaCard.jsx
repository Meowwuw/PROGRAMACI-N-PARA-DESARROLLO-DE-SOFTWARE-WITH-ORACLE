import React from 'react';

function ReservaCard({ reserva, onEditar, onEliminar }) {
  // Manejo flexible del ID (por si tu backend usa "id" o "idReserva")
  const idReserva = reserva.id || reserva.idReserva;

  return (
    <div className="reserva-card">
      <div>
        <h3>Reserva #{idReserva}</h3>

        {/* Cancha reservada */}
        <p>
          <strong>Cancha:</strong> {reserva.cancha?.nombre || reserva.cancha || "No especificada"}
        </p>

        {/* Cliente que realizó la reserva */}
        <p>
          <strong>Cliente:</strong> {
            reserva.cliente 
              ? `${reserva.cliente.nombre} ${reserva.cliente.apellido}` 
              : reserva.nombreCliente || "Cliente general"
          }
        </p>

        {/* Fecha y Horario */}
        <p>
          <strong>Fecha:</strong> {reserva.fecha}
        </p>
        <p>
          <strong>Hora:</strong> {reserva.horaInicio} - {reserva.horaFin}
        </p>

        {/* Precio o Monto */}
        <p>
          <strong>Total:</strong> S/ {reserva.precioTotal || reserva.monto || "0.00"}
        </p>

        {/* Estado opcional con badge */}
        {reserva.estado && (
          <p>
            <strong>Estado: </strong>
            <span className={`badge-estado badge-${reserva.estado.toLowerCase()}`}>
              {reserva.estado}
            </span>
          </p>
        )}
      </div>

      {/* Botones de acción */}
      <div className="card-actions">
        <button className="btn-editar" onClick={() => onEditar && onEditar(reserva)}>
          Editar
        </button>
        <button className="btn-eliminar" onClick={() => onEliminar && onEliminar(idReserva)}>
          Eliminar
        </button>
      </div>
    </div>
  );
}

export default ReservaCard;