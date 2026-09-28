package com.serviciocancha.service;

import com.serviciocancha.model.Reserva;
import com.serviciocancha.repository.ReservaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservaService {

    @Autowired
    private ReservaRepository reservaRepository;

    public List<Reserva> listar() {
        return reservaRepository.findAll();
    }

    public Reserva buscarPorId(Integer id) {
        return reservaRepository.findById(id).orElse(null);
    }

    public Reserva guardar(Reserva reserva) {
        return reservaRepository.save(reserva);
    }
}