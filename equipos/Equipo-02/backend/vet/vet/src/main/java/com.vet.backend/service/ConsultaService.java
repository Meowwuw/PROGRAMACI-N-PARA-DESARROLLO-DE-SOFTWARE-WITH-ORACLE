package com.vet.backend.service;

import com.vet.backend.model.Consulta;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConsultaService {
    public List<Consulta> listar(){
        return List.of(
                new Consulta(1L, "Control anual", "2026-01-15", "Estado saludable"),
                new Consulta(2L, "Vómitos", "2026-02-20", "Gastritis leve"),
                new Consulta(3L, "Cojera", "2026-03-10", "Esguince en pata trasera")
        );
    }
}