package com.veterinaria_xime.backend.service;

import com.veterinaria_xime.backend.model.Mascota;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MascotaService {


    public List<Mascota> listar(){
        return List.of(
                new Mascota(1L, 50.00, "Consulta Médica General", "Atención"),
                new Mascota(2L, 35.00, "Vacuna Sextuple Canina", "Vacunación"),
                new Mascota(3L, 45.00, "Baño y Corte Higiénico", "Grooming")
        );
    }

}
