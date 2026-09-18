package com.voley_playa.bakend.service;



import com.voley_playa.bakend.model.Horario;

import com.voley_playa.bakend.repository.HorarioRepository;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;



import java.util.List;



@Service

public class HorarioService {



    @Autowired

    private HorarioRepository horarioRepository;



    public List<Horario> listarHorarios() {

        return horarioRepository.findAll();

    }

}