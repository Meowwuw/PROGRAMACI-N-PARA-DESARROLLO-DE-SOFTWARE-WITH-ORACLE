package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Pago;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Optional;

@Repository
public interface PagoRepository extends JpaRepository<Pago, Long> {

    // Buscar pago asociado a una reserva específica
    Optional<Pago> findByReservaIdReserva(Long idReserva);

    // Calcular la recaudación total acumulada
    @Query("SELECT SUM(p.total) FROM Pago p")
    BigDecimal sumarTotalPagos();

    // Eliminar pago asociado a una reserva específica
    void deleteByReservaIdReserva(Long idReserva);
}