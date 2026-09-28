package com.VoleyPlay.backend.repository;

import com.VoleyPlay.backend.model.Cancha;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CanchaRepository extends JpaRepository<Cancha, Long> {
}