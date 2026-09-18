package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Horario;
import com.VoleyPlay.backend.Repository.HorarioRepository; // R mayúscula

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/horario")
@CrossOrigin(origins = "*")
public class HorarioController {

    @Autowired
    private HorarioRepository horarioRepository;

    @GetMapping
    public List<Horario> obtenerTodos() {
        return horarioRepository.findAll();
    }

    @PostMapping
    public Horario guardarHorario(@RequestBody Horario horario) {
        return horarioRepository.save(horario);
    }
}