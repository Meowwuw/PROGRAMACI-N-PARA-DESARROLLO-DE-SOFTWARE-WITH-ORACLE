package com.proyectoweb.backed.controller;

import com.proyectoweb.backed.model.Producto;
import com.proyectoweb.backed.service.ProductoService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@RestController
@RequestMapping("/api/productos")
public class ProductoController {

    private final ProductoService productoService;

    public ProductoController(ProductoService productoService){
        this.productoService=productoService;
    }
    @GetMapping
    public List <Producto> Listar(){
        return productoService.listar() ;
    }
    @GetMapping("/producto")
    public Producto producto(){
        return new Producto( 2L , "Mouse", 25.50, "Accesorio");
    }

    @GetMapping("/destacado")
    public Producto destacado() {
        return new Producto(2L, "MonitorBig", 750.00,"Accesorio" );
    }



    @GetMapping("/{id}")
    public Producto buscarPorId(@PathVariable Long id) {
        return new Producto(2L, "Producto prueba", 99.90,"Accesorio");
    }

}

