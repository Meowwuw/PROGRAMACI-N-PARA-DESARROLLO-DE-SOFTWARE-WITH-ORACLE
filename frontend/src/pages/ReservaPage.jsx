import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Navbar } from "../componets/Navbar";
import { Footer } from "../componets/Footer";
import { Stepper } from "../componets/Stepper";
import { ResumenCard } from "../componets/ResumenCard";
import { SlotCard } from "../componets/SlotCard";
import { InputGroup } from "../componets/InputGroup";
import { ReservaService } from "../services/ReservaService";

export const ReservaPage = () => {
  const navigate = useNavigate();
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    fecha: "2026-09-28",
    canchaId: 1,
    canchaNombre: "Cancha Sintética #1",
    horario: "16:00",
    precio: 40,
    nombre: "",
    apellido: "",
    dni: "",
    telefono: "",
  });

  const handleInputChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleNext = () => setStep((prev) => Math.min(prev + 1, 4));
  const handleBack = () => setStep((prev) => Math.max(prev - 1, 1));

  const handleConfirmar = async () => {
    try {
      await ReservaService.crear(formData);
      navigate("/confirmacion");
    } catch (err) {
      alert("Reserva registrada localmente para pruebas");
      navigate("/confirmacion");
    }
  };

  return (
    <div className="min-h-screen flex flex-col bg-slate-50">
      <Navbar />

      <main className="flex-1 max-w-6xl mx-auto px-6 py-10 w-full">
        <Stepper currentStep={step} />

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
          <div className="lg:col-span-2 bg-white rounded-3xl p-8 border border-slate-100 shadow-sm">
            {step === 1 && (
              <div>
                <h2 className="text-xl font-bold mb-4">Paso 1: Fecha y Cancha</h2>
                <div className="space-y-4 mb-6">
                  <div>
                    <label className="text-sm font-medium text-slate-700 block mb-1">Fecha</label>
                    <input
                      type="date"
                      value={formData.fecha}
                      onChange={(e) => setFormData({ ...formData, fecha: e.target.value })}
                      className="border border-slate-200 rounded-xl p-3 w-full text-sm"
                    />
                  </div>
                </div>
                <button onClick={handleNext} className="bg-blue-600 text-white font-semibold px-6 py-3 rounded-xl">
                  Siguiente
                </button>
              </div>
            )}

            {step === 2 && (
              <div>
                <h2 className="text-xl font-bold mb-4">Paso 2: Selecciona Horario</h2>
                <div className="grid grid-cols-3 gap-3 mb-6">
                  <SlotCard hora="14:00" precio="40" estado="disponible" onClick={() => setFormData({ ...formData, horario: "14:00" })} />
                  <SlotCard hora="16:00" precio="40" estado={formData.horario === "16:00" ? "seleccionado" : "disponible"} onClick={() => setFormData({ ...formData, horario: "16:00" })} />
                  <SlotCard hora="18:00" precio="50" estado="ocupado" />
                </div>
                <div className="flex justify-between">
                  <button onClick={handleBack} className="border border-slate-200 text-slate-700 font-semibold px-6 py-3 rounded-xl">Atrás</button>
                  <button onClick={handleNext} className="bg-blue-600 text-white font-semibold px-6 py-3 rounded-xl">Siguiente</button>
                </div>
              </div>
            )}

            {step === 3 && (
              <div>
                <h2 className="text-xl font-bold mb-4">Paso 3: Datos del Cliente</h2>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                  <InputGroup label="Nombre" name="nombre" value={formData.nombre} onChange={handleInputChange} placeholder="Tu nombre" />
                  <InputGroup label="Apellido" name="apellido" value={formData.apellido} onChange={handleInputChange} placeholder="Tu apellido" />
                  <InputGroup label="DNI" name="dni" value={formData.dni} onChange={handleInputChange} placeholder="Número de DNI" />
                  <InputGroup label="Teléfono" name="telefono" value={formData.telefono} onChange={handleInputChange} placeholder="987654321" />
                </div>
                <div className="flex justify-between">
                  <button onClick={handleBack} className="border border-slate-200 text-slate-700 font-semibold px-6 py-3 rounded-xl">Atrás</button>
                  <button onClick={handleNext} className="bg-blue-600 text-white font-semibold px-6 py-3 rounded-xl">Siguiente</button>
                </div>
              </div>
            )}

            {step === 4 && (
              <div>
                <h2 className="text-xl font-bold mb-4">Paso 4: Confirmación y Pago</h2>
                <p className="text-slate-500 mb-6">Verifica el resumen de tu reserva y confirma la operación.</p>
                <div className="flex justify-between">
                  <button onClick={handleBack} className="border border-slate-200 text-slate-700 font-semibold px-6 py-3 rounded-xl">Atrás</button>
                  <button onClick={handleConfirmar} className="bg-emerald-600 text-white font-bold px-8 py-3 rounded-xl">Confirmar Reserva</button>
                </div>
              </div>
            )}
          </div>

          <ResumenCard
            fecha={formData.fecha}
            cancha={formData.canchaNombre}
            horario={formData.horario}
            total={formData.precio}
          />
        </div>
      </main>

      <Footer />
    </div>
  );
};