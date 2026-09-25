import { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import { listarMascotas, crearMascota, eliminarMascota } from '../api/mascotas';
import { listarApoderados } from '../api/apoderados';

export default function MascotasPage() {
    const [mascotas, setMascotas] = useState([]);
    const [apoderados, setApoderados] = useState([]);
    const [error, setError] = useState('');

    const [nombre, setNombre] = useState('');
    const [raza, setRaza] = useState('');
    const [peso, setPeso] = useState('');
    const [genero, setGenero] = useState('Macho');
    const [idApoderado, setIdApoderado] = useState('');

    useEffect(() => {
        cargarMascotas();
        cargarApoderados();
    }, []);

    async function cargarMascotas() {
        try {
            const data = await listarMascotas();
            setMascotas(data);
        } catch (err) {
            console.error('Error cargando mascotas:', err);
        }
    }

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

        if (!idApoderado) {
            setError('Selecciona un apoderado (dueño) antes de guardar.');
            return;
        }

        try {
            await crearMascota({
                nombre,
                raza,
                peso: parseFloat(peso),
                genero,
                idApoderado: parseInt(idApoderado, 10),
            });
            setNombre('');
            setRaza('');
            setPeso('');
            setGenero('Macho');
            setIdApoderado('');
            cargarMascotas();
        } catch (err) {
            setError(`Error al guardar en la base de datos: ${err.message}`);
        }
    }

    async function handleEliminar(id) {
        if (!window.confirm(`¿Eliminar de la base de datos la mascota con ID ${id}?`)) return;
        try {
            await eliminarMascota(id);
            cargarMascotas();
        } catch (err) {
            alert(`Error al eliminar: ${err.message}`);
        }
    }

    return (
        <Layout title="Gestión de Mascotas">
            <section className="card">
                <h2>Registrar Mascota</h2>
                {error && <div className="alert error">{error}</div>}
                <form className="grid-form" onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label>Nombre:</label>
                        <input type="text" value={nombre} onChange={(e) => setNombre(e.target.value)} required />
                    </div>
                    <div className="form-group">
                        <label>Raza:</label>
                        <input type="text" value={raza} onChange={(e) => setRaza(e.target.value)} required />
                    </div>
                    <div className="form-group">
                        <label>Peso (kg):</label>
                        <input
                            type="number"
                            step="0.1"
                            value={peso}
                            onChange={(e) => setPeso(e.target.value)}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label>Género:</label>
                        <select value={genero} onChange={(e) => setGenero(e.target.value)} required>
                            <option value="Macho">Macho</option>
                            <option value="Hembra">Hembra</option>
                        </select>
                    </div>
                    <div className="form-group">
                        <label>Apoderado (dueño):</label>
                        <select value={idApoderado} onChange={(e) => setIdApoderado(e.target.value)} required>
                            <option value="">-- Selecciona un apoderado --</option>
                            {apoderados.map((a) => (
                                <option key={a.id} value={a.id}>
                                    {a.nombre} (tel: {a.telefono})
                                </option>
                            ))}
                        </select>
                    </div>
                    <div className="form-actions">
                        <button type="submit" className="btn btn-primary">Guardar en Base de Datos</button>
                    </div>
                </form>
            </section>

            <section className="card mt-2">
                <h2>Mascotas en Base de Datos</h2>
                <table className="data-table">
                    <thead>
                        <tr>
                            <th>ID</th><th>Nombre</th><th>Raza</th><th>Peso</th><th>Género</th><th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        {mascotas.length === 0 ? (
                            <tr><td colSpan="6" style={{ textAlign: 'center' }}>No hay registros</td></tr>
                        ) : (
                            mascotas.map((m) => (
                                <tr key={m.id}>
                                    <td>{m.id}</td>
                                    <td><strong>{m.nombre}</strong></td>
                                    <td>{m.raza}</td>
                                    <td>{m.peso}</td>
                                    <td>{m.genero}</td>
                                    <td>
                                        <button className="btn btn-danger" onClick={() => handleEliminar(m.id)}>
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
