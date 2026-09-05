package com.proyectoweb.backed.service;

import com.proyectoweb.backed.model.Producto;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

public class ProductoService {

    @GetMapping
    public List<Producto> listar() {
        return List.of(
                new Producto(1L, "Laptop Michina", 2500.00,"categoria Laptop"),
                new Producto(2L, "Mouse Michi Gamer", 75.50,"categoria Mouse"),
                new Producto(3L, "Teclado Cat", 120.00,"categoria teclado")
        );
    }
}
