import { useEffect, useState } from "react";
import ProductoCard from "../components/ProductoCard.jsx";
import { obtenerProductos } from "../services/ProductoService.jsx";

function ProductPage() {
    const [productos, setProductos] = useState([]);

    useEffect(() => {
        fetch(obtenerProductos)
            .then((data) => setProductos(data))
            .catch((error) => console.error("Error:", error));
    }, []);

    return (
        <div>
            <h1>MichiStore</h1>
            <h2>Productos</h2>

            {productos.map((producto) => (
                <ProductoCard
                    key={producto.id}
                    producto={producto} />
            ))}
        </div>
    );
}

export default ProductPage;