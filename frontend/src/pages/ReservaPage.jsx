import React, { useState, useEffect } from 'react';
import { Link, useSearchParams } from 'react-router-dom';
import { HorarioService } from '../services/HorarioService';
import { ReservaService } from '../services/ReservaService';
import { ClienteService } from '../services/ClienteService';
import { PagoService } from '../services/PagoService';
import './ReservaPage.css';

export function ReservaPage() {
  const [searchParams] = useSearchParams();
  const canchaParam = searchParams.get('cancha');

  const [pasoActual, setPasoActual] = useState(1);
  const [fechaSeleccionada, setFechaSeleccionada] = useState(28); // 28 sep 2026 por defecto

  const [canchaSeleccionada, setCanchaSeleccionada] = useState(
    canchaParam ? parseInt(canchaParam, 10) : null
  );

  useEffect(() => {
    setCanchaSeleccionada(canchaParam ? parseInt(canchaParam, 10) : null);
  }, [canchaParam]);

  const canchas = [
    { id: 1, nombre: 'Cancha 1' },
    { id: 2, nombre: 'Cancha 2' },
    { id: 3, nombre: 'Cancha 3' },
    { id: 4, nombre: 'Cancha 4' },
    { id: 5, nombre: 'Cancha 5' },
  ];

  const diasDeshabilitados = Array.from({ length: 18 }, (_, i) => i + 1);
  const diasHabilitados = Array.from({ length: 12 }, (_, i) => i + 19);

  // ---- PASO 2: HORARIOS ----
  const ANIO_RESERVA = 2026;
  const MES_RESERVA = 9;
  const fechaISO = fechaSeleccionada
    ? `${ANIO_RESERVA}-${String(MES_RESERVA).padStart(2, '0')}-${String(fechaSeleccionada).padStart(2, '0')}`
    : null;

  const [horarios, setHorarios] = useState([]);
  const [horariosOcupados, setHorariosOcupados] = useState([]);
  const [horarioSeleccionado, setHorarioSeleccionado] = useState(null);
  const [cargandoHorarios, setCargandoHorarios] = useState(false);
  const [errorHorarios, setErrorHorarios] = useState(null);

  useEffect(() => {
    if (pasoActual !== 2 || !canchaSeleccionada || !fechaISO) return;

    let cancelado = false;
    setCargandoHorarios(true);
    setErrorHorarios(null);
    setHorarioSeleccionado(null);

    Promise.all([
      HorarioService.obtenerTodos(),
      ReservaService.obtenerPorFecha(fechaISO),
    ])
      .then(([listaHorarios, reservasDelDia]) => {
        if (cancelado) return;
        setHorarios(listaHorarios);
        const ocupados = reservasDelDia
          .filter((r) => r.cancha?.idCancha === canchaSeleccionada)
          .map((r) => r.horario?.idHorario);
        setHorariosOcupados(ocupados);
      })
      .catch((err) => {
        console.error('Error al cargar horarios:', err);
        if (!cancelado) setErrorHorarios('No se pudieron cargar los horarios. Intenta de nuevo.');
      })
      .finally(() => {
        if (!cancelado) setCargandoHorarios(false);
      });

    return () => {
      cancelado = true;
    };
  }, [pasoActual, canchaSeleccionada, fechaISO]);

  const fechaTexto = fechaSeleccionada ? `lunes ${fechaSeleccionada} de septiembre` : '';
  const fechaLarga = fechaSeleccionada ? `Lunes ${fechaSeleccionada} de septiembre de ${ANIO_RESERVA}` : '';

  // ---- PASO 3: TUS DATOS ----
  const [datosCliente, setDatosCliente] = useState({
    nombre: '',
    apellido: '',
    dni: '',
    telefono: '',
  });
  const [erroresDatos, setErroresDatos] = useState({});

  const actualizarCampo = (campo, valor) => {
    setDatosCliente((prev) => ({ ...prev, [campo]: valor }));
  };

  const validarDatos = () => {
    const errores = {};
    if (!datosCliente.nombre.trim()) errores.nombre = 'Ingresa tu nombre.';
    if (!datosCliente.apellido.trim()) errores.apellido = 'Ingresa tu apellido.';
    if (!/^\d{8}$/.test(datosCliente.dni.trim())) errores.dni = 'El DNI debe tener 8 dígitos.';
    if (!/^\d{9}$/.test(datosCliente.telefono.trim())) errores.telefono = 'El teléfono debe tener 9 dígitos.';
    setErroresDatos(errores);
    return Object.keys(errores).length === 0;
  };

  // ---- PASO 4: RESUMEN Y PAGO ----
  const [enviandoReserva, setEnviandoReserva] = useState(false);
  const [errorEnvio, setErrorEnvio] = useState(null);
  const [reservaConfirmada, setReservaConfirmada] = useState(false);
  const [datosConfirmacion, setDatosConfirmacion] = useState(null);

  const confirmarReserva = async () => {
    setEnviandoReserva(true);
    setErrorEnvio(null);

    try {
      // 1. Buscar si el cliente ya existe por DNI; si no, crearlo
      let idClienteFinal;
      try {
        const clienteExistente = await ClienteService.buscarPorDni(datosCliente.dni.trim());
        idClienteFinal = clienteExistente.idCliente;
      } catch {
        const nuevoCliente = await ClienteService.registrar({
          nombre: datosCliente.nombre.trim(),
          apellido: datosCliente.apellido.trim(),
          dni: datosCliente.dni.trim(),
          telefono: datosCliente.telefono.trim(),
        });
        idClienteFinal = nuevoCliente.idCliente;
      }

      // 2. Crear la reserva
      const nuevaReserva = await ReservaService.crear({
        cliente: { idCliente: idClienteFinal },
        cancha: { idCancha: canchaSeleccionada },
        horario: { idHorario: horarioSeleccionado.idHorario },
        fecha: fechaISO,
      });

      // 3. Registrar el pago
      await PagoService.procesar({
        reserva: { idReserva: nuevaReserva.idReserva },
        total: horarioSeleccionado.precio,
      });

      setDatosConfirmacion({
        cancha: canchaSeleccionada,
        fecha: fechaLarga,
        horario: horarioSeleccionado.hora?.slice(0, 5),
        total: Number(horarioSeleccionado.precio),
      });
      setReservaConfirmada(true);
    } catch (err) {
      console.error('Error al confirmar la reserva:', err);
      setErrorEnvio('No se pudo confirmar la reserva. Es posible que ese horario ya haya sido tomado por otra persona. Vuelve al paso 2 y elige otro horario.');
    } finally {
      setEnviandoReserva(false);
    }
  };

  const hacerOtraReserva = () => {
    setPasoActual(1);
    setFechaSeleccionada(28);
    setCanchaSeleccionada(null);
    setHorarioSeleccionado(null);
    setDatosCliente({ nombre: '', apellido: '', dni: '', telefono: '' });
    setErroresDatos({});
    setErrorEnvio(null);
    setReservaConfirmada(false);
    setDatosConfirmacion(null);
  };

  // ===== PANTALLA DE ÉXITO =====
  if (reservaConfirmada && datosConfirmacion) {
    return (
      <div className="reserva-container">
        <header className="header con-sombra" id="header">
          <div className="container header-in">
            <Link to="/" className="marca">
              <span className="logo">V</span>
              <span className="marca-nombre">CanchaVóley</span>
            </Link>
            <nav className="menu" aria-label="Principal">
              <Link className="enlace" to="/">Inicio</Link>
              <Link className="enlace" to="/#canchas">Canchas</Link>
              <Link className="enlace" to="/#horarios">Horarios</Link>
              <Link className="enlace" to="/">Contacto</Link>
            </nav>
            <Link className="btn btn-primario header-cta" to="/reservar">Reservar</Link>
          </div>
        </header>

        <main className="container reserva-main">
          <div className="confirmacion-card">
            <div className="confirmacion-icono">✓</div>
            <h1>¡Reserva confirmada!</h1>
            <p>
              Te esperamos en la cancha {datosConfirmacion.cancha} el {datosConfirmacion.fecha.toLowerCase()} a las {datosConfirmacion.horario}.
            </p>

            <div className="confirmacion-detalle">
              <div className="resumen-fila">
                <span>Cancha</span>
                <strong>Cancha {datosConfirmacion.cancha}</strong>
              </div>
              <div className="resumen-fila">
                <span>Fecha</span>
                <strong>{datosConfirmacion.fecha}</strong>
              </div>
              <div className="resumen-fila">
                <span>Horario</span>
                <strong>{datosConfirmacion.horario}</strong>
              </div>
              <div className="resumen-fila">
                <span>Total pagado</span>
                <strong className="total-destacado">S/ {datosConfirmacion.total}</strong>
              </div>
            </div>

            <div className="confirmacion-acciones">
              <button type="button" className="btn btn-secundario" onClick={hacerOtraReserva}>
                Hacer otra reserva
              </button>
              <Link className="btn btn-primario" to="/">
                Volver al inicio
              </Link>
            </div>
          </div>
        </main>
      </div>
    );
  }

  return (
    <div className="reserva-container">
      <header className="header con-sombra" id="header">
        <div className="container header-in">
          <Link to="/" className="marca">
            <span className="logo">V</span>
            <span className="marca-nombre">CanchaVóley</span>
          </Link>

          <nav className="menu" aria-label="Principal">
            <Link className="enlace" to="/">Inicio</Link>
            <Link className="enlace" to="/#canchas">Canchas</Link>
            <Link className="enlace" to="/#horarios">Horarios</Link>
            <Link className="enlace" to="/">Contacto</Link>
          </nav>

          <Link className="btn btn-primario header-cta" to="/reservar">
            Reservar
          </Link>
        </div>
      </header>

      <main className="container reserva-main">
        <div className="reserva-header">
          <h1>Reserva tu cancha</h1>
          <p>Completa los 4 pasos para confirmar tu reserva.</p>
        </div>

        <div className="stepper">
          <div className={`step-item ${pasoActual >= 1 ? 'activo' : ''}`}>
            <span className="step-num">1</span>
            <span className="step-text">Fecha y cancha</span>
          </div>
          <div className="step-linea"></div>

          <div className={`step-item ${pasoActual >= 2 ? 'activo' : ''}`}>
            <span className="step-num">2</span>
            <span className="step-text">Horario</span>
          </div>
          <div className="step-linea"></div>

          <div className={`step-item ${pasoActual >= 3 ? 'activo' : ''}`}>
            <span className="step-num">3</span>
            <span className="step-text">Tus datos</span>
          </div>
          <div className="step-linea"></div>

          <div className={`step-item ${pasoActual >= 4 ? 'activo' : ''}`}>
            <span className="step-num">4</span>
            <span className="step-text">Resumen y pago</span>
          </div>
        </div>

        <div className="reserva-grid">
          <div className="reserva-card-paso">
            {/* ===== PASO 1: FECHA Y CANCHA ===== */}
            {pasoActual === 1 && (
              <>
                <section className="bloque-seleccion">
                  <h2>Elige la fecha</h2>
                  <p className="subtexto-bloque">Los días anteriores a hoy no están disponibles.</p>

                  <div className="calendario-box">
                    <div className="calendario-header">
                      <button type="button" className="cal-btn-nav">‹</button>
                      <span className="cal-mes">Septiembre 2026</span>
                      <button type="button" className="cal-btn-nav">›</button>
                    </div>

                    <div className="calendario-dias-semana">
                      <span>Lu</span><span>Ma</span><span>Mi</span><span>Ju</span>
                      <span>Vi</span><span>Sá</span><span>Do</span>
                    </div>

                    <div className="calendario-grid">
                      <div className="cal-dia vacio"></div>

                      {diasDeshabilitados.map((dia) => (
                        <button key={`dis-${dia}`} className="cal-dia deshabilitado" disabled>
                          {dia}
                        </button>
                      ))}

                      {diasHabilitados.map((dia) => (
                        <button
                          key={`hab-${dia}`}
                          type="button"
                          className={`cal-dia habilitado ${fechaSeleccionada === dia ? 'seleccionado' : ''}`}
                          onClick={() => setFechaSeleccionada(dia)}
                        >
                          {dia}
                        </button>
                      ))}
                    </div>
                  </div>
                </section>

                <section className="bloque-seleccion">
                  <h2>Elige la cancha</h2>
                  <div className="canchas-grid-selector">
                    {canchas.map((c) => (
                      <button
                        key={c.id}
                        type="button"
                        className={`cancha-opcion ${canchaSeleccionada === c.id ? 'seleccionada' : ''}`}
                        onClick={() => setCanchaSeleccionada(c.id)}
                      >
                        <span>Cancha</span>
                        <strong>{c.id}</strong>
                      </button>
                    ))}
                  </div>
                </section>

                <div className="reserva-acciones">
                  <button
                    type="button"
                    className="btn btn-primario btn-continuar"
                    disabled={!canchaSeleccionada || !fechaSeleccionada}
                    onClick={() => setPasoActual(2)}
                  >
                    Continuar
                  </button>
                </div>
              </>
            )}

            {/* ===== PASO 2: HORARIO ===== */}
            {pasoActual === 2 && (
              <>
                <section className="bloque-seleccion">
                  <h2>Elige tu horario</h2>
                  <p className="subtexto-bloque">
                    Los horarios en gris ya están reservados en la cancha {canchaSeleccionada} el {fechaTexto}.
                  </p>

                  <div className="horario-leyenda">
                    <span className="leyenda-item">
                      <span className="leyenda-punto disponible"></span> Disponible
                    </span>
                    <span className="leyenda-item">
                      <span className="leyenda-punto ocupado"></span> Ocupado
                    </span>
                    <span className="leyenda-item">
                      <span className="leyenda-punto seleccionado"></span> Seleccionado
                    </span>
                  </div>

                  {cargandoHorarios && <p className="estado-carga">Cargando horarios…</p>}
                  {errorHorarios && <p className="estado-error">{errorHorarios}</p>}

                  {!cargandoHorarios && !errorHorarios && (
                    <div className="horarios-grid-selector">
                      {horarios.map((h) => {
                        const ocupado = horariosOcupados.includes(h.idHorario);
                        const seleccionado = horarioSeleccionado?.idHorario === h.idHorario;
                        return (
                          <button
                            key={h.idHorario}
                            type="button"
                            className={`horario-slot ${ocupado ? 'ocupado' : seleccionado ? 'seleccionado' : 'disponible'}`}
                            disabled={ocupado}
                            onClick={() => setHorarioSeleccionado(h)}
                          >
                            <strong>{h.hora?.slice(0, 5)}</strong>
                            <span>S/ {Number(h.precio)}</span>
                          </button>
                        );
                      })}
                    </div>
                  )}
                </section>

                <div className="reserva-acciones acciones-dos-botones">
                  <button type="button" className="btn btn-secundario" onClick={() => setPasoActual(1)}>
                    Atrás
                  </button>
                  <button
                    type="button"
                    className="btn btn-primario btn-continuar"
                    disabled={!horarioSeleccionado}
                    onClick={() => setPasoActual(3)}
                  >
                    Continuar
                  </button>
                </div>
              </>
            )}

            {/* ===== PASO 3: TUS DATOS ===== */}
            {pasoActual === 3 && (
              <>
                <section className="bloque-seleccion">
                  <h2>Tus datos</h2>
                  <p className="subtexto-bloque">Los usaremos para registrar tu reserva.</p>

                  <div className="form-datos-grid">
                    <div className="campo-grupo">
                      <label className="campo-label" htmlFor="campo-nombre">Nombre</label>
                      <input
                        id="campo-nombre"
                        type="text"
                        className={`campo-input ${erroresDatos.nombre ? 'con-error' : ''}`}
                        placeholder="Escribe aquí"
                        value={datosCliente.nombre}
                        onChange={(e) => actualizarCampo('nombre', e.target.value)}
                      />
                      {erroresDatos.nombre && <span className="campo-ayuda-error">{erroresDatos.nombre}</span>}
                    </div>

                    <div className="campo-grupo">
                      <label className="campo-label" htmlFor="campo-apellido">Apellido</label>
                      <input
                        id="campo-apellido"
                        type="text"
                        className={`campo-input ${erroresDatos.apellido ? 'con-error' : ''}`}
                        placeholder="Escribe aquí"
                        value={datosCliente.apellido}
                        onChange={(e) => actualizarCampo('apellido', e.target.value)}
                      />
                      {erroresDatos.apellido && <span className="campo-ayuda-error">{erroresDatos.apellido}</span>}
                    </div>

                    <div className="campo-grupo">
                      <label className="campo-label" htmlFor="campo-dni">DNI</label>
                      <input
                        id="campo-dni"
                        type="text"
                        inputMode="numeric"
                        maxLength={8}
                        className={`campo-input ${erroresDatos.dni ? 'con-error' : ''}`}
                        placeholder="Escribe aquí"
                        value={datosCliente.dni}
                        onChange={(e) => actualizarCampo('dni', e.target.value.replace(/\D/g, ''))}
                      />
                      {erroresDatos.dni && <span className="campo-ayuda-error">{erroresDatos.dni}</span>}
                    </div>

                    <div className="campo-grupo">
                      <label className="campo-label" htmlFor="campo-telefono">Teléfono</label>
                      <input
                        id="campo-telefono"
                        type="text"
                        inputMode="numeric"
                        maxLength={9}
                        className={`campo-input ${erroresDatos.telefono ? 'con-error' : ''}`}
                        placeholder="Escribe aquí"
                        value={datosCliente.telefono}
                        onChange={(e) => actualizarCampo('telefono', e.target.value.replace(/\D/g, ''))}
                      />
                      {erroresDatos.telefono && <span className="campo-ayuda-error">{erroresDatos.telefono}</span>}
                    </div>
                  </div>
                </section>

                <div className="reserva-acciones acciones-dos-botones">
                  <button type="button" className="btn btn-secundario" onClick={() => setPasoActual(2)}>
                    Atrás
                  </button>
                  <button
                    type="button"
                    className="btn btn-primario btn-continuar"
                    onClick={() => {
                      if (validarDatos()) setPasoActual(4);
                    }}
                  >
                    Continuar
                  </button>
                </div>
              </>
            )}

            {/* ===== PASO 4: RESUMEN Y PAGO ===== */}
            {pasoActual === 4 && (
              <>
                <section className="bloque-seleccion">
                  <h2>Confirma tu reserva</h2>
                  <p className="subtexto-bloque">Revisa los datos antes de confirmar.</p>

                  <div className="confirma-filas">
                    <div className="confirma-fila">
                      <span>Cliente</span>
                      <strong>{datosCliente.nombre} {datosCliente.apellido}</strong>
                    </div>
                    <div className="confirma-fila">
                      <span>DNI</span>
                      <strong>{datosCliente.dni}</strong>
                    </div>
                    <div className="confirma-fila">
                      <span>Teléfono</span>
                      <strong>{datosCliente.telefono}</strong>
                    </div>
                    <div className="confirma-fila">
                      <span>Cancha</span>
                      <strong>Cancha {canchaSeleccionada}</strong>
                    </div>
                    <div className="confirma-fila">
                      <span>Fecha</span>
                      <strong>{fechaLarga}</strong>
                    </div>
                    <div className="confirma-fila">
                      <span>Horario</span>
                      <strong>{horarioSeleccionado?.hora?.slice(0, 5)}</strong>
                    </div>
                    <div className="confirma-fila">
                      <span>Precio por hora</span>
                      <strong>S/ {Number(horarioSeleccionado?.precio)}</strong>
                    </div>
                  </div>

                  <div className="total-a-pagar">
                    <span>Total a pagar</span>
                    <strong>S/ {Number(horarioSeleccionado?.precio)}</strong>
                  </div>

                  {errorEnvio && <p className="estado-error">{errorEnvio}</p>}
                </section>

                <div className="reserva-acciones acciones-dos-botones">
                  <button
                    type="button"
                    className="btn btn-secundario"
                    onClick={() => setPasoActual(3)}
                    disabled={enviandoReserva}
                  >
                    Atrás
                  </button>
                  <button
                    type="button"
                    className="btn btn-primario btn-continuar"
                    onClick={confirmarReserva}
                    disabled={enviandoReserva}
                  >
                    {enviandoReserva ? 'Confirmando…' : 'Confirmar reserva'}
                  </button>
                </div>
              </>
            )}
          </div>

          <aside className="reserva-resumen-card">
            <h3>Tu reserva</h3>

            <div className="resumen-filas">
              <div className="resumen-fila">
                <span>Fecha</span>
                <strong>{fechaSeleccionada ? `Lun ${fechaSeleccionada} sep 2026` : '—'}</strong>
              </div>

              <div className="resumen-fila">
                <span>Cancha</span>
                <strong>{canchaSeleccionada ? `Cancha ${canchaSeleccionada}` : '—'}</strong>
              </div>

              <div className="resumen-fila">
                <span>Horario</span>
                <strong>{horarioSeleccionado ? horarioSeleccionado.hora?.slice(0, 5) : '—'}</strong>
              </div>

              <hr className="resumen-divider" />

              <div className="resumen-fila total">
                <span>Total</span>
                <strong>{horarioSeleccionado ? `S/ ${Number(horarioSeleccionado.precio)}` : '—'}</strong>
              </div>
            </div>
          </aside>
        </div>
      </main>
    </div>
  );
}

export default ReservaPage;