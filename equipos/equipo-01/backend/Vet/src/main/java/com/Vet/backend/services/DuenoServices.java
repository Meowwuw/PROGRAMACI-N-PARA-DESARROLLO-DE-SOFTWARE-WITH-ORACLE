package com.Vet.backend.services;

import com.Vet.backend.model.Dueno;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DuenoServices {

    public List<Dueno> listar(){
        return List.of(
                new Dueno(1L, "Maria Perez", "987654321", "Av. Los Olivos 123"),
                new Dueno(2L, "Juan Torres", "912345678", "Jr. Las Flores 456"),
                new Dueno(3L, "Ana Rojas", "923456789", "Calle Lima 789")
        );
    }
}
