package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Reserva;
import com.canchavoley.backend.repository.ReservaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReservaService {

    private final ReservaRepository reservaRepository;

    public ReservaService(ReservaRepository reservaRepository) {
        this.reservaRepository = reservaRepository;
    }

    public List<Reserva> listar() {
        return reservaRepository.findAll();
    }

    public Reserva buscarPorId(Integer id) {
        return reservaRepository.findById(id).orElse(null);
    }

    public List<Reserva> buscarPorCliente(int idCliente) {
        return reservaRepository.findByIdCliente(idCliente);
    }

    public List<Reserva> buscarPorFecha(String fecha) {
        return reservaRepository.findByFecha(fecha);
    }

    public List<Reserva> buscarPorCancha(int idCancha) {
        return reservaRepository.findByIdCancha(idCancha);
    }

    public Reserva guardar(Reserva reserva) {
        return reservaRepository.save(reserva);
    }

    public List<Reserva> guardarVarias(List<Reserva> reservas) {
        return reservaRepository.saveAll(reservas);
    }

    public Reserva actualizar(Integer id, Reserva reservaDetalles) {
        Optional<Reserva> opt = reservaRepository.findById(id);
        if (opt.isPresent()) {
            Reserva r = opt.get();
            r.setIdCliente(reservaDetalles.getIdCliente());
            r.setIdCancha(reservaDetalles.getIdCancha());
            r.setIdHorario(reservaDetalles.getIdHorario());
            r.setHorasAlquilado(reservaDetalles.getHorasAlquilado());
            r.setFecha(reservaDetalles.getFecha());
            return reservaRepository.save(r);
        }
        return null;
    }

    public Reserva actualizarFecha(Integer id, String fecha) {
        Optional<Reserva> opt = reservaRepository.findById(id);
        if (opt.isPresent()) {
            Reserva r = opt.get();
            r.setFecha(fecha);
            return reservaRepository.save(r);
        }
        return null;
    }

    public void eliminar(Integer id) {
        reservaRepository.deleteById(id);
    }

    public void eliminarPorCliente(int idCliente) {
        reservaRepository.deleteByIdCliente(idCliente);
    }
}