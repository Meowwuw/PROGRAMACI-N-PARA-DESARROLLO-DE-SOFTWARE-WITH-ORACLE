package com.vet.backend.controller;

import com.vet.backend.model.Apoderado;
import com.vet.backend.service.ApoderadoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/apoderados")
public class ApoderadoController {
    private final ApoderadoService apoderadoService;

    public ApoderadoController(ApoderadoService apoderadoService){
        this.apoderadoService = apoderadoService;
    }

    @GetMapping
    public List<Apoderado> listar(){
        return apoderadoService.listar();
    }

    @GetMapping("{id}")
    public Apoderado buscarPorId(@PathVariable Long id){
        return new Apoderado(
                id,
                "Apoderado Prueba",
                "999999999",
                "Dirección Prueba"
        );
    }
}