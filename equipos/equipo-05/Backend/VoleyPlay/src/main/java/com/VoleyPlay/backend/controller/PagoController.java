package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Pago;
import com.VoleyPlay.backend.services.PagoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/pago")
public class PagoController {
    private final PagoService pagoService;

    public PagoController(PagoService pagoService) {
        this.pagoService = pagoService;
    }

    @GetMapping
    public List<Pago> listar() {
        return pagoService.listar();
    }

    @GetMapping("/destacado")
    public Pago destacado() {
        return new Pago(1L, 1L, "2026-09-06", 50.00, "Yape", "Completado");
    }

    @GetMapping("{id}")
    public Pago buscarPorId(@PathVariable Long id) {
        return new Pago(id, 0L, "1900-01-01", 0.0, "Sin definir", "Pendiente");
    }
}