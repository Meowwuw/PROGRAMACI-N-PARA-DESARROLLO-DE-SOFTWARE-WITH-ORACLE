function CanchaCard({ cancha }) {

    return (
        <div key={cancha.id}>
          <h3>ID {cancha.nombre}</h3>
          <p>Número: {cancha.numero}</p>
          <p>Superficie: {cancha.tipoSuperficie}</p>
          <p>Estado: {cancha.estado}</p>
          <hr />
        </div>
    );
}

export default CanchaCard;