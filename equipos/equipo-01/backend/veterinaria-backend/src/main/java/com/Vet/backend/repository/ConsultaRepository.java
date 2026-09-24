package com.Vet.backend.repository;

import com.Vet.backend.model.Consulta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ConsultaRepository extends JpaRepository<Consulta, Integer> {

    List<Consulta> findByMascota_IdMascota(Integer idMascota);

    List<Consulta> findByVeterinario_IdVeterinario(Integer idVeterinario);
}
