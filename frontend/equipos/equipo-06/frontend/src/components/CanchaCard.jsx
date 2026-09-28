import React from 'react';

function CanchaCard({ cancha, onEditar, onEliminar }) {
  // Validación de seguridad para evitar pantallas en blanco si el objeto llega indefinido
  if (!cancha) return null;

  return (
    <div className="cancha-card">
      <h3>{cancha.nombre || 'Cancha sin nombre'}</h3>
      <p><strong>Tipo / Deporte:</strong> {cancha.tipoDeporte || cancha.tipo || 'No especificado'}</p>
      <p><strong>Precio por Hora:</strong> S/ {cancha.precioPorHora || cancha.precio || 0}</p>
      <p>
        <strong>Estado:</strong>{' '}
        <span className={`estado ${cancha.disponible ? 'disponible' : 'ocupado'}`}>
          {cancha.disponible ? 'Disponible' : 'No disponible'}
        </span>
      </p>

      {/* Botones de acción */}
      <div className="card-actions">
        <button className="btn-editar" onClick={() => onEditar && onEditar(cancha)}>
          Editar
        </button>
        <button className="btn-eliminar" onClick={() => onEliminar && onEliminar(cancha.id)}>
          Eliminar
        </button>
      </div>
    </div>
  );
}

export default CanchaCard;