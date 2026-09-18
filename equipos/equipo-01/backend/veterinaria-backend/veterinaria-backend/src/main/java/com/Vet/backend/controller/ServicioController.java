package com.Vet.backend.controller;

import com.Vet.backend.model.Servicio;
import com.Vet.backend.service.ServicioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/servicios")
public class ServicioController {

    @Autowired
    private ServicioService servicioService;

    @GetMapping
    public List<Servicio> listar() {
        return servicioService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Servicio> obtenerPorId(@PathVariable Integer id) {
        return servicioService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Servicio> crear(@RequestBody Servicio servicio) {
        Servicio guardado = servicioService.save(servicio);
        return ResponseEntity.status(HttpStatus.CREATED).body(guardado);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Servicio> actualizar(@PathVariable Integer id, @RequestBody Servicio servicio) {
        if (!servicioService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        servicio.setIdServicio(id);
        return ResponseEntity.ok(servicioService.save(servicio));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (!servicioService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        servicioService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
