package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Cancha;
import com.VoleyPlay.backend.services.CanchaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cancha")
@CrossOrigin(origins = "http://localhost:5173/")
public class CanchaController {
    private final CanchaService canchaService;

    public CanchaController(CanchaService canchaService) {
        this.canchaService = canchaService;
    }

    @GetMapping
    public List<Cancha> listar() {
        return canchaService.listar();
    }

    @GetMapping("/{id}")
    public Cancha buscarPorId(@PathVariable Long id) {
        return canchaService.buscarPorId(id);
    }

    @PostMapping
    public Cancha guardar(@RequestBody Cancha cancha) {
        return canchaService.guardar(cancha);
    }

    @PutMapping("/{id}")
    public Cancha actualizar(@PathVariable Long id, @RequestBody Cancha cancha) {
        return canchaService.actualizar(id, cancha);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        canchaService.eliminar(id);
    }
}