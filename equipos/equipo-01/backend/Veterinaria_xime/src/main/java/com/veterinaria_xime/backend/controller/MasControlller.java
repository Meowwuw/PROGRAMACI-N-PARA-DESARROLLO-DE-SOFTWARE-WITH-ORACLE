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
@RequestMapping("/api/mascota")

public class MasControlller {
    private final MascotaService mascotaService;

    public MasControlller(MascotaService mascotaService){
        this.mascotaService=mascotaService;
    }

    @GetMapping
    public List<Mascota> listar(){
        return mascotaService.listar();
    }

}