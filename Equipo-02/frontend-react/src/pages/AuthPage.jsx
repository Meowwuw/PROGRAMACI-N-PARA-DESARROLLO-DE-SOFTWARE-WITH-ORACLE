import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { login, register } from '../api/auth';
import { useAuth } from '../context/AuthContext';

export default function AuthPage() {
    const [modo, setModo] = useState('login'); // 'login' | 'register'
    const navigate = useNavigate();
    const { guardarSesion } = useAuth();

    // Estado del formulario de login
    const [loginUsername, setLoginUsername] = useState('');
    const [loginPassword, setLoginPassword] = useState('');
    const [loginError, setLoginError] = useState('');

    // Estado del formulario de registro
    const [regUsername, setRegUsername] = useState('');
    const [regEmail, setRegEmail] = useState('');
    const [regPassword, setRegPassword] = useState('');
    const [regError, setRegError] = useState('');
    const [regSuccess, setRegSuccess] = useState('');

    async function handleLogin(e) {
        e.preventDefault();
        setLoginError('');
        try {
            const authResponse = await login(loginUsername, loginPassword);
            guardarSesion(authResponse);
            navigate('/home');
        } catch (error) {
            setLoginError(error.message);
        }
    }

    async function handleRegister(e) {
        e.preventDefault();
        setRegError('');
        setRegSuccess('');
        try {
            await register(regUsername, regEmail, regPassword);
            setRegSuccess('Cuenta creada en Base de Datos. Ya puedes iniciar sesión.');
            setRegUsername('');
            setRegEmail('');
            setRegPassword('');
        } catch (error) {
            setRegError(error.message);
        }
    }

    return (
        <div className="auth-container">
            {modo === 'login' ? (
                <div className="auth-box active">
                    <h2>Iniciar Sesión 🐾</h2>
                    {loginError && <div className="alert error">{loginError}</div>}
                    <form onSubmit={handleLogin}>
                        <div className="form-group">
                            <label>Usuario</label>
                            <input
                                type="text"
                                value={loginUsername}
                                onChange={(e) => setLoginUsername(e.target.value)}
                                required
                            />
                        </div>
                        <div className="form-group">
                            <label>Contraseña</label>
                            <input
                                type="password"
                                value={loginPassword}
                                onChange={(e) => setLoginPassword(e.target.value)}
                                required
                            />
                        </div>
                        <button type="submit" className="btn btn-primary btn-block">Ingresar</button>
                    </form>
                    <p className="switch-form">
                        ¿No tienes cuenta?{' '}
                        <a href="#" onClick={(e) => { e.preventDefault(); setModo('register'); }}>
                            Regístrate
                        </a>
                    </p>
                </div>
            ) : (
                <div className="auth-box active">
                    <h2>Registrarse 🐾</h2>
                    {regError && <div className="alert error">{regError}</div>}
                    {regSuccess && <div className="alert success">{regSuccess}</div>}
                    <form onSubmit={handleRegister}>
                        <div className="form-group">
                            <label>Usuario</label>
                            <input
                                type="text"
                                value={regUsername}
                                onChange={(e) => setRegUsername(e.target.value)}
                                required
                            />
                        </div>
                        <div className="form-group">
                            <label>Email</label>
                            <input
                                type="email"
                                value={regEmail}
                                onChange={(e) => setRegEmail(e.target.value)}
                                required
                            />
                        </div>
                        <div className="form-group">
                            <label>Contraseña</label>
                            <input
                                type="password"
                                value={regPassword}
                                onChange={(e) => setRegPassword(e.target.value)}
                                required
                            />
                        </div>
                        <button type="submit" className="btn btn-primary btn-block">Crear Cuenta</button>
                    </form>
                    <p className="switch-form">
                        ¿Ya tienes cuenta?{' '}
                        <a href="#" onClick={(e) => { e.preventDefault(); setModo('login'); }}>
                            Inicia Sesión
                        </a>
                    </p>
                </div>
            )}
        </div>
    );
}
