package com.perfumeria.backend.controller;

import com.perfumeria.backend.model.Venta;
import com.perfumeria.backend.service.VentaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/ventas")
public class VentaController {

    @Autowired
    private VentaService ventaService;

    @GetMapping
    public List<Venta> obtenerTodasLasVentas() {
        return ventaService.obtenerTodasLasVentas();
    }

    @PutMapping("/{id}")
    public Venta actualizar(@PathVariable int id, @RequestBody Venta venta) {
        return ventaService.actualizar(id, venta);
    }
}