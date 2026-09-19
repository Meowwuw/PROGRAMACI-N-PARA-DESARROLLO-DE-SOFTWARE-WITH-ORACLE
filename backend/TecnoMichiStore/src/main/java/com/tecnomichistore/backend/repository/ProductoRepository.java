package com.tecnomichistore.backend.repository;
import com.tecnomichistore.backend.model.Producto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductoRepository
    extends JpaRepository <Producto, Long> {
}

