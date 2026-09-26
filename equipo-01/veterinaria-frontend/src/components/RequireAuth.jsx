import { Navigate, useLocation } from 'react-router-dom'
import { haySesion } from '../lib/session.js'

export default function RequireAuth({ children }) {
  const location = useLocation()

  if (!haySesion()) {
    // Guarda a dónde quería ir, por si luego quieres redirigir de vuelta
    // ahí mismo después de loguearse.
    return <Navigate to="/login" replace state={{ from: location }} />
  }

  return children
}
