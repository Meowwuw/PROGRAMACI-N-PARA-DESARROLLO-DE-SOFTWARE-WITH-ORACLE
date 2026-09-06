package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Horario;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Service
public class HorarioService {
    @GetMapping
    public List<Horario> listar() {
        return List.of(
                new Horario(1L, "08:00", "10:00", 50.00),
                new Horario(2L, "10:00", "12:00", 50.00),
                new Horario(3L, "14:00", "16:00", 70.00)
        );
    }
}