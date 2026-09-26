import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { FileEdit, PawPrint, User, CalendarDays, Plus } from 'lucide-react'
import { obtenerSesion } from '../lib/session.js'

const API_BASE = 'http://localhost:8080/api'

function esHoy(fechaHoraStr) {
  if (!fechaHoraStr) return false
  const fecha = new Date(fechaHoraStr)
  const hoy = new Date()
  return (
    fecha.getFullYear() === hoy.getFullYear() &&
    fecha.getMonth() === hoy.getMonth() &&
    fecha.getDate() === hoy.getDate()
  )
}

function formatearFechaLarga(date) {
  const texto = date.toLocaleDateString('es-PE', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  })
  return texto.charAt(0).toUpperCase() + texto.slice(1)
}

export default function Home() {
  const [consultas, setConsultas] = useState([])
  const [mascotas, setMascotas] = useState([])
  const [duenos, setDuenos] = useState([])
  const [veterinarios, setVeterinarios] = useState([])
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    async function cargarDatos() {
      try {
        const [resConsultas, resMascotas, resDuenos, resVeterinarios] = await Promise.all([
          fetch(`${API_BASE}/consultas`),
          fetch(`${API_BASE}/mascotas`),
          fetch(`${API_BASE}/duenos`),
          fetch(`${API_BASE}/veterinarios`),
        ])

        if (!resConsultas.ok || !resMascotas.ok || !resDuenos.ok || !resVeterinarios.ok) {
          throw new Error('Alguno de los endpoints no respondió OK')
        }

        setConsultas(await resConsultas.json())
        setMascotas(await resMascotas.json())
        setDuenos(await resDuenos.json())
        setVeterinarios(await resVeterinarios.json())
      } catch (err) {
        console.error('Error cargando el dashboard:', err)
        setError('No se pudo cargar la información. Verifica que el backend esté encendido.')
      } finally {
        setCargando(false)
      }
    }

    cargarDatos()
  }, [])

  const consultasHoy = consultas.filter((c) => esHoy(c.fechaHora))
  const proximasCitas = consultas.filter((c) => c.fechaHora && new Date(c.fechaHora) > new Date())

  const sesion = obtenerSesion()
  // El backend devuelve { idUsuario, email, rol, veterinario }. Si el rol es
  // veterinario, veterinario.nombre trae el nombre real; si es admin, no hay
  // "nombre" propio en la tabla usuarios, así que usamos el email.
  const nombreSaludo = sesion?.veterinario?.nombre || sesion?.email || ''

  return (
    <div className="page-home">
      <h1 className="page-title">{nombreSaludo ? `Buenos días, ${nombreSaludo}` : 'Buenos días'}</h1>
      <p className="page-subtitle">{formatearFechaLarga(new Date())}</p>

      {error && <p className="form-message form-message-error">{error}</p>}

      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-icon stat-icon-mint"><FileEdit size={20} /></div>
          <div className="stat-value">{cargando ? '…' : consultasHoy.length}</div>
          <div className="stat-label">Consultas hoy</div>
        </div>

        <div className="stat-card">
          <div className="stat-icon stat-icon-teal"><PawPrint size={20} /></div>
          <div className="stat-value">{cargando ? '…' : mascotas.length}</div>
          <div className="stat-label">Mascotas registradas</div>
        </div>

        <div className="stat-card">
          <div className="stat-icon stat-icon-slate"><User size={20} /></div>
          <div className="stat-value">{cargando ? '…' : duenos.length}</div>
          <div className="stat-label">Dueños activos</div>
        </div>

        <div className="stat-card">
          <div className="stat-icon stat-icon-slate"><CalendarDays size={20} /></div>
          <div className="stat-value">{cargando ? '…' : proximasCitas.length}</div>
          <div className="stat-label">Próximas citas</div>
        </div>
      </div>

      <div className="home-grid">
        <div className="panel">
          <div className="panel-header">
            <h2>Consultas de hoy</h2>
            <Link to="/consultas" className="panel-link">Ver todas</Link>
          </div>

          {consultasHoy.length === 0 ? (
            <p className="empty-hint">No hay consultas registradas para hoy.</p>
          ) : (
            <ul className="today-list">
              {consultasHoy.map((c) => (
                <li key={c.idConsulta} className="today-item">
                  <span className="today-item-icon"><PawPrint size={16} /></span>
                  <div>
                    <div className="today-item-title">{c.mascota?.nombre ?? 'Mascota'}</div>
                    <div className="today-item-sub">{c.diagnostico || 'Sin diagnóstico registrado'}</div>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </div>

        <div className="home-side">
          <div className="panel">
            <h2>Accesos rápidos</h2>
            <div className="quick-actions">
              {/* Dueños, Mascotas y Consultas ya navegan de verdad. */}
              <Link to="/consultas" className="btn-quick btn-quick-primary">
                <Plus size={16} /> Nueva consulta
              </Link>
              <Link to="/duenos" className="btn-quick btn-quick-secondary">
                <Plus size={16} /> Nuevo dueño
              </Link>
              <Link to="/mascotas" className="btn-quick btn-quick-light">
                <Plus size={16} /> Nueva mascota
              </Link>
            </div>
          </div>

          <div className="panel">
            <h2>Veterinarios activos</h2>
            {veterinarios.length === 0 ? (
              <p className="empty-hint">Aún no hay veterinarios registrados.</p>
            ) : (
              <ul className="vet-list">
                {veterinarios.map((v) => (
                  <li key={v.idVeterinario} className="vet-item">
                    <span className="vet-avatar">
                      {v.nombre.split(' ').map((p) => p[0]).slice(0, 2).join('').toUpperCase()}
                    </span>
                    <div>
                      <div className="vet-item-title">{v.nombre}</div>
                      <div className="vet-item-sub">{v.especialidad || 'Sin especialidad registrada'}</div>
                    </div>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
