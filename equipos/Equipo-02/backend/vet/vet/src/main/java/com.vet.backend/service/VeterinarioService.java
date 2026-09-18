package com.vet.backend.service;

import com.vet.backend.model.Veterinario;
import com.vet.backend.repository.VeterinarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VeterinarioService {

    @Autowired
    private VeterinarioRepository veterinarioRepository;

    public List<Veterinario> listarTodos() {
        return veterinarioRepository.findAll();
    }

    public Veterinario buscarPorId(Long id) {
        return veterinarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Veterinario no encontrado con id: " + id));
    }

    public Veterinario agregar(Veterinario veterinario) {
        return veterinarioRepository.save(veterinario);
    }

    public void eliminar(Long id) {
        veterinarioRepository.deleteById(id);
    }
}