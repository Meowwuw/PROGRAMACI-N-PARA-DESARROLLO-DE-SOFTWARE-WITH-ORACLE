package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Cancha;
import com.canchavoley.backend.service.CanchaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/canchas")
public class canchaController {

    private final CanchaService canchaService;

    public canchaController(CanchaService canchaService) {
        this.canchaService = canchaService;
    }

    // ---- GET (5) ----
    @GetMapping
    public List<Cancha> listar() {
        return canchaService.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Cancha> buscarPorId(@PathVariable Integer id) {
        Cancha cancha = canchaService.buscarPorId(id);
        return cancha != null ? ResponseEntity.ok(cancha) : ResponseEntity.notFound().build();
    }

    @GetMapping("/numero/{numeroCancha}")
    public ResponseEntity<Cancha> buscarPorNumero(@PathVariable int numeroCancha) {
        Cancha cancha = canchaService.buscarPorNumero(numeroCancha);
        return cancha != null ? ResponseEntity.ok(cancha) : ResponseEntity.notFound().build();
    }

    @GetMapping("/ordenadas")
    public List<Cancha> listarOrdenadas() {
        return canchaService.listarOrdenadasPorNumero();
    }

    @GetMapping("/desde/{numeroCancha}")
    public List<Cancha> listarDesde(@PathVariable int numeroCancha) {
        return canchaService.listarDesdeNumero(numeroCancha);
    }

    // ---- POST (2) ----
    @PostMapping
    public Cancha registrar(@RequestBody Cancha cancha) {
        return canchaService.guardar(cancha);
    }

    @PostMapping("/lote")
    public List<Cancha> registrarVarias(@RequestBody List<Cancha> canchas) {
        return canchaService.guardarVarias(canchas);
    }

    // ---- PUT (2) ----
    @PutMapping("/{id}")
    public ResponseEntity<Cancha> actualizar(@PathVariable Integer id, @RequestBody Cancha cancha) {
        Cancha actualizada = canchaService.actualizar(id, cancha);
        return actualizada != null ? ResponseEntity.ok(actualizada) : ResponseEntity.notFound().build();
    }

    @PutMapping("/{id}/numero")
    public ResponseEntity<Cancha> actualizarNumero(@PathVariable Integer id, @RequestBody int numeroCancha) {
        Cancha actualizada = canchaService.actualizarNumero(id, numeroCancha);
        return actualizada != null ? ResponseEntity.ok(actualizada) : ResponseEntity.notFound().build();
    }

    // ---- DELETE (2) ----
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        return canchaService.eliminar(id) ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/numero/{numeroCancha}")
    public ResponseEntity<Void> eliminarPorNumero(@PathVariable int numeroCancha) {
        canchaService.eliminarPorNumero(numeroCancha);
        return ResponseEntity.noContent().build();
    }
}
