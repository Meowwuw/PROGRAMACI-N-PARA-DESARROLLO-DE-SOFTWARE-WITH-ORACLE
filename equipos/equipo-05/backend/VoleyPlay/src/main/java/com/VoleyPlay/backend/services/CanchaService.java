package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Cancha;
import com.VoleyPlay.backend.repository.CanchaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CanchaService {
    private final CanchaRepository canchaRepository;

    public CanchaService(CanchaRepository canchaRepository) {
        this.canchaRepository = canchaRepository;
    }

    public List<Cancha> listar() {
        return canchaRepository.findAll();
    }

    public Cancha buscarPorId(Long id) {
        return canchaRepository.findById(id)
                .orElse(null);
    }

    public Cancha guardar(Cancha cancha) {
        return canchaRepository.save(cancha);
    }

    public Cancha actualizar(Long id, Cancha datos) {
        Cancha cancha = canchaRepository.findById(id)
                .orElse(null);

        if (cancha == null) {
            return null;
        }

        cancha.setNumero(datos.getNumero());
        cancha.setNombre(datos.getNombre());
        cancha.setTipoSuperficie(datos.getTipoSuperficie());
        cancha.setEstado(datos.getEstado());

        return canchaRepository.save(cancha);
    }

    public void eliminar(Long id) {
        canchaRepository.deleteById(id);
    }
}