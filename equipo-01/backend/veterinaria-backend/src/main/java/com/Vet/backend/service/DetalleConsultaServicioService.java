package com.Vet.backend.service;

import com.Vet.backend.model.DetalleConsultaServicio;
import com.Vet.backend.repository.DetalleConsultaServicioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DetalleConsultaServicioService {

    @Autowired
    private DetalleConsultaServicioRepository detalleConsultaServicioRepository;

    public List<DetalleConsultaServicio> findAll() {
        return detalleConsultaServicioRepository.findAll();
    }

    public Optional<DetalleConsultaServicio> findById(Integer id) {
        return detalleConsultaServicioRepository.findById(id);
    }

    public List<DetalleConsultaServicio> findByConsulta(Integer idConsulta) {
        return detalleConsultaServicioRepository.findByConsulta_IdConsulta(idConsulta);
    }

    public DetalleConsultaServicio save(DetalleConsultaServicio detalle) {
        return detalleConsultaServicioRepository.save(detalle);
    }

    public void deleteById(Integer id) {
        detalleConsultaServicioRepository.deleteById(id);
    }

    public boolean existsById(Integer id) {
        return detalleConsultaServicioRepository.existsById(id);
    }
}
