package com.Vet.backend.service;

import com.Vet.backend.model.Consulta;
import com.Vet.backend.repository.ConsultaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ConsultaService {

    @Autowired
    private ConsultaRepository consultaRepository;

    public List<Consulta> findAll() {
        return consultaRepository.findAll();
    }

    public Optional<Consulta> findById(Integer id) {
        return consultaRepository.findById(id);
    }

    public List<Consulta> findByMascota(Integer idMascota) {
        return consultaRepository.findByMascota_IdMascota(idMascota);
    }

    public List<Consulta> findByVeterinario(Integer idVeterinario) {
        return consultaRepository.findByVeterinario_IdVeterinario(idVeterinario);
    }

    public Consulta save(Consulta consulta) {
        return consultaRepository.save(consulta);
    }

    public void deleteById(Integer id) {
        consultaRepository.deleteById(id);
    }

    public boolean existsById(Integer id) {
        return consultaRepository.existsById(id);
    }
}
