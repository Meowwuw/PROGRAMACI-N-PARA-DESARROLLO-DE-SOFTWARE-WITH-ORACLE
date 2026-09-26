import { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import { listarApoderados, crearApoderado, eliminarApoderado } from '../api/apoderados';
import { listarMascotas, eliminarMascota } from '../api/mascotas';

export default function ApoderadosPage() {
    const [apoderados, setApoderados] = useState([]);
    const [error, setError] = useState('');
    const [mensaje, setMensaje] = useState('');

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
        setMensaje('');
        try {
            await crearApoderado({ nombre, telefono });
            setMensaje(`Apoderado "${nombre}" guardado correctamente.`);
            setNombre('');
            setTelefono('');
            cargarApoderados();
        } catch (err) {
            setError(`Error al guardar en la base de datos: ${err.message}`);
        }
    }

    async function handleEliminar(id, nombreApoderado) {
        setError('');
        setMensaje('');
        try {
            const todasLasMascotas = await listarMascotas();
            const mascotasDelApoderado = todasLasMascotas.filter((m) => m.apoderado?.id === id);

            let mensajeConfirmacion = `¿Eliminar al apoderado "${nombreApoderado}"?`;
            if (mascotasDelApoderado.length > 0) {
                const listado = mascotasDelApoderado.map((m) => `• ${m.nombre} (${m.raza})`).join('\n');
                mensajeConfirmacion +=
                    `\n\nTiene ${mascotasDelApoderado.length} mascota(s) registrada(s) a su nombre. ` +
                    `Si continúas, también se eliminarán:\n${listado}`;
            }

            if (!window.confirm(mensajeConfirmacion)) return;

            // Primero las mascotas (si las hay), luego el apoderado.
            for (const m of mascotasDelApoderado) {
                await eliminarMascota(m.id);
            }
            await eliminarApoderado(id);

            setMensaje(
                mascotasDelApoderado.length > 0
                    ? `Apoderado "${nombreApoderado}" y ${mascotasDelApoderado.length} mascota(s) eliminados correctamente.`
                    : `Apoderado "${nombreApoderado}" eliminado correctamente.`
            );
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
                {mensaje && <div className="alert success">{mensaje}</div>}
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
                                        <button className="btn btn-danger" onClick={() => handleEliminar(a.id, a.nombre)}>
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
