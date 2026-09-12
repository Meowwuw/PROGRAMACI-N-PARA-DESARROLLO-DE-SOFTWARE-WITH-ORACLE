package com.vet.backend.controller;


import categoria.categorias;
import model.Producto;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.management.monitor.Monitor;
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
                1l,
                "Michi Mouse",
                75.50

        );
    }

    //Creen el endpoint de despedida
    @GetMapping("/despedida")
    public String despedida() {
        return "Adiós! Espero volver pronto.";
    }

    //Creen el endpoint de curso/{nombrecurso}
    @GetMapping("/curso/{nombreCurso}")
    public String curso(@PathVariable String nombreCurso) {
        return "Estás en el curso: " + nombreCurso;
    }


    //Creen el endpoint de categoria que devuelva 3 categorias
    @GetMapping("/categoria")
    public List<categorias> getCategorias() {
        List<categorias> categorias = new ArrayList<>();
        categorias.add(new categorias(1L, "Electrónica"));
        categorias.add(new categorias(2L, "Accesorios"));
        categorias.add(new categorias(3L, "Juegos"));
        return categorias;
    }
    @GetMapping("/destacado")
    public Producto destadcado(){
      return new Producto(
                2L,
              "Monitos Big",
              750.00
      );
    }
}
