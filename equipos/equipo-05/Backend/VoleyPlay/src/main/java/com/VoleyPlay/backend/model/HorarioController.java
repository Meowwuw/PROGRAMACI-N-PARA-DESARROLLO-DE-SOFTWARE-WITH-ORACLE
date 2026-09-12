package com.VoleyPlay.backend.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

public class HorarioController {


import com.VoleyPlay.backend.model.Horario;

import com.VoleyPlay.backend.service.HorarioService;

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


}
