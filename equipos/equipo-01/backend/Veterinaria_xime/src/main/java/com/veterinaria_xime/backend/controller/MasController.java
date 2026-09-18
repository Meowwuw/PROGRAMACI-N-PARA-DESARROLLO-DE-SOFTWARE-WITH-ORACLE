package com.veterinaria_xime.backend.controller;


import com.veterinaria_xime.backend.model.Mascota;
import com.veterinaria_xime.backend.service.MascotaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//ProductoController

@RestController
@RequestMapping("/api/mascota")

public class MasController {
    private final MascotaService mascotaService;

    public MasController(MascotaService mascotaService){
        this.mascotaService=mascotaService;
    }

    @GetMapping
    public List<Mascota> listar(){
        return mascotaService.listar();
    }
    @GetMapping("/{id}")
    public Mascota buscarPorId(@PathVariable Long id){
        return mascotaService.buscarPorId(id);
    }

    @PostMapping
    public Mascota guardar(@RequestBody Mascota producto) {
        return mascotaService.guardar(producto);
    }




}