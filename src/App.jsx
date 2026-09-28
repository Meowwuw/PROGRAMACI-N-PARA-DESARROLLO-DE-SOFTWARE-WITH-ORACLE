  import { useEffect, useState } from "react";

  function App() {
    const [clientes, setClientes] = useState([]);

    useEffect(() => {
      fetch("http://localhost:8080/api/clientes")
        .then((response) => response.json())
        .then((data) => setClientes(data))
        .catch((error) => console.error("Error:", error));
    }, []);

    return (
      <div>
        <h1>Alquiler de Cancha</h1>
        <h2>Clientes</h2>

        {clientes.map((cliente) => (
          <div key={cliente.id}>
            <h3>{cliente.nombre}</h3>
            <p>Teléfono: {cliente.telefono}</p>
            <p>DNI: {cliente.dni}</p>
            <p>Email: {cliente.email}</p>
            <p>Password: {cliente.password}</p>
            <hr />
          </div>
        ))}
      </div>
    );
  }

  export default App;