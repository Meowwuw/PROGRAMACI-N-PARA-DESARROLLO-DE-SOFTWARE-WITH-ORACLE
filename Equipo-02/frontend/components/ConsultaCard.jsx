function ConsultaCard({consulta}){
    return(
        <div>
            <h3>{consulta.fechacon}</h3>
            <p>Apoderado: {consulta.apoderado}</p>
            <p>Veterinario: {consulta.veterinario}</p>
            <p>Mascota: {consulta.mascota}</p>
        </div>
    )
}
export default ConsultaCard;