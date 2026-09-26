import { useEffect, useMemo, useState } from 'react'
import { ChevronRight, Plus } from 'lucide-react'
import Modal from '../components/Modal.jsx'

const API_BASE = 'http://localhost:8080/api'

export default function Duenos() {
  const [duenos, setDuenos] = useState([])
  const [mascotas, setMascotas] = useState([])
  const [busqueda, setBusqueda] = useState('')
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState('')

  const [modalAbierto, setModalAbierto] = useState(false)
  const [guardando, setGuardando] = useState(false)
  const [errorForm, setErrorForm] = useState('')
  const [form, setForm] = useState({ nombre: '', telefono: '', direccion: '' })

  async function cargarDatos() {
    setCargando(true)
    try {
      const [resDuenos, resMascotas] = await Promise.all([
        fetch(`${API_BASE}/duenos`),
        fetch(`${API_BASE}/mascotas`),
      ])

      if (!resDuenos.ok || !resMascotas.ok) {
        throw new Error('Alguno de los endpoints no respondió OK')
      }

      setDuenos(await resDuenos.json())
      setMascotas(await resMascotas.json())
    } catch (err) {
      console.error('Error cargando dueños:', err)
      setError('No se pudo cargar la lista de dueños. Verifica que el backend esté encendido.')
    } finally {
      setCargando(false)
    }
  }

  useEffect(() => {
    cargarDatos()
  }, [])

  // Cuenta mascotas por dueño sin tener que pedirlo al backend uno por uno
  const cantidadMascotasPorDueno = useMemo(() => {
    const conteo = {}
    for (const m of mascotas) {
      const id = m.dueno?.idDueno
      if (id != null) conteo[id] = (conteo[id] ?? 0) + 1
    }
    return conteo
  }, [mascotas])

  const duenosFiltrados = duenos.filter((d) => {
    const texto = busqueda.trim().toLowerCase()
    if (!texto) return true
    return (
      d.nombre.toLowerCase().includes(texto) ||
      (d.telefono ?? '').toLowerCase().includes(texto)
    )
  })

  function iniciales(nombre) {
    return nombre
      .split(' ')
      .map((p) => p[0])
      .slice(0, 2)
      .join('')
      .toUpperCase()
  }

  function abrirModal() {
    setForm({ nombre: '', telefono: '', direccion: '' })
    setErrorForm('')
    setModalAbierto(true)
  }

  async function handleSubmit(e) {
    e.preventDefault()
    setErrorForm('')

    if (!form.nombre.trim()) {
      setErrorForm('El nombre es obligatorio.')
      return
    }

    setGuardando(true)
    try {
      const response = await fetch(`${API_BASE}/duenos`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(form),
      })

      if (!response.ok) throw new Error('El backend respondió con error al crear el dueño')

      setModalAbierto(false)
      await cargarDatos()
    } catch (err) {
      console.error('Error creando dueño:', err)
      setErrorForm('No se pudo guardar el dueño. Revisa los datos e inténtalo de nuevo.')
    } finally {
      setGuardando(false)
    }
  }

  return (
    <div className="page-duenos">
      <div className="page-title-row">
        <div>
          <h1 className="page-title">Dueños</h1>
          <p className="page-subtitle">{cargando ? '…' : `${duenos.length} registros`}</p>
        </div>
        <button type="button" className="btn-submit btn-inline" onClick={abrirModal}>
          <Plus size={16} /> Agregar dueño
        </button>
      </div>

      <div className="table-search">
        <input
          type="text"
          placeholder="Buscar por nombre, teléfono..."
          value={busqueda}
          onChange={(e) => setBusqueda(e.target.value)}
        />
      </div>

      {error && <p className="form-message form-message-error">{error}</p>}

      <div className="panel panel-table">
        <table className="data-table">
          <thead>
            <tr>
              <th>Nombre</th>
              <th>Teléfono</th>
              <th>Dirección</th>
              <th>Mascotas</th>
              <th aria-hidden="true"></th>
            </tr>
          </thead>
          <tbody>
            {cargando && (
              <tr>
                <td colSpan={5} className="empty-hint">Cargando…</td>
              </tr>
            )}

            {!cargando && duenosFiltrados.length === 0 && (
              <tr>
                <td colSpan={5} className="empty-hint">No se encontraron dueños.</td>
              </tr>
            )}

            {duenosFiltrados.map((d) => (
              <tr key={d.idDueno} className="data-row">
                <td>
                  <div className="row-person">
                    <span className="row-avatar">{iniciales(d.nombre)}</span>
                    <span>{d.nombre}</span>
                  </div>
                </td>
                <td>{d.telefono || '—'}</td>
                <td>{d.direccion || '—'}</td>
                <td>
                  <span className="badge-count">{cantidadMascotasPorDueno[d.idDueno] ?? 0}</span>
                </td>
                <td className="row-chevron"><ChevronRight size={18} /></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {modalAbierto && (
        <Modal titulo="Agregar dueño" onClose={() => setModalAbierto(false)}>
          <form onSubmit={handleSubmit} className="modal-form">
            <div className="form-group">
              <label htmlFor="nombreDueno">Nombre</label>
              <input
                id="nombreDueno"
                className="form-control"
                type="text"
                value={form.nombre}
                onChange={(e) => setForm({ ...form, nombre: e.target.value })}
                required
              />
            </div>

            <div className="form-group">
              <label htmlFor="telefonoDueno">Teléfono (opcional)</label>
              <input
                id="telefonoDueno"
                className="form-control"
                type="text"
                value={form.telefono}
                onChange={(e) => setForm({ ...form, telefono: e.target.value })}
              />
            </div>

            <div className="form-group">
              <label htmlFor="direccionDueno">Dirección (opcional)</label>
              <input
                id="direccionDueno"
                className="form-control"
                type="text"
                value={form.direccion}
                onChange={(e) => setForm({ ...form, direccion: e.target.value })}
              />
            </div>

            {errorForm && <p className="form-message form-message-error">{errorForm}</p>}

            <button type="submit" className="btn-submit" disabled={guardando}>
              {guardando ? 'Guardando...' : 'Guardar dueño'}
            </button>
          </form>
        </Modal>
      )}
    </div>
  )
}
