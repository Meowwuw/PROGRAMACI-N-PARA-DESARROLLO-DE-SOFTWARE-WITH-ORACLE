import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import BrandPanel from '../components/BrandPanel.jsx'
import HeaderBrand from '../components/HeaderBrand.jsx'
import { guardarSesion } from '../lib/session.js'

const API_BASE = 'http://localhost:8080/api'

export default function Login() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [mensaje, setMensaje] = useState({ texto: '', tipo: '' })
  const [enviando, setEnviando] = useState(false)
  const navigate = useNavigate()

  async function handleSubmit(e) {
    e.preventDefault()
    setEnviando(true)
    setMensaje({ texto: '', tipo: '' })

    try {
      // Confirmado con UsuarioController.java: POST /api/usuarios/login,
      // body {email, password}, responde el objeto Usuario completo.
      const response = await fetch(`${API_BASE}/usuarios/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password }),
      })

      if (response.ok) {
        const usuario = await response.json()
        // No guardamos el password en localStorage aunque el backend lo
        // devuelva; no hace falta tenerlo en el navegador para nada.
        const { password: _password, ...datosUsuario } = usuario

        guardarSesion(datosUsuario)
        setMensaje({ texto: 'Sesión iniciada correctamente.', tipo: 'success' })
        navigate('/')
      } else if (response.status === 401) {
        setMensaje({ texto: 'Correo o contraseña incorrectos.', tipo: 'error' })
      } else {
        setMensaje({ texto: 'No se pudo iniciar sesión. Intenta de nuevo.', tipo: 'error' })
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

          <h1 className="login-title">Iniciar sesión</h1>
          <p className="login-subtitle">Ingresa tus credenciales para continuar</p>

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
              <div className="password-input-wrapper">
                <input
                  type={showPassword ? 'text' : 'password'}
                  id="password"
                  className="form-control"
                  required
                  placeholder=" "
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                />
                <button
                  type="button"
                  className="toggle-password"
                  aria-label="Mostrar u ocultar contraseña"
                  onClick={() => setShowPassword((v) => !v)}
                >
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                    <circle cx="12" cy="12" r="3"></circle>
                  </svg>
                </button>
              </div>
              <div className="forgot-password-wrapper">
                <a href="#" className="forgot-password-link">¿Olvidaste tu contraseña?</a>
              </div>
            </div>

            <button type="submit" className="btn-submit" disabled={enviando}>
              {enviando ? 'Ingresando...' : 'Ingresar'}
            </button>
          </form>

          {mensaje.texto && (
            <p className={`form-message ${mensaje.tipo === 'success' ? 'form-message-success' : 'form-message-error'}`}>
              {mensaje.texto}
            </p>
          )}

          <p className="create-account-text">
            ¿No tienes cuenta? <Link to="/agregar-cuenta" className="create-account-link">Crear una cuenta</Link>
          </p>

          <div className="form-footer">Sistema de gestión veterinaria v2.4.1</div>
        </div>
      </div>
    </div>
    </div>
  )
}
