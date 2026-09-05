package com.proyectoweb.backed.controller;


import com.proyectoweb.backed.model.Cancha;
import com.proyectoweb.backed.service.CanchaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reserva")
public class CanchaController {

    private final CanchaService reservaService;

    // Inyección de dependencias por constructor
    public CanchaController(CanchaService reservaService) {
        this.reservaService = reservaService;
    }

    // Endpoint para obtener la lista de todas las canchas/reservas
    // GET /api/reservas
    @GetMapping
    public List<Cancha> listarCanchas() {
        return reservaService.obtenerTodasLasCanchas();
    }

    // Endpoint para buscar una cancha/reserva por ID
    // GET /api/reservas/1
    @GetMapping("/{id}")
    public Cancha obtenerPorId(@PathVariable Long id) {
        return reservaService.buscarPorId(id);
    }

    // Endpoint para registrar o guardar una nueva cancha/reserva
    // POST /api/reservas
    @PostMapping
    public Cancha crearCancha(@RequestBody Cancha cancha) {
        return reservaService.guardarCancha(cancha);
    }

}
