package com.vet.backend.service;

import com.vet.backend.model.Apoderado;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApoderadoService {
    public List<Apoderado> listar(){
        return List.of(
                new Apoderado(1L, "Carlos Ramírez", "987654321", "Av. Los Álamos 123"),
                new Apoderado(2L, "María Torres", "912345678", "Jr. Las Flores 456"),
                new Apoderado(3L, "Luis Vargas", "998877665", "Calle San Martín 789")
        );
    }
}