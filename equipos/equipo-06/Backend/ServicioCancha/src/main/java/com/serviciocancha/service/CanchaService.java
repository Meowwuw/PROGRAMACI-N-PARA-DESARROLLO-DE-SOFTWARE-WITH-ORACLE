package com.serviciocancha.service;

import com.serviciocancha.model.Cancha;
import com.serviciocancha.repository.CanchaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class CanchaService {

    @Autowired
    private CanchaRepository canchaRepository;

    public List<Cancha> listar() {
        return canchaRepository.findAll();
    }

    public Cancha buscarPorId(Integer id) {
        return canchaRepository.findById(id).orElse(null);
    }

    public Cancha guardar(Cancha cancha) {
        return canchaRepository.save(cancha);
    }
}
