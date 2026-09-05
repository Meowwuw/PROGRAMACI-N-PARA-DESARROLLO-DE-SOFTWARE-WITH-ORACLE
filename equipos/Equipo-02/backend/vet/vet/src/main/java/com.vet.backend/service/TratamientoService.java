package com.vet.backend.service;

import com.vet.backend.model.Tratamiento;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TratamientoService {

    public List<Tratamiento> listarTratamientos() {

        List<Tratamiento> tratamientos = new ArrayList<>();

        tratamientos.add(new Tratamiento(
                1L,
                "Vacunación",
                "Vacunación preventiva para perros y gatos",
                50.0
        ));

        tratamientos.add(new Tratamiento(
                2L,
                "Desparasitación",
                "Tratamiento para eliminar parásitos internos y externos",
                35.0
        ));

        tratamientos.add(new Tratamiento(
                3L,
                "Limpieza dental",
                "Limpieza y cuidado dental de la mascota",
                80.0
        ));

        tratamientos.add(new Tratamiento(
                4L,
                "Curación de heridas",
                "Limpieza y tratamiento de heridas en mascotas",
                45.0
        ));

        return tratamientos;
    }
}