package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Cancha;
import com.canchavoley.backend.repository.CanchaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class CanchaService {

    @Autowired
    private CanchaRepository canchaRepository;

    // --- GETs ---
    public List<Cancha> obtenerTodas() {
        return canchaRepository.findAll();
    }

    public Optional<Cancha> obtenerPorId(Long id) {
        return canchaRepository.findById(id);
    }

    public Optional<Cancha> obtenerPorNumero(Integer numero) {
        return canchaRepository.findByNumeroCancha(numero);
    }

    public long contarTodas() {
        return canchaRepository.count();
    }

    public boolean existePorNumero(Integer numero) {
        return canchaRepository.existsByNumeroCancha(numero);
    }

    // --- POSTs ---
    public Cancha guardar(Cancha cancha) {
        return canchaRepository.save(cancha);
    }

    public List<Cancha> guardarVarias(List<Cancha> canchas) {
        return canchaRepository.saveAll(canchas);
    }

    // --- PUTs ---
    public Cancha actualizar(Long id, Cancha canchaDetalles) {
        Cancha cancha = canchaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cancha no encontrada con id: " + id));
        cancha.setNumeroCancha(canchaDetalles.getNumeroCancha());
        return canchaRepository.save(cancha);
    }

    public Cancha actualizarNumero(Long id, Integer nuevoNumero) {
        Cancha cancha = canchaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cancha no encontrada con id: " + id));
        cancha.setNumeroCancha(nuevoNumero);
        return canchaRepository.save(cancha);
    }

    // --- DELETEs ---
    public void eliminarPorId(Long id) {
        canchaRepository.deleteById(id);
    }

    @Transactional
    public void eliminarPorNumero(Integer numero) {
        canchaRepository.deleteByNumeroCancha(numero);
    }
}