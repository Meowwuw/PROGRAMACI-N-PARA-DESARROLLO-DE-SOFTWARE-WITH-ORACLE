import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';
import AuthPage from './pages/AuthPage';
import HomePage from './pages/HomePage';
import MascotasPage from './pages/MascotasPage';
import ApoderadosPage from './pages/ApoderadosPage';
import VeterinariosPage from './pages/VeterinariosPage';
import CitasPage from './pages/CitasPage';

export default function App() {
    return (
        <AuthProvider>
            <BrowserRouter>
                <Routes>
                    <Route path="/login" element={<AuthPage />} />

                    <Route
                        path="/home"
                        element={
                            <ProtectedRoute>
                                <HomePage />
                            </ProtectedRoute>
                        }
                    />

                    {/* Mascotas: admin ve/edita todas, veterinario solo consulta, apoderado ve/crea las suyas */}
                    <Route
                        path="/mascotas"
                        element={
                            <ProtectedRoute>
                                <MascotasPage />
                            </ProtectedRoute>
                        }
                    />

                    {/* Apoderados: solo administración */}
                    <Route
                        path="/apoderados"
                        element={
                            <ProtectedRoute roles={['admin']}>
                                <ApoderadosPage />
                            </ProtectedRoute>
                        }
                    />

                    {/* Veterinarios: todos los roles pueden verlos, solo admin puede crear */}
                    <Route
                        path="/veterinarios"
                        element={
                            <ProtectedRoute>
                                <VeterinariosPage />
                            </ProtectedRoute>
                        }
                    />

                    {/* Citas: admin ve todas, veterinario ve las suyas, apoderado ve/agenda las suyas */}
                    <Route
                        path="/citas"
                        element={
                            <ProtectedRoute>
                                <CitasPage />
                            </ProtectedRoute>
                        }
                    />

                    {/* Cualquier ruta desconocida manda al login */}
                    <Route path="*" element={<Navigate to="/login" replace />} />
                </Routes>
            </BrowserRouter>
        </AuthProvider>
    );
}
