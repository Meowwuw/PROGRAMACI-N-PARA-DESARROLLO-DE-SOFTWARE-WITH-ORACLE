import { useState } from "react";
import { actualizarHorario } from "../services/HorarioService";

export function EditarHorarioPage({ horarioExistente }) {
  const [formData, setFormData] = useState(horarioExistente || { materia: "", dia: "" });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await actualizarHorario(formData.id, formData);
      alert("Horario actualizado");
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <form onSubmit={handleSubmit} style={{ padding: "20px" }}>
      <h2>Editar Horario</h2>
      <input 
        value={formData.materia} 
        onChange={(e) => setFormData({ ...formData, materia: e.target.value })} 
      />
      <button type="submit">Actualizar</button>
    </form>
  );
}