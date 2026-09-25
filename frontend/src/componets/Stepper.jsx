import React from "react";

export const Stepper = ({ currentStep }) => {
  const pasos = [
    { num: 1, label: "Fecha y Cancha" },
    { num: 2, label: "Horario" },
    { num: 3, label: "Tus Datos" },
    { num: 4, label: "Pago" },
  ];

  return (
    <div className="flex items-center justify-between max-w-2xl mx-auto mb-10 px-4">
      {pasos.map((paso, index) => {
        const isActive = currentStep >= paso.num;
        const isCurrent = currentStep === paso.num;

        return (
          <React.Fragment key={paso.num}>
            <div className="flex items-center gap-2">
              <div
                className={`w-9 h-9 rounded-full flex items-center justify-center font-bold text-sm transition-colors ${
                  isCurrent
                    ? "bg-blue-600 text-white ring-4 ring-blue-100"
                    : isActive
                    ? "bg-emerald-600 text-white"
                    : "bg-slate-200 text-slate-500"
                }`}
              >
                {paso.num}
              </div>
              <span
                className={`text-xs font-semibold hidden sm:inline ${
                  isActive ? "text-slate-900" : "text-slate-400"
                }`}
              >
                {paso.label}
              </span>
            </div>
            {index < pasos.length - 1 && (
              <div
                className={`flex-1 h-1 mx-2 rounded ${
                  currentStep > paso.num ? "bg-emerald-500" : "bg-slate-200"
                }`}
              />
            )}
          </React.Fragment>
        );
      })}
    </div>
  );
};