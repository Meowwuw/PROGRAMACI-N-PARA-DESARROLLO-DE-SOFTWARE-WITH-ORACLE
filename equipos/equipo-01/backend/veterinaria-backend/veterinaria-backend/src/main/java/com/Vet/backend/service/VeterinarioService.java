package com.Vet.backend.service;

import com.Vet.backend.model.Veterinario;
import com.Vet.backend.repository.VeterinarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VeterinarioService {

    @Autowired
    private VeterinarioRepository veterinarioRepository;

    public List<Veterinario> findAll() {
        return veterinarioRepository.findAll();
    }

    public Optional<Veterinario> findById(Integer id) {
        return veterinarioRepository.findById(id);
    }

    public Veterinario save(Veterinario veterinario) {
        return veterinarioRepository.save(veterinario);
    }

    public void deleteById(Integer id) {
        veterinarioRepository.deleteById(id);
    }

    public boolean existsById(Integer id) {
        return veterinarioRepository.existsById(id);
    }
}
