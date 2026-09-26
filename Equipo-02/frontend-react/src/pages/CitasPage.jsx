import { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import { listarCitas, listarCitasPorVeterinario, agendarCita, eliminarCita } from '../api/citas';
import { listarMascotas } from '../api/mascotas';
import { listarVeterinarios } from '../api/veterinarios';
import { useAuth } from '../context/AuthContext';

export default function CitasPage() {
    const { user } = useAuth();
    const esAdmin = user?.rol === 'admin';
    const esApoderado = user?.rol === 'apoderado';
    const esVeterinario = user?.rol === 'veterinario';

    const [citas, setCitas] = useState([]);
    const [mascotas, setMascotas] = useState([]);
    const [veterinarios, setVeterinarios] = useState([]);
    const [error, setError] = useState('');
    const [mensaje, setMensaje] = useState('');

    const [idMascota, setIdMascota] = useState('');
    const [idVeterinario, setIdVeterinario] = useState('');
    const [fecha, setFecha] = useState('');

    useEffect(() => {
        cargarCitas();
        cargarMascotas();
        if (!esVeterinario) {
            cargarVeterinarios();
        }
    }, []);

    async function cargarCitas() {
        try {
            let data;
            if (esVeterinario) {
                data = await listarCitasPorVeterinario(user.idVeterinario);
            } else {
                data = await listarCitas();
                if (esApoderado) {
                    data = data.filter((c) => c.apoderado?.id === user.idApoderado);
                }
            }
            // Ordenar por fecha, la mas proxima primero
            data.sort((a, b) => new Date(a.fechaCon) - new Date(b.fechaCon));
            setCitas(data);
        } catch (err) {
            console.error('Error cargando citas:', err);
        }
    }

    async function cargarMascotas() {
        try {
            const data = await listarMascotas();
            const propias = esApoderado ? data.filter((m) => m.apoderado?.id === user.idApoderado) : data;
            setMascotas(propias);
        } catch (err) {
            console.error('Error cargando mascotas:', err);
        }
    }

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

        const mascotaElegida = mascotas.find((m) => m.id === parseInt(idMascota, 10));
        if (!mascotaElegida) {
            setError('Selecciona una mascota.');
            return;
        }
        const idVeterinarioFinal = esVeterinario ? user.idVeterinario : parseInt(idVeterinario, 10);
        if (!idVeterinarioFinal) {
            setError('Selecciona un veterinario.');
            return;
        }
        if (!fecha) {
            setError('Selecciona fecha y hora.');
            return;
        }

        try {
            await agendarCita({
                fecha: `${fecha}:00`, // datetime-local no trae segundos
                idApoderado: mascotaElegida.apoderado.id,
                idVeterinario: idVeterinarioFinal,
                idMascota: mascotaElegida.id,
            });
            setMensaje('Cita agendada correctamente.');
            setIdMascota('');
            setIdVeterinario('');
            setFecha('');
            cargarCitas();
        } catch (err) {
            setError(`Error al agendar la cita: ${err.message}`);
        }
    }

    async function handleEliminar(id) {
        if (!window.confirm('¿Cancelar/eliminar esta cita?')) return;
        setError('');
        setMensaje('');
        try {
            await eliminarCita(id);
            setMensaje('Cita eliminada correctamente.');
            cargarCitas();
        } catch (err) {
            alert(`Error al eliminar: ${err.message}`);
        }
    }

    function formatearFecha(fechaIso) {
        return new Date(fechaIso).toLocaleString('es-PE', {
            dateStyle: 'medium',
            timeStyle: 'short',
        });
    }

    return (
        <Layout title={esApoderado ? 'Mis Citas' : esVeterinario ? 'Citas por atender' : 'Gestión de Citas'}>
            <section className="card">
                <h2>Agendar Cita</h2>
                {error && <div className="alert error">{error}</div>}
                {mensaje && <div className="alert success">{mensaje}</div>}
                <form className="grid-form" onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label>Mascota:</label>
                        <select value={idMascota} onChange={(e) => setIdMascota(e.target.value)} required>
                            <option value="">-- Selecciona una mascota --</option>
                            {mascotas.map((m) => (
                                <option key={m.id} value={m.id}>
                                    {m.nombre} {m.apoderado?.nombre ? `(${m.apoderado.nombre})` : ''}
                                </option>
                            ))}
                        </select>
                    </div>

                    {!esVeterinario && (
                        <div className="form-group">
                            <label>Veterinario:</label>
                            <select value={idVeterinario} onChange={(e) => setIdVeterinario(e.target.value)} required>
                                <option value="">-- Selecciona un veterinario --</option>
                                {veterinarios.map((v) => (
                                    <option key={v.id} value={v.id}>
                                        {v.nombre} ({v.especialidad})
                                    </option>
                                ))}
                            </select>
                        </div>
                    )}

                    <div className="form-group">
                        <label>Fecha y hora:</label>
                        <input
                            type="datetime-local"
                            value={fecha}
                            onChange={(e) => setFecha(e.target.value)}
                            required
                        />
                    </div>

                    <div className="form-actions">
                        <button type="submit" className="btn btn-primary">Agendar</button>
                    </div>
                </form>
            </section>

            <section className="card mt-2">
                <h2>{esApoderado ? 'Mis citas' : esVeterinario ? 'Citas asignadas' : 'Todas las citas'}</h2>
                <table className="data-table">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Mascota</th>
                            {!esApoderado && <th>Apoderado</th>}
                            {!esVeterinario && <th>Veterinario</th>}
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        {citas.length === 0 ? (
                            <tr>
                                <td colSpan="5" style={{ textAlign: 'center' }}>No hay citas registradas</td>
                            </tr>
                        ) : (
                            citas.map((c) => (
                                <tr key={c.id}>
                                    <td>{formatearFecha(c.fechaCon)}</td>
                                    <td>{c.mascota?.nombre}</td>
                                    {!esApoderado && <td>{c.apoderado?.nombre}</td>}
                                    {!esVeterinario && <td>{c.veterinario?.nombre}</td>}
                                    <td>
                                        <button className="btn btn-danger" onClick={() => handleEliminar(c.id)}>
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
