package com.canchavoley.backend.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class saludoController {

    @GetMapping("/saludo")
    public String saludo(){ return "Hola desde Michi Store 🚀";}

    @GetMapping("/saludo/{nombre}")
    public String saludoPersonalizado(@PathVariable String nombre ){
        return "Hola " + nombre + " 🌻";
    }

    //Creen el endpoint de despedida
    //Creen el enpoint de curso/{nombrecurso}
    //Creen el enpoint de categorias que devuelva 3 categorias

    @GetMapping("/despedida")
    public String despedida(){ return "Adios desde Michi Store 🚀";}

    @GetMapping("/curso/{nombre}")
    public String cursoNombre(@PathVariable String nombre ){
        return "Curso: " + nombre;
    }

    @GetMapping("/categorias")
    public List<String> categorias(){
        return List.of(
                "Pantalla",
                "Accesorio",
                "Teclado"
        );
    }


}