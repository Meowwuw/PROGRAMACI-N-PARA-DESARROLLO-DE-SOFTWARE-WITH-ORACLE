import React from 'react';

function ClienteCard({ cliente, onEditar, onEliminar }) {
  return (
    <div className="cliente-card">
      <h3>{cliente.nombre} {cliente.apellido}</h3>
      <p><strong>Teléfono:</strong> {cliente.telefono}</p>
      <p><strong>DNI:</strong> {cliente.dni}</p>
      <p><strong>Email:</strong> {cliente.email}</p>

      {/* Botones de acción */}
      <div className="card-actions">
        <button className="btn-editar" onClick={() => onEditar && onEditar(cliente)}>
          Editar
        </button>
        <button className="btn-eliminar" onClick={() => onEliminar && onEliminar(cliente.id)}>
          Eliminar
        </button>
      </div>
    </div>
  );
}

export default ClienteCard;