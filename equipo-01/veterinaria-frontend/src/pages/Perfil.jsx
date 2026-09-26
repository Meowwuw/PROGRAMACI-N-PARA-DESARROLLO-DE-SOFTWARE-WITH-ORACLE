import { obtenerSesion } from '../lib/session.js'

export default function Perfil() {
  const sesion = obtenerSesion()

  function iniciales(texto) {
    return texto
      .split(/[@.\s]/)
      .filter(Boolean)
      .map((p) => p[0])
      .slice(0, 2)
      .join('')
      .toUpperCase()
  }

  const rolLegible = sesion?.rol === 'admin' || sesion?.rol === 'ADMINISTRADOR' ? 'Administrador' : 'Veterinario'

  return (
    <div className="page-duenos">
      <div className="page-title-row">
        <div>
          <h1 className="page-title">Perfil</h1>
          <p className="page-subtitle">Datos de la cuenta con la que iniciaste sesión</p>
        </div>
      </div>

      <div className="panel" style={{ maxWidth: 480 }}>
        <div className="perfil-header">
          <span className="row-avatar perfil-avatar">{iniciales(sesion?.email ?? '?')}</span>
          <div>
            <div className="today-item-title">{sesion?.email}</div>
            <div className="today-item-sub">{rolLegible}</div>
          </div>
        </div>

        {sesion?.veterinario && (
          <>
            <div className="detalle-linea" style={{ marginTop: 18 }}>
              <strong>Nombre:</strong> {sesion.veterinario.nombre}
            </div>
            <div className="detalle-linea">
              <strong>Especialidad:</strong> {sesion.veterinario.especialidad || 'Sin especialidad registrada'}
            </div>
            <div className="detalle-linea">
              <strong>Teléfono:</strong> {sesion.veterinario.telefono || '—'}
            </div>
          </>
        )}

        <p className="empty-hint" style={{ marginTop: 18 }}>
          Editar estos datos todavía no está conectado a un endpoint del backend.
        </p>
      </div>
    </div>
  )
}
