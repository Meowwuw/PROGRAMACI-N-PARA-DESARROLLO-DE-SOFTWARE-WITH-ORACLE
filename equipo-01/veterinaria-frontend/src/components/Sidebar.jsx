import { NavLink, useNavigate } from 'react-router-dom'
import {
  Home,
  Users,
  PawPrint,
  ClipboardList,
  Tag,
  Stethoscope,
  BookOpen,
  BarChart3,
  User,
  LogOut,
} from 'lucide-react'
import { borrarSesion } from '../lib/session.js'

const navItems = [
  { to: '/', label: 'Inicio', icon: Home, end: true },
  { to: '/duenos', label: 'Dueños', icon: Users },
  { to: '/mascotas', label: 'Mascotas', icon: PawPrint },
  { to: '/consultas', label: 'Consultas', icon: ClipboardList },
  { to: '/servicios', label: 'Servicios', icon: Tag },
  { to: '/veterinarios', label: 'Veterinarios', icon: Stethoscope },
  { to: '/catalogos', label: 'Catálogos', icon: BookOpen },
  { to: '/reportes', label: 'Reportes', icon: BarChart3 },
]

export default function Sidebar() {
  const navigate = useNavigate()

  function handleLogout() {
    borrarSesion()
    navigate('/login')
  }

  return (
    <aside className="sidebar">
      <div className="sidebar-brand">
        <svg className="sidebar-paw-icon" viewBox="0 0 100 100" fill="#1ed0a8">
          <ellipse cx="25" cy="35" rx="9" ry="12" transform="rotate(-20 25 35)" />
          <ellipse cx="42" cy="20" rx="9" ry="12" />
          <ellipse cx="60" cy="20" rx="9" ry="12" />
          <ellipse cx="77" cy="35" rx="9" ry="12" transform="rotate(20 77 35)" />
          <path d="M 25,60 C 20,80 35,92 51,92 C 67,92 82,80 77,60 C 72,45 58,48 51,52 C 44,48 30,45 25,60 Z" />
        </svg>
        <div>
          <div className="sidebar-brand-name">Ximedgar</div>
          <div className="sidebar-brand-sub">Panel administrativo</div>
        </div>
      </div>

      <nav className="sidebar-nav">
        {navItems.map(({ to, label, icon: Icon, end }) => (
          <NavLink
            key={to}
            to={to}
            end={end}
            className={({ isActive }) => `sidebar-link${isActive ? ' sidebar-link-active' : ''}`}
          >
            <Icon size={18} strokeWidth={2} />
            <span>{label}</span>
          </NavLink>
        ))}
      </nav>

      <div className="sidebar-footer">
        <NavLink to="/perfil" className={({ isActive }) => `sidebar-link${isActive ? ' sidebar-link-active' : ''}`}>
          <User size={18} strokeWidth={2} />
          <span>Perfil</span>
        </NavLink>
        <button type="button" className="sidebar-link sidebar-logout" onClick={handleLogout}>
          <LogOut size={18} strokeWidth={2} />
          <span>Cerrar sesión</span>
        </button>
      </div>
    </aside>
  )
}
