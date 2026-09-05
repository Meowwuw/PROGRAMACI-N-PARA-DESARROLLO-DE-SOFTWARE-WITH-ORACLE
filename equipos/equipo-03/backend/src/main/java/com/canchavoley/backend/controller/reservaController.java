package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Cliente;
import com.canchavoley.backend.model.Reserva;
import com.canchavoley.backend.service.ClienteService;
import com.canchavoley.backend.service.ReservaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class reservaController {
    private final ReservaService reservaService;

    public reservaController(ReservaService reservaService){
        this.reservaService=reservaService;
    }

    @GetMapping
    public List<Reserva> listar(){
        return reservaService.listar();
    }


}
