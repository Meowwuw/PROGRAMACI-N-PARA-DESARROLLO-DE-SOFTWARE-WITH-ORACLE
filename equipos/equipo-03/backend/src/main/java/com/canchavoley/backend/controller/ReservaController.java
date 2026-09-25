package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Reserva;
import com.canchavoley.backend.service.ReservaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/reservas")
@CrossOrigin(origins = "*")
public class ReservaController {

    @Autowired
    private ReservaService reservaService;

    // ==========================================
    // 5 ENDPOINTS GET
    // ==========================================

    // GET 1: Listar todas las reservas
    @GetMapping
    public List<Reserva> listarTodas() {
        return reservaService.obtenerTodas();
    }

    // GET 2: Buscar reserva por ID
    @GetMapping("/{id}")
    public ResponseEntity<Reserva> buscarPorId(@PathVariable Long id) {
        return reservaService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // GET 3: Buscar reservas por fecha (formato YYYY-MM-DD)
    @GetMapping("/fecha/{fecha}")
    public List<Reserva> buscarPorFecha(
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha) {
        return reservaService.obtenerPorFecha(fecha);
    }

    // GET 4: Buscar reservas asociadas a un cliente por su ID
    @GetMapping("/cliente/{idCliente}")
    public List<Reserva> buscarPorCliente(@PathVariable Long idCliente) {
        return reservaService.obtenerPorCliente(idCliente);
    }

    // GET 5: Contar total de reservas
    @GetMapping("/conteo")
    public ResponseEntity<Long> contarReservas() {
        return ResponseEntity.ok(reservaService.contarTodas());
    }

    // ==========================================
    // 2 ENDPOINTS POST
    // ==========================================

    // POST 1: Crear una reserva
    @PostMapping
    public ResponseEntity<Reserva> crearReserva(@RequestBody Reserva reserva) {
        return new ResponseEntity<>(reservaService.guardar(reserva), HttpStatus.CREATED);
    }

    // POST 2: Crear reservas en lote
    @PostMapping("/lote")
    public ResponseEntity<List<Reserva>> crearReservasEnLote(@RequestBody List<Reserva> reservas) {
        return new ResponseEntity<>(reservaService.guardarVarias(reservas), HttpStatus.CREATED);
    }

    // ==========================================
    // 2 ENDPOINTS PUT
    // ==========================================

    // PUT 1: Actualizar reserva completa por ID
    @PutMapping("/{id}")
    public ResponseEntity<Reserva> actualizarReserva(@PathVariable Long id, @RequestBody Reserva reserva) {
        return ResponseEntity.ok(reservaService.actualizar(id, reserva));
    }

    // PUT 2: Reprogramar únicamente la fecha de una reserva
    @PutMapping("/{id}/fecha")
    public ResponseEntity<Reserva> actualizarFechaReserva(
            @PathVariable Long id,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate nuevaFecha) {
        return ResponseEntity.ok(reservaService.actualizarFecha(id, nuevaFecha));
    }

    // ==========================================
    // 2 ENDPOINTS DELETE
    // ==========================================

    // DELETE 1: Eliminar una reserva por ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarPorId(@PathVariable Long id) {
        reservaService.eliminarPorId(id);
        return ResponseEntity.noContent().build();
    }

    // DELETE 2: Eliminar reservas pertenecientes a una fecha
    @DeleteMapping("/fecha/{fecha}")
    public ResponseEntity<Void> eliminarPorFecha(
            @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fecha) {
        reservaService.eliminarPorFecha(fecha);
        return ResponseEntity.noContent().build();
    }
}