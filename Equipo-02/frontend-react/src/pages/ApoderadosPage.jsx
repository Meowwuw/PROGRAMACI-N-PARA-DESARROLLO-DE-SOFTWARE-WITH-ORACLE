import { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import { listarApoderados, crearApoderado, eliminarApoderado } from '../api/apoderados';

export default function ApoderadosPage() {
    const [apoderados, setApoderados] = useState([]);
    const [error, setError] = useState('');

    const [nombre, setNombre] = useState('');
    const [telefono, setTelefono] = useState('');

    useEffect(() => {
        cargarApoderados();
    }, []);

    async function cargarApoderados() {
        try {
            const data = await listarApoderados();
            setApoderados(data);
        } catch (err) {
            console.error('Error cargando apoderados:', err);
        }
    }

    async function handleSubmit(e) {
        e.preventDefault();
        setError('');
        try {
            await crearApoderado({ nombre, telefono });
            setNombre('');
            setTelefono('');
            cargarApoderados();
        } catch (err) {
            setError(`Error al guardar en la base de datos: ${err.message}`);
        }
    }

    async function handleEliminar(id) {
        if (!window.confirm(`¿Eliminar de la base de datos al apoderado con ID ${id}?`)) return;
        try {
            await eliminarApoderado(id);
            cargarApoderados();
        } catch (err) {
            alert(`Error al eliminar: ${err.message}`);
        }
    }

    return (
        <Layout title="Gestión de Apoderados">
            <section className="card">
                <h2>Registrar Apoderado</h2>
                {error && <div className="alert error">{error}</div>}
                <form className="grid-form" onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label>Nombre:</label>
                        <input type="text" value={nombre} onChange={(e) => setNombre(e.target.value)} required />
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

            <section className="card mt-2">
                <h2>Apoderados en Base de Datos</h2>
                <table className="data-table">
                    <thead>
                        <tr>
                            <th>ID</th><th>Nombre</th><th>Teléfono</th><th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        {apoderados.length === 0 ? (
                            <tr><td colSpan="4" style={{ textAlign: 'center' }}>No hay registros</td></tr>
                        ) : (
                            apoderados.map((a) => (
                                <tr key={a.id}>
                                    <td>{a.id}</td>
                                    <td><strong>{a.nombre}</strong></td>
                                    <td>{a.telefono}</td>
                                    <td>
                                        <button className="btn btn-danger" onClick={() => handleEliminar(a.id)}>
                                            Eliminar
                                        </button>
                                    </td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </section>
        </Layout>
    );
}
