package com.veterinaria_xime.backend.service;

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
}
