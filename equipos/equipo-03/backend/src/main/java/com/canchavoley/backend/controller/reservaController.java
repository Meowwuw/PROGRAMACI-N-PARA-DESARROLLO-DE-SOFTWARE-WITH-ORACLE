package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Reserva;
import com.canchavoley.backend.service.ReservaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reservas")
public class reservaController {
    private final ReservaService reservaService;

    public reservaController(ReservaService reservaService) {
        this.reservaService = reservaService;
    }

    // ---- GET (5) ----
    @GetMapping
    public List<Reserva> listar() {
        return reservaService.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Reserva> buscarPorId(@PathVariable Integer id) {
        Reserva reserva = reservaService.buscarPorId(id);
        return reserva != null ? ResponseEntity.ok(reserva) : ResponseEntity.notFound().build();
    }

    @GetMapping("/cliente/{idCliente}")
    public List<Reserva> buscarPorCliente(@PathVariable int idCliente) {
        return reservaService.buscarPorCliente(idCliente);
    }

    @GetMapping("/fecha/{fecha}")
    public List<Reserva> buscarPorFecha(@PathVariable String fecha) {
        return reservaService.buscarPorFecha(fecha);
    }

    @GetMapping("/cancha/{idCancha}")
    public List<Reserva> buscarPorCancha(@PathVariable int idCancha) {
        return reservaService.buscarPorCancha(idCancha);
    }

    // ---- POST (2) ----
    @PostMapping
    public Reserva registrar(@RequestBody Reserva reserva) {
        return reservaService.guardar(reserva);
    }

    @PostMapping("/lote")
    public List<Reserva> registrarVarias(@RequestBody List<Reserva> reservas) {
        return reservaService.guardarVarias(reservas);
    }

    // ---- PUT (2) ----
    @PutMapping("/{id}")
    public ResponseEntity<Reserva> actualizar(@PathVariable Integer id, @RequestBody Reserva reserva) {
        Reserva actualizada = reservaService.actualizar(id, reserva);
        return actualizada != null ? ResponseEntity.ok(actualizada) : ResponseEntity.notFound().build();
    }

    @PutMapping("/{id}/fecha")
    public ResponseEntity<Reserva> actualizarFecha(@PathVariable Integer id, @RequestBody String fecha) {
        Reserva actualizada = reservaService.actualizarFecha(id, fecha);
        return actualizada != null ? ResponseEntity.ok(actualizada) : ResponseEntity.notFound().build();
    }

    // ---- DELETE (2) ----
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        if (reservaService.buscarPorId(id) != null) {
            reservaService.eliminar(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/cliente/{idCliente}")
    public ResponseEntity<Void> eliminarPorCliente(@PathVariable int idCliente) {
        reservaService.eliminarPorCliente(idCliente);
        return ResponseEntity.noContent().build();
    }
}
