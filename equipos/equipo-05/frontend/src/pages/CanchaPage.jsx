import CanchaCard from "../components/CanchaCard.jsx";
import { obtenerCanchas } from "../service/CanchaService.jsx";
import { useEffect, useState } from "react";

function CanchaPage() {
  const [canchas, setCanchas] = useState([]);

  useEffect(() => {
    obtenerCanchas()
      .then((data) => setCanchas(data))
      .catch((error) => console.error("Error:", error));
  }, []);

  return (
    <div>
      <h1>VoleyPlay</h1>
      <h2>Canchas</h2>
      <div className="cancha">
        {canchas.map((cancha) => (
          <CanchaCard key={cancha.id} 
          cancha={cancha} />
        ))}
      </div>
    </div>
  );
}

export default CanchaPage;