package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Horario;
import com.VoleyPlay.backend.services.HorarioService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/horario")
public class HorarioController {
    private final HorarioService horarioService;

    public HorarioController(HorarioService horarioService) {
        this.horarioService = horarioService;
    }

    @GetMapping
    public List<Horario> listar() {
        return horarioService.listar();
    }

    @GetMapping("/destacado")
    public Horario destacado() {
        return new Horario(1L, "18:00", "20:00", 80.00);
    }

    @GetMapping("{id}")
    public Horario buscarPorId(@PathVariable Long id) {
        return new Horario(id, "00:00", "00:00", 0.0);
    }
}