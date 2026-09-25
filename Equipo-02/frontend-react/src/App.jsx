import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';
import AuthPage from './pages/AuthPage';
import HomePage from './pages/HomePage';
import MascotasPage from './pages/MascotasPage';
import ApoderadosPage from './pages/ApoderadosPage';

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
                    <Route
                        path="/mascotas"
                        element={
                            <ProtectedRoute>
                                <MascotasPage />
                            </ProtectedRoute>
                        }
                    />
                    <Route
                        path="/apoderados"
                        element={
                            <ProtectedRoute>
                                <ApoderadosPage />
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
