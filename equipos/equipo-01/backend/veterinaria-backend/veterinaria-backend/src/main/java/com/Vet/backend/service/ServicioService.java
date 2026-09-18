package com.Vet.backend.service;

import com.Vet.backend.model.Servicio;
import com.Vet.backend.repository.ServicioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ServicioService {

    @Autowired
    private ServicioRepository servicioRepository;

    public List<Servicio> findAll() {
        return servicioRepository.findAll();
    }

    public Optional<Servicio> findById(Integer id) {
        return servicioRepository.findById(id);
    }

    public Servicio save(Servicio servicio) {
        return servicioRepository.save(servicio);
    }

    public void deleteById(Integer id) {
        servicioRepository.deleteById(id);
    }

    public boolean existsById(Integer id) {
        return servicioRepository.existsById(id);
    }
}
