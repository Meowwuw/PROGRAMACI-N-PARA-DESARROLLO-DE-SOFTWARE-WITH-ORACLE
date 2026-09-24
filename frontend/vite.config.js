import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// Configuración de Vite para correr exactamente en el puerto 6767
export default defineConfig({
  plugins: [react()],
  server: {
    port: 6767,
    open: true
  }
});