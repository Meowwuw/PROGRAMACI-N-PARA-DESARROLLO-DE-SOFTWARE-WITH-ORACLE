import { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import { listarVeterinarios, crearVeterinario } from '../api/veterinarios';
import { useAuth } from '../context/AuthContext';

export default function VeterinariosPage() {
    const { user } = useAuth();
    const esAdmin = user?.rol === 'admin';

    const [veterinarios, setVeterinarios] = useState([]);
    const [error, setError] = useState('');
    const [mensaje, setMensaje] = useState('');

    const [nombre, setNombre] = useState('');
    const [especialidad, setEspecialidad] = useState('');
    const [telefono, setTelefono] = useState('');

    useEffect(() => {
        cargarVeterinarios();
    }, []);

    async function cargarVeterinarios() {
        try {
            const data = await listarVeterinarios();
            setVeterinarios(data);
        } catch (err) {
            console.error('Error cargando veterinarios:', err);
        }
    }

    async function handleSubmit(e) {
        e.preventDefault();
        setError('');
        setMensaje('');
        try {
            await crearVeterinario({ nombre, especialidad, telefono });
            setMensaje(`Veterinario "${nombre}" guardado correctamente.`);
            setNombre('');
            setEspecialidad('');
            setTelefono('');
            cargarVeterinarios();
        } catch (err) {
            setError(`Error al guardar en la base de datos: ${err.message}`);
        }
    }

    return (
        <Layout title="Veterinarios">
            {esAdmin && (
                <section className="card">
                    <h2>Registrar Veterinario</h2>
                    {error && <div className="alert error">{error}</div>}
                    {mensaje && <div className="alert success">{mensaje}</div>}
                    <form className="grid-form" onSubmit={handleSubmit}>
                        <div className="form-group">
                            <label>Nombre:</label>
                            <input type="text" value={nombre} onChange={(e) => setNombre(e.target.value)} required />
                        </div>
                        <div className="form-group">
                            <label>Especialidad:</label>
                            <input
                                type="text"
                                value={especialidad}
                                onChange={(e) => setEspecialidad(e.target.value)}
                                required
                            />
                        </div>
                        <div className="form-group">
                            <label>Teléfono:</label>
                            <input
                                type="text"
                                maxLength={11}
                                value={telefono}
                                onChange={(e) => setTelefono(e.target.value)}
                                required
                            />
                        </div>
                        <div className="form-actions">
                            <button type="submit" className="btn btn-primary">Guardar en Base de Datos</button>
                        </div>
                    </form>
                </section>
            )}

            <section className="card mt-2">
                <h2>Veterinarios en Base de Datos</h2>
                <table className="data-table">
                    <thead>
                        <tr>
                            <th>ID</th><th>Nombre</th><th>Especialidad</th><th>Teléfono</th>
                        </tr>
                    </thead>
                    <tbody>
                        {veterinarios.length === 0 ? (
                            <tr><td colSpan="4" style={{ textAlign: 'center' }}>No hay registros</td></tr>
                        ) : (
                            veterinarios.map((v) => (
                                <tr key={v.id}>
                                    <td>{v.id}</td>
                                    <td><strong>{v.nombre}</strong></td>
                                    <td>{v.especialidad}</td>
                                    <td>{v.telefono}</td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </section>
        </Layout>
    );
}
