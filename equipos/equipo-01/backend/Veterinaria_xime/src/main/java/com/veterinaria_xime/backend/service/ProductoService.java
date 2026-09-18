package com.veterinaria_xime.backend.service;

import com.veterinaria_xime.backend.model.Mascota;
import com.veterinaria_xime.backend.model.Producto;
import com.veterinaria_xime.backend.repository.ProductoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductoService {
    private final ProductoRepository productoRepository;

    public ProductoService(ProductoRepository productoRepository){
        this.productoRepository = productoRepository;
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

}
