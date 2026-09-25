import ConsultaCard from "../components/ConsultaCard.jsx";
import { obtenerConsulta } from "../service/ConsultaService.jsx";
import { useState, useEffect } from "react";

function ConsultaPage() {

    const [consultas, setConsultas] = useState([]);

    useEffect(() => {
        obtenerConsulta()
            .then((data) => setConsultas(data))
            .catch((error) => console.error("Error:", error));
    }, []);

    return (
        <div>
            <h1>Vet</h1>
            <h2>Consultas</h2>

            <div className="consultas">
                {consultas.map((consulta) => (
                    <ConsultaCard
                        key={consulta.id}
                        consulta={consulta}
                    />
                ))}
            </div>
        </div>
    );
}

export default ConsultaPage;