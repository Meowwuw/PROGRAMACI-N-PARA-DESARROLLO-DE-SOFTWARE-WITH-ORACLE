package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Reserva;
import com.VoleyPlay.backend.services.ReservaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reserva")
public class ReservaController {
    private final ReservaService reservaService;

    public ReservaController(ReservaService reservaService) {
        this.reservaService = reservaService;
    }

    @GetMapping
    public List<Reserva> listar() {
        return reservaService.listar();
    }

    @GetMapping("/{id}")
    public Reserva buscarPorId(@PathVariable Long id) {
        return reservaService.buscarPorId(id);
    }

    @PostMapping
    public Reserva guardar(@RequestBody Reserva reserva) {
        return reservaService.guardar(reserva);
    }

    @PutMapping("/{id}")
    public Reserva actualizar(@PathVariable Long id, @RequestBody Reserva reserva) {
        return reservaService.actualizar(id, reserva);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        reservaService.eliminar(id);
    }
}