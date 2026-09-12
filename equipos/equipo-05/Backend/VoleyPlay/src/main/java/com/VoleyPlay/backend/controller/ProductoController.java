package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Producto;
import com.VoleyPlay.backend.services.ProductoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/producto")

public class ProductoController {
<<<<<<< HEAD
    private final ProductoService productoService;


    public ProductoController(ProductoService productoService){
        this.productoService = productoService;
    }

    //cada clase tiene una responsabilidad
    @GetMapping
    public List <Producto> Listar(){
        return productoService.listar();
    }

    //migrar los endpoints de producto
    @GetMapping("/destacado")
    public Producto destacado(){
        return new Producto(
                2L,
                "MonitorBig",
                750.00,
                "Monitor");

    }

=======
  
>>>>>>> 57ab954a1c30c0eecf59a6cca9f7dfcba81c1123
}
