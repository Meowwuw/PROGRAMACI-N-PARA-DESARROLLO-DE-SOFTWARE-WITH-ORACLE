package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Horario;
import com.canchavoley.backend.repository.HorarioRepository;
import org.springframework.stereotype.Service;

import java.time.LocalTime;
import java.util.List;

@Service
public class HorarioService {

    private final HorarioRepository horarioRepository;

    public HorarioService(HorarioRepository horarioRepository) {
        this.horarioRepository = horarioRepository;
    }

    // ---- GET ----
    public List<Horario> listar() {
        return horarioRepository.findAll();
    }

    public Horario buscarPorId(Integer id) {
        return horarioRepository.findById(id).orElse(null);
    }

    public Horario buscarPorHora(LocalTime hora) {
        return horarioRepository.findByHora(hora).orElse(null);
    }

    public List<Horario> listarConPrecioMaximo(double precio) {
        return horarioRepository.findByPrecioLessThanEqual(precio);
    }

    public List<Horario> listarOrdenadosPorPrecio() {
        return horarioRepository.findAllByOrderByPrecioAsc();
    }

    // ---- POST ----
    public Horario guardar(Horario horario) {
        return horarioRepository.save(horario);
    }

    public List<Horario> guardarVarios(List<Horario> horarios) {
        return horarioRepository.saveAll(horarios);
    }

    // ---- PUT ----
    public Horario actualizar(Integer id, Horario datos) {
        Horario existente = horarioRepository.findById(id).orElse(null);
        if (existente == null) return null;
        existente.setHora(datos.getHora());
        existente.setPrecio(datos.getPrecio());
        return horarioRepository.save(existente);
    }

    public Horario actualizarPrecio(Integer id, double precio) {
        Horario existente = horarioRepository.findById(id).orElse(null);
        if (existente == null) return null;
        existente.setPrecio(precio);
        return horarioRepository.save(existente);
    }

    // ---- DELETE ----
    public boolean eliminar(Integer id) {
        if (!horarioRepository.existsById(id)) return false;
        horarioRepository.deleteById(id);
        return true;
    }

    public void eliminarPorHora(LocalTime hora) {
        horarioRepository.deleteByHora(hora);
    }
}
