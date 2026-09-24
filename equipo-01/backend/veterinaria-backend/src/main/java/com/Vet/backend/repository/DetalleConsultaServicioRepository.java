package com.Vet.backend.repository;

import com.Vet.backend.model.DetalleConsultaServicio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DetalleConsultaServicioRepository extends JpaRepository<DetalleConsultaServicio, Integer> {

    List<DetalleConsultaServicio> findByConsulta_IdConsulta(Integer idConsulta);
}
