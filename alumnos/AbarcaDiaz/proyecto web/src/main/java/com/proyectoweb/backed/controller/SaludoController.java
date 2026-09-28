package com.proyectoweb.backed.controller;
import com.proyectoweb.backed.model.Producto;
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
        return "Hola "+ nombre + "🏌️";
    }

    @GetMapping("/productos")
    public List<String> productos(){
        return List.of(
                "Laptop Michina",
                "Mouse Michi Gamer",
                "Teclado RGB Cat"
        );
    }

    @GetMapping("/producto")
    public Producto producto(){
        return new Producto (
                1L,
                "Michi-Mause",
                75.50
        );
    }
    // 1. Endpoint de despedida
    @GetMapping("/despedida")
    public String despedida() {
        return "¡Hasta luego! Gracias por visitar Michi Store.";
    }

    // 2. Endpoint de curso/{nombrecurso}
    @GetMapping("/curso/{nombrecurso}")
    public String obtenerCurso(@PathVariable String nombrecurso) {
        return "Estás viendo el curso de: " + nombrecurso;
    }

    // 3. Endpoint de categorias que devuelvan 3 categorias
    @GetMapping("/categorias")
    public List<String> obtenerCategorias() {
        return List.of("Laptops", "Accesorios", "Audio");
    }