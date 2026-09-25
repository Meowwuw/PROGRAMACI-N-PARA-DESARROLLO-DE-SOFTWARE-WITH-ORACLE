export function HorarioCard({ horario, onEliminar }) {
  return (
    <div style={{ border: "1px solid #ccc", padding: "16px", borderRadius: "8px", margin: "10px" }}>
      <h3>{horario.materia || horario.titulo}</h3>
      <p><strong>Día:</strong> {horario.dia}</p>
      <p><strong>Hora:</strong> {horario.horaInicio} - {horario.horaFin}</p>
      {onEliminar && (
        <button onClick={() => onEliminar(horario.id)} style={{ color: "red" }}>
          Eliminar
        </button>
      )}
    </div>
  );
}