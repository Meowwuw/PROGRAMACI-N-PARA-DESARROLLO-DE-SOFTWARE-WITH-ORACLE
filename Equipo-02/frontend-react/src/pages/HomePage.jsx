import Layout from '../components/Layout';
import { useAuth } from '../context/AuthContext';

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
            </section>
        </Layout>
    );
}
