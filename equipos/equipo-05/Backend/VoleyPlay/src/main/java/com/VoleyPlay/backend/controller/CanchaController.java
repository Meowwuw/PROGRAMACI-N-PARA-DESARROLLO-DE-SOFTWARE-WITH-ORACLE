package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Cancha;
import com.VoleyPlay.backend.services.CanchaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/cancha")
public class CanchaController {
    private final CanchaService canchaService;

    public CanchaController(CanchaService canchaService) {
        this.canchaService = canchaService;
    }

    @GetMapping
    public List<Cancha> listar() {
        return canchaService.listar();
    }

    @GetMapping("/destacado")
    public Cancha destacado() {
        return new Cancha(1L, 1, "Cancha Central", "Arena", "Disponible");
    }

    @GetMapping("{id}")
    public Cancha buscarPorId(@PathVariable Long id) {
        return new Cancha(id, 0, "Cancha prueba", "Arena", "Pendiente");
    }
}