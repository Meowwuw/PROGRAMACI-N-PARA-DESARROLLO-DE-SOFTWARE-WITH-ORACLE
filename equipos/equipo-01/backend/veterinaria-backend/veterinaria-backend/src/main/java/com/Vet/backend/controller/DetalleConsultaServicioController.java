package com.Vet.backend.controller;

import com.Vet.backend.model.DetalleConsultaServicio;
import com.Vet.backend.service.DetalleConsultaServicioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/detalle-consulta-servicio")
public class DetalleConsultaServicioController {

    @Autowired
    private DetalleConsultaServicioService detalleService;

    @GetMapping
    public List<DetalleConsultaServicio> listar() {
        return detalleService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<DetalleConsultaServicio> obtenerPorId(@PathVariable Integer id) {
        return detalleService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/consulta/{idConsulta}")
    public List<DetalleConsultaServicio> listarPorConsulta(@PathVariable Integer idConsulta) {
        return detalleService.findByConsulta(idConsulta);
    }

    @PostMapping
    public ResponseEntity<DetalleConsultaServicio> crear(@RequestBody DetalleConsultaServicio detalle) {
        DetalleConsultaServicio guardado = detalleService.save(detalle);
        return ResponseEntity.status(HttpStatus.CREATED).body(guardado);
    }

    @PutMapping("/{id}")
    public ResponseEntity<DetalleConsultaServicio> actualizar(@PathVariable Integer id, @RequestBody DetalleConsultaServicio detalle) {
        if (!detalleService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        detalle.setIdDetalle(id);
        return ResponseEntity.ok(detalleService.save(detalle));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (!detalleService.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        detalleService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
