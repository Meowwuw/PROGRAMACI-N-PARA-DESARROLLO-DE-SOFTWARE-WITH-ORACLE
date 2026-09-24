package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Reserva;
import com.VoleyPlay.backend.repository.ReservaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservaService {
    private final ReservaRepository reservaRepository;

    public ReservaService(ReservaRepository reservaRepository) {
        this.reservaRepository = reservaRepository;
    }

    public List<Reserva> listar() {
        return reservaRepository.findAll();
    }

    public Reserva buscarPorId(Long id) {
        return reservaRepository.findById(id)
                .orElse(null);
    }

    public Reserva guardar(Reserva reserva) {
        return reservaRepository.save(reserva);
    }

    public Reserva actualizar(Long id, Reserva datos) {
        Reserva reserva = reservaRepository.findById(id)
                .orElse(null);

        if (reserva == null) {
            return null;
        }

        reserva.setIdCliente(datos.getIdCliente());
        reserva.setIdCancha(datos.getIdCancha());
        reserva.setIdHorario(datos.getIdHorario());
        reserva.setFechaReserva(datos.getFechaReserva());
        reserva.setEstado(datos.getEstado());
        reserva.setTotal(datos.getTotal());

        return reservaRepository.save(reserva);
    }

    public void eliminar(Long id) {
        reservaRepository.deleteById(id);
    }
}