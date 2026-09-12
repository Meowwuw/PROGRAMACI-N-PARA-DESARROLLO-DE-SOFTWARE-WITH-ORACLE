package com.serviciocancha.controller;

import com.serviciocancha.model.Cancha;
import com.serviciocancha.service.CanchaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/canchas")
@CrossOrigin(origins = "*")
public class CanchaController {

    @Autowired
    private CanchaService canchaService;

    @GetMapping
    public List<Cancha> listar() {
        return canchaService.listar();
    }

    @GetMapping("/{id}")
    public Cancha buscarPorId(@PathVariable Integer id) {
        return canchaService.buscarPorId(id);
    }

    @PostMapping
    public Cancha guardar(@RequestBody Cancha cancha) {
        return canchaService.guardar(cancha);
    }
}