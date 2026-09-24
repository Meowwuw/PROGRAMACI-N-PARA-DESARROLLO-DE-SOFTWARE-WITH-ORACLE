import { useEffect, useState } from "react";

function App() {
  const [canchas, setCanchas] = useState([]);

  useEffect(() => {
    fetch("http://localhost:8080/api/cancha")
      .then((response) => response.json())
      .then((data) => setCanchas(data))
      .catch((error) => console.error("Error:", error));
  }, []);

  return (
    <div>
      <h1>VoleyPlay</h1>
      <h2>Canchas</h2>

      {canchas.map((cancha) => (
        <div key={cancha.id}>
          <h3>ID {cancha.nombre}</h3>
          <p>Número: {cancha.numero}</p>
          <p>Superficie: {cancha.tipoSuperficie}</p>
          <p>Estado: {cancha.estado}</p>
          <hr />
        </div>
      ))}
    </div>
  );
}

export default App;