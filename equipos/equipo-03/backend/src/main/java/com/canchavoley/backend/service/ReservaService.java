package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Reserva;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ReservaService {
    private List<Reserva> reservas = new ArrayList<>();

    public List<Reserva> listar(){
        return List.of(
                new Reserva(1,123456,123,0001,"01/01/26"),
                new Reserva(2,654321,456,0002,"02/02/26"),
                new Reserva(3,162534,789,0003,"03/03/26")
        );
    }

    public void guardar(Reserva reserva){
        reservas.add(reserva);
    }

    public void eliminar(int id) {
        reservas.removeIf(reserva -> reserva.getId() == id);
    }
}
