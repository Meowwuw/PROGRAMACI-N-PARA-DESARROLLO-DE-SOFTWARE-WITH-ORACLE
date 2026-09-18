package com.Vet.backend.service;

import com.Vet.backend.model.Especie;
import com.Vet.backend.repository.EspecieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EspecieService {

    @Autowired
    private EspecieRepository especieRepository;

    public List<Especie> findAll() {
        return especieRepository.findAll();
    }

    public Optional<Especie> findById(Integer id) {
        return especieRepository.findById(id);
    }

    public Especie save(Especie especie) {
        return especieRepository.save(especie);
    }

    public void deleteById(Integer id) {
        especieRepository.deleteById(id);
    }

    public boolean existsById(Integer id) {
        return especieRepository.existsById(id);
    }
}
