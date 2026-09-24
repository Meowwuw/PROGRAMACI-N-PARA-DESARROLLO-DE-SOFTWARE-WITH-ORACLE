package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Horario;
import com.canchavoley.backend.repository.HorarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Service
public class HorarioService {

    @Autowired
    private HorarioRepository horarioRepository;

    // --- GETs ---
    public List<Horario> obtenerTodos() {
        return horarioRepository.findAll();
    }

    public Optional<Horario> obtenerPorId(Long id) {
        return horarioRepository.findById(id);
    }

    public Optional<Horario> obtenerPorHora(LocalTime hora) {
        return horarioRepository.findByHora(hora);
    }

    public List<Horario> obtenerPorPrecioMaximo(BigDecimal precioMax) {
        return horarioRepository.findByPrecioLessThanEqual(precioMax);
    }

    public long contarTodos() {
        return horarioRepository.count();
    }

    // --- POSTs ---
    public Horario guardar(Horario horario) {
        return horarioRepository.save(horario);
    }

    public List<Horario> guardarVarios(List<Horario> horarios) {
        return horarioRepository.saveAll(horarios);
    }

    // --- PUTs ---
    public Horario actualizar(Long id, Horario detalles) {
        Horario horario = horarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Horario no encontrado con id: " + id));
        horario.setHora(detalles.getHora());
        horario.setPrecio(detalles.getPrecio());
        return horarioRepository.save(horario);
    }

    public Horario actualizarPrecio(Long id, BigDecimal nuevoPrecio) {
        Horario horario = horarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Horario no encontrado con id: " + id));
        horario.setPrecio(nuevoPrecio);
        return horarioRepository.save(horario);
    }

    // --- DELETEs ---
    public void eliminarPorId(Long id) {
        horarioRepository.deleteById(id);
    }

    @Transactional
    public void eliminarPorHora(LocalTime hora) {
        horarioRepository.deleteByHora(hora);
    }
}