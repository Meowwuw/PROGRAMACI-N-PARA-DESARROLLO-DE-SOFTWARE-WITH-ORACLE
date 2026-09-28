package com.tecnomichistore.backend.service;

import com.tecnomichistore.backend.model.Producto;
import com.tecnomichistore.backend.repository.ProductoRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductoService {
    private final ProductoRepository productoRepository;

    public ProductoService(ProductoRepository productoRepository){
        this.productoRepository=productoRepository;
    }

    public List<Producto> listar(){
        return productoRepository.findAll();
    }

    public Producto buscarPorId(Long id) {
        return productoRepository.findById(id)
                .orElse(null);
    }

    public Producto guardar(Producto producto) {
        return productoRepository.save(producto);
    }

    public Producto actualizar(Long id,Producto datos){

        Producto producto = productoRepository.findById(id)
                .orElse(null);
        if(producto == null){
            return null;
        }
        producto.setNombre(datos.getNombre());
        producto.setCategoria(datos.getCategoria());
        producto.setPrecio(datos.getPrecio());
        producto.setStock(datos.getStock());

        return productoRepository.save(producto);
    }

    public void eliminar (Long id){
        productoRepository.deleteById(id);
    }

}
