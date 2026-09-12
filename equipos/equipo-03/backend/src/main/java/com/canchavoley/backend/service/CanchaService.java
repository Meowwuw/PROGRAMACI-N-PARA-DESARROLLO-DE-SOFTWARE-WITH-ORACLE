package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Cancha;
import com.canchavoley.backend.repository.CanchaRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CanchaService {

    private final CanchaRepository canchaRepository;

    public CanchaService(CanchaRepository canchaRepository) {
        this.canchaRepository=canchaRepository;
    }

    public List<Cancha> listar(){
        return canchaRepository.findAll();
    }

    public Cancha buscarPorId(Long id) {
        return canchaRepository.findById(id)
                .orElse(null);
    }

}