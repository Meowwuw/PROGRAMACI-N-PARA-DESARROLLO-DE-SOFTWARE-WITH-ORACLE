package com.Vet.backend.controller;

import com.Vet.backend.model.Raza;
import com.Vet.backend.service.RazaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/razas")
public class RazaController {

    @Autowired
    private RazaService razaService;

    @GetMapping
    public List<Raza> listar() {
        return razaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Raza> obtenerPorId(@PathVariable Integer id) {
        return razaService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/especie/{idEspecie}")
    public List<Raza> listarPorEspecie(@PathVariable Integer idEspecie) {
        return razaService.findByEspecie(idEspecie);
    }

    @PostMapping
    public ResponseEntity<Raza> crear(@RequestBody Raza raza) {
        Raza guardada = razaService.save(raza);
        return ResponseEntity.status(HttpStatus.CREATED).body(guardada);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Raza> actualizar(@PathVariable Integer id, @RequestBody Raza raza) {
        if (!razaService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        raza.setIdRaza(id);
        return ResponseEntity.ok(razaService.save(raza));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (!razaService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        razaService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
