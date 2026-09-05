package com.vet.backend.controller;

import com.vet.backend.model.Tratamiento;
import com.vet.backend.service.TratamientoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/tratamientos")
public class TratamientoController {
    private final TratamientoService tratamientoService;

    public TratamientoController(TratamientoService tratamientoService){
        this.tratamientoService = tratamientoService;
    }

    @GetMapping
    public List<Tratamiento> listar(){
        return tratamientoService.listar();
    }

    @GetMapping("{id}")
    public Tratamiento buscarPorId(@PathVariable Long id){
        return new Tratamiento(
                id,
                "Tratamiento Prueba",
                "Descripción de prueba",
                20.00
        );
    }
}