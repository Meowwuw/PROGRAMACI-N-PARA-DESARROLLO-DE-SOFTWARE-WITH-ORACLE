import { useEffect, useState } from "react";

function App() {
  const [productos, setProductos] = useState([]);

  useEffect(() => {
    fetch("http://localhost:8080/api/canchas")
      .then((response) => response.json())
      .then((data) => setProductos(data))
      .catch((error) => console.error("Error:", error));
  }, []);

  return (
    <div>
      <h1>MichiStore</h1>
      <h2>Productos</h2>

      {productos.map((canchas) => (
        <div key={canchas.id}>
          <h3>{canchas.nombre}</h3>
          <p>Tipo de Deportes: {canchas.tipoDeporte}</p>
          <p>Precio por hora: S/ {canchas.precioPorHora}</p>
          <p>Estado: {canchas.estado}</p>
          <hr />
        </div>
      ))}
    </div>
  );
}

export default App;