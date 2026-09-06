package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Producto;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Service
public class ProductoService {
    @GetMapping
    public List <Producto> listar(){
        return List.of(
                new Producto(1L, "Laptop Michina", 2500.00, "computo"),
                new Producto(2L, "Mause Michi Gamer", 75.50, "Accesorio"),
                new Producto(3L, "Teclado Cat", 120.00, "Accesorio")
        );
    }
}
