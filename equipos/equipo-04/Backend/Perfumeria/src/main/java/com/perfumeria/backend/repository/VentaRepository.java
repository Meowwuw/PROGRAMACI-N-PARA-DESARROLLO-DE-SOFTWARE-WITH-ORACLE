package com.perfumeria.backend.repository;

import com.perfumeria.backend.model.Venta;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VentaRepository extends JpaRepository<Venta, Integer> {
}