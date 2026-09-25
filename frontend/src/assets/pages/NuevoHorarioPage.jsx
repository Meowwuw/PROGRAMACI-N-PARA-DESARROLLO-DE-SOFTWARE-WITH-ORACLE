import { useState } from "react";
import { crearHorario } from "../services/HorarioService";

export function NuevoHorarioPage() {
  const [formData, setFormData] = useState({ materia: "", dia: "", horaInicio: "", horaFin: "" });

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await crearHorario(formData);
      alert("Horario creado exitosamente");
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <form onSubmit={handleSubmit} style={{ padding: "20px", maxWidth: "400px" }}>
      <h2>Nuevo Horario</h2>
      <input name="materia" placeholder="Materia" onChange={handleChange} required />
      <input name="dia" placeholder="Día (ej. Lunes)" onChange={handleChange} required />
      <input name="horaInicio" type="time" onChange={handleChange} required />
      <input name="horaFin" type="time" onChange={handleChange} required />
      <button type="submit">Guardar</button>
    </form>
  );
}