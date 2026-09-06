package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Pago;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Service
public class PagoService {
    @GetMapping
    public List<Pago> listar() {
        return List.of(
                new Pago(1L, 1L, "2026-09-06", 50.00, "Yape", "Completado"),
                new Pago(2L, 2L, "2026-09-07", 50.00, "Efectivo", "Pendiente"),
                new Pago(3L, 3L, "2026-09-08", 70.00, "Tarjeta", "Completado")
        );
    }
}