package com.vet.backend.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class SaludoController {

    @GetMapping("/saludo")
    public String saludo() {
        return "Hola desde la veterinaria";
    }

    @GetMapping("/saludo/{nombre}")
    public String saludoPersonalizado(@PathVariable String nombre) {
        return "Hola " + nombre + " le gusta el yupi";
    }

    @GetMapping("/despedida")
    public String despedida() {
        return "Adiós! Espero volver pronto.";
    }

    @GetMapping("/curso/{nombreCurso}")
    public String curso(@PathVariable String nombreCurso) {
        return "Estás en el curso: " + nombreCurso;
    }
}