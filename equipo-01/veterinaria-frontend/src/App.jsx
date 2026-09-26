import { Routes, Route } from 'react-router-dom'
import Login from './pages/Login.jsx'
import AgregarCuenta from './pages/AgregarCuenta.jsx'
import Layout from './components/Layout.jsx'
import RequireAuth from './components/RequireAuth.jsx'
import Home from './pages/Home.jsx'
import Duenos from './pages/Duenos.jsx'
import Mascotas from './pages/Mascotas.jsx'
import Consultas from './pages/Consultas.jsx'
import Servicios from './pages/Servicios.jsx'
import Veterinarios from './pages/Veterinarios.jsx'
import Catalogos from './pages/Catalogos.jsx'
import Reportes from './pages/Reportes.jsx'
import Perfil from './pages/Perfil.jsx'

export default function App() {
  return (
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route path="/agregar-cuenta" element={<AgregarCuenta />} />

      <Route
        element={
          <RequireAuth>
            <Layout />
          </RequireAuth>
        }
      >
        <Route path="/" element={<Home />} />
        <Route path="/duenos" element={<Duenos />} />
        <Route path="/mascotas" element={<Mascotas />} />
        <Route path="/consultas" element={<Consultas />} />
        <Route path="/servicios" element={<Servicios />} />
        <Route path="/veterinarios" element={<Veterinarios />} />
        <Route path="/catalogos" element={<Catalogos />} />
        <Route path="/reportes" element={<Reportes />} />
        <Route path="/perfil" element={<Perfil />} />
      </Route>
    </Routes>
  )
}
