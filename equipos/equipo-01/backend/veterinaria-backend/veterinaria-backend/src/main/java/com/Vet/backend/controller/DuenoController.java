package com.Vet.backend.controller;

import com.Vet.backend.model.Dueno;
import com.Vet.backend.service.DuenoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/duenos")
public class DuenoController {

    @Autowired
    private DuenoService duenoService;

    @GetMapping
    public List<Dueno> listar() {
        return duenoService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Dueno> obtenerPorId(@PathVariable Integer id) {
        return duenoService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Dueno> crear(@RequestBody Dueno dueno) {
        Dueno guardado = duenoService.save(dueno);
        return ResponseEntity.status(HttpStatus.CREATED).body(guardado);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Dueno> actualizar(@PathVariable Integer id, @RequestBody Dueno dueno) {
        if (!duenoService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        dueno.setIdDueno(id);
        return ResponseEntity.ok(duenoService.save(dueno));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (!duenoService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        duenoService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
