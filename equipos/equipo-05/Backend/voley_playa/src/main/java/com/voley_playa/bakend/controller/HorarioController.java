package com.voley_playa.bakend.controller;



import com.voley_playa.bakend.model.Horario;

import com.voley_playa.bakend.service.HorarioService;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;



import java.util.List;



@RestController

@RequestMapping("/api/horarios")

public class HorarioController {



    @Autowired

    private HorarioService horarioService;



    @GetMapping

    public List<Horario> listarHorarios() {

        return horarioService.listarHorarios();

    }

}

