package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Pago;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PagoRepository extends JpaRepository<Pago, Long> {

    List<Pago> findByIdReserva(Long idReserva);

    List<Pago> findByTotalGreaterThanEqual(Double total);

    void deleteByIdReserva(Long idReserva);
}
