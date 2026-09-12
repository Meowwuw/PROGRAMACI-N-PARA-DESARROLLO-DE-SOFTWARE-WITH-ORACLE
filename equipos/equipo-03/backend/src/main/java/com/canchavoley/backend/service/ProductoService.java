package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Producto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductoService {

    public List<Producto> listar(){
        return List.of(
                new Producto(1l,"Laptop Michina", 2500.00, "Equipo"),
                new Producto(2l,"Mouse michi Gamer", 75.50, "Accesorio"),
                new Producto(3l,"Teclado Cat", 120.00, "Accesorio")
        );
    }
}
