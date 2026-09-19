package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Cancha;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CanchaRepository extends JpaRepository<Cancha, Long> {

    // Método para buscar cancha por su número (GET 3)
    Optional<Cancha> findByNumeroCancha(Integer numeroCancha);

    // Método para verificar existencia por número
    boolean existsByNumeroCancha(Integer numeroCancha);

    // Método para eliminar por número (DELETE 2)
    void deleteByNumeroCancha(Integer numeroCancha);
}