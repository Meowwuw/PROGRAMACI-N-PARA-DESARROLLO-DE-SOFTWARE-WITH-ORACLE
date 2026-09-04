package com.tecnomichistore.backend.controller;
import com.tecnomichistore.backend.model.Producto;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class SaludoController {

    @GetMapping("/saludo")
    public String saludo(){ return "Hola desde Michi Store 🚀";}

    @GetMapping("/saludo/{nombre}")
    public String saludoPersonalizado(@PathVariable String nombre ){
        return "Hola " + nombre + " 🌻";
    }

    @GetMapping("/productos")
    public List<String> productos(){
        return List.of(
                "Laptop Michina",
                "Mouse Michi Gamer",
                "Tecladp RGB Cat"
        );
    }

    @GetMapping("/producto")
    public Producto producto(){
        return new Producto(
                1L,
                "Michi-Mouse",
                75.50
        );
    }

    //Creen el endpoint de despedida
    //Creen el enpoint de curso/{nombrecurso}
    //Creen el enpoint de categorias que devuelva 3 categorias
}
