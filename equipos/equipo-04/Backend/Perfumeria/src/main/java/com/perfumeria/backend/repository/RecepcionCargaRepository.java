package com.perfumeria.backend.repository;

import com.perfumeria.backend.model.RecepcionCarga;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RecepcionCargaRepository extends JpaRepository<RecepcionCarga, Long> {
}
