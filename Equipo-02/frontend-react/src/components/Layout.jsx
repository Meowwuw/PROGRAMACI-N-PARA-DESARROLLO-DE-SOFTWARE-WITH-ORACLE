import { NavLink, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

export default function Layout({ title, children }) {
    const { cerrarSesion } = useAuth();
    const navigate = useNavigate();

    function handleLogout() {
        cerrarSesion();
        navigate('/login');
    }

    return (
        <div className="dashboard-layout">
            <aside className="sidebar">
                <div className="brand"><h2>🐾 Patitas</h2></div>
                <nav className="nav-menu">
                    <NavLink to="/home" className={({ isActive }) => `nav-item${isActive ? ' active' : ''}`}>
                        🏠 Inicio
                    </NavLink>
                    <NavLink to="/mascotas" className={({ isActive }) => `nav-item${isActive ? ' active' : ''}`}>
                        🐶 Mascotas
                    </NavLink>
                    <NavLink to="/apoderados" className={({ isActive }) => `nav-item${isActive ? ' active' : ''}`}>
                        👤 Apoderados
                    </NavLink>
                </nav>
                <button className="btn btn-logout" onClick={handleLogout}>Cerrar Sesión</button>
            </aside>
            <main className="main-content">
                <header className="topbar"><h1>{title}</h1></header>
                {children}
            </main>
        </div>
    );
}
