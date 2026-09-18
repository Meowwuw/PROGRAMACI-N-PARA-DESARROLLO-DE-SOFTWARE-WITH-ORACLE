package com.Vet.backend.service;

import com.Vet.backend.model.Mascota;
import com.Vet.backend.repository.MascotaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MascotaService {

    @Autowired
    private MascotaRepository mascotaRepository;

    public List<Mascota> findAll() {
        return mascotaRepository.findAll();
    }

    public Optional<Mascota> findById(Integer id) {
        return mascotaRepository.findById(id);
    }

    public List<Mascota> findByDueno(Integer idDueno) {
        return mascotaRepository.findByDueno_IdDueno(idDueno);
    }

    public Mascota save(Mascota mascota) {
        return mascotaRepository.save(mascota);
    }

    public void deleteById(Integer id) {
        mascotaRepository.deleteById(id);
    }

    public boolean existsById(Integer id) {
        return mascotaRepository.existsById(id);
    }
}
