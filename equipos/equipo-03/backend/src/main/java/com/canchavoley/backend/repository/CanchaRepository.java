package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Cancha;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CanchaRepository extends JpaRepository<Cancha, Long> {

}