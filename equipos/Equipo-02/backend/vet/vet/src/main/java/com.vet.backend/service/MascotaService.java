package com.vet.backend.service;

import com.vet.backend.model.Mascota;
import com.vet.backend.repository.MascotaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional; // Necesario para que funcione con tu Controller

@Service
public class MascotaService {

    @Autowired
    private MascotaRepository mascotaRepository;

    // Conecta con tu listar() del Controller
    public List<Mascota> listar() {
        return mascotaRepository.findAll();
    }

    // Devuelve un Optional para que funcione tu ResponseEntity con .map() y .orElse()
    public Optional<Mascota> buscarPorId(Long id) {
        return mascotaRepository.findById(id);
    }

    // Guardar
    public Mascota guardar(Mascota mascota) {
        return mascotaRepository.save(mascota);
    }

    // Eliminar
    public void eliminar(Long id) {
        mascotaRepository.deleteById(id);
    }
}