package com.vet.backend.controller;

import com.vet.backend.model.Apoderado;
import com.vet.backend.service.ApoderadoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/apoderados")
public class ApoderadoController {

    private final ApoderadoService apoderadoService;

    public ApoderadoController(ApoderadoService apoderadoService) {
        this.apoderadoService = apoderadoService;
    }

    @GetMapping
    public List<Apoderado> listar() {
        return apoderadoService.listar();
    }

    @GetMapping("{id}")
    public ResponseEntity<Apoderado> buscarPorId(@PathVariable Long id) {
        return apoderadoService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}