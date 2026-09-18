package com.canchavoley.backend.repository;

import com.canchavoley.backend.model.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {

    Optional<Cliente> findByDni(String dni);

    List<Cliente> findByApellidoContainingIgnoreCase(String apellido);

    void deleteByDni(String dni);
}
