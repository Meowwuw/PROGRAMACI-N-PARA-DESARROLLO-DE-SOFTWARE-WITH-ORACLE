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

    public Reserva actualizar(Integer id, Reserva datos) {
        Reserva reserva = reservaRepository.findById(id)
                .orElse(null);

        if (reserva == null) {
            return null;
        }

        reserva.setId(datos.getId());
        reserva.setCancha(datos.getCancha());
        reserva.setCliente(datos.getCliente());
        reserva.setMetodoPago(datos.getMetodoPago());
        reserva.setFecha(datos.getFecha());
        reserva.setHoraInicio(datos.getHoraInicio());
        reserva.setHoraFin(datos.getHoraFin());
        reserva.setTotal(datos.getTotal());
        reserva.setEstado(datos.getEstado());

        return reservaRepository.save(reserva);
    }

    public void eliminar(Integer id) {
        reservaRepository.deleteById(id);
    }
}