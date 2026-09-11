package com.veterinaria_xime.backend.service;

import com.veterinaria_xime.backend.model.Mascota;
import com.veterinaria_xime.backend.repository.MascotaRepository;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class MascotaService {
    private final MascotaRepository mascotaRepository;

    public MascotaService(MascotaRepository mascotaRepository){
        this.mascotaRepository=mascotaRepository;
    }

    public List<Mascota> listar(){
        return mascotaRepository.findAll();
    }

}
