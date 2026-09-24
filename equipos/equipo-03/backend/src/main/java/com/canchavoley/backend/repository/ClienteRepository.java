package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, Long> {

    // Buscar cliente por DNI
    Optional<Cliente> findByDni(String dni);

    // Verificar si existe cliente por DNI
    boolean existsByDni(String dni);

    // Eliminar cliente por DNI
    void deleteByDni(String dni);
}