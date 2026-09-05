package com.proyectoweb.backed.controller;

import com.proyectoweb.backed.model.Producto;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class SaludoController {

    @GetMapping("/saludo")
    public String saludo() {
        return "Hola desde la Cancha";
    }

    @GetMapping("/saludo/{nombre}")
    public String saludoPersonalizado(@PathVariable String nombre) {
        return "Hola " + nombre + " ";
    }

    @GetMapping("/productos")
    public List<String> productos() {
        return List.of(
                "Laptop Michina",
                "Mouse Michi Gamer",
                "Teclado RGB Cat"
        );
    }

    @GetMapping("/producto")
    public Producto producto() {
        return new Producto(1L, "Michi-Mause", 75.50, "Mouse");
    }

    @GetMapping("/destacado")
    public Producto destacado() {
        return new Producto(2L, "MonitorBig", 750.00,"Monitor");
    }

    @GetMapping("/listar")
    public List<Producto> listar() {
        return List.of(
                new Producto(1L, "Laptop Michica", 2500.00,"Laptop"),
                new Producto(2L, "Mouse Michi Game", 75.50,"Mouse"),
                new Producto(3L, "Teclado Cat", 120.00,"Teclado")
        );
    }
}