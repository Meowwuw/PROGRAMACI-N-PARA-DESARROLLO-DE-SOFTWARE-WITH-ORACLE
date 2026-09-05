package com.vet.backend.controller;

import com.vet.backend.model.Mascota;
import com.vet.backend.service.MascotaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/mascotas")
public class MascotaController {
    private final MascotaService mascotaService;

    public MascotaController(MascotaService mascotaService){
        this.mascotaService = mascotaService;
    }

    @GetMapping
    public List<Mascota> listar(){
        return mascotaService.listar();
    }

    @GetMapping("{id}")
    public Mascota buscarPorId(@PathVariable Long id){
        return new Mascota(
                id,
                "Mascota Prueba",
                "Perro",
                "Mestizo",
                3
        );
    }
}