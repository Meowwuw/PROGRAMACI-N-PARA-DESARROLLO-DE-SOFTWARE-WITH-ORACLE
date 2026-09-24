package com.Vet.backend.controller;

import com.Vet.backend.model.Consulta;
import com.Vet.backend.service.ConsultaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/consultas")
public class ConsultaController {

    @Autowired
    private ConsultaService consultaService;

    @GetMapping
    public List<Consulta> listar() {
        return consultaService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Consulta> obtenerPorId(@PathVariable Integer id) {
        return consultaService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/mascota/{idMascota}")
    public List<Consulta> listarPorMascota(@PathVariable Integer idMascota) {
        return consultaService.findByMascota(idMascota);
    }

    @GetMapping("/veterinario/{idVeterinario}")
    public List<Consulta> listarPorVeterinario(@PathVariable Integer idVeterinario) {
        return consultaService.findByVeterinario(idVeterinario);
    }

    @PostMapping
    public ResponseEntity<Consulta> crear(@RequestBody Consulta consulta) {
        Consulta guardada = consultaService.save(consulta);
        return ResponseEntity.status(HttpStatus.CREATED).body(guardada);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Consulta> actualizar(@PathVariable Integer id, @RequestBody Consulta consulta) {
        if (!consultaService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        consulta.setIdConsulta(id);
        return ResponseEntity.ok(consultaService.save(consulta));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (!consultaService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        consultaService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
