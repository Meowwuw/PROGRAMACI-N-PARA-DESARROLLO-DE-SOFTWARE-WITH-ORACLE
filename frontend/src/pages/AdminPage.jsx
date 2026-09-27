import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { CanchaService } from '../services/CanchaService';
import { ClienteService } from '../services/ClienteService';
import { ReservaService } from '../services/ReservaService';
import { PagoService } from '../services/PagoService';
import { HorarioService } from '../services/HorarioService';
import './AdminPage.css';

const SECCIONES = [
  { id: 'dashboard', nombre: 'Dashboard' },
  { id: 'reservas', nombre: 'Reservas' },
  { id: 'canchas', nombre: 'Canchas' },
  { id: 'clientes', nombre: 'Clientes' },
  { id: 'horarios', nombre: 'Horarios' },
  { id: 'pagos', nombre: 'Pagos' },
];

const FORM_RESERVA_VACIO = { idCliente: '', idCancha: '', idHorario: '', fecha: '' };

export function AdminPage() {
  const navigate = useNavigate();
  const [seccionActiva, setSeccionActiva] = useState('dashboard');

  const [canchas, setCanchas] = useState([]);
  const [clientes, setClientes] = useState([]);
  const [reservas, setReservas] = useState([]);
  const [pagos, setPagos] = useState([]);
  const [horarios, setHorarios] = useState([]);
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    if (sessionStorage.getItem('admin_autenticado') !== 'true') {
      navigate('/');
    }
  }, [navigate]);

  const recargarDatos = useCallback(() => {
    setCargando(true);
    setError(null);
    return Promise.all([
      CanchaService.obtenerTodas(),
      ClienteService.obtenerTodos(),
      ReservaService.obtenerTodas(),
      PagoService.obtenerTodos(),
      HorarioService.obtenerTodos(),
    ])
      .then(([listaCanchas, listaClientes, listaReservas, listaPagos, listaHorarios]) => {
        setCanchas(listaCanchas);
        setClientes(listaClientes);
        setReservas(listaReservas);
        setPagos(listaPagos);
        setHorarios(listaHorarios);
      })
      .catch((err) => {
        console.error('Error al cargar datos del admin:', err);
        setError('No se pudieron cargar los datos del panel.');
      })
      .finally(() => setCargando(false));
  }, []);

  useEffect(() => {
    recargarDatos();
  }, [recargarDatos]);

  const cerrarSesion = () => {
    sessionStorage.removeItem('admin_autenticado');
    navigate('/');
  };

  // ---- CÁLCULOS PARA EL DASHBOARD ----
  const ingresosTotales = pagos.reduce((acum, p) => acum + Number(p.total || 0), 0);

  const ingresosPorCancha = canchas.map((c) => {
    const total = pagos
      .filter((p) => p.reserva?.cancha?.idCancha === c.idCancha)
      .reduce((acum, p) => acum + Number(p.total || 0), 0);
    return { numero: c.numeroCancha, total };
  });

  const maxIngresoCancha = Math.max(1, ...ingresosPorCancha.map((c) => c.total));

  const hoy = new Date();
  hoy.setHours(0, 0, 0, 0);

  const proximasReservas = [...reservas]
    .filter((r) => new Date(r.fecha + 'T00:00:00') >= hoy)
    .sort((a, b) => {
      if (a.fecha !== b.fecha) return a.fecha.localeCompare(b.fecha);
      return (a.horario?.hora || '').localeCompare(b.horario?.hora || '');
    })
    .slice(0, 5);

  const formatearFechaCorta = (fechaISO) => {
    const [, mes, dia] = fechaISO.split('-');
    const meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
    return `${dia} ${meses[parseInt(mes, 10) - 1]}`;
  };

  const formatearFechaCorta2 = (fechaISO) => {
    const [anio, mes, dia] = fechaISO.split('-');
    return `${dia}/${mes}/${anio}`;
  };

  // ---- SECCIÓN RESERVAS ----
  const [filtroReservas, setFiltroReservas] = useState('todas'); // todas | fecha | cliente | cancha
  const [busquedaReservas, setBusquedaReservas] = useState('');

  const [modalReservaAbierto, setModalReservaAbierto] = useState(false);
  const [cerrandoModalReserva, setCerrandoModalReserva] = useState(false);
  const [reservaEditando, setReservaEditando] = useState(null);
  const [formReserva, setFormReserva] = useState(FORM_RESERVA_VACIO);
  const [guardandoReserva, setGuardandoReserva] = useState(false);
  const [errorReserva, setErrorReserva] = useState('');

  const obtenerTotalReserva = (r) => {
    const pago = pagos.find((p) => p.reserva?.idReserva === r.idReserva);
    return pago ? Number(pago.total) : Number(r.horario?.precio || 0);
  };

  const reservasFiltradas = [...reservas]
    .filter((r) => {
      const q = busquedaReservas.trim().toLowerCase();
      if (!q) return true;
      if (filtroReservas === 'todas') return String(r.idReserva).includes(q);
      if (filtroReservas === 'fecha') return r.fecha.includes(q);
      if (filtroReservas === 'cliente') {
        return `${r.cliente?.nombre || ''} ${r.cliente?.apellido || ''}`.toLowerCase().includes(q);
      }
      if (filtroReservas === 'cancha') return String(r.cancha?.numeroCancha || '').includes(q);
      return true;
    })
    .sort((a, b) => a.idReserva - b.idReserva);

  const abrirNuevaReserva = () => {
    setFormReserva(FORM_RESERVA_VACIO);
    setReservaEditando(null);
    setErrorReserva('');
    setCerrandoModalReserva(false);
    setModalReservaAbierto(true);
  };

  const abrirEditarReserva = (r) => {
    setFormReserva({
      idCliente: r.cliente?.idCliente || '',
      idCancha: r.cancha?.idCancha || '',
      idHorario: r.horario?.idHorario || '',
      fecha: r.fecha || '',
    });
    setReservaEditando(r);
    setErrorReserva('');
    setCerrandoModalReserva(false);
    setModalReservaAbierto(true);
  };

  const cerrarModalReserva = () => {
    setCerrandoModalReserva(true);
    setTimeout(() => {
      setModalReservaAbierto(false);
      setCerrandoModalReserva(false);
    }, 200);
  };

  const guardarReserva = (e) => {
    e.preventDefault();
    if (!formReserva.idCliente || !formReserva.idCancha || !formReserva.idHorario || !formReserva.fecha) {
      setErrorReserva('Completa todos los campos.');
      return;
    }

    setGuardandoReserva(true);
    setErrorReserva('');

    const payload = {
      cliente: { idCliente: Number(formReserva.idCliente) },
      cancha: { idCancha: Number(formReserva.idCancha) },
      horario: { idHorario: Number(formReserva.idHorario) },
      fecha: formReserva.fecha,
    };

    const promesa = reservaEditando
      ? ReservaService.actualizar(reservaEditando.idReserva, payload)
      : ReservaService.crear(payload);

    promesa
      .then(() => {
        cerrarModalReserva();
        recargarDatos();
      })
      .catch((err) => {
        console.error('Error al guardar la reserva:', err);
        setErrorReserva('No se pudo guardar. Puede que ya exista una reserva en esa cancha, fecha y horario.');
      })
      .finally(() => setGuardandoReserva(false));
  };

  const eliminarReserva = (r) => {
    if (!window.confirm(`¿Eliminar la reserva #${r.idReserva}?`)) return;
    ReservaService.eliminar(r.idReserva)
      .then(() => recargarDatos())
      .catch((err) => {
        console.error('Error al eliminar la reserva:', err);
        window.alert('No se pudo eliminar la reserva.');
      });
  };

  // ---- SECCIÓN CANCHAS ----
  const [filtroCanchas, setFiltroCanchas] = useState('todas'); // todas | id | numero
  const [busquedaCanchas, setBusquedaCanchas] = useState('');

  const [modalCanchaAbierto, setModalCanchaAbierto] = useState(false);
  const [cerrandoModalCancha, setCerrandoModalCancha] = useState(false);
  const [canchaEditando, setCanchaEditando] = useState(null);
  const [formCancha, setFormCancha] = useState({ numeroCancha: '' });
  const [guardandoCancha, setGuardandoCancha] = useState(false);
  const [errorCancha, setErrorCancha] = useState('');

  const canchasFiltradas = [...canchas]
    .filter((c) => {
      const q = busquedaCanchas.trim().toLowerCase();
      if (!q) return true;
      if (filtroCanchas === 'id') return String(c.idCancha).includes(q);
      return String(c.numeroCancha).includes(q);
    })
    .sort((a, b) => a.idCancha - b.idCancha);

  const abrirNuevaCancha = () => {
    setFormCancha({ numeroCancha: '' });
    setCanchaEditando(null);
    setErrorCancha('');
    setCerrandoModalCancha(false);
    setModalCanchaAbierto(true);
  };

  const abrirEditarCancha = (c) => {
    setFormCancha({ numeroCancha: c.numeroCancha });
    setCanchaEditando(c);
    setErrorCancha('');
    setCerrandoModalCancha(false);
    setModalCanchaAbierto(true);
  };

  const cerrarModalCancha = () => {
    setCerrandoModalCancha(true);
    setTimeout(() => {
      setModalCanchaAbierto(false);
      setCerrandoModalCancha(false);
    }, 200);
  };

  const guardarCancha = (e) => {
    e.preventDefault();
    if (!formCancha.numeroCancha) {
      setErrorCancha('Ingresa el número de cancha.');
      return;
    }

    setGuardandoCancha(true);
    setErrorCancha('');

    const payload = { numeroCancha: Number(formCancha.numeroCancha) };

    const promesa = canchaEditando
      ? CanchaService.actualizar(canchaEditando.idCancha, payload)
      : CanchaService.crear(payload);

    promesa
      .then(() => {
        cerrarModalCancha();
        recargarDatos();
      })
      .catch((err) => {
        console.error('Error al guardar la cancha:', err);
        setErrorCancha('No se pudo guardar. Puede que ese número de cancha ya exista.');
      })
      .finally(() => setGuardandoCancha(false));
  };

  const eliminarCancha = (c) => {
    if (!window.confirm(`¿Eliminar la Cancha ${c.numeroCancha}?`)) return;
    CanchaService.eliminar(c.idCancha)
      .then(() => recargarDatos())
      .catch((err) => {
        console.error('Error al eliminar la cancha:', err);
        window.alert('No se pudo eliminar la cancha (puede tener reservas asociadas).');
      });
  };

  // ---- SECCIÓN CLIENTES ----
  const [filtroClientes, setFiltroClientes] = useState('todos'); // todos | dni | apellido
  const [busquedaClientes, setBusquedaClientes] = useState('');

  const [modalClienteAbierto, setModalClienteAbierto] = useState(false);
  const [cerrandoModalCliente, setCerrandoModalCliente] = useState(false);
  const [clienteEditando, setClienteEditando] = useState(null);
  const [formCliente, setFormCliente] = useState({ nombre: '', apellido: '', dni: '', telefono: '' });
  const [guardandoCliente, setGuardandoCliente] = useState(false);
  const [errorCliente, setErrorCliente] = useState('');

  const clientesFiltrados = [...clientes]
    .filter((c) => {
      const q = busquedaClientes.trim().toLowerCase();
      if (!q) return true;
      if (filtroClientes === 'dni') return c.dni.includes(q);
      if (filtroClientes === 'apellido') return c.apellido.toLowerCase().includes(q);
      return `${c.nombre} ${c.apellido} ${c.dni}`.toLowerCase().includes(q);
    })
    .sort((a, b) => a.idCliente - b.idCliente);

  const abrirNuevoCliente = () => {
    setFormCliente({ nombre: '', apellido: '', dni: '', telefono: '' });
    setClienteEditando(null);
    setErrorCliente('');
    setCerrandoModalCliente(false);
    setModalClienteAbierto(true);
  };

  const abrirEditarCliente = (c) => {
    setFormCliente({ nombre: c.nombre, apellido: c.apellido, dni: c.dni, telefono: c.telefono });
    setClienteEditando(c);
    setErrorCliente('');
    setCerrandoModalCliente(false);
    setModalClienteAbierto(true);
  };

  const cerrarModalCliente = () => {
    setCerrandoModalCliente(true);
    setTimeout(() => {
      setModalClienteAbierto(false);
      setCerrandoModalCliente(false);
    }, 200);
  };

  const guardarCliente = (e) => {
    e.preventDefault();
    if (!formCliente.nombre.trim() || !formCliente.apellido.trim()) {
      setErrorCliente('Completa nombre y apellido.');
      return;
    }
    if (!/^\d{8}$/.test(formCliente.dni.trim())) {
      setErrorCliente('El DNI debe tener 8 dígitos.');
      return;
    }
    if (!/^\d{9}$/.test(formCliente.telefono.trim())) {
      setErrorCliente('El teléfono debe tener 9 dígitos.');
      return;
    }

    setGuardandoCliente(true);
    setErrorCliente('');

    const payload = {
      nombre: formCliente.nombre.trim(),
      apellido: formCliente.apellido.trim(),
      dni: formCliente.dni.trim(),
      telefono: formCliente.telefono.trim(),
    };

    const promesa = clienteEditando
      ? ClienteService.actualizar(clienteEditando.idCliente, payload)
      : ClienteService.registrar(payload);

    promesa
      .then(() => {
        cerrarModalCliente();
        recargarDatos();
      })
      .catch((err) => {
        console.error('Error al guardar el cliente:', err);
        setErrorCliente('No se pudo guardar. Puede que ese DNI ya esté registrado.');
      })
      .finally(() => setGuardandoCliente(false));
  };

  const eliminarCliente = (c) => {
    if (!window.confirm(`¿Eliminar a ${c.nombre} ${c.apellido}?`)) return;
    ClienteService.eliminar(c.idCliente)
      .then(() => recargarDatos())
      .catch((err) => {
        console.error('Error al eliminar el cliente:', err);
        window.alert('No se pudo eliminar el cliente (puede tener reservas asociadas).');
      });
  };

  // ---- SECCIÓN HORARIOS ----
  const [filtroHorarios, setFiltroHorarios] = useState('todos'); // todos | hora | precio
  const [busquedaHorarios, setBusquedaHorarios] = useState('');

  const [modalHorarioAbierto, setModalHorarioAbierto] = useState(false);
  const [cerrandoModalHorario, setCerrandoModalHorario] = useState(false);
  const [horarioEditando, setHorarioEditando] = useState(null);
  const [formHorario, setFormHorario] = useState({ hora: '', precio: '' });
  const [guardandoHorario, setGuardandoHorario] = useState(false);
  const [errorHorarioForm, setErrorHorarioForm] = useState('');

  const horariosFiltrados = [...horarios]
    .filter((h) => {
      const q = busquedaHorarios.trim().toLowerCase();
      if (!q) return true;
      if (filtroHorarios === 'precio') return String(Number(h.precio)).includes(q);
      return h.hora?.slice(0, 5).includes(q);
    })
    .sort((a, b) => a.idHorario - b.idHorario);

  const abrirNuevoHorario = () => {
    setFormHorario({ hora: '', precio: '' });
    setHorarioEditando(null);
    setErrorHorarioForm('');
    setCerrandoModalHorario(false);
    setModalHorarioAbierto(true);
  };

  const abrirEditarHorario = (h) => {
    setFormHorario({ hora: h.hora?.slice(0, 5) || '', precio: h.precio });
    setHorarioEditando(h);
    setErrorHorarioForm('');
    setCerrandoModalHorario(false);
    setModalHorarioAbierto(true);
  };

  const cerrarModalHorario = () => {
    setCerrandoModalHorario(true);
    setTimeout(() => {
      setModalHorarioAbierto(false);
      setCerrandoModalHorario(false);
    }, 200);
  };

  const guardarHorario = (e) => {
    e.preventDefault();
    if (!formHorario.hora || !formHorario.precio) {
      setErrorHorarioForm('Completa la hora y el precio.');
      return;
    }

    setGuardandoHorario(true);
    setErrorHorarioForm('');

    const payload = { hora: formHorario.hora, precio: Number(formHorario.precio) };

    const promesa = horarioEditando
      ? HorarioService.actualizar(horarioEditando.idHorario, payload)
      : HorarioService.crear(payload);

    promesa
      .then(() => {
        cerrarModalHorario();
        recargarDatos();
      })
      .catch((err) => {
        console.error('Error al guardar el horario:', err);
        setErrorHorarioForm('No se pudo guardar. Puede que esa hora ya esté registrada.');
      })
      .finally(() => setGuardandoHorario(false));
  };

  const eliminarHorario = (h) => {
    if (!window.confirm(`¿Eliminar el horario ${h.hora?.slice(0, 5)}?`)) return;
    HorarioService.eliminar(h.idHorario)
      .then(() => recargarDatos())
      .catch((err) => {
        console.error('Error al eliminar el horario:', err);
        window.alert('No se pudo eliminar el horario (puede tener reservas asociadas).');
      });
  };

  // ---- SECCIÓN PAGOS ----
  const [filtroPagos, setFiltroPagos] = useState('todos'); // todos | reserva | cancha
  const [busquedaPagos, setBusquedaPagos] = useState('');

  const [modalPagoAbierto, setModalPagoAbierto] = useState(false);
  const [cerrandoModalPago, setCerrandoModalPago] = useState(false);
  const [pagoEditando, setPagoEditando] = useState(null);
  const [formPago, setFormPago] = useState({ idReserva: '', total: '' });
  const [guardandoPago, setGuardandoPago] = useState(false);
  const [errorPagoForm, setErrorPagoForm] = useState('');

  const totalPagos = pagos.reduce((acum, p) => acum + Number(p.total || 0), 0);
  const ticketPromedio = pagos.length > 0 ? Math.round(totalPagos / pagos.length) : 0;

  const canchaConMasIngresos = ingresosPorCancha.reduce(
    (mejor, c) => (c.total > (mejor?.total || 0) ? c : mejor),
    null
  );

  const reservasSinPago = reservas.filter(
    (r) => !pagos.some((p) => p.reserva?.idReserva === r.idReserva)
  );

  const pagosFiltrados = [...pagos]
    .filter((p) => {
      const q = busquedaPagos.trim().toLowerCase();
      if (!q) return true;
      if (filtroPagos === 'reserva') return String(p.reserva?.idReserva || '').includes(q);
      if (filtroPagos === 'cancha') return String(p.reserva?.cancha?.numeroCancha || '').includes(q);
      return String(p.idPago).includes(q);
    })
    .sort((a, b) => a.idPago - b.idPago);

  const abrirNuevoPago = () => {
    setFormPago({ idReserva: '', total: '' });
    setPagoEditando(null);
    setErrorPagoForm('');
    setCerrandoModalPago(false);
    setModalPagoAbierto(true);
  };

  const abrirEditarPago = (p) => {
    setFormPago({ idReserva: p.reserva?.idReserva || '', total: p.total });
    setPagoEditando(p);
    setErrorPagoForm('');
    setCerrandoModalPago(false);
    setModalPagoAbierto(true);
  };

  const cerrarModalPago = () => {
    setCerrandoModalPago(true);
    setTimeout(() => {
      setModalPagoAbierto(false);
      setCerrandoModalPago(false);
    }, 200);
  };

  const guardarPago = (e) => {
    e.preventDefault();
    if (!formPago.idReserva || !formPago.total) {
      setErrorPagoForm('Completa la reserva y el total.');
      return;
    }

    setGuardandoPago(true);
    setErrorPagoForm('');

    const payload = {
      reserva: { idReserva: Number(formPago.idReserva) },
      total: Number(formPago.total),
    };

    const promesa = pagoEditando
      ? PagoService.actualizar(pagoEditando.idPago, payload)
      : PagoService.procesar(payload);

    promesa
      .then(() => {
        cerrarModalPago();
        recargarDatos();
      })
      .catch((err) => {
        console.error('Error al guardar el pago:', err);
        setErrorPagoForm('No se pudo guardar. Puede que esa reserva ya tenga un pago registrado.');
      })
      .finally(() => setGuardandoPago(false));
  };

  const eliminarPago = (p) => {
    if (!window.confirm(`¿Eliminar el pago #${p.idPago}?`)) return;
    PagoService.eliminar(p.idPago)
      .then(() => recargarDatos())
      .catch((err) => {
        console.error('Error al eliminar el pago:', err);
        window.alert('No se pudo eliminar el pago.');
      });
  };

  return (
    <div className="admin-layout">
      <aside className="admin-sidebar">
        <div className="admin-marca">
          <span className="logo">V</span>
          <span className="marca-nombre">CanchaVóley</span>
        </div>

        <span className="admin-etiqueta">Panel admin</span>

        <nav className="admin-nav">
          {SECCIONES.map((s, idx) => (
            <button
              key={s.id}
              type="button"
              className={`admin-nav-item ${seccionActiva === s.id ? 'activo' : ''}`}
              style={{ animationDelay: `${idx * 0.04}s` }}
              onClick={() => setSeccionActiva(s.id)}
            >
              {s.nombre}
            </button>
          ))}
        </nav>

        <button type="button" className="admin-cerrar-sesion" onClick={cerrarSesion}>
          Cerrar sesión
        </button>
      </aside>

      <main className="admin-contenido">
        {cargando && <p className="estado-carga">Cargando panel…</p>}
        {error && <p className="estado-error">{error}</p>}

        {!cargando && !error && (
          <div key={seccionActiva} className="admin-vista">
            {seccionActiva === 'dashboard' && (
              <>
                <div className="admin-encabezado">
                  <div>
                    <h1>Dashboard</h1>
                    <p>Resumen general de reservas e ingresos.</p>
                  </div>
                </div>

                <div className="admin-tarjetas">
                  <div className="admin-tarjeta" style={{ animationDelay: '0s' }}>
                    <span>Reservas</span>
                    <strong>{reservas.length}</strong>
                    <small>registradas</small>
                  </div>
                  <div className="admin-tarjeta" style={{ animationDelay: '0.06s' }}>
                    <span>Ingresos totales</span>
                    <strong>S/ {ingresosTotales}</strong>
                    <small>suma de pagos</small>
                  </div>
                  <div className="admin-tarjeta" style={{ animationDelay: '0.12s' }}>
                    <span>Canchas</span>
                    <strong>{canchas.length}</strong>
                    <small>disponibles</small>
                  </div>
                  <div className="admin-tarjeta" style={{ animationDelay: '0.18s' }}>
                    <span>Clientes</span>
                    <strong>{clientes.length}</strong>
                    <small>registrados</small>
                  </div>
                </div>

                <div className="admin-paneles-dobles">
                  <div className="admin-panel" style={{ animationDelay: '0.24s' }}>
                    <h3>Ingresos por cancha</h3>
                    <div className="admin-barras">
                      {ingresosPorCancha.map((c) => (
                        <div key={c.numero} className="admin-barra-col">
                          <span className="admin-barra-valor">S/ {c.total}</span>
                          <div
                            className="admin-barra"
                            style={{ height: `${(c.total / maxIngresoCancha) * 160 || 4}px` }}
                          ></div>
                          <span className="admin-barra-label">Cancha {c.numero}</span>
                        </div>
                      ))}
                    </div>
                  </div>

                  <div className="admin-panel" style={{ animationDelay: '0.3s' }}>
                    <h3>Próximas reservas</h3>
                    <div className="admin-lista-reservas">
                      {proximasReservas.length === 0 && <p className="subtexto-bloque">No hay reservas próximas.</p>}
                      {proximasReservas.map((r) => (
                        <div key={r.idReserva} className="admin-fila-reserva">
                          <span>{r.cliente?.nombre} {r.cliente?.apellido} · Cancha {r.cancha?.numeroCancha}</span>
                          <strong>{formatearFechaCorta(r.fecha)} · {r.horario?.hora?.slice(0, 5)}</strong>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              </>
            )}

            {seccionActiva === 'reservas' && (
              <>
                <div className="admin-encabezado">
                  <div>
                    <h1>Reservas</h1>
                    <p>Consulta y administra todas las reservas.</p>
                  </div>
                  <button type="button" className="admin-btn-primario" onClick={abrirNuevaReserva}>
                    Nueva reserva
                  </button>
                </div>

                <div className="admin-filtros">
                  <input
                    type="text"
                    className="admin-buscador"
                    placeholder={
                      filtroReservas === 'todas'
                        ? 'Buscar por ID...'
                        : filtroReservas === 'fecha'
                        ? 'Buscar por fecha (AAAA-MM-DD)...'
                        : filtroReservas === 'cliente'
                        ? 'Buscar por nombre de cliente...'
                        : 'Buscar por número de cancha...'
                    }
                    value={busquedaReservas}
                    onChange={(e) => setBusquedaReservas(e.target.value)}
                  />
                  <div className="admin-chips-filtro">
                    {[
                      { id: 'todas', nombre: 'Todas' },
                      { id: 'fecha', nombre: 'Por fecha' },
                      { id: 'cliente', nombre: 'Por cliente' },
                      { id: 'cancha', nombre: 'Por cancha' },
                    ].map((f) => (
                      <button
                        key={f.id}
                        type="button"
                        className={`admin-chip ${filtroReservas === f.id ? 'activo' : ''}`}
                        onClick={() => {
                          setFiltroReservas(f.id);
                          setBusquedaReservas('');
                        }}
                      >
                        {f.nombre}
                      </button>
                    ))}
                  </div>
                </div>

                <div className="admin-tabla-wrap">
                  <table className="admin-tabla">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Cancha</th>
                        <th>Fecha</th>
                        <th>Horario</th>
                        <th>Precio/hora</th>
                        <th>Total</th>
                        <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      {reservasFiltradas.map((r) => (
                        <tr key={r.idReserva}>
                          <td>{r.idReserva}</td>
                          <td>{r.cliente?.nombre} {r.cliente?.apellido}</td>
                          <td>{r.cancha?.numeroCancha}</td>
                          <td>{formatearFechaCorta2(r.fecha)}</td>
                          <td>{r.horario?.hora?.slice(0, 5)}</td>
                          <td>S/ {Number(r.horario?.precio)}</td>
                          <td>S/ {obtenerTotalReserva(r)}</td>
                          <td>
                            <button type="button" className="admin-link-editar" onClick={() => abrirEditarReserva(r)}>
                              Editar
                            </button>{' '}
                            <button type="button" className="admin-link-eliminar" onClick={() => eliminarReserva(r)}>
                              Eliminar
                            </button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                <p className="admin-conteo">
                  Mostrando {reservasFiltradas.length} de {reservas.length} reservas
                </p>
              </>
            )}

            {seccionActiva === 'canchas' && (
              <>
                <div className="admin-encabezado">
                  <div>
                    <h1>Canchas</h1>
                    <p>Administra las canchas disponibles.</p>
                  </div>
                  <button type="button" className="admin-btn-primario" onClick={abrirNuevaCancha}>
                    Nueva cancha
                  </button>
                </div>

                <div className="admin-filtros">
                  <input
                    type="text"
                    className="admin-buscador"
                    placeholder={filtroCanchas === 'id' ? 'Buscar por ID...' : 'Buscar por número...'}
                    value={busquedaCanchas}
                    onChange={(e) => setBusquedaCanchas(e.target.value)}
                  />
                  <div className="admin-chips-filtro">
                    {[
                      { id: 'todas', nombre: 'Todas' },
                      { id: 'id', nombre: 'Por ID' },
                      { id: 'numero', nombre: 'Por número' },
                    ].map((f) => (
                      <button
                        key={f.id}
                        type="button"
                        className={`admin-chip ${filtroCanchas === f.id ? 'activo' : ''}`}
                        onClick={() => {
                          setFiltroCanchas(f.id);
                          setBusquedaCanchas('');
                        }}
                      >
                        {f.nombre}
                      </button>
                    ))}
                  </div>
                </div>

                <div className="admin-tabla-wrap">
                  <table className="admin-tabla">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Número de cancha</th>
                        <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      {canchasFiltradas.map((c) => (
                        <tr key={c.idCancha}>
                          <td>{c.idCancha}</td>
                          <td>{c.numeroCancha}</td>
                          <td>
                            <button type="button" className="admin-link-editar" onClick={() => abrirEditarCancha(c)}>
                              Editar
                            </button>{' '}
                            <button type="button" className="admin-link-eliminar" onClick={() => eliminarCancha(c)}>
                              Eliminar
                            </button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                <p className="admin-conteo">
                  Mostrando {canchasFiltradas.length} de {canchas.length} canchas
                </p>
              </>
            )}

            {seccionActiva === 'clientes' && (
              <>
                <div className="admin-encabezado">
                  <div>
                    <h1>Clientes</h1>
                    <p>Datos de las personas que reservan.</p>
                  </div>
                  <button type="button" className="admin-btn-primario" onClick={abrirNuevoCliente}>
                    Nuevo cliente
                  </button>
                </div>

                <div className="admin-filtros">
                  <input
                    type="text"
                    className="admin-buscador"
                    placeholder={
                      filtroClientes === 'dni'
                        ? 'Buscar por DNI...'
                        : filtroClientes === 'apellido'
                        ? 'Buscar por apellido...'
                        : 'Buscar por nombre o DNI...'
                    }
                    value={busquedaClientes}
                    onChange={(e) => setBusquedaClientes(e.target.value)}
                  />
                  <div className="admin-chips-filtro">
                    {[
                      { id: 'todos', nombre: 'Todos' },
                      { id: 'dni', nombre: 'Por DNI' },
                      { id: 'apellido', nombre: 'Por apellido' },
                    ].map((f) => (
                      <button
                        key={f.id}
                        type="button"
                        className={`admin-chip ${filtroClientes === f.id ? 'activo' : ''}`}
                        onClick={() => {
                          setFiltroClientes(f.id);
                          setBusquedaClientes('');
                        }}
                      >
                        {f.nombre}
                      </button>
                    ))}
                  </div>
                </div>

                <div className="admin-tabla-wrap">
                  <table className="admin-tabla">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>DNI</th>
                        <th>Teléfono</th>
                        <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      {clientesFiltrados.map((c) => (
                        <tr key={c.idCliente}>
                          <td>{c.idCliente}</td>
                          <td>{c.nombre}</td>
                          <td>{c.apellido}</td>
                          <td>{c.dni}</td>
                          <td>{c.telefono}</td>
                          <td>
                            <button type="button" className="admin-link-editar" onClick={() => abrirEditarCliente(c)}>
                              Editar
                            </button>{' '}
                            <button type="button" className="admin-link-eliminar" onClick={() => eliminarCliente(c)}>
                              Eliminar
                            </button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                <p className="admin-conteo">
                  Mostrando {clientesFiltrados.length} de {clientes.length} clientes
                </p>
              </>
            )}

            {seccionActiva === 'horarios' && (
              <>
                <div className="admin-encabezado">
                  <div>
                    <h1>Horarios</h1>
                    <p>Horas disponibles y su precio por hora.</p>
                  </div>
                  <button type="button" className="admin-btn-primario" onClick={abrirNuevoHorario}>
                    Nuevo horario
                  </button>
                </div>

                <div className="admin-filtros">
                  <input
                    type="text"
                    className="admin-buscador"
                    placeholder={filtroHorarios === 'precio' ? 'Buscar por precio...' : 'Buscar por hora...'}
                    value={busquedaHorarios}
                    onChange={(e) => setBusquedaHorarios(e.target.value)}
                  />
                  <div className="admin-chips-filtro">
                    {[
                      { id: 'todos', nombre: 'Todos' },
                      { id: 'hora', nombre: 'Por hora' },
                      { id: 'precio', nombre: 'Por precio' },
                    ].map((f) => (
                      <button
                        key={f.id}
                        type="button"
                        className={`admin-chip ${filtroHorarios === f.id ? 'activo' : ''}`}
                        onClick={() => {
                          setFiltroHorarios(f.id);
                          setBusquedaHorarios('');
                        }}
                      >
                        {f.nombre}
                      </button>
                    ))}
                  </div>
                </div>

                <div className="admin-tabla-wrap">
                  <table className="admin-tabla">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Hora</th>
                        <th>Precio por hora</th>
                        <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      {horariosFiltrados.map((h) => (
                        <tr key={h.idHorario}>
                          <td>{h.idHorario}</td>
                          <td>{h.hora?.slice(0, 5)}</td>
                          <td>S/ {Number(h.precio)}</td>
                          <td>
                            <button type="button" className="admin-link-editar" onClick={() => abrirEditarHorario(h)}>
                              Editar
                            </button>{' '}
                            <button type="button" className="admin-link-eliminar" onClick={() => eliminarHorario(h)}>
                              Eliminar
                            </button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                <p className="admin-conteo">
                  Mostrando {horariosFiltrados.length} de {horarios.length} horarios
                </p>
              </>
            )}

            {seccionActiva === 'pagos' && (
              <>
                <div className="admin-encabezado">
                  <div>
                    <h1>Pagos</h1>
                    <p>Pagos registrados por reserva.</p>
                  </div>
                  <button type="button" className="admin-btn-primario" onClick={abrirNuevoPago}>
                    Nuevo pago
                  </button>
                </div>

                <div className="admin-tarjetas">
                  <div className="admin-tarjeta" style={{ animationDelay: '0s' }}>
                    <span>Total pagos</span>
                    <strong>S/ {totalPagos}</strong>
                    <small>{pagos.length} pagos registrados</small>
                  </div>
                  <div className="admin-tarjeta" style={{ animationDelay: '0.06s' }}>
                    <span>Cancha con más ingresos</span>
                    <strong>{canchaConMasIngresos ? `Cancha ${canchaConMasIngresos.numero}` : '—'}</strong>
                    <small>S/ {canchaConMasIngresos?.total || 0}</small>
                  </div>
                  <div className="admin-tarjeta" style={{ animationDelay: '0.12s' }}>
                    <span>Ticket promedio</span>
                    <strong>S/ {ticketPromedio}</strong>
                    <small>por reserva</small>
                  </div>
                </div>

                <div className="admin-filtros">
                  <input
                    type="text"
                    className="admin-buscador"
                    placeholder={
                      filtroPagos === 'reserva'
                        ? 'Buscar por ID de reserva...'
                        : filtroPagos === 'cancha'
                        ? 'Buscar por número de cancha...'
                        : 'Buscar por ID de pago...'
                    }
                    value={busquedaPagos}
                    onChange={(e) => setBusquedaPagos(e.target.value)}
                  />
                  <div className="admin-chips-filtro">
                    {[
                      { id: 'todos', nombre: 'Todos' },
                      { id: 'reserva', nombre: 'Por reserva' },
                      { id: 'cancha', nombre: 'Por cancha' },
                    ].map((f) => (
                      <button
                        key={f.id}
                        type="button"
                        className={`admin-chip ${filtroPagos === f.id ? 'activo' : ''}`}
                        onClick={() => {
                          setFiltroPagos(f.id);
                          setBusquedaPagos('');
                        }}
                      >
                        {f.nombre}
                      </button>
                    ))}
                  </div>
                </div>

                <div className="admin-tabla-wrap">
                  <table className="admin-tabla">
                    <thead>
                      <tr>
                        <th>ID pago</th>
                        <th>ID reserva</th>
                        <th>Total</th>
                        <th>Acciones</th>
                      </tr>
                    </thead>
                    <tbody>
                      {pagosFiltrados.map((p) => (
                        <tr key={p.idPago}>
                          <td>{p.idPago}</td>
                          <td>{p.reserva?.idReserva}</td>
                          <td>S/ {Number(p.total)}</td>
                          <td>
                            <button type="button" className="admin-link-editar" onClick={() => abrirEditarPago(p)}>
                              Editar
                            </button>{' '}
                            <button type="button" className="admin-link-eliminar" onClick={() => eliminarPago(p)}>
                              Eliminar
                            </button>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>

                <p className="admin-conteo">
                  Mostrando {pagosFiltrados.length} de {pagos.length} pagos
                </p>
              </>
            )}

            {seccionActiva !== 'dashboard' &&
              seccionActiva !== 'reservas' &&
              seccionActiva !== 'canchas' &&
              seccionActiva !== 'clientes' &&
              seccionActiva !== 'horarios' &&
              seccionActiva !== 'pagos' && (
              <div className="admin-encabezado">
                <div>
                  <h1>{SECCIONES.find((s) => s.id === seccionActiva)?.nombre}</h1>
                  <p>Esta sección la construimos en el siguiente paso.</p>
                </div>
              </div>
            )}
          </div>
        )}
      </main>

      {/* MODAL NUEVA / EDITAR RESERVA */}
      {modalReservaAbierto && (
        <div
          className={`admin-modal-overlay ${cerrandoModalReserva ? 'salida' : ''}`}
          onClick={cerrarModalReserva}
        >
          <div
            className={`admin-modal-contenido ${cerrandoModalReserva ? 'salida' : ''}`}
            onClick={(e) => e.stopPropagation()}
          >
            <button className="modal-cerrar" type="button" onClick={cerrarModalReserva} aria-label="Cerrar modal">
              ✕
            </button>

            <h2>{reservaEditando ? 'Editar reserva' : 'Nueva reserva'}</h2>

            <form onSubmit={guardarReserva} className="admin-form">
              <div className="campo-grupo">
                <label className="campo-label">Cliente</label>
                <select
                  className="campo-input"
                  value={formReserva.idCliente}
                  onChange={(e) => setFormReserva((prev) => ({ ...prev, idCliente: e.target.value }))}
                >
                  <option value="">Selecciona un cliente</option>
                  {clientes.map((c) => (
                    <option key={c.idCliente} value={c.idCliente}>
                      {c.nombre} {c.apellido} · DNI {c.dni}
                    </option>
                  ))}
                </select>
              </div>

              <div className="campo-grupo">
                <label className="campo-label">Cancha</label>
                <select
                  className="campo-input"
                  value={formReserva.idCancha}
                  onChange={(e) => setFormReserva((prev) => ({ ...prev, idCancha: e.target.value }))}
                >
                  <option value="">Selecciona una cancha</option>
                  {canchas.map((c) => (
                    <option key={c.idCancha} value={c.idCancha}>
                      Cancha {c.numeroCancha}
                    </option>
                  ))}
                </select>
              </div>

              <div className="campo-grupo">
                <label className="campo-label">Horario</label>
                <select
                  className="campo-input"
                  value={formReserva.idHorario}
                  onChange={(e) => setFormReserva((prev) => ({ ...prev, idHorario: e.target.value }))}
                >
                  <option value="">Selecciona un horario</option>
                  {horarios.map((h) => (
                    <option key={h.idHorario} value={h.idHorario}>
                      {h.hora?.slice(0, 5)} · S/ {Number(h.precio)}
                    </option>
                  ))}
                </select>
              </div>

              <div className="campo-grupo">
                <label className="campo-label">Fecha</label>
                <input
                  type="date"
                  className="campo-input"
                  value={formReserva.fecha}
                  onChange={(e) => setFormReserva((prev) => ({ ...prev, fecha: e.target.value }))}
                />
              </div>

              {errorReserva && <span className="campo-ayuda-error">{errorReserva}</span>}

              <div className="admin-modal-acciones">
                <button type="button" className="btn-admin-secundario" onClick={cerrarModalReserva}>
                  Cancelar
                </button>
                <button type="submit" className="admin-btn-primario" disabled={guardandoReserva}>
                  {guardandoReserva ? 'Guardando…' : 'Guardar'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* MODAL NUEVA / EDITAR CANCHA */}
      {modalCanchaAbierto && (
        <div
          className={`admin-modal-overlay ${cerrandoModalCancha ? 'salida' : ''}`}
          onClick={cerrarModalCancha}
        >
          <div
            className={`admin-modal-contenido ${cerrandoModalCancha ? 'salida' : ''}`}
            onClick={(e) => e.stopPropagation()}
          >
            <button className="modal-cerrar" type="button" onClick={cerrarModalCancha} aria-label="Cerrar modal">
              ✕
            </button>

            <h2>{canchaEditando ? 'Editar cancha' : 'Nueva cancha'}</h2>

            <form onSubmit={guardarCancha} className="admin-form">
              <div className="campo-grupo">
                <label className="campo-label">Número de cancha</label>
                <input
                  type="number"
                  min="1"
                  className="campo-input"
                  value={formCancha.numeroCancha}
                  onChange={(e) => setFormCancha({ numeroCancha: e.target.value })}
                />
              </div>

              {errorCancha && <span className="campo-ayuda-error">{errorCancha}</span>}

              <div className="admin-modal-acciones">
                <button type="button" className="btn-admin-secundario" onClick={cerrarModalCancha}>
                  Cancelar
                </button>
                <button type="submit" className="admin-btn-primario" disabled={guardandoCancha}>
                  {guardandoCancha ? 'Guardando…' : 'Guardar'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* MODAL NUEVO / EDITAR CLIENTE */}
      {modalClienteAbierto && (
        <div
          className={`admin-modal-overlay ${cerrandoModalCliente ? 'salida' : ''}`}
          onClick={cerrarModalCliente}
        >
          <div
            className={`admin-modal-contenido ${cerrandoModalCliente ? 'salida' : ''}`}
            onClick={(e) => e.stopPropagation()}
          >
            <button className="modal-cerrar" type="button" onClick={cerrarModalCliente} aria-label="Cerrar modal">
              ✕
            </button>

            <h2>{clienteEditando ? 'Editar cliente' : 'Nuevo cliente'}</h2>

            <form onSubmit={guardarCliente} className="admin-form">
              <div className="campo-grupo">
                <label className="campo-label">Nombre</label>
                <input
                  type="text"
                  className="campo-input"
                  value={formCliente.nombre}
                  onChange={(e) => setFormCliente((prev) => ({ ...prev, nombre: e.target.value }))}
                />
              </div>

              <div className="campo-grupo">
                <label className="campo-label">Apellido</label>
                <input
                  type="text"
                  className="campo-input"
                  value={formCliente.apellido}
                  onChange={(e) => setFormCliente((prev) => ({ ...prev, apellido: e.target.value }))}
                />
              </div>

              <div className="campo-grupo">
                <label className="campo-label">DNI</label>
                <input
                  type="text"
                  inputMode="numeric"
                  maxLength={8}
                  className="campo-input"
                  value={formCliente.dni}
                  onChange={(e) => setFormCliente((prev) => ({ ...prev, dni: e.target.value.replace(/\D/g, '') }))}
                />
              </div>

              <div className="campo-grupo">
                <label className="campo-label">Teléfono</label>
                <input
                  type="text"
                  inputMode="numeric"
                  maxLength={9}
                  className="campo-input"
                  value={formCliente.telefono}
                  onChange={(e) => setFormCliente((prev) => ({ ...prev, telefono: e.target.value.replace(/\D/g, '') }))}
                />
              </div>

              {errorCliente && <span className="campo-ayuda-error">{errorCliente}</span>}

              <div className="admin-modal-acciones">
                <button type="button" className="btn-admin-secundario" onClick={cerrarModalCliente}>
                  Cancelar
                </button>
                <button type="submit" className="admin-btn-primario" disabled={guardandoCliente}>
                  {guardandoCliente ? 'Guardando…' : 'Guardar'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* MODAL NUEVO / EDITAR HORARIO */}
      {modalHorarioAbierto && (
        <div
          className={`admin-modal-overlay ${cerrandoModalHorario ? 'salida' : ''}`}
          onClick={cerrarModalHorario}
        >
          <div
            className={`admin-modal-contenido ${cerrandoModalHorario ? 'salida' : ''}`}
            onClick={(e) => e.stopPropagation()}
          >
            <button className="modal-cerrar" type="button" onClick={cerrarModalHorario} aria-label="Cerrar modal">
              ✕
            </button>

            <h2>{horarioEditando ? 'Editar horario' : 'Nuevo horario'}</h2>

            <form onSubmit={guardarHorario} className="admin-form">
              <div className="campo-grupo">
                <label className="campo-label">Hora</label>
                <input
                  type="time"
                  className="campo-input"
                  value={formHorario.hora}
                  onChange={(e) => setFormHorario((prev) => ({ ...prev, hora: e.target.value }))}
                />
              </div>

              <div className="campo-grupo">
                <label className="campo-label">Precio por hora (S/)</label>
                <input
                  type="number"
                  min="0"
                  step="0.5"
                  className="campo-input"
                  value={formHorario.precio}
                  onChange={(e) => setFormHorario((prev) => ({ ...prev, precio: e.target.value }))}
                />
              </div>

              {errorHorarioForm && <span className="campo-ayuda-error">{errorHorarioForm}</span>}

              <div className="admin-modal-acciones">
                <button type="button" className="btn-admin-secundario" onClick={cerrarModalHorario}>
                  Cancelar
                </button>
                <button type="submit" className="admin-btn-primario" disabled={guardandoHorario}>
                  {guardandoHorario ? 'Guardando…' : 'Guardar'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* MODAL NUEVO / EDITAR PAGO */}
      {modalPagoAbierto && (
        <div
          className={`admin-modal-overlay ${cerrandoModalPago ? 'salida' : ''}`}
          onClick={cerrarModalPago}
        >
          <div
            className={`admin-modal-contenido ${cerrandoModalPago ? 'salida' : ''}`}
            onClick={(e) => e.stopPropagation()}
          >
            <button className="modal-cerrar" type="button" onClick={cerrarModalPago} aria-label="Cerrar modal">
              ✕
            </button>

            <h2>{pagoEditando ? 'Editar pago' : 'Nuevo pago'}</h2>

            <form onSubmit={guardarPago} className="admin-form">
              <div className="campo-grupo">
                <label className="campo-label">Reserva</label>
                <select
                  className="campo-input"
                  value={formPago.idReserva}
                  onChange={(e) => setFormPago((prev) => ({ ...prev, idReserva: e.target.value }))}
                >
                  <option value="">Selecciona una reserva</option>
                  {(pagoEditando ? reservas : reservasSinPago).map((r) => (
                    <option key={r.idReserva} value={r.idReserva}>
                      #{r.idReserva} · {r.cliente?.nombre} {r.cliente?.apellido} · Cancha {r.cancha?.numeroCancha} · {r.fecha}
                    </option>
                  ))}
                </select>
              </div>

              <div className="campo-grupo">
                <label className="campo-label">Total (S/)</label>
                <input
                  type="number"
                  min="0"
                  step="0.5"
                  className="campo-input"
                  value={formPago.total}
                  onChange={(e) => setFormPago((prev) => ({ ...prev, total: e.target.value }))}
                />
              </div>

              {errorPagoForm && <span className="campo-ayuda-error">{errorPagoForm}</span>}

              <div className="admin-modal-acciones">
                <button type="button" className="btn-admin-secundario" onClick={cerrarModalPago}>
                  Cancelar
                </button>
                <button type="submit" className="admin-btn-primario" disabled={guardandoPago}>
                  {guardandoPago ? 'Guardando…' : 'Guardar'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}

export default AdminPage;
