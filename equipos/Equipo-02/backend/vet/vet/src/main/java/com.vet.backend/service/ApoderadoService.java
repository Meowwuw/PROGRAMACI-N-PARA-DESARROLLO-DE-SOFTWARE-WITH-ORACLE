package com.vet.backend.service;

import com.vet.backend.model.Apoderado;
import com.vet.backend.repository.ApoderadoRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ApoderadoService {

    private final ApoderadoRepository apoderadoRepository;

    public ApoderadoService(ApoderadoRepository apoderadoRepository) {
        this.apoderadoRepository = apoderadoRepository;
    }

    public List<Apoderado> listar() {
        return apoderadoRepository.findAll();
    }

    public Optional<Apoderado> buscarPorId(Long id) {
        return apoderadoRepository.findById(id);
    }
}