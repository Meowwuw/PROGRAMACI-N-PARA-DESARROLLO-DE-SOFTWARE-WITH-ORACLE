package com.veterinaria_xime.backend.repository;

import com.veterinaria_xime.backend.model.Dueno;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DuenoRepository
    extends JpaRepository<Dueno, Long> {
}

