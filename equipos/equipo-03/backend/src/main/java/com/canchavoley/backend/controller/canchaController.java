package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Cancha;
import com.canchavoley.backend.service.CanchaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/api/canchas")
public class canchaController {

    private final CanchaService canchaService;

    public canchaController(CanchaService canchaService) {
        this.canchaService = canchaService;
    }

    @GetMapping
    public List<Cancha> listar() {
        return canchaService.listar();
    }

    @GetMapping("/{id}")
    public Cancha buscarPorId(@PathVariable Integer id) {
        return canchaService.buscarPorId(id);
    }

    @PostMapping
    public Cancha registrar(@RequestBody Cancha cancha) {
        return canchaService.guardar(cancha);
    }

}