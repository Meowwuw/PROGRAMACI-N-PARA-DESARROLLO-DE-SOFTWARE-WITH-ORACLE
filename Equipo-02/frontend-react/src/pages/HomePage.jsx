import Layout from '../components/Layout';
import { useAuth } from '../context/AuthContext';

const DESCRIPCION_ROL = {
    admin: 'Tienes acceso completo: mascotas, apoderados, veterinarios y citas.',
    veterinario: 'Puedes ver todas las mascotas con su apoderado y tus citas asignadas.',
    apoderado: 'Puedes ver tus mascotas, agendar citas y consultar a los veterinarios.',
    recepcionista: 'Bienvenido/a al sistema.',
};

export default function HomePage() {
    const { user } = useAuth();

    return (
        <Layout title="Bienvenido al Sistema">
            <section className="card">
                <h2>Estado del Sistema</h2>
                <p>
                    {user?.username
                        ? `Sesión iniciada como ${user.username} (${user.rol}).`
                        : 'Selecciona una opción en el menú lateral para gestionar la clínica.'}
                </p>
                {user?.rol && DESCRIPCION_ROL[user.rol] && (
                    <p>{DESCRIPCION_ROL[user.rol]}</p>
                )}
            </section>
        </Layout>
    );
}
