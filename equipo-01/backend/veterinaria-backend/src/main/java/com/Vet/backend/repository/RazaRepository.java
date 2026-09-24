package com.Vet.backend.repository;

import com.Vet.backend.model.Raza;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RazaRepository extends JpaRepository<Raza, Integer> {

    List<Raza> findByEspecie_IdEspecie(Integer idEspecie);
}
