package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Pago;
import com.canchavoley.backend.service.PagoService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/pagos")
public class pagoController {
    private final PagoService pagoService;

    public pagoController(PagoService pagoService){
        this.pagoService=pagoService;
    }

    @GetMapping
    public List<Pago> listar(){
        return pagoService.listar();
    }
}
