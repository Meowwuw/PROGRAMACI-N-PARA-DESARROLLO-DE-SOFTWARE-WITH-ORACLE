import ProductoCard from "../components/ProductoCard.jsx";
import { obtenerProductos } from "../services/productoService.jsx";
import { useState, useEffect } from "react";

function ProductosPage() {
    const [productos, setProductos] = useState([]);

    useEffect(() => {
        obtenerProductos()
            .then((data) => setProductos(data))
            .catch((error) => console.error("Error:", error));
    }, []);

    return (
        <div>
            <h1>MichiStore</h1>
            <h2>Productos</h2>
            <div className="productos">
                {productos.map((producto) => (
                    <ProductoCard
                        key={producto.id}
                        producto={producto} />
                ))}
            </div>
        </div>
    );
}

export default ProductosPage;