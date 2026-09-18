package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Cancha;
import com.canchavoley.backend.repository.CanchaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CanchaService {

    private final CanchaRepository canchaRepository;

    public CanchaService(CanchaRepository canchaRepository) {
        this.canchaRepository = canchaRepository;
    }

    // ---- GET ----
    public List<Cancha> listar() {
        return canchaRepository.findAll();
    }

    public Cancha buscarPorId(Integer id) {
        return canchaRepository.findById(id).orElse(null);
    }

    public Cancha buscarPorNumero(int numeroCancha) {
        return canchaRepository.findByNumeroCancha(numeroCancha).orElse(null);
    }

    public List<Cancha> listarOrdenadasPorNumero() {
        return canchaRepository.findAllByOrderByNumeroCanchaAsc();
    }

    public List<Cancha> listarDesdeNumero(int numeroCancha) {
        return canchaRepository.findByNumeroCanchaGreaterThanEqual(numeroCancha);
    }

    // ---- POST ----
    public Cancha guardar(Cancha cancha) {
        return canchaRepository.save(cancha);
    }

    public List<Cancha> guardarVarias(List<Cancha> canchas) {
        return canchaRepository.saveAll(canchas);
    }

    // ---- PUT ----
    public Cancha actualizar(Integer id, Cancha datos) {
        Cancha existente = canchaRepository.findById(id).orElse(null);
        if (existente == null) return null;
        existente.setNumeroCancha(datos.getNumeroCancha());
        return canchaRepository.save(existente);
    }

    public Cancha actualizarNumero(Integer id, int numeroCancha) {
        Cancha existente = canchaRepository.findById(id).orElse(null);
        if (existente == null) return null;
        existente.setNumeroCancha(numeroCancha);
        return canchaRepository.save(existente);
    }

    // ---- DELETE ----
    public boolean eliminar(Integer id) {
        if (!canchaRepository.existsById(id)) return false;
        canchaRepository.deleteById(id);
        return true;
    }

    public void eliminarPorNumero(int numeroCancha) {
        canchaRepository.deleteByNumeroCancha(numeroCancha);
    }
}
