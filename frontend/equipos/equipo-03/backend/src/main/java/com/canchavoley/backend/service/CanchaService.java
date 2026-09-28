package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Cancha;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CanchaService {

    public List<Cancha> listar() {
        return List.of(
                new Cancha(1L, 1),
                new Cancha(2L, 2),
                new Cancha(3L, 3)
        );
    }
}