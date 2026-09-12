package com.vet.backend.service;

import com.vet.backend.model.Tratamiento;
import com.vet.backend.repository.TratamientoRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TratamientoService {

    private final TratamientoRepository tratamientoRepository;

    public TratamientoService(TratamientoRepository tratamientoRepository) {
        this.tratamientoRepository = tratamientoRepository;
    }

    public List<Tratamiento> listar() {
        return tratamientoRepository.findAll();
    }

    public Optional<Tratamiento> buscarPorId(Long id) {
        return tratamientoRepository.findById(id);
    }
}