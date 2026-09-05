package com.Vet.backend.controller;
import com.Vet.backend.model.Producto;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")

public class SaludoController {

    @GetMapping("/saludo")
    public String saludo(){return "hola, cara de ñema";}

    @GetMapping("/saludo/{nombre}")
    public String saludoPersonalizado(@PathVariable String nombre){
        return "hola JIJIJA " + nombre;}

    @GetMapping("/productos")
    public List <String> productos(){
        return List.of(
                "Laptop bien equisde",
                "Mouse Michi gamer",
                "teclado RGB Cat"
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

    //Creeb el endpoint de despedida
    @GetMapping("/despedida")
    public String despedida(){
        return "goodbye";
    }

    //creen el endpoint d curso/{nombreCurso}
    @GetMapping("/curso/{nombreCurso}")
    public String obtenerCurso(@PathVariable String nombreCurso){
        return  "estas inscrito en el curso: " + nombreCurso;
    }
    //Creen el endpoint de categoria que devuelva 3 categorias
    @GetMapping("/categorias")
    public List<String> obtenerCategorias(){
        return List.of(
                "Alimentos para mascotas",
                "Juguetes",
                "medicamentos veterinarios"
        );
    }
}
