package com.example.backend.controller;

import com.example.backend.model.Producto;
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
        return "Hola mi amor desde mi corazon <3";}

    @GetMapping("/saludo/{nombre}")
    public String saludoPersonalizado(@PathVariable String nombre ){
        return "Hola "+ nombre + " <3";
    }


    @GetMapping("/productos")
    public List<String> productos(){
        return List.of(
                "Laptop Michina",
                "Santiago Bernabeu",
                "Teclado RGB Cat"
        );
    }
    @GetMapping("/producto")
    public Producto producto(){
        return new Producto(
                1L,
                "Santiago Bernabeu",
                75.50
        );

    }
    @GetMapping("/despedida")
    public String despedida() {
        return "Adiós, cuídate mucho <3";
    }

    @GetMapping("/curso/{Matematicas}")
    public String cursoPersonalizado(@PathVariable String nombrecurso) {
        return "Estás cursando la materia de: " + nombrecurso + " <3";
    }

    @GetMapping("/categorias")
    public List<String> categorias() {
        return List.of(
                "Tecnología y Gadgets",
                "Hogar y Estilo de Vida",
                "Ropa y Accesorios"
        );
    }
}
//Creen el endpoint de despedida
//Creen el enpoint de curso/{nombrecurso}
//Creen el enpoint de categorías que devuelva 3 categorías