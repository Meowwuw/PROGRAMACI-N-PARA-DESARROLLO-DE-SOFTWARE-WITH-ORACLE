package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Horario;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HorarioService {

    private final List<Horario> listaHorarios = new ArrayList<>();

    public HorarioService() {

        listaHorarios.add(new Horario(1L, "08:00 - 09:00", 25.0));
        listaHorarios.add(new Horario(2L, "09:00 - 10:00", 25.0));
    }

    public List<Horario> listar() {
        return listaHorarios;
    }

    public Horario guardar(Horario hora) {
        listaHorarios.add(hora);
        return hora;
    }
}