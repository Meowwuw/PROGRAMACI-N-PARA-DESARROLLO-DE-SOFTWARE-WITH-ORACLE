package com.vet.backend.repository;

import com.vet.backend.model.Consulta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ConsultaRepository extends JpaRepository<Consulta, Long> {

    List<Consulta> findByMascotaId(Long idMascota);

    List<Consulta> findByVeterinarioId(Long idVeterinario);

    List<Consulta> findByFechaConBetween(LocalDateTime inicio, LocalDateTime fin);

    void deleteByMascotaId(Long idMascota);
}