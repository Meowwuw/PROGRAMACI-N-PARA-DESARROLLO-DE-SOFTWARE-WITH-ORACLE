import { createContext, useContext, useState } from 'react';

const STORAGE_KEY = 'auth_user';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
    const [user, setUser] = useState(() => {
        const raw = localStorage.getItem(STORAGE_KEY);
        return raw ? JSON.parse(raw) : null;
    });

    function guardarSesion(authResponse) {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(authResponse));
        setUser(authResponse);
    }

    function cerrarSesion() {
        localStorage.removeItem(STORAGE_KEY);
        setUser(null);
    }

    return (
        <AuthContext.Provider value={{ user, guardarSesion, cerrarSesion }}>
            {children}
        </AuthContext.Provider>
    );
}

export function useAuth() {
    const ctx = useContext(AuthContext);
    if (!ctx) {
        throw new Error('useAuth debe usarse dentro de <AuthProvider>');
    }
    return ctx;
}
