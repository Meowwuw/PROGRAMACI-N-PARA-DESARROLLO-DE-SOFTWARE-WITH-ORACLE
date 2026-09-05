package com.veterinaria_xime.backend.controller;


import com.veterinaria_xime.backend.model.Mascota;
import com.veterinaria_xime.backend.service.MascotaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

//ProductoController

@RestController
@RequestMapping("/api/mascotas")

public class MasControlller {
    private final MascotaService mascotaService;

    public MasControlller(MascotaService mascotaService){
        this.mascotaService=mascotaService;
    }

    //Cada clas tiene una responsabilidad
    @GetMapping
    public List <Mascota> listar(){
        return mascotaService.listar();
    }


    //Migrar los endpoints de productos



    // Endpoint de ejemplo de una mascota
    @GetMapping("/masco")
    public Mascota mascota() {
        return new Mascota(
                1L,
                12.5,
                "Genesis",
                "Perro"
        );
    }

    // Endpoint de la mascota destacada
    @GetMapping("/destacado")
    public Mascota destacado() {
        return new Mascota(
                2L,
                4.5,
                "Michi Big",
                "Gato"
        );
    }

    // Buscar mascota por ID
    @GetMapping("/{id}")
    public Mascota buscarPorId(@PathVariable Long id) {
        return new Mascota(
                id,
                8.0,
                "Mascota de Prueba",
                "Canino"
        );
    }
}