const API_MASCOTAS = 'http://localhost:8080/api/mascotas';
const API_APODERADOS = 'http://localhost:8080/api/apoderados';

document.addEventListener('DOMContentLoaded', () => {
    cargarMascotas();
    cargarApoderados();

    // Crear / Insertar
    const formMascota = document.getElementById('form-mascota');
    if (formMascota) {
        formMascota.addEventListener('submit', async (e) => {
            e.preventDefault();

            const idApoderado = document.getElementById('mascota-apoderado').value;
            if (!idApoderado) {
                alert('Selecciona un apoderado (dueño) antes de guardar.');
                return;
            }

            const nuevaMascota = {
                nombre: document.getElementById('mascota-nombre').value,
                raza: document.getElementById('mascota-raza').value,
                peso: parseFloat(document.getElementById('mascota-peso').value),
                genero: document.getElementById('mascota-genero').value,
                apoderado: { id: parseInt(idApoderado, 10) } // el backend espera el objeto Apoderado, no solo el id suelto
            };

            try {
                const response = await fetch(API_MASCOTAS, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(nuevaMascota)
                });

                if (response.ok) {
                    formMascota.reset();
                    cargarMascotas();
                } else {
                    const texto = await response.text();
                    console.error('Error al guardar mascota:', response.status, texto);
                    alert(`Error al guardar en la base de datos (HTTP ${response.status}).`);
                }
            } catch (error) {
                console.error('Error de red al guardar mascota:', error);
                alert('No se pudo conectar con el servidor Backend.');
            }
        });
    }
});

// Carga el select de apoderados
async function cargarApoderados() {
    const select = document.getElementById('mascota-apoderado');
    if (!select) return;

    try {
        const response = await fetch(API_APODERADOS);
        if (!response.ok) throw new Error('HTTP ' + response.status);
        const apoderados = await response.json();

        select.innerHTML = '<option value="">-- Selecciona un apoderado --</option>';
        apoderados.forEach(a => {
            const opt = document.createElement('option');
            opt.value = a.id;
            opt.textContent = `${a.nombre} (tel: ${a.telefono})`;
            select.appendChild(opt);
        });
    } catch (error) {
        console.error('Error cargando apoderados:', error);
        select.innerHTML = '<option value="">Error al cargar apoderados</option>';
    }
}

// Leer / Select
async function cargarMascotas() {
    try {
        const response = await fetch(API_MASCOTAS);
        if (response.ok) {
            const mascotas = await response.json();
            renderTabla(mascotas);
        }
    } catch (error) {
        console.error('Error:', error);
    }
}

function renderTabla(mascotas) {
    const tbody = document.getElementById('mascotas-table-body');
    tbody.innerHTML = '';

    if (mascotas.length === 0) {
        tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;">No hay registros</td></tr>';
        return;
    }

    mascotas.forEach(m => {
        const rowId = m.id_mascota || m.id;
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${rowId}</td>
            <td><strong>${m.nombre}</strong></td>
            <td>${m.raza}</td>
            <td>${m.peso}</td>
            <td>${m.genero}</td>
            <td>
                <button onclick="eliminarMascota(${rowId})" class="btn btn-danger">Eliminar</button>
            </td>
        `;
        tbody.appendChild(row);
    });
}

// Eliminar / Delete
async function eliminarMascota(id) {
    if (confirm(`¿Eliminar de la base de datos la mascota con ID ${id}?`)) {
        try {
            const response = await fetch(`${API_MASCOTAS}/${id}`, { method: 'DELETE' });
            if (response.ok) {
                cargarMascotas();
            } else {
                alert('Error al eliminar en la base de datos.');
            }
        } catch (error) {
            alert('Error de conexión.');
        }
    }
}
