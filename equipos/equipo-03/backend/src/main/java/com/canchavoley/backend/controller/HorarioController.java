package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Horario;
import com.canchavoley.backend.service.HorarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalTime;
import java.util.List;

@RestController
@RequestMapping("/api/horarios")
@CrossOrigin(origins = "*")
public class HorarioController {

    @Autowired
    private HorarioService horarioService;

    // ==========================================
    // 5 ENDPOINTS GET
    // ==========================================

    // GET 1: Listar todos los horarios
    @GetMapping
    public List<Horario> listarTodos() {
        return horarioService.obtenerTodos();
    }

    // GET 2: Buscar horario por ID
    @GetMapping("/{id}")
    public ResponseEntity<Horario> buscarPorId(@PathVariable Long id) {
        return horarioService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // GET 3: Buscar por hora exacta (ejemplo formato: 08:00:00)
    @GetMapping("/hora/{hora}")
    public ResponseEntity<Horario> buscarPorHora(
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime hora) {
        return horarioService.obtenerPorHora(hora)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // GET 4: Filtrar por precio menor o igual
    @GetMapping("/precio-maximo")
    public List<Horario> listarPorPrecioMaximo(@RequestParam BigDecimal max) {
        return horarioService.obtenerPorPrecioMaximo(max);
    }

    // GET 5: Contar total de horarios registrados
    @GetMapping("/conteo")
    public ResponseEntity<Long> contarHorarios() {
        return ResponseEntity.ok(horarioService.contarTodos());
    }

    // ==========================================
    // 2 ENDPOINTS POST
    // ==========================================

    // POST 1: Crear un horario
    @PostMapping
    public ResponseEntity<Horario> crearHorario(@RequestBody Horario horario) {
        return new ResponseEntity<>(horarioService.guardar(horario), HttpStatus.CREATED);
    }

    // POST 2: Crear varios horarios en lote
    @PostMapping("/lote")
    public ResponseEntity<List<Horario>> crearHorariosEnLote(@RequestBody List<Horario> horarios) {
        return new ResponseEntity<>(horarioService.guardarVarios(horarios), HttpStatus.CREATED);
    }

    // ==========================================
    // 2 ENDPOINTS PUT
    // ==========================================

    // PUT 1: Actualizar horario completo por ID
    @PutMapping("/{id}")
    public ResponseEntity<Horario> actualizarHorario(@PathVariable Long id, @RequestBody Horario horario) {
        return ResponseEntity.ok(horarioService.actualizar(id, horario));
    }

    // PUT 2: Actualizar únicamente el precio del horario
    @PutMapping("/{id}/precio")
    public ResponseEntity<Horario> actualizarPrecio(@PathVariable Long id, @RequestParam BigDecimal nuevoPrecio) {
        return ResponseEntity.ok(horarioService.actualizarPrecio(id, nuevoPrecio));
    }

    // ==========================================
    // 2 ENDPOINTS DELETE
    // ==========================================

    // DELETE 1: Eliminar horario por ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarPorId(@PathVariable Long id) {
        horarioService.eliminarPorId(id);
        return ResponseEntity.noContent().build();
    }

    // DELETE 2: Eliminar horario por hora exacta
    @DeleteMapping("/hora/{hora}")
    public ResponseEntity<Void> eliminarPorHora(
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime hora) {
        horarioService.eliminarPorHora(hora);
        return ResponseEntity.noContent().build();
    }
}