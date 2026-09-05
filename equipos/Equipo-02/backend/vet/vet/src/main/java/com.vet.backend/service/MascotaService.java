package com.vet.backend.service;

import com.vet.backend.model.Mascota;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MascotaService {
    public List<Mascota> listar(){
        return List.of(
                new Mascota(1L, "Michi", "Gato", "Siamés", 2),
                new Mascota(2L, "Firulais", "Perro", "Labrador", 4),
                new Mascota(3L, "Kiwi", "Ave", "Periquito", 1)
        );
    }
}