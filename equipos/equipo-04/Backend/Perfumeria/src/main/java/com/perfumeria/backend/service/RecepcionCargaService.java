package com.perfumeria.backend.service;

import com.perfumeria.backend.model.RecepcionCarga;
import com.perfumeria.backend.repository.RecepcionCargaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RecepcionCargaService {

    @Autowired
    private RecepcionCargaRepository recepcionCargaRepository;

    public List<RecepcionCarga> listarTodas() {
        return recepcionCargaRepository.findAll();
    }

    public Optional<RecepcionCarga> buscarPorId(Long id) {
        return recepcionCargaRepository.findById(id);
    }

    public RecepcionCarga guardar(RecepcionCarga recepcion) {
        return recepcionCargaRepository.save(recepcion);
    }

    public RecepcionCarga actualizar(Long id, RecepcionCarga actualizada) {
        return recepcionCargaRepository.findById(id)
                .map(r -> {
                    r.setIdPerfume(actualizada.getIdPerfume());
                    r.setNumeroLote(actualizada.getNumeroLote());
                    r.setCantidadRecibida(actualizada.getCantidadRecibida());
                    r.setFechaRecepcion(actualizada.getFechaRecepcion());
                    return recepcionCargaRepository.save(r);
                })
                .orElse(null);
    }

    public boolean eliminar(Long id) {
        if (recepcionCargaRepository.existsById(id)) {
            recepcionCargaRepository.deleteById(id);
            return true;
        }
        return false;
    }
}
