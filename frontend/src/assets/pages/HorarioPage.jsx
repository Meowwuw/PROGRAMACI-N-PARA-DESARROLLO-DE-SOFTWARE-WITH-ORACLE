import { useEffect, useState } from "react";
import { obtenerHorarios, eliminarHorario } from "../services/HorarioService";
import { HorarioCard } from "../components/HorarioCard";

export function HorarioPage() {
  const [horarios, setHorarios] = useState([]);

  useEffect(() => {
    cargarHorarios();
  }, []);

  const cargarHorarios = async () => {
    try {
      const data = await obtenerHorarios();
      setHorarios(data);
    } catch (error) {
      console.error(error);
    }
  };

  const handleEliminar = async (id) => {
    try {
      await eliminarHorario(id);
      setHorarios(horarios.filter((h) => h.id !== id));
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>Lista de Horarios</h1>
      <div>
        {horarios.map((h) => (
          <HorarioCard key={h.id} horario={h} onEliminar={handleEliminar} />
        ))}
      </div>
    </div>
  );
}