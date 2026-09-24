import { useState } from 'react';
import './App.css';

function App() {
  const [formData, setFormData] = useState({
    nombre: '',
    apellido: '',
    dni: '',
    telefono: ''
  });

  const [mensaje, setMensaje] = useState(null);
  const [error, setError] = useState(null);
  const [cargando, setCargando] = useState(false);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMensaje(null);
    setError(null);
    setCargando(true);

    try {
      const response = await fetch('http://localhost:8080/api/clientes', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
      });

      if (!response.ok) {
        throw new Error('Error en la respuesta del servidor');
      }

      const data = await response.json();
      
      setMensaje(`¡Cliente registrado exitosamente! ID: ${data.idCliente}`);
      
      setFormData({
        nombre: '',
        apellido: '',
        dni: '',
        telefono: ''
      });
    } catch (err) {
      setError('No se pudo conectar con el servidor backend (http://localhost:8080).');
    } finally {
      setCargando(false);
    }
  };

  return (
    <div className="page-wrapper">
      {/* Header Superior Blanco */}
      <header className="header">
        <div className="header-container">
          <div className="logo">
            <span className="logo-icon">V</span>
            <span className="logo-text">CanchaVóley</span>
          </div>
          <nav className="nav">
            <a href="#">Inicio</a>
            <a href="#">Canchas</a>
            <a href="#">Horarios</a>
            <a href="#">Contacto</a>
          </nav>
          <button className="btn-reservar">Reservar</button>
        </div>
      </header>

      {/* Contenido Principal */}
      <main className="main-content">
        <div className="title-section">
          <h1>Reserva tu cancha</h1>
          <p>Completa los 4 pasos para confirmar tu reserva.</p>
        </div>

        {/* Stepper */}
        <div className="stepper">
          <div className="step completed"><span className="step-num">1</span> Fecha y cancha</div>
          <div className="step-line active"></div>
          <div className="step completed"><span className="step-num">2</span> Horario</div>
          <div className="step-line active"></div>
          <div className="step active"><span className="step-num">3</span> Tus datos</div>
          <div className="step-line"></div>
          <div className="step"><span className="step-num">4</span> Resumen y pago</div>
        </div>

        <div className="grid-layout">
          {/* Form Card */}
          <div className="card">
            <h2>Tus datos</h2>
            <p className="card-subtitle">Los usaremos para registrar tu reserva.</p>

            {mensaje && <div className="alert alert-success">{mensaje}</div>}
            {error && <div className="alert alert-danger">{error}</div>}

            <form onSubmit={handleSubmit}>
              <div className="form-row">
                <div className="form-group">
                  <label>Nombre</label>
                  <input
                    type="text"
                    name="nombre"
                    placeholder="Ej. Juan"
                    value={formData.nombre}
                    onChange={handleChange}
                    required
                  />
                </div>
                <div className="form-group">
                  <label>Apellido</label>
                  <input
                    type="text"
                    name="apellido"
                    placeholder="Ej. Perez"
                    value={formData.apellido}
                    onChange={handleChange}
                    required
                  />
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>DNI</label>
                  <input
                    type="text"
                    name="dni"
                    placeholder="Ej. 12345678"
                    value={formData.dni}
                    onChange={handleChange}
                    maxLength="8"
                    required
                  />
                </div>
                <div className="form-group">
                  <label>Teléfono</label>
                  <input
                    type="text"
                    name="telefono"
                    placeholder="Ej. 987654321"
                    value={formData.telefono}
                    onChange={handleChange}
                    maxLength="20"
                    required
                  />
                </div>
              </div>

              <div className="form-actions">
                <button type="button" className="btn-atras">Atrás</button>
                <button type="submit" className="btn-continuar" disabled={cargando}>
                  {cargando ? 'Guardando...' : 'Continuar'}
                </button>
              </div>
            </form>
          </div>

          {/* Summary Card */}
          <div className="card summary-card">
            <h2>Tu reserva</h2>
            <div className="summary-item">
              <span>Fecha</span>
              <strong>Lun 28 sep 2026</strong>
            </div>
            <div className="summary-item">
              <span>Cancha</span>
              <strong>Cancha 2</strong>
            </div>
            <div className="summary-item">
              <span>Horario</span>
              <strong>16:00</strong>
            </div>
            <div className="summary-divider"></div>
            <div className="summary-total">
              <span>Total</span>
              <span className="total-price">S/ 40</span>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}

export default App;