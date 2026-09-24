package com.vet.backend.service;

import com.vet.backend.model.Apoderado;
import com.vet.backend.model.Consulta;
import com.vet.backend.model.Mascota;
import com.vet.backend.model.Veterinario;
import com.vet.backend.repository.ConsultaRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ConsultaService {

    private final ConsultaRepository consultaRepository;

    public ConsultaService(ConsultaRepository consultaRepository) {
        this.consultaRepository = consultaRepository;
    }

    public List<Consulta> listar() {
        return consultaRepository.findAll();
    }

    public Optional<Consulta> buscarPorId(Long id) {
        return consultaRepository.findById(id);
    }

    public List<Consulta> listarPorMascota(Long idMascota) {
        return consultaRepository.findByMascotaId(idMascota);
    }

    public List<Consulta> listarPorVeterinario(Long idVeterinario) {
        return consultaRepository.findByVeterinarioId(idVeterinario);
    }

    public List<Consulta> listarPorRangoFecha(LocalDateTime inicio, LocalDateTime fin) {
        return consultaRepository.findByFechaConBetween(inicio, fin);
    }

    public Consulta guardar(Consulta consulta) {
        return consultaRepository.save(consulta);
    }

    public Consulta guardarRapida(LocalDateTime fecha, Apoderado apoderado, Veterinario veterinario, Mascota mascota) {
        Consulta consulta = new Consulta(fecha, apoderado, veterinario, mascota);
        return consultaRepository.save(consulta);
    }

    public Optional<Consulta> actualizar(Long id, Consulta datos) {
        return consultaRepository.findById(id).map(consulta -> {
            consulta.setFechaCon(datos.getFechaCon());
            consulta.setApoderado(datos.getApoderado());
            consulta.setVeterinario(datos.getVeterinario());
            consulta.setMascota(datos.getMascota());
            return consultaRepository.save(consulta);
        });
    }

    public Optional<Consulta> reprogramar(Long id, LocalDateTime nuevaFecha) {
        return consultaRepository.findById(id).map(consulta -> {
            consulta.setFechaCon(nuevaFecha);
            return consultaRepository.save(consulta);
        });
    }

    public boolean eliminar(Long id) {
        if (consultaRepository.existsById(id)) {
            consultaRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public void eliminarPorMascota(Long idMascota) {
        consultaRepository.deleteByMascotaId(idMascota);
    }
}