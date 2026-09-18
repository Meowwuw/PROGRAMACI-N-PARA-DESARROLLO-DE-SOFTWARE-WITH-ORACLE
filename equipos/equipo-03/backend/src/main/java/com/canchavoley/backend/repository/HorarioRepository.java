package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Horario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

public interface HorarioRepository extends JpaRepository<Horario, Integer> {

    Optional<Horario> findByHora(LocalTime hora);

    List<Horario> findByPrecioLessThanEqual(double precio);

    List<Horario> findAllByOrderByPrecioAsc();

    void deleteByHora(LocalTime hora);
}
