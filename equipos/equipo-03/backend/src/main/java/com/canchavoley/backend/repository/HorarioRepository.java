package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Horario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HorarioRepository extends JpaRepository<Horario, Integer> {
}