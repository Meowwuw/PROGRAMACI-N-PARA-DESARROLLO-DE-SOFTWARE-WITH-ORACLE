const SESSION_KEY = 'ximedgar_session'

export function guardarSesion(usuario) {
  localStorage.setItem(SESSION_KEY, JSON.stringify(usuario))
}

export function obtenerSesion() {
  const raw = localStorage.getItem(SESSION_KEY)
  if (!raw) return null
  try {
    return JSON.parse(raw)
  } catch {
    return null
  }
}

export function borrarSesion() {
  localStorage.removeItem(SESSION_KEY)
}

export function haySesion() {
  return obtenerSesion() !== null
}
