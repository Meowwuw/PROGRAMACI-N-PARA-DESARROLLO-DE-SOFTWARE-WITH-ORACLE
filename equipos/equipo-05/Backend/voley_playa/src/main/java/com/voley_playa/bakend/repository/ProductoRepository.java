package com.voley_playa.bakend.repository;

import com.voley_playa.bakend.model.Producto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductoRepository extends JpaRepository<Producto, Long> {
}