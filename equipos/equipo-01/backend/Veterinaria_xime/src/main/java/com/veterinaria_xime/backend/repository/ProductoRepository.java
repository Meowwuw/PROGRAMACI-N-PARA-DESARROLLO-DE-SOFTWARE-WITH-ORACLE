package com.veterinaria_xime.backend.repository;

import com.veterinaria_xime.backend.model.Producto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductoRepository
    extends JpaRepository <Producto, Long>{

}
