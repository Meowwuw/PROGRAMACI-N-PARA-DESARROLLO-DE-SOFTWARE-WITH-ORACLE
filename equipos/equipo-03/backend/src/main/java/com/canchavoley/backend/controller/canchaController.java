package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Cancha;
import com.canchavoley.backend.service.CanchaService;
import org.springframework.web.bind.annotation.GetMapping;
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
}