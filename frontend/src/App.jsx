import { useEffect, useState } from "react";

function App() {
  const [productos, setProductos] = useState([]);

  useEffect(() => {
    fetch("http://localhost:8080/api/productos")
      .then((response) => response.json())
      .then((data) => setProductos(data))
      .catch((error) => console.error("Error:", error));
  }, []);

  return (
    <div>
      <h1>MichiStore</h1>
      <h2>Productos</h2>

      {productos.map((producto) => (
        <div key={producto.id}>
          <h3>{producto.nombre}</h3>
          <p>Categoría: {producto.categoria}</p>
          <p>Precio: S/ {producto.precio}</p>
          <p>Stock: {producto.stock}</p>
          <hr />
        </div>
      ))}
    </div>
  );
}

export default App;