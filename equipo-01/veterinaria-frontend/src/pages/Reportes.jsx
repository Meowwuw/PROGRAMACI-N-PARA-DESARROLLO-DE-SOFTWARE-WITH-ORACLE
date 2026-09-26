import { useEffect, useState } from 'react'

const API_BASE = 'http://localhost:8080/api'

export default function Reportes() {
  const [consultas, setConsultas] = useState([])
  const [detalles, setDetalles] = useState([])
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    async function cargarDatos() {
      try {
        const [resConsultas, resDetalles] = await Promise.all([
          fetch(`${API_BASE}/consultas`),
          fetch(`${API_BASE}/detalle-consulta-servicio`),
        ])

        if (!resConsultas.ok || !resDetalles.ok) throw new Error('Alguno de los endpoints no respondió OK')

        setConsultas(await resConsultas.json())
        setDetalles(await resDetalles.json())
      } catch (err) {
        console.error('Error cargando reportes:', err)
        setError('No se pudo cargar la información. Verifica que el backend esté encendido.')
      } finally {
        setCargando(false)
      }
    }

    cargarDatos()
  }, [])

  // Consultas por veterinario
  const consultasPorVeterinario = {}
  for (const c of consultas) {
    const nombre = c.veterinario?.nombre ?? 'Sin veterinario'
    consultasPorVeterinario[nombre] = (consultasPorVeterinario[nombre] ?? 0) + 1
  }
  const listaVeterinarios = Object.entries(consultasPorVeterinario).sort((a, b) => b[1] - a[1])
  const maxConsultas = Math.max(1, ...listaVeterinarios.map(([, n]) => n))

  // Ingresos por servicio (a partir de detalle_consulta_servicio)
  const ingresosPorServicio = {}
  for (const d of detalles) {
    const nombre = d.servicio?.nombreServicio ?? 'Servicio'
    const precio = Number(d.servicio?.precio ?? 0)
    ingresosPorServicio[nombre] = (ingresosPorServicio[nombre] ?? 0) + precio
  }
  const listaServicios = Object.entries(ingresosPorServicio).sort((a, b) => b[1] - a[1])
  const maxIngreso = Math.max(1, ...listaServicios.map(([, n]) => n))

  const ingresoBase = consultas.reduce((suma, c) => suma + Number(c.costoBase ?? 0), 0)
  const ingresoServicios = detalles.reduce((suma, d) => suma + Number(d.servicio?.precio ?? 0), 0)
  const ingresoTotal = ingresoBase + ingresoServicios

  return (
    <div className="page-duenos">
      <div className="page-title-row">
        <div>
          <h1 className="page-title">Reportes</h1>
          <p className="page-subtitle">Calculado a partir de tus consultas y servicios aplicados</p>
        </div>
      </div>

      {error && <p className="form-message form-message-error">{error}</p>}

      <div className="stats-grid" style={{ gridTemplateColumns: 'repeat(3, 1fr)' }}>
        <div className="stat-card">
          <div className="stat-value">{cargando ? '…' : consultas.length}</div>
          <div className="stat-label">Consultas totales</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">{cargando ? '…' : `S/ ${ingresoTotal.toFixed(2)}`}</div>
          <div className="stat-label">Ingresos totales (base + servicios)</div>
        </div>
        <div className="stat-card">
          <div className="stat-value">{cargando ? '…' : detalles.length}</div>
          <div className="stat-label">Servicios aplicados</div>
        </div>
      </div>

      <div className="home-grid">
        <div className="panel">
          <h2>Consultas por veterinario</h2>
          {cargando ? (
            <p className="empty-hint">Cargando…</p>
          ) : listaVeterinarios.length === 0 ? (
            <p className="empty-hint">Todavía no hay consultas registradas.</p>
          ) : (
            <div className="bar-chart">
              {listaVeterinarios.map(([nombre, cantidad]) => (
                <div key={nombre} className="bar-row">
                  <span className="bar-label">{nombre}</span>
                  <div className="bar-track">
                    <div
                      className="bar-fill bar-fill-mint"
                      style={{ width: `${(cantidad / maxConsultas) * 100}%` }}
                    />
                  </div>
                  <span className="bar-value">{cantidad}</span>
                </div>
              ))}
            </div>
          )}
        </div>

        <div className="panel">
          <h2>Ingresos por servicio</h2>
          {cargando ? (
            <p className="empty-hint">Cargando…</p>
          ) : listaServicios.length === 0 ? (
            <p className="empty-hint">Todavía no se aplicó ningún servicio.</p>
          ) : (
            <div className="bar-chart">
              {listaServicios.map(([nombre, monto]) => (
                <div key={nombre} className="bar-row">
                  <span className="bar-label">{nombre}</span>
                  <div className="bar-track">
                    <div
                      className="bar-fill bar-fill-teal"
                      style={{ width: `${(monto / maxIngreso) * 100}%` }}
                    />
                  </div>
                  <span className="bar-value">S/ {monto.toFixed(2)}</span>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
