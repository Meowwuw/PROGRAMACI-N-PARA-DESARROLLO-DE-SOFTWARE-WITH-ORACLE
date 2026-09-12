package com.veterinaria_xime.backend.repository;

import com.veterinaria_xime.backend.model.Mascota;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MascotaRepository
    extends JpaRepository <Mascota, Long> {
}

