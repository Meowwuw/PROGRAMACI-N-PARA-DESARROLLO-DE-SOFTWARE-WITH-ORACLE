import { useEffect, useState } from 'react'
import { Plus } from 'lucide-react'
import Modal from './Modal.jsx'

const API_BASE = 'http://localhost:8080/api'

export default function DetalleConsultaModal({ consulta, servicios, onClose, onCambio }) {
  const [detalles, setDetalles] = useState([])
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState('')

  const [idServicio, setIdServicio] = useState('')
  const [observaciones, setObservaciones] = useState('')
  const [guardando, setGuardando] = useState(false)
  const [errorForm, setErrorForm] = useState('')

  async function cargarDetalles() {
    setCargando(true)
    try {
      const res = await fetch(`${API_BASE}/detalle-consulta-servicio/consulta/${consulta.idConsulta}`)
      if (!res.ok) throw new Error('Respuesta no OK')
      setDetalles(await res.json())
    } catch (err) {
      console.error('Error cargando servicios de la consulta:', err)
      setError('No se pudieron cargar los servicios aplicados.')
    } finally {
      setCargando(false)
    }
  }

  useEffect(() => {
    cargarDetalles()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [consulta.idConsulta])

  const costoServicios = detalles.reduce((suma, d) => suma + Number(d.servicio?.precio ?? 0), 0)
  const costoTotal = Number(consulta.costoBase ?? 0) + costoServicios

  async function handleAgregarServicio(e) {
    e.preventDefault()
    setErrorForm('')

    if (!idServicio) {
      setErrorForm('Selecciona un servicio.')
      return
    }

    setGuardando(true)
    try {
      const res = await fetch(`${API_BASE}/detalle-consulta-servicio`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          consulta: { idConsulta: consulta.idConsulta },
          servicio: { idServicio: Number(idServicio) },
          observaciones: observaciones || null,
        }),
      })

      if (!res.ok) throw new Error('El backend respondió con error al agregar el servicio')

      setIdServicio('')
      setObservaciones('')
      await cargarDetalles()
      onCambio?.()
    } catch (err) {
      console.error('Error agregando servicio:', err)
      setErrorForm('No se pudo agregar el servicio. Inténtalo de nuevo.')
    } finally {
      setGuardando(false)
    }
  }

  return (
    <Modal titulo={`Consulta de ${consulta.mascota?.nombre ?? 'mascota'}`} onClose={onClose}>
      <div className="detalle-consulta">
        <p className="detalle-linea">
          <strong>Veterinario:</strong> {consulta.veterinario?.nombre ?? '—'}
        </p>
        <p className="detalle-linea">
          <strong>Diagnóstico:</strong> {consulta.diagnostico || 'Sin diagnóstico registrado'}
        </p>

        <h3 className="detalle-subtitulo">Servicios aplicados</h3>

        {error && <p className="form-message form-message-error">{error}</p>}

        {cargando ? (
          <p className="empty-hint">Cargando…</p>
        ) : detalles.length === 0 ? (
          <p className="empty-hint">Todavía no se aplicó ningún servicio en esta consulta.</p>
        ) : (
          <ul className="servicios-aplicados-list">
            {detalles.map((d) => (
              <li key={d.idDetalle} className="servicio-aplicado-item">
                <div>
                  <div className="today-item-title">{d.servicio?.nombreServicio ?? 'Servicio'}</div>
                  {d.observaciones && <div className="today-item-sub">{d.observaciones}</div>}
                </div>
                <span className="servicio-precio">S/ {Number(d.servicio?.precio ?? 0).toFixed(2)}</span>
              </li>
            ))}
          </ul>
        )}

        <div className="detalle-total">
          <span>Costo base + servicios</span>
          <strong>S/ {costoTotal.toFixed(2)}</strong>
        </div>

        <form onSubmit={handleAgregarServicio} className="modal-form agregar-servicio-form">
          <div className="form-group">
            <label htmlFor="servicioAplicado">Agregar servicio</label>
            <select
              id="servicioAplicado"
              className="form-control"
              value={idServicio}
              onChange={(e) => setIdServicio(e.target.value)}
            >
              <option value="" disabled>Selecciona un servicio</option>
              {servicios.map((s) => (
                <option key={s.idServicio} value={s.idServicio}>
                  {s.nombreServicio} — S/ {Number(s.precio).toFixed(2)}
                </option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <label htmlFor="observacionesServicio">Observaciones (opcional)</label>
            <input
              id="observacionesServicio"
              className="form-control"
              type="text"
              value={observaciones}
              onChange={(e) => setObservaciones(e.target.value)}
            />
          </div>

          {errorForm && <p className="form-message form-message-error">{errorForm}</p>}

          <button type="submit" className="btn-quick btn-quick-primary" disabled={guardando}>
            <Plus size={16} /> {guardando ? 'Agregando...' : 'Agregar servicio'}
          </button>
        </form>
      </div>
    </Modal>
  )
}
