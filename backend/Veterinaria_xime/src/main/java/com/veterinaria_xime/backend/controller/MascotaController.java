package com.veterinaria_xime.backend.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

//SaludoController

@RestController
@RequestMapping("/api")
public class MascotaController {

    @GetMapping("/saludo")
    public String saludo(){
        return "¡Bienvenido a Veterinaria XimEdgar HUELLITA! Cuidamos a tus mejores amigos.";
    }

    @GetMapping("/saludo/{nombreMascota}")
    public String saludoPersonalizado(@PathVariable String nombreMascota){
        return "¡Hola " + nombreMascota + "! Que tengas una excelente consulta hoy.";
    }
    // Lista de productos de la tienda veterinaria
    @GetMapping("/productos")
    public List<String> productos(){
        return List.of(
                "Comida Premium Perro (10kg)",
                "Arena Sanitaria Gatuna",
                "Juguete Mordedor Hueso",
                "Shampoo Antipulgas"
        );
    }
    // 1. Endpoint de despedida
    @GetMapping("/despedida")
    public String despedida() {
        return "¡Gracias por confiar en Veterinaria XimEdgar HUELLITA! Que tu mascota tenga un gran día..";
    }

    // 2. Endpoint para ver el detalle del historial o consulta de una mascota por nombre
    @GetMapping("/historial/{nombreMascota}")
    public String obtenerHistorial(@PathVariable String nombreMascota) {
        return "Estás viendo el historial médico y vacunas de: " + nombreMascota;
    }

    // 3. Endpoint de categorías de servicios de la veterinaria
    @GetMapping("/categorias")
    public List<String> obtenerCategorias() {
        return List.of(
                "Consultas y Vacunación",
                "Cirugía y Especialidades",
                "Grooming y Estética Canina/Felina"
        );
    }


}
