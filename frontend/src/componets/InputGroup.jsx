import React from "react";

export const InputGroup = ({ label, type = "text", name, placeholder, value, onChange }) => {
  return (
    <div className="flex flex-col gap-1.5">
      <label className="text-sm font-medium text-slate-700">{label}</label>
      <input
        type={type}
        name={name}
        placeholder={placeholder}
        value={value}
        onChange={onChange}
        className="border border-slate-200 bg-slate-50 rounded-xl p-3 text-sm text-slate-900 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-white transition-all w-full"
        required
      />
    </div>
  );
};