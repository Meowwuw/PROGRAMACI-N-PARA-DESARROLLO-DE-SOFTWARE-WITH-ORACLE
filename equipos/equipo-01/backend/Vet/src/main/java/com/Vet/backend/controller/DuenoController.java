package com.Vet.backend.controller;

import com.Vet.backend.model.Dueno;
import com.Vet.backend.services.DuenoServices;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/duenos")
public class DuenoController {
    private final DuenoServices duenoServices;

    public DuenoController(DuenoServices duenoServices){
        this.duenoServices = duenoServices;
    }

    @GetMapping
    public List<Dueno> listar(){
        return duenoServices.listar();
    }

    @GetMapping("{id}")
    public Dueno buscarPorId(@PathVariable Long id){
        return duenoServices.listar().stream()
                .filter(d -> d.getIdDueno().equals(id))
                .findFirst()
                .orElse(null);
    }
}
