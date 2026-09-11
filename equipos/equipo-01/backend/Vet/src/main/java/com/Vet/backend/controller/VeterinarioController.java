package com.Vet.backend.controller;

import com.Vet.backend.model.Veterinario;
import com.Vet.backend.services.VeterinarioServices;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/veterinarios")
public class VeterinarioController {
    private final VeterinarioServices veterinarioServices;

    public VeterinarioController(VeterinarioServices veterinarioServices){
        this.veterinarioServices = veterinarioServices;
    }

    @GetMapping
    public List<Veterinario> listar(){
        return veterinarioServices.listar();
    }

    @GetMapping("{id}")
    public Veterinario buscarPorId(@PathVariable Long id){
        return veterinarioServices.listar().stream()
                .filter(v -> v.getIdVeterinario().equals(id))
                .findFirst()
                .orElse(null);
    }
}
