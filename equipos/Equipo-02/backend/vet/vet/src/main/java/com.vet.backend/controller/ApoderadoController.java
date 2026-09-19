package com.vet.backend.controller;

import com.vet.backend.model.Apoderado;
import com.vet.backend.service.ApoderadoService;
import org.springframework.http.HttpStatus;
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

    @PostMapping
    public ResponseEntity<Apoderado> crear(@RequestBody Apoderado apoderado) {
        Apoderado nuevo = apoderadoService.guardar(apoderado);
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevo);
    }

    @PutMapping("{id}")
    public ResponseEntity<Apoderado> actualizar(@PathVariable Long id, @RequestBody Apoderado apoderado) {
        return apoderadoService.actualizar(id, apoderado)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        if (!apoderadoService.eliminar(id)) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.noContent().build();
    }
}