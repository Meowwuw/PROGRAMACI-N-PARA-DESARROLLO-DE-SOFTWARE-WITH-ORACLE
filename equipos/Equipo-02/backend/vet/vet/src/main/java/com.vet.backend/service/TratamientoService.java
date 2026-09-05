package com.vet.backend.service;

import com.vet.backend.model.Tratamiento;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TratamientoService {
    public List<Tratamiento> listar(){
        return List.of(
                new Tratamiento(1L, "Vacunación", "Aplicación de vacuna antirrábica", 45.00),
                new Tratamiento(2L, "Desparasitación", "Tratamiento antiparasitario interno", 30.00),
                new Tratamiento(3L, "Baño medicado", "Baño con shampoo dermatológico", 25.00)
        );
    }
}