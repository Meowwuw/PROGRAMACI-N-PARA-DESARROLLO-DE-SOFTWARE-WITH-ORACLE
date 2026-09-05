package com.canchavoley.backend.controller;
import com.canchavoley.backend.model.Producto;

import com.canchavoley.backend.service.ProductoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/productos")
public class productoController {
    private final ProductoService productoService;

    public productoController(ProductoService productoService){
        this.productoService=productoService;
    }

    @GetMapping
    public List<Producto> listar(){
        return productoService.listar();
    }

    @GetMapping("/destacado")
    public Producto destacado() {
        return new Producto(
                2L,
                "MonitorBig",
                750.00,
                "Pantalla"
        );
    }

    @GetMapping("{id}")
    public  Producto buscarPorId(@PathVariable Long id){
        return new Producto(
                id,
                "prueba",
                10.00,
                "prueba 2"
        );
    }
}
