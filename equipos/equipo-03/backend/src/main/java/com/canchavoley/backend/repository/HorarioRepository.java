package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Horario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface HorarioRepository extends JpaRepository<Horario, Long> {

    // Buscar por hora exacta
    Optional<Horario> findByHora(LocalTime hora);

    // Listar horarios con precio menor o igual a un monto
    List<Horario> findByPrecioLessThanEqual(BigDecimal precioMaximo);

    // Verificar si existe un horario por su hora
    boolean existsByHora(LocalTime hora);

    // Eliminar por hora exacta
    void deleteByHora(LocalTime hora);
}