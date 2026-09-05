package com.vet.backend.service;

import com.vet.backend.model.Producto;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductoServices {
    public List<Producto> listar(){
        return List.of(
                new Producto(1L, "Laptop Michina", 2500.00, "Laptop"),
                new Producto(2L, "Mouse Michi Gamer", 75.50, "Periferico"),
                new Producto(3L, "Teclado Cat", 120.00, "periferico")
        );
    }
}