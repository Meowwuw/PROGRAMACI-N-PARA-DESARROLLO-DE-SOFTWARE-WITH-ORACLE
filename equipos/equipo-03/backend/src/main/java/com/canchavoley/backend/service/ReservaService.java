package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Reserva;
import com.canchavoley.backend.repository.ReservaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class ReservaService {

    @Autowired
    private ReservaRepository reservaRepository;

    // --- GETs ---
    public List<Reserva> obtenerTodas() {
        return reservaRepository.findAll();
    }

    public Optional<Reserva> obtenerPorId(Long id) {
        return reservaRepository.findById(id);
    }

    public List<Reserva> obtenerPorFecha(LocalDate fecha) {
        return reservaRepository.findByFecha(fecha);
    }

    public List<Reserva> obtenerPorCliente(Long idCliente) {
        return reservaRepository.findByClienteIdCliente(idCliente);
    }

    public long contarTodas() {
        return reservaRepository.count();
    }

    // --- POSTs ---
    public Reserva guardar(Reserva reserva) {
        return reservaRepository.save(reserva);
    }

    public List<Reserva> guardarVarias(List<Reserva> reservas) {
        return reservaRepository.saveAll(reservas);
    }

    // --- PUTs ---
    public Reserva actualizar(Long id, Reserva detalles) {
        Reserva reserva = reservaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Reserva no encontrada con id: " + id));
        reserva.setCliente(detalles.getCliente());
        reserva.setCancha(detalles.getCancha());
        reserva.setHorario(detalles.getHorario());
        reserva.setFecha(detalles.getFecha());
        return reservaRepository.save(reserva);
    }

    public Reserva actualizarFecha(Long id, LocalDate nuevaFecha) {
        Reserva reserva = reservaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Reserva no encontrada con id: " + id));
        reserva.setFecha(nuevaFecha);
        return reservaRepository.save(reserva);
    }

    // --- DELETEs ---
    public void eliminarPorId(Long id) {
        reservaRepository.deleteById(id);
    }

    @Transactional
    public void eliminarPorFecha(LocalDate fecha) {
        reservaRepository.deleteByFecha(fecha);
    }
}