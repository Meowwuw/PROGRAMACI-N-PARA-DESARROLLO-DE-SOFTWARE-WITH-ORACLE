package com.vet.backend.controller;

import com.vet.backend.model.Consulta;
import com.vet.backend.service.ConsultaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/consultas")
public class ConsultaController {
    private final ConsultaService consultaService;

    public ConsultaController(ConsultaService consultaService){
        this.consultaService = consultaService;
    }

    @GetMapping
    public List<Consulta> listar(){
        return consultaService.listar();
    }

    @GetMapping("{id}")
    public Consulta buscarPorId(@PathVariable Long id){
        return new Consulta(
                id,
                "Consulta Prueba",
                "2026-09-05",
                "Diagnóstico de prueba"
        );
    }
}