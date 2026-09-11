package com.tecnomichistore.backend.controller;

import com.tecnomichistore.backend.model.Producto;
import com.tecnomichistore.backend.service.ProductoService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/productos")
public class ProductoController {
    private final ProductoService productoService;

    public ProductoController(ProductoService productoService) {
        this.productoService = productoService;
    }

    //cada clase tiene una responsabilidad
    @GetMapping
    public List<Producto> listar() {
        return productoService.listar();
    }

    //Migrar los endpoints de producto
    @GetMapping("/producto")
    public Producto producto() {
        return new Producto(
                1L,
                "Michi-Mouse",
                75.50, "perifericos"
        );
    }

    @GetMapping("/destacado")
    public Producto destacado() {
        return new Producto(
                2L,
                "MonitorBig",
                750.00,
                "perifericos");
    }

    @GetMapping("{id}")
    public Producto buscarPorId(@PathVariable Long id) {
        return new Producto(
                id,
                "Producto prueba",
                99.90,
                "Categoria de Prueba"
        );
    }
}
