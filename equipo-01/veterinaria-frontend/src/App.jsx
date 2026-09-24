import { Routes, Route } from 'react-router-dom'
import Login from './pages/Login.jsx'
import AgregarCuenta from './pages/AgregarCuenta.jsx'

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Login />} />
      <Route path="/agregar-cuenta" element={<AgregarCuenta />} />
    </Routes>
  )
}
