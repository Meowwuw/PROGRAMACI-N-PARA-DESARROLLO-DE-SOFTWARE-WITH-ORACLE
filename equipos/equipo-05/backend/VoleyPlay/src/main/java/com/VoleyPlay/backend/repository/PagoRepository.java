package com.VoleyPlay.backend.repository;
import com.VoleyPlay.backend.model.Pago;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PagoRepository
        extends JpaRepository <Pago, Long> {
}
