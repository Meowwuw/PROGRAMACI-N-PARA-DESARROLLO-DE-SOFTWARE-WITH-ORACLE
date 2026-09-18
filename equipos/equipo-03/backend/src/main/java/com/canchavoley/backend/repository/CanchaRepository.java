package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Cancha;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CanchaRepository extends JpaRepository<Cancha, Integer> {

    Optional<Cancha> findByNumeroCancha(int numeroCancha);

    List<Cancha> findAllByOrderByNumeroCanchaAsc();

    List<Cancha> findByNumeroCanchaGreaterThanEqual(int numeroCancha);

    void deleteByNumeroCancha(int numeroCancha);
}
