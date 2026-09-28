function ProductoCard({producto}){
    return(
        <div>
          <h3>{producto.nombre}</h3>
          <p>Categoría: {producto.categoria}</p>
          <p>Precio: S/ {producto.precio}</p>
          <p>Stock: {producto.stock}</p>
          <hr />
        </div>
    );
}
export default ProductoCard;