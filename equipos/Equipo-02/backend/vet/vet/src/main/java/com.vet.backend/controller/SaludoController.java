package com.vet.backend.controller;

import com.vet.backend.categoria.categorias;
import com.vet.backend.model.Producto;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api")
public class SaludoController {
    @GetMapping("/saludo")
    public String saludo(){ return "Hola desde la veterinaria";}

    @GetMapping("/saludo/{nombre}")
    public String saludopersonalizado(@PathVariable String nombre){
        return "Hola " + nombre + " le gusta el yupi";
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
        return new Producto(
                1L,
                "Michi Mouse",
                75.50,
                "Periferico"
        );
    }

    @GetMapping("/despedida")
    public String despedida() {
        return "Adiós! Espero volver pronto.";
    }

    @GetMapping("/curso/{nombreCurso}")
    public String curso(@PathVariable String nombreCurso) {
        return "Estás en el curso: " + nombreCurso;
    }

    @GetMapping("/categoria")
    public List<categorias> getCategorias() {
        List<categorias> categorias = new ArrayList<>();
        categorias.add(new categorias(1L, "Electrónica"));
        categorias.add(new categorias(2L, "Accesorios"));
        categorias.add(new categorias(3L, "Juegos"));
        return categorias;
    }
}