package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Reserva;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ReservaRepository extends JpaRepository<Reserva, Long> {

    // Listar reservas por fecha
    List<Reserva> findByFecha(LocalDate fecha);

    // Listar reservas por ID de cliente
    List<Reserva> findByClienteIdCliente(Long idCliente);

    // Listar reservas por ID de cancha
    List<Reserva> findByCanchaIdCancha(Long idCancha);

    // Eliminar todas las reservas de una fecha específica
    void deleteByFecha(LocalDate fecha);
}