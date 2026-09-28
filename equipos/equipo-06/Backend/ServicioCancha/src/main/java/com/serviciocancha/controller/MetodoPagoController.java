package com.serviciocancha.controller;

import com.serviciocancha.model.MetodoPago;
import com.serviciocancha.service.MetodoPagoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/metodos-pago")
@CrossOrigin(origins = "*")
public class MetodoPagoController {

    @Autowired
    private MetodoPagoService metodoPagoService;

    @GetMapping
    public List<MetodoPago> listar() {
        return metodoPagoService.listar();
    }

    @GetMapping("/{id}")
    public MetodoPago buscarPorId(@PathVariable Integer id) {
        return metodoPagoService.buscarPorId(id);
    }

    @PostMapping
    public MetodoPago guardar(@RequestBody MetodoPago metodoPago) {
        return metodoPagoService.guardar(metodoPago);
    }
}