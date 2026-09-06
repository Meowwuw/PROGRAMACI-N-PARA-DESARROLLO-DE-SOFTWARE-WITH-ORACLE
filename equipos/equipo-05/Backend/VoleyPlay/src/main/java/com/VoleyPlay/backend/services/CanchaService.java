package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Cancha;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Service
public class CanchaService {
    @GetMapping
    public List<Cancha> listar() {
        return List.of(
                new Cancha(1L, 1, "Cancha Central", "Arena", "Disponible"),
                new Cancha(2L, 2, "Cancha Lateral", "Arena", "Disponible"),
                new Cancha(3L, 3, "Cancha Principal", "Césped", "Mantenimiento")
        );
    }
}