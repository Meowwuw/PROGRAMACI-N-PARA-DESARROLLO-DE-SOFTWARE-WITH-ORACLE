package com.VoleyPlay.backend.controller;


import com.VoleyPlay.backend.model.Producto;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class SaludoController {

    @GetMapping("/saludo")
    public String saludo(){
        return "Hola desde la Cancha";}

    @GetMapping("/saludo/{nombre}")
    public String saludoPersonalizado(@PathVariable String nombre){
        return "Hola "+ nombre + " ";
    }

    @GetMapping("/Producto")
    public Producto producto(){
        return  new  Producto(
                1L,
                "Michi-Mouse",
                75.50,
                "computo"
        );
    }
    //Crear el endpoint de despedida
    @GetMapping("/despedida")
    public String despedida() {
        return "¡Hasta luego!";
    }
    //Creen el enpoint de curso/{nombrecurso}
    @GetMapping("/curso/{nombrecurso}")
    public String curso(@PathVariable String nombrecurso) {
        return "Estas inscrito en el curso: " + nombrecurso;
    }
    //Creen el enpoint de categorias que devuelve 3 categorias
    @GetMapping("/categorias")
    public List<String> categorias() {
        return List.of(
                "Tecnología",
                "Ropa",
                "Hogar"
        );
    }
    @GetMapping("/destacado")
    public Producto destacado(){
        return new Producto(
                2L,
                "MonitorBig",
                750.00,
                "Monitor");

    }
}
