package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Reserva;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReservaRepository extends JpaRepository<Reserva, Integer> {

    List<Reserva> findByIdCliente(int idCliente);

    List<Reserva> findByFecha(String fecha);

    List<Reserva> findByIdCancha(int idCancha);

    void deleteByIdCliente(int idCliente);
}