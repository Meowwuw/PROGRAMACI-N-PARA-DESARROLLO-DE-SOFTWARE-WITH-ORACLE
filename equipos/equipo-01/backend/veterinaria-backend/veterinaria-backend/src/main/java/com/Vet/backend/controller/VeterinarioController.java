package com.Vet.backend.controller;

import com.Vet.backend.model.Veterinario;
import com.Vet.backend.service.VeterinarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/veterinarios")
public class VeterinarioController {

    @Autowired
    private VeterinarioService veterinarioService;

    @GetMapping
    public List<Veterinario> listar() {
        return veterinarioService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Veterinario> obtenerPorId(@PathVariable Integer id) {
        return veterinarioService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Veterinario> crear(@RequestBody Veterinario veterinario) {
        Veterinario guardado = veterinarioService.save(veterinario);
        return ResponseEntity.status(HttpStatus.CREATED).body(guardado);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Veterinario> actualizar(@PathVariable Integer id, @RequestBody Veterinario veterinario) {
        if (!veterinarioService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        veterinario.setIdVeterinario(id);
        return ResponseEntity.ok(veterinarioService.save(veterinario));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (!veterinarioService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        veterinarioService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
