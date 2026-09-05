package com.proyectoweb.backed.service;

import com.proyectoweb.backed.model.Cancha;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CanchaService {

    private final List<Cancha> listaCanchas = new ArrayList<>(List.of(
            new Cancha(1L, 1, "Cancha Principal", "Arena", "Disponible"),
            new Cancha(2L, 2, "Cancha Sintética 1", "Gras Sintético", "Disponible"),
            new Cancha(3L, 3, "Cancha Auxiliar", "Arena", "Ocupado")
    ));

    public List<Cancha> obtenerTodasLasCanchas() {
        return listaCanchas;
    }

    public Cancha buscarPorId(Long id) {
        return listaCanchas.stream()
                .filter(c -> c.getIdCancha().equals(id))
                .findFirst()
                .orElse(null);
    }

    public Cancha guardarCancha(Cancha cancha) {
        if (cancha.getTipoSuperficie() == null) {
            cancha.setTipoSuperficie("Arena");
        }
        if (cancha.getEstado() == null) {
            cancha.setEstado("Disponible");
        }

        listaCanchas.add(cancha);
        return cancha;
    }
}