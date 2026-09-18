package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Horario;
import com.canchavoley.backend.service.HorarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalTime;
import java.util.List;

@RestController
@RequestMapping("/api/horarios")
public class horarioController {

    private final HorarioService horarioService;

    public horarioController(HorarioService horarioService) {
        this.horarioService = horarioService;
    }

    // ---- GET (5) ----
    @GetMapping
    public List<Horario> listar() {
        return horarioService.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Horario> buscarPorId(@PathVariable Integer id) {
        Horario horario = horarioService.buscarPorId(id);
        return horario != null ? ResponseEntity.ok(horario) : ResponseEntity.notFound().build();
    }

    @GetMapping("/hora/{hora}")
    public ResponseEntity<Horario> buscarPorHora(@PathVariable LocalTime hora) {
        Horario horario = horarioService.buscarPorHora(hora);
        return horario != null ? ResponseEntity.ok(horario) : ResponseEntity.notFound().build();
    }

    @GetMapping("/precio-maximo/{precio}")
    public List<Horario> listarConPrecioMaximo(@PathVariable double precio) {
        return horarioService.listarConPrecioMaximo(precio);
    }

    @GetMapping("/ordenados")
    public List<Horario> listarOrdenados() {
        return horarioService.listarOrdenadosPorPrecio();
    }

    // ---- POST (2) ----
    @PostMapping
    public Horario registrar(@RequestBody Horario horario) {
        return horarioService.guardar(horario);
    }

    @PostMapping("/lote")
    public List<Horario> registrarVarios(@RequestBody List<Horario> horarios) {
        return horarioService.guardarVarios(horarios);
    }

    // ---- PUT (2) ----
    @PutMapping("/{id}")
    public ResponseEntity<Horario> actualizar(@PathVariable Integer id, @RequestBody Horario horario) {
        Horario actualizado = horarioService.actualizar(id, horario);
        return actualizado != null ? ResponseEntity.ok(actualizado) : ResponseEntity.notFound().build();
    }

    @PutMapping("/{id}/precio")
    public ResponseEntity<Horario> actualizarPrecio(@PathVariable Integer id, @RequestBody double precio) {
        Horario actualizado = horarioService.actualizarPrecio(id, precio);
        return actualizado != null ? ResponseEntity.ok(actualizado) : ResponseEntity.notFound().build();
    }

    // ---- DELETE (2) ----
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        return horarioService.eliminar(id) ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/hora/{hora}")
    public ResponseEntity<Void> eliminarPorHora(@PathVariable LocalTime hora) {
        horarioService.eliminarPorHora(hora);
        return ResponseEntity.noContent().build();
    }
}
