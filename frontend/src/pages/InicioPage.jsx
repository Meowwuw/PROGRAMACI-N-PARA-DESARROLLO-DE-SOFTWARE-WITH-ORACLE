import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import './InicioPage.css';

const getImageUrl = (name) => {
  return new URL(`../assets/${name}`, import.meta.url).href;
};

export default function InicioPage() {
  const [menuAbierto, setMenuAbierto] = useState(false);
  const [conSombra, setConSombra] = useState(false);
  const [seccionActiva, setSeccionActiva] = useState('inicio');

  useEffect(() => {
    const alScroll = () => {
      setConSombra(window.scrollY > 8);

      // Si estamos cerca de la parte superior, aseguramos que "inicio" esté activo
      if (window.scrollY < 150) {
        setSeccionActiva('inicio');
      }
    };

    window.addEventListener('scroll', alScroll, { passive: true });
    alScroll();

    const secciones = ['canchas', 'horarios', 'contacto']
      .map((id) => document.getElementById(id))
      .filter(Boolean);

    if ('IntersectionObserver' in window) {
      const observer = new IntersectionObserver(
        (entradas) => {
          entradas.forEach((entrada) => {
            // Solo cambia si el scroll está más abajo del Hero
            if (entrada.isIntersecting && window.scrollY >= 150) {
              setSeccionActiva(entrada.target.id);
            }
          });
        },
        { rootMargin: '-20% 0px -50% 0px' }
      );

      secciones.forEach((s) => observer.observe(s));

      return () => {
        window.removeEventListener('scroll', alScroll);
        secciones.forEach((s) => observer.unobserve(s));
      };
    }

    return () => window.removeEventListener('scroll', alScroll);
  }, []);

  useEffect(() => {
    const alTecla = (e) => {
      if (e.key === 'Escape') setMenuAbierto(false);
    };
    const alResize = () => {
      if (window.innerWidth >= 900) setMenuAbierto(false);
    };

    window.addEventListener('keydown', alTecla);
    window.addEventListener('resize', alResize);

    return () => {
      window.removeEventListener('keydown', alTecla);
      window.removeEventListener('resize', alResize);
    };
  }, []);

  const irASeccion = (e, id) => {
    e.preventDefault();
    setMenuAbierto(false);

    if (id === 'inicio') {
      setSeccionActiva('inicio');
      window.scrollTo({ top: 0, behavior: 'smooth' });
      return;
    }

    const elem = document.getElementById(id);
    if (elem) {
      const headerH = document.getElementById('header')?.offsetHeight || 70;
      const elemPosition = elem.getBoundingClientRect().top + window.pageYOffset;
      const offsetPosition = elemPosition - headerH;

      window.scrollTo({
        top: offsetPosition,
        behavior: 'smooth'
      });
    }
  };

  // Cambiado de 'hero-voley.jpg' a 'Cancha 1.png' (o cámbialo por el nombre real de tu archivo)
  const canchas = [
    { id: 1, nombre: 'Cancha 1', precio: 'Desde S/ 20 por hora', img: getImageUrl('Cancha 1.png') },
    { id: 2, nombre: 'Cancha 2', precio: 'Desde S/ 20 por hora', img: getImageUrl('Cancha 2.png') },
    { id: 3, nombre: 'Cancha 3', precio: 'Desde S/ 20 por hora', img: getImageUrl('Cancha 3.png') },
    { id: 4, nombre: 'Cancha 4', precio: 'Desde S/ 20 por hora', img: getImageUrl('Cancha 4.png') },
    { id: 5, nombre: 'Cancha 5', precio: 'Desde S/ 20 por hora', img: getImageUrl('Cancha 5.png') },
  ];

  const horarios = [
    { hora: '08:00', precio: 'S/ 20' },
    { hora: '09:00', precio: 'S/ 20' },
    { hora: '10:00', precio: 'S/ 25' },
    { hora: '11:00', precio: 'S/ 25' },
    { hora: '12:00', precio: 'S/ 30' },
    { hora: '13:00', precio: 'S/ 30' },
    { hora: '14:00', precio: 'S/ 35' },
    { hora: '15:00', precio: 'S/ 35' },
    { hora: '16:00', precio: 'S/ 40' },
    { hora: '17:00', precio: 'S/ 40' },
    { hora: '18:00', precio: 'S/ 50' },
  ];

  return (
    <div className="inicio-container">
      {/* HEADER / NAVBAR */}
      <header className={`header ${conSombra ? 'con-sombra' : ''}`} id="header">
        <div className="container header-in">
          <a href="#inicio" className="marca" onClick={(e) => irASeccion(e, 'inicio')} aria-label="CanchaVóley, ir al inicio">
            <span className="logo">V</span>
            <span className="marca-nombre">CanchaVóley</span>
          </a>

          <nav className={`menu ${menuAbierto ? 'abierto' : ''}`} id="menu" aria-label="Principal">
            <a
              className={`enlace ${seccionActiva === 'inicio' ? 'activo' : ''}`}
              href="#inicio"
              onClick={(e) => irASeccion(e, 'inicio')}
            >
              Inicio
            </a>
            <a
              className={`enlace ${seccionActiva === 'canchas' ? 'activo' : ''}`}
              href="#canchas"
              onClick={(e) => irASeccion(e, 'canchas')}
            >
              Canchas
            </a>
            <a
              className={`enlace ${seccionActiva === 'horarios' ? 'activo' : ''}`}
              href="#horarios"
              onClick={(e) => irASeccion(e, 'horarios')}
            >
              Horarios
            </a>
            <a
              className={`enlace ${seccionActiva === 'contacto' ? 'activo' : ''}`}
              href="#contacto"
              onClick={(e) => irASeccion(e, 'contacto')}
            >
              Contacto
            </a>

            <Link className="btn btn-primario menu-cta" to="/reservar" onClick={() => setMenuAbierto(false)}>
              Reservar
            </Link>
          </nav>

          <Link className="btn btn-primario header-cta" to="/reservar">
            Reservar
          </Link>

          <button
            className={`hamburguesa ${menuAbierto ? 'abierta' : ''}`}
            type="button"
            aria-label={menuAbierto ? 'Cerrar menú' : 'Abrir menú'}
            aria-expanded={menuAbierto}
            onClick={() => setMenuAbierto(!menuAbierto)}
          >
            <span></span>
            <span></span>
            <span></span>
          </button>
        </div>
      </header>

      <main>
        {/* HERO SECTION */}
        <section className="hero" id="inicio">
          <div className="container hero-in">
            <div className="hero-texto">
              <span className="etiqueta">Reserva en línea</span>
              <h1>Reserva tu cancha de vóley en minutos</h1>
              <p className="hero-sub">
                Elige la fecha, la cancha y tu horario. Confirma tu reserva sin llamadas ni esperas.
              </p>

              <div className="hero-botones">
                <Link className="btn btn-primario" to="/reservar">
                  Reservar ahora
                </Link>
                <a className="btn btn-secundario" href="#canchas" onClick={(e) => irASeccion(e, 'canchas')}>
                  Ver canchas
                </a>
              </div>

              <div className="datos">
                <div className="dato">
                  <b>5</b>
                  <span>canchas</span>
                </div>
                <div className="dato">
                  <b>08:00 – 18:00</b>
                  <span>horarios disponibles</span>
                </div>
                <div className="dato">
                  <b>Desde S/ 20</b>
                  <span>por hora</span>
                </div>
              </div>
            </div>

            <div className="hero-foto">
              <img src={getImageUrl('hero-voley.jpg')} alt="Cancha principal de vóley" width="954" height="616" />
            </div>
          </div>
        </section>

        {/* CANCHAS SECTION */}
        <section className="canchas" id="canchas">
          <div className="container">
            <div className="seccion-titulo">
              <h2>Nuestras canchas</h2>
              <p>Desliza para ver todas y elige la tuya.</p>
            </div>

            <div className="carrusel" tabIndex="0" aria-label="Lista de canchas">
              {canchas.map((cancha) => (
                <article className="cancha" key={cancha.id}>
                  <div className="cancha-foto">
                    <img src={cancha.img} alt={cancha.nombre} loading="lazy" />
                  </div>
                  <div className="cancha-detalle">
                    <h3>{cancha.nombre}</h3>
                    <p>{cancha.precio}</p>
                    <Link className="btn btn-secundario" to={`/reservar?cancha=${cancha.id}`}>
                      Reservar
                    </Link>
                  </div>
                </article>
              ))}
            </div>
          </div>
        </section>

        {/* HORARIOS Y PRECIOS SECTION */}
        <section className="horarios" id="horarios">
          <div className="container">
            <div className="seccion-titulo">
              <h2>Horarios y precios</h2>
              <p>Precio por hora según el horario que elijas.</p>
            </div>

            <ul className="chips">
              {horarios.map((item, idx) => (
                <li className="chip" key={idx}>
                  <b>{item.hora}</b>
                  <span>{item.precio}</span>
                </li>
              ))}
            </ul>
          </div>
        </section>
      </main>

      {/* FOOTER / CONTACTO SECTION */}
      <footer className="footer" id="contacto">
        <div className="container footer-in">
          <strong>CanchaVóley</strong>
          <small>© CanchaVóley · Reserva de canchas de vóley</small>
        </div>
      </footer>
    </div>
  );
}