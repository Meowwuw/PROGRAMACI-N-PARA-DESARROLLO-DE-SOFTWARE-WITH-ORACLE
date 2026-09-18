package com.perfumeria.backend.service;

import com.perfumeria.backend.model.Marca;
import com.perfumeria.backend.repository.MarcaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MarcaService {

    @Autowired
    private MarcaRepository marcaRepository;

    public List<Marca> listarTodas() {
        return marcaRepository.findAll();
    }

    public Optional<Marca> buscarPorId(Long id) {
        return marcaRepository.findById(id);
    }

    public Marca guardar(Marca marca) {
        return marcaRepository.save(marca);
    }

    public Marca actualizar(Long id, Marca marcaActualizada) {
        return marcaRepository.findById(id)
                .map(marca -> {
                    marca.setNombre(marcaActualizada.getNombre());
                    marca.setPaisOrigen(marcaActualizada.getPaisOrigen());
                    marca.setDescripcion(marcaActualizada.getDescripcion());
                    return marcaRepository.save(marca);
                })
                .orElse(null);
    }

    public boolean eliminar(Long id) {
        if (marcaRepository.existsById(id)) {
            marcaRepository.deleteById(id);
            return true;
        }
        return false;
    }
}