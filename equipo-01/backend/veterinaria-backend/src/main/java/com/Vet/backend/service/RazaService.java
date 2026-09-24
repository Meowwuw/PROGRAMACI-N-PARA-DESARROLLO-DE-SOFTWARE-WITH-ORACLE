package com.Vet.backend.service;

import com.Vet.backend.model.Raza;
import com.Vet.backend.repository.RazaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RazaService {

    @Autowired
    private RazaRepository razaRepository;

    public List<Raza> findAll() {
        return razaRepository.findAll();
    }

    public Optional<Raza> findById(Integer id) {
        return razaRepository.findById(id);
    }

    public List<Raza> findByEspecie(Integer idEspecie) {
        return razaRepository.findByEspecie_IdEspecie(idEspecie);
    }

    public Raza save(Raza raza) {
        return razaRepository.save(raza);
    }

    public void deleteById(Integer id) {
        razaRepository.deleteById(id);
    }

    public boolean existsById(Integer id) {
        return razaRepository.existsById(id);
    }
}
