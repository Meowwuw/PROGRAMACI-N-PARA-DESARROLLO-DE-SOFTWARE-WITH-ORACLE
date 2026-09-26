import { useEffect, useState } from 'react'
import { Plus } from 'lucide-react'
import Modal from '../components/Modal.jsx'

const API_BASE = 'http://localhost:8080/api'

export default function Catalogos() {
  const [pestana, setPestana] = useState('razas')

  const [especies, setEspecies] = useState([])
  const [razas, setRazas] = useState([])
  const [cargando, setCargando] = useState(true)
  const [error, setError] = useState('')

  const [modalAbierto, setModalAbierto] = useState(false)
  const [guardando, setGuardando] = useState(false)
  const [errorForm, setErrorForm] = useState('')
  const [formRaza, setFormRaza] = useState({ nombreRaza: '', idEspecie: '' })
  const [formEspecie, setFormEspecie] = useState({ nombreEspecie: '' })

  async function cargarDatos() {
    setCargando(true)
    try {
      const [resEspecies, resRazas] = await Promise.all([
        fetch(`${API_BASE}/especies`),
        fetch(`${API_BASE}/razas`),
      ])

      if (!resEspecies.ok || !resRazas.ok) throw new Error('Alguno de los endpoints no respondió OK')

      setEspecies(await resEspecies.json())
      setRazas(await resRazas.json())
    } catch (err) {
      console.error('Error cargando catálogos:', err)
      setError('No se pudo cargar la información. Verifica que el backend esté encendido.')
    } finally {
      setCargando(false)
    }
  }

  useEffect(() => {
    cargarDatos()
  }, [])

  function abrirModal() {
    setFormRaza({ nombreRaza: '', idEspecie: '' })
    setFormEspecie({ nombreEspecie: '' })
    setErrorForm('')
    setModalAbierto(true)
  }

  async function handleSubmitRaza(e) {
    e.preventDefault()
    setErrorForm('')

    if (!formRaza.nombreRaza.trim() || !formRaza.idEspecie) {
      setErrorForm('Completa el nombre y la especie.')
      return
    }

    setGuardando(true)
    try {
      const res = await fetch(`${API_BASE}/razas`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          nombreRaza: formRaza.nombreRaza,
          especie: { idEspecie: Number(formRaza.idEspecie) },
        }),
      })

      if (!res.ok) throw new Error('El backend respondió con error al crear la raza')

      setModalAbierto(false)
      await cargarDatos()
    } catch (err) {
      console.error('Error creando raza:', err)
      setErrorForm('No se pudo guardar la raza. Revisa los datos e inténtalo de nuevo.')
    } finally {
      setGuardando(false)
    }
  }

  async function handleSubmitEspecie(e) {
    e.preventDefault()
    setErrorForm('')

    if (!formEspecie.nombreEspecie.trim()) {
      setErrorForm('El nombre es obligatorio.')
      return
    }

    setGuardando(true)
    try {
      const res = await fetch(`${API_BASE}/especies`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ nombreEspecie: formEspecie.nombreEspecie }),
      })

      if (!res.ok) throw new Error('El backend respondió con error al crear la especie')

      setModalAbierto(false)
      await cargarDatos()
    } catch (err) {
      console.error('Error creando especie:', err)
      setErrorForm('No se pudo guardar la especie. Puede que ya exista una con ese nombre.')
    } finally {
      setGuardando(false)
    }
  }

  return (
    <div className="page-duenos">
      <div className="page-title-row">
        <div>
          <h1 className="page-title">Catálogos</h1>
          <p className="page-subtitle">Razas y especies usadas al registrar mascotas</p>
        </div>
        <button type="button" className="btn-submit btn-inline" onClick={abrirModal}>
          <Plus size={16} /> Agregar {pestana === 'razas' ? 'raza' : 'especie'}
        </button>
      </div>

      <div className="tabs">
        <button
          type="button"
          className={`tab-btn${pestana === 'razas' ? ' tab-btn-active' : ''}`}
          onClick={() => setPestana('razas')}
        >
          Razas
        </button>
        <button
          type="button"
          className={`tab-btn${pestana === 'especies' ? ' tab-btn-active' : ''}`}
          onClick={() => setPestana('especies')}
        >
          Especies
        </button>
      </div>

      {error && <p className="form-message form-message-error">{error}</p>}

      <div className="panel panel-table">
        {pestana === 'razas' ? (
          <table className="data-table">
            <thead>
              <tr>
                <th>Raza</th>
                <th>Especie</th>
              </tr>
            </thead>
            <tbody>
              {cargando && <tr><td colSpan={2} className="empty-hint">Cargando…</td></tr>}
              {!cargando && razas.length === 0 && (
                <tr><td colSpan={2} className="empty-hint">No hay razas registradas.</td></tr>
              )}
              {razas.map((r) => (
                <tr key={r.idRaza} className="data-row">
                  <td>{r.nombreRaza}</td>
                  <td>{r.especie?.nombreEspecie || '—'}</td>
                </tr>
              ))}
            </tbody>
          </table>
        ) : (
          <table className="data-table">
            <thead>
              <tr>
                <th>Especie</th>
              </tr>
            </thead>
            <tbody>
              {cargando && <tr><td colSpan={1} className="empty-hint">Cargando…</td></tr>}
              {!cargando && especies.length === 0 && (
                <tr><td colSpan={1} className="empty-hint">No hay especies registradas.</td></tr>
              )}
              {especies.map((e) => (
                <tr key={e.idEspecie} className="data-row">
                  <td>{e.nombreEspecie}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      {modalAbierto && pestana === 'razas' && (
        <Modal titulo="Agregar raza" onClose={() => setModalAbierto(false)}>
          <form onSubmit={handleSubmitRaza} className="modal-form">
            <div className="form-group">
              <label htmlFor="nombreRaza">Nombre de la raza</label>
              <input
                id="nombreRaza"
                className="form-control"
                type="text"
                value={formRaza.nombreRaza}
                onChange={(e) => setFormRaza({ ...formRaza, nombreRaza: e.target.value })}
                required
              />
            </div>

            <div className="form-group">
              <label htmlFor="especieRaza">Especie</label>
              <select
                id="especieRaza"
                className="form-control"
                value={formRaza.idEspecie}
                onChange={(e) => setFormRaza({ ...formRaza, idEspecie: e.target.value })}
                required
              >
                <option value="" disabled>Selecciona una especie</option>
                {especies.map((esp) => (
                  <option key={esp.idEspecie} value={esp.idEspecie}>{esp.nombreEspecie}</option>
                ))}
              </select>
              {especies.length === 0 && (
                <p className="empty-hint">Primero crea una especie en la otra pestaña.</p>
              )}
            </div>

            {errorForm && <p className="form-message form-message-error">{errorForm}</p>}

            <button type="submit" className="btn-submit" disabled={guardando}>
              {guardando ? 'Guardando...' : 'Guardar raza'}
            </button>
          </form>
        </Modal>
      )}

      {modalAbierto && pestana === 'especies' && (
        <Modal titulo="Agregar especie" onClose={() => setModalAbierto(false)}>
          <form onSubmit={handleSubmitEspecie} className="modal-form">
            <div className="form-group">
              <label htmlFor="nombreEspecie">Nombre de la especie</label>
              <input
                id="nombreEspecie"
                className="form-control"
                type="text"
                value={formEspecie.nombreEspecie}
                onChange={(e) => setFormEspecie({ nombreEspecie: e.target.value })}
                required
              />
            </div>

            {errorForm && <p className="form-message form-message-error">{errorForm}</p>}

            <button type="submit" className="btn-submit" disabled={guardando}>
              {guardando ? 'Guardando...' : 'Guardar especie'}
            </button>
          </form>
        </Modal>
      )}
    </div>
  )
}
