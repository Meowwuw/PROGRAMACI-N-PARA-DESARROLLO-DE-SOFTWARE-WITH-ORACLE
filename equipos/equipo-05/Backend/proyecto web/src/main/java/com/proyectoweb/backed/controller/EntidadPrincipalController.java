package com.proyectoweb.backed.controller;

import com.proyectoweb.backed.model.Producto;
import com.proyectoweb.backed.service.ProductoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/entidad-principal")
public class EntidadPrincipalController {

    private final ProductoService productoService;

    // Inyección de dependencias por constructor
    public EntidadPrincipalController(ProductoService productoService) {
        this.productoService = productoService;
    }

    @GetMapping
    public List<Producto> obtenerTodos() {
        return productoService.obtenerTodos();
    }

    @GetMapping("/{id}")
    public Producto obtenerPorId(@PathVariable Long id) {
        return productoService.obtenerPorId(id);
    }
}