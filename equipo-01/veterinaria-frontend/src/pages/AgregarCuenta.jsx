import { useState } from 'react'
import { Link } from 'react-router-dom'
import BrandPanel from '../components/BrandPanel.jsx'
import HeaderBrand from '../components/HeaderBrand.jsx'

const API_BASE = 'http://localhost:8080/api'

export default function AgregarCuenta() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [rol, setRol] = useState('')
  const [idVeterinario, setIdVeterinario] = useState('')
  const [veterinarios, setVeterinarios] = useState([])
  const [veterinariosCargados, setVeterinariosCargados] = useState(false)
  const [mensaje, setMensaje] = useState({ texto: '', tipo: '' })
  const [enviando, setEnviando] = useState(false)

  // Trae la lista de veterinarios desde el backend, igual que cargarVeterinarios() del JS original
  async function cargarVeterinarios() {
    if (veterinariosCargados) return

    try {
      const response = await fetch(`${API_BASE}/veterinarios`)
      if (!response.ok) throw new Error('No se pudo obtener la lista de veterinarios')

      const data = await response.json()
      setVeterinarios(data)
      setVeterinariosCargados(true)
    } catch (error) {
      console.error('Error cargando veterinarios:', error)
      setMensaje({
        texto: 'No se pudo cargar la lista de veterinarios. Verifica que el backend esté encendido.',
        tipo: 'error',
      })
    }
  }

  function handleRolChange(e) {
    const nuevoRol = e.target.value
    setRol(nuevoRol)

    if (nuevoRol === 'veterinario') {
      cargarVeterinarios()
    } else {
      setIdVeterinario('')
    }
  }

  async function handleSubmit(e) {
    e.preventDefault()

    if (password !== confirmPassword) {
      setMensaje({ texto: 'Las contraseñas no coinciden.', tipo: 'error' })
      return
    }

    if (rol === 'veterinario' && !idVeterinario) {
      setMensaje({ texto: 'Selecciona el veterinario asociado a esta cuenta.', tipo: 'error' })
      return
    }

    // Misma estructura que espera el modelo Usuario.java (email, password, rol, veterinario)
    const nuevoUsuario = {
      email,
      password,
      rol,
      veterinario: rol === 'veterinario' ? { idVeterinario: Number(idVeterinario) } : null,
    }

    setEnviando(true)
    try {
      const response = await fetch(`${API_BASE}/usuarios`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(nuevoUsuario),
      })

      if (response.ok) {
        setMensaje({ texto: '¡Cuenta creada exitosamente! Ya puedes iniciar sesión.', tipo: 'success' })
        setEmail('')
        setPassword('')
        setConfirmPassword('')
        setRol('')
        setIdVeterinario('')
      } else if (response.status === 409) {
        setMensaje({ texto: 'Ese correo ya está registrado.', tipo: 'error' })
      } else {
        setMensaje({ texto: 'Error al crear la cuenta. Verifica los datos.', tipo: 'error' })
      }
    } catch (error) {
      console.error('Error en la petición:', error)
      setMensaje({ texto: 'Error de conexión con el servidor (backend apagado o CORS).', tipo: 'error' })
    } finally {
      setEnviando(false)
    }
  }

  return (
    <div className="auth-shell">
    <div className="main-container">
      <BrandPanel />

      <div className="right-panel">
        <div className="form-wrapper">
          <HeaderBrand />

          <h1 className="login-title">Crear cuenta</h1>
          <p className="login-subtitle">Completa los datos para registrar un nuevo usuario</p>

          <form onSubmit={handleSubmit} autoComplete="off">
            <div className="form-group">
              <label htmlFor="email">Correo electrónico</label>
              <input
                type="email"
                id="email"
                className="form-control"
                required
                placeholder=" "
                value={email}
                onChange={(e) => setEmail(e.target.value)}
              />
            </div>

            <div className="form-group">
              <label htmlFor="password">Contraseña</label>
              <input
                type="password"
                id="password"
                className="form-control"
                required
                minLength={6}
                placeholder=" "
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </div>

            <div className="form-group">
              <label htmlFor="confirmPassword">Confirmar contraseña</label>
              <input
                type="password"
                id="confirmPassword"
                className="form-control"
                required
                minLength={6}
                placeholder=" "
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
              />
            </div>

            <div className="form-group">
              <label htmlFor="rol">Rol</label>
              <select id="rol" className="form-control" required value={rol} onChange={handleRolChange}>
                <option value="" disabled>Selecciona un rol</option>
                <option value="admin">Administrador</option>
                <option value="veterinario">Veterinario</option>
              </select>
            </div>

            {rol === 'veterinario' && (
              <div className="form-group" id="veterinarioGroup">
                <label htmlFor="veterinario">Veterinario asociado</label>
                <select
                  id="veterinario"
                  className="form-control"
                  required
                  value={idVeterinario}
                  onChange={(e) => setIdVeterinario(e.target.value)}
                >
                  <option value="" disabled>Selecciona un veterinario</option>
                  {veterinarios.map((vet) => (
                    <option key={vet.idVeterinario} value={vet.idVeterinario}>
                      {vet.nombre}
                    </option>
                  ))}
                </select>
              </div>
            )}

            <button type="submit" className="btn-submit" disabled={enviando}>
              {enviando ? 'Creando...' : 'Crear cuenta'}
            </button>
          </form>

          {mensaje.texto && (
            <p className={`form-message ${mensaje.tipo === 'success' ? 'form-message-success' : 'form-message-error'}`}>
              {mensaje.texto}
            </p>
          )}

          <p className="create-account-text">
            <Link to="/login" className="create-account-link">Volver al inicio de sesión</Link>
          </p>

          <div className="form-footer">Sistema de gestión veterinaria v2.4.1</div>
        </div>
      </div>
    </div>
    </div>
  )
}
