package com.Vet.backend.controller;

import com.Vet.backend.model.Especie;
import com.Vet.backend.service.EspecieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/especies")
public class EspecieController {

    @Autowired
    private EspecieService especieService;

    @GetMapping
    public List<Especie> listar() {
        return especieService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Especie> obtenerPorId(@PathVariable Integer id) {
        return especieService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Especie> crear(@RequestBody Especie especie) {
        Especie guardada = especieService.save(especie);
        return ResponseEntity.status(HttpStatus.CREATED).body(guardada);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Especie> actualizar(@PathVariable Integer id, @RequestBody Especie especie) {
        if (!especieService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        especie.setIdEspecie(id);
        return ResponseEntity.ok(especieService.save(especie));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (!especieService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        especieService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
