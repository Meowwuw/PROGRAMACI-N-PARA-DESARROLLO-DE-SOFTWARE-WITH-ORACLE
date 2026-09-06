package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Reserva;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Service
public class ReservaService {
    @GetMapping
    public List<Reserva> listar() {
        return List.of(
                new Reserva(1L, 1L, 1L, 1L, "2026-09-06", "Pendiente", 50.00),
                new Reserva(2L, 2L, 2L, 2L, "2026-09-07", "Confirmada", 50.00),
                new Reserva(3L, 3L, 3L, 3L, "2026-09-08", "Pendiente", 70.00)
        );
    }
}