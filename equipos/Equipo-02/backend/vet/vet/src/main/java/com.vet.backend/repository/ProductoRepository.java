package com.vet.backend.repository;
import com.vet.backend.model.Producto;
import org.springframework.data.jpa.repository.JpaRepository;


public interface ProductoRepository
        extends JpaRepository <Producto, Long>{
}
