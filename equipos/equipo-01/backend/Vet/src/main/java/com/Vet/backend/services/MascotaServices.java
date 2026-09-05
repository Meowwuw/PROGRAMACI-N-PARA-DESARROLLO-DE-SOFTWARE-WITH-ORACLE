package com.Vet.backend.services;

import com.Vet.backend.model.Mascota;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class MascotaServices {

    public List<Mascota> listar(){
        return List.of(
                new Mascota(1L, 1L, "Rocky", 1L, LocalDate.of(2021, 3, 10)),
                new Mascota(2L, 2L, "Michi", 3L, LocalDate.of(2022, 7, 22)),
                new Mascota(3L, 3L, "Firulais", 2L, LocalDate.of(2020, 11, 5))
        );
    }
}
