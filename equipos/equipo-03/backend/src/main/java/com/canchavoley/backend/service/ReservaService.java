package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Cancha;
import com.canchavoley.backend.model.Cliente;
import com.canchavoley.backend.model.Horario;
import com.canchavoley.backend.model.Reserva;
import com.canchavoley.backend.repository.CanchaRepository;
import com.canchavoley.backend.repository.ClienteRepository;
import com.canchavoley.backend.repository.HorarioRepository;
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

    @Autowired
    private ClienteRepository clienteRepository;

    @Autowired
    private CanchaRepository canchaRepository;

    @Autowired
    private HorarioRepository horarioRepository;

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

    // --- Resuelve las relaciones (cliente/cancha/horario) por su ID real ---
    private Reserva resolverRelaciones(Reserva reserva) {
        if (reserva.getCliente() != null && reserva.getCliente().getIdCliente() != null) {
            Cliente cliente = clienteRepository.findById(reserva.getCliente().getIdCliente())
                    .orElseThrow(() -> new RuntimeException("Cliente no encontrado con id: " + reserva.getCliente().getIdCliente()));
            reserva.setCliente(cliente);
        }
        if (reserva.getCancha() != null && reserva.getCancha().getIdCancha() != null) {
            Cancha cancha = canchaRepository.findById(reserva.getCancha().getIdCancha())
                    .orElseThrow(() -> new RuntimeException("Cancha no encontrada con id: " + reserva.getCancha().getIdCancha()));
            reserva.setCancha(cancha);
        }
        if (reserva.getHorario() != null && reserva.getHorario().getIdHorario() != null) {
            Horario horario = horarioRepository.findById(reserva.getHorario().getIdHorario())
                    .orElseThrow(() -> new RuntimeException("Horario no encontrado con id: " + reserva.getHorario().getIdHorario()));
            reserva.setHorario(horario);
        }
        return reserva;
    }

    // --- POSTs ---
    public Reserva guardar(Reserva reserva) {
        return reservaRepository.save(resolverRelaciones(reserva));
    }

    public List<Reserva> guardarVarias(List<Reserva> reservas) {
        reservas.forEach(this::resolverRelaciones);
        return reservaRepository.saveAll(reservas);
    }

    // --- PUTs ---
    public Reserva actualizar(Long id, Reserva detalles) {
        Reserva reserva = reservaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Reserva no encontrada con id: " + id));
        Reserva detallesResueltos = resolverRelaciones(detalles);
        reserva.setCliente(detallesResueltos.getCliente());
        reserva.setCancha(detallesResueltos.getCancha());
        reserva.setHorario(detallesResueltos.getHorario());
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