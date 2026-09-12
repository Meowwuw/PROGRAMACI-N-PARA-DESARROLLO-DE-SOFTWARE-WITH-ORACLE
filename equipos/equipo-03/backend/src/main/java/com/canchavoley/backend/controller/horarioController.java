package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Horario;
import com.canchavoley.backend.service.HorarioService;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/horarios")
public class horarioController {

    private final HorarioService horarioService;

    public horarioController(HorarioService horarioService) {
        this.horarioService = horarioService;
    }

    @GetMapping
    public List<Horario> listar() {
        return horarioService.listar();
    }

    @GetMapping("/{id}")
    public Horario buscarPorId(@PathVariable Integer id) {
        return horarioService.buscarPorId(id);
    }

    @PostMapping
    public Horario registrar(@RequestBody Horario horario) {
        return horarioService.guardar(horario);
    }
}