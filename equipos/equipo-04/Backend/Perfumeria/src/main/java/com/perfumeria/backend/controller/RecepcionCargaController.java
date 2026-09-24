package com.perfumeria.backend.controller;

import com.perfumeria.backend.model.RecepcionCarga;
import com.perfumeria.backend.service.RecepcionCargaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/recepciones")
public class RecepcionCargaController {

    @Autowired
    private RecepcionCargaService recepcionCargaService;

    @GetMapping
    public List<RecepcionCarga> listarTodas() {
        return recepcionCargaService.listarTodas();
    }

    @GetMapping("/{id}")
    public ResponseEntity<RecepcionCarga> buscarPorId(@PathVariable Long id) {
        return recepcionCargaService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<RecepcionCarga> crear(@RequestBody RecepcionCarga recepcion) {
        RecepcionCarga nuevaRecepcion = recepcionCargaService.guardar(recepcion);
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevaRecepcion);
    }

    @PutMapping("/{id}")
    public ResponseEntity<RecepcionCarga> actualizar(@PathVariable Long id, @RequestBody RecepcionCarga recepcion) {
        RecepcionCarga recepcionActualizada = recepcionCargaService.actualizar(id, recepcion);
        if (recepcionActualizada != null) {
            return ResponseEntity.ok(recepcionActualizada);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        boolean eliminado = recepcionCargaService.eliminar(id);
        if (eliminado) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
