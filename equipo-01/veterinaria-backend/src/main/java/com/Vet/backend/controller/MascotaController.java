package com.Vet.backend.controller;

import com.Vet.backend.model.Mascota;
import com.Vet.backend.service.MascotaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/mascotas")
public class MascotaController {

    @Autowired
    private MascotaService mascotaService;

    @GetMapping
    public List<Mascota> listar() {
        return mascotaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Mascota> obtenerPorId(@PathVariable Integer id) {
        return mascotaService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/dueno/{idDueno}")
    public List<Mascota> listarPorDueno(@PathVariable Integer idDueno) {
        return mascotaService.findByDueno(idDueno);
    }

    @PostMapping
    public ResponseEntity<Mascota> crear(@RequestBody Mascota mascota) {
        Mascota guardada = mascotaService.save(mascota);
        return ResponseEntity.status(HttpStatus.CREATED).body(guardada);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Mascota> actualizar(@PathVariable Integer id, @RequestBody Mascota mascota) {
        if (!mascotaService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        mascota.setIdMascota(id);
        return ResponseEntity.ok(mascotaService.save(mascota));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (!mascotaService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        mascotaService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
