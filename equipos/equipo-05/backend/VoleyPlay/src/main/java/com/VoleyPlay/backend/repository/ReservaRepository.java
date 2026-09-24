package com.VoleyPlay.backend.repository;

import com.VoleyPlay.backend.model.Reserva;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservaRepository extends JpaRepository<Reserva, Long> {
}