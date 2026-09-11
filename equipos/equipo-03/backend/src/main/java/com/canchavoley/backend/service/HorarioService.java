package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Cancha;
import com.canchavoley.backend.model.Horario;
import com.canchavoley.backend.model.Producto;
import com.canchavoley.backend.repository.CanchaRepository;
import com.canchavoley.backend.repository.HorarioRepository;
import com.canchavoley.backend.repository.ProductoRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HorarioService {

    private final HorarioRepository horarioRepository;

    public HorarioService(HorarioRepository horarioRepository) {
        this.horarioRepository=horarioRepository;
    }

    public List<Horario> listar(){
        return horarioRepository.findAll();
    }
}