package com.serviciocancha.service;

import com.serviciocancha.model.Cancha;
import com.serviciocancha.model.Cliente;
import com.serviciocancha.repository.CanchaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class CanchaService {

    @Autowired
    private CanchaRepository canchaRepository;

    public List<Cancha> listar() {
        return canchaRepository.findAll();
    }

    public Cancha buscarPorId(Integer id) {
        return canchaRepository.findById(id).orElse(null);
    }

    public Cancha guardar(Cancha cancha) {
        return canchaRepository.save(cancha);
    }

    public Cancha actualizar(Integer id, Cancha datos) {
        Cancha cancha = canchaRepository.findById(id)
                .orElse(null);

        if (cancha == null) {
            return null;
        }

        // Seteo de los atributos mapeados
        cancha.setNombre(datos.getNombre());
        cancha.setTipoDeporte(datos.getTipoDeporte());
        cancha.setPrecioPorHora(datos.getPrecioPorHora());
        cancha.setEstado(datos.getEstado());

        // Guarda los cambios y devuelve la entidad actualizada
        return canchaRepository.save(cancha);
    }
    public void eliminar(Integer id) {
        canchaRepository.deleteById(id);
    }
}
