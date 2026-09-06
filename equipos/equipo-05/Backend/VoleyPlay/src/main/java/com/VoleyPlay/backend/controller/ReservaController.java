package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Reserva;
import com.VoleyPlay.backend.services.ReservaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

    @GetMapping("/destacado")
    public Reserva destacado() {
        return new Reserva(1L, 1L, 1L, 1L, "2026-09-06", "Confirmada", 50.00);
    }

    @GetMapping("{id}")
    public Reserva buscarPorId(@PathVariable Long id) {
        return new Reserva(id, 0L, 0L, 0L, "1900-01-01", "Pendiente", 0.0);
    }
}