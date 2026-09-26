import { useEffect, useState } from 'react'
import { ChevronRight, Plus } from 'lucide-react'
import Modal from '../components/Modal.jsx'

const API_BASE = 'http://localhost:8080/api'

function calcularEdad(fechaNacimiento) {
  if (!fechaNacimiento) return '—'
  const nacimiento = new Date(fechaNacimiento)
  const hoy = new Date()
  let edad = hoy.getFullYear() - nacimiento.getFullYear()
  const meses = hoy.getMonth() - nacimiento.getMonth()
  if (meses < 0 || (meses === 0 && hoy.getDate() < nacimiento.getDate())) edad--
  return edad <= 0 ? 'Menos de 1 año' : `${edad} año${edad === 1 ? '' : 's'}`
}

export default function Mascotas() {
  const [mascotas, setMascotas] = useState([])
  const [duenos, setDuenos] = useState([])
  const [razas, setRazas] = useState([])
  const [busqueda, setBusqueda] = useState('')
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState('')

  const [modalAbierto, setModalAbierto] = useState(false)
  const [guardando, setGuardando] = useState(false)
  const [errorForm, setErrorForm] = useState('')
  const [form, setForm] = useState({ nombre: '', idDueno: '', idRaza: '', fechaNacimiento: '' })

  async function cargarDatos() {
    setCargando(true)
    try {
      const [resMascotas, resDuenos, resRazas] = await Promise.all([
        fetch(`${API_BASE}/mascotas`),
        fetch(`${API_BASE}/duenos`),
        fetch(`${API_BASE}/razas`),
      ])

      if (!resMascotas.ok || !resDuenos.ok || !resRazas.ok) {
        throw new Error('Alguno de los endpoints no respondió OK')
      }

      setMascotas(await resMascotas.json())
      setDuenos(await resDuenos.json())
      setRazas(await resRazas.json())
    } catch (err) {
      console.error('Error cargando mascotas:', err)
      setError('No se pudo cargar la información. Verifica que el backend esté encendido.')
    } finally {
      setCargando(false)
    }
  }

  useEffect(() => {
    cargarDatos()
  }, [])

  const mascotasFiltradas = mascotas.filter((m) => {
    const texto = busqueda.trim().toLowerCase()
    if (!texto) return true
    return (
      m.nombre.toLowerCase().includes(texto) ||
      (m.dueno?.nombre ?? '').toLowerCase().includes(texto) ||
      (m.raza?.nombreRaza ?? '').toLowerCase().includes(texto)
    )
  })

  function abrirModal() {
    setForm({ nombre: '', idDueno: '', idRaza: '', fechaNacimiento: '' })
    setErrorForm('')
    setModalAbierto(true)
  }

  async function handleSubmit(e) {
    e.preventDefault()
    setErrorForm('')

    if (!form.nombre || !form.idDueno || !form.idRaza) {
      setErrorForm('Completa nombre, dueño y raza.')
      return
    }

    const nuevaMascota = {
      nombre: form.nombre,
      dueno: { idDueno: Number(form.idDueno) },
      raza: { idRaza: Number(form.idRaza) },
      fechaNacimiento: form.fechaNacimiento || null,
    }

    setGuardando(true)
    try {
      const response = await fetch(`${API_BASE}/mascotas`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(nuevaMascota),
      })

      if (!response.ok) throw new Error('El backend respondió con error al crear la mascota')

      setModalAbierto(false)
      await cargarDatos()
    } catch (err) {
      console.error('Error creando mascota:', err)
      setErrorForm('No se pudo guardar la mascota. Revisa los datos e inténtalo de nuevo.')
    } finally {
      setGuardando(false)
    }
  }

  function iniciales(nombre) {
    return nombre
      .split(' ')
      .map((p) => p[0])
      .slice(0, 2)
      .join('')
      .toUpperCase()
  }

  return (
    <div className="page-duenos">
      <div className="page-title-row">
        <div>
          <h1 className="page-title">Mascotas</h1>
          <p className="page-subtitle">{cargando ? '…' : `${mascotas.length} registros`}</p>
        </div>
        <button type="button" className="btn-submit btn-inline" onClick={abrirModal}>
          <Plus size={16} /> Agregar mascota
        </button>
      </div>

      <div className="table-search">
        <input
          type="text"
          placeholder="Buscar por nombre, dueño o raza..."
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
              <th>Raza</th>
              <th>Dueño</th>
              <th>Edad</th>
              <th aria-hidden="true"></th>
            </tr>
          </thead>
          <tbody>
            {cargando && (
              <tr><td colSpan={5} className="empty-hint">Cargando…</td></tr>
            )}

            {!cargando && mascotasFiltradas.length === 0 && (
              <tr><td colSpan={5} className="empty-hint">No se encontraron mascotas.</td></tr>
            )}

            {mascotasFiltradas.map((m) => (
              <tr key={m.idMascota} className="data-row">
                <td>
                  <div className="row-person">
                    <span className="row-avatar">{iniciales(m.nombre)}</span>
                    <span>{m.nombre}</span>
                  </div>
                </td>
                <td>{m.raza?.nombreRaza || '—'}</td>
                <td>{m.dueno?.nombre || '—'}</td>
                <td>{calcularEdad(m.fechaNacimiento)}</td>
                <td className="row-chevron"><ChevronRight size={18} /></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {modalAbierto && (
        <Modal titulo="Agregar mascota" onClose={() => setModalAbierto(false)}>
          <form onSubmit={handleSubmit} className="modal-form">
            <div className="form-group">
              <label htmlFor="nombreMascota">Nombre</label>
              <input
                id="nombreMascota"
                className="form-control"
                type="text"
                value={form.nombre}
                onChange={(e) => setForm({ ...form, nombre: e.target.value })}
                required
              />
            </div>

            <div className="form-group">
              <label htmlFor="dueno">Dueño</label>
              <select
                id="dueno"
                className="form-control"
                value={form.idDueno}
                onChange={(e) => setForm({ ...form, idDueno: e.target.value })}
                required
              >
                <option value="" disabled>Selecciona un dueño</option>
                {duenos.map((d) => (
                  <option key={d.idDueno} value={d.idDueno}>{d.nombre}</option>
                ))}
              </select>
            </div>

            <div className="form-group">
              <label htmlFor="raza">Raza</label>
              <select
                id="raza"
                className="form-control"
                value={form.idRaza}
                onChange={(e) => setForm({ ...form, idRaza: e.target.value })}
                required
              >
                <option value="" disabled>Selecciona una raza</option>
                {razas.map((r) => (
                  <option key={r.idRaza} value={r.idRaza}>
                    {r.nombreRaza}{r.especie?.nombreEspecie ? ` (${r.especie.nombreEspecie})` : ''}
                  </option>
                ))}
              </select>
            </div>

            <div className="form-group">
              <label htmlFor="fechaNacimiento">Fecha de nacimiento (opcional)</label>
              <input
                id="fechaNacimiento"
                className="form-control"
                type="date"
                value={form.fechaNacimiento}
                onChange={(e) => setForm({ ...form, fechaNacimiento: e.target.value })}
              />
            </div>

            {errorForm && <p className="form-message form-message-error">{errorForm}</p>}

            <button type="submit" className="btn-submit" disabled={guardando}>
              {guardando ? 'Guardando...' : 'Guardar mascota'}
            </button>
          </form>
        </Modal>
      )}
    </div>
  )
}
